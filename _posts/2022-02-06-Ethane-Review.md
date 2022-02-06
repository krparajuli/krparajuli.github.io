---
layout: post
title:  "Review of Ethane: Network Architecture for the enterprise"
date:   2022-02-05 21:03:36 -0500
categories: Ethane Network-Architecture Paper-Review SDN
---

> **BRIEF OVERVIEW OF ETHANE** 
> Ethane: Network Architecture for the enterprise
> Define single network0wide fine-grain policy and enforces it
> Extremely Simple Flow-Based Ethernet Switches and Centralized controller to manage the admittance and routing of flows
> Backwards-compatible

# Introduction
* Enterprise networks = Strict reliability and security constraints + Wide variety of applications and protocols
* Difficult to manage; Current solutions are weak; expensive and error-prone
  * Requires substantial manual configurations
* Alternative Approaches:
  * Proprietary middleboxes exerting control if placed at network choke-points
    * Does not secure from flows around the middlebox
  * Add functionality to existing networks
    * for tools for diagnosis, offfer controls for VLANs, ACLs, filter and isolate users, to instrument routing and spanning tree algorithms to support better connectivity management
    * to collect packet traces to allow auditing
    * Can be done by adding a new lira protocols, scripts and applications
    * **have to be constantly maintained**
    * Not suitable for rapidly changing elements
* **Ethane** makes these more manageable. It's fundamental principles are:
    * the networks will be governed by policies declared over high-level names (users, hosts, and access-points rather than addresses)
    * **Polilicies to determine the path that packets follow**
      * example: a guest user communicate via proxy; and unpatched OS must communicate via an IDS
      * example: a traffic can receive more appropriate service if it's path is controlled
    * **The networks should enforce a strong binding between a packet and its origin**
      * governed by high-level names like users and host rather than dynamically changing addresses
  * **Adopts Centralized contol architecture**
    * The paper finds that standard replication techniques can provide excellence resilience and current CPU speeds can handle functions of a sizable net work from one PC
  *  Ethan follows up on SANE in three different following ways:
     * Security follows management
     * Incremental deployability: Ethane switches can be incrementally deployed all inside existing ethernet switches
     * Significant deployment experience
  
# Overview of Ethane Design
* Controls network by not allowing any communication between and host without explicit permission
  * Two componenets acheive the aforementioned goals:
    * **Central controller**: containing the global network policy determines the fate of all packets
      * Decides whether of low represented by a packet should be allowed
      * Knows the global network topology and performs computations for permitted flows; Grants excess by explicitly enabling flows within the network switches along the chosen route
      * Controller can be replicated for redundancy and performance
    * **Set of ethane switches**: Simplae and dump consisting of a  simple floor table and a secure channel do the controller
      * when a package arrives that is not in the floor table they forward the packet to the controller; else forward according to the controllers directive
      * not every switch on the network needs to be an Ethane switch
## Names, Bindings and Policy Language
* If the mapping between machine names and IP addresses(DNS) or IP Addresses and  Mac addresses (ARP, DHCP) are handled elsewhere and not authenticated, it is not possible to tell who sent the packet
* With local centralization it is simple to keep namespaces consistent
* Ethane uses a sequence of techniques to secure the bindings between packet headers and the physical entities that send them
  * Ethane Controls DHCP to assign IP address and knows the machine
  * Packet must come from a machine within the network; thus is properly attributed
  * Users are required to authenticate themselves within the network; binding users to hosts
