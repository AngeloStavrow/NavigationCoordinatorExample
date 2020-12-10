import SwiftUI

struct MailList: View {
    @EnvironmentObject var store: MailStore
    @EnvironmentObject var coordinator: MailNavigationCoordinator

    var body: some View {
        if let selectedLabel = coordinator.selectedLabel {
            List(selection: $coordinator.selectedMail) {
                ForEach(store.allMail[selectedLabel, default: []], id: \.self) { mail in
                    NavigationLink(
                        mail.subject,
                        destination: ContentView(),
                        tag: mail,
                        selection: $coordinator.selectedMail
                    )
                }
            }
            .navigationTitle(selectedLabel.rawValue)
        } else {
            Text("👈 Select a folder")
        }
    }
}

struct MailList_Previews: PreviewProvider {
    static var previews: some View {
        MailList()
            .environmentObject(MailStore())
            .environmentObject(MailNavigationCoordinator())
    }
}
