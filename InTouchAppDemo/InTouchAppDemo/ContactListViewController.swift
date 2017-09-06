//
//  ViewController.swift
//  InTouchAppDemo
//
//  Created by Rahul Umap on 06/09/17.
//  Copyright © 2017 Rahul Umap. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class ContactListViewController: UIViewController {

    @IBOutlet weak var contactListTableView: UITableView!
    @IBOutlet weak var contactSearchBar: UISearchBar!


    let realm = try! Realm()
    var contactsArray : [ListModel]? = nil
    var numberOfContact:Results<ListModel>?
    var filteredContact:[ListModel]?
    var searchActive : Bool = false

    // MARK: - View Controller's Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUp()
        setupDataSource()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.contactSearchBar.endEditing(true)
        self.contactListTableView.reloadData()
    }


    // MARK: - View Controller's Internal Methods

    /*
     * @Method : setUI()
     * @Remark : Method for rendering any UI component.
     *
     */

    func setUp(){
        self.contactListTableView.register(UINib(nibName: "ContactsListTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactsListTableViewCell")
        contactSearchBar.showsCancelButton = true
        self.contactSearchBar.placeholder = "Search by Name,Phone number"
        self.automaticallyAdjustsScrollViewInsets = false
        contactListTableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
    }

    /*
     * @Method : setupDataSource()
     * @Remark : Method for providing data source to the view
     *
     */

    func setupDataSource(){
        numberOfContact = realm.objects(ListModel.self)
        contactsArray = numberOfContact?.toArray(ofType: ListModel.self)
        self.contactListTableView.reloadData()
    }
}

// MARK: - View Controller's SearchBar Delegate
extension ContactListViewController: UISearchBarDelegate {

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.contactSearchBar.endEditing(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchBar.text = nil
        searchBar.endEditing(true)
        self.contactListTableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.contactSearchBar.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0 {
            filteredContact?.removeAll()

            // Developer Note : Add following filter conditions to add attributes like city,organization etc.
            // Remark : These filters are not added because UI don't contain the city and organizations,
            // To make Search more releavant search attributes are contact names and contact number

            //          ($0.contact_city).range(of: searchText, options:.caseInsensitive) != nil
            //         ($0.contact_organization).range(of: searchText, options:.caseInsensitive) != nil

            filteredContact = contactsArray?.filter { if ($0.contact_name).range(of: searchText, options:.caseInsensitive) != nil
                || ($0.contact_number).range(of: searchText, options:.caseInsensitive) != nil{
                return true
                }
                return false
            }
            searchActive = true
        }else {
            searchActive = false
        }
        self.contactListTableView.reloadData()
    }

}


// MARK: - View Controller DataSource and Delegate
extension ContactListViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height-400))
        if(searchActive) {
            if (filteredContact?.count)! > 0 {
                noDataLabel.text          = ""
                tableView.backgroundView  = noDataLabel
                tableView.separatorStyle  = .singleLine
                return filteredContact!.count
            } else {
                noDataLabel.text          = "No result found for \(contactSearchBar.text!)"
                noDataLabel.textColor     = UIColor.black
                noDataLabel.textAlignment = .center
                noDataLabel.numberOfLines = 0
                tableView.backgroundView  = noDataLabel
                tableView.separatorStyle  = .none
            }
        } else {
            noDataLabel.text          = ""
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .singleLine
            return contactsArray!.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsListTableViewCell", for: indexPath) as! ContactsListTableViewCell
        var data = ListModel()
        data = searchActive == true ? self.filteredContact![indexPath.row] : (self.contactsArray?[indexPath.row])!
        cell.setupCell(data: data,searchText:contactSearchBar.text!)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = searchActive == true ? self.filteredContact![indexPath.row] : (self.contactsArray?[indexPath.row])!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ContactDetailsViewController") as! ContactDetailsViewController
        vc.contactModelObject = object
        self.navigationController?.present(vc, animated: true, completion: nil)
    }

}
