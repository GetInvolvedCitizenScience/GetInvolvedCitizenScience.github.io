
# Air Quality

\textbf{Objective:} Use Arduino as an air quality sensor for either ozone or particulate matter.

\section{Introduction: Air Quality}

Although there are many things that contribute to air quality, two of the most commonly measured pollutants are ozone (O$_3$) and particulate matter (PM), both of which are regulated by the Environmental Protection Agency.  The Georgia Department of Natural Resources even maintains a network of air quality stations that measure these things and stream the data live to the internet (\url{http://www.air.dnr.state.ga.us/amp/}).  The Athens site is located near the intersection of College Station and Barnett Shoals Roads.  In this portion of the class, you'll use Arduino to collect data from either a PM sensor or an ozone sensor.

\subsection{Good Ozone vs. Bad Ozone}
In the upper atmosphere (i.e. the stratosphere), ozone is a naturally occurring gas that blocks high energy ultraviolet (UV) radiation from the Sun.  It's similar to Earth's sunscreen: Without it, we would all be sunburnt and prone to skin cancer!  This is why the ozone hole, caused by destruction of ozone by chlorofluorocarbons (CFCs), was such a big problem.  However, ozone is a powerful oxidant, and attacks most things it comes into contact with.  This can include other gases, containers it's stored in, or human lungs.  Thus, at ground level (i.e. in the troposphere), ozone is a potent pollutant.  Further, ground level ozone is created in large part by human activities, so high levels of ozone can easily by controlled by pollution control strategies.  These things are outlined in Figure \ref{ozone}. In this class, we'll look for qualitative changes in O$_3$ concentration, meaning simply whether it has gone up or down and not what the exact concentration is.

\begin{figure}[h]
\centering
\includegraphics[width = 0.9\textwidth]{Images/CH4/ozone.pdf} 
\caption{Atmospheric ozone.  Public domain image from \url{http://en.wikipedia.org/wiki/Ozone\#mediaviewer/File:Atmospheric_ozone.svg}.}
\label{ozone}	
\end{figure}

\subsection{Particulate Matter}
Particulate matter consists of small liquid and/or solid particles suspended in the air as an aerosol.  PM is typically divided into two classes, both shown in Figure \ref{pm25}: (1) PM$_{10}$ ("PM ten"), defined as any PM less than 10$\mu$m (micrometers) in diameter and (2) PM$_2.5$ ("PM two point five"), which is any PM less than 2.5$\mu$m in diameter.  To put that in perspective, an average human hair is about 50$\mu$m in diameter.  PM$_{10}$ is generally considered to come from natural sources, such as dust storms.  PM$_{2.5}$ on the other hand is commonly anthropogenic (human-causes).  Of the two, PM$_{2.5}$ is most harmful to human health, and can cause respiratory and cardiovascular problems.  In addition to affecting human health and air quality, both types of PM affect climate by scattering and absorbing sunlight.  Particles that scatter sunlight usually result in a cooling effect, while particles that absorb sunlight have a warming effect on the Earth.  In this class, we're just concerned with getting a \textit{qualitative} measure of how much PM there is.  This means we only care about measuring whether the concentration has has gone up or down, rather than what the exact concentration or size distribution is.

\begin{figure}[h]
\centering
\includegraphics[width = 0.5\textwidth]{Images/CH4/epa-pm25.jpg} 
\caption{Size of PM$_{2.5}$.  Image from US EPA via (\url{http://insightshealthassociates.files.wordpress.com/2013/06/pm-2-5-from-epa.jpg})}.
\label{pm25}	
\end{figure}

\section{Measuring Air Quality}

You'll be largely on your own to determine how to connect the sensors and determine the appropriate code to use.  Included at the end of this handout are several documents from the internet that contain helpful information to this regard.  These include the manufacturer's datasheets.

\subsection{O$_3$ Sensor}
The ozone sensor contains a heater (i.e. resistor) made of a special material (tin dioxide, SnO$_2$) whose resistance changes based on the amount of ozone on it.  The ozone concentration can thus be determined by measuring the resistance across the heater.

The datasheet for the ozone sensor says to use a load resistance of $\approx$ 10 k$\Omega$.  In the version of the sensor you're using, this has been built into the circuit board.  You need to read the voltage on the analog out pin of the sensor.  This is essentially the same as you did in Exercise 2 previously in the semester.

\begin{easylist}[enumerate]
\ListProperties(Style1=,Numbers=l,Numbers1=a)
& Connect pins AO (analog out), 5V/$V_{cc}$, and ground to the corresponding pins on the Arduino.
& Use your code from Exercise 2 to measure the voltage from the sensor.
& Your code should look like this:

%\chunk{
%void setup() \{							\\
%\hspace*{10mm}   Serial.begin(9600);		\\
%\}										\\
%\\
%
%void loop() \{		\\
%  \hspace*{10mm} int sensorValue = analogRead(A0);				\\
%  \hspace*{10mm} float voltage = sensorValue * (5.0 / 1023.0);	\\
%  \hspace*{10mm} Serial.println(voltage);						\\
%  \hspace*{10mm} delay(1000);									\\
%\																\\
%}

& If you think the sensor is working, place your fingers near the mesh screen.  Can you feel the warmth from the heating element?  If not, double check your connections.
& Once you've successfully gotten a reading from the sensor, program the Arduino to turn an LED on an off when the voltage reaches a specific value.  Make this value somewhere close to the value currently shown by the sensor so you can see it change.  Use an \inline{if()} statement like you did in Homework 2, but this time include an \inline{else()} clause to turn the light off when the voltage is below the specified value:
  
  %\chunk{
    %if (voltage > 0.5) \{		\\
      %	\hspace*{10mm} digitalWrite(led, HIGH);		\\
      %\}		\\
    %
    %else\{	\\
      %	\hspace*{10mm} digitalWrite(led, LOW);	\\
      %\}
    %}

\end{easylist}

\subsection{PM Sensor}
The PM sensor contains an infrared LED and an infrared photodiode placed at approximately a right angle to each other.  As current is applied to a resistor in the sample chamber, it heats up and creates an updraft that carries particles through the sample chamber by convection.  These particles move between the LED and photodiode and scatter light, thereby changing the amount of light seen by the photodiode.  The circuitry on the PM sensor converts the signal to a high or low pulse, and the signal you need to read is the amount of time the signal is low.  The following site contains some very helpful code to get started.
\\

\noindent \begin{small} \url{http://www.davidholstius.com/wp-content/uploads/2012/05/ShinyeiPPD42NS_SerialOutput1.ino}\end{small}
\\

\begin{easylist}[enumerate]
\ListProperties(Style1=,Numbers=l,Numbers1=a)
& List item.
\end{easylist}

\chapter{Data Logging}

\noindent \textbf{Objective:} Plot data on a computer screen and save data to an SD Card.

\section{Introduction}

So far, you've used Arduino as an interface to sensors that reads and displays numbers on a computer screen.  Usually, it's more desirable to view a plot of the data.  This provides a way to visualize all the data at once and pick out trends.  Most modern scientific instruments provide a graphical display directly on the computer screen in real time, and also provide a way to save the data to a file to graph later with a graphing or data analysis program.  This exercise will walk you through both of those.

\section{Interacting with the Data}

\subsection{Plotting in Real Time}
We've written a program using the programming software LabVIEW that reads data from the serial port (remember Arduino sends data to the serial port) and plots it in real time.  To use it:

\begin{easylist}[enumerate]
\ListProperties(Style1=,Numbers=l,Numbers1=a)
& Go to the "Arduino Exercises" section of the eLC site and download the appropriate program for your sensor.  It will have the naming convention "Arduino\_PlotData\_Sensor".
& Connect your sensor/Arduino to the computer.
& Open the program you downloaded and follow the instruction in the user interface.
\end{easylist}

\subsection{Saving Data to a File}
To save the data to a file, we'll use an SD (Secure Digital) card as portable memory (just like digital cameras) and an SD card \textit{shield} (a pre-made add-on for Arduino).  Writing to a data file is similar to writing to the serial port, and uses the command \inline{fileName.print()} or \inline{fileName.println()}.  You'll need to modify your code to make it work.

\subsubsection{O3 Sensor}
\begin{easylist}[enumerate]
\ListProperties(Style1=,Numbers=l,Numbers1=a)
& At the top of your code (just below the comments), include the necessary \textit{libraries}.  A library is a set of commands that can be accessed by the Arduino program.  Library files have the extension \inline{.h}.

\chunk{\textbf{\#include <SPI.h>  // Serial Peripheral Interface \\
\#include <SD.h>	 // SD card library. \\
\#undef int()		 // change default so stdlib will work \\
\#include <stdlib.h>  // float to string fucntion \\
}}

& Now make sure all of the following variables are defined:

\chunk{
// numReadings * interval = averaging time \\
unsigned long interval = 100; // time between samples in ms\\
int numReadings = 10; // no. readings (samples) to average\\
\\
int o3Pin    = A0;    // analog input for O3 sensor\\
int tempPin  = A1;    // analog input for temperature sensor\\
\textbf{const int CS = 4;     // chip select pin for SD shield\\
}\\
float O3;\\
float temp;\\
int O3Value;\\
int tempValue;\\
\textbf{char tempStr[6];\\
char O3str[8];\\
String header = "Elapsed\_ms, O3\_mV, Temp\_C";\\
String dataString;\\}
}
\newpage
& Write the \inline{setup()} routine.

\chunk{
void setup() \{\\
\\
\textbf{  pinMode(CS, OUTPUT);\\
SD.begin(CS);              // initialize SD card\\
File dataFile = SD.open("datalog.txt", FILE\_WRITE);  // open file for writing\\
if(dataFile) \{\\
\hspace*{10mm}   dataFile.println(header);   // print header to data file\\
\hspace*{10mm}   dataFile.close();           // close the file\\
\}}\\
\\
Serial.begin(9600);        // initialize serial communication at 9600 bits per second\\
\textbf{  Serial.println(header);    // print file header to serial port\\
}\}\\
}
\newpage
& Write the \inline{loop()}.

\chunk{
void loop() \{\\
// sum readings over sampling interval\\
for (int i = 1; i < numReadings; i++) \{\\
\hspace*{10mm}     O3Value += analogRead(o3Pin);\\
\hspace*{10mm}     tempValue += analogRead(tempPin);\\
\hspace*{10mm}     delay(interval);\\
\}\\
\\
// compute avg O3 voltage:\\
O3Value = O3Value / (numReadings);\\
O3 = O3Value * (5000.0 / 1023.0);\\
// compute avg temperature:\\
tempValue = tempValue / numReadings;  \\
temp = tempValue * (5000.0 / 1023.0);           // convert temp bits to mV\\
temp = (temp - 500) / 10;                       // convert temp voltage to degrees C\\
\\
\textbf{  dtostrf(O3, 4, 2, O3str);\\
dtostrf(temp, 3, 1, tempStr);\\
\\
dataString = String(millis()) + ", " + String(O3str) + ", " + String(tempStr);    // place data in single text string;\\
Serial.println(dataString);                     // print to serial port\\
File dataFile = SD.open("datalog.txt", FILE\_WRITE);  // open file for writing\\
if(dataFile) \{\\
\hspace*{10mm}     dataFile.println(dataString);                   // print data to file\\
\hspace*{10mm}     dataFile.close();                               // close the file\\
\}}\\
\}
}

& Make sure the SD card is loaded before trying to log data.
& After several minutes, try reading the data back off of your card using a SD card reader.
\end{easylist}

\subsubsection{PM Sensor}
\begin{easylist}[enumerate]
\ListProperties(Style1=,Numbers=l,Numbers1=a)
& At the top of your code (just below the comments), include the necessary \textit{libraries}.  A library is a set of commands the we want to make accessible during the program.  Library files have the extension \inline{.h}.

\chunk{\textbf{\#include <SPI.h>  // Serial Peripheral Interface \\
\#include <SD.h>	 // SD card library. \\
\#undef int()		 // change default so stdlib will work \\
\#include <stdlib.h>  // float to string fucntion \\
}}

& Now make sure all of the following variables are defined:

\chunk{int shinPin  = 8;           // input pin (digital) \\
int tempPin  = A0;          // input pin for temp sensor (analog) \\
int INTERVAL = 1000;        // sample duration (ms) \\		
float ALPHA  = 0.9;         // controls smoothing \\
\textbf{int CS       = 4;          // SD chip select pin }\\
\\
unsigned long t0;                // time of last data dump \\
unsigned long elapsed;           // time since last data dump (ms) \\
unsigned long acc = 0;               // sum of time spent LOW \\
float raw;                       // fraction of time spent LOW \\
float filtered = 0.0; \\
float temp;\\
int tempValue; \\
\\
\textbf{String header = "Elapsed\_ms, Raw\_percent, Filtered\_percent, Temp\_C"; \\
String dataString;  // character array for float conv. \\
char tempStr[6]; // character array for float conv. \\
char rawStr[9]; // character array for float conv. \\
char filteredStr[9]; // character array for float conv.}
}
\newpage
& Write the \inline{setup()} routine.

\chunk{void setup() \{ \\
pinMode(shinPin, INPUT); \\
\textbf{pinMode(CS, OUTPUT);} \\
\textbf{SD.begin(CS);              // initialize SD card \\
File dataFile = SD.open("datalog.txt", FILE\_WRITE);  // open file for writing \\
if(dataFile) \{ \\
\hspace*{10mm} dataFile.println(header);   // print header to data file \\
\hspace*{10mm} dataFile.close();           // close the file \\
\}} \\
\\
Serial.begin(9600); \\
\textbf{Serial.println(header);    // print file header to serial port }\\
\\
t0 = millis(); \\
\}
}
\newpage
& Finally, write the \inline{loop()} command.

\chunk{void loop() \{\\
acc += pulseIn(shinPin, LOW);\\
elapsed = millis() - t0;\\
if (elapsed > INTERVAL) \{\\
\\
\hspace*{10mm} tempValue = analogRead(tempPin);                    // read temp value (bits)\\
\hspace*{10mm} temp = tempValue * (5000.0 / 1023.0);               // convert temp bits to mV\\
\hspace*{10mm} temp = (temp - 500) / 10;                           // convert temp voltage to degrees C\\
\\
\hspace*{10mm} raw = acc / (elapsed * 10.0);                       // expressed as percentage\\
\hspace*{10mm} filtered = ALPHA * filtered + (1.0 - ALPHA) * raw;  // smooth data\\
\\
\textbf{    \hspace*{10mm} dtostrf(temp, 2, 1, tempStr);\\
\hspace*{10mm} dtostrf(raw, 2, 4, rawStr);\\
\hspace*{10mm} dtostrf(filtered, 2, 4, filteredStr);\\
\hspace*{10mm} dataString = String(millis()) + ", " + String(rawStr) + ", " + \hspace*{10mm} String(filteredStr) + ", " + String(tempStr);\\
\\
\hspace*{10mm} Serial.println(dataString);\\
\\
\hspace*{10mm}  File dataFile = SD.open("datalog.txt", FILE\_WRITE);  // open file \\
\hspace*{10mm} if(dataFile) \{\\
\hspace*{20mm} dataFile.println(dataString);                   // print data to file\\
\hspace*{20mm} dataFile.close();                               // close the file\\
\}\\}
\\
acc = 0;\\
t0 = millis();\\
\}\\
\}
}


& Make sure the SD card is loaded before trying to log data.
& After several minutes, try reading the data back off of your card using a SD card reader.
\end{easylist}

\end{document}