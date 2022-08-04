//
//  WriteView.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/01.
//

import Foundation
import SwiftUI

struct WriteView: View {
  @FocusState private var focused: Bool
  @State private var topic = ""
  @State private var errorMessage = ""
  @State private var showingErrorMessage = false
  @State private var showingGoodPointView = false
  
  var body: some View {
    VStack(alignment: .center) {
      topicLabel
      topicTextField
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
        self.focused = true
      })
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        NavigationLink(destination: GoodPointView(topic: topic), isActive: $showingGoodPointView) {
          Button(action: {
            next()
          }) {
            Text("NextButton".localized())
          }
        }
      }
    }
    .alert("AlertTitle".localized(), isPresented: $showingErrorMessage, actions: {
      Button("ConfirmButton".localized(), role: .cancel) {
        showingErrorMessage = false
        focused = true
      }
    }, message: {
      Text(errorMessage)
    })
    .padding(.leading, 16)
    .padding(.trailing, 16)
  }
}

extension WriteView {
  var topicLabel: some View {
    Text("WriteViewTopicTitle".localized())
      .foregroundColor(.appTextColor)
  }
  
  var topicTextField: some View {
    TextField("WriteViewTopicExample".localized(), text: $topic, onCommit: {
      next()
    })
      .focused($focused)
      .typeFieldStyle()
  }
}

extension WriteView {
  func next() {
    if topic.count == 0 {
      errorMessage = "AddViewShortTopicMessage".localized()
      showingErrorMessage = true
    } else if topic.count > 50 {
      errorMessage = "AddViewLongTopicMessage".localized()
      showingErrorMessage = true
    } else {
      showingGoodPointView = true
    }
  }
}