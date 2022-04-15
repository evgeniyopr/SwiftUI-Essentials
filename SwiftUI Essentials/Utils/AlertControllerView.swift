//
//  AlertControllerView.swift
//  SwiftUI Essentials
//
//  Created by Evgeniy Opryshko on 14.04.2022.
//

import SwiftUI

struct AlertControllerView: UIViewControllerRepresentable {
    
    @Binding var textfieldText: String
    @Binding var showingAlert: Bool
    
    var alertTitle: String
    var alertMessage: String
    
    func makeUIViewController(context: Context) -> UIViewController {
        return UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        guard context.coordinator.alert == nil else { return }
        
        if self.showingAlert {
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            context.coordinator.alert = alert
            
            alert.addTextField { textField in
                textField.placeholder = "Enter some text"
                textField.text = self.textfieldText
                textField.delegate = context.coordinator
            }
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { _ in
                self.textfieldText = ""
            })
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { _ in
                if let textField = alert.textFields?.first, let text = textField.text {
                    self.textfieldText = text
                }
            })
            
            DispatchQueue.main.async {
                uiViewController.present(alert, animated: true, completion: {
                    self.showingAlert = false
                })
            }
        }
    }
    
    func makeCoordinator() -> AlertControllerView.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        var alert: UIAlertController?
        var control: AlertControllerView
        
        init(_ control: AlertControllerView) {
            self.control = control
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            control.textfieldText = textField.text ?? ""
        }
    }
}
