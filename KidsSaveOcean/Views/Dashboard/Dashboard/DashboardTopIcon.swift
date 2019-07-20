//
//  DashboardTopIcon.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 1/13/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class DashboardTopIcon: UIButton {

    var completed: Bool = false

    /*Peder [3:15 PM]
     1) if selected and incomplete: halo added, background white, icon red
     2) I selected and complete: halo, background white, icon blue */
    func setSelected() {
        if completed {
            setImage(#imageLiteral(resourceName: "dashboardIconBlue"), for: .normal)
        } else {
            setImage(#imageLiteral(resourceName: "dashboardIconRed"), for: .normal)
        }
        //add halo
        backgroundColor = .clear
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowRadius = 15.0
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.masksToBounds = false
    }

    /* Peder [3:15 PM]
     3) If unselected and incomplete: background darker, icon red
     4) If unselected and complete: background white, icon blue */
    func setUnselected() {
        if completed {
            setImage(#imageLiteral(resourceName: "dashboardIconBlue"), for: .normal)
        } else {
            setImage(#imageLiteral(resourceName: "dashboardIconRedNotFinished"), for: .normal)
        }
        // remove halo if it has been there
        layer.shadowRadius = 0
        layer.shadowOpacity = 0
        layer.shadowOffset = .zero
    }
}
