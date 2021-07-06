//
//  ContentView.swift
//  NetworkCall Test
//
//  Created by Artificial-Soft Air on 4/7/21.
//

import SwiftUI
import AlertToast

struct ContentView: View {
    
    @State var userName:String = ""
    @State var userPass:String = ""
    @State private var showToast = false
    @State var loginType = 1
    
    var body: some View {
        ZStack {
            Color(.brown).ignoresSafeArea()
            VStack {
                VStack(spacing:6) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.white))
                        .frame(height: 48)
                        .overlay(
                            TextField("User Name", text: $userName)
                                .padding(.leading, 10)
                                .padding(.trailing, 10))
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.top)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.white))
                        .frame(height: 48)
                        .overlay(
                            SecureField("Password", text: $userPass)
                                .padding(.leading, 10)
                                .padding(.trailing, 10))
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.top)
                }
                //                Button("Login!"){
                //                    LoginApi().callLoginApi(userName, userPass) { tempData in
                //                        print(tempData.mobile)
                //                        if tempData.error == 0 {
                //                            loginType = 0
                //                            showToast.toggle()
                //                        } else {
                //                            loginType = 1
                //                            showToast = false
                //                        }
                //                    }
                //
                //                }.foregroundColor(.white)
                //                .padding().padding(.top, 20)
                
                Button("Login!"){
                    LoginApi().callLoginApi(userName, userPass) { result in
                        switch result{
                        case .success(let tempData):
                            print(tempData.name)
                            showToast.toggle()
                        case .failure(let error):
                            switch error {
                            case .requestFailed:
                                print("Login Failed")
                                showToast = false
                            case .unknown:
                                print("Unknown Failed")
                                showToast = false
                            }
                            
                            
                        }
                    }
                    
                }.foregroundColor(.white)
                .padding().padding(.top, 20)
                
            }
        }.toast(isPresenting: $showToast){
            AlertToast(type: .complete(Color(.green)), title: "Login Success!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
