//: Playground - noun: a place where people can play

import UIKit

struct Filter {
    let name: String
    let formula: (UIColor) -> UIColor
    
    func apply(to color: UIColor) -> UIColor {
        return formula(color)
    }
}


class ImageProcessor {
    var filters: [Filter] = []
    
    func applyFilters(to image: UIImage) -> UIImage {
        var filteredImage = image
        
        for filter in filters {
            filteredImage = apply(filter: filter, to: filteredImage)
        }
        
        return filteredImage
    }
    
    private func apply(filter: Filter, to image: UIImage) -> UIImage {
        guard let cgImage = image.cgImage else { return image }
        
        let filterName = filter.name
        let ciImage = CIImage(cgImage: cgImage)
        
        guard let filterEffect = CIFilter(name: filterName) else { return image }
        filterEffect.setValue(ciImage, forKey: kCIInputImageKey)
        
        guard let outputCIImage = filterEffect.outputImage else { return image }
        
        let context = CIContext(options: nil)
        guard let outputCGImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else { return image }
        
        return UIImage(cgImage: outputCGImage)
    }
}


extension Filter {
    static var grayscale: Filter {
        return Filter(name: "CIColorControls", formula: { color in

            let ciColor = CIColor(color: color)
            let grayValue = (ciColor.red + ciColor.green + ciColor.blue) / 3.0
            return UIColor(red: grayValue, green: grayValue, blue: grayValue, alpha: 1.0)
        })
    }
    
    static var sepia: Filter {
        return Filter(name: "CISepiaTone", formula: { color in

            let ciColor = CIColor(color: color)
            return UIColor(red: min(1.0, ciColor.red * 0.393 + ciColor.green * 0.769 + ciColor.blue * 0.189),
                           green: min(1.0, ciColor.red * 0.349 + ciColor.green * 0.686 + ciColor.blue * 0.168),
                           blue: min(1.0, ciColor.red * 0.272 + ciColor.green * 0.534 + ciColor.blue * 0.131),
                           alpha: 1.0)
        })
    }
}


let imageProcessor = ImageProcessor()
imageProcessor.filters = [Filter.grayscale, Filter.sepia]

let originalImage = UIImage(named: "sample.jpg")!
let filteredImage = imageProcessor.applyFilters(to: originalImage)
