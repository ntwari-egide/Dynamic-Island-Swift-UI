//
//  ContentView.swift
//  Dynamic Islands
//

import SwiftUI
import ActivityKit
//import Inject

import WidgetKit

struct ContentView: View {
    
    @State var selectedIsland: Island?
    
//    @ObserveInjection var inject
    @StateObject var activityManager = LiveActivityManager()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                Circle()
                    .fill(.pink)
                    .frame(width: 300, height: 300)
                    .padding()
                    .padding(.horizontal)
                
                List {
                    ForEach(Island.allCases) { island in
                        Section {
                            island.overviewView
                                .swipeActions {
                                    Button("Start".uppercased()) {
                                        activityManager.startLiveActivity(island: island)
                                        // This could give you issues with App Review if used on the App Store.
                                        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                                    }
                                    .tint(.pink)
                                    
                                    Button("Stop".uppercased()) {
                                        activityManager.stopLiveActivity(island: island)
                                    }
                                    .tint(.red.opacity(0.7))
                                }
                            .listRowBackground(Color.clear)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        }
                    }
                }
                
            }
            .background(Color.pink)
//            .toolbar(content: { toolbarItems })
            .navigationDestination(for: Island.self) { island in
                island.detailView
            }
            .navigationTitle("Go Call")
//            .onAppear {
//                checkLiveActivities()
//            }
//            .onReceive(Timer.publish(every: 1, on: .main, in: .default).autoconnect()) { input in
//                                   print("TIMER")
//                checkLiveActivities()
//            }
        }
        .statusBarHidden(true)
//        .enableInjection()
    }
    
    
    
    
    func checkLiveActivities() {
        activeIslands = 0
        for activity in Activity<MusicAttributes>.activities {
            let _ = MusicAttributes.ContentState()
            activeIslands += 1
        }
        
        for activity in Activity<AreasAttributes>.activities {
            let _ = AreasAttributes.ContentState()
            activeIslands += 1
        }
        
        for activity in Activity<PhoneAttributes>.activities {
            let _ = PhoneAttributes.ContentState()
            activeIslands += 1
        }
    }
    
    @State var activeIslands: Int = 0
    
    
//    func startLiveActivity(for island: Island) {
//        island.startLiveActivity()
//    }
    
//    func checkActiveActivities() async {
//        for await activity in Activity<SimpleIslandAttributes>.activityUpdates {
//            print("Activity detais: \(activity.attributes)")
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

