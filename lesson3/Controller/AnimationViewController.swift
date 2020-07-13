//
//  AnimationViewController.swift
//  CryptoConverter
//
//  Created by User on 11/28/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    
    var timer: Timer!
    var degree = CGFloat(Double.pi / 180)

    @IBOutlet weak var rotateButton: UIButton!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBAction func startButtonPressed(_ sender: Any) {
        startButton.isHidden = true
        stopButton.isHidden = false
        
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: Selector(("rotate")), userInfo: nil, repeats: true)
    }
    @IBAction func stopButtonPressed(_ sender: Any) {
        timer.invalidate()
        startButton.isHidden = false
        stopButton.isHidden = true
    }
    
    func rotate() {
        UIView.animate(withDuration: 0.02, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: { () -> Void in
            self.rotateButton.transform = CGAffineTransform(rotationAngle: self.degree)})
        { (finished) -> Void in
            self.degree += CGFloat(Double.pi / 180)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.isHidden = false
        stopButton.isHidden = true

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
