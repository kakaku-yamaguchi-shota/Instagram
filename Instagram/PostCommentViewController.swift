//
//  PostCommentViewController.swift
//  Instagram
//
//  Created by 山口 彰太 on 2019/11/28.
//  Copyright © 2019 shouta.yamaguchi4. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class PostCommentViewController: UIViewController {
    @IBOutlet weak var commentTextArea: UITextView! {
        didSet {
            commentTextArea.layer.borderColor = UIColor.black.cgColor
            commentTextArea.layer.borderWidth = 5.0
        }
    }

    @IBAction func handlePostComment(_ sender: Any) {
        // Commentを取得する
        if commentTextArea.text.isEmpty {
            SVProgressHUD.showError(withStatus: "コメントを入力してください")
            return
        }

        // Commentに必要な情報を取得しておく
        let name = Auth.auth().currentUser?.displayName
        let myId = Auth.auth().currentUser?.uid

        // 辞書を作成してFirebaseに保存する
        let postRef = Database.database().reference().child(Const.PostPath).child(postId)
        let commentData = [name! : commentTextArea.text!]
        postRef.observeSingleEvent(of: .value, with: { snapshot in
            let postData = PostData.init(snapshot: snapshot, myId: myId!)
            var comments = postData.comments
            comments.append(commentData)
            postRef.updateChildValues(["comments": comments])
            // HUDで投稿完了を表示する
            SVProgressHUD.showSuccess(withStatus: "コメントしました")
            // 全てのモーダルを閉じる
            UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        })

    }

    @IBAction func handleCommentCancel(_ sender: Any) {
        // 画面を閉じる
        dismiss(animated: true, completion: nil)
    }

    var postId: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
