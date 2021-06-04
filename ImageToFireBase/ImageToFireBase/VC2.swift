//
//  VC2.swift
//  ImageToFireBase
//
//  Created by abdullah FH  on 21/10/1442 AH.
//

import UIKit
import Firebase
import SDWebImage
import FirebaseFirestore


class VC2: UIViewController {
    
    
    var MyImage : MyObject!
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var ImageView1: UIImageView!
    @IBOutlet weak var ImageView2: UIImageView!
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Button1.layer.cornerRadius = 12
        Button2.layer.cornerRadius = 12
        Button3.layer.cornerRadius = 12
        
    }
    
    @IBAction func DoneButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func AddImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .overFullScreen
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func UploadImage(_ sender: Any) {
        if(ImageView1 != nil){
            Label.text = "يتم الرفع ..."
            Auth.auth().addStateDidChangeListener { Auth, user in
                // let MyimageID : String = self.MyImage?.ID ?? UUID().uuidString
                self.ImageView1.image?.Upload(completion: { IMG in
                    MyObject(ID: user!.uid, ImageURL: IMG).Upload()
                    self.Label.text = "تم الرفع"
                    
                })
            }
            
        }
        
    }
    
    
    @IBAction func DownloadImage(_ sender: Any) {
        
        Label.text = "يتم التحميل ..."
        Auth.auth().addStateDidChangeListener { Auth, user in
            ImageApi.GetImage(ID: user!.uid) { MIG in
                if let str = MIG.ImageURL ,let url = URL(string : str) {
                    self.ImageView2.sd_setImage(with: url, completed: nil)
                    self.ImageView2.contentMode = .scaleAspectFill
                    self.Label.text = "تم التحميل"
                }
                
            }
            
        }
        
    }
    
}
extension VC2: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        ImageView1.contentMode = .scaleAspectFit
        ImageView1.contentMode = UIView.ContentMode.scaleAspectFill
        ImageView1.layer.masksToBounds = true
        ImageView1.image = image
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
}
