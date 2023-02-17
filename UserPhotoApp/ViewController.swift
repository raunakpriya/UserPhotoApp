//
//  ViewController.swift
//  UserPhotoApp
//
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var data = [photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchApiData(URL: "https://jsonplaceholder.typicode.com/users") { result in
            self.data = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchApiData(URL url: String, completion: @escaping ([photo]) -> Void) {
        let url = URL(string: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if data != nil && error == nil {
                do {
                    let parseData = try JSONDecoder().decode([photo].self, from: data!)
                    completion(parseData)
                } catch {
                    print("Parse Data")
                }
            }
        }
        dataTask.resume()
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PhotoTableViewCell
        cell?.name?.text = data[indexPath.row].name
        cell?.email?.text = data[indexPath.row].email

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsHome") as? DetailViewController
        vc?.photoContent = data[indexPath.row]
        navigationController?.pushViewController(vc!, animated: true)
    }
    
}

extension UIImageView {
    func displayImage(from url: URL) {
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                    let data = data, error == nil,
                  let image = UIImage(data: data)
            else {
                return
            }
            DispatchQueue.main.async {
                self.image
            }
            
        })
        dataTask.resume()
    }
}
