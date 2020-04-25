# HoneyNebula: Exploration into the Honeyverse

Nathalie Paquin
Yuxian Ren
Elizabeth Poggie

## Abstract

A honeypot is a decoy IT infrastructure that is meant to lure attackers by appearing vulnerable. They come in a variety of different architectures that give attackers different levels of access to the operating system from low interaction to high interaction. Once attacked, information regarding the attack and the attacker is captured by the honeypot. In this project, by leveraging the Google Cloud Platform (GCP) we are able to increase the attack surface through the use of multiple honeypots that span the globe. From this, we can compare the statistics related to attack methods, locations, and the frequency of attacks for a given IP address. This is especially important now as most of the world is working from home, so with this project we can study the attackers behaviour and determine which systems are attacked the most and why.

## Introduction



## Procedure 

We set up multiple Honeypot architectures in their own VM instance within the Google Cloud Platform. Each honeypot was taken from Paralax’s “awesome-honeypots” github repository and from this list, we focused on the T-Pot. This is a multi-honeypot platform that has additional features such as Elasticsearch for retrieving back end information, Kibana for visualizing the attack log information that is necessary to make our observations. The T-pot is based on the network installer Debian which allows multiple honeypot daemons to run on the same network interface. The T-pot is a dockerized environment where each container is a sub category so depending on the protocol the attacker is trying to access, the T-pot routes them to a particular container.

## Results

xxxx

## Discussion

xxxx

## Conclusion

xxx

## References

xxx https://dtag-dev-sec.github.io/mediator/feature/2015/03/17/concept.html

xxx https://github.com/paralax/awesome-honeypots

Akiyoshi, Ryoh, et al. “Detecting Emerging Large-Scale Vulnerability Scanning Activities by Correlating Low-Interaction Honeypots with Darknet.” 2018 IEEE 42nd Annual Computer Software and Applications Conference (COMPSAC), 2018, doi:10.1109/compsac.2018.10314. https://ieeexplore.ieee.org/document/8377942/

Bajtoš, Tomáš, et al. “Virtual Honeypots and Detection of Telnet Botnets.” Proceedings of the Central European Cybersecurity Conference 2018 on - CECC 2018, 2018, doi:10.1145/3277570.3277572. https://www.researchgate.net/publication/328519020_Virtual_honeypots_and_detection_of_telnet_botnets

Deshpande, Hrishikesh Arun. “HoneyMesh: Preventing Distributed Denial of Service Attacks Using Virtualized Honeypots.” International Journal of Engineering Research And, vol. V4, no. 08, 2015, doi:10.17577/ijertv4is080325. https://arxiv.org/pdf/1508.05002.pdf

Kambourakis, Georgios, et al. “The Mirai Botnet and the IoT Zombie Armies.” MILCOM 2017 - 2017 IEEE Military Communications Conference (MILCOM), 2017, doi:10.1109/milcom.2017.8170867. https://ieeexplore.ieee.org/document/8170867/

Lingenfelter, Bryson, et al. “Analyzing Variation Among IoT Botnets Using Medium Interaction Honeypots.” 2020 10th Annual Computing and Communication Workshop and Conference (CCWC), 2020, doi:10.1109/ccwc47524.2020.9031234. https://www.researchgate.net/publication/338297464_Analyzing_Variation_Among_IoT_Botnets_Using_Medium_Interaction_Honeypots

Song, Jungsuk, et al. “Statistical Analysis of Honeypot Data and Building of Kyoto 2006+ Dataset for NIDS Evaluation.” Proceedings of the First Workshop on Building Analysis Datasets and Gathering Experience Returns for Security - BADGERS '11, 2011, doi:10.1145/1978672.1978676. https://dl.acm.org/doi/abs/10.1145/1978672.1978676
