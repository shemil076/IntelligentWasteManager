//
//  DisposalInstructionModel.swift
//  InteligentWasteManager
//
//  Created by PRAMUDITHA KARUNARATHNA on 2024-03-17.
//

import RealmSwift

class WasteDisposalInstruction: Object, Decodable {
    @Persisted var wasteType: String
    @Persisted var instruction: List<String>
    
    
    convenience init(wasteType: String, instruction: List<String>){
        self.init()
        self.wasteType = wasteType
        self.instruction.append(objectsIn: instruction)
    }
}
