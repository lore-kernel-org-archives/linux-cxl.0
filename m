Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A36B4D8BB;
	Tue, 11 Jun 2024 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130706; cv=none; b=gFh5mW6VyoJ+/vF40kZrgto9OBVuoz9F8q6wnG3p9TT8bSzDAOCER0XLtlbZ9iyZD7W7d6nyLoMwlyPRZIe6cJDNFCf1I9NYStw1mQDCbAXhn/IS1z4QtzJKSOfc+wh3JgiS4ExhnvhnaXr3G4ikVe+3MvIWezo5m6txExmPeo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130706; c=relaxed/simple;
	bh=ssDxGBEO1v+Bn96XkYGZvqK1SmAskeAKa0ATYQi8F90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=E+sY3LR+F/pOz3HIHYPbhkSTW59gKGiIeRkDbI6qPT8sCKreV4GuO71UG+Vb26zvi/YWHeXHKjtRcaqhXo7K053KqXA90R1QLalR0pc1RBAlbuhAn3SR4A93vrio6gmeTN+htio5UF44E4IVmR48eSzJw5eF5XAkjnzCpYsCVL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IOFKSp1C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IOFKSp1C"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BBLS8a024513;
	Tue, 11 Jun 2024 18:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MKL7h3+Tth91Ko5JDRnBZL
	hnGPvdZdXioho4y1uBnyY=; b=IOFKSp1C8TZ07GS8sIRAhrJuZLxCkL0h9IsvxN
	64p00feh1MOzSf/qelvE3zyz2CGU4gYSRB3ZAygBb1d0Jqg9IR8Bn3lRw4EXIyx6
	LjtxQJoremaXB2g4qnh/4/dG0YfGD3wzvirM2yMyZWKNMvVrYno4IH7HOu2pX4jt
	j4BYB7gVycbN6iI8JDX9So2Ey7eGhYjW+95FVgHsyLEDgNebVaBwltdzgyfWeuK3
	Pw7c+63kGwQmoPLCZEhOthoS7LlfBn5oyF2E6qq7fUqnectIURZAjB4N0x72SYdu
	Pvugxxs05yqwE8OnSlupFQ1+bEuLx137AIEJSF4XKQZf1TeA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymfh384h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 18:31:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45BIVECn021521
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 18:31:14 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 11:31:07 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 11 Jun 2024 11:31:06 -0700
Subject: [PATCH] perf: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240611-md-drivers-perf-v1-1-c001bae6da5c@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOmXaGYC/x3MwQqDMAyA4VeRnBdoaydurzJ2qCbOwOwkcSKI7
 26343f4/x2MVdjgXu2gvIrJJxf4SwX9mPKLUagYggvRNd7jREgqK6vhzDrgldo6BtfemkhQqll
 5kO1/fDyLu2SMnabcj7/PW/J3wynZwgrHcQIJVJAFgAAAAA==
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Frank Li <Frank.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam
	<festevam@gmail.com>,
        Yicong Yang <yangyicong@hisilicon.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <imx@lists.linux.dev>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SqlRJ1-P_JB-TsycMDe8qYHwpnOrVlY_
X-Proofpoint-GUID: SqlRJ1-P_JB-TsycMDe8qYHwpnOrVlY_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 bulkscore=0 phishscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110127

With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm-ccn.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/fsl_imx8_ddr_perf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/marvell_cn10k_ddr_pmu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm_cspmu/arm_cspmu_module.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm_cspmu/nvidia_cspmu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm_cspmu/ampere_cspmu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/cxl_pmu.o

Add the missing invocation of the MODULE_DESCRIPTION() macro to all
files which have a MODULE_LICENSE().

This includes drivers/perf/hisilicon/hisi_uncore_pmu.c which, although
it did not produce a warning with the x86 allmodconfig configuration,
may cause this warning with arm64 configurations.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/perf/arm-ccn.c                   | 1 +
 drivers/perf/arm_cspmu/ampere_cspmu.c    | 1 +
 drivers/perf/arm_cspmu/arm_cspmu.c       | 1 +
 drivers/perf/arm_cspmu/nvidia_cspmu.c    | 1 +
 drivers/perf/cxl_pmu.c                   | 1 +
 drivers/perf/fsl_imx8_ddr_perf.c         | 1 +
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 1 +
 drivers/perf/marvell_cn10k_ddr_pmu.c     | 1 +
 8 files changed, 8 insertions(+)

diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 86ef31ac7503..65f4882531db 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1561,4 +1561,5 @@ module_init(arm_ccn_init);
 module_exit(arm_ccn_exit);
 
 MODULE_AUTHOR("Pawel Moll <pawel.moll@arm.com>");
+MODULE_DESCRIPTION("ARM CCN (Cache Coherent Network) driver support");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/perf/arm_cspmu/ampere_cspmu.c b/drivers/perf/arm_cspmu/ampere_cspmu.c
index f146a455e838..426b3cfcb52e 100644
--- a/drivers/perf/arm_cspmu/ampere_cspmu.c
+++ b/drivers/perf/arm_cspmu/ampere_cspmu.c
@@ -269,4 +269,5 @@ static void __exit ampere_cspmu_exit(void)
 module_init(ampere_cspmu_init);
 module_exit(ampere_cspmu_exit);
 
+MODULE_DESCRIPTION("Ampere SoC PMU (Performance Monitor Unit) driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index c318dc909767..c21c564840d6 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1427,4 +1427,5 @@ EXPORT_SYMBOL_GPL(arm_cspmu_impl_unregister);
 module_init(arm_cspmu_init);
 module_exit(arm_cspmu_exit);
 
+MODULE_DESCRIPTION("ARM CoreSight Architecture PMU driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
index 5b84b701ad62..0dea47e48ac5 100644
--- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
+++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
@@ -417,4 +417,5 @@ static void __exit nvidia_cspmu_exit(void)
 module_init(nvidia_cspmu_init);
 module_exit(nvidia_cspmu_exit);
 
+MODULE_DESCRIPTION("NVIDIA Coresight Architecture PMU driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 1f93a66eff5b..8b6ce9ea5a55 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -972,6 +972,7 @@ static __exit void cxl_pmu_exit(void)
 	cpuhp_remove_multi_state(cxl_pmu_cpuhp_state_num);
 }
 
+MODULE_DESCRIPTION("CXL Performance Monitoring Unit driver");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS(CXL);
 module_init(cxl_pmu_init);
diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 1bbdb29743c4..a6683b38315c 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -850,4 +850,5 @@ static struct platform_driver imx_ddr_pmu_driver = {
 };
 
 module_platform_driver(imx_ddr_pmu_driver);
+MODULE_DESCRIPTION("Freescale i.MX8 DDR PMU driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 6392cbedcd06..e1df9db498e9 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -537,4 +537,5 @@ void hisi_pmu_init(struct hisi_pmu *hisi_pmu, struct module *module)
 }
 EXPORT_SYMBOL_GPL(hisi_pmu_init);
 
+MODULE_DESCRIPTION("HiSilicon SoC PMU driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index e2abca188dbe..94f1ebcd2a27 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -763,4 +763,5 @@ module_init(cn10k_ddr_pmu_init);
 module_exit(cn10k_ddr_pmu_exit);
 
 MODULE_AUTHOR("Bharat Bhushan <bbhushan2@marvell.com>");
+MODULE_DESCRIPTION("Marvell CN10K DRAM Subsystem (DSS) Performance Monitor Driver");
 MODULE_LICENSE("GPL v2");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240611-md-drivers-perf-5d834208964d

