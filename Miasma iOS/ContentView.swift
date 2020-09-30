//
//  ContentView.swift
//  Miasma iOS
//
//  Created by Darragh Rogan on 30/09/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var stockPrice: Int = 0

       var body: some View {


           List {

               HStack {
                   Text("Stock Price (15 Min. delay)")
                   Spacer()
                   Text("\(stockPrice)")
                       .onAppear() {
                           self.updateStockPrice(stock: "something")
                   }
               }

           }

       }

       private func updateStockPrice(stock: String) {

           DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // sort of URL session task
               DispatchQueue.main.async { // you need to update it in main thread!
                self.stockPrice = wAQIData.data?.aqi ?? 0
               }
           }

       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
