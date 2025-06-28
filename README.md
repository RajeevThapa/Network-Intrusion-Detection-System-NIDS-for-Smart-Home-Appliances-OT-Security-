# 🛡️ Network Intrusion Detection System (NIDS) for Smart Home Appliances (OT Security)

This project simulates a real-world **Red Team vs Blue Team** scenario in a smart home IoT network. It demonstrates how an **open-source NIDS sensor (Suricata + Filebeat)** can detect and respond to common IoT attacks, with logs and alerts analyzed through the **Elastic Stack (Elasticsearch + Kibana)**. The goal is to provide visibility into vulnerable IoT traffic, emulate real cyberattacks, and show how defenders can respond using detection tools and threat intelligence.

## 📁 Project Structure

```
.
├── Vagrantfile                # Provision VMs: 1 NIDS (Ubuntu), 3 IoT (Alpine), 1 Kali attacker
├── elastic-stack/             # Host-based Docker setup for Elasticsearch & Kibana
│   └── docker-compose.yml
├── nids-sensor/               # Suricata and Filebeat configurations
│   ├── filebeat/
│   └── suricata/
├── iot-devices/               # Simulated vulnerable IoT devices
│   ├── iot1/                  # Smart Light (MQTT + HTTP, no auth)
│   ├── iot2/                  # IP Camera (Telnet with default credentials)
│   └── iot3/                  # Smart Plug (CoAP with payload injection)
└── README.md
```

## ⚙️ System Overview

### 👁️ NIDS Server (Ubuntu)
- **Suricata** monitors all host-only network traffic.
- **Filebeat** ships Suricata alerts to Elasticsearch.

### 🧪 IoT Devices (Alpine Linux)
- **IoT 1**: Smart light with exposed **MQTT** and **HTTP**, no authentication.
- **IoT 2**: IP camera with **Telnet** enabled using default creds.
- **IoT 3**: Smart plug running a vulnerable **CoAP** service.

### 📊 ELK Stack (Host Machine via Docker)
- **Elasticsearch** indexes alerts and logs.
- **Kibana** provides dashboards for monitoring and threat hunting.

### 💣 Kali Linux (Attacker VM)
- Simulates external attacker on the same host-only network.

## 🧠 Simulation Framework

The entire project follows the **Cyber Kill Chain** stages:

1. **Reconnaissance** – Nmap scans
2. **Weaponization** – Use of payloads, brute-force tools
3. **Delivery** – SYN floods, brute attempts, protocol exploits
4. **Exploitation** – Service crashes, shell access
5. **Installation** – Reverse shell or persistence
6. **Command & Control (C2)** – Maintain remote access
7. **Actions on Objectives** – Data exfiltration, device control

## 🔴 Red Team Attack Scenarios

### 🚨 IoT 1 – MQTT DoS Attack
- Recon: Found ports 80 & 1883
- Attack: SYN flood via `hping3`
- Result: MQTT crash

### 🚨 IoT 2 – Telnet Brute Force
- Recon: Found port 23
- Attack: Brute force via `hydra`
- Result: Default login, reverse shell, data exfiltration

### 🚨 IoT 3 – CoAP Payload Injection
- Recon: Found port 5683/UDP
- Attack: Payload injection via CoAP client
- Result: Reverse shell, log tampering

## 🔵 Blue Team Detection & Response

- Suricata detects scans, brute force, CoAP exploits
- Filebeat ships logs to ELK stack
- Kibana visualizes alerts
- Mitigation: IP blocks, port restrictions, custom rules

## 🚀 How to Deploy

```bash
# Start ELK stack
cd elastic-stack/
docker-compose up -d

# Provision VMs
vagrant up

# Open Kibana dashboard
http://localhost:5601
```

## 💡 Features

✅ Simulated IoT devices with realistic vulnerabilities  
✅ Red Team attack toolkit via Kali Linux  
✅ Detection and alerting via Suricata  
✅ Log shipping with Filebeat  
✅ Visual dashboards in Kibana  
✅ Based on OWASP IoT Top 10 and Cyber Kill Chain

## 🧰 Tools Used

| Tool             | Purpose                         |
|------------------|----------------------------------|
| Suricata          | Network intrusion detection     |
| Filebeat          | Log shipping                    |
| Elasticsearch     | Data storage and indexing       |
| Kibana            | Visual dashboard                |
| Vagrant           | VM provisioning                 |
| Docker Compose    | ELK stack orchestration         |
| Kali Linux        | Red team simulation             |

## 🔐 Security Recommendations

- Use secure protocols (HTTPS, MQTTS, CoAPS)
- Disable Telnet and unused services
- Enforce authentication
- Monitor logs regularly

## 🎓 Educational Value

> This project simulates real-world IoT attacks and defenses using open-source tools and red/blue teaming. It’s designed for hands-on security learning and research.

## 📄 License

MIT License

## 🤝 Contributing

Pull requests welcome!