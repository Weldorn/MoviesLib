//
//  SettingsViewController.swift
//  MoviesLib
//
//  Created by Welton Dornelas on 26/09/20.
//  Copyright © 2020 Welton Dornelas. All rights reserved.
//

import UIKit

import UIKit

final class SettingsViewController: UIViewController {
    
    //MARK: - Properties
    private let ud = UserDefaults.standard
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var switchAutoPlay: UISwitch!
    @IBOutlet weak var segmentControlColors: UISegmentedControl!
    @IBOutlet weak var textFieldCategory: UITextField!
    //MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: - Methods
    private func setupView() {
        let autoPlay = ud.bool(forKey: "autoplay")
        switchAutoPlay.isOn = autoPlay
        
        let colorIndex = ud.integer(forKey: "color")
        segmentControlColors.selectedSegmentIndex = colorIndex
        
        let category = ud.string(forKey: "category")
        textFieldCategory.text = category
        
    }
    
    //MARK: - IBActions
    @IBAction func autoPlayChanged(_ sender: UISwitch) {
        ud.set(sender.isOn, forKey: "autoaplay")
    }
    @IBAction func colorChanged(_ sender: UISegmentedControl) {
        ud.set(sender.selectedSegmentIndex, forKey: "color")
    }
    @IBAction func categoryChanged(_ sender: UITextField) {
        ud.set(sender.text, forKey: "category")
        sender.resignFirstResponder()
    }
}
