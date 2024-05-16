Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13596CDA8
	for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847154; cv=fail; b=BOAd0YyrwAlGsrM3VKIm6WP0UYvtABtO2vVBAQHEDz7ajIQ5f5/t7ERgW5xJryYUuTq4IrsEZ07Qcw7OcgAqwI+TpUdGI4fmr1/jadjMrPIifCUPWdTH9wplQoJonSLZ/LSrowjPXeKs06TDqOTvbcyhX2m7+kWaT2LTQe1GCFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847154; c=relaxed/simple;
	bh=zWniedtFUPzl0E11HR7iGxGdL1Juxo/80C4yAXA9b/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VPeSA2wM8KZCa/W0j6P+KvWAmklR1wE8SXcpKwTFnX4HbSTJ4pBUm2+SfLEATS93VN1FFhjqvr2yHfC+ehOOwhu/MN4/vTAZaDRlR544eMk+1NlB0aVdsbB56l2CF57PrcEDJvhh6QpFvTfLRnOJbPuA2ux28HT3X/xaAUhz8Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gPatzai9; arc=fail smtp.client-ip=40.107.101.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gPatzai9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lULLiB/lhZwGHQlH+ZT+q8ZVCiyYtWD6FmfLv6DpBk6kcyW/QGSIzwc1Sb4asaJsn1qnXBb4FaUcD2fXCAdri2ZAZXbQAuNXg/L4Fipg1QG6eLF4Jy0I08v9ewQ0xPVL0PoeOwTdaT00e6gG/1fOl02u1Uk/PMg3g4wvpKeo34xdZekeYin2Zc2kVOhFteEvG6PSEHHrd0JYDxvZV+YdAaBVpGuviKFDc6m3S7rsVH4nxF1LVw/UJxlu9FFknKiAfA+Nm1AP5BZQG//kVjdaS6aSCg2JGo/MSBcyrIaW/ZPC9HvEZBjHFL/3s9Dxd14PGRR1RKOTDEDwIHJraxSkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcWDwP022Mxfy9oYIZXBqD/mFXuQt8zU0PrNQs3Db2Q=;
 b=lZDxVjx2xZ1P/lIqnE4qBgi4p92hd/VFpffQKB55F4bTU4prUX611BmHQx5blndbLDWHqqyHmR0iNrZqBpwKSFGNIdwCVNv1mRBC0MKCAgk9DLnW3b9vJI9wZyJEP/Y6ZfDJyq+oNWxp4h7eDTA+9qF19vvQRMKJkGYS4KBDhVLXClGu/JJ/CbgUjWb2bfRD6kjHRabNDFKuC2x1LMK+zgptTspx4Vu6fSHuR564aQTjUPmRHkWZgxuakIBo5OBi3V5PvgyS7TpP8RU22M48qaJOpHzlOAK6dOJJW8x4ZCYNfDwkWI38eJaM5Tx4dqiLSo5CxvEv61jSZujBHBInMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcWDwP022Mxfy9oYIZXBqD/mFXuQt8zU0PrNQs3Db2Q=;
 b=gPatzai9Xc7kv2467X+29bTLs84EmmExvYfBInAeFeYLRStT8LpC1fd7TgFeux+9yj470+YvryzBNUpB+XpdKS1lgTeRZ1RWW0VDraVA5qarP2918kfA3rXglqoK0WLfoD7PRia8XxH9zqAohFlYW2tJZPZJ8Fnd7L2onA9vH2c=
Received: from MN2PR19CA0065.namprd19.prod.outlook.com (2603:10b6:208:19b::42)
 by LV8PR12MB9336.namprd12.prod.outlook.com (2603:10b6:408:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Thu, 16 May
 2024 08:12:29 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:19b:cafe::1f) by MN2PR19CA0065.outlook.office365.com
 (2603:10b6:208:19b::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 08:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 08:12:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 03:12:27 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 03:12:27 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC PATCH 11/13] cxl: allow automatic region creation by type2 drivers
