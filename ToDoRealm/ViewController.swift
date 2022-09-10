//
//  ViewController.swift
//  ToDoRealm
//
//  Created by ryo on 2022/09/05.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
    @IBOutlet weak var titleTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var titleText: Results<Post>!
    var contentText: Results<Post>!
    var dateText: Results<Post>!
    
    @IBOutlet var editButton: UIBarButtonItem!
    @IBOutlet var doneButton: UIBarButtonItem!
    
    
//    var titleText = [String]()
//    var contentText = [String]()
//    var dateText = [String]()
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let realm = try! Realm()
        
        //nil回避
        if let titleTable = titleTable {
            titleTable.dataSource = self
            titleTable.delegate = self
        }
        
        searchBar.delegate = self
        
        //タップ選択できるように
//        titleTable.allowsSelectionDuringEditing = true
        
//        titleTable.isEditing = true
        
        //realmのデータ取得．後で整理
        self.titleText = realm.objects(Post.self)
        self.contentText = realm.objects(Post.self)
        self.dateText = realm.objects(Post.self)
        
        //最初は完了ボタン非表示
        self.doneButton.isEnabled = false
        self.doneButton.tintColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        //nil回避
        if titleTable != nil {
            self.titleTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleText.count
//        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let post: Post = self.titleText[indexPath.row]
        
        // TableViewCellの中に配置したLabelを取得する
        //Labelを二つ置くと編集モードにしたときにレイアウトが崩れる
//        let label1 = cell.contentView.viewWithTag(1) as! UILabel
//        let label2 = cell.contentView.viewWithTag(2) as! UILabel
//        label1.text = post.title
//        label2.text = post.date
        
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.date

        

        
        
//        cell.textLabel?.text = "テスト"
        
        return cell
        
    }
    
    // スワイプしてセルを削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // Realmのデータ削除
        try! realm.write {
            realm.delete(self.titleText[indexPath.row])
        }
        
        self.titleTable.deleteRows(at: [indexPath], with: .automatic)
    }
    //indexpath.rowの取得がおかしくなった時の確認用
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

         // タップされたセルの行番号を出力
         print("\(indexPath.row)番目の行が選択されました。")
     }
    
    @IBAction func edit() {
        //編集モードをオンに
        isEditing = true
        self.editButton.isEnabled = false
        self.editButton.tintColor = UIColor.clear
        self.doneButton.isEnabled = true
        self.doneButton.tintColor = UIColor.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
    }
    
    @IBAction func done() {
        //編集モードをオフに
        titleTable.isEditing = false
        self.doneButton.isEnabled = false
        self.doneButton.tintColor = UIColor.clear
        self.editButton.isEnabled = true
        self.editButton.tintColor = UIColor.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
        
        
    }

    //並べ替えを許可
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
//以下のメソッドがあるとスワイプアクションが呼び出されない！
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .none
//    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //Results型だとremoveとinsertが使えないのでArray型に変換
//        let titleText = Array(titleText)
        //varにしないとダメだった
        var titleTextRow = Array(titleText)
        //元はsourceIndexPath
        let movedText = titleText[sourceIndexPath.row]
//        let itemToMove = titleText.remove(at: sourceIndexPath.row)
        titleTextRow.remove(at: sourceIndexPath.row)
//        titleText.insert(itemToMove, at: destinationIndexPath.row)
        //遷移先はdestinationIndexPath(引数見ればわかる)
        titleTextRow.insert(movedText, at: destinationIndexPath.row)
//        let movedText = titleText[sourceIndexPath.row]
//        titleText.removeAtIndex(sourceIndexPath)
//        titleText.insert(movedText, at: destinationIndexPath.row)
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    /*
    検索機能
    //文字列の取得
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        var titleTextRow = Array(titleText)
        print(titleText[1])
        print(titleTextRow[1])
        if let searchText = searchBar.text {
            print(searchText) //文字列が出力テスト
//            if searchText == "" {
//
//            }
//            else {
//                for data in titleTextRow {                    if data.containString(searchBar.text!) {
//
//                   }
//                }
//            }
        }
    }
     */
    

    

}

