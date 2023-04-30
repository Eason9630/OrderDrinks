//
//  OrderTableViewController.swift
//  OrderDrinks
//
//  Created by 林祔利 on 2023/4/25.
//

import UIKit

class OrderTableViewController: UITableViewController{

    

    var orders = [OrderRecords]()
    
    //viewDidLoad 方法只會在 View 被載入到記憶體中時呼叫一次，通常用於初始化 View 的內容，如設定樣式、建立 UI 控制項、註冊通知等
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchOrder()
        
    }
    //viewWillAppear 中更新資料能夠確保每次顯示 View 時都會載入最新的資料，避免出現資料未更新的問題。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchOrder()
    }
    
    func fetchOrder(){
        let OrderURL = "https://api.airtable.com/v0/appLHR9Jn5QhBFIey/OrderItem"
        let url = URL(string: OrderURL)!
        
        var URLRequest = URLRequest(url: url)
        URLRequest.httpMethod = "Get"
        URLRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: URLRequest){data , response,error in
                let decoder = JSONDecoder()
            if let data {
                do {
                    let result = try decoder.decode(OrdersRecords.self, from: data)
                    self.orders = result.records
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch{
                    print(error)
                }
            }
        }.resume()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(OrderTableViewCell.self)", for: indexPath) as! OrderTableViewCell
        let order = orders[indexPath.row]
        
        cell.nameLabel.text = order.fields.orderName
        cell.drinkName.text = order.fields.drinksName
        cell.iceLabel.text = order.fields.ice
        cell.sugerLabel.text = order.fields.suger
        cell.countLabel.text = order.fields.count
        cell.priceLabel.text = order.fields.price
        
        return cell 
    }
    
    func fetchDelet(order: OrderRecords){
        let deleteUrl = "https://api.airtable.com/v0/appLHR9Jn5QhBFIey/OrderItem/\(order.id!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: deleteUrl!)
        var URLRequest = URLRequest(url: url!)
        URLRequest.httpMethod = "delete"
        URLRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let encoder = JSONEncoder()
        URLSession.shared.dataTask(with: URLRequest){ data, response, error in
            if let response = response as? HTTPURLResponse,
               response.statusCode == 200 ,
               error == nil
                {
                print("成功刪除")
                DispatchQueue.main.async {
                    if let index = self.orders.firstIndex(where: {$0.id == order.id}) {
                        self.orders.remove(at: index)
                        self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                    }
                }
            }else{
                print("刪除失敗")
                print(error!)
            }
        }.resume()

    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let order = orders[indexPath.row]
        
        //建立確認訊息
        let controller = UIAlertController(title: "\(order.fields.orderName)", message: "確定刪除此訂單嗎？", preferredStyle: .alert)
        
        //按確認才做刪除
        let okAction = UIAlertAction(title: "確認", style: .default) { _ in
            self.fetchDelet(order: order)
        }
        let cancel = UIAlertAction(title: "取消", style: .default)
        controller.addAction(okAction)
        controller.addAction(cancel)
        present(controller, animated: true,completion: nil)
    }
    
    @IBSegueAction func goUpdateView(_ coder: NSCoder) -> UpdateViewController? {
        guard let row = tableView.indexPathForSelectedRow?.row else {return nil}
        let controller = orders[row]
        return UpdateViewController(coder: coder, item: controller)
        
    }
    
    @IBAction func unwindToList(_ unwindSegue: UIStoryboardSegue) {
        tableView.reloadData()
//        if let controller = unwindSegue.source as? UpdateViewController {
//            if let order = controller.item as? OrderRecords{
//                if let indexPath = tableView.indexPathForSelectedRow {
//                    orders[indexPath.row] = order
//                    fetchOrder()
//                }
//            }
//        }
    }
}
extension OrderTableViewController: UpdateDelegate {
    func didUpdateOrder() {
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let controller = segue.destination as? UpdateViewController {
                controller.delegate = self
                fetchOrder()
            }
        }
    }
}
