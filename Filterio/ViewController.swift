import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let context = CIContext()
    var original: UIImage!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    @IBAction func choosePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            navigationController?.present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func savePhoto() {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, nil, nil, nil)
        
        let alertController = UIAlertController(title: "Filterio", message:
            "Image saved to album!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func applySepia() {
        
        display(filterName: "CISepiaTone")
    }
    
    @IBAction func applyNoir() {
        display(filterName: "CIPhotoEffectNoir")
    }
    
    @IBAction func applyVintage() {
        display(filterName: "CIPhotoEffectProcess")
    }
    
    @IBAction func applyBlur() {
        display(filterName: "CIGaussianBlur")
    }
    
    @IBAction func applyBloom() {
        display(filterName: "CIBloom")
    }
    
    @IBAction func applyInvert() {
        display(filterName: "CIColorInvert")
    }
    
    @IBAction func applyPosterize() {
        display(filterName: "CIColorPosterize")
    }
    
    @IBAction func applyComic() {
        display(filterName: "CIComicEffect")
    }
    
    @IBAction func applySharpen() {
        display(filterName: "CINoiseReduction")
    }
    
    func display(filterName: String) {
        if original == nil {
            return
        }
        let filter = CIFilter(name: filterName)!
        filter.setValue(CIImage(image: original), forKey: kCIInputImageKey)
        let output = filter.outputImage
        imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: (output?.extent)!)!)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            original = image
            navigationController?.dismiss(animated: true, completion: nil)
            saveButton.isEnabled = true
        }
    }
}
