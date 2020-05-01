# HoneyNebula: Exploration into the Honeyverse

Nathalie Paquin
Yuxiang Ren
Elizabeth Poggie

## Abstract

A honeypot is a decoy IT infrastructure that is meant to lure attackers by appearing vulnerable, inciting malicious users to attack. Once attacked, information regarding the attack and the attacker is captured by the honeypot. In this project, multiple honeypots were deployed on the Google Cloud Platform (GCP) in numerous different locations in order to analyze the data collected by them over an increased attack surface. This allows for the comparison of statistics related to attack methods and frequency of attacks for different deployments in different locations. This is especially important in current times when most of the world is working remotely. This project allows us to study the behaviour of attackers in order to determine which systems are attacked the most and to understand why these systems make the most enticing targets.

## Introduction

Honeypots come in a variety of different architectures that give attackers different levels of access to the operating system. They are classified as either low interaction, medium interaction or high interaction honeypots. Low interaction honeypots give attackers minimal access to the system's operating system, making their deception more detectable by attackers. They are mainly used to detect known attack types and methods. Higher interaction honeypots give attackers more freedom to interact with the operating system and are thus harder to detect by attackers [1]. Attackers are also much more likely to interact with higher interaction honeypots for that reason. The information regarding the exact methods an attacker uses to try to gain access on such a system can then be analyzed by whoever deployed the honeypots, making them useful cybersecurity tools.  
In this project, several different honeypot architectures were set up as their own virtual machine (VM) instances within the GCP. In order to make the results of this research relevant on a global scale, each honeypot was based in a different location. Different honeypot architectures from Paralax’s “awesome-honeypots” GitHub repository [2] were deployed in order to be tested and to determine which honeypots to use for this project. The T-Pot honeypot developed by T-Mobile became the focus for this research, due to the variety of results that emerge from its multi-honeypot platform [3].  
This platform offers additional features including an ELK stack, which includes Elasticsearch for retrieving back end information, Kibana for visualizing the attack log information that is necessary to make observations and Logstash in order to log information related to attacks and attackers [3]. The T-Pot is based on the network installer Debian which allows multiple honeypot daemons to run on the same network interface. The T-Pot is a dockerized environment where each honeypot daemon runs in its own container [3]. This means that depending on the protocol the attacker is trying to access, they will be routed to a particular container by T-Pot.  
T-Pot uses Suricata for monitoring malicious activity. When one of the existing Suricata rules are matched, the information regarding the attack that caused the match is logged [4]. Kibana is then used to visualize the data that is logged. T-Pot also uses p0f as a fingerprinting tool to identify what type of operating system is being run on the computers of attackers [5].

## Procedure 

1. Made a GCP account
2. Deployed several different architectures on their own VM instances to find the one that best suited our goals (T-Pot was deemed the best match)
3. Wrote a script to auto-deploy the VMs
4. (Part 1) Deployed several T-Pot instances in different locations around the globe to harvest location specific data
5. (Part 2) Deployed a “HoneyCore” VM instance to aggregate all of the data from different VM instances than part 1 into one central instance to harvest data to represent a global scale
6. Harvested both local and global data from Kibana for both parts of the project


## Results

In the first part of the project, statistics were compared from honeypots stationed in five different locations: Montréal, São Paulo, Los Angeles, Frankfurt and Tokyo over a twenty-four hour period. Across all of these honeypots, the dionaea honeypot was the most attacked, with the cowrie honeypot being the second most attacked. The honeytrap honeypot was the third most attacked across almost all locations, with the exception being that the honeypot stationed in Montréal had the heralding honeypot as its third most attacked honeypot (see Figure 1).


 <img src="/data_visualization/by_country/attacks_top5.png" width="2000"/>
 
Figure 1: Top 5 Most Attacked Honeypots Per Deployment  

Most of the attacks on the Heralding honeypot in Montreal occurred before 8 AM and originated from Bulgaria, as seen in Figure 3. 

<img src="/data_visualization/by_country/alert_categories.png"/>

Figure 2: Top 3 Suricata Alert Categories Per Deployment  

<img src="/data_visualization/by_country/montreal_attacks_by_country.png"/>

Figure 3: Targeted Honeypots and Attacks by Country for Montreal  

The results from p0f in which p0f was able to identify the operating system being run on the machines of attackers showed that most of the machines were running Windows 7 or 8. Destination ports that were repeatedly seen to be attacked were 445, 443, 1433 and 8088. The main reputation that most of the source IP addresses had was “known attacker”, for all of the deployments (see Figure 4 for an example).

--Figure 4 --

In the second part of the project, the data from even more VM instances (different from those in part one) was aggregated into one core instance, HoneyCore. The individual instances were situated in Taiwan, Tokyo, Sydney, Frankfurt, Zürich, Montréal, Iowa and Salt Lake City.  

