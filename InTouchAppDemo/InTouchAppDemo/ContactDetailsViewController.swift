//
//  ContactDetailsViewController.swift
//  InTouchAppDemo
//
//  Created by Rahul Umap on 06/09/17.
//  Copyright © 2017 Rahul Umap. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactNameTextfield: UITextField!
    @IBOutlet weak var contactNumberTextfield: UITextField!
    @IBOutlet weak var companyNameTextfield: UITextField!
    @IBOutlet weak var addressTextfield: UITextField!

    var contactModelObject :  ListModel? = nil

    // MARK: - View Controller's Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        if let object = contactModelObject{
            contactNameTextfield.text = object.contact_name
            contactNumberTextfield.text = object.contact_number
            companyNameTextfield.text = object.contact_organization
            addressTextfield.text = object.contact_city
        }
    }


    // MARK: - View Controller's Internal Methods

    /*
     * @Method : setUI()
     * @Remark : Method for rendering any UI component.
     *
     */

    func setup(){
        contactImageView.layer.borderWidth = 1.0
        contactImageView.layer.masksToBounds = false
        contactImageView.layer.borderColor = UIColor.white.cgColor
        contactImageView.layer.cornerRadius = contactImageView.frame.size.height/2
        contactImageView.clipsToBounds = true
    }

    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
