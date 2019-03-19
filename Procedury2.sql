--procedura usuwa uczestnika ze szczegó³ów rezerwacji konferencji (wiêc tak¿e i warsztatów dla danej rezerwacji),
--jeœli uczestnika nie ma na ¿adnej innej rezerwacji, to jest on ca³kowicie usuwany z bazy
create procedure Usun_szczeg_konf
@id int,
@konf int
as begin
	with q as (select * from Szczegoly_rezerwacji_Konferencji where IDUczestnika=@id and IDRezerwacjiKonferencji=@konf)
	delete from q;

	with x as (select * from Szczegoly_rezerwacji_warsztatu where IDUczestnika=@id and IDRezerwacjiKonferencji=@konf)
	delete from x

	declare @i as int
	set @i=(select count(*) from Szczegoly_rezerwacji_Konferencji where IDUczestnika=@id)
	if (@i=0)
	begin
		with p as (select * from Uczestnik where IDUczestnika=@id)
		delete from p
	end
end
go

--analogicznie jak powy¿ej, z tym ¿e teraz usuwamy uczestnika tylko z rezerwacji warsztatu
create procedure Usun_szczeg_war
@id int,
@war int
as begin
	with q as (select * from Szczegoly_rezerwacji_warsztatu where IDUczestnika=@id and IDRezerwacjiWarsztatu=@war)
	delete from q
end
go

--procedura usuwa rezerwacjê dnia konferencji (a wiêc i wszystkie rezerwacje warsztatów z ni¹ zwi¹zane)
create procedure Usun_rez_konf
@r int
as begin
	declare @sr as int
	set @sr=(select IDRezerwacjiKonferencji from Szczegoly_rezerwacji_konferencji where IDWczesnejRezerwacjiKonferencji=@r);
	with s as (select * from Szczegoly_rezerwacji_warsztatu where IDRezerwacjiKonferencji=@sr)
	delete from s;
	with r as (select * from Szczegoly_rezerwacji_konferencji where IDRezerwacjiKonferencji=@sr)
	delete from r;

	with q as (select * from Wczesna_rezerwacja_warsztatu where IDWczesnejRezerwacjiKonferencji=@r)
	delete from q;
	with p as (select * from Wczesna_rezerwacja_konferencji where IDWczesnejRezerwacjiKonferencji=@r)
	delete from p;

	with z as (select * from Zaplata where IDWczesnejRezerwacjiKonferencji=@r)
	delete from z
end
go

--tak samo jak wy¿ej, tylko teraz usuwamy sam¹ rezerwacê warsztatu
create procedure Usun_rez_war
@r int
as begin
	declare @sr as int
	set @sr=(select IDRezerwacjiWarsztatu from Szczegoly_rezerwacji_warsztatu where IDWczesnejRezerwacjiWarsztatu=@r);
	with s as (select * from Szczegoly_rezerwacji_warsztatu where IDRezerwacjiWarsztatu=@sr)
	delete from s;
	with q as (select * from Wczesna_rezerwacja_warsztatu where IDWczesnejRezerwacjiWarsztatu=@r)
	delete from q;
end
go

--usuwamy dzieñ konferencji (pod warunkiem, ¿e nie ma ¿adnych rezerwacji na niego), jak to jedyny dzieñ, to usuwamy te¿ konferencjê
create procedure Usun_dzien_konf
@dk int
as begin
	declare @ile as int
	set @ile=(select count(*) from Wczesna_rezerwacja_konferencji where IDDniaKonferencji=@dk)
	if (@ile=0)
	begin
		declare @k as int
		set @k=(select IDKonferencji from Dzien_konferencji where IDDniaKonferencji=@dk);
		with q as (select * from Dzien_konferencji where IDDniaKonferencji=@dk)
		delete from q;
		with r as (select * from Warsztaty where IDDniaKonferencji=@dk)
		delete from r;

		declare @i int
		set @i=(select count(*) from Dzien_konferencji where IDKonferencji=@k)
		if (@i=0)
		begin
			with p as (select * from Konferencje where IDKonferencji=@k)
			delete from p
		end
	end
end
go

--usuwamy konferencjê (pod warunkiem, ¿e nie ma ¿adnych rezerwacji na ni¹)
create procedure Usun_konf
@k int
as begin
	declare @i as int
	set @i=(select top 1 IDDniaKonferencji from Dzien_konferencji where IDKonferencji=@k)
	declare @ile as int
	set @ile=0
	declare @iter as int
	set @iter=@i+(select count(*) from Dzien_konferencji where IDKonferencji=@k)
	while @i<@iter
	begin
		set @ile=@ile+(select count(*) from Wczesna_rezerwacja_konferencji where IDDniaKonferencji=@i)
		set @i=@i+1
	end

	if (@ile=0)
	begin
		set @i=(select top 1 IDDniaKonferencji from Dzien_konferencji where IDKonferencji=@k)
		set @iter=@i+(select count(*) from Dzien_konferencji where IDKonferencji=@k)
		while @i<@iter
		begin
			with r as (select * from Warsztaty where IDDniaKonferencji=@i)
			delete from r;
			with q as (select * from Dzien_konferencji where IDDniaKonferencji=@i)
			delete from q
			set @i=@i+1
		end;
		with p as (select * from Konferencje where IDKonferencji=@k)
		delete from p
	end
end
go

--usuwamy warsztat (pod warunkiem, ¿e nie ma rezerwacji na niego)
create procedure Usun_war
@w int
as begin
	declare @ile as int
	set @ile=(select count(*) from Wczesna_rezerwacja_warsztatu where IDWarsztatu=@w)
	if (@ile=0)
	begin
		with q as (select * from Warsztaty where IDWarsztatu=@w)
		delete from q
	end
end