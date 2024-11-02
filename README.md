# Development-of-IoT-enabled-Breathing-sound-Detection-System

![image](https://github.com/user-attachments/assets/000c5019-84e2-41bf-b90e-ac4f735ddd70)

The above figure represents block diagram of the project. 

 1. Detection of Lungs sound: The detection of sound of lungs is done by MEMS based
 INMP441 microphone. The sound is collected by placing the microphone at specific places
 on lung cavity as shown in the block diagram, this is done to get sounds that give accurate
 results while diagnosing in later stages.INMP441 contains inbuilt ADC which converts
 analog signal to digital signal before transmitting .
 2. Processes in the ESP32-WROOM32 microcontroller: The sound detected by ACM is
 fed to the ESP32-WROOM32 micro controller using I2S interface, the micro controller
 has inbuilt wifi module, the audio signal transmitting from INMP441 is directly buffered
 into a http server which is saved as a .wav file.
 3. Post analysis: It includes the process where the .wav file is downloaded from the http
 server and then MATLAB is used to perform the digital signal processing to obtain clean
 lung sound and plot it using inbuilt MATLAB functions.

# Circuit Diagram

![image](https://github.com/user-attachments/assets/1aa84b74-9f72-4f5d-8016-3d4f2c788400)