Date: Thu, 16 May 2024 09:12:00 +0100
Message-ID: <20240516081202.27023-12-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240516081202.27023-1-alucerop@amd.com>
References: <20240516081202.27023-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|LV8PR12MB9336:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f98d85c-b48a-4d7d-8b5b-08dc757fee43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0fDlsnWgLwHkMSFm1ey1W+Tjm8Szm0VmWBRxB9ukArFNMUZBkNVM2SgVoGqT?=
 =?us-ascii?Q?rRttYBt/jtn4ec2eAQbuLndwxkX6YCHFJR6D9h9hr2TKZSVn9N3uyxkCqDEJ?=
 =?us-ascii?Q?FWRSL9z2LmpKtqiAW/Q0X2I6FtEfkZVH3/qYHAIu8HzH0ssjB8mtIZ28MOFG?=
 =?us-ascii?Q?p0/KW+rWW8oL0pkX0h5j80VmZOa2Lfiz6fqgtUNe7VcCXatcRbYmmInBB2HE?=
 =?us-ascii?Q?oO1Z31gCJMWgCK/ImVF8gSFbuOgtPk62Djq/pMaDmBFfnch14uUYuUNNV2Md?=
 =?us-ascii?Q?MH+4M/GFlF/FmquqlTdfVfj/OcoYnpkXwn3eGrazcN7pI95rNkwYqxQJ2zqD?=
 =?us-ascii?Q?+1KO/30DQLMAdvY6+SOq5Ygongwhv24SlbMDl/or7Sh/9ywOBeesot0cTAE1?=
 =?us-ascii?Q?PQDNJYnrVUrFSoeogbxiDszq47nRKYmN4g0yTPVRQdStLNRdJZyWCWv0rn7o?=
 =?us-ascii?Q?77OsYK3L8HPZNAl9MfqVbvumIFAdTzrPnbDVrx2bTsXo2bgBfwjpHQFU/7Ka?=
 =?us-ascii?Q?yR08KR5g7CGrYCbS313Av3MQ9Yy1D5f5+q10AXRoH3ynkJSSu7KvnUNGyUOO?=
 =?us-ascii?Q?BqskqYt3pwEhSZyxVAODQ5eCx58CdF8ky926dVxUKjvYAkNf2xcKE12+CrQu?=
 =?us-ascii?Q?Xs1gUYmw3skp0GbHuKSLJcCLVnvFhdvPFKUbGdRK+BVX39rCEQLu69pes0Sc?=
 =?us-ascii?Q?Cxd8r5+U/lcXp+W4I7eepzaOmhl0JWtxvuQjidoA/iK5+TjSTCn08v7u+zpG?=
 =?us-ascii?Q?nrS/bIboUx/3S8YI33rrIEFsvOuPGzGFGtAcE+m1AgpmoYMqkS32PPSNCQLm?=
 =?us-ascii?Q?cYX3Ybl4O08Hg3CtZ2GEc/nIu1R9P8zc/6wA5+u+HVZA7JX6Qnug59G/Csrk?=
 =?us-ascii?Q?N31fCh85fqe0mFHewxmw8eecLzeQTlJ9zzIHyfexLoih0wTNxKLhe8X9v8KE?=
 =?us-ascii?Q?xakILz/3U9y/tiwRZQbktoSrKS+gSbSG5u2Y5GSryzSMbZEu126EIMiki98P?=
 =?us-ascii?Q?OzIkChqx+fFzy7PFibIhnqAgwC1UzeIF+4ryrwhLiC2N7msHJsaAYEnCRClX?=
 =?us-ascii?Q?1mZeHvrnyvHmmb33TedwzZEaGlhQ7mzsXeFMOmfV8HNhT5VNgJ3Zu9zLx+q0?=
 =?us-ascii?Q?CTKBKRwKjClfrj2julG/40ElD9TvKgaIkqgUWjKPTFE7X/FZC76yGJZYZj3f?=
 =?us-ascii?Q?w1o+BGqdcwdmAVrHUEpMpHfNhHkMqrxAmTOGORbr5+50dy0fL5XYrzkYi2d8?=
 =?us-ascii?Q?C+d1ZVd2bgSuxviGuYGswTxuf1xhp0iuwPKQAAhNLC37dwTty0fOZoGRykOY?=
 =?us-ascii?Q?Luc0nkV+hmf/buOyZe0dTYMbwc440O1RRof/AakEbTFHhzTzIBLffc18RjAv?=
 =?us-ascii?Q?LUJyDGHYdQwQn0YaexFggzdC/6f+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:12:29.7843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f98d85c-b48a-4d7d-8b5b-08dc757fee43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9336

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Adding that functionality and integrating it with current support for
memory expanders.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c           | 262 ++++++++++++++++++++++------
 include/linux/cxlmem.h              |   4 +
 tools/testing/cxl/type2/pci_type2.c |  18 ++
 3 files changed, 228 insertions(+), 56 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8228b7e96d8d..014684ff4343 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -479,22 +479,14 @@ static ssize_t interleave_ways_show(struct device *dev,
 
 static const struct attribute_group *get_cxl_region_target_group(void);
 
-static ssize_t interleave_ways_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t len)
+static int set_interleave_ways(struct cxl_region *cxlr, int val)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	unsigned int val, save;
-	int rc;
+	int save, rc;
 	u8 iw;
 
