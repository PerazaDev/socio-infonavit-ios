//
//  MenuNavigationViewController.swift
//  SocioInfonavitNextia
//
//  Created by Daniel Sanchez Peraza on 26/03/22.
//

import UIKit
protocol MenuNavigationViewControllerDelegate{
    func hideMenu()
}
class MenuNavigationViewController: UIViewController, UIGestureRecognizerDelegate{
    var delegate : MenuNavigationViewControllerDelegate?
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var overView: UIView!
    
    @objc func didOverPressView (_ sender : UITapGestureRecognizer){
        UIView.animate(withDuration: 0.5) {
//            self.view.transform = CGAffineTransform(translationX:-self.view.bounds.size.width,  y: 0)
//           self.overView.isHidden = true
            self.delegate?.hideMenu()
            
        }
    }
    
    // lo que se carga cuando la vista ha sido cargada
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupOverView()
    }
    
    //lo que se carga cuando va todavia aparecer la vista
//    override func viewWillAppear(_ animated: Bool) {
//        
//        self.overView.alpha = 0
//        self.overView.isHidden = true
//        UIView.animate(withDuration: 0.5) {
//            self.view.transform = CGAffineTransform(translationX:0,  y:0)
//            DispatchQueue.main.asyncAfter(deadline: .now()+0.37) {
//                UIView.animate(withDuration: 0.2) {
//                    self.overView.isHidden = false
//                    self.overView.alpha = 1.0
//                }
//            }
//        }
//
//    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Confirmacion", message: "¿Seguro que desea cerrar sesion?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .destructive,handler: { action in
            DashboardController.shared.logoutResponse { res in
                print(res)
                UserDefaults.standard.removeObject(forKey: "tokenLogin")
            }
            UIView.animate(withDuration: 0.5) {
                self.view.transform = CGAffineTransform(translationX:-self.view.bounds.size.width,  y: 0)
                self.overView.isHidden = true
            } completion: { Bool in
                self.performSegue(withIdentifier: "logoutSegue", sender: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cerrar", style: .cancel))
        present(alert, animated: true)
          
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoutSegue"{
            guard let _ = segue.destination as? ViewController else {
                return
            }
        }
        
    }
    
    func setupOverView (){
        let tapGesture = UITapGestureRecognizer(target: self,action:#selector(self.didOverPressView(_:)))
        tapGesture.delegate = self
        overView.addGestureRecognizer(tapGesture)
    }
    
}

