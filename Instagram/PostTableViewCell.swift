//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 山口 彰太 on 2019/11/26.
//  Copyright © 2019 shouta.yamaguchi4. All rights reserved.
//

import UIKit
import Firebase

class PostTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentTableView: UITableView!

    var comments: [Dictionary<String, String>] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        commentTableView.delegate = self
        commentTableView.dataSource = self
        // テーブルセルのタップを無効にする
        commentTableView.allowsSelection = false

        let nib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        commentTableView.register(nib, forCellReuseIdentifier: "CommetCell")

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // セルを取得してデータを設定
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommetCell", for: indexPath) as! CommentTableViewCell
        let commentData = comments[indexPath.row].first
        cell.commentLabel.text = commentData?.value
        cell.nameLabel.text = commentData?.key

        return cell
    }

    func setPostData(_ postData: PostData) {
        self.postImageView.image = postData.image

        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: postData.date!)
        self.dateLabel.text = dateString

        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }

        self.comments = postData.comments
        commentTableView.reloadData()
    }

}
