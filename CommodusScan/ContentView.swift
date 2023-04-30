//
//  ContentView.swift
//  CommodusScan
//
//  Created by Ricardo J. Cantarero on 3/17/23.
//  Copyright © 2023 Ricardo J. Cantarero. All rights reserved.
//

import SwiftUI
import UIKit
import Foundation


//App Colors
let  stargoon = Color(red: 0.9 , green: 0.8, blue: 0.65)
let richbrown = Color(red: 0.74, green: 0.60, blue: 0.44)
var currentProjects: [Project] = [] //Global Variable that contains all of the Projects that a user has created

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{
                
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame( minWidth: 0, maxWidth: 200, minHeight: 20, maxHeight: 150)
                
            VStack{
                
                
                Spacer()
                
                
                HStack{
                    
                    NavigationLink(destination: LibraryPickerView()){
                        
                        Text("Photos")
                            .font(.body)
                            .fontWeight(.bold)
                        Image(systemName: "photo")
                        
                        }
                    }
                .frame(minWidth: 0, maxWidth: 200, minHeight: 20, maxHeight: 30)
                .background(stargoon)
                    

               
                    
                HStack{
                    NavigationLink(destination: fileView()){
                        
                        Text("Files")
                            .font(.body)
                            .fontWeight(.bold)
                        Image(systemName: "folder")
                        
                        }
                    }
                    .frame(minWidth: 0, maxWidth: 200, minHeight: 20, maxHeight: 30)
                    .background(stargoon)

                
                
                    HStack{
                        NavigationLink(destination: WorkshopView()){
                            
                            Text("Workshop")
                            .font(.body)
                            .foregroundColor(stargoon)
                            .fontWeight(.bold)
                            Image(systemName: "hammer")
                            
                        }.frame(minWidth: 0, maxWidth: 200, minHeight: 20, maxHeight: 30)
                        .background(Color.gray)
                        
                    } .frame(minWidth: 0, maxWidth: 200, minHeight: 20, maxHeight: 30)
                      .background(Color.gray)
          
                Spacer()
                
            }
            .frame(minWidth:0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(richbrown)
            .cornerRadius(20)
            
            NavigationLink(destination: SettingsView()){
                HStack(alignment: .lastTextBaseline){
                    Spacer();
                    Image(systemName: "gear")
                    .padding(30);
                }
            }
                
            Spacer()
                
        }.background(stargoon
            .scaledToFill()
            .scaleEffect(2))
            .frame(minWidth:0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        }
        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .padding()
    }
}
