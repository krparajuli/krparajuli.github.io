
* validating every stage of a digital interaction
* “never trust, always verify”
* strong authentication methods, leveraging network segmentation, preventing lateral movement, providing Layer 7 threat prevention, and simplifying granular, “least access” policies
* This implicit trust means that once on the network, users – including threat actors and malicious insiders – are free to move laterally and access or exfiltrate sensitive data due to a lack of granular security controls.
  * Host-based auth
    * Especially in network firewall


Step 0: Visibility and Critical Asset Identification
Building The Zero Trust Enterprise

Users
- strong authentication of user identity
- application of “least access” policies
- verification of user device integrity

Applications 
- Removes implicit trust
- continuous monitoring at runtime is necessary to validate their behavior

Infrastructure - everything infrastructure-related—routers, switches, cloud, IoT, and supply chain—must be addressed with a Zero Trust approach.


## Google Beyond Zero
1. Device Authentication
   1. Use of chrome to understand the user behavior
2. Session Length is very important; No priveleged access for 24 hours

IAP - Identity Access Proxy

### 1. Securely Identifying the Device
1. **Device Inventory Database**: *Managed Device* - Keep track of changes made to the device
2. **Device Identity**: *Certificate* Stored on TPM or qualified cetificate store*
### 2. Securely Identufying the User
1. **User and Group Database**: 
2. **Single Sign-On System w/ 2FA**

### 3. Removing Trust from the Network
1. **Deployment of an Unprivileged Network**: Unprivileged Network for all users even while physically on the workplace
2. **802.1x Authentication on Wired and Wireless Network Access**
  1. RADIUS informs the switch in the VLAN for the authenticated device
  2. Remote Authentication Dial-In User Service (RADIUS)
    1. Provides centraluzed Authentication, Authorization, Accounting Management for users who connect and use a network service
   

### Externalizing Applications and Workflows
1. **Internet-Facing Access Proxy**:Delegate request as appropriate to the back-end
2. **Public DNS Entries**

## Implementing Inventory-Based Access Control
### Trust Inference for Devices and Users
### Access Control Engine
### Pipeline into the Access Control Engine


### Implementing Zero Trust
1. Workflow Qualification - Work through Access Proxy
1. Cutting Back on the Usage of VPN - No perimeter approach
2. Job Function Analysis - Tying close to "Need-to-know" and "for how long"


[1](https://www.paloaltonetworks.com/cyberpedia/what-is-a-zero-trust-architecture)


1. [https://www.paloaltonetworks.com/cyberpedia/what-is-a-zero-trust-architecture](https://www.paloaltonetworks.com/cyberpedia/what-is-a-zero-trust-architecture)
