import UIKit

class MyJobsTVC: UITableViewController {
    
    @IBOutlet weak var segmentedControlLabel: UISegmentedControl!
    
    var sharedArray: [String] = []
    var currentUser: User?
    
    
    //    var currentArray: [String] = []
    //    var historyArray: [String] = []
    //    var appliedArray: [String] = []
    //    var postedArray: [String] = []
    
    
    func segmentAttributes() {
        segmentedControlLabel.layer.cornerRadius = 5.0
        segmentedControlLabel.backgroundColor = .lightGray
        segmentedControlLabel.tintColor = .darkGray
        
        segmentedControlLabel.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.currentUser = UserController.shared.currentUser
        guard let currentUser = currentUser else { return }
        
        UserController.shared.readUser(userID: currentUser.uuid) { (error) in
            if let error = error {
                print("Couldn't read user data \(error.localizedDescription)")
            } else {
                print("read user")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentAttributes()
        
        tableView.delegate = self
        
    }
    @IBAction func segmentDidChangeValue(_ sender: Any) {
        guard let currentUser = currentUser else {return}
        switch segmentedControlLabel.selectedSegmentIndex {
        case 0:
            sharedArray = currentUser.jobsInProgress
            tableView.reloadData()
        case 1:
            sharedArray = currentUser.jobsHiredCompleted
            tableView.reloadData()
        case 2:
            sharedArray = currentUser.jobsApplied
            tableView.reloadData()
        case 3:
            sharedArray = currentUser.jobsCreated
            tableView.reloadData()
        default:
            sharedArray = []
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myJobsCellID", for: indexPath) as? myJobsCell else {return UITableViewCell()}
        let jobRef = sharedArray[indexPath.row]
        let readJobs = JobController.shared.readOneJob(with: jobRef)
        cell.myJob = readJobs
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //            if let destinationVC = segue.destination as? AppliedDetailVC {
        //                let currentUser = UserController.shared.currentUser[IndexPath.row]
        //                destinationVC.currentUser = currentUser
        //                return
        //            }
    }
    
}
