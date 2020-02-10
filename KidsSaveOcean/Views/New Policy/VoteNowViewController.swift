//
//  VoteNowViewController.swift
//  KidsSaveOcean
//
//  Created by Neha Mittal on 9/17/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class VoteNowViewController: UIViewController, Instantiatable {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var pickerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var voteButton: UIButton!
    
    @IBOutlet weak var impactNumberLabel: UILabel!
    @IBOutlet weak var difficultyNumberLabel: UILabel!
    @IBOutlet weak var impactToDifficultyNumberLabel: UILabel!
    
    
    var pickerData = HijackPoliciesViewModel.shared().hidjackPolicies.sorted {$0.id < $1.id}
    
    var selectedPolicy: HijackPolicy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIScreen.main.bounds.height > 800 {
                self.pickerViewHeightConstraint.constant *= 2.1
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let userHijackPolicy = UserViewModel.shared().hijack_policy_selected
        
        if !userHijackPolicy.isEmpty {
            let alertMessage = UIAlertController(title: "", message: "Explore proposals FateChanger youth are considering for citizen ballot initiatives", preferredStyle: .alert)
            let action = UIAlertAction(title: "Got it", style: .cancel) { (_) in
                //
            }
            alertMessage.addAction(action)
            
            self.present(alertMessage, animated: true) {
                self.voteButton.isEnabled = false
            }
        }
        
        impactNumberLabel.text = String(0.0)
        difficultyNumberLabel.text = String(1.0)
        impactToDifficultyNumberLabel.text = String(0.0)
        
        let policy = pickerData[0]
        pickerView.selectRow(0, inComponent: 0, animated: true)
        setPolicyDetails(policy)
    }
    
    @IBAction func voteNowButton() {
        let dialogMessage = UIAlertController(title: "Are you sure you want to vote for this policy?", message: "", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (_) -> Void in
            if let selectedPolicy = self.selectedPolicy {
//                if UserViewModel.shared().hijack_policy_selected != selectedPolicy.id {
//                    UserViewModel.shared().campaign = nil
//                }
                UserViewModel.shared().hijack_policy_selected = selectedPolicy.id
                UserViewModel.shared().saveUser()
                HijackPoliciesViewModel.shared().updateVotes(policy: selectedPolicy, value: selectedPolicy.votes + 1)
                
            }
            self.pickerData = HijackPoliciesViewModel.shared().hidjackPolicies
            self.dismiss(animated: false, completion: nil)
            self.navigationController?.popViewController(animated: true)
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (_) -> Void in
            self.dismiss(animated: false, completion: nil)
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let hijackPolicy = pickerData[row]
        setPolicyDetails(hijackPolicy)
    }
    
    private func setPolicyDetails(_ policy: HijackPolicy) {
        selectedPolicy = policy
        summaryLabel.text = policy.summary
        
        let impact = Double(policy.votes)
        impactNumberLabel.text = String(impact)
        difficultyNumberLabel.text = String(1.0)
        impactToDifficultyNumberLabel.text = String(impact / 1.0)
    }
}

// MARK: - UIPickerViewDataSource
extension VoteNowViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
}

// MARK: - UIPickerViewDelegate
extension VoteNowViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }

        label.text = pickerData[row].description
        label.textAlignment = .center
        label.font = UIFont.proDisplaySemiBold15
//        label.adjustsFontSizeToFitWidth = true
//        label.minimumScaleFactor = 0.5

        return label
    }
}
