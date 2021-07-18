import UIKit

var str = "Hello, playground"

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var labelText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = labelText
    }
}

let vc = ViewController()
vc.view.backgroundColor = .red
//vc.label.text = "1234"