The main honeypots attacked over these aggregated instances were the same as in the first part of the project: dionaea, cowrie, honeytrap, rdpy and heralding, which was also one of the top five attacked honeypots in São Paulo in the first part (see Figure 5). The total number of attacks recorded on the HoneyCore deployment over a 24 hour window amounted to more than 1.3 million attacks.  

--Figure 5 --

Most of the attacks over the 24 hour period came from Ireland, with Russia being the source with the next highest number of attacks, followed by Vietnam, Indonesia and Brazil (see Figure 6).

--Figure 6 --

There were two major attack periods over 24 hours, in which Suricata alert categories of the type “Attempted User Privilege Gain” spiked. 386,333 attacks of this nature occurred at 21:30 and 443,932 attacks of that same type took place at 00:30 (as seen in Figure 7).  

--Figure 7 --

As seen in the first part of the project, most of the machines that attacked the HoneyCore instance were running Windows 7 or 8, when identifiable by p0f. Among the primary destination ports attacked, the ports 445 and 443 were the ports which were frequently attacked in both the instances from the first part of the project as well as the HoneyCore in the second part. 

 


## Discussion

The honeypot found to have the most attacks across both the first and second parts of the project was the dionaea honeypot. Dionaea is a malware honeypot, employed in order to collect information on malware that exploits system vulnerabilities [6]. For this honeypot, the Samba (smbd) and mssqld protocols were exploited the most.  

Sambda (smbd) allows attackers to perform man-in-the-middle and denial-of-service attacks [7]. Public Safety Canada noted this vulnerability in 2016 and encouraged system administrators to go look at Samba Security Releases, where all versions of Samba are listed alongside the security concerns associated with each version [8]. The port that this protocol exploits is 445 which is also consistent with our findings [9].   

In a 2005 article from Microsoft, it was announced that the mssqld protocol was vulnerable to remote code execution [10]. This protocol allows for bots to perform memory corruption to systems via SQL injection [10][11]. This is a code injection technique that allows attackers to spoof identity, tamper with personal user data, and manipulate transactions within a system [12]. Sometimes an attacker can obtain a consistent back-door to a system for a long period of time if not caught.  

Cowrie was the second most attacked honeypot in both parts of the project. Because cowrie is a medium-high interaction honeypot, it is able to log an attacker’s commands, since it enables attackers to interact more with its system. The most frequently used command across the cowrie honeypots by attackers was the “system” command. This as well as several of the other most common commands seen  (see Figure 8) shows that attackers were trying to get information about the honeypot’s operating system and were trying to execute commands. The second most commonly used command was a command used to verify whether a bot (in this case an fbot) has successfully infiltrated the target device [13], confirming that a large number of the attacks were launched from bots.  

--Figure 8 --

The heralding honeypot was only ranked as one of the top 5 attacked honeypots for our Montreal T-Pot deployment, but none of the others (refer to Figure 1). These attacks occurred around 8:00 EST which translates to mid-afternoon in Bulgarian time. For our core deployment, the Heralding honeypot is also within the top five most attacked honeypots, as seen in Figure 6. This is a low interaction honeypot designed to capture malicious login attempts over several protocols such as ftp, http/https, telnet, pop3/pop3s, ssh, and smtp [14]. Malicious login attempts are associated with credential stuffing attacks where botnets attempt to steal a user’s identity in order to collect information, money or goods. According to a 2018 article, it was noted that these types of attacks were on the rise so it is likely to see even more Heralding attacks for our Montreal VM and our core deployment in the future [15].  
A key difference between the separate instances in the first part of the project and the HoneyCore deployment in the second part is the volume of attacks on the Heralding honeypot. For the HoneyCore, there were small yet consistent attacks with minimal spiking over the 24 hour period (see Figure 6), whereas in Montreal there was only one high volume attack spike in the morning (refer to Figure 3). This suggests that there were two different methods of credential stuffing used by botnets. Further investigation would be required to see if there were more than two methods of credential stuffing attacks being used.  
The priority (and thus risk level) of the attack types among the predominant Suricata alert categories observed for each different deployment vary (refer to Figure 2). In the São Paulo deployment the most frequent type of alert category seen was the "Attempted Administrator Privilege Gain" alert. It is of the highest Suricata priority level, which is a priority of 1. The main attack types for Los Angeles, Frankfurt and Tokyo are of a slightly lower priority level. The honeypot that predominantly had attacks of the lowest priority level was Montreal [16].  
Most of the source IP addresses involved in the attacks were reputed as being “known attackers”. This is likely because, of the assortment of honeypots contained in the T-Pot, most are low interaction honeypots. These honeypots are less likely to be extensively interacted with because of the limited access they offer to attackers. This restricted access makes them more easily identifiable as a honeypot and less convincing as a real IT infrastructure.   
By being labeled as a “known attacker” this means that the IP address in question has been reported for malicious activities before and could be a spammer or botnet. This explains why, despite the low interactivity of the majority of the honeypots deployed, there were numerous attacks from these known attackers. A botnet would not be set up in such a way that it would fingerprint [17] a target IP and then stop attacking if it found the host to be an unviable target (such as a low interaction honeypot). If it were set up that way, it would risk missing out on a future potential victim since the honeypot infrastructure might eventually get replaced by an actual IT infrastructure. For this reason, it is safer for many of these known attackers to hit all potential victims and to not discriminate by fingerprinting in order to maximize their chances of a potential hit.  


