--sprawdzanie czy liczba uczestników dnia konferencji nie przekracza tej podanej we wczesnej rezerwacji
create trigger Czy_liczba_uczestnikow_dnia_konferencji_odpowiednia on Szczegoly_rezerwacji_konferencji for insert as
begin
	declare @d_konf as int
	set @d_konf=(select IDDniaKonferencji from Szczegoly_rezerwacji_konferencji)
	declare @ileu as int
	set @ileu=(select count(*) from Szczegoly_rezerwacji_konferencji where IDDniaKonferencji=@d_konf)
	declare @ileu_teoria as int
	set @ileu_teoria=(select sum(Ilosc_miejsc) from Wczesna_rezerwacja_konferencji where IDDniaKonferencji=@d_konf)

	if (@ileu>@ileu_teoria)
	begin
		raiserror('Rzeczywista liczba uczestnikow dnia konferencji przekracza zadeklarowana we wczesnej rezerwacji',-1,-1);
		rollback transaction
	end
end
go

--sprawdzanie czy liczba uczestników warsztatu nie przekracza tej podanej we wczesnej rezerwacji
create trigger Czy_liczba_uczestnikow_warsztatu_odpowiednia on Szczegoly_rezerwacji_warsztatu for insert as
begin
	declare @d_war as int
	set @d_war=(select IDWarsztatu from Szczegoly_rezerwacji_warsztatu)
	declare @ileu as int
	set @ileu=(select count(*) from Szczegoly_rezerwacji_warsztatu where IDWarsztatu=@d_war)
	declare @ileu_teoria as int
	set @ileu_teoria=(select sum(Ilosc_miejsc) from Wczesna_rezerwacja_warsztatu where IDWarsztatu=@d_war)

	if (@ileu>@ileu_teoria)
	begin
		raiserror('Rzeczywista liczba uczestnikow warsztatu przekracza zadeklarowana we wczesnej rezerwacji',-1,-1);
		rollback transaction
	end
end
go

--nie pozwala rezerwowaæ warsztatu, je¿eli klient poda³ mniejsz¹ iloœæ uczestników na dzieñ ni¿ na warsztat w tym dinu
create trigger wiêcej_uczestnikow_warsztat_ni¿_dzien on Wczesna_rezerwacja_warsztatu for insert as
begin
	declare @id as int
	set @id=(select IDWczesnejRezerwacjiKonferencji from Wczesna_rezerwacja_konferencji)
	declare @u_d as int
	set @u_d=(select Ilosc_miejsc from Wczesna_rezerwacja_konferencji where IDWczesnejRezerwacjiKonferencji=@id)
	declare @u_w as int
	set @u_w=(select Ilosc_miejsc from Wczesna_rezerwacja_warsztatu where IDWczesnejRezerwacjiKonferencji=@id)

	if (@u_w>@u_d)
	begin
		raiserror('Liczba zarezerwowanych miejsc na warsztat przekracza liczbê zarezerwowanych miejsc na dzieñ konferencji, w którym on siê odbywa',-1,-1);
		rollback transaction
	end
end
go

--nie pozwala dodaæ uczestnika, gdy wszystkie miejsca s¹ zajête
create trigger miejsca_rezerwacji_zajête on Uczestnik for insert as
begin
	declare @id as int
	set @id=(select IDUczestnika from Uczestnik)
	declare @id_rez as int
	set @id_rez=(select IDRezerwacjiKonferencji from Szczegoly_rezerwacji_konferencji where IDUczestnika=@id)
	declare @miejsca as int
	set @miejsca=(select Ilosc_miejsc from Wczesna_rezerwacja_konferencji where IDWczesnejRezerwacjiKonferencji=@id_rez)
	declare @ile as int
	set @ile=(select COUNT(*) from Szczegoly_rezerwacji_konferencji where IDWczesnejRezerwacjiKonferencji=@id_rez)

	if (@ile>@miejsca)
	begin
		raiserror('Wszystkie zadeklarowane we wczesnej rezerwacji miejsca s¹ ju¿ zajête przez uczestników',-1,-1);
		rollback transaction
	end
end
go

--sprawdza, czy rezerwowany warsztat jest z w³aœciwego dnia
create trigger warsztat_odp_dzien on Wczesna_rezerwacja_warsztatu for insert as
begin
	declare @id as int
	set @id=(select IDWczesnejRezerwacjiKonferencji from Wczesna_rezerwacja_konferencji)
	declare @dk as int
	set @dk=(select IDDniaKonferencji from Wczesna_rezerwacja_konferencji where IDWczesnejRezerwacjiKonferencji=@id)
	declare @dw as int
	set @dw=(select IDWarsztatu from Warsztaty where IDDniaKonferencji=@dk)
	declare @dw_wybr as int
	set @dw_wybr=(select IDWarsztatu from Wczesna_rezerwacja_warsztatu where IDWczesnejRezerwacjiKonferencji=@id)

	if (@dw!=@dw_wybr)
	begin
		raiserror('Nie mo¿na zarezerwowaæ warsztatu odbywaj¹cego siê w innym dniu ni¿ zarezerwowany dzieñ konferencji',-1,-1);
		rollback transaction
	end
end
go

--sprawdza, czy dopuszczalna iloœæ miejsc na dany warsztat nie przekracza tej na dzieñ konferencji, w kótrym siê on odbywa
create trigger warsztat_miej_mniej_niz_dzien on Warsztaty for insert as
begin
	declare @dk as int
	set @dk=(select IDDniaKonferencji from Dzien_konferencji)
	declare @w as int
	set @w=(select IDWarsztatu from Warsztaty where IDDniaKonferencji=@dk)
	declare @mk as int
	set @mk=(select Ilosc_miejsc from Dzien_konferencji where IDDniaKonferencji=@dk)
	declare @mw as int
	set @mw=(select Ilosc_miejsc from Warsztaty where IDWarsztatu=@w)

	if (@mw>@mk)
	begin
		raiserror('Iloœæ miejsc na dany warsztat nie mo¿e przekraczaæ iloœci miejsc na dzieñ konferencji, w którym siê on odbywa',-1,-1);
		rollback transaction
	end
end