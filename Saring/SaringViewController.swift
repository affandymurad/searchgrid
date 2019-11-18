//
//  SaringViewController.swift
//  search
//
//  Created by Affandy Murad on 14/11/19.
//  Copyright © 2019 Affandy Murad. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import WARangeSlider


class SaringViewController: UIViewController, UITextFieldDelegate {
//    let min = 0.0
//    let max = 100000000.0
    var tagsArray = [String]()
    var isWholeSale = false
    var isGoldChecked = false
    var isOfficialChecked = false
    var searchquery = ""
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 8
    }
    
    private let saringButton : UIButton =  {
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        let statusBarHeight = Swift.min(statusBarSize.width, statusBarSize.height)
        let btn = UIButton(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 30.0 - statusBarHeight, width: UIScreen.main.bounds.width, height: 50))
        btn.backgroundColor = .clover
        btn.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        btn.setTitle("Apply", for: .normal)
        return btn
    }()
    
    let rangeSliders : RangeSlider = {
        let rangeSlider = RangeSlider(frame: CGRect.zero)
        rangeSlider.trackTintColor = .lightGray
        rangeSlider.trackHighlightTintColor = .clover
        rangeSlider.thumbTintColor = .white
        rangeSlider.thumbBorderColor = .clover
        rangeSlider.minimumValue = 0.0
        rangeSlider.maximumValue = 10000000.0
        rangeSlider.thumbBorderWidth = 2.0
        rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged(_:)), for: .valueChanged)
        return rangeSlider
    }()
     

    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewMinimumMaximum, rangeSliders])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var stackViewMinimumMaximum: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var stackViewMinimum: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var minimumLabel: UILabel = {
        let label = UILabel()
        label.text = "Minimum Price"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let minimumTextInput: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .no
        textField.font = .systemFont(ofSize: 18)
        textField.textColor = UIColor.darkGray
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
//        textField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var stackViewMaximum: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var maximumLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "Maximum Price"
        return label
    }()
    
    private let maximumTextInput: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .no
        textField.font = .systemFont(ofSize: 18)
        textField.textColor = UIColor.darkGray
        textField.autocorrectionType = UITextAutocorrectionType.no
