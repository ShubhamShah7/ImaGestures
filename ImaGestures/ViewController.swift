//
//  ViewController.swift
//  ImaGestures
//
//  Created by Shubham Shreemankar on 12/07/21.
//

import UIKit

class ViewController: UIViewController{
    private var flag = 1
    private let imagePicker:UIImagePickerController = {
       let imgPicker = UIImagePickerController()
        imgPicker.allowsEditing = false
        return imgPicker
    }()
    
    private let imageView:UIImageView = {
        let img  = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = UIImage(systemName: "folder.badge.plus")
        return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Image Gesture"
        
        view.addSubview(imageView)
        imagePicker.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImg))
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGes))
        view.addGestureRecognizer(pinchGesture)
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationGes))
        view.addGestureRecognizer(rotationGesture)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
  
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeLeft.direction = .right
        view.addGestureRecognizer(swipeRight)

        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeLeft.direction = .up
        view.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeLeft.direction = .down
        view.addGestureRecognizer(swipeDown)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGes))
        view.addGestureRecognizer(panGesture)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.frame = CGRect(x:20, y:view.safeAreaInsets.top + 100, width: view.width-40, height: 100)
    }
}

extension ViewController {
    @objc private func selectImg(_ gesture: UITapGestureRecognizer)
    {
        if(flag==1)
        {
            print("Helloooo")
            imagePicker.sourceType = .photoLibrary
            DispatchQueue.main.async {
                self.present(self.imagePicker, animated: true)
            }
        } else {
            print("Already Selected")
        }
    }
    
    @objc private func pinchGes(_ gesture:UIPinchGestureRecognizer)
    {
        imageView.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
    }
    @objc private func rotationGes(_ gesture:UIRotationGestureRecognizer)
    {
        imageView.transform = CGAffineTransform(rotationAngle: gesture.rotation)
    }
    @objc private func swipe(_ gesture:UISwipeGestureRecognizer)
    {
        if(gesture.direction == .left)
        {
            UIView.animate(withDuration: 0.5) {
                self.imageView.frame = CGRect(x: self.imageView.frame.origin.x - 40, y:self.imageView.frame.origin.y,width:100, height: 100)
            }
        }
        else if(gesture.direction == .right)
        {
            UIView.animate(withDuration: 0.5) {
                self.imageView.frame = CGRect(x: self.imageView.frame.origin.x + 40, y:self.imageView.frame.origin.y,width:100, height: 100)
            }
        }
        else if(gesture.direction == .up)
        {
            UIView.animate(withDuration: 0.5) {
                self.imageView.frame = CGRect(x: self.imageView.frame.origin.x, y:self.imageView.frame.origin.y-40,width:100, height: 100)
            }
        }
        else if(gesture.direction == .down)
        {
            UIView.animate(withDuration: 0.5) {
                self.imageView.frame = CGRect(x: self.imageView.frame.origin.x, y:self.imageView.frame.origin.y + 40,width:100, height: 100)
            }
        }
        else{
            print("Could not Detect")
        }
    }
    @objc private func panGes(_ gesture:UIPanGestureRecognizer)
    {
        let x = gesture.location(in: view).x
        let y = gesture.location(in: view).y
        imageView.center = CGPoint(x:x, y:y)
    }
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectImg = info[.originalImage] as? UIImage {
            imageView.image = selectImg
        }
        picker.dismiss(animated: true)
        flag = 0
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
