# PhysComp2017
A group project from Aurelian Ammon, Daniel Holler, and Michael Schönenberger during the Physical Computing module in the Bachelor of Interaction Design in Zurich.

![Data Collector and Visualizer](https://user-images.githubusercontent.com/29760709/38198368-d5152296-368c-11e8-94d4-b64f7518dad1.jpg)

[Video](https://vimeo.com/241423111)

## Input Code
The code of our input device is stored the input_measureXYZSOUND folder. 
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
The output device requires two programs, due to difficulties with just one arduino, transmitting to the linux chip and the servo controller. 

We use processing, which sends a string with 4 values to the arduino, that then transforms these values to specific numbers for each servo. 
The processing sketch is stored in the output_vibration_transformator folder, and the arduino file in the output_arduino_receiver folder.

### Using the output device
#### Before running the Processing script
1. Select serial port on line 45
```processing
myPort = new Serial(this, Serial.list()[5], 9600); // Open a new port and connect with Arduino at 9600 baud
```
2. Select dataset on line 64.
```processing
reader = createReader("data_mehrspursession.txt");
```
3. Run the code!

![Image of Processing Interface](https://user-images.githubusercontent.com/29760709/36719036-2fdfb1ae-1ba4-11e8-8d3d-4bf6cb685801.png)

* **R** _Reads the dataset specified in the code._

* **S** _Starts the transformation according to the dataset, previously loaded with key R. By pressing the arrowkeys UP and DOWN, you can change the offset of the arms (for smaller or larger objects)._

* **O** _Is some sort of showcase, where two axis move simultaniously._

* **C** _Opens all the arms to place or remove the petri object._
