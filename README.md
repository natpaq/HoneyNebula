# HoneyNebula: Exploration into the Honeyverse

Nathalie Paquin
Yuxiang Ren
Elizabeth Poggie

## Abstract

A honeypot is a decoy IT infrastructure that is meant to lure attackers by appearing vulnerable, inciting malicious users to attack. Once attacked, information regarding the attack and the attacker is captured by the honeypot. In this project multiple honeypots in numerous different locations were deployed leveraging the Google Cloud Platform (GCP) in order to analyze the data collected by them over an increased attack surface. This allows for the comparison of statistics related to attack methods, locations, and frequency of attacks for given IP addresses and honeypots. This is especially important in current times when most of the world is working remotely. This project allows us to study the behaviour of attackers, to determine which systems are attacked the most and to understand why these systems make the most enticing targets.  

## Introduction

Honeypots come in a variety of different architectures that give attackers different levels of access to the operating system. They are classified as either low interaction, medium interaction or high interaction honeypots. Low interaction honeypots give attackers minimal access to the system's operating system, making their deception more detectable by attackers. They are mainly used to detect known attack types and methods. Higher interaction honeypots give attackers more freedom to interact with the operating system and are thus harder to detect by attackers[7]. Attackers are also much more likely to interact more with higher interaction honeypots for that reason. The information regarding the exact methods an attacker uses to try to gain access on such a system can then be analyzed by whoever deployed the honeypots, making them useful cybersecurity tools.  

In this project, several different honeypot architectures were set up as their own VM instances within the GCP. In order to make the results of this research relevant on a global scale, each honeypot was based in a different location. The different honeypot architectures that were deployed in order to be tested were taken from Paralax’s “awesome-honeypots” GitHub repository[10]. The T-Pot honeypot developed by T-Mobile became the focus for this research, due to the variety of results that emerge from its multi-honeypot platform[9]. This platform has additional features including an ELK stack, which includes Elasticsearch for retrieving back end information, Kibana for visualizing the attack log information that is necessary to make our observations and Logstash in order to log information related to attacks and attackers[9]. The T-Pot is based on the network installer Debian which allows multiple honeypot daemons to run on the same network interface. The T-Pot is a dockerized environment where each honeypot daemon is dockerized and contained in its own environment[6]. This means that depending on the protocol the attacker is trying to access, they will be routed to a particular container by T-Pot.  

## Procedure 

1. Made a GCP account
2. Deployed several different architectures on their own VM instances to find the one that best suited our goals (T-Pot was deemed the best match)
3. Wrote a script to auto-deploy the VMs
4. Deployed several T-Pot instances in different locations around the globe
5. Harvested data  


## Results

In the first part of the project, statistics were compared from honeypots stationed in five different locations: Montréal, São Paulo, Los Angeles, Frankfurt and Tokyo over a twenty-four hour period. Across all of these honeypots, the dionaea honeypot was the most attacked, with the cowrie honeypot being the second most attacked. The honeytrap honeypot was the third most attacked across almost all locations, with the exception being that the honeypot stationed in Montréal had the heralding honeypot as its third most attacked honeypot.

Table y: Top 5 Attacks

 <img src="/data_visualization/by_country/attacks_top5.png" width="2000"/>
 
 Figure y++: Attacks by Country for Different Deployments

 <img src="/data_visualization/by_country/attacks_by_country.png"/>

Most of the attacks on the Heralding honeypot in Montreal occured before 8 am from Bulgaria as seen in Figure x. Activity associated with this time frame are categorized as "Misc activity" in our Suricata Alert histogram in Figure x++. 

Figure x: Montreal Attacks by Country

<img src="/data_visualization/by_country/montreal_attack_by_contry_and_by_hour.png"/>

Figure x++: Suricata Alert Categories

<img src="/data_visualization/by_country/alert_categories.png"/>


The results from p0f in which p0f was able to identify the OS being run on the machines of attackers showed that most of the machines were running Windows 7 or 8. Some repeat attackers across all the different honeypot locations were Petersburg Internet Network ltd., Chinanet and Viettel Corporation. Destination ports that were repeatedly seen to be attacked were 445, 443, 1433 and 8088.

