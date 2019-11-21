//
//  ViewController.swift
//  ForeCast
//
//  Created by Prog on 9/27/19.
//  Copyright © 2019 Prog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtCountryISOCode: UITextField!
    @IBOutlet weak var txtCityName: UITextField!
    @IBOutlet weak var lblCurrent: UILabel!
    @IBOutlet weak var lblMin: UILabel!
    @IBOutlet weak var lblMax: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    
    
    @IBAction func getWeather(_ sender: Any) {
        let cityName = txtCityName.text!
        let encCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let countryISO = txtCountryISOCode.text!
        let key = "cfca7735f342b05700ea79279834d8ea"
        let path = "https://api.openweathermap.org/data/2.5/weather/"
        let query = "q=\(encCityName),\(countryISO)&APPID=\(key)&units=metric&lang=es"
        let fullPath = "\(path)?\(query)"
        
        print(fullPath)
        
        txtCityName.resignFirstResponder()
        txtCountryISOCode.resignFirstResponder()
        
        if let url = URL(string: fullPath) {
            downloadInfo(url)
        }
        
        lblCurrent.text = ""
        lblMin.text = ""
        lblMax.text = ""
    }
    
    func downloadInfo(_ url: URL){
        URLSession.shared.dataTask(with: url) {(data, url, error) in do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
            
                let root : Root = try decoder.decode(Root.self, from: data!)
                DispatchQueue.main.async {
                    self.lblCurrent.text = "\(root.main.temp)"
                    self.lblMax.text = "\(root.main.tempMax)"
                    self.lblMin.text = "\(root.main.tempMin)"
                    let image = "\(root.weather[0].icon)"
                    let Path = "https://openweathermap.org/img/w/"
                    let imagePath = "\(Path)\(image).png"
                    if let urlI = URL(string: imagePath) {
                        self.downloadImage(urlI)
                    }
                }
            } catch {
            }
        }.resume()
    }
    
    func downloadImage(_ url: URL){
        URLSession.shared.dataTask(with: url) {(data, url, error) in if let imgData = data {
                
                DispatchQueue.main.async {
                    self.imageIcon.image = UIImage(data: imgData)
                }
            }
            
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

