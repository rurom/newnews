//
//  ViewController.swift
//  NewNews
//
//  Created by Roman on 2/5/18.
//  Copyright © 2018 Roman Rudavskiy. All rights reserved.
//

import UIKit

let apiKey = "aecdc5df1eb44b70aa384f61640bc2c5"

//Store the source name to these variable during transition
//formatted for url request
var selectedSource:String?
//for navigation bar title
var titleSource:String!


class MainVC: UITableViewController {
    
    //Array for list of sources
    var sourcesArr:Array = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseSorcesJson()
    
    }//viewDidLoad

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sourcesArr.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Troubleshouting url string with "& - ." symbols
        let source = sourcesArr[indexPath.row]
        titleSource = source
        let urlStringSpace:String = source.replacingOccurrences(of: " ", with: "-")
        let urlStringDot:String = urlStringSpace.replacingOccurrences(of: ".", with: "&")
        let urlStringBracket:String = urlStringDot.replacingOccurrences(of: "-(", with: "&")
        let urlStringFinal:String = urlStringBracket.replacingOccurrences(of: ")", with: "")
        
        selectedSource = urlStringFinal
        
        performSegue(withIdentifier: "ArticlesVC", sender: source)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ArticlesVC" {
            _ = segue.destination as? ArticlesVC
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"Cell") else { return UITableViewCell()}
        
        let source = sourcesArr[indexPath.row]
        
        cell.textLabel?.text = source
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func parseSorcesJson() {
        
        let jsonSourcesUrl = "https://newsapi.org/v2/sources?apiKey=\(apiKey)"
        
        
        //optional binding to unwrap optional value
        guard let url = URL(string: jsonSourcesUrl) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else {return}
            
            do {
                
                let json = try JSONDecoder().decode(SourcesForNews.self, from: data)
                
                let array = json.sources
                
                DispatchQueue.main.async {
                    for var i in 0..<array.count {
                        if let source = array[i] {
                            self.sourcesArr.append(source.name!)
                            i+=1
                        }
                    }
                    self.tableView.reloadData()
                }//Dispatch
                
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }


}//class

