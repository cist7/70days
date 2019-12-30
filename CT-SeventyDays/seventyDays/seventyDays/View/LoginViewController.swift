//
//  LoginViewController.swift
//  seventyDays
//
//  Created by 최일용 on 2019/12/26.
//  Copyright © 2019 CISTREE. All rights reserved.
//

import Foundation

class LoginViewController : BaseViewController {
    
    
    @IBOutlet weak var userProfileImageButton:UIButton!
    
    
    @IBAction func dismissModalViewController() {
        self.dismiss(animated: true, completion:{()->() in
            
        })
    }
    
    @IBAction func eidtProfileImageViewController() {
//        performSegue(withIdentifier: "editProfile", sender: nil)
        
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GPEditProfileViewController") as? GPEditProfileViewController {

//           if let navigator = navigationController {
               
            viewController.completionHandler = {(resultImage:UIImage) in
                self.updateProfileImage(image: resultImage)
            }
//               self.pushViewController(viewController, animated: true)
                self.present(viewController, animated: true, completion: nil)
            
//           }
        }
        
//        let editProfileViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? GPFeedListViewController
//
//        GPEditProfileViewController
//
//        performSegue(withIdentifier: "editProfile", sender: nil)
//        self.navigationController?.present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
//        completionHandler?(image, error, cacheType, url)
    }
    
    func updateProfileImage(image: UIImage){
        self.userProfileImageButton.setImage(image, for: .normal)
    }
}

