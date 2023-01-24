//
//  SentMemesCollectionViewController.swift
//  MemeMeS
//
//  Created by MacBook on 01/07/1444 AH.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController{
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var memes = [Meme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 3.0
        let width = (view.frame.size.width - (2 * space)) / 3.0
        let height = (view.frame.size.height - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: width, height: height)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(SentMemesCollectionViewController.createMemeEditor))
    }
    
    @objc func createMemeEditor(){
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        present(viewController, animated: true, completion: nil)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        collectionView?.reloadData()
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.title = "Sent Memes"
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.imageView.image = meme.memedImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
         viewController.index = (indexPath as NSIndexPath).row
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
