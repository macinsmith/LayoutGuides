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
    var mySafeAreaView: UIView!
    var referencesView: UIView!
    var refInsetView: UIView!
    var notesView: UIView!
    var notesInsetView: UIView!
    let navHeight = CGFloat(70)

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let view = self.view else { return }

        print("navigation bar = \(String(describing: navigationController?.navigationBar.frame))")

        let mySafeHeight = self.view.frame.size.height

        let mySafeRect = CGRect(x: view.frame.origin.x, y: navHeight, width: view.frame.size.width, height: mySafeHeight)
        print("view rect=\(view.frame), mySafeRect = \(mySafeRect)")
        mySafeAreaView = UIView(frame: mySafeRect)
        mySafeAreaView.backgroundColor = .brown
        mySafeAreaView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mySafeAreaView)

        referencesView = UIView(frame: .zero)
        referencesView.backgroundColor = .purple
        referencesView.translatesAutoresizingMaskIntoConstraints = false
        mySafeAreaView.addSubview(referencesView)

        refInsetView = UIView(frame: .zero)
        refInsetView.backgroundColor = .lightGray
        refInsetView.translatesAutoresizingMaskIntoConstraints = false
        referencesView.addSubview(refInsetView)


        notesView = UIView(frame: .zero)
        notesView.backgroundColor = .green
        notesView.translatesAutoresizingMaskIntoConstraints = false
        mySafeAreaView.addSubview(notesView)

        notesInsetView = UIView(frame: .zero)
        notesInsetView.backgroundColor = .lightGray
        notesInsetView.translatesAutoresizingMaskIntoConstraints = false
        notesView.addSubview(notesInsetView)


    }



    override func viewWillAppear(_ animated: Bool) {
        layoutTheViews(DeviceInfo.Orientation.isPortrait)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        layoutTheViews(size.height > size.width)
    }

    func layoutTheViews(_ isPortrait:Bool) {
        guard let view = self.view else { return }
        print("will layout for \(isPortrait ? "portrait" : "landscape") orientation")
        view.removeConstraints(view.constraints)
        if #available(iOS 11, *) {
            print("safeArea = \(view.safeAreaLayoutGuide.layoutFrame)")

            mySafeAreaView.topAnchor.constraint(equalTo: view.topAnchor, constant: navHeight).isActive = true
            mySafeAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
            mySafeAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
            mySafeAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true

            referencesView.topAnchor.constraint(equalTo: mySafeAreaView.topAnchor).isActive = true
            referencesView.leftAnchor.constraint(equalTo: mySafeAreaView.leftAnchor).isActive = true

            notesView.bottomAnchor.constraint(equalTo: mySafeAreaView.bottomAnchor).isActive = true
            notesView.rightAnchor.constraint(equalTo: mySafeAreaView.rightAnchor).isActive = true

            if isPortrait {
                referencesView.heightAnchor.constraint(equalTo: mySafeAreaView.heightAnchor, multiplier: 0.5).isActive = true
                referencesView.rightAnchor.constraint(equalTo: mySafeAreaView.rightAnchor).isActive = true

                notesView.heightAnchor.constraint(equalTo: mySafeAreaView.heightAnchor, multiplier: 0.5).isActive = true
                notesView.leftAnchor.constraint(equalTo: mySafeAreaView.leftAnchor).isActive = true
            } else {
                referencesView.bottomAnchor.constraint(equalTo: mySafeAreaView.bottomAnchor).isActive = true
                referencesView.widthAnchor.constraint(equalToConstant: mySafeAreaView.frame.width * 0.5).isActive = true

                notesView.topAnchor.constraint(equalTo: mySafeAreaView.topAnchor).isActive = true
                notesView.widthAnchor.constraint(equalToConstant: mySafeAreaView.frame.width * 0.5).isActive = true
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

        view.setNeedsDisplay()

    }



}

