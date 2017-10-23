# PhysComp2017

## Input Code
The code of our input device is stored the XXX folder. 
It will generate a data.txt file, looking like this:
```
4435,-0.016,-0.016,0.984,155,
4852,-0.016,-0.016,0.969,155,
5413,0.000,-0.031,1.000,155,
6044,-0.016,-0.016,1.000,155,
6760,-0.016,0.000,0.984,155,
7094,0.016,-0.016,0.969,155,
7681,-0.016,-0.016,1.000,155,
8385,0.000,0.031,0.969,154,
```
Where 4435 are the millis, -0.016 the G force of the X axis, -0.016 the G force of the Y axis, 0.984 the G force of the Z axis and 155 value of the microphone (143 would be complete silence).


## Output Code
The output device requires two programs. We use processing, which sends a string with 4 values to the arduino, which then transforms these values to specific numbers for each servo. 
The processing sketch is stored in the XXX folder, and the arduino file in the XXX folder.

### Using the processing interface
![Image of Processing Interface](https://github.com/Muchete/PhysComp2017/blob/master/processingInterface.png)

* **R** _Reads the dataset specified on line 64_
```processing
// Open the file from the createWriter() example 
reader = createReader("data_mehrspursession.txt");
```
* **S** _Starts the transformation according to the dataset, previously loaded with key R_

* **O** _Is some sort of showcase, where two axis move simultaniously_

* **C** _Opens all the arms to put the petri object inside or to remove it_
