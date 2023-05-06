# Deskify

![](./table-flip-mess.gif)

## Pretotyp

- mit Figma erstellt und [hier](https://www.figma.com/file/FN3ZSl7ccE4fye27Pu3vv3/Deskify---Pretotyp?type=design&node-id=0-1&t=vEo29yGKSYGOo5gN-0) zu finden

## Kanboard

- mit Hilfe von Notion erstellt und [hier](https://www.notion.so/uni-lucas/Desk-Automation-10b1583714f4440482bbe67a8e326174?pvs=4) zu finden
- stetig aufgefüllt und angepasst

## Storyboard

- mit Hilfe von Notion erstellt und [hier](https://uni-lucas.notion.site/Funktionsanforderungen-an-die-Software-64a872d1aa994bad9923f69d2f497f4b) zu finden
- insgesamt 3 Varianten -> Entwicklung zu sehen

## Lessons Learned

### Verwendung von Providern

- Ziel = Gewährleistung Verfügbarkeit von Daten
- Provider-Klasse

  ```dart
  class DeskProvider with ChangeNotifier {
    ...
    final List<Desk> _desks = [
        Desk(...),
        Desk(...),
        ...
    ];
    int _currentlySelectedIndex = 0;

    Desk get currentDesk => _desks[_currentlySelectedIndex];
    ...

    void addDesk(Desk desk) {
        _desks.add(desk);
        notifyListeners();
    }
  }
  ```

- Initialisierung der Provider-Klasse

  ```dart
  void main() { ... }
  ...

  @override
  Widget build(BuildContext context) {
      return MultiProvider(
          providers: [
              ChangeNotifierProvider(create: (_) => DeskProvider()),
              ChangeNotifierProvider(create: (_) => ...()),
              ChangeNotifierProvider(create: (_) => ...()),
          ],
          ...
      );
  }
  ```

- Verwendung des Providers

  ```dart
  Widget build(BuildContext context) {
      final deskProvider = Provider.of<DeskProvider>(context);
      ...

      Text(deskProvider.currentDesk.name);
      ...
  }
  ```

### Carousel Slider

- Wechsel zwischen verschiedenen Tischen
- Verwendung von [Carousel Slider](https://pub.dev/packages/carousel_slider)
- Verwendung von Beispiel, um IndicatorBar einzubauen:
  ```dart
  Widget _buildIndicatorBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: deskProvider.desks.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => buttonCarouselController.animateToPage(entry.key),
          child: Container(
            width: 10.0,
            height: 10.0,
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).colorScheme.secondary).withOpacity(deskProvider.currentlySelectedIndex == entry.key ? 0.9 : 0.3),
            ),
          ),
        );
      },).toList(),
    );
  }
  ```

### ReoderableGridView

- tolle Möglichkeit, um Widgets zu sortieren -> Idee ist während der Entwicklung entstanden
- Umstieg von GridView für die Darstellung der Widgets auf ReorderableGridView war sehr leicht, dank externen Packages [reorderables](https://pub.dev/packages/reorderables)
- Problem: Daten für die draggable Widgets wurden in der Homepage immer wieder überschrieben
  -> Lösung: nur einmal initialisieren und dann nur noch überschreiben, wenn auch überschrieben werden sollen
- nächstes Problem: in `initState()` funktioniert es nicht, weil für Initialisierung der Provider noch kein `context` verfügbar ist
  -> Verwendung von Bypass über `didChangeDependencies()` (wird direkt nach `initState()` aufgerufen, wodurch Kontext vorhanden ist und die Provider initialisiert werden können)

  ```dart
  @override
  void didChangeDependencies() {
  if (!_isInitialized) {
      _initProvider();
      _isInitialized = true;
  }

  super.didChangeDependencies();
  }

  void _initProvider() {
  deskProvider = Provider.of<DeskProvider>(context);
  profileProvider = Provider.of<ProfileProvider>(context);
  themeProvider = Provider.of<ThemeProvider>(context);
  }

  List<InteractionWidget> presetInteractionWidget = [
    for (Preset preset in deskProvider.currentDesk.presets!)
      InteractionWidget(
        title: preset.title,
        icon: preset.icon,
        onPressedWholeWidget: () => deskProvider.currentDesk.height = preset.targetHeight,
        onPressedSettingsIcon: () => Utils.navigateToWidgetPage(
          context: context,
          title: preset.title,
          child: PresetWidgetPage(
            preset: preset,
            onAboutToPop: () => presetInteractionWidgets = updatedPresetInteractionWidgets,
          ),
        ),
      ),
  ];
  ```
