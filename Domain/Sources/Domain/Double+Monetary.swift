import Foundation

public extension Double {
    
    var monetary: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.decimalSeparator = ","
        numberFormatter.alwaysShowsDecimalSeparator = false
        let isFractionDigitsAvailable = truncatingRemainder(dividingBy: 1) != 0
        numberFormatter.minimumFractionDigits = !isFractionDigitsAvailable
            ? 0
            : 2
        numberFormatter.maximumFractionDigits = 2
        let absoluteNumber = NSNumber(value: fabs(self))
        guard let formattedString = numberFormatter.string(from: absoluteNumber) else {
            return String(self)
        }
        return "$" + formattedString
    }
}
