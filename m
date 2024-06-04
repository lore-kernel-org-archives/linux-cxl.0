Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D6113D638;
	Tue,  4 Jun 2024 04:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717476552; cv=none; b=tCtv8GZKMT8un/UwG/c1Y7HRBQLs8J2ulkjGpRGM1gGMHy+ZRKe9QDr7L/7/16QS6qQYcQvzF5P2ArCqUen4pQia34Ax8h1jydDv0vi7GqirF1VHRowk+CWaKSy7bPSvuQUKrXg55lkS1jk3cLjLGNr4kFnpdC2s1y+q9XZWemA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717476552; c=relaxed/simple;
	bh=kBMweLVpCfM2UzYjIsXunDx3MkgmfdWSqBe5Wqak/p4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=mm0Jc+/LEJCirP2SI9EyxPxfTcTPelh2iIx/orvNbopjO4yE9igrAdK24QcxsrQo48HPsbv6fd/h0oyYCnymKZOFHg2wVGOnuXPtuat3/9knmZS3UK/kXF9hbUNnazwcxeidqMo8WHTdQ2ktyzxriXKu2I0bJJwbWmYCL7/t9Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K7NfBC7l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K7NfBC7l"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4540t0Jh022462;
	Tue, 4 Jun 2024 04:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QHdcs9iRHSLkbBbytnbZ2v
	ItgkiTp6EaHw12hroidTo=; b=K7NfBC7lJK++CtBRySB7XNOHf6d8I3+6ILHB1q
	HZn/PkbFMxmZF00Py0u81S6FJDfBdEH/3jOovWkk0/XYC7NSMBvqo2dGxUS1sAiw
	SJK2UmztQIG9RP6Tr2Yh4MzHl0ZL29J0SNiRbksmfdksO3TnwuWXGxUP9v8+4OFG
	mqPEpQIfTJFClFfXg0PKrCZ8TV56y79cYU0wpIiOU9tp8n8f7WTacXHTDtpM+9jR
	PdhSG5G+oSgPRv5eWaACx4cxbZu9211kdtNBHnw1YqeRJFUdBsq9i7AaaUNelXO7
	n08J0eVY4gcM+HItumg2zso9NNqwkQsoRdjbE4lh8GnjBSXw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw5t5g3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 04:48:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4544mvka018396
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 04:48:57 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 21:48:56 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 3 Jun 2024 21:48:53 -0700
Subject: [PATCH] cxl: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240603-md-drivers-cxl-v1-1-f2940f5c0836@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALScXmYC/x3MSw7CMAwA0atUXmMp/VACV0EsnMRQS21ANlSRq
 t6dwPItZjYwVmGDS7OB8iomz1zRHhqIE+UHo6Rq6Fw3uNH1uCRMKiurYSwz+iNF707hPLYeavR
 Svkv5D6+36kDGGJRynH6bWfKn4EL2ZoV9/wL48+ksfwAAAA==
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
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I0XTO6e2qVNYZiT88KgZGlwVs3c6VMCr
X-Proofpoint-GUID: I0XTO6e2qVNYZiT88KgZGlwVs3c6VMCr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406040036

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
index 887ed6e358fb..ccaa00cd0321 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2356,5 +2356,6 @@ static void cxl_core_exit(void)
 
 subsys_initcall(cxl_core_init);
 module_exit(cxl_core_exit);
+MODULE_DESCRIPTION("CXL (Compute Express Link) Devices Support");
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
index e53646e9f2fb..2c17fcb1b4ee 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1066,5 +1066,6 @@ static void __exit cxl_pci_driver_exit(void)
 
 module_init(cxl_pci_driver_init);
 module_exit(cxl_pci_driver_exit);
+MODULE_DESCRIPTION("CXL PCI manageability");
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
index 97c21566677a..5ceff1df60db 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -209,6 +209,7 @@ static struct cxl_driver cxl_port_driver = {
 };
 
 module_cxl_driver(cxl_port_driver);
+MODULE_DESCRIPTION("CXL Port Support");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);
 MODULE_ALIAS_CXL(CXL_DEVICE_PORT);

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240603-md-drivers-cxl-85ac807b9618

