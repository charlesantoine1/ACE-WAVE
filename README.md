Wave data were collected during the ACE cruise http://spi-ace-expedition.ch/ .
This Git project started during he Data jam Days at the EPFL aims at reconstructing the wave characteristics drom the GPS/IMU signal when WaMoS data are not available.

Alberto Alberello alberto.alberello@outlook.com

Antoine Ratouis antoine.ratouis@gmail.com

Charles-Antoine Kuszli c.a.kuszli@gmail.com

#datajamdays #epfl


Brief Data Description:

.- WaMoS wave data are not only available for the entire ACE cruise. The radar is sometimes switched off and wave properties cannot be reconstructed in ice infested seas.
The WaMoS file includes synthetic metocean information and the full 2 dimensional spectrum (90 directions x 64 frequencies)

.- GPS 1hr time series at 1Hz including: Lat, Long, Heave, Roll, Pitch, Heading, etc., as indicated in the header.

A more comprehensive description of the data set is available at

https://data.aad.gov.au/metadata/records/AAS_4434_ACE_GPS

https://data.aad.gov.au/metadata/records/AAS_4434_ACE_WAMOS

where the full data set is stored. A subset of the data is included in this Git repository.


Brief Descriptions of the scripts and methodology:

The aim is to calibrate a transfer function that relates the heave spectrum to the WaMoS wave spectrum and reconstrucyt the wave characteristics.
The enclosed scripts are used to read the files and perform this analysis. This is a work in progress.

The analysis follows this steps:

1.- the WaMoS spectrum is corrected for the doppler effect (forward motion of the ship comparedto the angle of attack of the waves)

2.- the WaMoS spectrum is interated over the directions to obtain a one dimensional wave spectrum

3.- the Spectrum from the Heave motion is computed

4.- the Wamos spectrum and the heave spectrum are paired

5.- the transfer function is estimated

The analysis can be improved to keep in account the other translational and rotational movements of the ship


Ship characteristics:

Name : AKADEMIK TRYOSHNIKOV

IMO Number : 9548536

Length abt 124m

Breath 23m

Summer Depth 8.5m

Summer Displacement abt 165000tons
