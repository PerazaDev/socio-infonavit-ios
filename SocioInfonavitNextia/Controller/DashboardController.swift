//
//  DashboardController.swift
//  SocioInfonavitNextia
//
//  Created by Daniel Sanchez Peraza on 26/03/22.
//

import Foundation
import UIKit
final class DashboardController {
    let urlsession = URLSession.shared

    static let shared = DashboardController()
    
    func loginResponse (user : User , success :@escaping (_ logged: Bool, _ token : String?)->()){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let url = URL(string: "https://qa-api.socioinfonavit.com//api/v1/login")else{return}
        let data = try! encoder.encode(["user":user])
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        urlsession.dataTask(with: request) { data, response, error in
            if let token = (response as? HTTPURLResponse)?.value(forHTTPHeaderField: "Authorization"){
                    print(token)
                
                    success(true,token)

               
            }
            else {
            
                success(false,nil)
            }
        }.resume()
    }
    func logoutResponse (success : @escaping (_ res : String)->()){
        guard let url = URL(string: "https://qa-api.socioinfonavit.com/api/v1/member/wallets")else{return print("error en la url")}
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        urlsession.dataTask(with: request) { data, response, error in
            success("")
        }.resume()
        
        
    }
    func walletsResponse (token :String, success : @escaping (_ wallets: [WalletResponseModel])->()){
        guard let url = URL(string: "https://qa-api.socioinfonavit.com/api/v1/member/wallets")else{return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "Authorization")
        urlsession.dataTask(with: request) { data, response, error in
            if let data = data {
                guard let walletsParse = try? JSONDecoder().decode([WalletResponseModel].self, from: data) else{ print("error al parsear wallet")
                    return
                    
                }
                success(walletsParse)
            }
            else{
                print("error al obtener data")
            }
        }.resume()
    }
    func benevitsResponse (token :  String, success :  @escaping (_ benevits: BenevitResponseModel)->()){
        guard let url = URL(string: "https://qa-api.socioinfonavit.com//api/v1/member/landing_benevits")else{return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "Authorization")
        urlsession.dataTask(with: request) { data, response, error in
            guard let benevitsParse = try? JSONDecoder().decode(BenevitResponseModel.self, from: data!) else{ print("error al parsear benevit")
                return
            }
            success(benevitsParse)
        }.resume()
        
    }
    func imageResponse (urlImg:String, success : @escaping (_ imagen : UIImage)->()){
        guard let url = URL(string: urlImg) else {return}
        let urlsession = URLSession.shared
        urlsession.dataTask(with: url) { data, response, error in
            guard let img = UIImage(data: data!)else{return print("error en la imagen") }
            success(img)
            
        }.resume()
    }
}

