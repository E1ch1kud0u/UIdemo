//
//  info3ViewController.swift
//  UIdemo
//
//  Created by Airi Furukawa on 2022/07/22.
//

import UIKit
import SafariServices

class info3ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, SFSafariViewControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArticlesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticlesCell", for: indexPath)
        cell.textLabel?.text = ArticlesList[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        if let imageData = try? Data(contentsOf: ArticlesList[indexPath.row].urlToImage) {
            cell.imageView?.image = UIImage(data: imageData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let safariViewController = SFSafariViewController(url: ArticlesList[indexPath.row].url)
        safariViewController.delegate = self
        
        present(safariViewController, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.placeholder = "検索"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        searchArticles(keyword: keywords)
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var keywords = ""
    var ArticlesList: [(title: String, url: URL, urlToImage: URL)] = []
    
    struct AricleJson: Codable {
        let title: String?
        let url: URL?
        let urltoImage: URL?
    }
    
    struct ResultJson: Codable {
        let aricles: [AricleJson]?
    }
    
    func searchArticles(keyword: String) {
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        guard let req_url = URL(string: "https://newsapi.org/v2/everything/=\(keyword_encode)&apiKey=3cdc24314708452e96caf1adfb49b6fc") else {
            return
        }
        print(req_url)
        
        let req = URLRequest(url: req_url)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: req, completionHandler: {(data, response, error) in
            session.finishTasksAndInvalidate()
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(ResultJson.self, from: data!)
//                print(json)
                if let articles = json.aricles{
                    self.ArticlesList.removeAll()
                    for article in articles {
                        if let title = article.title, let url = article.url, let urlToImage = article.urltoImage {
                            let Articles = (title, url, urlToImage)
                            self.ArticlesList.append(Articles)
                        }
                    }
                    self.tableView.reloadData()
                    if let Articlesdbg = self.ArticlesList.first{
                        print("-----------")
                        print("ArticlesList[0] = \(Articlesdbg)")
                    }
                }
                
            } catch {
                print("Error Detected")
            }
        })
        task.resume()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if let searchWord = searchBar.text {
            print(searchWord)
            searchArticles(keyword: searchWord)
        }
    }
    
    


}
