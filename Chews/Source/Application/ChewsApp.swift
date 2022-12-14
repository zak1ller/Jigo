//
//  ChewsApp.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/01.
//

import SwiftUI
import IceCream
import Foundation

@main
struct ChewsApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  @State private var syncEngine: SyncEngine?
  
  var body: some Scene {
    WindowGroup {
      TabView {
        HomeView()
          .tabItem {
            Image(systemName: "scribble")
              .renderingMode(.original)
              .foregroundColor(.appPointColor)
            Text("TabBarItemWrite".localized())
          }
          .environmentObject(HomeViewModel())
        HistoryView()
          .tabItem {
            Image(systemName: "clock")
              .foregroundColor(.appPointColor)
            Text("TabBarItemHistory".localized())
          }
          .environmentObject(HistoryViewModel(topics: Topic.get()))
      }
      .tabViewStyle(selectedItemColor: Color.appPointColor)
      .onAppear {
        UINavigationBar.appearance().tintColor = UIColor.white
      }
    }
  }
}

extension View {
  func tabViewStyle(backgroundColor: Color? = nil,
                    itemColor: Color? = nil,
                    selectedItemColor: Color? = nil,
                    badgeColor: Color? = nil) -> some View {
    onAppear {
      let itemAppearance = UITabBarItemAppearance()
      if let uiItemColor = itemColor?.uiColor {
        itemAppearance.normal.iconColor = uiItemColor
        itemAppearance.normal.titleTextAttributes = [
          .foregroundColor: uiItemColor
        ]
      }
      if let uiSelectedItemColor = selectedItemColor?.uiColor {
        itemAppearance.selected.iconColor = uiSelectedItemColor
        itemAppearance.selected.titleTextAttributes = [
          .foregroundColor: uiSelectedItemColor
        ]
      }
      if let uiBadgeColor = badgeColor?.uiColor {
        itemAppearance.normal.badgeBackgroundColor = uiBadgeColor
        itemAppearance.selected.badgeBackgroundColor = uiBadgeColor
      }
      
      let appearance = UITabBarAppearance()
      if let uiBackgroundColor = backgroundColor?.uiColor {
        appearance.backgroundColor = uiBackgroundColor
      }
      
      appearance.stackedLayoutAppearance = itemAppearance
      appearance.inlineLayoutAppearance = itemAppearance
      appearance.compactInlineLayoutAppearance = itemAppearance
      
      UITabBar.appearance().standardAppearance = appearance
      if #available(iOS 15.0, *) {
        UITabBar.appearance().scrollEdgeAppearance = appearance
      }
    }
  }
}
