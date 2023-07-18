//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Mehmet Yumurtacı on 7/7/23.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var degreeLabel: UILabel!
    
    @IBOutlet weak var conditionLabel: UILabel!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var weatherModel : WeatherResponseApi?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        
        
//        let kagithane = "lat=41.112354&lon=29.019973"
        let amsterdam = "lat=52.36700697548092&lon=4.904644729211858"
        
        let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?" + "\(amsterdam)" + "&appid=f7b5bad894293e8526d40680060bce2a")!
        
        let session = URLSession.shared
        
        
        
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                
                if let data {
                    do {
                        
                        let decoder = JSONDecoder()
                        let responseModel = try decoder.decode(WeatherResponseApi.self, from: data)
                        self.weatherModel = responseModel
                        DispatchQueue.main.async {
                            self.updateLabels()
                            self.collectionView.reloadData()
                        }
                        
                    }
                    catch {
                        print(error)

                    }
                    
                }
                else {
                    
                }
            }
            
        }
        task.resume()
        
        
    }
    
    func updateLabels() {
        self.placeLabel.text = "Amsterdam"
        
        let kelvin =  self.weatherModel?.current?.temp ?? 10
        let celcius = kelvin - 273
        let intCelcius = Int(celcius)
        
        self.degreeLabel.text = "\(intCelcius)°"
        
        let weatherExample = self.weatherModel?.current?.weather[0]
        self.conditionLabel.text = weatherExample?.main?.rawValue
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.topLabel.text = "\(indexPath.row)"
        
        let kelvin =  self.weatherModel?.hourly?[indexPath.row].temp ?? 0
        let celcius = kelvin - 273
        let intCelcius = Int(celcius)
        cell.bottomLabel.text = "\(intCelcius)°"
        
        let state = weatherModel?.hourly?[indexPath.row].weather.first??.main
        cell.setImage(state: state)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 103)
    }
    
   
}
   












