//
//  UsersVC.swift
//  PictChat
//
//  Created by Francisco on 7/21/17.
//
//

import UIKit
import FirebaseDatabase

class UsersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var users = [User]()
    fileprivate var selectedUsers =  Dictionary<String, User>()
    
    fileprivate var _snapData: Data?
    fileprivate var _videoUrl: NSURL?
    
    var snapData: Data? {
        set {
            _snapData = newValue
        } get {
            return _snapData
        }
    }
    
    var videoUrl: NSURL? {
        set {
            _videoUrl = newValue
        } get {
            return _videoUrl
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        //TODO -  move to the User model class
        DataService.instance.usersReference.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let users = snapshot.value as? Dictionary<String, Any> {
                for (key, value) in users {
                    if let dict = value as? Dictionary<String, Any> {
                        if let profile = dict["profile"] as? Dictionary<String, Any> {
                            if let firstName = profile["firstname"] as? String {
                                let uid = key
                                let user = User(uid: uid, firstName: firstName)
                                self.users.append(user)
                            }
                        }
                    }
                }
            }
            
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        let user = users[indexPath.row]
        cell.updateUI(user: user)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: true)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = user
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: false)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = nil
        
        if selectedUsers.count <= 0 {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    @IBAction func sendSnapButtonPressed(_ sender: UIBarButtonItem) {
        if let url = _videoUrl {
            let videoName = "\(NSUUID().uuidString)\(url)"
            let ref = DataService.instance.videoStorageReference.child(videoName)
            
            _ = ref.putFile(from: url as URL, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print("PF: error uploading video to firebase storage - \(String(describing: error?.localizedDescription))")
                } else {
                    let downloadUrl = metadata?.downloadURL()
                    // save this somewhere
                    self.dismiss(animated: true, completion: nil)
                }
            })
        } else if let snap = _snapData {
            let ref = DataService.instance.imagesStorageReference.child("\(UUID().uuidString).jpg")
            ref.putData(snap, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print("PF: error uploading snapshot - \(String(describing: error?.localizedDescription))")
                } else {
                    let downloadUrl = metadata?.downloadURL()
                    // save this somewhere
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
}