* Useful to diagnose network faults or to perform auditing or forensi
## Ethane in use
### Registration
* All switches, users, and hosts are registered at the controller with the credentials necessary to authenticate them
  * ***Doesnt discuss the advantages of different level of auth one over other***
  * All switches are pre-configured wth credentials needed to authentiate the controller (Controller's public key)
### Bootstrapping
* Switches bootstrap connectivity by creating a spanning tree rooted at the controller
* Each  switch authenticate and then send links information to the controller using the secure connection
### Authentication
* For an unauthenticated host, all traffic is sent to the controller - since the floor increase associated with the user is lacking
* Host snets DHCP to contoller and get host->IP->MAC Address -> Physical Port on switch 1 mapping
* User authenticates using HTTPS traffic in web form binding user to the host
### Flow Setup
* For any initial connection, the switch forwards the packet to the controller if the packet does not have any matching active entries in the flow table
* Controller decides to allow or deny the flow are required to traverse a set of waypoints
* If allowed, computes the flow's routes; add new entry to the flow tables of all the switches
### Forwarding
* If Controller allowed the path, it sends the packet back to the originating switch with forwards it based on the new flow entry
* The flow entries is kept in the switch until it times out or is revoked by the Controller

# Ethane in more detail
## An Ethane Network
* When an Ethane Switch is added, it has to find the controller, open a secure channel to it, and held the controller figure out the topology using a modified minimum spanning tree algorithm
* When a host is added or booted, it has to authenticate itself with the controller; baguettes are automatically forwarded to the controller over the secure channel by the switch
## Switches
* Like a simplified Ethernet switch; has several ETH interfaces to send and receive Eth packets
* Ethan switch does not need to learn addresses, support VLANs, check for source-address spoofing, or keep flow level stats
* If Ethane switch replaces Level 3 router, it does not need to
  * Maintain forwarding table, ACLs, or NAT
  * Does not need to run routing protocols like OSPF, ISIS, and RIP
  * Doesn North support for SPANs and port-replication
* Flow table can be several orders of magnitude smaller than the forwarding table in an equivalent ethernet switch
  * > In an Ethernet switch, the table is sized to minimize broadcast traffic: as switches flood during learning, this can swamp links and makes the network less secure - thus needs to remember all address it's likely encounter
  * Ethane only need to keep track of flows in-progress
### Flow Table and Flow Entries

```
FLOW ENTRY TABLE
+---------------------------------+
| Header | Action | Per-Flow Data |
+---------------------------------+
```
* Flow Table
  * Header: Match Packets against
    * TCP/UDp, IP, and Ethernet header; Physical Port info
  * Action: What to do with the packet
    * For a proper packet
      * Forward to a particular interface
      * Update a packet-and-byte-counter
      * Set an activity bit (So that iactive entries can be timed-out)
    * For a misbehavign packet
      * Drop the packet
      * Update a packet-and-byte-counter
      * Set an activity bit (to tell when the host has stopped sending)
* > ONLY the CONTROLLER can add entries to the flow table
* Flow entries are exact match-tables
  * One for application-flow entries and one for misbehaving-host entreis
  * Easy to use hashing schemes instead ot TCAMs where memory is deficient
    * TCAM = TCAM (ternary content-addressable memory) is a specialized type of high-speed memory that searches its entire contents in a single clock cycle.
* **SWITCH (CONTINUED)**
* Switch Can perform address translation by replacing packet headers
* Switch can obfuscate addresses in the network by switching the address aat each switch along the path
### Local Switch Manager
* The Switch needs a small local manager to establish and maintain the secure channel to the Controller, to monitor link status, and to provide an interface for any additional Switch-specific management and diagnostics [1]
* If the Switch is not within the same broadcast domain as the Controller, the Switch can create an IP tunnel to it
* The local Switch manager relays link status to the Controller so it can reconstruct the topology for route computation. Switches maintain a list of neighboring switches by broadcasting and receiving neighbor-discovery messages
## Controller
* Brain of the network
![](./resources/Ethane-Controller.png)
* Authenticate users and hosts using credentials stored in registration database
* Holds *policy file* which is compled in to a fast lookup table
* *Route computation* uses network topology maintained by *switch manager* which recieves link updates from the switches
### Registration
* All end it is do we need to be registered
* Can interface with a global registry like LDAP or AD, which will be queried by the Controller
### Authentication
* All switches, hosts, and users must authenticate – a network or support multiple authentication methods
### Tracking Bindings
* Ethan's ability to track these dynamic bindings makes the policy language possible
* It allows us to describe policies in terms of users and hosts, eight implement the policy using show tables in switches
### Namespace Configurations
* The tracking of namespaces makes the data easily available to network managers, auditors, etc.
* Current networks have no known relationship between users and packet addresses since the addresses are dynamic; Ethane can journal all auth and binding information
### Permission Check and Access Granting
* Checks for what actions to apply
### Enforcing Resource Limits
* Can easily engorce the limit of resources granted to a user, host, or flow
  * Example: IP address range; flow's rate; number of auth requests per host and per switch port; Can disable port if address spoofing detected
* Can prevent flow state exhaustion attack through resource limits

## Handling Broadcast and Multicast
* Enterprise networks carry lot of broadcast and multicast address
* Worth distinguishign broadcast and multicast; In ethan: Swtiches handle bitmap
* Controller can calculate the broadcast or multicast tree and assign the appropriate bits during path setup

## Replicating the Controller: Fault-Tolerance and Scalability
* 3 approaches to replicating Controller:
  * Cold-Standby (having no network binding state)
    * Backups only need registration state and the network policy
  * Warm-Standby (having network binding state)
    * Controllers monitors one another's liveness
    * Bind Events are atomic, primary failures can at worst lost the latest bindings
  * Fully-replicated: Improves scalability, requests from Switches are spread over multiple active Controllers
    * Round-robin and hashes to divide up the labor of routing
    * **Future Research**

## Link Failures
* Switches always send neighbor-discovery messages to keep track of link-state
* When a link fails, the Switch removes all flow table entries tied to the failed port and sends its new link-state information to the Controller

## Bootstrapping
* When the network starts, the Switches must connect to and authenticate with the Controller.
* If a Switch finds a shorter path to the Controller, it attempts two-way authentication with it before advertising that path as a valid route.
* Authentication is done using the preconfigured credentials to ensure that a misbehaving node cannot masquerade as the Controller or another Switch.

> *POL-ETH Policy Language, Prototype/Deployment Review, and Performance/Scalabilty omitted*

# Ethane's Shortcomings
## Broadcast and Service Delivery
* Broadcast Discovery Protocols consists of tremendous overhead traffic is > 90% of the flows; creating large number of flow table entries
* One of the reasons for VLANs is to control the storms of bradcast traffic on enterprise networks
## Application-layer routing
* It has to trust end-hosts not to relay traffic in violation of the network policy
* Ethane can be compromised by communications at a higher layer
## Knowing what the user is doing
* Colluding malicious users or applications can fool Ethane by agreeing to use non-standard port numbers
## Spoofing Ethernet address
* If a user spoofs a MAC address, it might be possible to fool Ethane into delivering packets to an end-host

# Related Work
* Ethane diverges from 4D in that it supports a fine-grained policy-management
* Moving flow decisions to the controller makes it flexible to policy changes and feature addition
* Ipsilon Networks proposed caching IP routing decisions as flows, in order to provide a switched, multi-service fast path to traditional IP routers
* In Ethane, end-hosts cannot be trusted to enforce filtering as it is in distributed firewalls where policy is declared centrally and enforced at each hosts
* Much of the power of Ethane is to provide network level guarantees, such as policy imposed waypoints. This is not possible to do through end-host level filtering alone.
* VLANs are widely used in enterprise networks for segmentation, isolation, and to enforce coarse-grain policies; and they are commonly used to quarantine unauthenticated hosts or hosts without health “certificates” [3, 6]. VLANs are notoriously difficult to use, requiring much hand-holding and manual configuration; we believe Ethane can replace VLANs entirely, giving much simpler
control over isolation, connectivity, and diagnostics.
* There are a number of Identity-Based Networking (IBN) custom switches available  or secure AAA servers. These allow high-level policy to be declared, but are generally point solutions with little or no control over the network data-path (except as a choke-point). Several of them rely on the end-host for enforcement, which makes them vulnerable to compromise.

# Conclusions
* Ethane is difficult to deploy; eauser to manage once deployed; easier to add feature
* Has great auditing and journaling usage
* Controllers can scale well for large networks
* Switches are best when they are dumb and contain little management software
* Some innovation on controller and switches can be anticipitated