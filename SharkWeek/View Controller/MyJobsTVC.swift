import UIKit

class MyJobsTVC: UITableViewController {
    
    @IBOutlet weak var segmentedControlLabel: UISegmentedControl!
    
    var sharedArray: [String] = []
    var jobsArray: [Job] = []
    var currentUser: User?
    
    func segmentAttributes() {
        segmentedControlLabel.layer.cornerRadius = 5.0
        segmentedControlLabel.backgroundColor = .lightGray
        segmentedControlLabel.tintColor = .darkGray
        
        segmentedControlLabel.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if UserController.shared.currentUser == nil{
            let signInAlertController = UIAlertController(title: "Please Sign in to view this content!", message: "A lot of our app isn't very useful if you aren't signed in! Please sign in!", preferredStyle: .alert)
            let signInAction = UIAlertAction(title: "Go There Now!", style: .default) { (action) in
                self.performSegue(withIdentifier: "toSignInVC", sender: self)
            }
            let notNowAction = UIAlertAction(title: "Not Now", style: .cancel)
            signInAlertController.addAction(signInAction)
            signInAlertController.addAction(notNowAction)
            
            self.present(signInAlertController, animated: true, completion: nil)
        }
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
            jobsArray = []
            let dispatchGroup = DispatchGroup()
            
            for jobRef in sharedArray{
                dispatchGroup.enter()
                
                //                dispatchGroup.leave() // Call in the completion of readOneJob()
                JobController.shared.readOneJob(with: jobRef) { (job) in
                    
                    guard let theJob = job else {return}
                    
                    self.jobsArray.append(theJob)
                    dispatchGroup.leave()
                }
                
            }
            
            dispatchGroup.notify(queue: .main) {
                self.tableView.reloadData()
                
            }
            
            tableView.reloadData()
        case 1:
            sharedArray = currentUser.jobsHiredCompleted
            jobsArray = []
            let dispatchGroup = DispatchGroup()
            
            for jobRef in sharedArray{
                dispatchGroup.enter()
                
                //                dispatchGroup.leave() // Call in the completion of readOneJob()
                JobController.shared.readOneJob(with: jobRef) { (job) in
                    
                    guard let theJob = job else {return}
                    
                    self.jobsArray.append(theJob)
                    dispatchGroup.leave()
                }
                
            }
            
            dispatchGroup.notify(queue: .main) {
                self.tableView.reloadData()
                
            }
            
            tableView.reloadData()
        case 2:
            sharedArray = currentUser.jobsApplied
            jobsArray = []
            let dispatchGroup = DispatchGroup()
            
            for jobRef in sharedArray{
                dispatchGroup.enter()
                
                //                dispatchGroup.leave() // Call in the completion of readOneJob()
                JobController.shared.readOneJob(with: jobRef) { (job) in
                    
                    guard let theJob = job else {return}
                    
                    self.jobsArray.append(theJob)
                    dispatchGroup.leave()
                }
                
            }
            
            dispatchGroup.notify(queue: .main) {
                self.tableView.reloadData()
                
            }
            
            tableView.reloadData()
        case 3:
            sharedArray = currentUser.jobsCreated
            jobsArray = []
            let dispatchGroup = DispatchGroup()
            
            for jobRef in sharedArray{
                dispatchGroup.enter()
                
                //                dispatchGroup.leave() // Call in the completion of readOneJob()
                JobController.shared.readOneJob(with: jobRef) { (job) in
                  
                    guard let theJob = job else {return}
              
                    self.jobsArray.append(theJob)
                    dispatchGroup.leave()
                }
                
            }
            
            dispatchGroup.notify(queue: .main) {
                self.tableView.reloadData()
                
            }
        default:
            sharedArray = []
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myJobsCellID", for: indexPath) as? myJobsCell else {return UITableViewCell()}
        let job = jobsArray[indexPath.row]
        cell.myJob = job
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch segmentedControlLabel.selectedSegmentIndex {
        case 0:
            UserController.shared.currentJob = jobsArray[indexPath.row]
            performSegue(withIdentifier: "toDetailVc", sender: sharedArray[indexPath.row])
        //TOOD: Pass data from selected index into various viewcontrollers
        case 1:
            UserController.shared.currentJob = jobsArray[indexPath.row]
            performSegue(withIdentifier: "toDetailVc", sender: sharedArray[indexPath.row])
            
        case 2:
            UserController.shared.currentJob = jobsArray[indexPath.row]
            performSegue(withIdentifier: "toDetailVc", sender: sharedArray[indexPath.row])
            
        case 3:
            UserController.shared.currentJob = jobsArray[indexPath.row]
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
