//
//  CharacterDetailViewController.swift
//  MarvelList
//
//  Created by Tim Condon on 25/10/2019.
//  Copyright © 2019 Tim Condon. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    var character: Character?
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterTitle: UILabel!
    @IBOutlet weak var characterInformation: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let marvelCharacter = character {
            characterTitle.text = marvelCharacter.name
            if marvelCharacter.description == "" {
                characterInformation.text = "No description available"
            } else {
                characterInformation.text = marvelCharacter.description
            }
            
            let path = marvelCharacter.thumbnail.path.replacingOccurrences(of: "http://", with: "https://")
            let url = URL(string: "\(path).\(marvelCharacter.thumbnail.extension)")!
            let datatask = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let imageData = data else {
                    print("Failed to get image data")
                    return
                }
                guard let image = UIImage(data: imageData) else {
                    print("Data returned was not an image")
                    return
                }
                DispatchQueue.main.async {
                    self.characterImage.image = image
                }
            }
            datatask.resume()
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
