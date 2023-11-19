//
//  ViewController.swift
//  Code Sample
//
//  Created by Palukuri on 18/11/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Example usage
        let url1 = "https://example.com"
        let url2 = "malicious_script.com"

        if validateURLWithoutSanitization(urlString: url1) {
            print("URL 1 is valid")
        } else {
            print("URL 1 is invalid")
        }

        if validateURLWithoutSanitization(urlString: url2) {
            print("URL 2 is valid")
        } else {
            print("URL 2 is invalid")
        }
    }
    

    func validateURLWithoutSanitization(urlString: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "^(https?://)?([\\da-zA-Z.-]+)\\.([a-zA-Z.]{2,6})([/\\w.-]*)*/?$", options: .caseInsensitive)
        
        // Match the URL string against the regular expression
        let range = NSRange(location: 0, length: urlString.utf16.count)
        return regex.firstMatch(in: urlString, options: [], range: range) != nil
    }

   



}

