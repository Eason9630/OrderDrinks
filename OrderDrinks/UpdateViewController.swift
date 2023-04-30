//
//  UpdateViewController.swift
//  OrderDrinks
//
//  Created by 林祔利 on 2023/4/26.
//

import UIKit

class UpdateViewController: UIViewController {
    
    weak var delegate: UpdateDelegate?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var setOrder: UIButton!
    
    @IBOutlet weak var toppingLabel: UILabel!
    @IBOutlet weak var iceLabel: UILabel!
    @IBOutlet weak var sugerLabel: UILabel!
    @IBOutlet weak var ToppingSegment: UISegmentedControl!
    @IBOutlet weak var IceSegmented: UISegmentedControl!
    @IBOutlet weak var SugerSegmented: UISegmentedControl!
    @IBOutlet weak var drinkNameLebel: UILabel!
    
    
    var item: OrderRecords
    
    
    
    
    init?(coder: NSCoder, item: OrderRecords){
        self.item = item
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        guard let item = coder.decodeObject(forKey: "item") as? OrderRecords else {
            return nil
        }
        self.item = item
        super.init(coder: coder)
    }
    
    
    
    var userName = ""
    var drinkName = ""
    var ice = ""
    var suger = ""
    var topping = "無"
    var price = ""
    var count = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let first = item
        userName = first.fields.orderName
        drinkName = first.fields.drinksName
        ice = first.fields.ice
        suger = first.fields.suger
        topping = first.fields.topping
        price = first.fields.count
        count = first.fields.price
        
        nameTextField.text = userName
        drinkNameLebel.text = drinkName
        sugerLabel.text = suger
        iceLabel.text = ice
        toppingLabel.text = topping
        
        sugerLabel.isHidden = false
        iceLabel.isHidden = false
        toppingLabel.isHidden = false
        
        setOrder.isHidden = true
        SugerSegmented.isHidden = true
        ToppingSegment.isHidden = true
        IceSegmented.isHidden = true
    }
    
    
    @IBAction func iceSegment(_ sender: UISegmentedControl) {
        let iceSelect = sender.selectedSegmentIndex
        switch iceSelect {
        case 0:
            ice = "熱飲"
        case 1:
            ice = "去冰"
        case 2:
            ice = "微冰"
        case 3:
            ice = "少冰"
        case 4:
            ice = "正常"
        default:
            break
        }
    }
    
    @IBAction func sugerSegment(_ sender: UISegmentedControl) {
        let select = sender.selectedSegmentIndex
        switch select {
        case 0:
            suger = "無糖"
        case 1:
            suger = "三分糖"
        case 2:
            suger = "半糖"
        case 3:
            suger = "七分糖"
        case 4:
            suger = "正常"
        default:
            break
        }
    }
    
    @IBAction func toppingSegment(_ sender: UISegmentedControl) {
        let selectTopping = sender.selectedSegmentIndex
        switch selectTopping {
        case 0:
            topping = "無"
        case 1:
            topping = "白玉珍珠"
        case 2:
            topping = "墨玉珍珠"
        default:
            break
        }
    }

    @IBAction func UpdateOrder(_ sender: Any) {
        setOrder.isHidden.toggle()
        SugerSegmented.isHidden.toggle()
        ToppingSegment.isHidden.toggle()
        IceSegmented.isHidden.toggle()
        sugerLabel.isHidden.toggle()
        iceLabel.isHidden.toggle()
        toppingLabel.isHidden.toggle()

    }
    
    @IBAction func UpdateOrderDrink(_ sender: Any) {
        update(item: item)
    }
    
    func update(item:OrderRecords){
        
        let parameters: [String: Any] = [
            "suger": suger,
            "ice": ice,
            "topping": topping
        ]
        
        let updateURL = "https://api.airtable.com/v0/appLHR9Jn5QhBFIey/OrderItem/\(item.id!)"
        
        let url = URL(string: updateURL)
        var RequestURL = URLRequest(url: url!)
        RequestURL.httpMethod = "PATCH"
        RequestURL.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        RequestURL.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: ["fields": parameters]){
            
            RequestURL.httpBody = jsonData
            
            URLSession.shared.dataTask(with: RequestURL){ data, response, error in
                if let response = response as? HTTPURLResponse,
                   response.statusCode == 200,
                   error == nil {
                    print("Success")
                    self.delegate?.didUpdateOrder()
                    self.navigationController?.popViewController(animated: true)
                } else {
                    print("Error: \(error!)")
                }
            }.resume()
        }
    }

}
