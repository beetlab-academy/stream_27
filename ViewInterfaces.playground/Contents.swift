import UIKit

var greeting = "Hello, playground"

let point = CGPoint(x: 1, y: 2)
let size = CGSize(width: 12, height: 13)
let frame = CGRect(origin: point, size: size) //CGRect(x: 1, y: 2, width: 12, height: 23)
frame.origin

let view = UIView()
view.frame = frame
view.frame
view.subviews

let subview = UIView()
subview.frame = frame
view.addSubview(subview)
subview.superview


class RedView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GreenView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green
        
        addSubview(rv)
        addSubview(gv)
        
        NSLayoutConstraint.activate([
            rv.leftAnchor.constraint(equalTo: gv.rightAnchor)
            
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // доступ к фрейму GreenView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



struct State {}
class ViewController: UIViewController {
    init(state: State) {
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(rv)
        view.addSubview(gv)
        
        NSLayoutConstraint.activate([
            view.leftAnchor.constraint(equalTo: rv.leftAnchor),
            view.topAnchor.constraint(equalTo: rv.topAnchor),
            rv.leftAnchor.constraint(equalTo: gv.rightAnchor)
            
        ])

    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

let rv = RedView()
let gv = GreenView()

let superview = UIView()
superview.addSubview(rv)
superview.addSubview(gv)

// AUTOLAYOUT

NSLayoutConstraint(item: rv,
                   attribute: .left,
                   relatedBy: .equal,
                   toItem: gv,
                   attribute: .right,
                   multiplier: 1,
                   constant: 0).isActive = true

/////    left_red = right_green* multiplier + constant \\ isActive

NSLayoutConstraint.activate([
    rv.leftAnchor.constraint(equalTo: gv.rightAnchor)
    
])


