//
//  ViewController.swift
//  SocioInfonavitNextia
//
//  Created by Daniel Sanchez Peraza on 26/03/22.
//

import UIKit
import SkeletonView
class ViewController: UIViewController {
    
    
    var flag :Bool = false
    
    let token :String? = UserDefaults.standard.string(forKey: "tokenLogin")
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTexField: UITextField!
    @IBOutlet weak var forgetButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            //evaluamos si ya estaba logeado antes de mostrarse la vista
            if UserDefaults.standard.string(forKey: "tokenLogin") != nil {
                
                self.performSegue(withIdentifier: "dashboardSegue", sender: self.self)

            }
    /*si no, carga los delegados antes de mostrarse la vista*/
            else{
          
                self.emailTexField.delegate = self
                
                self.passwordTextField.delegate = self
                self.loginButton.isEnabled = false
                self.setupUI()
            }
        }
        
            
        
        
        
    }
    
    
    
    func setupUI(){
        //efecto subrayado de boton Olvide la contraseña
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        let atribbutes = NSMutableAttributedString(
            string: "Olvidé la contraseña",
            attributes: yourAttributes
        )
        forgetButton.setAttributedTitle(atribbutes,for:.normal )
        //button login
        loginButton.layer.cornerRadius = loginButton.bounds.height / 2
        
    }
    
    @IBAction func loginPressButton(_ sender: Any) {
        if !self.emailTexField.text!.isEmpty && !self.passwordTextField.text!.isEmpty {
            let user = User.init(email:self.emailTexField.text! , password: self.passwordTextField.text!)
            print("datos al pasarlo \(user.email) \(user.password)")
            DashboardController.shared.loginResponse(user: user) { logged, token in
                if logged {
                    //evaluo token valido
                    UserDefaults.standard.set(token!, forKey: "tokenLogin")

                    self.prepareViewSegue()
                }
                else{
                    //evaluo token invalido

                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error", message: "Usuario o contraseña incorrecta", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel))
                        self.present(alert, animated: true)
                    }
                    
                }
            }
       
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Ingresa todos los datos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel))
            self.present(alert, animated: true)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dashboardSegue"{
            guard let _ = segue.destination as? DashboardViewController else{
                return
            }
            
        }
    }
    func prepareViewSegue(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "dashboardSegue", sender: nil)
        }
    }
}

//se conforma los protocoles correspondientes para los eventos ocurridos en los txtfield
extension ViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !emailTexField.text!.isEmpty && !passwordTextField.text!.isEmpty {
            loginButton.isEnabled = true
        }
        else{
            loginButton.isEnabled = false
            
        }
        
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        
        if !self.emailTexField.text!.isEmpty && !self.passwordTextField.text!.isEmpty {
            let user = User.init(email:self.emailTexField.text! , password: self.passwordTextField.text!)
            print("datos al pasarlo \(user.email) \(user.password)")
            DashboardController.shared.loginResponse(user: user) { logged, token in
                if logged {
                    //evaluo token valido
                    UserDefaults.standard.set(token!, forKey: "tokenLogin")

                    self.prepareViewSegue()
                }
                else{
                    //evaluo token invalido

                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error", message: "Usuario o contraseña incorrecta", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel))
                        self.present(alert, animated: true)
                    }
                    
                }
            }
       
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Ingresa todos los datos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel))
            self.present(alert, animated: true)
        }
        
        
        return true
    }
    
    
}
