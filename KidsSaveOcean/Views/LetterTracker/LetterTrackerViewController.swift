//
//  LetterTrackerViewController.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 12/5/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import Foundation
import SnapKit

final class LetterTrackerViewController: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!

    private lazy var countriesData = CountriesService.shared().countriesContacts.sorted { (first, second) -> Bool in
        first.name < second.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewElements()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateViewConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let nearestCountry = CountriesService.shared().getNearestCountryToUserLocation(),
            let indextOfCountry = countriesData.firstIndex(where: { (country) -> Bool in
                country.name == nearestCountry.name
            }) {
            pickerView.selectRow(indextOfCountry, inComponent: 0, animated: true)
        }
    }

    private func setupViewElements() {
        setupNavigationBar()
        setupSubmitButton()
    }

    private func setupNavigationBar() {
        let fontColor = UIColor.black
        let titleLalel = UILabel()

        let attributedString = NSMutableAttributedString(string: "Letter Tracker")

        let length = attributedString.length
        let range = NSRange(location: 0, length: length)
        let font =  UIFont(name: "SF-Pro-Text-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20)

        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: fontColor, range: range)

        titleLalel.attributedText = attributedString
        navigationItem.titleView = titleLalel

        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    private func setupSubmitButton() {
        submitButton.layer.cornerRadius = 5
    }

    @IBAction func enterLetterInTheTracker(_ sender: Any) {

        let country = countriesData[pickerView.selectedRow(inComponent: 0)]
        CountriesService.shared().increaseLettersWrittenForCountry(country)
        UserViewModel.shared().increaseLetterWrittenCount()

        guard let mapVC = navigationController?.viewControllers.first as? MapViewController else { navigationController?.popViewController(animated: true)
            return
        }

        navigationController?.popToViewController(mapVC, animated: true)
    }

}

// MARK: - UIPickerViewDataSource
extension LetterTrackerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countriesData.count
    }
}

// MARK: - UIPickerViewDelegate
extension LetterTrackerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = countriesData[row].name
        label.textAlignment = .center

        return label
    }
}