//        textField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        return textField
    }()
    
        private lazy var stackViewSwitch: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 100, left: 10, bottom: 10, right: 10)
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var switchLabel: UILabel = {
        let label = UILabel()
        label.text = "Whole Sale"
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private let switchDemo : UISwitch = {
    let sw = UISwitch(frame:CGRect(x: 150, y: 300, width: 0, height: 0))
    sw.isOn = true
    sw.setOn(true, animated: true)
    sw.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
    return sw
    }()
    
    private lazy var stackViewSearch: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var searchLabel: UILabel = {
        let label = UILabel()
        label.text = "Search"
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private let searchTextInput: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.font = .systemFont(ofSize: 18)
        textField.textColor = UIColor.darkGray
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        return textField
    }()
    
    private lazy var stackViewCloud: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var cloudLabel: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 50))
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.contentEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        btn.contentHorizontalAlignment = .left
        btn.addTarget(self, action: #selector(openToko), for: .touchUpInside)
        btn.setTitle("Shop Type", for: .normal)
        return btn
    }()
    
    
    
 
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        minimumTextInput.delegate = self
        maximumTextInput.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initialValue()
    }

    
    // MARK: Function setup view
     func setupView() {
        title = "Filter"
        
        view.backgroundColor = UIColor.white
        
        let closeBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(close))
        self.navigationItem.leftBarButtonItem  = closeBarButtonItem
        
        let resetBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(reset))
        self.navigationItem.rightBarButtonItem  = resetBarButtonItem

        let numberOfItemsPerRow: CGFloat = 2.0
        let screenSize: CGRect = UIScreen.main.bounds
        let widthmin = (screenSize.width) / numberOfItemsPerRow
        
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        rangeSliders.frame = CGRect(x: margin, y: margin + topLayoutGuide.length + 150,
        width: width, height: 31.0)
        
        let disclosure = UITableViewCell()
        disclosure.frame = cloudLabel.bounds
        disclosure.accessoryType = .disclosureIndicator
        disclosure.isUserInteractionEnabled = false
        cloudLabel.addSubview(disclosure)
        
        maximumTextInput.delegate = self
        minimumTextInput.delegate = self
        
        stackViewSearch.addArrangedSubview(searchLabel)
        stackViewSearch.addArrangedSubview(searchTextInput)
        
        stackViewCloud.addArrangedSubview(cloudLabel)
        
        stackViewSwitch.addArrangedSubview(switchLabel)
        stackViewSwitch.addArrangedSubview(switchDemo)
        
        stackViewMinimum.addArrangedSubview(minimumLabel)
        stackViewMinimum.addArrangedSubview(minimumTextInput)
        stackViewMinimum.widthAnchor.constraint(equalToConstant: widthmin).isActive = true
        stackViewMaximum.addArrangedSubview(maximumLabel)
        stackViewMaximum.addArrangedSubview(maximumTextInput)
        
        stackViewMaximum.widthAnchor.constraint(equalToConstant: widthmin).isActive = true
        stackViewMinimumMaximum.addArrangedSubview(stackViewMinimum)
        stackViewMinimumMaximum.addArrangedSubview(stackViewMaximum)
        stackView.addArrangedSubview(stackViewMinimumMaximum)
        

        self.view.addSubview(stackView)
        self.view.addSubview(stackViewSwitch)
        self.view.addSubview(rangeSliders)
        self.view.addSubview(stackViewSearch)
        self.view.addSubview(stackViewCloud)
        self.view.addSubview(saringButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: stackViewSwitch.topAnchor).isActive = true
        stackView.isLayoutMarginsRelativeArrangement = true
        
        stackViewSwitch.translatesAutoresizingMaskIntoConstraints = false
        stackViewSwitch.topAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        stackViewSwitch.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackViewSwitch.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        stackViewSwitch.bottomAnchor.constraint(equalTo: stackViewSearch.topAnchor).isActive = true
        stackViewSwitch.isLayoutMarginsRelativeArrangement = true
        
        stackViewSearch.translatesAutoresizingMaskIntoConstraints = false
        stackViewSearch.topAnchor.constraint(equalTo: stackViewSwitch.bottomAnchor).isActive = true
        stackViewSearch.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackViewSearch.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//        stackViewSwitch.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        stackViewSearch.isLayoutMarginsRelativeArrangement = true
        
        stackViewCloud.translatesAutoresizingMaskIntoConstraints = false
        stackViewCloud.topAnchor.constraint(equalTo: stackViewSearch.bottomAnchor).isActive = true
        stackViewCloud.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackViewCloud.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//        stackViewSwitch.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        stackViewCloud.isLayoutMarginsRelativeArrangement = true
        

        saringButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        saringButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        saringButton.topAnchor.constraint(equalTo: stackViewSwitch.bottomAnchor).isActive = true
        saringButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    @objc func close(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func openToko(){
        let vc = TokoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func reset(){
        tagsArray.removeAll()
        
        isWholeSale = false
        switchDemo.setOn(self.isWholeSale, animated: true)
        
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        
        let valueMin = Double("0.0")
        let valueMax = Double("10000000.0")
        
        minimumTextInput.text = formatter.string(from: NSNumber(value: valueMin ?? 0.0))
        maximumTextInput.text = formatter.string(from: NSNumber(value: valueMax ?? 10000000.0))
        
        rangeSliders.lowerValue = 0.0
        rangeSliders.upperValue = 10000000.0
        
        searchquery = "Samsung"
        
        isGoldChecked = false
        isOfficialChecked = false
        createTagCloud(OnView: self.view, withArray: tagsArray as [AnyObject])
    }
    
    @objc func switchValueDidChange(_ sender: UISwitch!) {
        if (sender.isOn == true){
            self.isWholeSale = true
        }
        else{
            self.isWholeSale = false
        }
    }
    
    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        
        minimumTextInput.text = formatter.string(from: NSNumber(value: Int(round(rangeSlider.lowerValue / 500) * 500)))
         
         maximumTextInput.text = formatter.string(from: NSNumber(value: Int(round(rangeSlider.upperValue / 500) * 500)))
    }
    
    
    func createTagCloud(OnView view: UIView, withArray data:[AnyObject]) {

        for tempView in view.subviews {
            if tempView.tag != 0 {
                tempView.removeFromSuperview()
            }
        }
        
        var xPos:CGFloat = 15.0
        var ypos: CGFloat = 410.0
        var tag: Int = 1
        for str in data  {
            let startstring = str as! String
            let width = startstring.widthOfString(usingFont: UIFont(name:"verdana", size: 13.0)!)
            let checkWholeWidth = CGFloat(xPos) + CGFloat(width) + CGFloat(13.0) + CGFloat(25.5 )//13.0 is the width between lable and cross button and 25.5 is cross button width and gap to righht
            if checkWholeWidth > UIScreen.main.bounds.size.width - 30.0 {
                //we are exceeding size need to change xpos
                xPos = 15.0
                ypos = ypos + 29.0 + 8.0
            }
            
            let bgView = UIView(frame: CGRect(x: xPos, y: ypos, width:width + 17.0 + 38.5 , height: 29.0))
            bgView.layer.cornerRadius = 14.5
            bgView.backgroundColor = .clover
            bgView.tag = tag
            
            let textlable = UILabel(frame: CGRect(x: 17.0, y: 0.0, width: width, height: bgView.frame.size.height))
            textlable.font = UIFont(name: "verdana", size: 13.0)
            textlable.text = startstring
            textlable.textColor = UIColor.white
            bgView.addSubview(textlable)
            
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: bgView.frame.size.width - 2.5 - 23.0, y: 3.0, width: 23.0, height: 23.0)
            button.backgroundColor = UIColor.white
            button.layer.cornerRadius = CGFloat(button.frame.size.width)/CGFloat(2.0)
            button.setImage(UIImage(named: "CrossWithoutCircle"), for: .normal)
            button.tag = tag
            button.addTarget(self, action: #selector(removeTag(_:)), for: .touchUpInside)
            bgView.addSubview(button)
            xPos = CGFloat(xPos) + CGFloat(width) + CGFloat(17.0) + CGFloat(43.0)
            view.addSubview(bgView)
            tag = tag  + 1
        }
        
    }
    
    @objc func removeTag(_ sender: AnyObject) {
        let name = self.tagsArray[sender.tag - 1]
        
        if (name.elementsEqual("Official Store")){
           self.isOfficialChecked = false
        }

        if (name.elementsEqual("Gold Merchant"))
        {
            self.isGoldChecked = false
        }
        self.tagsArray.remove(at: (sender.tag - 1))
        createTagCloud(OnView: self.view, withArray: tagsArray as [AnyObject])
    }
    
    
    func initialValue() {
        let q_v = UserDefaults.standard.string(forKey: "q") ?? "Samsung"
        let pmin_v = UserDefaults.standard.string(forKey: "pmin") ?? "0"
        let pmax_v = UserDefaults.standard.string(forKey: "pmax") ?? "10000000"
        let wholesale_v = UserDefaults.standard.bool(forKey: "wholesale")
        let official_v = UserDefaults.standard.bool(forKey: "official")
        let fshop_v = UserDefaults.standard.bool(forKey: "fshop")
        
        
        let valueMin = Double(pmin_v)
        let valueMax = Double(pmax_v)
        
        rangeSliders.lowerValue = valueMin ?? 0.0
        rangeSliders.upperValue = valueMax ?? 0.0

        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        
        minimumTextInput.text = formatter.string(from: NSNumber(value: valueMin ?? 0.0))
        maximumTextInput.text = formatter.string(from: NSNumber(value: valueMax ?? 10000000.0))
        
        //Wholesale Switch
        self.isWholeSale = wholesale_v
        switchDemo.setOn(self.isWholeSale, animated: true)
        
        //Search
        searchquery = q_v
        searchTextInput.text = searchquery
        
        self.isOfficialChecked = official_v
        
        self.isGoldChecked = fshop_v
        
        if (self.isOfficialChecked == true && !self.tagsArray.contains("Official Store")){
            self.tagsArray.append("Official Store")
        }
        
        if (self.isOfficialChecked == false && self.tagsArray.contains("Official Store"))
        {
            self.tagsArray.removeAll { $0 == "Official Store" }
        }
        
        if (self.isGoldChecked == true && !self.tagsArray.contains("Gold Merchant")){
            self.tagsArray.append("Gold Merchant")
        }
        
        if (self.isGoldChecked == false && self.tagsArray.contains("Gold Merchant"))
        {
            self.tagsArray.removeAll { $0 == "Gold Merchant" }
        }
        
        createTagCloud(OnView: self.view, withArray: tagsArray as [AnyObject])
        
    }
    
    @objc func pressed() {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        
        let viewModel = ReactiveSearchListViewModel()
        
        if let numberMin = formatter.number(from: minimumTextInput.text ?? "0.0") {
            let amount = numberMin.decimalValue
            UserDefaults.standard.set(amount, forKey: "pmin")
        }
        
        if let numberMax = formatter.number(from: maximumTextInput.text ?? "10000000.0") {
            let amount = numberMax.decimalValue
            UserDefaults.standard.set(amount, forKey: "pmax")
        }
        
        UserDefaults.standard.set(isWholeSale, forKey: "wholesale")
        
        guard let text = searchTextInput.text, !text.isEmpty else {
            let alert = UIAlertController(title: "Ups", message: "Search must be filled!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        searchquery = text
        
        UserDefaults.standard.set(searchquery, forKey: "q")
        UserDefaults.standard.set(isOfficialChecked, forKey: "official")

        UserDefaults.standard.set(isGoldChecked, forKey: "fshop")
        
        viewModel.start = 0
        viewModel.privateDataSource.value.removeAll()

        let vc = ViewController()
        vc.searchNew()
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        
        navigationController?.popToRootViewController(animated: true)
    }

}


