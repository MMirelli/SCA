# SCA

In this repository we implement methods for *Side Channel Attacks* using power consumption traces (we mostly consider the ones from [DPAv2](http://www.dpacontest.org/v2/index.php) and [DPAv4.2](http://www.dpacontest.org/v4/index.php) contest).

Our approach consists in using wavelet functions for preprocessing procedures, such as traces **de-noising**, **compressing** or for **pattern recognition**.

As for the actual attacks, we would like to integrate the potential of the aforementioned numerical methods with *Machine Learning* in order to **automate** the process of key recovery. 