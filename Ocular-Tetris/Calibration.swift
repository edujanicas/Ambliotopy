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
        contrast = 1.0
    }
    
    func beginCalibration() {
        var color: BlockColor
        if (badEye == Eye.Left) {
            color = BlockColor.Blue
        }
        else {
            color = BlockColor.Red
        }
        shape = SquareShape(column:4, row:4, color: color, orientation:Orientation.random())
        delegate?.calibrationDidBegin(self)
    }
    
    func endCalibration() {
        delegate?.calibrationDidEnd(self)
    }
    
    func changeBlueContrast() {
        contrast *= 0.9
        delegate?.calibrationWillLevelUp(self)
        shape = SquareShape(column:4, row:4, color:BlockColor.Blue, orientation:Orientation.random())
        delegate?.calibrationDidLevelUp(self)
    }
    
    func changeRedContrast() {
        contrast *= 0.9
        delegate?.calibrationWillLevelUp(self)
        shape = SquareShape(column:4, row:4, color:BlockColor.Red, orientation:Orientation.random())
        delegate?.calibrationDidLevelUp(self)
    }

}