import SwiftUI

struct Mail: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    let subject: String
    let body: String
}

enum MailLabel: String {
    case inbox = "Inbox"
    case sent = "Sent"
    case drafts = "Drafts"
    case archive = "Archive"
}

final class MailNavigationCoordinator: ObservableObject {
    @Published var selectedMail: Mail?
    @Published var selectedLabel: MailLabel? = .inbox
}

final class MailStore: ObservableObject {
    @Published var allMail: [MailLabel: [Mail]] = [
        .inbox: [ .init(date: Date(), subject: "A Great Subject", body: "This is the email body.")],
        .sent: [ .init(date: Date(), subject: "Another Great Subject", body: "This is another email body.")],
        .drafts: [],
        .archive: [],
    ]

    func createNewDraft() -> Mail {
        let newDraft = Mail(date: Date(), subject: "A New Draft", body: "This is a new draft email.")
        self.allMail[MailLabel.drafts]?.append(newDraft)
        return newDraft
    }

    func delete(_ mail: Mail) {
        var mailFoundInLabel: MailLabel?

        // Extremely unperformant search for mail across all labels
        for folderLabel in allMail.keys {
            if let folder = allMail[folderLabel] {
                if folder.contains(mail) {
                    mailFoundInLabel = folderLabel
                    continue
                }
            }
        }

        guard let label = mailFoundInLabel else { return }
        allMail[label]?.removeAll(where: { $0.id == mail.id })
    }

    func send(_ mail: Mail) {
        allMail[.drafts]?.removeAll(where: { $0.id == mail.id })
        allMail[.sent]?.append(mail)
    }

    func archive(_ mail: Mail) {
        allMail[.inbox]?.removeAll(where: { $0.id == mail.id })
        allMail[.archive]?.append(mail)
    }
}