## Conclusion

The abundance of data harvested from Kibana offered a glimpse into which honeypots were being attacked the most and allowed for explorations into why such was the case. The dionaea and heralding honeypots offer attackers different vulnerabilities to exploit but as can be seen through the data obtained, the intent of the attack is the same. In both cases, the end goal for the attacker is to perform malicious login attempts to obtain private user information and to gain access to a computer system. This highlights how drastically different system vulnerabilities can result in the same security breaches.  

Overall there were more than 1.3 million attacks over a 24 hour period in our core deployment alone. This demonstrates how many attacks take place daily on a global scale as well as the importance of patching up security vulnerabilities so that they cannot be exploited. The arsenal of tools for attackers is expected to diversify more over time as the security measures taken by users intensify. Honeypots are helpful cybersecurity tools that allow users to keep up to date with the methods used by modern day attackers. As their attacks evolve, so must the precautions taken by modern day users.  

## References

[1] Paliwal, Savita. “Honeypot: A Trap for Attackers.” International Journal of Advanced Research in Computer and Communication Engineering, vol. 6, no. 3, Mar. 2017, pp. 842–845., doi:10.17148/ijarcce.2017.63197.  
[2] Paralax. “Paralax/Awesome-Honeypots.” GitHub, 14 Dec. 2019, github.com/paralax/awesome-honeypots   
[3] Dtag-Dev-Sec. “Dtag-Dev-Sec/Tpotce.” GitHub, 22 Apr. 2020, github.com/dtag-dev-sec/tpotce  
[4]  “4.1. Rules Format.” 4.1. Rules Format - Suricata 4.1.0-Dev Documentation, 2016, https://suricata.readthedocs.io/en/suricata-4.1.4/rules/intro.html  
[5] Zalewski, Michal. “p0f v3 (Version 3.09b).” p0f v3, lcamtuf.coredump.cx/p0f3/  
[6] “Documentation.”Dionaea, dionaea.carnivore.it/documentation/  
[7] Public Safety Canada. “Samba (Smbd) Vulnerability.” AV16-060, 4 May 2016, www.publicsafety.gc.ca/cnt/rsrcs/cybr-ctr/2016/av16-060-en.aspx  
[8] “Security Updates and Information.” Samba, www.samba.org//samba/history/security.html  
[9] Ismanto, Melvin. “How to Use EternalBlue to Exploit SMB Port Using Public Wi-Fi.” Medium, Medium, 18 June 2019, medium.com/@melvinshb/how-to-use-eternalblue-to-exploit-smb-port-using-public-wi-fi-79a996821767  
[10] Microsoft Support.”Microsoft Security Advisory: Vulnerability in SQL Server could allow remote code execution”..”Support.microsoft.com, support.microsoft.com/en-ca/help/961040/microsoft-security-advisory-vulnerability-in-sql-server-could-allow-re  
[11] “MS09-004 Microsoft SQL Server sp_replwritetovarbin Memory Corruption via SQL Injection.” Rapid7, www.rapid7.com/db/modules/exploit/windows/mssql/ms09_004_sp_replwritetovarbin_sqli  
[12] “What Is SQL Injection? Tutorial & Examples: Web Security Academy.” What Is SQL Injection? Tutorial & Examples | Web Security Academy, portswigger.net/web-security/sql-injection  
[13] Manuel, Jasper, et al. “OMG: Mirai-Based Bot Turns IoT Devices into Proxy Servers.” Fortinet Blog, 21 Feb. 2018, www.fortinet.com/blog/threat-research/omg--mirai-based-bot-turns-iot-devices-into-proxy-servers.html  
[14] Trost, Jason. “Adventures with Heralding, a Credential Grabbing Honeypot.” Covert.io, 15 Dec. 2016, www.covert.io/adventures-with-heralding-a-credential-grabbing-honeypot/  
[15] KacyConnect, Kacy Zurkus News WriterEmail. “Malicious Login Attempts Spike in Finance, Retail.” Infosecurity Magazine, 20 Sept. 2018, www.infosecurity-magazine.com/news/malicious-login-attempts-spike-in/  
[16] Vasilyev, Igor. “classification.config.” Classification.config - Suricata - Open Information Security Foundation, 26 July 2018, https://redmine.openinfosecfoundation.org/attachments/1529  
[17] Team, SecurityTrails. “SecurityTrails: Cybersecurity Fingerprinting Techniques and OS-Network Fingerprint Tools.” Cybersecurity Fingerprinting: What Is It? Fingerprint Techniques and Tools, SecurityTrails, 21 May 2019, securitytrails.com/blog/cybersecurity-fingerprinting  