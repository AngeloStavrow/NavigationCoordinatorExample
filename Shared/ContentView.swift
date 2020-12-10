import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: MailStore
    @EnvironmentObject var coordinator: MailNavigationCoordinator

    var body: some View {
        if let selectedMail = coordinator.selectedMail {
            VStack(alignment: .leading) {
                Text(selectedMail.subject)
                    .font(.title)
                Text(selectedMail.date, style: .date)
                    .font(.callout)
                    .foregroundColor(.secondary)
                Divider()
                Text(selectedMail.body)
                Spacer()
            }
            .padding()
            .background(Color(NSColor.controlBackgroundColor))
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            .padding()
            .toolbar {
                ToolbarItemGroup {
                    if coordinator.selectedLabel == .inbox {
                        Button(action: {
                            self.coordinator.selectedMail = nil
                            self.store.archive(selectedMail)
                        }, label: {
                            Image(systemName: "archivebox")
                        })
                    }
                    if coordinator.selectedLabel == .drafts {
                        Button(action: {
                            self.coordinator.selectedMail = nil
                            self.store.send(selectedMail)
                        }, label: {
                            Image(systemName: "paperplane")
                        })
                    }
                    Button(action: {
                        self.coordinator.selectedMail = nil
                        self.store.delete(selectedMail)
                    }, label: {
                        Image(systemName: "trash")
                    })
                }
            }
        } else {
            Text("👈 Select a message")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MailStore())
            .environmentObject(MailNavigationCoordinator())
    }
}
