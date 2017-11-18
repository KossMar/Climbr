import UIKit
import Firebase
//import FirebaseAuth


class RegisterClass: NSObject
{
    
    //   static var sharedInstance = RegisterClass()
    
    class func registerMethod(inpName: String, inpEmail: String, inpPassword: String)
    {
        Auth.auth().createUser (withEmail: inpEmail,
                                password: inpPassword)
        { (onlineUser, error) in
            if (error == nil)
            {
                let changeRequest = onlineUser?.createProfileChangeRequest()
                changeRequest?.displayName = inpName
                
                changeRequest?.commitChanges(completion:
                    { (profError) in
                        if ( profError == nil)
                        {
                            
                            // setting local user
                            AppData.sharedInstance.curUser = User(name: onlineUser!.displayName!,
                                                                  email: onlineUser!.email!,
                                                                  uid: onlineUser!.uid);
                            
                            
                            
                            
                            
                            
                            let userDict : [String : String] = ["nameKey": onlineUser!.displayName!,
                                                                "emailKey": onlineUser!.email!,
                                                                "uidKey": onlineUser!.uid]
                            
                            AppData.sharedInstance.usersNode
                                .child(onlineUser!.uid)
                                .setValue(userDict)
                            
                            
                            
                            
                            // add alert to confirm register?
//                            AlertShow.show(inpView: self, titleStr: "Yay!", messageStr: "You're now registered")
                            print("registered!")
                            
                            
                        }
                })
            }
            else
            {
                print("\(error)")
                //                AlertShow.show(inpView: inpView, titleStr: "Error", messageStr: error.debugDescription);
            }
        }
    }
}