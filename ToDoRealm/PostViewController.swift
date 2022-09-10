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
    @IBOutlet var contentTextField: UITextView!
    @IBOutlet var dateTextField: UITextField!
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    
    var titleText: Results<Post>!
    var contentText: Results<Post>!
    var dateText: Results<Post>!
    
    //    var titleText = [String]()
    //    var contentText = [String]()
    //    var dateText = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        
        self.titleText = realm.objects(Post.self)
        self.contentText = realm.objects(Post.self)
        self.dateText = realm.objects(Post.self)
        
        // ピッカー設定
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date //これがないと時間も表示されてしまう！！
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        // インプットビュー設定
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = toolbar
        
        //TextViewの形状設定
        //色をTextFieldに合わせる
        contentTextField.layer.borderColor = CGColor.init(red: 204.0/255.0, green:204.0/255.0, blue:204.0/255.0, alpha:1.0)
        //枠の太さ
        contentTextField.layer.borderWidth = 1.0
        //枠の角丸
        contentTextField.layer.cornerRadius = 5.0
        contentTextField.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    
    
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
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    // 決定ボタン押下
    @objc func done() {
        dateTextField.endEditing(true)
        
        // 日付のフォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
       // dateTextField.text = "\(formatter.string(from: Date()))"
        //Date()だと今日の日付，datePicker.dateで選択した日付を持ってくる
        dateTextField.text = "\(formatter.string(from: datePicker.date))"
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