## Discussion

Heralding honeypot is only within the top 5 for Montreal compared to our other locations. This is a low interaction honeypot designed to capture credentials from malicious login attempts over several protocols such as ftp, http/https, telnet, pop3/pop3s, ssh, and smtp [11][12]. The Misc Activity associated with these attacks taken from Figure x++ is large in number, but low severity [citation needed].

Among the predominant Suricata alert categories for each different deployment, the priority (and thus risk level) of the attack types vary (refer to Figure x++). In São Paulo, the most frequent type of alert category seen was the "Attempted Administrator Privilege Gain" alert, which is of the highest Suricata priority level(1) and indicates. The main attack types for Los Angeles, Frankfurt and Tokyo are of a  slightly lower priority level(2). The honeypot that predominantly had attacks of the lowest priority level was Montreal.


## Conclusion

honeypots are cool

## References

[1]Akiyoshi, Ryoh, et al. “Detecting Emerging Large-Scale Vulnerability Scanning Activities by Correlating Low-Interaction Honeypots with Darknet.” 2018 IEEE 42nd Annual Computer Software and Applications Conference (COMPSAC), 2018, doi:10.1109/compsac.2018.10314. https://ieeexplore.ieee.org/document/8377942/

[2]Bajtoš, Tomáš, et al. “Virtual Honeypots and Detection of Telnet Botnets.” Proceedings of the Central European Cybersecurity Conference 2018 on - CECC 2018, 2018, doi:10.1145/3277570.3277572. https://www.researchgate.net/publication/328519020_Virtual_honeypots_and_detection_of_telnet_botnets

[3]Deshpande, Hrishikesh Arun. “HoneyMesh: Preventing Distributed Denial of Service Attacks Using Virtualized Honeypots.” International Journal of Engineering Research And, vol. V4, no. 08, 2015, doi:10.17577/ijertv4is080325. https://arxiv.org/pdf/1508.05002.pdf

[4]Kambourakis, Georgios, et al. “The Mirai Botnet and the IoT Zombie Armies.” MILCOM 2017 - 2017 IEEE Military Communications Conference (MILCOM), 2017, doi:10.1109/milcom.2017.8170867. https://ieeexplore.ieee.org/document/8170867/

[5]Lingenfelter, Bryson, et al. “Analyzing Variation Among IoT Botnets Using Medium Interaction Honeypots.” 2020 10th Annual Computing and Communication Workshop and Conference (CCWC), 2020, doi:10.1109/ccwc47524.2020.9031234. https://www.researchgate.net/publication/338297464_Analyzing_Variation_Among_IoT_Botnets_Using_Medium_Interaction_Honeypots

[6]Ochse, Marco, et al. TPotce, 2020, GitHub repository, https://github.com/dtag-dev-sec/tpotce

[7]Paliwal, Savita. “Honeypot: A Trap for Attackers.” International Journal of Advanced Research in Computer and Communication Engineering, vol. 6, no. 3, Mar. 2017, pp. 842–845., doi:10.17148/ijarcce.2017.63197.

[8]Song, Jungsuk, et al. “Statistical Analysis of Honeypot Data and Building of Kyoto 2006+ Dataset for NIDS Evaluation.” Proceedings of the First Workshop on Building Analysis Datasets and Gathering Experience Returns for Security - BADGERS '11, 2011, doi:10.1145/1978672.1978676. https://dl.acm.org/doi/abs/10.1145/1978672.1978676

[9]xxx https://dtag-dev-sec.github.io/mediator/feature/2015/03/17/concept.html

[10]xxx https://github.com/paralax/awesome-honeypots

[11]xxx http://www.covert.io/adventures-with-heralding-a-credential-grabbing-honeypot/

[12]xxx https://redmine.openinfosecfoundation.org/attachments/1529

[13]xxx https://sectechno.com/heralding-credentials-catching-honeypot/

