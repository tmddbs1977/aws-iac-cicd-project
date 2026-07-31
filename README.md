# IaC를 활용한 AWS 인프라 구축 및 CI/CD 자동화

---

# 📌 프로젝트 소개

본 프로젝트는 **Spring PetClinic 애플리케이션을 대상으로 AWS 인프라를 구축하고, Ansible을 활용한 IaC(Infrastructure as Code)와 Jenkins 및 AWS CodeDeploy를 이용한 CI/CD 환경을 구현한 개인 프로젝트**입니다.

고가용성을 고려하여 VPC, Public/Private Subnet, NAT Gateway, Application Load Balancer(ALB), Auto Scaling Group(ASG) 등 AWS 인프라를 구성하였으며, Ansible Playbook을 활용하여 인프라 구축을 자동화했습니다.

또한 GitHub에 소스코드를 Push하면 Jenkins가 자동으로 애플리케이션을 빌드하고 AWS CodeDeploy를 통해 EC2 인스턴스에 배포되도록 CI/CD 파이프라인을 구축하여 반복적인 배포 작업을 자동화하고 운영 효율성을 향상시켰습니다.

---

# 🎯 프로젝트 목표

- AWS 환경에서 실제 서비스 운영을 고려한 고가용성 인프라를 설계하고 구축한다.
- Ansible을 활용한 IaC(Infrastructure as Code)를 적용하여 반복적인 인프라 구축 작업을 자동화한다.
- Jenkins와 AWS CodeDeploy를 활용하여 GitHub 소스 변경부터 빌드 및 배포까지 CI/CD 파이프라인을 구현한다.
- Spring PetClinic 애플리케이션을 대상으로 자동화된 배포 환경을 구축하여 DevOps 운영 방식을 경험한다.

---

# 🏗 Architecture

## AWS Infrastructure Architecture

![AWS Infrastructure Architecture](docs/architecture/aws-infrastructure-architecture.png)

## CI/CD Pipeline Architecture

![CI/CD Pipeline Architecture](docs/architecture/cicd-pipeline-architecture.png)

---

# 🛠 기술 스택

| 구분 | 기술 |
|---|---|
| Cloud | AWS EC2, VPC, ALB, Auto Scaling, Route 53, S3 |
| IaC / Automation | Ansible |
| CI/CD | Jenkins, AWS CodeDeploy |
| Build | Maven |
| Container | Docker, Docker Hub |
| Application | Spring PetClinic |
| Version Control | GitHub |

---

# ☁ AWS 인프라 구성

## Network

| 구분 | 구성 |
|---|---|
| Region | ap-northeast-2 (Seoul) |
| VPC | 172.42.0.0/16 |
| Availability Zones | ap-northeast-2a, ap-northeast-2c |
| Public Subnet A | 172.42.0.0/24 |
| Public Subnet C | 172.42.16.0/24 |
| Private Subnet A | 172.42.64.0/24 |
| Private Subnet C | 172.42.80.0/24 |
| Public Route | 0.0.0.0/0 → Internet Gateway |
| Private Route | 0.0.0.0/0 → NAT Gateway |
| NAT Gateway | Public Subnet A에 단일 구성 |

2개의 Availability Zone에 Public/Private Subnet을 분산 구성하였으며,
Public Subnet은 Internet Gateway를 통해 외부와 통신하도록 구성했습니다.

Private Subnet은 NAT Gateway를 통해 아웃바운드 인터넷 통신이 가능하도록 구성하여,
Jenkins 및 WAS 인스턴스를 외부에 직접 노출하지 않도록 설계했습니다.

---

# 🤖 IaC (Ansible)

---

# 🔄 CI/CD Pipeline

---

# 📂 프로젝트 구조

---

# ⚙ 구축 과정

---

# ⚠ Trouble Shooting

---

# 📈 성과

---

# 💡 배운 점
