//
//  ViewController.swift
//  Code Sample
//
//  Created by Palukuri on 18/11/23.
//

import UIKit
import CryptoKit

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
        
        retrieveUserData()
        login(username: "test", password: "test")
        cacheSensitiveData(userData: ["username": "test", "password": "test"])
        retrieveUserData()
        // Usage
        let userInput = "aaaaaaaaaaaaaaaaaaaaaaaaaaX" // Input that triggers ReDoS
        let isValid = validateInput(input: userInput)
    }
    

    func validateURLWithoutSanitization(urlString: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "^(https?://)?([\\da-zA-Z.-]+)\\.([a-zA-Z.]{2,6})([/\\w.-]*)*/?$", options: .caseInsensitive)
        
        // Match the URL string against the regular expression
        let range = NSRange(location: 0, length: urlString.utf16.count)
        return regex.firstMatch(in: urlString, options: [], range: range) != nil
    }

   
    func retrieveUserData() {
        // Simulating an API call to fetch user data
        let userData = "https://skilful-union-399804.uc.r.appspot.com/stripecustomers"

        // Logging user data - this is unsafe!
        print("User Data: \(userData)")
    }

    func sendUserDataToServer(userData: [String: Any]) {
        guard let url = URL(string: "https://api.example.com/userData") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: userData, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle the response, possibly without considering SSL pinning or HTTPS usage
        }.resume()
    }
    
    func cacheSensitiveData(userData: [String: Any]) {
        UserDefaults.standard.set(userData, forKey: "userData")
    }
    
    func login(username: String, password: String) {
        // Sending login request...
        // ...
        // Log the entered password (unsafe)
        print("Entered Password: \(password)")
    }
    
    
    func validateInput(input: String) -> Bool {
        // This pattern is susceptible to exponential time matching
        let regex = #"^(([a-z])+.)+[A-Z]([a-z])+$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: input)
    }

  
    func encrypt(data: Data) -> Data? {
        let key = "MySecretEncryptionKey" // Hardcoded encryption key

        guard let keyData = key.data(using: .utf8) else {
            return nil
        }

        // Use the key to perform encryption
        // Example using CommonCrypto for AES encryption (simplified)
        // Do not use this for actual encryption, it's just an example
//        let encryptedData = performAESEncryption(data: data, key: keyData)
//
//        return encryptedData
        return nil
    }
   

    func hashPassword(password: String) -> String? {
        guard let passwordData = password.data(using: .utf8) else {
            return nil
        }

        let salt = generateRandomSalt() // Function to generate a random salt
        
        var hashed = SHA256.hash(data: passwordData + salt)
        for _ in 1..<10000 {
            hashed = SHA256.hash(data: hashed + salt)
        }

        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }

    func generateRandomSalt() -> Data {
        var key = [UInt8](repeating: 0, count: 16) // 128-bit salt size
        _ = SecRandomCopyBytes(kSecRandomDefault, key.count, &key)
        return Data(key)
    }

}