-	rc = kstrtouint(buf, 0, &val);
-	if (rc)
-		return rc;
-
 	rc = ways_to_eiw(val, &iw);
 	if (rc)
 		return rc;
@@ -509,25 +501,42 @@ static ssize_t interleave_ways_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
-		return rc;
-	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
-		rc = -EBUSY;
-		goto out;
-	}
+	lockdep_assert_held_write(&cxl_region_rwsem);
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
+		return -EBUSY;
 
 	save = p->interleave_ways;
 	p->interleave_ways = val;
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
 	if (rc)
 		p->interleave_ways = save;
-out:
+
+	return rc;
+}
+
+static ssize_t interleave_ways_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	unsigned int val;
+	int rc;
+
+	rc = kstrtouint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	rc = down_write_killable(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+
+	rc = set_interleave_ways(cxlr, val);
 	up_write(&cxl_region_rwsem);
 	if (rc)
 		return rc;
 	return len;
 }
+
 static DEVICE_ATTR_RW(interleave_ways);
 
 static ssize_t interleave_granularity_show(struct device *dev,
@@ -547,21 +556,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
 	return rc;
 }
 
-static ssize_t interleave_granularity_store(struct device *dev,
-					    struct device_attribute *attr,
-					    const char *buf, size_t len)
+static int set_interleave_granularity(struct cxl_region *cxlr, int val)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	int rc, val;
+	int rc;
 	u16 ig;
 
-	rc = kstrtoint(buf, 0, &val);
-	if (rc)
-		return rc;
-
 	rc = granularity_to_eig(val, &ig);
 	if (rc)
 		return rc;
@@ -577,21 +579,36 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
 		return -EINVAL;
 
+	lockdep_assert_held_write(&cxl_region_rwsem);
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
+		return -EBUSY;
+
+	p->interleave_granularity = val;
+	return 0;
+}
+
+static ssize_t interleave_granularity_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	int rc, val;
+
+	rc = kstrtoint(buf, 0, &val);
+	if (rc)
+		return rc;
+
 	rc = down_write_killable(&cxl_region_rwsem);
 	if (rc)
 		return rc;
-	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
-		rc = -EBUSY;
-		goto out;
-	}
 
-	p->interleave_granularity = val;
-out:
+	rc = set_interleave_granularity(cxlr, val);
 	up_write(&cxl_region_rwsem);
 	if (rc)
 		return rc;
 	return len;
 }
+
 static DEVICE_ATTR_RW(interleave_granularity);
 
 static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
