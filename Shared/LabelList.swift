import SwiftUI

struct LabelList: View {
    @EnvironmentObject var store: MailStore
    @EnvironmentObject var coordinator: MailNavigationCoordinator

    var body: some View {
        List(selection: $coordinator.selectedLabel) {
            ForEach(Array(store.allMail.keys), id: \.self) { label in
                NavigationLink(
                    label.rawValue,
                    destination: MailList(),
                    tag: label,
                    selection: $coordinator.selectedLabel
                )
            }
        }
        .listStyle(SidebarListStyle())
    }
}

struct LabelList_Previews: PreviewProvider {
    static var previews: some View {
        LabelList()
            .environmentObject(MailStore())
    }
}
