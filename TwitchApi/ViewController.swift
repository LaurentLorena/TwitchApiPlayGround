//
//  ViewController.swift
//  TwitchApi
//
//  Created by Laurent Lorena on 08/04/18.
//  Copyright © 2018 Laurent Lorena. All rights reserved.
//

import UIKit
import Alamofire
typealias JSONDictionary = [String: AnyObject]
typealias JSONArray = Array<AnyObject>

class ViewController: UICollectionViewController  {
    
    
    let headers: HTTPHeaders = [
        "Client-ID": "jgwiacd7q1ebxu65ygwrzt528r8acs",
        "Accept": "application/vnd.twitchtv.v5+json"
    ]
    
    var games = [ResponseItemModel]()
    var pause = false
    var toSend = ResponseItemModel()
    
    @IBOutlet weak var colletionGames: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGames();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getGames(){
        pause = true
        var offset: Int
        if(self.games.count != 0){
            offset = self.games.count+1
        }else{
            offset = 0
        }
        
        print(offset)
        
        Alamofire.request("https://api.twitch.tv/kraken/games/top?offset=\(offset)", headers: headers)
            .responseJSON{ response in
                let res = response.result.value as! NSDictionary
                let teste = res.object(forKey: "top") as! JSONArray
                for t in teste{
                    let respItem = t as! JSONDictionary
                    let toAdd = ResponseItemModel(json: respItem)
                    self.games.append(toAdd)
                }
                
                self.colletionGames.reloadData()
                self.pause = false
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return Int.max
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.games.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectItemCustom", for: indexPath) as! CollectItemCustom
        let item = self.games[indexPath.item]
        cell.nameGame.text = item.game.name
        cell.imgGame.downloadedFrom(link: item.game.box.medium)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.games[indexPath.item]
        self.toSend = item
        performSegue(withIdentifier: "goToDetail", sender: true)
    }
    
    internal override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            if(!pause){
              getGames()
            }
            self.pause = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            if let viewController = segue.destination as? ViewGameDetail {
                    viewController.gameToShow = self.toSend
            }
        }
    }
    
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

