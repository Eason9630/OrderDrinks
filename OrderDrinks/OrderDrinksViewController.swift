//
//  OrderDrinksViewController.swift
//  OrderDrinks
//
//  Created by 林祔利 on 2023/4/23.
//

import UIKit

class OrderDrinksViewController: UIViewController {
    
    @IBOutlet weak var itemIamge: UIImageView!
    @IBOutlet weak var sortLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var iceSelect: UIButton!
    @IBOutlet weak var sugerSelect: UIButton!
    @IBOutlet weak var toppingSelect: UIButton!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var sizeSelect: UIButton!
    var item: [Records]
    var orderName = ""
    var drinksName = ""
    var suger = ""
    var ice = ""
    var count1 = ""
    var topping = "無"
    var basePrice = 0
    var i = 1 {
        didSet{
            count()
        }
    }
    
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
    
    var sizeL = ""
    var sizeM = ""
    var price = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        //數量跟金額
        count()
        //取得值
        let firstItem = item[0]
        let sort = firstItem.fields.sort
        let descript = firstItem.fields.descript
        let name = firstItem.fields.name
        sizeL = firstItem.fields.priceL ?? ""
        sizeM = firstItem.fields.priceM ?? ""
        //呼叫圖片 URL
        itemIamge.image = UIImage(systemName: "music.house")
        URLSession.shared.dataTask(with: firstItem.fields.image[0].url) { data, response, error in
                if let data,
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.itemIamge.image = image
                    }
                }
            }.resume()
        navigationItem.title = name
        descriptLabel.text = descript
        sortLabel.text = sort
        totalLabel.text = "\(price)"
        setSuger()
        setIce()
        setTop()
        setSize()
        
        drinksName = name
    }

    func setSuger() {
        sugerSelect.showsMenuAsPrimaryAction = true
        sugerSelect.changesSelectionAsPrimaryAction = true
        sugerSelect.menu = UIMenu(children: [
            UIAction(title: "請選擇", state: .on, handler: { action in
            }),
            UIAction(title: "正常", handler: { action in
                self.suger = "正常"
            }),
            UIAction(title: "七分糖", handler: { action in
                self.suger = "七分糖"
            }),
            UIAction(title: "半糖", handler: { action in
                self.suger = "半糖"
            }),
            UIAction(title: "三分糖", handler: { action in
                self.suger = "三分糖"
            }),
            UIAction(title: "無糖", handler: { action in
                self.suger = "無糖"
            })
        ])
    }
    
    func setIce() {
        iceSelect.showsMenuAsPrimaryAction = true
        iceSelect.changesSelectionAsPrimaryAction = true
        iceSelect.menu = UIMenu(children: [
            UIAction(title: "請選擇", state: .on, handler: { action in
            }),
            UIAction(title: "正常", handler: { action in
                self.ice = "正常"
            }),
            UIAction(title: "少冰", handler: { action in
                self.ice = "少冰"
            }),
            UIAction(title: "微冰", handler: { action in
                self.ice = "微冰"
            }),
            UIAction(title: "去冰", handler: { action in
                self.ice = "去冰"
            }),
            UIAction(title: "熱飲", handler: { action in
                self.ice = "熱飲"
            })
        ])
    }
    func setTop() {
        toppingSelect.showsMenuAsPrimaryAction = true
        toppingSelect.changesSelectionAsPrimaryAction = true
        toppingSelect.menu = UIMenu(children: [
            UIAction(title: "無", state: .on, handler: { action in
                self.price = self.basePrice
                self.topping = "無"
            }),
            UIAction(title: "白玉珍珠", handler: { action in
                print("白玉珍珠")
                self.price += 15
                self.totalLabel.text = "\(self.price)"
                self.price -= 15
                self.topping = "白玉珍珠"
            }),
            UIAction(title: "墨玉珍珠", handler: { action in
                print("墨玉珍珠")
                self.price += 15
                self.totalLabel.text = "\(self.price)"
                self.price -= 15
                self.topping = "墨玉珍珠"
            })
        ])
        
    }
    
    func setSize() {
        sizeSelect.showsMenuAsPrimaryAction = true
        sizeSelect.changesSelectionAsPrimaryAction = true
        sizeSelect.menu = UIMenu(children: [
            UIAction(title: "請選擇", state: .on, handler: { action in
            }),
            UIAction(title: "大杯 \(self.sizeL) 元", handler: { action in
                print("\(self.sizeL)")
                self.basePrice = Int(self.sizeL) ?? 0
                self.price = Int(self.sizeL) ?? 0
                self.totalLabel.text = "\(self.price)"
            }),
            UIAction(title: "中杯 \(self.sizeM) 元", handler: { action in
                print("\(self.sizeM)")
                self.basePrice = Int(self.sizeM) ?? 0
                self.price = Int(self.sizeM) ?? 0
                self.totalLabel.text = "\(self.price)"
            })
        ])
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func count () {
        countLabel.text = "\(i)"
        totalLabel.text = "\(self.price * i)"
        count1 = "\(i)"
    }
    @IBAction func addCount(_ sender: Any) {
       
        if( i == 5 ){
            i = 5
        }else{
            i += 1
        }
    }
  
    @IBAction func minusCount(_ sender: Any) {
        if( i == 1 ){
            i = 1
        }else{
            i -= 1
        }
    }
    
    func postOrderItem(){
        orderName = nameField.text!
        let orderItem = OrderItem(orderName: self.orderName, drinksName: self.drinksName, suger: self.suger, ice: self.ice, count: self.count1, topping: self.topping, price: "\(self.price)")
        
        
        let drinkOrder = OrderRecords(fields: orderItem)
        print(drinkOrder)
        
        
        let orderURL = "https://api.airtable.com/v0/appLHR9Jn5QhBFIey/OrderItem"
        let url = URL(string: orderURL)!
        
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "post"
        
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let Json = JSONEncoder()
        
        if let data = try? Json.encode(drinkOrder) {
            let _ = String(data: data, encoding: .utf8)
            URLSession.shared.uploadTask(with: urlRequest, from: data) { data , response, error in
              if let response = response as? HTTPURLResponse,
                 response.statusCode == 200,
                 error == nil {
                  print("success")
                  DispatchQueue.main.async {
                      self.navigationController?.popViewController(animated: true)
                  }
              }else {
                  print("fail")
                  print(error!)
              }
            }.resume()
        }
        
    }
    
    @IBAction func setPost(_ sender: Any) {
        postOrderItem()
    }
    
}

extension OrderDrinksViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
