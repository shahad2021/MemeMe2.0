//
//  SentMemesViewController.swift
//  MemeMeS
//
//  Created by MacBook on 01/07/1444 AH.
//

import Foundation
import UIKit

class SentMemesViewController: UITableViewController{
    
    var memes = [Meme]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        tableView.reloadData()
        tableView.rowHeight = self.view.frame.height / 10.0
        self.navigationItem.title = "Sent Memes"
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(SentMemesViewController.createMemeEditor))
    }
    
    @objc func createMemeEditor(){
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        present(viewController, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell", for: indexPath)
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = meme.topText + "..." + meme.bottomText
        cell.imageView?.image = meme.memedImage
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meme = memes[(indexPath as NSIndexPath).row]
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        viewController.meme = meme
        viewController.index = (indexPath as NSIndexPath).row
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            memes.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    
}
