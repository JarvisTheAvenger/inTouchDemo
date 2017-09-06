//
//  ContactsListTableViewCell.swift
//  InTouchAppDemo
//
//  Created by Rahul Umap on 06/09/17.
//  Copyright © 2017 Rahul Umap. All rights reserved.
//

import UIKit

class ContactsListTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileNumberlabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    /*
     * @Method : setupCell()
     * @param  : (MOCK_DATA, String)
     * @Remark : Configure the cell for the ConactList TableView
     *
     */

    func setupCell(data: ListModel, searchText: String){
        if searchText.characters.count > 0 {
            let searchTerm = searchText /* SEARCH_TERM */
            let contactNameAttributedString:NSMutableAttributedString = NSMutableAttributedString(string: data.contact_name)
            let contactNumberAttributedString:NSMutableAttributedString = NSMutableAttributedString(string: data.contact_number)
            let pattern = "(\(searchTerm))"
            let rangeForName:NSRange = NSMakeRange(0, data.contact_name.characters.count)
            let rangeForNumber:NSRange = NSMakeRange(0, data.contact_number.characters.count)

            let regex = try? NSRegularExpression( pattern: pattern, options: [.caseInsensitive])
            regex?.enumerateMatches(
                in: data.contact_name,
                options: NSRegularExpression.MatchingOptions(),
                range: rangeForName,
                using: {
                    (textCheckingResult, matchingFlags, stop) -> Void in
                    let subRange = textCheckingResult?.range
                    contactNameAttributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: subRange!)
                    nameLabel.attributedText = contactNameAttributedString
                    mobileNumberlabel.attributedText = contactNumberAttributedString
            }
            )

            let regexForNumber = try? NSRegularExpression( pattern: pattern, options: [.caseInsensitive])
            regexForNumber?.enumerateMatches(
                in: data.contact_number,
                options: NSRegularExpression.MatchingOptions(),
                range: rangeForNumber,
                using: {
                    (textCheckingResult, matchingFlags, stop) -> Void in
                    let subRange = textCheckingResult?.range
                    contactNumberAttributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: subRange!)
                    mobileNumberlabel.attributedText = contactNumberAttributedString
                    nameLabel.attributedText = contactNameAttributedString
            }
            )

        }else{
            nameLabel.text = data.contact_name
            mobileNumberlabel.text = data.contact_number
        }
    }

    // Developer Note To Do : Code optimization for the highlighting is remaining

    //    func highlightLabel(pattern:String,nameLabel: UILabel ,numberLabel: UILabel,
    //                        stringForAtrribution: String,range:NSRange , attributedStringForName : NSMutableAttributedString,
    //                        attributedStringForNumber : NSMutableAttributedString){
    //        let regex = try! NSRegularExpression( pattern: pattern, options: [.caseInsensitive])
    //        regex.enumerateMatches(
    //            in: stringForAtrribution,
    //            options: NSRegularExpression.MatchingOptions(),
    //            range: range,
    //            using: {
    //                (textCheckingResult, matchingFlags, stop) -> Void in
    //                let subRange = textCheckingResult?.range
    //                print(subRange?.length ?? "")
    //                if (subRange?.length)! > 0 {
    //                    attributedStringForName.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: subRange!)
    //                    attributedStringForNumber.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: subRange!)
    //                    nameLabel.attributedText = attributedStringForName
    //                    numberLabel.attributedText = attributedStringForNumber
    //                }
    //            }
    //        )
    //    }
    
}