@@ -2666,6 +2683,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
 	return to_cxl_region(region_dev);
 }
 
+static void drop_region(struct cxl_region *cxlr)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+
+	devm_release_action(port->uport_dev, unregister_region, cxlr);
+}
+
 static ssize_t delete_region_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t len)
@@ -3135,17 +3160,18 @@ static int match_region_by_range(struct device *dev, void *data)
 	return rc;
 }
 
-/* Establish an empty region covering the given HPA range */
-static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+static void construct_region_end(void)
+{
+	up_write(&cxl_region_rwsem);
+}
+
+static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
+						 struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxlrd_to_port(cxlrd);
-	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
-	struct resource *res;
-	int rc;
+	int err = 0;
 
 	do {
 		cxlr = __create_region(cxlrd, cxled->mode,
@@ -3154,8 +3180,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-		dev_err(cxlmd->dev.parent,
-			"%s:%s: %s failed assign region: %ld\n",
+		dev_err(cxlmd->dev.parent,"%s:%s: %s failed assign region: %ld\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__, PTR_ERR(cxlr));
 		return cxlr;
@@ -3165,23 +3190,47 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	p = &cxlr->params;
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_err(cxlmd->dev.parent,
-			"%s:%s: %s autodiscovery interrupted\n",
+			"%s:%s: %s region setup interrupted\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__);
-		rc = -EBUSY;
-		goto err;
+		err = -EBUSY;
+	}
+
+	if (err) {
+		construct_region_end();
+		drop_region(cxlr);
+		return ERR_PTR(err);
 	}
+	return cxlr;
+}
+
+
+/* Establish an empty region covering the given HPA range */
+static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
+					   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct range *hpa = &cxled->cxld.hpa_range;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	struct resource *res;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
+	if (IS_ERR(cxlr))
+		return cxlr;
 
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
 
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
 	if (!res) {
 		rc = -ENOMEM;
-		goto err;
+		goto out;
 	}
 
 	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
 				    dev_name(&cxlr->dev));
+
 	rc = insert_resource(cxlrd->res, res);
 	if (rc) {
 		/*
@@ -3194,6 +3243,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 			 __func__, dev_name(&cxlr->dev));
 	}
 
+	p = &cxlr->params;
 	p->res = res;
 	p->interleave_ways = cxled->cxld.interleave_ways;
 	p->interleave_granularity = cxled->cxld.interleave_granularity;
@@ -3201,24 +3251,124 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
 	if (rc)
-		goto err;
+		goto out;
 
 	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
-		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
-		dev_name(&cxlr->dev), p->res, p->interleave_ways,
-		p->interleave_granularity);
+				   dev_name(&cxlmd->dev),
+				   dev_name(&cxled->cxld.dev), __func__,
+				   dev_name(&cxlr->dev), p->res,
+				   p->interleave_ways,
+				   p->interleave_granularity);
 
 	/* ...to match put_device() in cxl_add_to_region() */
 	get_device(&cxlr->dev);
 	up_write(&cxl_region_rwsem);
+out:
+	construct_region_end();
+	if (rc) {
+		drop_region(cxlr);
+		return ERR_PTR(rc);
+	}
+	return cxlr;
+}
+
+static struct cxl_region *
+__construct_new_region(struct cxl_root_decoder *cxlrd,
+		       struct cxl_endpoint_decoder **cxled, int ways)
+{
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p;
+	resource_size_t size = 0;
+	struct cxl_region *cxlr;
+	int rc, i;
+
+	/* If interleaving is not supported, why does ways need to be at least 1? */
+	if (ways < 1)
+		return ERR_PTR(-EINVAL);
+
+	cxlr = construct_region_begin(cxlrd, cxled[0]);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	rc = set_interleave_ways(cxlr, ways);
+	if (rc)
+		goto out;
+
+	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
+	if (rc)
+		goto out;
+
+	down_read(&cxl_dpa_rwsem);
+	for (i = 0; i < ways; i++) {
+		if (!cxled[i]->dpa_res)
+			break;
+		size += resource_size(cxled[i]->dpa_res);
+	}
+	up_read(&cxl_dpa_rwsem);
+
+	if (i < ways)
+		goto out;
+
+	rc = alloc_hpa(cxlr, size);
+	if (rc)
+		goto out;
+
+	down_read(&cxl_dpa_rwsem);
+	for (i = 0; i < ways; i++) {
+		rc = cxl_region_attach(cxlr, cxled[i], i);
+		if (rc)
+			break;
+	}
+	up_read(&cxl_dpa_rwsem);
+
+	if (rc)
+		goto out;
+
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc)
+		goto out;
 
+	p = &cxlr->params;
+	p->state = CXL_CONFIG_COMMIT;
+out:
+	construct_region_end();
+	if (rc) {
+		drop_region(cxlr);
+		return ERR_PTR(rc);
+	}
 	return cxlr;
+}
 
-err:
-	up_write(&cxl_region_rwsem);
-	devm_release_action(port->uport_dev, unregister_region, cxlr);
-	return ERR_PTR(rc);
+/**
+ * cxl_create_region - Establish a region given an array of endpoint decoders
+ * @cxlrd: root decoder to allocate HPA
+ * @cxled: array of endpoint decoders with reserved DPA capacity
+ * @ways: size of @cxled array
+ *
+ * Returns a fully formed region in the commit state and attached to the
+ * cxl_region driver.
+ */
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder **cxled,
+				     int ways)
+{
+	struct cxl_region *cxlr;
+
+	mutex_lock(&cxlrd->range_lock);
+	cxlr = __construct_new_region(cxlrd, cxled, ways);
+	mutex_unlock(&cxlrd->range_lock);
+
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	if (device_attach(&cxlr->dev) <= 0) {
+		dev_err(&cxlr->dev, "failed to create region\n");
+		drop_region(cxlr);
+		return ERR_PTR(-ENODEV);
+	}
+	return cxlr;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
 
 int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 {
diff --git a/include/linux/cxlmem.h b/include/linux/cxlmem.h
index caf1cd86421c..fc963c2c2dc4 100644
--- a/include/linux/cxlmem.h
+++ b/include/linux/cxlmem.h
@@ -875,4 +875,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
 					     resource_size_t min,
 					     resource_size_t max);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder **cxled,
+				     int ways);
+
 #endif /* __CXL_MEM_H__ */
