//
//  ExampleViewController.swift
//  ExampleUnitTestiOS
//
//  Created by Hildequias Junior on 06/07/21.
//

import UIKit

class ExampleViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtValidThru: UITextField!
    @IBOutlet weak var txtCvv: UITextField!
    @IBOutlet weak var lblResult: UILabel!
    
    // MARK: Properties
    var viewModel: ExampleViewModel
    
    required init?(coder: NSCoder) {
        viewModel = ExampleViewModel()
        super.init(coder: coder)
    }
    
    // MARK: View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }

    // MARK: IBAction
    @IBAction func encryptAction(_ sender: UIButton) {
        viewModel.cardDataModel = CardDataModel(cardNumber: txtCardNumber.text ?? "",
                                                       validThru: txtValidThru.text ?? "",
                                                       cvv: txtCvv.text ?? "")
        viewModel.beginEncryption()
    }
}

// MARK: ExampleViewModel Delegate
extension ExampleViewController: ExampleViewModelDelegate {
    func show(viewModel: ExampleViewModel, with error: ErrorModel) {
        let alert = UIAlertController(title: error.title,
                                          message: error.message,
                                          preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func show(viewModel: ExampleViewModel, with data: String) {
        lblResult.text = data
    }
}
