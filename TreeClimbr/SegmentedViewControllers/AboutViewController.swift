

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var treeDescTextView: UITextView!
    @IBOutlet weak var coordinateLabel: UILabel!
    @IBOutlet weak var addFavouriteButton: UIButton!
    
    var sourceVC = TreeDetailViewController()
    var favouriteState = false

    var tree : Tree? {
        didSet {
            guard let tree = tree else { return }
            treeDescTextView.text = tree.treeDescription
            coordinateLabel.text = "\(tree.treeLatitude), \(tree.treeLongitude)"
      
            getCreatorName()

            for thisTree in AppData.sharedInstance.favouritesArr {
                if tree.treeID == thisTree.treeID {
                    favouriteState = true
                    addFavouriteButton.setTitle("Remove From Favourites", for: .normal)
                    break
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        treeDescTextView.isEditable = false
    }
    
    func getCreatorName() {
        
        let creator = tree?.treeCreator
        AppData.sharedInstance.usersNode
            .child(creator!)
            .observe( .value, with: { (snapshot) in
                
                let value = snapshot.value as? NSDictionary
                
                if (value == nil) {
                    return
                }
                
                let userName = value?["nameKey"] as? String ?? ""
                self.userLabel.text = "\(userName)"
            })
    }
    
    @IBAction func favouriteAction(_ sender: UIButton) {
        guard let tree = tree else {
            print("No tree object!")
            return
        }
        
        if favouriteState == false {
            
            FavouritesManager.saveFavourite(tree: tree) { success in
                tree.treePopularity += 1
                let favourites = String(describing: tree.treePopularity)
                self.sourceVC.basicTreeInfoView.favouritesCountLabel.text = favourites
                SaveTree.updateTree(tree: tree, completion: { success in
                })
                return
            }
            
            favouriteState = true
            addFavouriteButton.setTitle("Remove From Favourites", for: .normal)
        }
        else {
            FavouritesManager.removeFavourite(tree: tree)
            tree.treePopularity -= 1
            let favourites = String(describing: tree.treePopularity)
            self.sourceVC.basicTreeInfoView.favouritesCountLabel.text = favourites
            SaveTree.updateTree(tree: tree, completion: { success in
            })
            favouriteState = false
            addFavouriteButton.setTitle("Add To Favourites", for: .normal)
        }
        FavouritesManager.loadFavourites {trees in
        }
        ReadTrees.read { trees in
        }
        UserTreesManager.loadUserTrees { trees in
        }
    }
}
