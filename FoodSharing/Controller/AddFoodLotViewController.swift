import UIKit
import BSImagePicker
import Photos

class AddFoodLotViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let defaultImage = UIImage(systemName: "camera.circle")!
    var foodLotPhotos: [PHAsset] = []
    
    var foodPhotosWithDefaults: [UIImage?] = Array.init(repeating: nil, count: 6)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        collectionView.isUserInteractionEnabled = true
        collectionView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //let tappedImage = tapGestureRecognizer.view as! UIImageView

             let imagePicker = ImagePickerController()
            imagePicker.settings.selection.max = 6
            imagePicker.settings.theme.selectionStyle = .numbered
            imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
            imagePicker.settings.selection.unselectOnReachingMax = true
            
            self.presentImagePicker(imagePicker, select: { (asset) in
            }, deselect: { (asset) in
            }, cancel: { (assets) in
            }, finish: { (assets) in
                
                var imgArr: [UIImage] = []
                assets.forEach { (asset) in
                    imgArr.append(asset.image)
                }
                
                self.foodPhotosWithDefaults.replaceSubrange(Range(0...assets.count - 1), with: imgArr)

                self.foodLotPhotos = assets
                self.collectionView.reloadData()
                
            }, completion: {})
        }
    }
   

extension AddFoodLotViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        foodPhotosWithDefaults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        let foodPhoto = foodPhotosWithDefaults[indexPath.row]

        cell.displayContent(image: foodPhoto ?? defaultImage)
        
        return cell
    }
    
}

extension PHAsset {
    var image : UIImage {
        var thumbnail = UIImage()
        let imageManager = PHCachingImageManager()
        imageManager.requestImage(for: self, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil, resultHandler: { image, _ in
            thumbnail = image!
        })
        return thumbnail
    }
}
