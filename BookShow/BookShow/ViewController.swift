//
//  ViewController.swift
//  BookShow
//
//  Created by Vido Valianto on 2/28/19.
//  Copyright © 2019 Vido Valianto. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var myTableView: UITableView!
    var listBook = [Book]()
    let size = CGSize(100, 100)
    var sampleTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let yStart = UIApplication.shared.statusBarFrame.size.height
        let tfieldHeight = 40
        
        sampleTextField =  UITextField(frame: CGRect(x: 20, y: Int(yStart), width: 250, height: tfieldHeight))
        sampleTextField.placeholder = "Enter text here"
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.delegate = self
        self.view.addSubview(sampleTextField)
        
        let button = UIButton(frame: CGRect(x: 300, y: Int(yStart), width: 100, height: tfieldHeight))
        button.backgroundColor = UIColor.darkGray
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(searchBook), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navigationBarHeight: CGFloat = 20
        
        myTableView = UITableView(frame: CGRect(x: 0, y: yStart+CGFloat(tfieldHeight), width: displayWidth, height: displayHeight - (yStart+CGFloat(tfieldHeight))))
        myTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.estimatedRowHeight = 44
        
        self.view.addSubview(myTableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadBooks(bookTitle: String) {
        var urlbookTitle = ""
        if let bookTitle  = bookTitle.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),  let title = URL(string: bookTitle) {
        
            urlbookTitle = String(describing: title)
        }
        let url = "https://www.googleapis.com/books/v1/volumes?q="+urlbookTitle
        let parameters :Parameters = [
            "key" : "AIzaSyByk0QFa6qk8Uw4KYqh-xqBsdyNZMq2zzE",
//            "projection" : "lite"
        ]
        
        Alamofire.request(url, method:.get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let data):
                
                let swiftyJsonVar = JSON(response.result.value!)
//                print(swiftyJsonVar)
                for (key,subJson):(String, JSON) in swiftyJsonVar {
                    for (key,subsubJson):(String, JSON) in subJson{
                        
                        var book = Book()
                        let Json = subsubJson["volumeInfo"]
                        print(Json)
                        book.title = Json["title"].string
                        book.authors = Json["authors"][0].string
                        book.averageRating = String(Json["ratingsCount"].intValue)
                        print(book.averageRating)
                        book.imageLinks = Json["imageLinks"]["smallThumbnail"].string
                        if(!book.allNilField()){
                            book.hasNilField()
                            self.listBook.append(book)
                        }
                        
                    }
                }
                
                if let resData = swiftyJsonVar[].arrayObject {
                    self.listBook = resData as! [Book]
                    
                }
                if self.listBook.count > 0 {
                    self.myTableView.reloadData()
                    
                }
                
            case .failure(let error):
                
                print(error)
            }
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! CustomTableViewCell
        
        var url : URL
        if (listBook[indexPath.row].imageLinks != nil) {
            url = URL(string: listBook[indexPath.row].imageLinks)!
            
        }else{
            url = URL(string: "https://www.unesale.com/ProductImages/Large/notfound.png")!
        }
        let data = try! Data(contentsOf: url)
        cell.imgBook.image = imageResize(image :UIImage(data: data)!,sizeChange: size)
//        cell.imgBook.image = UIImage(data: data)
        cell.judulLbl.text = listBook[indexPath.row].title
        cell.authorLbl.text = listBook[indexPath.row].authors
        cell.ratingLbl.text = listBook[indexPath.row].averageRating
        cell.cosmosView.rating = Double(listBook[indexPath.row].averageRating)!

        return cell
    }
    
    func imageResize (image:UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.draw(in: CGRect(origin: .zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
    
    @objc func searchBook(sender: UIButton!) {
        print("Button tapped")
        
        
        guard let text = sampleTextField.text, !text.isEmpty else {
            return
        }
        if (sampleTextField.text == " ") {
            
        }
        let alert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
        downloadBooks(bookTitle: sampleTextField.text!)
        listBook = []
        
    }

}

extension CGRect {
    var center : CGPoint  {
        get {
            return CGPoint(x:self.midX, y: self.midY)
        }
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
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
    func downloaded(from link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension CGSize{
    init(_ width:CGFloat,_ height:CGFloat) {
        self.init(width:width,height:height)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        print("TextField should begin editing method called")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("TextField did begin editing method called")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:
        print("TextField did end editing with reason method called")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // return NO to not change text
        print("While entering the characters this method gets called")
        return true
    }
    
}





