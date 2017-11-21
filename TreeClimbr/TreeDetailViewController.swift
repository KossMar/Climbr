

import UIKit
import CoreLocation
import MapKit

protocol MapFocusDelegate {
    func focusOnTree(location: CLLocationCoordinate2D)
}

class TreeDetailViewController: UIViewController {
    
    @IBOutlet var toMapButton: UIBarButtonItem!
    @IBOutlet weak var basicTreeInfoView: BasicTreeInfoView!
    var tree : Tree!
    var delegate : MapFocusDelegate?
    var rootSourceVC = ViewController()
    var fromMapView : Bool = false
    var distance = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tree = tree {
            basicTreeInfoView.treeNameLabel.text = tree.treeName
            basicTreeInfoView.distanceLabel.text = "\(distanceFromUser()) km"
        }else {
            print("ERROR")
        }
        if (fromMapView) {
            toMapButton.isEnabled = false
            toMapButton.tintColor = UIColor.clear
        }
    }
    
    @IBAction func toMapAction(_ sender: UIBarButtonItem) {
        let treeLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(tree.treeLatitude, tree.treeLongitude)
        self.delegate = rootSourceVC
        self.view.window?.rootViewController?.dismiss(animated: true, completion: {
            self.rootSourceVC.focusOnTree(location: treeLocation)
        })
        
        
    }
    
    @IBAction func dismissDetailAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        fromMapView = false
        self.navigationItem.rightBarButtonItem = self.toMapButton
    }
    
    func distanceFromUser() -> Double {
        let treeLocation = CLLocationCoordinate2DMake(tree.treeLatitude,tree.treeLongitude)
        let currentLocation = rootSourceVC.userCoordinate
        let treePoint = MKMapPointForCoordinate(treeLocation)
        let currentPoint = MKMapPointForCoordinate(currentLocation)
        let distance = (MKMetersBetweenMapPoints(treePoint, currentPoint) / 1000)
        let distanceRound = Double(round(10*distance)/10)
        return distanceRound
    }
    
}
