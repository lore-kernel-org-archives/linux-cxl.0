Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41876196C68;
	Fri,  7 Jun 2024 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768655; cv=none; b=Vm3ETNScPAk94DhgPTBAkngVLqymoJA7C0g+GtBwSIzuTnupKY9RBZKbWouQIMWQ2E+iHmZ7M+BnjkRaSZlyzOSB8+Gg/DKMv9b96+V+aqN+lqACqYjVQh5IIfciYcy+dVf/WvrifUBop7zOeCCFXttNe+Ai1saCef6/FOApIOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768655; c=relaxed/simple;
	bh=K2XqmcCFd88M5gpCS+h5dZF1hou+6ifInJUri8K4X/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=CTvxWd4QOsT2pj9AbPX/8wxJVv3pJR1AeF2wCSGHpBcTNSTbqLs/kxVANDiDGoywKo/Nz5to/kB4Jsa5WyCbJlO3odGr2OFCJ/5SDMM8wfYcQzFhKAewCvC//cFceM8KsEh6Jnj6LDdBQ+ivs1p5tN5AqR/2+CQjrYZy4/ra6e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TXeE2Joq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TXeE2Joq"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457CDCOP020460;
	Fri, 7 Jun 2024 13:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6xBgDeNwsAKweEpikI+26H
	999a7zQZJIy7HkOc33JS0=; b=TXeE2Joq4RlTHeWZ/d7zuV36pJ8jt/TectNxNJ
	7X7zkpkH5/6vNHSe+C/c3NOq2IsEIKoe/qObDWuMekoRMDeif5F0az93jOnCA+O0
	VaGvzbG6wMuqe5M9vqlSjgbldHlhzzTI22rUYF0DG2my8PmM4h2NAeRXSJ6YIIuB
	LT6/AJDKEsuMrkOTW17JTfpzPPF6ap6PjlZje5MyKxON3UGxluM4TcIYi/MsAT0S
	AGrKRMFJDoCkwaSWKAh75A7o8jEFaXO1H6N2v1GC9aqZUn7brRJgtW2gRZa8xBoP
	Q1dOAyFSogBkOkLjNRhVITGScIO2PcOSeyeD49caRYqmn6VQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yk3h2vau9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 13:57:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457DvHFi008619
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 13:57:17 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Jun 2024
 06:57:16 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 7 Jun 2024 06:57:15 -0700
Subject: [PATCH v2] cxl: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240607-md-drivers-cxl-v2-1-0c61d95ee7a7@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALoRY2YC/3WNyw6CMBBFf4V07ZhSHhZX/odhUcogk0DRKTQYw
 r9b2Ls8yb3nbMIjE3pxTzbBGMjT5CKoSyJsb9wLgdrIQkmVy1JmMLbQMgVkD3YdQBfGanlrqjL
 VIp7ejB2tp/BZR26MR2jYONsfmoHcssJo/Ix8zHvy88TfMx/S4/S3FFJIoVNVLrvCSp2Vj89Cl
 py92mkU9b7vP2sdNrvNAAAA
To: Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron
	<jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alison
 Schofield" <alison.schofield@intel.com>,
        Vishal Verma
	<vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PmU4ysjL4w_iMXHzSETDFXVOJiU5DyK3
X-Proofpoint-ORIG-GUID: PmU4ysjL4w_iMXHzSETDFXVOJiU5DyK3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_07,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070100

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/core/cxl_core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_pci.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_mem.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_acpi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_pmem.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_port.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- Updated the descriptions in drivers/cxl/core/port.c and drivers/cxl/pci.c
  per feedback from Jonathan.
- Updated the description in drivers/cxl/port.c per feedback from Dan.
- Link to v1: https://lore.kernel.org/r/20240603-md-drivers-cxl-v1-1-f2940f5c0836@quicinc.com
---
 drivers/cxl/acpi.c      | 1 +
 drivers/cxl/core/port.c | 1 +
 drivers/cxl/mem.c       | 1 +
 drivers/cxl/pci.c       | 1 +
 drivers/cxl/pmem.c      | 1 +
 drivers/cxl/port.c      | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 571069863c62..e51315ea4a6a 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -921,6 +921,7 @@ static void __exit cxl_acpi_exit(void)
 /* load before dax_hmem sees 'Soft Reserved' CXL ranges */
 subsys_initcall(cxl_acpi_init);
 module_exit(cxl_acpi_exit);
+MODULE_DESCRIPTION("CXL ACPI: Platform Support");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);
 MODULE_IMPORT_NS(ACPI);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 887ed6e358fb..e31c5fcd9bf8 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2356,5 +2356,6 @@ static void cxl_core_exit(void)
 
 subsys_initcall(cxl_core_init);
 module_exit(cxl_core_exit);
+MODULE_DESCRIPTION("CXL: Core Compute Express Link support");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 0c79d9ce877c..1afb0e78082b 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -252,6 +252,7 @@ static struct cxl_driver cxl_mem_driver = {
 
 module_cxl_driver(cxl_mem_driver);
 
+MODULE_DESCRIPTION("CXL: Memory Expansion");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);
 MODULE_ALIAS_CXL(CXL_DEVICE_MEMORY_EXPANDER);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index e53646e9f2fb..4be35dc22202 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1066,5 +1066,6 @@ static void __exit cxl_pci_driver_exit(void)
 
 module_init(cxl_pci_driver_init);
 module_exit(cxl_pci_driver_exit);
+MODULE_DESCRIPTION("CXL: PCI manageability");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 2ecdaee63021..4ef93da22335 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -453,6 +453,7 @@ static __exit void cxl_pmem_exit(void)
 	cxl_driver_unregister(&cxl_nvdimm_bridge_driver);
 }
 
+MODULE_DESCRIPTION("CXL PMEM: Persistent Memory Support");
 MODULE_LICENSE("GPL v2");
 module_init(cxl_pmem_init);
 module_exit(cxl_pmem_exit);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 97c21566677a..d7d5d982ce69 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -209,6 +209,7 @@ static struct cxl_driver cxl_port_driver = {
 };
 
 module_cxl_driver(cxl_port_driver);
+MODULE_DESCRIPTION("CXL: Port enumeration and services");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);
 MODULE_ALIAS_CXL(CXL_DEVICE_PORT);

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240603-md-drivers-cxl-85ac807b9618

