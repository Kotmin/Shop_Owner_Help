# ShopOwnerApp
## 1. Wstęp
ShopOwnerApp to nowoczesne narzędzie dedykowane właścicielom kawiarni i podobnych miejsc usługowych, zaprojektowane z myślą o optymalizacji i ułatwieniu procesu zarządzania zamówieniami. 

<!-- ![Preview](https://github.com/Kotmin/Shop_Owner_Help/blob/main/ios_shop_ui.gif) -->


<p align="center">
  <img src="https://github.com/Kotmin/Shop_Owner_Help/blob/main/ios_shop_ui.gif" width="720" height="480">
</p>


Aplikacja, stworzona wyłącznie dla systemu iOS 17 lub nowszego, wykorzystuje CoreData do efektywnego przechowywania danych, a jej interfejs użytkownika oparty jest na SwiftUI, co gwarantuje płynność działania i intuicyjność obsługi.

---
#### Osoby realizujące:
 1.Paweł Jan Tłusty


#### Podział zadań:
100% zadań wykonane zostało przez Paweł Jan Tłusty

---


### Wymagania funkcjonalne

- Składanie zamówień przez klientów - Umożliwienie klientom przeglądania menu, składanie zamówień oraz śledzenie statusu zamówienia w czasie rzeczywistym.
- Zarządzanie menu - Możliwość dodawania, edytowania, lub usuwania pozycji z menu przez właściciela, w tym aktualizacji cen i opisów produktów.
- Zarządzanie zamówieniami - Przeglądanie bieżących zamówień, aktualizacja ich statusu i archiwizacja zakończonych zamówień przez pracowników.

### Wymagania niefunkcjonalne

- Wydajność - Aplikacja w edycji basic obsłuży co najmniej 250 zamówień na godzinę.
- Dostępność - System będzie dostępny przez co najmniej 160 godzin / tydzień. Dostępność zewnętrznych funkcji obsługi płatności nie jest wliczana.
- Skalowalność - System będzie projektowany z możliwością łatwego skalowania, aby obsłużyć wzrost liczby użytkowników i transakcji bez degradacji wydajności.
- Bezpieczeństwo - Wszystkie dane użytkownika i transakcje będą chronione za pomocą aktualnych standardów szyfrowania, z zastosowaniem bezpiecznych protokołów komunikacyjnych.
- Użyteczność - Interfejs użytkownika będzie intuicyjny, pozwalający na szybkie przyswojenie funkcjonalności aplikacji przez użytkowników różnych poziomów zaawansowania.
- Kompatybilność - Aplikacja będzie kompatybilna z systemem operacyjnym iOS w wersji 17
- Testowalność - System zostanie zaprojektowany w taki sposób, aby umożliwić łatwe wykonanie testów funkcjonalnych i niefunkcjonalnych, wspierając ciągłe doskonalenie produktu.

---
## 2. Podobne rozwiązania na rynku

Na rynku istnieją podobne rozwiązania, takie jak pyszne.pl czy Glovo, które umożliwiają zamawianie jedzenia online. ShopOwnerApp wyróżnia się jednak skupieniem na procesie zarządzania kawiarnią, oferując narzędzia nie tylko do przyjmowania zamówień, ale również do ich efektywnego przetwarzania i monitorowania w czasie rzeczywistym.

<div align="center">
  <img src="https://github.com/Kotmin/Shop_Owner_Help/assets/70173732/7250f679-026f-4be4-8e9a-3f5f961aa844" alt="obraz" style="margin: 10px;">
  <img src="https://github.com/Kotmin/Shop_Owner_Help/assets/70173732/05e4d1a2-b010-454c-ab60-72cd5108f639" alt="obraz" style="margin: 10px;">
  <img src="https://github.com/Kotmin/Shop_Owner_Help/assets/70173732/8fec2518-adcb-44d9-8c11-9a2bea8015c7" alt="obraz" style="margin: 10px;">
</div>



---
## 3. Dla kogo jest ta aplikacja?

ShopOwnerApp jest skierowana do właścicieli i zarządców kawiarni, którzy poszukują rozwiązania umożliwiającego szybkie przyjmowanie zamówień, ich efektywne przetwarzanie oraz szybką obsługę klientów. Aplikacja ta ma za zadanie usprawnić komunikację między klientami a lokalem, minimalizując czas oczekiwania na zamówienie.

---
## 4. Widoki aplikacji

ShopOwnerApp oferuje szereg funkcjonalności i widoków, ułatwiających zarządzanie kawiarnią:

- Składanie zamówień: Prosty i intuicyjny interfejs umożliwiający klientom składanie zamówień z menu.
- Przegląd menu: Możliwość przeglądania dostępnego menu oraz aktualizacji oferty w czasie rzeczywistym.
- Szybkie zamówienie: Funkcja umożliwiająca stałym klientom ponowne składanie zamówień w sposób szybki i wygodny.
- Nawigacja: Intuicyjna nawigacja po aplikacji, ułatwiająca dostęp do najważniejszych funkcji.
- Panel właściciela: Panel zarządzania umożliwiający monitorowanie i zarządzanie zamówieniami, a także dostęp do statystyk i analiz sprzedaży.

---
    
## 5. Projekt UI
### Pierwszy szkic interfejsu
<!--- 
![obraz](https://github.com/Kotmin/Shop_Owner_Help/assets/70173732/d66f6906-42fd-4ad9-ad12-e8365d622440)
-->
<p align="center">
  <img src="https://github.com/Kotmin/Shop_Owner_Help/assets/70173732/d66f6906-42fd-4ad9-ad12-e8365d622440">
</p>


---


### Przykłady realizacji
<!--- 
|![obraz](https://github.com/Kotmin/Shop_Owner_Help/assets/70173732/73ee91f1-de9d-40c5-b9a1-dd3d7cc599eb)
|![obraz](https://github.com/Kotmin/Shop_Owner_Help/assets/70173732/be6fe716-611c-4085-812c-7b23149aba72)
|![obraz](https://github.com/Kotmin/Shop_Owner_Help/assets/70173732/cb6ba1d4-54a2-41fb-89c3-b3631040cf2f)
|
|:----|:----:|----:|
| Menu Właściciela | Ekran główny | Aktualizacja kategorii produktu |




| Menu Właściciela | Ekran główny użytkownika | Aktualizacja kategorii produktu |
|:----------------:|:------------------------:|:-------------------------------:|
|![Menu Właściciela](https://github.com/Kotmin/Shop_Owner_Help/assets/70173732/73ee91f1-de9d-40c5-b9a1-dd3d7cc599eb)|![Ekran główny użytkownika](https://github.com/Kotmin/Shop_Owner_Help/assets/70173732/be6fe716-611c-4085-812c-7b23149aba72)|![Aktualizacja kategorii produktu](https://github.com/Kotmin/Shop_Owner_Help/assets/70173732/cb6ba1d4-54a2-41fb-89c3-b3631040cf2f)|
-->

|![Menu Właściciela](https://github.com/Kotmin/Shop_Owner_Help/assets/70173732/73ee91f1-de9d-40c5-b9a1-dd3d7cc599eb)|![Ekran główny użytkownika](https://github.com/Kotmin/Shop_Owner_Help/assets/70173732/ec0d01ca-f0ac-4453-aa35-dc5d5a22f120)|![obraz](https://github.com/Kotmin/Shop_Owner_Help/assets/70173732/74bbc870-1be4-44b1-a628-b0b8c2ee67f2)|
|:----------------:|:------------------------:|:-------------------------------:|
| Menu Właściciela | Ekran główny użytkownika | Wysuwane menu zarządzania kategoriami |





Projekt interfejsu użytkownika został opracowany z myślą o maksymalnej intuicyjności i estetyce. Wykorzystanie SwiftUI zapewnia płynne i szybkie działanie aplikacji, a także umożliwia łatwe dostosowanie layoutu do indywidualnych potrzeb użytkownika.
## 6. Projekt Bazy Danych




<p align="center">
  <img width="709" alt="db_schema_default" src="https://github.com/Kotmin/Shop_Owner_Help/assets/70173732/36feee13-88fe-49f6-bd8d-3a5849913815">
</p>

CoreData jest wykorzystywana do przechowywania wszystkich niezbędnych danych aplikacji, takich jak szczegóły zamówień, informacje o menu oraz dane klientów. Struktura bazy danych została zaprojektowana w taki sposób, aby zapewnić szybki dostęp do danych i ich bezpieczeństwo.


### Funkcja encji MetaData
Wierząc w dalszy rozwój i kształtowanie tej aplikacji postawiliśmy na uniwersalną encję umożliwiającą dodawanie specyficznych dla produktu/usługi danych. Takich jak m.in. opis, dodatkowe zdjęcia, czy tabela wartości odżywczych

## 7. Funkcjonalności

ShopOwnerApp oferuje szereg funkcji, które wyróżniają ją na tle konkurencji:

  - **Zarządzanie zamówieniami**: Szybkie przyjmowanie, przetwarzanie i aktualizowanie statusu zamówień.
  - **Realizacja płatności**: Możliwość płacenia aplikacją za pośrednictwem systemu PayPal
  - **Powiadomienia**: Automatyczne powiadomienia dla klientów o statusie ich zamówienia.
  - **Wsparcie dla wielu urządzeń**: Synchronizacja danych między urządzeniami pracowników.

### 7.1 Przykładowy diagram BPMN


<p align="center">
  <img width="709" alt="db_schema_default" src="https://github.com/Kotmin/Shop_Owner_Help/assets/70173732/370aa5d8-87dd-450e-9d1e-e0a540616352">
</p>
<p align="center" style="font-size:smaller; font-style:italic;">Proces biznesowy właściciela: Dodanie pozycji</p>


<p align="center">
  <img width="709" alt="db_schema_default" src="https://github.com/Kotmin/Shop_Owner_Help/assets/70173732/4a367178-cf24-471c-a695-e5abb6f03d2e">
</p>
<p align="center" style="font-size:smaller; font-style:italic;">Proces biznesowy: Dodanie zamówienia</p>


### 7.2 Przykładowy diagram UseCafe


<p align="center">
  <img width="709" alt="db_schema_default" src="https://github.com/Kotmin/Shop_Owner_Help/assets/70173732/2fc7dfb7-1a21-4899-81d5-e33b00bad932">
</p>


---

## 8. Testowanie

Aplikacja została poddana szczegółowym testom, zarówno pod kątem funkcjonalności, jak i wydajności, aby zapewnić bezproblemowe i stabilne działanie. Obecnie produkt jest w fazie prototypowania, co implikuje możliwość pojawienia się błędów. Gorąco zachęcamy do wspierania tego projektu poprzez zgłaszanie bugów w zakładce Issues.

---
## 9. Dalsze plany

W przyszłości planujemy rozbudowę aplikacji o dodatkowe funkcje, takie jak integracja z systemami płatności, możliwość zarządzania rezerwacjami oraz rozbudowane narzędzia do analizy zachowań klientów. Naszym celem jest ciągłe doskonalenie ShopOwnerApp, aby jeszcze bardziej ułatwić zarządzanie kawiarnią i poprawić doświadczenia klientów.

ShopOwnerApp to Twój partner w efektywnym zarządzaniu kawiarnią. Zapraszamy do korzystania i dzielenia się opiniami, które pomogą nam rozwijać aplikację w kierunkach najbardziej pożądanych przez naszych użytkowników.
