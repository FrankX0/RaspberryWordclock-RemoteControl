//
//  ControlViewController.swift
//  
//
//  Created by Pascal Henze on 05.01.16.
//
//

import UIKit
import Toast

class ControlViewController: UIViewController {

    @IBOutlet weak var rightWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var returnWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftButton.layer.borderWidth = 1.0;
        self.returnButton.layer.borderWidth = 1.0;
        self.rightButton.layer.borderWidth = 1.0;
        self.leftButton.layer.borderColor = self.leftButton.titleColorForState(UIControlState.Normal)?.CGColor
        
        self.returnButton.layer.borderColor = self.leftButton.titleColorForState(UIControlState.Normal)?.CGColor
        
        self.rightButton.layer.borderColor = self.leftButton.titleColorForState(UIControlState.Normal)?.CGColor
        
        self.leftButton.layer.cornerRadius = self.leftButton.frame.height / 3.0
        self.returnButton.layer.cornerRadius = self.leftButton.frame.height / 3.0
        self.rightButton.layer.cornerRadius = self.leftButton.frame.height / 3.0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func rightButtonClicked(sender: UIButton) {
        
        RaspberryHandler.sharedInstance.toggleGPIO(RaspberryHandler.sharedInstance.rightButtonNumber(), callback: { () -> Void in
            
            }) { () -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    self.view.hideToastActivity()
                    self.view.makeToast("Connecton Failed",duration: 1.0,position: CSToastPositionCenter)
                }
        }
    }
    
    @IBAction func returnButtonClicked(sender: UIButton) {
        RaspberryHandler.sharedInstance.toggleGPIO(RaspberryHandler.sharedInstance.returnButtonNumber(), callback: { () -> Void in
            
            }) { () -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    self.view.hideToastActivity()
                    self.view.makeToast("Connecton Failed",duration: 1.0,position: CSToastPositionCenter)
                }
        }
    }
    
    @IBAction func leftButtonClicked(sender: UIButton) {
        RaspberryHandler.sharedInstance.toggleGPIO(RaspberryHandler.sharedInstance.leftButtonNumber(), callback: { () -> Void in
            
        }) { () -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                self.view.hideToastActivity()
                self.view.makeToast("Connecton Failed",duration: 1.0,position: CSToastPositionCenter)
            }
        }
    
    }
    
    func setButtonsWidth(size : CGSize) {
        let availableWidth = size.width - 2*16 - 2*8;
        self.rightWidthConstraint.constant = availableWidth / 3.0
        self.leftWidthConstraint.constant = availableWidth / 3.0
        self.returnWidthConstraint.constant = availableWidth / 3.0
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setButtonsWidth(self.view.frame.size)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animateAlongsideTransition({ (context) -> Void in
            self.setButtonsWidth(size)
        
        }, completion: { (context) -> Void in
            
        })
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
