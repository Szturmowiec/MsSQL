create unique index IDDniaKonf_warsztat on Warsztaty
(
IDWarsztatu asc,
IDDniaKonferencji asc
)

create unique index IDDniaKonf_konferencje on Dzien_konferencji
(
IDDniaKonferencji asc
)

create unique index IDWczesnejRezKonf on Wczesna_rezerwacja_konferencji
(
IDWczesnejRezerwacjiKonferencji asc,
IDDniaKonferencji asc,
IDKlienta asc
)

create unique index IDWczesnaRezWar on Wczesna_rezerwacja_warsztatu
(
IDWczesnejRezerwacjiWarsztatu asc,
IDWczesnejRezerwacjiKonferencji asc,
IDWarsztatu asc,
IDKlienta asc
)

create unique index Progi on Progi_cenowe
(
IDProgu asc,
Termin_zaplaty asc
)

create unique index IDSczegKonf on Szczegoly_rezerwacji_konferencji
(
IDRezerwacjiKonferencji asc,
IDWczesnejRezerwacjiKonferencji asc,
IDDniaKonferencji asc
)

create unique index IDSczegWar on Szczegoly_rezerwacji_warsztatu
(
IDRezerwacjiWarsztatu asc,
IDRezerwacjiKonferencji asc,
IDWczesnejRezerwacjiWarsztatu asc,
IDWarsztatu asc
)