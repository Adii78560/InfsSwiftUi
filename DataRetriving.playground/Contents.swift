//: A Cocoa based Playground to present user interface

import AppKit
import PlaygroundSupport
import Cocoa

extension String{
//Get the filename from a String func
func fileName () -> String{
    return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
}
//Get the file extension from a String
func fileExtension() -> String{
    return URL(fileURLWithPath: self).pathExtension
}
}

func readCSV(inputFile: String, separator: String) -> [String]{
    //split the file Name
    let fileExtension = inputFile.fileExtension()
    let fileName  = inputFile.fileName()
    
    //get the file URL
    let fileURL = try! FileManager.default.url (for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil , create: true)
    
    let inputFile = fileURL.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
    
    //get data
    
    do{
        let saveData = try String(contentsOf: inputFile)
        return saveData.components(separatedBy: separator)
    } catch{
        return ["Error file Couldn't be found"]
        
    }
}


var myData = readCSV(inputFile: "FinancialSampleData.csv", separator: ",")

print(myData)
