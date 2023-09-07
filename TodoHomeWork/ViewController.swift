//
//  ViewController.swift
//  TodoHomeWork
//
//  Created by 長島啓太朗 on 2023/09/04.
//

import UIKit
import RealmSwift
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    let realm = try! Realm()
    var contents:[TodoContent] = []
    override func viewDidLoad() {
       
        super.viewDidLoad()
       
        tableView.dataSource = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoCell")
        contents = readContents()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        contents = readContents()
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "delete"){_,_,handler in
//            print("delete")
//
//            handler(true)
//        }
//        let editAction =  UIContextualAction(style: .normal, title: "edit"){_,_,handler in
//            print("edit")
//            handler(true)
//        }
//        let configuration = UISwipeActionsConfiguration(actions: [deleteAction,editAction])
//        configuration.performsFirstActionWithFullSwipe = true
//        return configuration
//    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            try! realm.write{
                realm.delete(contents[indexPath.row])
            }
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"TodoCell",for: indexPath) as! TodoTableViewCell
        let content: TodoContent = contents[indexPath.row]
        cell.setCell(title: content.title,body: content.body, date: content.date, isMarked: content.isMarked)
        return cell
    }
    func readContents()->[TodoContent]{
        print (contents.count)
        return Array(realm.objects(TodoContent.self))
    }
    func delete(){
        
    }
}

