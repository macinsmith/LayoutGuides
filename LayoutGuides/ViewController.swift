//
//  ViewController.swift
//  LayoutGuides
//
//  Created by Stephen Smith on 11/25/19.
//  Copyright © 2019 Zulily. All rights reserved.
//

import UIKit

struct DeviceInfo {
    struct Orientation {
        // indicate current device is in the LandScape orientation
        static var isLandscape: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isLandscape
                    : UIApplication.shared.statusBarOrientation.isLandscape
            }
        }
        // indicate current device is in the Portrait orientation
        static var isPortrait: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isPortrait
                    : UIApplication.shared.statusBarOrientation.isPortrait
            }
        }
    }}

class ViewController: UIViewController {
    var referencesView: UIView!
    var refInsetView: UIView!
    var notesView: UIView!
    var notesInsetView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        referencesView = UIView(frame: .zero)
        referencesView.backgroundColor = .purple
        referencesView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(referencesView)

        refInsetView = UIView(frame: .zero)
        refInsetView.backgroundColor = .lightGray
        refInsetView.translatesAutoresizingMaskIntoConstraints = false
        referencesView.addSubview(refInsetView)


        notesView = UIView(frame: .zero)
        notesView.backgroundColor = .green
        notesView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(notesView)

        notesInsetView = UIView(frame: .zero)
        notesInsetView.backgroundColor = .lightGray
        notesInsetView.translatesAutoresizingMaskIntoConstraints = false
        notesView.addSubview(notesInsetView)

        layoutTheViews()

    }

    func layoutTheViews() {
        if #available(iOS 11, *) {
            print("safeArea = \(view.safeAreaLayoutGuide.layoutFrame)")
            let guide = view.safeAreaLayoutGuide
            let guideSize = guide.layoutFrame.size

            referencesView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
            referencesView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true

            notesView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            notesView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

            if DeviceInfo.Orientation.isPortrait {
                referencesView.heightAnchor.constraint(equalToConstant: guideSize.height * 0.46).isActive = true
                referencesView.widthAnchor.constraint(equalToConstant: guideSize.width).isActive = true

                notesView.heightAnchor.constraint(equalToConstant: guideSize.height * 0.46).isActive = true
                notesView.widthAnchor.constraint(equalToConstant: guideSize.width).isActive = true
            } else {
                referencesView.heightAnchor.constraint(equalToConstant: guideSize.height-50).isActive = true
                referencesView.widthAnchor.constraint(equalToConstant: guideSize.width * 0.5).isActive = true

                notesView.heightAnchor.constraint(equalToConstant: guideSize.height - 50).isActive = true
                notesView.widthAnchor.constraint(equalToConstant: guideSize.width * 0.5).isActive = true
            }


        } else {
            let standardSpacing: CGFloat = 8.0
            referencesView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: standardSpacing).isActive = true
            bottomLayoutGuide.topAnchor.constraint(equalTo: referencesView.bottomAnchor, constant: standardSpacing).isActive = true
        }


        refInsetView.topAnchor.constraint(equalTo: referencesView.topAnchor, constant: 40).isActive = true
        refInsetView.bottomAnchor.constraint(equalTo: referencesView.bottomAnchor, constant: -40).isActive = true
        refInsetView.leadingAnchor.constraint(equalTo: referencesView.leadingAnchor, constant: 40).isActive = true
        refInsetView.trailingAnchor.constraint(equalTo: referencesView.trailingAnchor, constant: -40).isActive = true

        notesInsetView.topAnchor.constraint(equalTo: notesView.topAnchor, constant: 40).isActive = true
        notesInsetView.bottomAnchor.constraint(equalTo: notesView.bottomAnchor, constant: -40).isActive = true
        notesInsetView.leadingAnchor.constraint(equalTo: notesView.leadingAnchor, constant: 40).isActive = true
        notesInsetView.trailingAnchor.constraint(equalTo: notesView.trailingAnchor, constant: -40).isActive = true


//        let background = UIView()
//        background.translatesAutoresizingMaskIntoConstraints = false
//        background.backgroundColor = .red
//        view.addSubview(background)
//
//        let foreground = UIView()
//        foreground.translatesAutoresizingMaskIntoConstraints = false
//        foreground.backgroundColor = .blue
//        view.addSubview(foreground)
//
//        background.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        background.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//
//        foreground.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        foreground.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        foreground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        foreground.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true



    }



}

