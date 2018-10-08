//
//  ViewController.swift
//  mdonatoHW1
//
//  Created by Michael Donato on 4/16/18.
//  Copyright © 2018 Michael Donato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var arrayView: ArrayView!
    @IBOutlet weak var algorithmpicker1: UISegmentedControl!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var nPicker: UISegmentedControl!
    @IBOutlet weak var algorithmpicker2: UISegmentedControl!
    @IBOutlet weak var arrayView2: ArrayView2!
    //thread one and thread two
    let queue = DispatchQueue.global(qos: .userInitiated)
    let queue2 = DispatchQueue.global(qos: .userInitiated)
    
    //function decides what sorting algorithm to run on what graph
    @IBAction func sortPressed(_ sender: Any) {
        if(self.algorithmpicker1.selectedSegmentIndex == 0){
            queue.async{
                self.insertionSort(&self.arrayView.data)
                DispatchQueue.main.async {
                    self.arrayView.setNeedsDisplay()
                }
            }
        }
        if(self.algorithmpicker2.selectedSegmentIndex == 0){
            queue2.async{
                self.insertionSort2(&self.arrayView2.data)
                DispatchQueue.main.async {
                    self.arrayView2.setNeedsDisplay()
                }
            }
        }
        if(self.algorithmpicker1.selectedSegmentIndex == 1){
            queue.async {
                self.selectionSort(&self.arrayView.data)
                DispatchQueue.main.async {
                    self.arrayView.setNeedsDisplay()
                }
            }
        }
        if(self.algorithmpicker2.selectedSegmentIndex == 1){
            queue2.async {
                self.selectionSort2(&self.arrayView2.data)
                DispatchQueue.main.async {
                    self.arrayView2.setNeedsDisplay()
                }
            }
        }
        if(self.algorithmpicker1.selectedSegmentIndex == 2){
            queue.async {
                self.quickSort(&self.arrayView.data, low: 0, high: self.arrayView.data.count-1)
                DispatchQueue.main.async {
                    self.arrayView.setNeedsDisplay()
                }
            }
        }
        if(self.algorithmpicker2.selectedSegmentIndex == 2){
            queue2.async {
                self.quickSort(&self.arrayView2.data, low: 0, high: self.arrayView2.data.count-1)
                DispatchQueue.main.async {
                    self.arrayView2.setNeedsDisplay()
                }
            }
        }
        if(self.algorithmpicker1.selectedSegmentIndex == 3){
            queue.sync {
                self.mergeSort(&self.arrayView.data, start: 0, end: self.arrayView.data.count-1)
                DispatchQueue.main.async{
                    self.arrayView.setNeedsDisplay()
                }
            }
        }
        if(self.algorithmpicker2.selectedSegmentIndex == 3){
            queue2.sync {
                self.mergeSort2(&self.arrayView2.data, start: 0, end: self.arrayView2.data.count-1)
                DispatchQueue.main.async{
                    self.arrayView2.setNeedsDisplay()
                }
            }
        }
    }
    //shuffles the graphs
    @IBAction func shufflePressed(_ sender: Any) {
        queue.async {
            self.shuffle(&self.arrayView.data)
            DispatchQueue.main.async {
                self.arrayView.setNeedsDisplay()
            }
        }
        queue2.async {
            self.shuffle(&self.arrayView2.data)
            DispatchQueue.main.async {
                self.arrayView2.setNeedsDisplay()
            }
        }
    }
    //changes the value of N
    @IBAction func nChanger(_ sender: Any) {
        var N = 16
        if(nPicker.selectedSegmentIndex == 0){
            N = 16
            
        }
        if(nPicker.selectedSegmentIndex == 1){
            N = 32
        }
        if(nPicker.selectedSegmentIndex == 2){
            N = 48
        }
        if(nPicker.selectedSegmentIndex == 3){
            N = 64
        }
        arrayView.data.removeAll()
        arrayView2.data.removeAll()
        for i in 0 ... N{
            arrayView.data.append(i+1)
        }
        for i in 0 ... N{
            arrayView2.data.append(i+1)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let N = 16
        for i in 0 ... N{
            arrayView.data.append(i+1)
        }
        for i in 0 ... N{
            arrayView2.data.append(i+1)
        }
    }
        

        // Do any additional setup after loading the view, typically from a nib.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    let delay: UInt32 = 100_000
    func shuffle(_ a :inout[Int]){
        let N = a.count
         for i in 0 ..< N {
            let r = Int(arc4random_uniform(UInt32(i + 1)))
            a.swapAt(i, r)
            DispatchQueue.main.sync{
                self.arrayView.setNeedsDisplay()
            }
            usleep(delay)
            DispatchQueue.main.sync{
                self.arrayView2.setNeedsDisplay()
            }
            usleep(delay)
        }
    }
    //insertion sort for thread 1
    func insertionSort(_ a:inout[Int]){
        for i in 0 ..< a.count{
            var j = i
            while j > 0 && a[j-1] > a[j] {
                a.swapAt(j-1, j)
                j -= 1
                DispatchQueue.main.sync{
                    self.arrayView.setNeedsDisplay()
                }
                usleep(delay)
            }
        }
    }
    //insertion sort for thread 2
    func insertionSort2(_ a:inout[Int]){
        for i in 0 ..< a.count{
            var j = i
            while j > 0 && a[j-1] > a[j] {
                a.swapAt(j-1, j)
                j -= 1
                DispatchQueue.main.sync{
                    self.arrayView2.setNeedsDisplay()
                }
                usleep(delay)
            }
        }
    }
    //selection sort for thread 1
    func selectionSort(_ a:inout[Int]){
        let N = a.count;
        for i in 0 ..< N{
            var minIdx = i;
            for j in 0 ..< i + 1{
                if (a[j] >= a[minIdx]){
                minIdx = j;
                }
                a.swapAt(i, minIdx)
                DispatchQueue.main.sync{
                    self.arrayView.setNeedsDisplay()
                }
                usleep(delay)
                
            }
        }
    }
    //selection sort for thread 2
    func selectionSort2(_ a:inout[Int]){
        let N = a.count;
        for i in 0 ..< N{
            var minIdx = i;
            for j in 0 ..< i + 1{
                if (a[j] >= a[minIdx]){
                    minIdx = j;
                }
                a.swapAt(i, minIdx)
                DispatchQueue.main.sync{
                    self.arrayView2.setNeedsDisplay()
                }
                usleep(delay)
                
            }
        }
    }
    //quicksort for thread 1
    func quickSort(_ a:inout[Int], low:Int, high:Int){
        if(low >= high){
            return
        }
        let pivotIndex = partition(&a, low: low, high: high)
        quickSort(&a, low: low, high: pivotIndex - 1)
        quickSort(&a, low: pivotIndex + 1, high: high)
        
    }
    
    func partition(_ a: inout [Int], low: Int, high: Int) -> Int {
        var index = low
        for i in low ..< high{
            if a[i] < a[high] {
                a.swapAt(index, i)
                index += 1
                DispatchQueue.main.sync{
                    self.arrayView.setNeedsDisplay()
                }
                DispatchQueue.main.sync{
                    self.arrayView2.setNeedsDisplay()
                }
                usleep(delay)
            }
        }
        a.swapAt(index, high)
        DispatchQueue.main.sync{
            self.arrayView.setNeedsDisplay()
        }
        
        return index
    }
    //quicksort for thread 2
    func quickSort2(_ a:inout[Int], low:Int, high:Int){
        if(low >= high){
            return
        }
        let pivotIndex = partition(&a, low: low, high: high)
        quickSort2(&a, low: low, high: pivotIndex - 1)
        quickSort2(&a, low: pivotIndex + 1, high: high)
        
    }
    func partition2(_ a: inout [Int], low: Int, high: Int) -> Int {
        var index = low
        for i in low ..< high{
            if a[i] < a[high] {
                a.swapAt(index, i)
                index += 1
                DispatchQueue.main.sync{
                    self.arrayView.setNeedsDisplay()
                }
                DispatchQueue.main.sync{
                    self.arrayView2.setNeedsDisplay()
                }
                usleep(delay)
            }
        }
        a.swapAt(index, high)
        DispatchQueue.main.sync{
            self.arrayView.setNeedsDisplay()
        }
        
        return index
    }
    
    
    func merge (_ a: inout [Int], startIndex: Int, middleIndex: Int, endIndex: Int) {
        let lArray = Array(a[startIndex...middleIndex])
        let rArray = Array(a[middleIndex+1...endIndex])
        
        var index = startIndex
        var leftIndex = 0
        var rightIndex = 0
        
        while leftIndex < lArray.count && rightIndex < rArray.count {
            if lArray[leftIndex] < rArray[rightIndex] {
                a[index] = lArray[leftIndex]
                leftIndex += 1
            }
            else {
                a[index] = rArray[rightIndex]
                rightIndex += 1
            }
            index += 1
        }
        
        while leftIndex < lArray.count {
            a[index] = lArray[leftIndex]
            index += 1
            leftIndex += 1
        }
        
        while rightIndex < rArray.count {
            a[index] = rArray[rightIndex]
            index += 1
            rightIndex += 1
            
        }
        
    }
    //mergesort for thread 1
    func mergeSort(_ a: inout [Int], start: Int, end: Int) {
        if start >= end {
            return
        }
        
        let mIndex = (start + end) / 2
        mergeSort(&a, start: start, end: mIndex)
        mergeSort(&a, start: mIndex+1, end: end)
        merge(&a, startIndex: start, middleIndex: mIndex, endIndex: end)
    }
    
    
    func merge2 (_ a: inout [Int], startIndex: Int, middleIndex: Int, endIndex: Int) {
        let lArray = Array(a[startIndex...middleIndex])
        let rArray = Array(a[middleIndex+1...endIndex])
        
        var index = startIndex
        var leftIndex = 0
        var rightIndex = 0
        
        while leftIndex < lArray.count && rightIndex < rArray.count {
            if lArray[leftIndex] < rArray[rightIndex] {
                a[index] = lArray[leftIndex]
                leftIndex += 1
            }
            else {
                a[index] = rArray[rightIndex]
                rightIndex += 1
            }
            index += 1
        }
        
        while leftIndex < lArray.count {
            a[index] = lArray[leftIndex]
            index += 1
            leftIndex += 1
        }
        
        while rightIndex < rArray.count {
            a[index] = rArray[rightIndex]
            index += 1
            rightIndex += 1
            
        }
        
    }
    //mergesort for thread 2
    func mergeSort2(_ a: inout [Int], start: Int, end: Int) {
        if start >= end {
            return
        }
        
        let mIndex = (start + end) / 2
        mergeSort2(&a, start: start, end: mIndex)
        mergeSort2(&a, start: mIndex+1, end: end)
        merge2(&a, startIndex: start, middleIndex: mIndex, endIndex: end)
    }

}
    

