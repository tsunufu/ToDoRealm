//
//  PostViewController.swift
//  ToDoRealm
//
//  Created by ryo on 2022/09/07.
//

import UIKit
import RealmSwift

class PostViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    
    
    var titleText: Results<Post>!
    var contentText: Results<Post>!
    var dateText: Results<Post>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        
        self.titleText = realm.objects(Post.self)
        self.contentText = realm.objects(Post.self)
        self.dateText = realm.objects(Post.self)

        // Do any additional setup after loading the view.
    }
    
//    func read() -> Post? {
//        return realm.objects(Post.self).first
//    }
    
    @IBAction func save() {
        //Postクラスのインスタンス作成
        let post = Post()
        post.title = self.titleTextField.text! //左のtitleはPostテーブルのtitleカラムと紐付けられている
        post.content = self.contentTextField.text! //同様
        post.date = self.dateTextField.text! //同様
        
        let realm = try! Realm()
        
        
            try! realm.write {
                realm.add(post)
            }
        
        //一旦ここで初期化．後でViewWillAppearに書き直し
        titleTextField.text = ""
        contentTextField.text = ""
        dateTextField.text = ""
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
