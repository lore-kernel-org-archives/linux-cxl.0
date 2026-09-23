Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010063.outbound.protection.outlook.com [40.93.198.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173174078FF
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184848; cv=fail; b=V53I4y6tAvVL4CsX0SpXpiEkFQ+uIaHnUnk1jQv1zkdp1LMGnvz/xjhzTtuboCdXSR9Px0R/iSqV0zgB8mUMRcU7pEGFLEukr3ztR8YNR21YArZHlhFRyNtck9A21ELq1+kwURQUG7xoJvp4hRKb9MZgzW7yIDfzZL85P95rvtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184848; c=relaxed/simple;
	bh=ybXc49g8Pc27IpjQV6iVf060tF1oWawJd3nSjmIpyM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U155ebL3uBXRorTGyNDunNja3zXhe+Junidc4P/YesXVPfIw5S391oztOlQdMLwDg53tzvoEfqbf1wCd85ga4QJBXSriKzE8tW9znCnJbMXpV53xlGMHn1qTlrvmbILM+GVmzveiZtsYc8C0Wd1byEYT67aYuQE5OqMOkGEaC9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G9tm39bA; arc=fail smtp.client-ip=40.93.198.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G9tm39bA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=heZRMyXbHRE5YUqPH7a9rW4juTnYbhp2QYEmXLzol0YUrY2NWc5Wp43iKp+Z0MOjELwsuoac3fNFrp1zw4isCWSCL5AsJmt5nsACYSZvZiiM6EUBzkVs4mHwAu0U8NlTlitAXtqHlqX67Js/pi13EaR5t/ltFDEus7Bve0MkLO9gmxaZQC5SH1/nb/zMpC6tNLL8WGveR+Wa90mFwuLrED9ylFmeYwofKu7zieTzBvEMVMYsfQLMpUWXRObpn6fosJiDYvQnSC79ID95JcnpRP8KOXeZt5BcEB9CehjKcR7OZCKEo25GdzMaRwkGwlUke0GSpiStRAvaoXiR7P+r5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdF2AKmJY5Q7+RS/CrW84WWbzuolbquDP9kwthyTCyI=;
 b=Rk7uBHZgQmrDhAw1KgwsiY/vRsUy0hdtpooY0Jw/24lQGyfDfsuBjxh5EMQyFMnHXRXVxAPr+NDH+Mt6cLK5CI+aySa7Cs6Csaws2jjfZT/UHU5RG88VHi4FXgzg+4IgJTz8YjAR4xTusXMz2Av+4sfRu4kWPSmsmh1LjccXicU/AZnSeUh0ESb1scv/axCsJ/XmAIiiAxW6o7K2bT6ZNcUmPwzRYjWcPWI4eCR5Fvf4iu3Ud3KZQpezHmq4z9SBoEmrROlJtsLHSPsTqVI3kWtDb4lGgmLxJDotts0ROX+kxYGMgJylHJU8C98RbMbT0m5DtDaCvVCkHuV4yaK3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdF2AKmJY5Q7+RS/CrW84WWbzuolbquDP9kwthyTCyI=;
 b=G9tm39bAEYysdhmdOlscrFLvwH3UsJ3UjlVB2HcWH18UzC2QTjaD7X56wz8k+2Yxy7NOh0Ct8EpBgdI0QAqm7kg/3HtAxo+NepykowCkBUgowacmQ/CFIkEP5O3ltuYNSPzEa/056Ch8Cs/98lm7fXRmsIdfXWTUr4X567Pg9kw=
Received: from DS7PR05CA0021.namprd05.prod.outlook.com (2603:10b6:5:3b9::26)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 17:34:01 +0000
Received: from DS2PEPF000061C2.namprd02.prod.outlook.com
 (2603:10b6:5:3b9:cafe::83) by DS7PR05CA0021.outlook.office365.com
 (2603:10b6:5:3b9::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8 via Frontend Transport; Wed, 23
 Sep 2026 17:33:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C2.mail.protection.outlook.com (10.167.23.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 17:33:59 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 12:33:58 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>
CC: <linux-iommu@vger.kernel.org>, <benjamin.cheatham@amd.com>,
	<terry.bowman@amd.com>, <robert.richter@amd.com>
Subject: [PATCH 14/15] iommu, cxl: Configure IOMMU for CXL.cache
Date: Wed, 23 Sep 2026 12:33:41 -0500
Message-ID: <20260923173342.5584-15-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
References: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C2:EE_|IA1PR12MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: 51643641-7503-47cf-dc03-08df1998da63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|6133799003|22082099003|18002099003|3023799007|5023799004|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	lbUZTXiRFVBJg+LOT8TO2FbVCwDoTlSHKWAx4VyLRUI/YRqGMF+lSGJbncKazfU40nSRXUtbm/opO46C+dSLZ7xRN/gosAYDlGDQKZnud/54KwDY6NQfGnmUowg86FsX/N9IRexQ4SdMiRJPEhZZJH9kdDtfhzHUqJoGU3N2JIzuklNlOqNWacKrqhN2FtcVFae3+DsgjhN6wc3uYCvkYCdFoU9UVw0/upS/1SZenvT3T2btp6b2ZJuZl70KC1QoatGoVgVcLRwXiQBFpa99fmikw9IUvzDMJq9CtigBGuucOm9gL7Pv1nPMYhvrVt1R5tZtEuX85bbz4wMvzmgoKC2vJsTQmj4eH1tehDdkbkISYz65x1iLmy6TcYnbMO/pRD01yc5LQWBf+FFu4xpIXxgZ6KHP/RMTmWiILC9aJM1FhYcjyYxdzAOVGr5fpD/hCgwT541VQJElFJVj1dXEErxqxD+1APwLtC6cyUHgA/Acsu64brCFzL2OepEXmYTuV7IF/cNnb9XU9yZx4qumQc9LxGEXX+p93xVcQVlPw/HvWbQhGLiGt/9NusYRqLIffL9A+CMufp0d97dDe3r5bmKbq6NORyVhrMZ9KZPQ+JcbPw/Dp8/yulHCYFL2SQVpFmVy7qh/iJ1UE5oFKYrA4MOrV10UsgNiFNVvDsznyl6V2wnzO6VdNd3QzwLas3O75o7f0v4IkSUfMlxKu//bRg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(5023799004)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	61C43+9Iu+2Gf50wvNDx+LtUUCNIEnyKEEw03bb1AcjDjBSkz7q8khOv0dNPErsIBGtlVPPoyXL0uxPFB05BlMBeQ3Z9Bal/GKjrUeMJC2+dr0yAOvIi6BUcVnjMkZBApuW2m9cIoLq66onVv6vuDWDU69BQpL+6W7O6wSnMiAj9gtPuUmg5tSgMSUh3JDDGZP9tDJ1VbOV4ZYMq25hAUm18LsjyHewB6T4TmO/OEFzUFRI88+YBwL3tlQLvqqkLSe+GMabFKt7qDoYcT6jrMFvV/q/vsd99gjme2bCYae6Dn9/Vje2yEJXIz0C1EzlZTYSBYj/BByIju+O9msxPDpHLMfrX4B0wvWgBSGJSCjvX8SFhE6vu/kzk49MaHWywMyS3H7qE4Qob6ZanF1POq5vE/IcIttkWm/w2A3C20JbGcgiDGV+Q72gHl3fczdx8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:33:59.8862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51643641-7503-47cf-dc03-08df1998da63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494

Some IOMMU implementations require additional set up for enabling
ATS requests past enabling the base PCI ATS support. Create a callback
in the IOMMU core to be used by the CXL driver during device set up
that, when called, configures the IOMMU to handle ATS requests with the
CXL source bit set. For CXL.cache devices that don't support ATS, the
expectation is for the device to be attached to an identity domain, or
the iommu be disabled.

Update the AMD IOMMU driver with an implementation of the CXL ATS
callback and defaulting CXL.cache devices without ATS support to an
identity domain.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---

I have a note next to the definition of FEATURE_CXLMEMATTR that it's
missing in the AMD IOMMU spec. The spec I'm referring to is the "AMD I/O
Virtualization Technology (IOMMU) Specification, Rev. 3.11, April 2026"
spec available on AMD's website.

I *think* the bit is actually supposed to be 0 based on the figures for
the register it's located in, but I had to guess since it's missing from
the register field table and isn't mentioned elsewhere AFAIK. I figured
it's fine while this is in RFC, but I'll update with the actual bit
when/if this comes out of RFC. Thanks!

---
 drivers/cxl/cache.c                 |  1 +
 drivers/cxl/core/cache.c            | 43 ++++++++++++++++++++++
 drivers/iommu/amd/amd_iommu_types.h |  4 +++
 drivers/iommu/amd/init.c            | 14 ++++++++
 drivers/iommu/amd/iommu.c           | 56 ++++++++++++++++++++++++++++-
 drivers/iommu/iommu.c               | 28 +++++++++++++++
 include/cxl/cxl.h                   | 22 ++++++++++++
 include/linux/iommu.h               |  8 +++++
 8 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
index b4574a76ac0b..f73bf96d231e 100644
--- a/drivers/cxl/cache.c
+++ b/drivers/cxl/cache.c
@@ -3,6 +3,7 @@
 
 #include <linux/pci.h>
 #include <cxl/cxl.h>
+#include <linux/iommu.h>
 
 #include "cxlcache.h"
 
diff --git a/drivers/cxl/core/cache.c b/drivers/cxl/core/cache.c
index 429c997b2ada..44323dfdb759 100644
--- a/drivers/cxl/core/cache.c
+++ b/drivers/cxl/core/cache.c
@@ -2,6 +2,7 @@
 /* Copyright (C) Advanced Micro Device, Inc. */
 
 #include <linux/iopoll.h>
+#include <linux/iommu.h>
 #include <linux/pci.h>
 #include <cxlcache.h>
 
@@ -806,3 +807,45 @@ void cxl_destroy_snoop_filters(void)
 
 	xa_destroy(&snoop_filters);
 }
+
+/**
+ * cxl_cache_configure_iommu() - Configure a device's IOMMU for CXL.cache
+ * @cxlds: struct cxl_dev_state of a cxl_cachedev that has been through
+ *	   CXL.cache probe
+ *
+ * Fails if the underlying PCI device supports ATS and IOMMU can't be
+ * configured, or if the device doesn't support ATS and is not attached to an
+ * identity IOMMU domain.
+ */
+int cxl_cache_configure_iommu(struct cxl_dev_state *cxlds)
+{
+	struct device *dev = cxlds->dev;
+	struct iommu_domain *domain;
+	int rc;
+
+	lockdep_assert_held(&dev->mutex);
+
+	if (!dev->iommu || !dev->iommu->iommu_dev)
+		return 0;
+
+	if (!device_iommu_capable(dev, IOMMU_CAP_PCI_ATS_SUPPORTED)) {
+		domain = iommu_get_domain_for_dev(dev);
+		if (!domain || domain->type != IOMMU_DOMAIN_IDENTITY)
+			return -EINVAL;
+
+		return 0;
+	}
+
+	rc = iommu_enable_cxl_ats(cxlds->dev);
+	if (rc == -EOPNOTSUPP) {
+		dev_warn(cxlds->dev,
+			"IOMMU doesn't support enabling CXL ATS requests; CXL.cache may not function properly.");
+		rc = 0;
+	} else if (rc) {
+		dev_err(cxlds->dev, "Failed to enable CXL ATS requests: %d\n",
+			rc);
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cache_configure_iommu, "CXL");
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 3dbe20023456..696d9879ce9b 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -107,6 +107,7 @@
 
 
 /* Extended Feature 2 Bits */
+#define FEATURE_CXLMEMATTR	BIT_ULL(0) /* WARNING: This bit isn't in the spec as of 09/26 */
 #define FEATURE_SEVSNPIO_SUP	BIT_ULL(1)
 #define FEATURE_GCR3TRPMODE	BIT_ULL(3)
 #define FEATURE_SNPAVICSUP	GENMASK_ULL(7, 5)
@@ -189,6 +190,7 @@
 #define CONTROL_EPH_EN		45
 #define CONTROL_XT_EN		50
 #define CONTROL_INTCAPXT_EN	51
+#define CONTROL_CXLMEMATTR_EN	57
 #define CONTROL_GCR3TRPMODE	58
 #define CONTROL_IRTCACHEDIS	59
 #define CONTROL_SNPAVIC_EN	61
@@ -355,6 +357,7 @@
  */
 #define DTE_FLAG_V	BIT_ULL(0)
 #define DTE_FLAG_TV	BIT_ULL(1)
+#define DTE_CXLMEM_MASK	GENMASK_ULL(6, 4)
 #define DTE_FLAG_HAD	(3ULL << 7)
 #define DTE_MODE_MASK	GENMASK_ULL(11, 9)
 #define DTE_HOST_TRP	GENMASK_ULL(51, 12)
@@ -831,6 +834,7 @@ struct iommu_dev_data {
 	u8 ppr          :1;		  /* Enable device PPR support */
 	bool use_vapic;			  /* Enable device to use vapic mode */
 	bool defer_attach;
+	u8 cxl_memattr;			  /* CXLMemAttr DTE setting */
 
 	struct ratelimit_state rs;        /* Ratelimit IOPF messages */
 };
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 40726dfef273..e11f98db826e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1125,6 +1125,14 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
 		iommu_feature_enable(iommu, CONTROL_GCR3TRPMODE);
 }
 
+static void iommu_enable_cxlmemattr(struct amd_iommu *iommu)
+{
+	if (!check_feature2(FEATURE_CXLMEMATTR) || !amd_iommu_iotlb_sup)
+		return;
+
+	iommu_feature_enable(iommu, CONTROL_CXLMEMATTR_EN);
+}
+
 /* sets a specific bit in the device table entry. */
 static void set_dte_bit(struct dev_table_entry *dte, u8 bit)
 {
@@ -2245,6 +2253,12 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 			return ret;
 	}
 
+	/* 
+	 * Set the CXLMemAttr control bit and do the Device Table Entry parts
+	 * of set up when a CXL.cache device shows up.
+	 */
+	iommu_enable_cxlmemattr(iommu);
+
 	ret = iommu_device_register(&iommu->iommu, &amd_iommu_ops, NULL);
 	if (ret || amd_iommu_pgtable == PD_MODE_NONE) {
 		/*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4dc306a4b5c6..78d34b907450 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -41,6 +41,7 @@
 #include <asm/dma.h>
 #include <uapi/linux/iommufd.h>
 #include <linux/generic_pt/iommu.h>
+#include <cxl/cxl.h>
 
 #include "amd_iommu.h"
 #include "iommufd.h"
@@ -2199,6 +2200,13 @@ static void set_dte_passthrough(struct iommu_dev_data *dev_data,
 
 }
 
+static void set_dte_cxl_mem_attr(struct iommu_dev_data *dev_data,
+				 struct dev_table_entry *new)
+{
+	new->data[0] &= ~DTE_CXLMEM_MASK;
+	new->data[0] |= FIELD_PREP(DTE_CXLMEM_MASK, dev_data->cxl_memattr);
+}
+
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data,
 			  phys_addr_t top_paddr, unsigned int top_level)
@@ -2217,11 +2225,14 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	else if (domain->domain.type == IOMMU_DOMAIN_IDENTITY)
 		set_dte_passthrough(dev_data, domain, &new);
 	else if ((domain->domain.type & __IOMMU_DOMAIN_PAGING) &&
-		 domain->pd_mode == PD_MODE_V1)
+		   domain->pd_mode == PD_MODE_V1)
 		set_dte_v1(dev_data, domain, domain->id, top_paddr, top_level, &new);
 	else
 		WARN_ON(true);
 
+	if (amd_iommu_iotlb_sup && check_feature2(FEATURE_CXLMEMATTR))
+		set_dte_cxl_mem_attr(dev_data, &new);
+
 	amd_iommu_update_dte(iommu, dev_data, &new);
 
 	/*
@@ -3190,6 +3201,14 @@ static int amd_iommu_def_domain_type(struct device *dev)
 		return IOMMU_DOMAIN_IDENTITY;
 	}
 
+	/*
+	 * CXL.cache devices that have no ATS capability need a passthrough
+	 * domain to function correctly.
+	 */
+	if (dev_is_pci(dev) && !pci_ats_supported(to_pci_dev(dev)) &&
+	    cxl_cache_supported(to_pci_dev(dev)))
+		return IOMMU_DOMAIN_IDENTITY;
+
 	return 0;
 }
 
@@ -3199,6 +3218,40 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 	return true;
 }
 
+static int amd_iommu_enable_cxl_ats(struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	int ret = 0;
+
+	if (!dev_data || !amd_iommu_iotlb_sup)
+		return -EINVAL;
+
+	if (!check_feature2(FEATURE_CXLMEMATTR))
+		return -ENXIO;
+
+	mutex_lock(&dev_data->mutex);
+
+	/* Already set up */
+	if (dev_data->cxl_memattr != 0)
+		goto out;
+
+	if (!dev_data->ats_enabled) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Give device the choice of whether to use CXL.io or CXL.cache and
+	 * whether accesses are snooped
+	 */
+	dev_data->cxl_memattr = 1;
+	dev_update_dte(dev_data, true);
+
+out:
+	mutex_unlock(&dev_data->mutex);
+	return ret;
+}
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.hw_info = amd_iommufd_hw_info,
@@ -3216,6 +3269,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.page_response = amd_iommu_page_response,
 	.get_viommu_size = amd_iommufd_get_viommu_size,
 	.viommu_init = amd_iommufd_viommu_init,
+	.enable_cxl_ats = amd_iommu_enable_cxl_ats,
 };
 
 #ifdef CONFIG_IRQ_REMAP
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd1bca7ede9a..5d82b5d09a3f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -4222,6 +4222,34 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_done);
 
