	//
//  OneNewsViewController.swift
//  NewsApp
//
//  Created by Artem on 04.10.2022.
//  Copyright © 2022 Artem. All rights reserved.
//

import UIKit

class OneNewsViewController: UIViewController {

    var article: Article!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var leableTitle: UILabel!
    
    @IBOutlet weak var textDescription: UITextView!
    
    @IBAction func share(_ sender: Any) {
        let any:[Any] = [article.url]
        let avc = UIActivityViewController(activityItems: any, applicationActivities: nil)
        self.present(avc, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        leableTitle.text = article.title
        textDescription.text = article.description
        
        DispatchQueue.main.async {
            if let url = URL(string: self.article.urlToImage) {
                if let data = try? Data(contentsOf: url) {
                    self.imageView.image = UIImage (data: data)
                }
            } else{
                self.imageView.image = UIImage(named: "imgNone")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
