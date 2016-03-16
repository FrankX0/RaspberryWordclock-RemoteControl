//
//  SettingsViewController.swift
//  
//
//  Created by Pascal Henze on 05.01.16.
//
//

import UIKit
import Toast

class SettingsViewController: UIViewController {

    @IBOutlet weak var ipTextField: UITextField!
    @IBOutlet weak var webIOUser: UITextField!
    @IBOutlet weak var webIOPassword: UITextField!
    @IBOutlet weak var wordclockButtons: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ipTextField.text = RaspberryHandler.sharedInstance.raspberryIP()
        self.webIOPassword.text = RaspberryHandler.sharedInstance.webIOPassword()
        self.webIOUser.text = RaspberryHandler.sharedInstance.webIOUser()
        self.wordclockButtons.text = RaspberryHandler.sharedInstance.wordclockButtons()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func testConnectionClicked(sender: UIButton) {
        self.view.makeToastActivity(CSToastPositionCenter)
        RaspberryHandler.sharedInstance.get("/GPIO/18/value", callback: { (result) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                self.view.hideToastActivity()
                self.view.makeToast("Connecton Successfull",duration: 1.0,position: CSToastPositionCenter)
            }
            
        }) { () -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                self.view.hideToastActivity()
                self.view.makeToast("Connecton Failed",duration: 1.0,position: CSToastPositionCenter)
            }
            
        }

    }
    
    @IBAction func saveClicked(sender: UIButton) {
        NSUserDefaults.standardUserDefaults().setValue(self.ipTextField.text, forKey: kRasperryIPUserDefaultsKey)
         NSUserDefaults.standardUserDefaults().setValue(self.webIOPassword.text, forKey: kWebIOPasswordUserDefaultsKey)
         NSUserDefaults.standardUserDefaults().setValue(self.webIOUser.text, forKey: kWebIOUserUserDefaultsKey)
         NSUserDefaults.standardUserDefaults().setValue(self.wordclockButtons.text, forKey: kButtonsUserDefaultsKey)
        
        self.navigationController?.popViewControllerAnimated(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
