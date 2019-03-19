declare @x as money
execute @x=dbo.Cena_rezerwacji_warsztatu @rw=32
select @x

declare @y as money
execute @y=dbo.Cena_rezerwacji_warsztatu @rw=37
select @y

declare @z as money
execute @z=dbo.Cena_rezerwacji_konf @rk=3
select @z

declare @x1 as money
execute @x1=dbo.Cena_rezerwacji_dnia_i_warszt @rk2=3
select @x1

select * from Wczesna_rezerwacja_konferencji
where IDWczesnejRezerwacjiKonferencji=3

select * from Wczesna_rezerwacja_warsztatu
where IDWczesnejRezerwacjiKonferencji=3

select * from Warsztaty where IDWarsztatu=2

select * from Dzien_konferencji where IDDniaKonferencji=1
select * from Progi_cenowe where IDKonferencji=0

select * from dbo.Ceny_poszcz_rezw()