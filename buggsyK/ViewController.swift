//
//  ViewController.swift
//  buggsyK
//
//  Created by Felipe Montoya on 2/10/22.
//

import UIKit


class ViewController: UIViewController {

    func didPressedChallangeAcceptedButton(_ sender: Any) {
        self.navigationController?.pushViewController(TableViewController(), animated: true)
    }
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    private func addiOSDevSignatureLabel() {
        let label = UILabel()
        label.text = "Solved by [INSERT YOUR NAME HERE]"
        self.view.addSubview(label)
    }
   
    var activityIndicator: ActivityIndicatorViewController!
    
    func showActivityIndicator() {
        activityIndicator = ActivityIndicatorViewController()
        activityIndicator.presenter = self
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addiOSDevSignatureLabel()
        showActivityIndicator()
        ImageService.downloadImage { result in
            switch result {
            case .success(let data):
                self.logoImageView.image = UIImage(data: data)
                self.children.first?.willMove(toParent: nil)
                self.children.first?.view.removeFromSuperview()
                self.children.first?.removeFromParent()
                self.activityIndicator = nil
            case .failure(_ ):
                //TODO: Handle Failure
                break
            }
            
        }
    }


}

