//
//  fileView.swift
//  CommodusScan
//
//  Created by Ricardo J. Cantarero on 3/18/23.
//  Copyright © 2023 Ricardo J. Cantarero. All rights reserved.
//

import SwiftUI
import UIKit


struct fileView: View {
    
    /*State Variables*/
    
    @State var images: [UIImage] = [] //Intialize empty array of UIImage type
    @State private var showFilePickerView = false //Will determine when screen pops up
    @State var userProject = [Project]()
    
    var body: some View {
        
            ZStack{
                
                richbrown
                
                    VStack{
                    
                        ScrollView{
                            
                                HStack{
                                    
                                    ForEach(images, id: \.self){
                                        image in
                                            Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding()
                                        
                                    }
                                }
                            }
                        
                        Spacer()
                            
                        HStack{
                                
                            Image(systemName: "trash.fill")
                                .frame(height:20)
                                .padding()
                                .onTapGesture {
                                    if(self.images.count > 0){
                                        self.images.popLast()
                                        }
                                    }
                            
                            Spacer()
                                
                            Image(systemName: "plus")
                                .frame(height:20)
                                .padding()
                                .onTapGesture {
                                    self.showFilePickerView.toggle()
                                }
                            
                            Spacer()
                            
                            Image(systemName: "checkmark")
                                .font(.headline)
                                .frame(height:20)
                                .padding()
                                .onTapGesture {
                                    //On click
                                    let alert = UIAlertController(title: "New Project", message: "Enter the name for your new project:", preferredStyle: .alert) //Creates alert, with title and message prompting ProjectName
                                        alert.addTextField() //Allows user to enter ProjectName
                                        alert.addAction(UIAlertAction(title: "Create Project", style: .default){ //Upon clicking enter
                                                               
                                            [ self,  alert] _ in guard let projectName = alert.textFields?[0].text, !projectName.isEmpty else {return} //We create a closure capturing the current view and the current alert, and assigning the value of the textField to projectName, if it is valid, and non-empty.
                                                               
                                            let currentProject = Project(projectName: projectName, projectImages: self.images) //Create a new Project object with current images and project name
                                                               
                                            currentProjects.append(currentProject) //Add current Project to List
                                                               
                                            self.images.removeAll() //clears all images currently
                                        })
                                         alert.addAction(UIAlertAction(title:"Go Back", style: .cancel))
                                         UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
                                        }.disabled(images.isEmpty)
                            }
                        .background(stargoon)
                            .frame(width: UIScreen.main.bounds.width, height: 40, alignment: .bottomTrailing)
                                        
                        }
                    .sheet(isPresented: $showFilePickerView){
                        FilePickerView(images: self.$images)
                        }
        }.navigationBarTitle("Files")
   
                }
            }


        
struct fileView_Previews: PreviewProvider {
    static var previews: some View {
        fileView()
    }
}
