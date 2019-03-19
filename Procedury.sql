create procedure Dodaj_konferencje
@nazwa varchar(30),
@pocz date,
@kon date
as begin
set nocount on;
insert into Konferencje
(Nazwa, Data_rozpoczecia, Data_zakonczenia) values (@nazwa, @pocz, @kon)
end
go

create procedure Dodaj_dzien_konferencji
@nazwa varchar(30),
@data date,
@ile int
as begin
set nocount on;
declare @id as int
set @id=(select IDKonferencji from Konferencje where @nazwa=Nazwa)
insert into Dzien_konferencji
(IDKonferencji, Data, Ilosc_miejsc) values (@id, @data, @ile)
end
go

create procedure Dodaj_prog_cenowy
@nazwa varchar(30),
@cena money,
@termin date
as begin
set nocount on;
declare @id as int
set @id=(select IDKonferencji from Konferencje where @nazwa=Nazwa)
insert into Progi_cenowe
(IDKonferencji, Cena, Termin_zaplaty) values (@id, @cena, @termin)
end
go

create procedure Dodaj_warsztat
@dzien date,
@nazwa varchar(20),
@cena money,
@ile int
as begin
set nocount on;
declare @id as int
set @id=(select IDDniaKonferencji from Dzien_konferencji where @dzien=Data)
insert into Warsztaty
(IDDniaKonferencji, Nazwa, Cena, Data, Ilosc_miejsc) values (@id, @nazwa, @cena, @dzien, @ile)
end
go

create procedure Dodaj_klienta
@miasto varchar(20),
@ulica varchar(20),
@kod_pocztowy varchar(6),
@kraj varchar(30),
@email varchar(30)=null,
@tel varchar(15)=null,
@login varchar(10),
@haslo varchar(20)
as begin
set nocount on;
insert into Klient
(Miasto, Ulica, Kod_pocztowy, Kraj, Email, Telefon, Login, Haslo) values (@miasto, @ulica, @kod_pocztowy, @kraj, @email, @tel, @login, @haslo)
end
go

create procedure Dodaj_osobe
@login varchar(10),
@imie varchar(20),
@naziwkso varchar(30),
@pesel int
as begin
set nocount on;
declare @id as int
set @id=(select IDKlienta from Klient where @login=Login)
insert into Osoba_fizyczna
(IDKlienta, Imie, Nazwisko, PESEL) values (@id, @imie, @naziwkso, @pesel)
end
go

create procedure Dodaj_firme
@login varchar(10),
@nazwa varchar(40)
as begin
set nocount on;
declare @id as int
set @id=(select IDKlienta from Klient where @login=Login)
insert into Firma
(IDKlienta, Nazwa) values (@id, @nazwa)
end
go

create procedure Rezerwuj_miejsca_dzien_konf
@data date,
@ile int,
@iles int,
@data_rez date,
@login varchar(10)
as begin
set nocount on;
declare @id_k as int
set @id_k=(select IDKlienta from Klient where @login=Login)
declare @id_dnia as int
set @id_dnia=(select IDDniaKonferencji from Dzien_konferencji where @data=Data)
insert into Wczesna_rezerwacja_konferencji
(IDDniaKonferencji, Ilosc_miejsc, Ilosc_studentow, Data_rezerwacji, IDKlienta) values (@id_dnia, @ile, @iles, @data_rez, @id_k)
end
go

create procedure Rezerwuj_miejsca_warsztat
@nazwa varchar(20),
@data_rez_kon date,
@login varchar(10),
@ile int,
@data_rez date
as begin
set nocount on;
declare @id_k as int
set @id_k=(select IDKlienta from Klient where @login=Login)
declare @id_rez_kon as int
set @id_rez_kon=(select wrk.IDWczesnejRezerwacjiKonferencji from Wczesna_rezerwacja_konferencji as wrk
join Dzien_konferencji as dk
on dk.IDDniaKonferencji=wrk.IDDniaKonferencji
where @data_rez_kon=Data_rezerwacji and @data_rez=dk.Data)
declare @id_w as int
set @id_w=(select IDWarsztatu from Warsztaty where @nazwa=Nazwa)
insert into Wczesna_rezerwacja_warsztatu
(IDWczesnejRezerwacjiKonferencji, Ilosc_miejsc, Data_rezerwacji, IDKlienta, IDWarsztatu) values (@id_rez_kon, @ile, @data_rez, @id_k, @id_w)
end
go

create procedure Dodaj_uczestnika
@imie varchar(20),
@nazwisko varchar(30),
@miasto varchar(20),
@ulica varchar(20),
@kod_pocztowy varchar(6),
@kraj varchar(30),
@email varchar(30)=null,
@tel varchar(15)=null,
@znizka decimal(3,2),
@nr int=null,
@login varchar(10),
@haslo varchar(20)
as begin
set nocount on;
insert into Uczestnik
(Imie, Nazwisko, Miasto, Ulica, Kod_pocztowy, Kraj, Email, Telefon, Znizka, Nr_legitymacji, Login, Haslo)
values (@imie, @nazwisko, @miasto, @ulica, @kod_pocztowy, @kraj, @email, @tel, @znizka, @nr, @login, @haslo)
end
go

