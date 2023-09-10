//
//  CategoryViewController.swift
//  TodoHomeWork
//
//  Created by 長島啓太朗 on 2023/09/10.
//

import UIKit
import RealmSwift
class CategoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    
    let realm = try! Realm()
    var categories:Results<Category>!
    var selectedCategory:Category? = nil
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        categories = readCategories()
    }
    override func viewWillAppear(_ animated: Bool) {
        categories = readCategories()
        tableView.reloadData()
    }
    func readCategories() -> Results<Category>{
        return realm.objects(Category.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")!
        cell.textLabel?.text = categories[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.row]
        print(indexPath.row)
        self.performSegue(withIdentifier: "toTodoView", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTodoView"{
            let todoViewController = segue.destination as! TodoViewController
            todoViewController.selectedCategory = self.selectedCategory!
        }
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
