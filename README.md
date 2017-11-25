Purpose:
Retrieve wave characteristics from a GPS/IMU signal when WaMoS wave radar are not available.

Participants: 
Alberto Alberello alberto.alberello@outlook.com
Antoine Ratouis antoine.ratouis@gmail.com
Charles-Antoine Kuszli c.a.kuszli@gmail.com
#datajamdays
#epfl

Data available:
.- WaMoS wave spectra are not only available for the entire ACE cruise. The radar was switched off at some point during the cruise. Furthermore the radar do not provide reliable informations in ice infested seas do to the backscatter of floes.
Wamos file: includes synthetic information on the ship speed/heading and wave metocean conditions. The full 2 dimensional spectrum is available (90 directions x 64 frequencies) 
.- GPS 1hr time series at 1Hz including: Lat, Long, Altitude (Heave), Roll, Pitch, Ship Heading, Ship speed, ... as indicated in the header.

Data not available:
Position of the GPS emitter on the ship.

Proposed Methodology:
Calibrate/Validate a model to reconstruct the wave properties from the GPS/IMU.
We intend to recover characteristics of the sea state and possibly part of the one dimensional wave spectrum (in the frequency space) from the heave signal.
As a first step we correct the wave spectrum for the doppler effect (encounter frequency correction).
We then compute the heave (vertical motion of ship) spectrum.
Finally, we estimate a transfer function (Response Amplitude Operator - RAO) by dividing heave spectrum by the wave spectrum.  

Job Done:
Preconditioning
.- Express the ship motions in ship reference axis. Longitude and Latitude are converted in surge and sway using the ship heading. The ship trajectory is high pass filtered to remove the low frequency components associated to the ship motion on its route. The recovered signal is supposed to contain only the wave induced motions. 
.- The ship is sailing in a particular direction. The wave encounter frequency depends on the relative angle between the wave and the ship. To account for this, the spectrum are shifted in frequency using the wave equation and ship's speed and heading.  
.- Integrate the spectrum over the 90 different directions to obtain a one directional spectrum.
.- Compute heave spectrum.

Job to be Done:
.- Quality control of the data to discard non suitable reference cases.
.- Identify a reliable transfer function/

Ship characteristics:
Name AKADEMIK TRYOSHNIKOV
IMO Number : 9548536
Length abt 124m
Breath 23m
Summer Depth 8.5m
Summer Displacement abt 165000tons
