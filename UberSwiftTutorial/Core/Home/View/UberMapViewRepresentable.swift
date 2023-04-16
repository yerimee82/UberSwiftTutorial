//
//  UberMapViewRepresentable.swift
//  UberSwiftTutorial
//
//  Created by 김예림 on 2023/04/12.
//

import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    
    // making mapview
    // UIView 를 생성하고 초기화하여 SwiftUI 에서 사용할 컴포넌트(UIView)를 리턴
    // SwiftUI 의 View 라이프 사이클 동안 "한 번" 호출된다.
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
         
        return mapView
    }
    
    // UIView 업데이트가 필요할 때 호출되는 메소드
    // @Binding 을 이용하여 SwiftUI 데이터가 UIKit 컴포넌트의 데이터로 바인딩 (Read Only)
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        
        
    }
    
    
    // UIKit -> SwiftUI로의 데이터 전달 (= delegate 역할)
    // @Bidning property는 SwiftUI -> UIkit으로의 데이터 전달
    // UIkit의 데이터가 SwiftUI의 데이터로 바인딩 → Binding<> 타입으로 선언된 값을 통해 연결, 해당 커스텀 클래스 컴포넌트 이니셜라이즈 시 프로퍼티로 전달된 값

    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
    
}

extension UberMapViewRepresentable {
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: UberMapViewRepresentable
        
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            parent.mapView.setRegion(region, animated: true)
        }
    }
}