diff --git a/tools/testing/cxl/type2/pci_type2.c b/tools/testing/cxl/type2/pci_type2.c
index 6499d709f54d..0e7f17c0c920 100644
--- a/tools/testing/cxl/type2/pci_type2.c
+++ b/tools/testing/cxl/type2/pci_type2.c
@@ -4,8 +4,10 @@
 #include <linux/cxlpci.h>
 #include <linux/cxlmem.h>
 
+struct cxl_region_params *region_params;
 struct cxl_endpoint_decoder *cxled;
 struct cxl_root_decoder *cxlrd;
+struct cxl_region *efx_region;
 struct cxl_dev_state *cxlds;
 struct cxl_memdev *cxlmd;
 struct cxl_port *endpoint;
@@ -109,6 +111,22 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
 		goto out;
 	}
 
+	pci_info(pci_dev, "cxl create_region...");
+	efx_region = cxl_create_region(cxlrd, &cxled, 1);
+	if (!efx_region) {
+		rc = PTR_ERR(cxled);
+		goto out_dpa;
+	}
+
+	region_params = &efx_region->params;
+	pci_info(pci_dev, "CXL region: start=%llx, end=%llx\n", region_params->res->start,
+			  region_params->res->end);
+
+	cxl_release_endpoint(cxlmd, endpoint);
+	return 0;
+
+out_dpa:
+	cxl_dpa_free(cxled);
 out:
 	cxl_release_endpoint(cxlmd, endpoint);
 
-- 
2.17.1