+/*
+ * iommu_enable_cxl_ats() - Enable CXL source bit extension of ATS for the
+ * given device.
+ * @dev: CXL.cache-capable PCIe device to enable capability for
+ *
+ * Returns:
+ * + -ENODEV if no IOMMU present
+ * + -EOPNOTSUPP if IOMMU isn't CXL-aware or doesn't need extra set up
+ * + Result of enablement callback otherwise
+ *
+ * Required by devices looking to use CXL.cache with non-identity IOMMU domais:
+ * see CXL 4.0 specification, section 3.1.6 "Memory Type Indication on ATS"
+ */
+int iommu_enable_cxl_ats(struct device *dev)
+{
+	const struct iommu_ops *ops;
+
+	if (!dev_has_iommu(dev))
+		return -ENODEV;
+
+	ops = dev_iommu_ops(dev);
+	if (!ops->enable_cxl_ats)
+		return -EOPNOTSUPP;
+
+	return ops->enable_cxl_ats(dev);
+}
+EXPORT_SYMBOL_GPL(iommu_enable_cxl_ats);
+
 #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
 /**
  * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 5d550dd70870..0471d5c00144 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -8,6 +8,7 @@
 #include <linux/node.h>
 #include <linux/ioport.h>
 #include <cxl/mailbox.h>
+#include <linux/pci.h>
 
 /**
  * enum cxl_devtype - delineate type-2 from a generic type-3 device
@@ -274,6 +275,23 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
 struct cxl_cachedev *devm_cxl_add_cachedev(struct cxl_dev_state *cxlds);
 int devm_cxl_cachedev_alloc_snoop_capacity(struct cxl_cachedev *cxlcd,
 					   u64 size);
+int cxl_cache_configure_iommu(struct cxl_dev_state *cxlds);
+
+static inline bool cxl_cache_supported(struct pci_dev *pdev)
+{
+	int offset;
+	u16 cap;
+
+	offset = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					   PCI_DVSEC_CXL_DEVICE);
+	if (!offset)
+		return false;
+
+	if (pci_read_config_word(pdev, offset + PCI_DVSEC_CXL_CAP, &cap))
+		return false;
+
+	return cap & PCI_DVSEC_CXL_CACHE_CAPABLE;
+}
 #else
 static inline struct cxl_cachedev *
 devm_cxl_add_cachedev(struct cxl_dev_state *cxlds)
@@ -281,5 +299,9 @@ devm_cxl_add_cachedev(struct cxl_dev_state *cxlds)
 static inline int
 devm_cxl_cachedev_alloc_snoop_capacity(struct cxl_cachedev *cxlcd, u64 size)
 { return -ENXIO; }
+static inline int cxl_cache_configure_iommu(struct cxl_dev_state *cxlds)
+{ return -ENXIO; }
+static inline bool cxl_cache_supported(struct pci_dev *pdev)
+{ return false; }
 #endif /* CONFIG_CXL_CACHE */
 #endif /* __CXL_CXL_H__ */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ac43b8b93f14..aa1e42ec5e38 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -734,6 +734,7 @@ struct iommu_ops {
 	int (*viommu_init)(struct iommufd_viommu *viommu,
 			   struct iommu_domain *parent_domain,
 			   const struct iommu_user_data *user_data);
+	int (*enable_cxl_ats)(struct device *dev);
 
 	const struct iommu_domain_ops *default_domain_ops;
 	struct module *owner;
@@ -1222,6 +1223,8 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
 ioasid_t iommu_alloc_global_pasid(struct device *dev);
 void iommu_free_global_pasid(ioasid_t pasid);
 
+int iommu_enable_cxl_ats(struct device *dev);
+
 /* PCI device reset functions */
 int pci_dev_reset_iommu_prepare(struct pci_dev *pdev);
 void pci_dev_reset_iommu_done(struct pci_dev *pdev);
@@ -1549,6 +1552,11 @@ static inline ioasid_t iommu_alloc_global_pasid(struct device *dev)
 
 static inline void iommu_free_global_pasid(ioasid_t pasid) {}
 
+static inline int iommu_enable_cxl_ats(struct device *dev)
+{
+	return -ENODEV;
+}
+
 static inline int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 {
 	return 0;
-- 
2.53.0

