//
//  WorkshopView.swift
//  CommodusScan
//
//  Created by Ricardo J. Cantarero on 3/17/23.
//  Copyright © 2023 Ricardo J. Cantarero. All rights reserved.
//

import SwiftUI
import UIKit
import Foundation

struct WorkshopView: View {
    /*Struct init -- ensures good formatting*/
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear;
    }
    
    /*State Vars*/
    
    @State var updateView = UUID() //Assigning a new UUID to this state variable forces reload
    @State var toggleExists = false //No more than one item can be toggled at a time
    
    /*Utility Function*/
    
  func sharePDF(for projectList: [Project], i: Int ){
    guard i < projectList.count else { return }
    
    savePDF(pdf_data: projectList[i].makePDF(),
            pdf_name: projectList[i].projectName,
            pvc: UIApplication.shared.windows.first?.rootViewController ?? UIViewController())
    
    sharePDF(for: projectList, i: i+1)
    
    }


    var body: some View {
        
        ZStack{
            
            Color.gray
            VStack{
                
                Spacer()
                
                VStack{
                    
                    List(currentProjects.indices){idx in

                        HStack{
                            
                            Text(currentProjects[idx].projectName)
                            Text(currentProjects[idx].formatDate())
                            
                            Spacer()
                            Button(action: {
                                if(!self.toggleExists){
                                    currentProjects[idx].isToggled.toggle()
                                    self.toggleExists = true
                                    self.updateView = UUID()
                                }
                            }){
                                
                                Image(systemName: currentProjects[idx].isToggled ? "largecircle.fill.circle" : "circle")
                                    .font(.system(size:25))
                                    .foregroundColor(.blue)
                            }
                            
                        }
                        
                    }.id(self.updateView)
                    .listRowBackground(Color.clear)
                    .onAppear{
                            UITableView.appearance().allowsSelection = false
                    }
                    
                }.frame(minWidth:0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(richbrown)
                .cornerRadius(20)
                .navigationBarTitle("Your Current Projects")
                
                HStack{
                    Button(action: {
                        
                        currentProjects = currentProjects.filter { !$0.isToggled }
                        self.toggleExists = false
                        self.updateView = UUID()
                    }){
                        Image(systemName: "trash")
                            .font(.system(size: 30))
                            .padding()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.sharePDF(for: currentProjects.filter {$0.isToggled}, i: 0)
                        currentProjects = currentProjects.filter { !$0.isToggled }
                        self.toggleExists = false
                        
                        self.updateView = UUID()
                    }){
                        
                        Image(systemName: "arrow.down.doc")
                            .font(.system(size: 30))
                            .padding()
                    }
                }
            }
        }.navigationBarTitle("Your Workshop")
    }
}



struct WorkshopView_Previews: PreviewProvider {
    static var previews: some View {
        WorkshopView()
            .background(stargoon)
    }
}
