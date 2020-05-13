
import UIKit
import FirebaseAuth
class MyPageViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailLabel.text = Auth.auth().currentUser?.email
        favouriteButton.layer.cornerRadius = 5
    }
    
    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        } catch let error {
            let alertController = UIAlertController(title: "Ошибка", message:
                error.localizedDescription, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "ОК", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }

    }
    

}
