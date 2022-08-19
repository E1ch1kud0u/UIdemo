////
////  Info2ViewController.swift
////  UIdemo
////
////  Created by Airi Furukawa on 2022/06/17.
////
//
//import UIKit
//import SafariServices
//
//class Info2ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {
//    
//    @IBOutlet weak var searchBar: UITableView!
//    @IBOutlet weak var tabelView: UITableView!
//    var word = ""
//    var ArticleList: [(title: String, url: URL, urlToImage: URL)] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        searchBar.delegate = self
//        tabelView.dataSource = self
//        tabelView.delegate = self
//        // Do any additional setup after loading the view.
//    }
//    
//    func searchBarButtonClicked(_ searchBar: UISearchBar) {
//        view.endEditing(true)
//        
//        if let searchWord = searchBar.text {
//            searchArticle(word: searchWord)
//        }
//    }
//    
//    func searchArticle(word: String) {
//        guard let word_encode = word.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
//            return
//        }
//        guard let req_url = URL(string: "https://newsapi.org/v2/everything/=\(word_encode)&apiKey=3cdc24314708452e96caf1adfb49b6fc") else {
//           return
//        }
//        
//        let req = URLRequest(url: req_url)
//        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
//        let task = session.dataTask(with: req, completionHandler: { (data, response, error) in
//            session.finishTasksAndInvalidate()
//            do {
//                let decoder = JSONDecoder()
//                let json = try decoder.decode(ResultJson.self, from: data!)
//                
//                if let articles = json.articles {
//                    self.ArticleList.removeAll()
//                    for article in articles {
//                        if let title = article.title, let url = article.url, let urlToImage = article.urlToImage {
//                            let infos = (title, url, urlToImage)
//                            self.ArticleList.append(infos)
//                        }
//                    }
//                    self.tableView.reloadData()
//                    
//                    if let infosbdg = self.ArticleList.first{
//                        print("--------------------")
//                        print("ArticleList[0] = \(infosbdg)")
//                    }
//                }
//            } catch {
//                print("Error Detected")
//            }
//        })
//        task.resume()
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return ArticleList.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
//        cell.textLabel?.text = ArticleList[indexPath.row].title
//        cell.textLabel?.numberOfLines = 0
//        if let imageData = try? Data(contentsOf: ArticleList[indexPath.row].urlToImage) {
//            cell.imageView?.image = UIImage(data: imageData)
//        }
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
//    
//    func tableView(_tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let safariViewController = SFSafariViewController(url: ArticleList[indexPath.row].url)
//        safariViewController.delegate = self
//        present(safariViewController, animated: true, completion: nil)
//    }
//    
//    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
//        dismiss(animated: true, completion: nil)
//    }
//    
//    
//    struct ArticleJson: Codable {
//        let title: String?
//        let url: URL?
//        let urlToImage: URL?
//    }
//    struct ResultJson: Codable {
//        let articles: [ArticleJson]?
//    }
//}
