//
//  BarChartViewController.swift
//  Ambliotopy
//
//  Created by Eduardo Janicas and Nuno Fernandes on 25/06/16.
//  Copyright © 2016 EN. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {
    
    @IBOutlet weak var barChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let (days, time) = clock.daysPlayed()
        setChart(days, values: time)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        barChartView.noDataTextDescription = "To provide data, you need to play at least once."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i] / 60, xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Minutos jogados")
        let chartData = BarChartData(xVals: dataPoints, dataSet: chartDataSet)
        barChartView.data = chartData
        
        barChartView.descriptionText = ""
        chartDataSet.colors = [UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)]
        barChartView.xAxis.labelPosition = .Bottom
        barChartView.xAxis.labelTextColor = UIColor.whiteColor()
        barChartView.leftAxis.labelTextColor = UIColor.whiteColor()
        barChartView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        let ll = ChartLimitLine(limit: 60.0, label: "Target")
        barChartView.rightAxis.addLimitLine(ll)
    }
    
    @IBAction func saveChart(sender: UIBarButtonItem) {
        barChartView.saveToCameraRoll()
    }
}