create procedure Szczegoly_rez_konf_dodaj_uczestnika
@data date,
@idu int,
@idkonf int
as begin
set nocount on;
declare @dk as int
set @dk=(select IDDniaKonferencji from Wczesna_rezerwacja_konferencji where IDWczesnejRezerwacjiKonferencji=@idkonf)
insert into Szczegoly_rezerwacji_konferencji
(IDWczesnejRezerwacjiKonferencji, IDDniaKonferencji, Data_rezerwacji, IDUczestnika)
values (@idkonf, @dk, @data, @idu)
end
go

create procedure Sczegoly_rez_war_dodaj_uczestnika
@idw int,
@idkonf int,
@data date,
@idu int
as begin
set nocount on;
declare @w as int
set @w=(select IDWarsztatu from Wczesna_rezerwacja_warsztatu where IDWczesnejRezerwacjiWarsztatu=@idw)
insert into Szczegoly_rezerwacji_warsztatu
(IDRezerwacjiKonferencji, IDWczesnejRezerwacjiWarsztatu, IDWarsztatu, Data_rezerwacji, IDUczestnika)
values (@idkonf, @idw, @w, @data, @idu)
end
go

--funkcja zwracaj¹ca cenê danej rezerwacji dnia konferencji, bez wliczania warsztatów
create function Cena_rezerwacji_konf
(@rk int) returns money
as begin
	declare @d as date
	set @d=(select Data_rezerwacji from Wczesna_rezerwacja_konferencji where IDWczesnejRezerwacjiKonferencji=@rk)
	declare @dk as int
	set @dk=(select IDDniaKonferencji from Wczesna_rezerwacja_konferencji where IDWczesnejRezerwacjiKonferencji=@rk)
	declare @konf as int
	set @konf=(select IDKonferencji from Dzien_konferencji where IDDniaKonferencji=@dk)
	declare @cena as money
	set @cena=(select top 1 Cena from Progi_cenowe where IDKonferencji=@konf and Termin_zaplaty>=@d order by Termin_zaplaty)
	declare @total as money
	set @total=(select @cena*Ilosc_miejsc-@cena*Ilosc_studentow*0.3 from Wczesna_rezerwacja_konferencji where IDWczesnejRezerwacjiKonferencji=@rk)
	return @total
end
go

--funkcja zwracaj¹ca cenê danej rezerwacji warsztatu
create function Cena_rezerwacji_warsztatu
(@rw int) returns money
as begin
	declare @w as int
	set @w=(select IDWarsztatu from Wczesna_rezerwacja_warsztatu where IDWczesnejRezerwacjiWarsztatu=@rw)
	declare @cena as money
	set @cena=(select Cena from Warsztaty where IDWarsztatu=@w)
	declare @total as money
	set @total=(select @cena*Ilosc_miejsc from Wczesna_rezerwacja_warsztatu where IDWczesnejRezerwacjiWarsztatu=@rw)
	return @total
end
go

--funkcja zwracaj¹ca cenê danej rezerwacji dnia konferencji, w³¹cznie z zarezerwowanymi w tym dniu dla tej konferencji warsztatami
create function Cena_rezerwacji_dnia_i_warszt
(@rk2 int) returns money
as begin
	declare @rezw table
	(
		RezerwacjeWar int
	)
	insert into @rezw (RezerwacjeWar)
	select IDWczesnejRezerwacjiWarsztatu from Wczesna_rezerwacja_warsztatu where IDWczesnejRezerwacjiKonferencji=@rk2

	declare @total as money
	execute @total=dbo.Cena_rezerwacji_konf @rk=@rk2

	declare @ile as int
	set @ile=(select COUNT(*) from @rezw)
	while @ile>0
	begin
		declare @r as int
		set @r=(select top 1 * from @rezw)
		declare @x as money
		execute @x=dbo.Cena_rezerwacji_warsztatu @rw=@r
		set @total=@total+@x
		set @ile=@ile-1;
		
		with q as (select top 1 * from @rezw)
		delete from q
	end
	return @total
end
go

create procedure Dodaj_zaplate
@r int,
@k int,
@data date,
@ile money
as begin
set nocount on;
insert into Zaplata
(IDWczesnejRezerwacjiKonferencji, IDKlienta, Data_zaplaty, Wplacona_kwota)
values (@r, @k, @data, @ile)
end
go

--procedura obliczaj¹ca zwrot (lub dop³atê) za dan¹ rezerwacjê i wstawiaj¹ca go do tabeli
create procedure Zwrot_lub_doplata
@r int
as begin
set nocount on;
declare @cena as money
execute @cena=dbo.Cena_rezerwacji_dnia_i_warszt @rk2=@r
declare @zaplata as money
set @zaplata=(select Wplacona_kwota from Zaplata where IDWczesnejRezerwacjiKonferencji=@r)
declare @zwrot as money
set @zwrot=@zaplata-@cena
insert into Zaplata (Do_zwrotu) values (@zwrot)
end
go

--funkcja wyœwietlaj¹ca poszczególne rezerwacje wraz z klientami, którzy ich dokonali i cen¹
create function Ceny_poszcz_rezw
() returns @t table
(
	IDWczesnejRezerwacjiKonferencji int not null,
	IDKlienta int not null,
	Cena money not null
)
as begin
	declare @r as int
	set @r=(select IDWczesnejRezerwacjiKonferencji from Wczesna_rezerwacja_konferencji)
	declare @cena as money
	execute @cena=dbo.Cena_rezerwacji_dnia_i_warszt @rk2=@r

	declare @k as int
	set @k=(select IDKlienta from Wczesna_rezerwacja_konferencji where IDWczesnejRezerwacjiKonferencji=@r)
	insert into @t
	values (@r, @k, @cena)
	return
end