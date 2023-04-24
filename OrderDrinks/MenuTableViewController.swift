//
//  MenuTableViewController.swift
//  OrderDrinks
//
//  Created by 林祔利 on 2023/4/23.
//

import UIKit

public let apiKey = "key6uDxppJsZibEKS"

class MenuTableViewController: UITableViewController {

    var menus = [Records]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchMenu()
    }

    func fetchMenu(){
        
        let menuURL = "https://api.airtable.com/v0/appLHR9Jn5QhBFIey/Menu"
        let url = URL(string: menuURL)!
        
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "Get"
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            let decoder = JSONDecoder()
            if let data {
                do{
                    let result = try decoder.decode(MenuDate.self, from: data)
                    
                    print(result)
                    self.menus = result.records
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }catch{
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
        return menus.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MenuTableViewCell.self)", for: indexPath) as! MenuTableViewCell
        let menu = menus[indexPath.row]
        
        cell.menuName.text = menu.fields.name
        cell.menuDescription.text = menu.fields.descript
        cell.menuImage.image = UIImage(systemName: "music.house")
        URLSession.shared.dataTask(with: menu.fields.image[0].url) { data, response, error in
                if let data,
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.menuImage.image = image
                    }
                }
            }.resume()

        return cell
    }
    
    @IBSegueAction func goOrderItems(_ coder: NSCoder) -> OrderDrinksViewController? {
        guard let  row = tableView.indexPathForSelectedRow?.row else{return nil}
        let controller = OrderDrinksViewController(coder: coder)
        let selected = menus[row]
        return OrderDrinksViewController(coder: coder,item: [selected])
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
