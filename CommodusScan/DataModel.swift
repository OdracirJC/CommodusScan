//
//  DataModel.swift
//  CommodusScan
//
//  Created by Ricardo J. Cantarero on 3/17/23.
//  Copyright © 2023 Ricardo J. Cantarero. All rights reserved.
//

import UIKit
import SwiftUI
import AVFoundation
import Foundation
import PDFKit

/*View Structs*/
/*******************************************************************************/

struct SettingsView: View{
    
    var body: some View{
        VStack{
            Button(action: {
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                UIApplication.shared.open(settingsUrl) //Open
                }){
                    Image(systemName: "gear")
                        .font(.system(size: 200))
            }
        }.navigationBarTitle("Settings")
    }
}

/*******************************************************************************/

/*******************************************************************************/

//Integrates File Selection with FileView SwiftUI View

struct FilePickerView: UIViewControllerRepresentable{

    /*Struct Properties*/
    
    @Binding var images: [UIImage]                          //List of images accessible by Parent View / FileView
    @Environment(\.presentationMode) var presentationMode   //Used to dismiss this view upon completion of selection
    
    //Function required by Protocol
    //Creates an instance of FilePickerView
    func makeUIViewController(context: Context) ->  UIViewController {
        
        let controller = UIDocumentPickerViewController(documentTypes: ["public.image"], in: .import) //only allows image selection in Files App
        controller.delegate = context.coordinator                                                     //Coordinator delegate
        return controller
        
    }
    
    //Function required by Protocol
    
    func updateUIViewController(_ uiViewController:  UIViewController, context: Context) {}            //View not updated, so emptry
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }                                        //Pass instance to Coordinator init
    
    
    /*Nested Class -- Required by UIViewControllerRepresentable*/
    /*******************************************************************************/
    //Bridge between our custom view and FileView, connects us to the UIDocumentPickerViewController for file selection
    
    class Coordinator: NSObject, UIDocumentPickerDelegate{
        
        let parent: FilePickerView  //Specify parent as encapsulating Struct
        
        init(_ parent: FilePickerView){
            self.parent = parent
        }
        
            func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
                
                for url in urls {
                    
                    if let image = UIImage(contentsOfFile: url.path){
                        parent.images.append(image)     //Add selected image to images array
                    }
                    
                }
                
                parent.presentationMode.wrappedValue.dismiss()              //Kills view
            }
        
    }
    
    /*******************************************************************************/
    
}

/*******************************************************************************/

/*******************************************************************************/

struct LibraryView: UIViewControllerRepresentable {
    
    @Binding var images: [UIImage]

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary               //User Photos Lib
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    /*Nested Coordiantor Class*/
    /*******************************************************************************/
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: LibraryView

        init(_ parent: LibraryView) {
            self.parent = parent
        }
        
        //User picks single image
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.images.append(image)
            }
            picker.dismiss(animated: true) //Kill View
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true) //Allow cancel
        }
    }
    
    /*******************************************************************************/
}

/*******************************************************************************/
/*******************************************************************************/


/*Project Data Structure*/
/*******************************************************************************/

struct Project : Identifiable {
    /*Struct Properties*/
    
    var projectName: String     //Name of Project
    var projectImages: [UIImage] //List of images to be converted
    let id = UUID()             //To allow indexing by view
    var isToggled = false;      //If item has been selected
    let dateCreated =  Date()
    

    
    
    /*Struct Methods*/
    

 /*Format the date as a String */
    
    func formatDate() -> String{
        let format = DateFormatter()
        format.dateFormat = "MM-d-yy H:mm a"  //4-12-2022 02:24
        return format.string(from: self.dateCreated)
    }
    
    /*Maybe create a PDF Data from projectImages */
    func makePDF() -> Data?{
        let pdf_document = PDFDocument()
        for im in projectImages{
            guard let page = PDFPage(image: im) else {continue} //try to make pdf page, else keep going
            pdf_document.insert(page, at: pdf_document.pageCount) //Insert page at newest page
        }
        print("Returning Data Representation of PDF")
        return pdf_document.dataRepresentation()
    }
}
/*******************************************************************************/



/*Helper Function*/
/*******************************************************************************/

//pvc is used to present View that contains options for resulting pdf

func savePDF(pdf_data: Data?, pdf_name: String, pvc: UIViewController) -> some View {
    do {
        
        
        let pdf_file_name = "\(pdf_name).pdf" //make file name with ext
        let dir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) //Open up dir
        let newFileURL = dir.appendingPathComponent(pdf_file_name) //create url or file
        try pdf_data?.write(to: newFileURL, options: .atomic) //write the data to the file in one go
       
            
        let controller = UIDocumentInteractionController(url: newFileURL) //Create controller pointing to new pdf
        controller.presentOptionsMenu(from: pvc.view.bounds, in: pvc.view, animated: true) //Open up the options menu with sensical bounds
        
    
    } catch {
        print("ERROR") //Error if the above couldn't be accomplished
        
    }

    return EmptyView() //To prevent error from WorkshopView, return NULL View.
}
/*******************************************************************************/





