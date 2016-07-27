import Foundation

protocol CalibrationDelegate {
    func calibrationDidEnd(calibration: Calibration)
    func calibrationDidBegin(calibration: Calibration)
    func calibrationWillLevelUp(calibration: Calibration)
    func calibrationDidLevelUp(calibration: Calibration)
}

class Calibration {
    
    var blockArray:Array2D<Block>
    var shape:Shape?
    var delegate:CalibrationDelegate?
    
    init() {
        shape = nil
        blockArray = Array2D<Block>(columns: NumColumns, rows: NumRows)
    }
    
    func beginCalibration() {

        shape = SquareShape(column:4, row:4, color:BlockColor.Blue, orientation:Orientation.random())
        delegate?.calibrationDidBegin(self)
    }
    
    func endCalibration() {
        delegate?.calibrationDidEnd(self)
    }
    
    func changeBlueContrast() {
        blueLevel += 1
        delegate?.calibrationWillLevelUp(self)
        shape = SquareShape(column:4, row:4, color:BlockColor.Blue, orientation:Orientation.random())
        delegate?.calibrationDidLevelUp(self)
    }
    
    func changeRedContrast() {
        redLevel += 1
        delegate?.calibrationWillLevelUp(self)
        shape = SquareShape(column:4, row:4, color:BlockColor.Red, orientation:Orientation.random())
        delegate?.calibrationDidLevelUp(self)
    }

}