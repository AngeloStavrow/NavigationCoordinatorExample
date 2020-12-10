import SwiftUI

@main
struct NavigationCoordinatorExampleApp: App {
    @StateObject var store = MailStore()
    @StateObject var coordinator = MailNavigationCoordinator()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                LabelList()
                    .toolbar {
                        ToolbarItem {
                            Button(action: {
                                // 👇 This navigates to the Drafts list.
                                self.coordinator.selectedLabel = .drafts
                                // 👇 This doesn't set the selectedMail selection in MailList to the new draft as I'd
                                // expect; instead, the selection is overridden by whatever mail object might already
                                // exist in the mail list that's active when this new-draft button is clicked; if the
                                // mail list is empty, then the selectedMail selection is overriden to nil.
                                self.coordinator.selectedMail = self.store.createNewDraft()
                            }, label: {
                                Image(systemName: "square.and.pencil")
                            })
                        }
                    }
                MailList()
                ContentView()
            }
            .environmentObject(store)
            .environmentObject(coordinator)
        }
    }
}
