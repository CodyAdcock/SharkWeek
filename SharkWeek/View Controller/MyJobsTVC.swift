
import UIKit

class MyJobsTVC: UITableViewController {
    
    @IBOutlet weak var segmentedControlLabel: UISegmentedControl!
    
    var sharedArray: [String] = []
    var currentUser: User?
    
    @IBAction func segmentedActionButton(_ sender: Any) {
        guard let currentUser = currentUser else {return}
        switch segmentedControlLabel.selectedSegmentIndex {
        case 0:
            sharedArray = currentUser.jobsInProgress
        case 1:
            sharedArray = currentUser.jobsHiredCompleted
        case 2:
            sharedArray = currentUser.jobsApplied
        case 3:
            sharedArray = currentUser.jobsCreated
        default:
            sharedArray = []
        }
    }
    
    
    func segmentAttributes() {
        segmentedControlLabel.layer.cornerRadius = 5.0
        segmentedControlLabel.backgroundColor = .lightGray
        segmentedControlLabel.tintColor = .darkGray

        segmentedControlLabel.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        currentUser = UserController.shared.currentUser
        segmentAttributes()
    
   
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedArray.count
    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myJobsCellID", for: indexPath) as? myJobsCell else {return UITableViewCell()}
        let jobRef = sharedArray[indexPath.row]
        let readJobs = JobController.shared.readOneJob(with: jobRef)
        cell.myJob = readJobs
        return cell
    }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch segmentedControlLabel.selectedSegmentIndex {
        case 0:
            
            print("first segment tapped on")
            
        case 1:
            print("second segment tapped on")
            
        case 2:
            performSegue(withIdentifier: "toDetailVc", sender: sharedArray[indexPath.row])
            
        case 3:
            performSegue(withIdentifier: "toViewJobVC", sender: sharedArray[indexPath.row])
        default:
            sharedArray = []
        }
        
    }
        
        
        
    
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //            if let destinationVC = segue.destination as? AppliedDetailVC {
        //                let currentUser = UserController.shared.currentUser[IndexPath.row]
        //                destinationVC.currentUser = currentUser
        //                return
        //            }
    }
    
}

}
