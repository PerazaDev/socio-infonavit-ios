//
//  DashboardViewController.swift
//  SocioInfonavitNextia
//
//  Created by Daniel Sanchez Peraza on 26/03/22.
//
import SkeletonView
import UIKit

class DashboardViewController: UIViewController, MenuNavigationViewControllerDelegate {
    @IBOutlet weak var menuContainerView: UIView!

    var token : String = UserDefaults.standard.string(forKey: "tokenLogin")!
    var menuController :  MenuNavigationViewController?
    var wallets : [WalletResponseModel] = []
    @IBOutlet weak var walletsTableView: UITableView!
    
    
    @IBOutlet weak var leftConstrainsMenu: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(token)
        menuContainerView.isHidden = true
        setupTableView()
    }
    
    
    func hideMenu() {
        self.hideMenuView()
    }
    func hideMenuView(){
        self.menuContainerView.isHidden = true
        self.leftConstrainsMenu.constant = -view.bounds.size.width
    }
    
   
    
    func setupTableView(){
        
       
        DashboardController.shared.walletsResponse(token: token) { wallets in
            DispatchQueue.main.async {
                self.walletsTableView.dataSource = self
                self.walletsTableView.delegate = self
                self.walletsTableView.register(UINib(nibName: "\(WalletTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "walletCell")
                self.wallets = wallets
                self.walletsTableView.reloadData()
            }
        }
    }
    
    
    
  
    @IBAction func menuPressButton(_ sender: Any) {
        
        self.menuContainerView.isHidden = false
        self.leftConstrainsMenu.constant = 0
        print("presionando boton")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menuSegue"{
            if let vc = segue.destination as? MenuNavigationViewController{
                self.menuController = vc
                self.menuController?.delegate = self
            }
        }
    }
}

extension DashboardViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wallets.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = walletsTableView.dequeueReusableCell(withIdentifier: "walletCell", for: indexPath) as? WalletTableViewCell else{
            return UITableViewCell()
        }
        cell.benevit.removeAll()
        cell.setupCell(wallet: self.wallets[indexPath.row])
       
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
        
    }
    
    
}


