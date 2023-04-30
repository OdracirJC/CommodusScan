//
//  ScanView.swift
//  CommodusScan
//
//  Created by Ricardo J. Cantarero on 3/17/23.
//  Copyright © 2023 Ricardo J. Cantarero. All rights reserved.
//

import SwiftUI
import AVFoundation
import UIKit


struct ScanView: View {
    @State private var showImagePicker: Bool = false
    @State private var image: UIImage? = nil

    
    var body: some View {
       
        ZStack{
            
            VStack{
                
                Spacer()
                
                
                
                ZStack{
                    
                    Circle()
                        .fill(richbrown)
                    
                    Circle()
                        .stroke(Color.white, lineWidth: 5)
                }
                .frame(width: 60.0, height: 60.0)
                .padding(.bottom)
                
                
                HStack(alignment: .lastTextBaseline){
                    Image(systemName: "plus")
                        .frame(height:20)
                        
                        .padding()

                    Spacer()
                    Image(systemName: "checkmark")
                        .font(.headline)
                        .frame(height:20)
                        .padding()
                }
            .background(richbrown)
                .frame(width: UIScreen.main.bounds.width, height: 40, alignment: .bottomTrailing)
                            
            }
        }
    }
}
        
struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
