//
//  main2.swift
//  Clima
//
//  Created by Paweł Łąk on 21/05/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

protocol AdvandedLifeSupport
{
    func performCPR()
}

class EmergencyCallHandler
{
    
    var dele: AdvandedLifeSupport?
    
    func medicalEmergency()
    {
        dele?.performCPR()
    }
    
    
    
}

struct Paramedic : AdvandedLifeSupport
{
    
    init(mo: EmergencyCallHandler)
    {
        mo.dele = self;
    }
    
    
    func performCPR() {
    
        
    }
    
}

let emilio = EmergencyCallHandler()
let pete = Paramedic(mo:emilio)


emilio.medicalEmergency()
