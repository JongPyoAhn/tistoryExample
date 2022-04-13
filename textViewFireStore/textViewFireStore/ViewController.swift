//
//  ViewController.swift
//  textViewFireStore
//
//  Created by 안종표 on 2022/04/13.
//

import UIKit
import Firebase
import FirebaseFirestore
class ViewController: UIViewController {
    @IBOutlet weak var contentTextView: UITextView!
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        contentTextView.delegate = self
    }
    
    private func sendFirestore(_ content: String){
        let replaceContent = content.replacingOccurrences(of: "\n", with: "\\n")
        db.collection("posts").document().setData(
            ["content" : replaceContent]
        ){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    @IBAction func buttonTapped(_ sender: Any) {
        sendFirestore(contentTextView.text)
    }
}
extension ViewController: UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        if contentTextView.text.count % 25 == 0{
            contentTextView.text.append("\n")
            
        }
    }
    
}
