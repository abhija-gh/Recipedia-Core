//
//  Snackbar.swift
//  Recipedia
//
//  Created by Abhijana Agung Ramanda on 23/11/20.
//

// Credit to https://github.com/Zi0P4tch0/Swift-UI-Views

import SwiftUI

public struct Snackbar: View {
  @Binding var isShowing: Bool
  private let presenting: AnyView
  private let text: Text
  private let actionText: Text?
  private let action: (() -> Void)?
  
  private var isBeingDismissedByAction: Bool {
    actionText != nil && action != nil
  }
  
  @Environment(\.colorScheme) private var colorScheme: ColorScheme
  
  init<Presenting>(isShowing: Binding<Bool>,
                   presenting: Presenting,
                   text: Text,
                   actionText: Text? = nil,
                   action: (() -> Void)? = nil) where Presenting: View {
    
    self._isShowing = isShowing
    self.presenting = AnyView(presenting)
    self.text = text
    self.actionText = actionText
    self.action = action
    
  }
  
  public var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .center) {
        self.presenting
        VStack {
          Spacer()
          if self.isShowing {
            HStack {
              self.text
                .foregroundColor(self.colorScheme == .light ? .white : .black)
              Spacer()
              if self.actionText != nil && self.action != nil {
                self.actionText!
                  .bold()
                  .foregroundColor(self.colorScheme == .light ? .white : .black)
                  .onTapGesture {
                    self.action?()
                    withAnimation {
                      self.isShowing = false
                    }
                  }
              }
            }
            .padding()
            .frame(width: geometry.size.width * 0.9, height: 50)
            .shadow(radius: 3)
            .background(self.colorScheme == .light ?
                          Color.black.opacity(0.8) :
                          Color.white.opacity(0.8)
            )
            .offset(x: 0, y: -20)
            .onAppear {
              guard !self.isBeingDismissedByAction else { return }
              DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                  self.isShowing = false
                }
              }
            }
          }
        }
      }
    }
  }
}

extension View {
  public func snackBar(isShowing: Binding<Bool>,
                       text: Text,
                       actionText: Text? = nil,
                       action: (() -> Void)? = nil) -> some View {
    Snackbar(isShowing: isShowing,
             presenting: self,
             text: text,
             actionText: actionText,
             action: action)
  }
  
}
