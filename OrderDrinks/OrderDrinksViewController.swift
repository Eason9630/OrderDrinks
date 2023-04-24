//
//  OrderDrinksViewController.swift
//  OrderDrinks
//
//  Created by 林祔利 on 2023/4/23.
//

import UIKit

class OrderDrinksViewController: UIViewController {
    @IBOutlet var itemIamge: UIView!
    @IBOutlet weak var sortLabel: UILabel!
    
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var iceSelect: UIButton!
    @IBOutlet weak var sugerSelect: UIButton!
    @IBOutlet weak var toppingSelect: UIButton!
    @IBOutlet weak var nameField: UITextField!
    
    var item: [Records]
    
    
    init?(coder: NSCoder, item: [Records]){
        self.item = item
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        guard let item = coder.decodeObject(forKey: "item") as? [Records] else {
            return nil
        }
        self.item = item
        super.init(coder: coder)
    }

    override func encode(with coder: NSCoder) {
        coder.encode(item, forKey: "item")
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstItem = item[0]
        let name = firstItem.fields.sort
        
        sortLabel.text = name
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
