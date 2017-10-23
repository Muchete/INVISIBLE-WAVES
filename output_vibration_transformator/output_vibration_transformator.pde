/**
 *
 * @topic   Data Visualisation Transformation
 * @author  Aurelian Ammon / Michael Schoenenberger / Daniel Holler
 * @date    10-11-2017
 *
 */

import processing.serial.*;  // Import the Processing Serial Library for communicating with arduino
Serial myPort;               // The used Serial Port

int value = 300;
int counter = 0;
int offset = 250;

BufferedReader reader;
String line;

boolean oscillate = false;
boolean engine = false;

class DataPoint {
    public int time; 
    public float x;  
    public float y;
    public float z;
    public int sound;

    public DataPoint(int time, float x, float y, float z, int sound) {
        this.time = time;
        this.x = x;
        this.y = y;
        this.z = z;
        this.sound = sound;
    }
};

ArrayList<DataPoint> dataSet = new ArrayList<DataPoint>();

void setup()
{
    background(255);
    size(500, 160);
    println(Serial.list()); // Prints the list of serial available devices (Arduino should be on top of the list)
    myPort = new Serial(this, Serial.list()[5], 9600); // Open a new port and connect with Arduino at 9600 baud

    // Explanation keys
    textSize(20);
    fill(0); 
    text("-R- to read Dataset", 10, 30);
    text("-S- to start and stop the Transformation Engine", 10, 60);
    text("-O- to start and stop oscillation", 10, 90);
    text("-c- to center the arms", 10, 120);

    frameRate(5);
}

void readData () {
    // reset dataSet
    dataSet = new ArrayList<DataPoint>();
    println("clear Data Storage");

    // Open the file from the createWriter() example 
    reader = createReader("data_mehrspursession.txt");

    // Read all Data and safe it into the ArrayList
    do {
        try {
            line = reader.readLine();
        } catch (IOException e) {
            e.printStackTrace();
            line = null;
        }
        if (line == null) {
            // Stop reading because of an error or file is empty
            // noLoop();  
        } else {
            String[] pieces = split(line, ",");
            int time = int(pieces[0]);
            float x = float(pieces[1]);
            float y = float(pieces[2]);
            float z = float(pieces[3]);
            int sound = int(pieces[4]);
            dataSet.add(new DataPoint(time, x, y, z, sound));
        }
    } while (line != null);

    println(dataSet.size() + " lines of new data processed");
}

void draw()
{

    if (oscillate)
    {
        write_to_arduino(500, 300, 300, 500);
        delay(500);

        write_to_arduino(300, 500, 500, 300);
        delay(500);

    } else if (engine){
        DataPoint tempData = dataSet.get(counter);
        tempData.z = tempData.z*750-offset;
        tempData.x = (tempData.x+1)*750-offset;
        tempData.y = (tempData.y+1)*750-offset;
        tempData.sound = int(map(tempData.sound, 80, 200, 0, 1000)-offset);

        write_to_arduino(int(tempData.z), int(tempData.x), int(tempData.y), tempData.sound);
        counter = counter + 4;

        if (counter >= dataSet.size()){
            engine = false; 
            counter = 0;
            println("all Data processed!");
        }
    }
}


void write_to_arduino (int one, int two, int three, int four)
{
    myPort.write(str(one));
    myPort.write(",");
    myPort.write(str(two));
    myPort.write(",");
    myPort.write(str(three));
    myPort.write(","); 
    myPort.write(str(four));
    myPort.write(",");
    myPort.write("\n");

    print(str(one));
    print(",");
    print(str(two));
    print(",");
    print(str(three));
    print(","); 
    print(str(four));
    print(",");
    print("\n");
}

void keyPressed() {
    if (key == 'r') {
        oscillate = false;
        readData();

    } else if (key == 's') {
        if (dataSet.size() == 0) {
            println("unable to start transformation engine, please insert data first");
        } else {
            println("transforming data");
            engine =! engine;
        }
    } else if (key == 'o') {
        oscillate = !oscillate;
    } else if (key == 'c') {
        engine = false;
        oscillate = false;
        write_to_arduino(300, 300, 300, 300);
    } else if (keyCode == 38) {
        offset = offset + 10;
        println("offset: "+offset);
    } else if (keyCode == 40) {
        offset = offset-10;
        println("offset: "+offset);
    } else {
        println("keyCode: "+keyCode);
    }
}
