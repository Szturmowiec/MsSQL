--lista uczestnik�w poszczeg�lnych dni konferencji pocz�wszy od dnia bie��cego
create view Lista_uczestnikow_dni_konferencji as
select k.Nazwa as Nazwa_konferencji, dk.Data as Data_dnia_konferencji, u.IDUczestnika as ID, u.Imie, u.Nazwisko from Uczestnik as u
join Szczegoly_rezerwacji_konferencji as sk
on sk.IDUczestnika=u.IDUczestnika
join Dzien_konferencji as dk
on dk.IDDniaKonferencji=sk.IDDniaKonferencji
join Konferencje as k
on k.IDKonferencji=dk.IDKonferencji
where dk.Data>=GETDATE()
go

--lista uczestnik�w poszczeg�lnych warsztat�w pocz�wszy od dnia bie��cego
create view Lista_uczestnikow_warsztatow as
select distinct w.Nazwa as Nazwa_warsztatu, w.Data as Data_warsztatu, u.IDUczestnika as ID, u.Imie, u.Nazwisko from Uczestnik as u
join Szczegoly_rezerwacji_konferencji as sk
on sk.IDUczestnika=u.IDUczestnika
join Dzien_konferencji as dk
on dk.IDDniaKonferencji=sk.IDDniaKonferencji
join Warsztaty as w
on w.IDDniaKonferencji=dk.IDDniaKonferencji
where w.Data>=GETDATE()
go

--lista klient�w najcz�ciej korzystaj�cych z us�ug
create view Lista_najczestszych_klientow as
select top 10 k.IDKlienta as ID, f.Nazwa as Nazwa_firmy, o.Imie, o.Nazwisko from Klient as k
left join Firma as f
on f.IDKlienta=k.IDKlienta
left join Osoba_fizyczna as o
on o.IDKlienta=k.IDKlienta
join Wczesna_rezerwacja_konferencji as rk
on rk.IDKlienta=k.IDKlienta
group by rk.IDKlienta, k.IDKlienta, f.Nazwa, o.Nazwisko, o.Imie
order by count(*) desc
go

--ilo�� wolnych i zaj�tych miejsc poszczeg�lnych dni konferencji
create view Wolne_zajete_dni as
select dk.IDDniaKonferencji, sum(wrk.Ilosc_miejsc) as zajete, dk.Ilosc_miejsc-sum(wrk.Ilosc_miejsc) as wolne from Dzien_konferencji as dk
join Wczesna_rezerwacja_konferencji as wrk
on dk.IDDniaKonferencji=wrk.IDDniaKonferencji
group by wrk.IDDniaKonferencji, dk.IDDniaKonferencji, dk.Ilosc_miejsc
go

--ilo�� wolnych i zaj�tych miejsc poszczeg�lnych warsztat�w
create view Wolne_zajete_warsztaty as
select w.IDWarsztatu, sum(wrw.Ilosc_miejsc) as zajete, w.Ilosc_miejsc-sum(wrw.Ilosc_miejsc) as wolne from Warsztaty as w
join Wczesna_rezerwacja_warsztatu as wrw
on w.IDWarsztatu=wrw.IDWarsztatu
group by wrw.IDWarsztatu, w.IDWarsztatu, w.Ilosc_miejsc
go

--klienci, kt�rzy zap�acili za du�o lub tyle ile trzeba wraz z kwot� zwrotu
create view Klienci_zaduzo as
select z.IDKlienta, f.Nazwa as Nazwa_firmy, o.Imie, o.Nazwisko, z.Do_zwrotu as zwrot from Zaplata as z
join Wczesna_rezerwacja_konferencji as wrk
on wrk.IDKlienta=z.IDKlienta
join Klient as k
on wrk.IDKlienta=k.IDKlienta
left join Firma as f
on f.IDKlienta=k.IDKlienta
left join Osoba_fizyczna as o
on o.IDKlienta=k.IDKlienta
where Do_zwrotu>=0
go

--klienci, kt�rzy zap�acili za ma�o wraz z kwot� dop�aty
create view Klienci_zamalo as
select z.IDKlienta, f.Nazwa as Nazwa_firmy, o.Imie, o.Nazwisko, -(z.Do_zwrotu) as doplata from Zaplata as z
join Wczesna_rezerwacja_konferencji as wrk
on wrk.IDKlienta=z.IDKlienta
join Klient as k
on wrk.IDKlienta=k.IDKlienta
left join Firma as f
on f.IDKlienta=k.IDKlienta
left join Osoba_fizyczna as o
on o.IDKlienta=k.IDKlienta
where Do_zwrotu<0
go

--rezerwacje dni konferencji, dla kt�rych brakuje wszystkich uczestnik�w
create view Brak_uczestn_dni as
select wrk.IDWczesnejRezerwacjiKonferencji from Wczesna_rezerwacja_konferencji as wrk
join Szczegoly_rezerwacji_konferencji as srk
on srk.IDWczesnejRezerwacjiKonferencji=wrk.IDWczesnejRezerwacjiKonferencji
group by srk.IDWczesnejRezerwacjiKonferencji, wrk.IDWczesnejRezerwacjiKonferencji, wrk.Ilosc_miejsc
having COUNT(srk.IDRezerwacjiKonferencji)<wrk.Ilosc_miejsc
go

--rezerwacje warsztat�w, dla kt�rych brakuje wszystkich uczestnik�w
create view Brak_uczestn_war as
select wrw.IDWczesnejRezerwacjiWarsztatu from Wczesna_rezerwacja_warsztatu as wrw
join Szczegoly_rezerwacji_warsztatu as srw
on srw.IDWczesnejRezerwacjiWarsztatu=wrw.IDWczesnejRezerwacjiWarsztatu
group by srw.IDWczesnejRezerwacjiWarsztatu, wrw.IDWczesnejRezerwacjiWarsztatu, wrw.Ilosc_miejsc
having COUNT(srw.IDRezerwacjiWarsztatu)<wrw.Ilosc_miejsc