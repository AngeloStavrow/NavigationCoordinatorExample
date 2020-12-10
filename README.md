# NavigationCoordinatorExample

A proposal for coordinating the showing/hiding of views in a 3-column macOS SwiftUI app, this project extends the code in the [_Sidebar Navigation in SwiftUI_ article by Majid Jabrayilov](https://swiftwithmajid.com/2020/07/21/sidebar-navigation-in-swiftui/) with some CRUD operations on the mail store via toolbar buttons.

The buttons do two things: they call the relevant method on the `MailStore` class, to perform the necessary function on the selected mail item, and tthey manipulate the two `@Published` properties in the `MailNavigationCoordinator` class, to determine view state.

The two properties in question are  `selectedMail`, and `selectedLabel`, and each view observes these via an `@EnvironmentObject` to know, for example, which list to show, and which item in the list should be selected, based on the state of these properties. This feels more elegant and simple than passing state along through `@Binding`s, and —at least to my still-forming understanding of SwiftUI— works much more reliably.

The only place where this falls down is in creating a new draft. Ideally, this would:

1. Create a new draft `Mail` object in the `MailStore`, under the `.drafts` label; 
2. Select the "Drafts" list in the `LabelList` sidebar; and
3. Select the new draft in the `MailList` column for display in the `ContentView`.

This _almost_ works; the app sets itself to show the Drafts list per 1 and 2 above, and _does_ set the `selectedMail` object in the coordinator to the new draft, but instead, this selection gets overridden as things are being propagated through the views to either `nil` (if the new-draft button is triggered while viewing an empty `MailList`) or some existing `Mail` item (if the new-draft button is triggered while viewing a non-empty `MailList`). 

This seems to be happening due to the `selection` parameter of the SwiftUI `List` element in `MailList`; more investigations to come.
