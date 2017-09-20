//
//  ViewController.swift
//  03_Map_Pin_Plist
//
//  Created by D7702_10 on 2017. 9. 19..
//  Copyright © 2017년 D7702_10. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,MKMapViewDelegate {
    @IBOutlet weak var myMap: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

            zoomToRegion()
        
            // plist 파일을 경로 찾아서 가져 오기
        let path = Bundle.main.path(forResource: "ViewPoint", ofType: "plist")
        print("path = \(String(describing:path))")
    
            // plist 파일 내용을 가져와서 저장하기.
        let content = NSArray(contentsOfFile: path!)
        print("contents = \(String(describing: content))")
        
        //pin저장
        var annotations = [MKPointAnnotation]()
        myMap.delegate = self
        
        
        if let myitems = content {
            for item in myitems{
                let lat = (item as AnyObject).value(forKey: "lat")
                let long = (item as AnyObject).value(forKey: "long")
                let title = (item as AnyObject).value(forKey: "title")
                let subtitle = (item as AnyObject).value(forKey: "subTitle")
                let annotation = MKPointAnnotation()
                
               // 형 변환
                let myLat = (lat as! NSString).doubleValue
                let myLong = (long as! NSString).doubleValue
                let mytitle = title as! String
                let mysubtitle = subtitle as! String
                
                annotation.coordinate.latitude = myLat
                annotation.coordinate.longitude = myLong
                annotation.title = mytitle
                annotation.subtitle = mysubtitle
            
                //배열에 추가하기
                
                annotations.append(annotation)
                
                
                
                
            }
            
        }   else{
                print("content is nil")
            }
        
                myMap.addAnnotations(annotations)
                myMap.showAnnotations(annotations, animated: true)
        
        }
    
        func zoomToRegion(){
        let center = CLLocationCoordinate2DMake(35.166197, 129.072594)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(center, span)
        myMap.setRegion(region, animated: true)
 
            
    }


    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        let iden = "mypin"
        
        var myMapView = myMap.dequeueReusableAnnotationView(withIdentifier: iden)
       
        if myMapView == nil{
            myMapView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: iden)
            myMapView?.canShowCallout = true
            let leftIconView = UIImageView(frame: CGRect(x:0, y:0, width:53,height:53))
            if annotation.title! == "동의중학교" {
                leftIconView.image = UIImage(named:"poketmon.jpeg")
            }else{
                leftIconView.image = UIImage(named: "33.png")
            }
           
            myMapView?.leftCalloutAccessoryView = leftIconView
            let btn = UIButton(type: .detailDisclosure)
            
            myMapView?.rightCalloutAccessoryView = btn
            myMapView?.tintColor = UIColor.blue
            
        }
        else {
            myMapView?.annotation = annotation
    
    }
        return myMapView
        }

}
