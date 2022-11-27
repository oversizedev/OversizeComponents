//
// Copyright © 2022 Alexander Romanov
// MailView.swift
//

#if os(iOS)
    import MessageUI
    import SwiftUI

    public struct MailView: UIViewControllerRepresentable {
        private var to: String
        private var subject: String
        private var content: String

        public init(to: String, subject: String, content: String) {
            self.to = to
            self.subject = subject
            self.content = content
        }

        public typealias UIViewControllerType = MFMailComposeViewController

        public func updateUIViewController(_: MFMailComposeViewController, context _: Context) {}

        public func makeUIViewController(context: Context) -> MFMailComposeViewController {
            if MFMailComposeViewController.canSendMail() {
                let view: MFMailComposeViewController = .init()
                view.mailComposeDelegate = context.coordinator
                view.setToRecipients([to])
                view.setSubject(subject)
                view.setMessageBody(content, isHTML: false)
                return view
            } else {
                return MFMailComposeViewController()
            }
        }

        public func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }

        public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
            var parent: MailView

            public init(_ parent: MailView) {
                self.parent = parent
            }

            public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith _: MFMailComposeResult, error _: Error?) {
                controller.dismiss(animated: true)
            }
        }
    }
#endif
