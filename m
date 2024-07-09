Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4DF1B86D6;
	Tue,  9 Jul 2024 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720562910; cv=none; b=H/4EoiQey3OIM8QuSwCcUt7QqHT/J0kI8LuYFCN8Rua6YBJXufFTayVR+TIsDvLSnnFbvDPghW31p6XRonxTGKIcUyQFK+KNK86CnwjR4ngZRYAFEa6B7F3W9thhrIqgvhTZoUG/OvmYV5GFPofKvcxb5xHM0WGKX2pYcY9NeSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720562910; c=relaxed/simple;
	bh=lkzWomeVwq/YRJmwTAIEZ93bVceNo/kXZvVtzOy1Wd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=jvTHv/zyEBeKZkAMR7vQ/UKn5sTtOOi7n7kJwYfbeInFfkFM05yhf6cwBZ5xqwAZ4fDT5Bz9LJELJ6AbsHrWRtaxgerpQEbnX6lAx96/jD5UabSl9B55SxEo5zHgLlUe2WmU/U1tjkfWS/x5/FQvnJFdWaGkq/ZLapVjFjigQqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YISv2mlK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YISv2mlK"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469J6FoH019368;
	Tue, 9 Jul 2024 22:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qlBjtF6+Nl6p3pxoPrJXX6
	P3qWoG4zdVGdJPJXfQSu0=; b=YISv2mlKxrtaQNwSg0QGrgLDzM5cpQUh0X8NHO
	HeZkjGl8BN0285CD755VQZZVfhQ23yfLwGH9/4ZdLUG0M0sJePB0DBpY254B/pcn
	5hkhLkW2Sm4IQO6ZnfHJf2X5d6XmEvia2sAUPK+h7FQnOrjBiRQYlHoeJ5y+QxG6
	18EbhrWzNLoL6eHH9UkmUTW8v56nvPRL+jBBVdqrqWbOyZkIl43Li/gBi9pE9gr3
	w/6/eFrQE693/oyb1D/6H97ExEhSO/A542D1vPyv0Oq0fhQJjchNanEDZegCatgs
	1JeQsT04EreTjJcDoPM7YLX7UrExTQOpc/TraBIlsiagJjwA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wg3yvgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 22:07:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469M7uXu022335
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 22:07:56 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 15:07:56 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 9 Jul 2024 15:07:55 -0700
Subject: [PATCH v3] perf: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240709-md-drivers-perf-v3-1-513275b75ed0@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALq0jWYC/3WNQQ6CMBBFr0K6dkxbgVRX3sO4KO0gk0jBKTQaw
 90trjTG5Uv+f+8pIjJhFIfiKRgTRRpCht2mEK6z4YJAPrPQUpeyVgp6D54pIUcYkVuovNmVWpp
 9XXqRXyNjS/e38XTO3NiI0LANrls9VwrzHXobJ+R13lGcBn68+0mtp/+ppECBk1I1FmtvK3e8z
 eQouK0berHGkv4waPlr0NmgWmNaY6XB0nwblmV5Abxhll8RAQAA
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
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NIEQ1DEPAW5LxLD-pOtMBJdkRdU74cC0
X-Proofpoint-GUID: NIEQ1DEPAW5LxLD-pOtMBJdkRdU74cC0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_10,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090151

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
Changes in v3:
- Consistently use "Performance Monitor" in the descriptions
- Did not carry forward Yicong Yang's Reviewed-by since I tweaked the
  description that was reviewed
- Link to v2: https://lore.kernel.org/r/20240620-md-drivers-perf-v2-1-1f88f8a08e48@quicinc.com

Changes in v2:
- Updated hisi_uncore_pmu.c description per Yicong Yang
- Link to v1: https://lore.kernel.org/r/20240611-md-drivers-perf-v1-1-c001bae6da5c@quicinc.com
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
index 86ef31ac7503..5c66b9278862 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1561,4 +1561,5 @@ module_init(arm_ccn_init);
 module_exit(arm_ccn_exit);
 
 MODULE_AUTHOR("Pawel Moll <pawel.moll@arm.com>");
+MODULE_DESCRIPTION("ARM CCN (Cache Coherent Network) Performance Monitor Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/perf/arm_cspmu/ampere_cspmu.c b/drivers/perf/arm_cspmu/ampere_cspmu.c
index f146a455e838..f72f5689923c 100644
--- a/drivers/perf/arm_cspmu/ampere_cspmu.c
+++ b/drivers/perf/arm_cspmu/ampere_cspmu.c
@@ -269,4 +269,5 @@ static void __exit ampere_cspmu_exit(void)
 module_init(ampere_cspmu_init);
 module_exit(ampere_cspmu_exit);
 
+MODULE_DESCRIPTION("Ampere SoC Performance Monitor Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index c318dc909767..2158a5975c90 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1427,4 +1427,5 @@ EXPORT_SYMBOL_GPL(arm_cspmu_impl_unregister);
 module_init(arm_cspmu_init);
 module_exit(arm_cspmu_exit);
 
+MODULE_DESCRIPTION("ARM CoreSight Architecture Performance Monitor Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
index 5b84b701ad62..d0ef611240aa 100644
--- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
+++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
@@ -417,4 +417,5 @@ static void __exit nvidia_cspmu_exit(void)
 module_init(nvidia_cspmu_init);
 module_exit(nvidia_cspmu_exit);
 
+MODULE_DESCRIPTION("NVIDIA Coresight Architecture Performance Monitor Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 1f93a66eff5b..43d68b69e630 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -972,6 +972,7 @@ static __exit void cxl_pmu_exit(void)
 	cpuhp_remove_multi_state(cxl_pmu_cpuhp_state_num);
 }
 
+MODULE_DESCRIPTION("CXL Performance Monitor Driver");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS(CXL);
 module_init(cxl_pmu_init);
diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 1bbdb29743c4..746b92330ca7 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -850,4 +850,5 @@ static struct platform_driver imx_ddr_pmu_driver = {
 };
 
 module_platform_driver(imx_ddr_pmu_driver);
+MODULE_DESCRIPTION("Freescale i.MX8 DDR Performance Monitor Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 6392cbedcd06..918cdc31de57 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -537,4 +537,5 @@ void hisi_pmu_init(struct hisi_pmu *hisi_pmu, struct module *module)
 }
 EXPORT_SYMBOL_GPL(hisi_pmu_init);
 
+MODULE_DESCRIPTION("HiSilicon SoC uncore Performance Monitor driver framework");
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
base-commit: 34afb82a3c67f869267a26f593b6f8fc6bf35905
change-id: 20240611-md-drivers-perf-5d834208964d

