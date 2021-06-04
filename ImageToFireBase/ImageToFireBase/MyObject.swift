//
//  MyObject.swift
//  ImageToFireBase
//
//  Created by abdullah FH  on 22/10/1442 AH.
//

import Foundation
import FirebaseFirestore

class MyObject {
    
    var ID : String?
    var ImageURL : String?
    
    init(ID : String, ImageURL : String) {
        self.ID = ID
        self.ImageURL = ImageURL
    }
    
    init(Dictionary : [String : AnyObject]) {
        self.ID = Dictionary["ID"] as? String
        self.ImageURL = Dictionary["ImageURL"] as? String
        
    }
    
    func MakeDictionary()->[String : AnyObject] {
        var D : [String : AnyObject] = [:]
        D["ID"] = self.ID as AnyObject
        D["ImageURL"] = self.ImageURL as AnyObject
        return D
    }
    
    func Upload(){
        guard let id = self.ID else { return }
        Firestore.firestore().collection("Images").document(id).setData(MakeDictionary())
    }
    
    func Remove(){
        guard let id = self.ID else { return }
        Firestore.firestore().collection("Images").document(id).delete()
        
    }
    
    
}


class ImageApi {

    static func GetImage(ID : String, completion : @escaping (_ Image : MyObject)->()){
        Firestore.firestore().collection("Images").document(ID).addSnapshotListener { (Snapshot : DocumentSnapshot?, Error : Error?) in
            if let data = Snapshot?.data() as [String : AnyObject]? {
                let New = MyObject(Dictionary: data)
                completion(New)
            }
        }
    }
    
    static func GetAllImages(completion : @escaping (_ Image : MyObject)->()){
        Firestore.firestore().collection("Images").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    let New = MyObject(Dictionary: data)
                    completion(New)
                }
            }
        }

    }
    
}

