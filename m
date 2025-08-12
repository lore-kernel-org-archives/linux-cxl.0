Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45212F0661
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 21:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034436; cv=fail; b=JqOYnb4Y3y6o/wXtLBK6sjsSBztbZzFOfBEkKdr6UE8alWFwbsF8lseHI3NbTLihCJ6AliUt+aM+1rDYcdL6OuxkcjvRAay0Wt2l3U+5X+WRDONBRR00Bvm0LMD6XZ/3/oadCPz6vs+rcp5r/6Hx4F4ZBJ1PWFQj86FkAv+VAXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034436; c=relaxed/simple;
	bh=5wxyJnFkh0MTePF/TR7Ihtss9JIao4tiLgZctBKTnQU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXWhxh9Z0uPF4SBd9A3BLpEIW9OULbyErkWqgghB7+fv7BexrNEq5UxHCTDdkoXWurX8OoViq2VP++p5yayuzqYhSKa8prQwQZQVi/+q/s5SC5QHdDujL5e9XwFEAoEHpkmpdEFPnp24CS8wU3cuqKE+yaz5y5+1Esi7nGQI82A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CLldU84d; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CLldU84d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ph/AW2NYckrr9ZOBVMgRQkUzqH1nz74+mk5YO6Ae7WGUeFhcK2TdHDTDq11QnB34vJVZbRTCzEmgSfL8W00D1xkTAsr0TvxnM8alcrP/T+gaWwfz3XV3aQUaQqW0Ox38zxCTv9mPhh2n5q2pNkV5MixiroGloD9sA/1UJ68OIpTixOQrX9NG71Di8vj+VIHCDZJtrVKBz76LTAWuaDO5cwv59/XUVJLm3YjWh17rsdbUDdY96GQJU29PowgZSjROjtnxARApO12V0opSUZSztyNy+ZZZy7KFI1HRZEKPOlrr3C61WWOQsg/hzJNZAGAwrEHqpK+q8vcPKxDr0ObmHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAcjQcp4waVnFM9lmO1BPdCNE52H0SFfEfxs8ZAct/k=;
 b=Dtk8V7CfmGzXCDBR7380+N/i6bZQdbsHrRNNjqvicyPyqbVeg+PLEobjPfwlIrFoanyDXR+mZDVZeVmsxPPanyFFzKwXwHwIrxL0WR374Zpq72kFZKOi06l0t0kcS3FTcq+JbWgSHPazvkjxOp2mnEEiEUTycng0h+kxVglSLGdVwtE2BTrSpT2JjPX9gJUjZxxeqOFecSKdYbpmIWJR96O/+2OYCuuOFpeHuFl9Vq7G/VmHBfyUVv9Jr6L86qkygjh6VzoKPQkf/WLdoy/GthHjddalsARUq74f8V2D3dUMJRS4Pc1kprfgbUcOqBQzygihRr5r4uF+W3opo0O9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAcjQcp4waVnFM9lmO1BPdCNE52H0SFfEfxs8ZAct/k=;
 b=CLldU84dSk3t5P1fw1G0jo7z18/lTjMtpLde14Sg0jrhBDQCsCypuPAoBACOCPbvqOr+4cRMBjnj42F0rxBlcOyX+d3r6WpQXYU7WQD+6QfimiKHPBqfxYpteI72MpsxEk9q2fmeCw/atVO4UqldfH+0TFOeQJ7VZ8eGSrLOUBI=
Received: from CH0PR03CA0117.namprd03.prod.outlook.com (2603:10b6:610:cd::32)
 by BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 21:33:50 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::a5) by CH0PR03CA0117.outlook.office365.com
 (2603:10b6:610:cd::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 21:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 21:33:50 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 16:33:49 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [RFC PATCH 18/18] cxl/core: Add cache device cache management attributes
Date: Tue, 12 Aug 2025 16:29:21 -0500
Message-ID: <20250812212921.9548-19-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|BL4PR12MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9ed92d-90eb-4c81-c6a6-08ddd9e7ed87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?baRvP3SaVrts9FsI3YIvhhAGUBQddSDfj0nLkyVHZxK/fRLJg6VUSRN9ogsD?=
 =?us-ascii?Q?4Su93u9UdtkOnzyoNYTaBOG89B95DAqEWT4xVk+GbcWRR5KF0q4bmLLB1PSt?=
 =?us-ascii?Q?5mBwvobN1pzEsI8+uoB5eLrKUPfdcAv15hopLto7NUnOLrZDrz2PJUwO3Fky?=
 =?us-ascii?Q?jjqqLi9LhShH/OP52PXMjGrF4nIIv/SHt8tlMjMod5ZOYCOhrJjqa1zS2lZB?=
 =?us-ascii?Q?1wX+FfhaJmZLHT4HZa/UG0U3HpPztQeTPaZ1QJ2NkzquahNXzUUaazuwyD0u?=
 =?us-ascii?Q?ZZrmNHBx4sCwQEHmVhRTGqt5bzyw4fiFERABREypqrDOL8EIoh5R/zSNAaar?=
 =?us-ascii?Q?Kv0gCMQZJhB0McqfiUtyMFyjjRjCmzJcWPaY/BVefSyfMq1qz4P9qce9Zrhu?=
 =?us-ascii?Q?/NHexjezayrL/8BAY9gCkyBGOmx59IhOu7WmmtLU3SNfJREY365jmVI8pI+M?=
 =?us-ascii?Q?SrgpBicGrPzwyF7rOfxzFEoQdq2oGqdPqGEf5PuZXNUZcYl9L7i7hTcHUc9A?=
 =?us-ascii?Q?qKtpeIHAYadEBmK7fS2GxByszbVuEkiB5dC0Wnii2OSAuT+4Xb+c0H8XSKUR?=
 =?us-ascii?Q?ZnIv6aPI7jMz0PWfv8qOmSkl75YmOVb2iLasX4ntEOUC7zNcq+9tfknZTck6?=
 =?us-ascii?Q?TTQUiEIF0dFC0JW3gvKkr31AlyZCK1s9laZLQCNwO8nyxkxc76eBXXCpqHgA?=
 =?us-ascii?Q?XGsJtZwM17dzL0/Nnm9eQ89ku/ecEFm0HXiMr4kyI9wa+YiEvdd6uKXUHMCG?=
 =?us-ascii?Q?A0iLEgs6fNTMlnG1a6Ae4Ddljs1/VDcjut3PpA88udpV2l124ozFedPIddOB?=
 =?us-ascii?Q?myKpb4tKfPq2bz8qSxj44t5El87U44/BB0SmgTsE09T0LyBMznezuasIZwch?=
 =?us-ascii?Q?i1xgC+/PP7RI9z0EIuRoj+ZsBps2BxAorQVngez9d3YUS033XSf12oOF+IPW?=
 =?us-ascii?Q?0PZQ0Fawr4HUue0LSPBAWYEZ/XUpBrXu+ss6z7P+1yQj5c5il66Qk/hI4Xgu?=
 =?us-ascii?Q?8uFgHsaiA7lV5svH/WkjO29hG6oLhTgg09nOeQipo4HE4vbpDZ9KYUtncG7g?=
 =?us-ascii?Q?XkZxZ61GqLaXfUwDXwnMC9/+OnfAMuVCZJta4WHH1C7B3JMl3yQzIASu+UBK?=
 =?us-ascii?Q?1+oOw8NDIp3AzacFMY4qRYaoVnYZWIWvBw0L7YVbxXUfHBeApU29N3O1Pa6c?=
 =?us-ascii?Q?Gc2VXvbDxy2gnXb5ocgu+2b8Pn5fP7FxRniJxULUF+uAHDus9cg9J8Ct3zgB?=
 =?us-ascii?Q?iWV5/ADbyVCWXIYBo85lc0umJKWjY+TrXE/M/tvT2SRpAsr85v+WJxsD/jdR?=
 =?us-ascii?Q?hy3leMUIfL1CcvLMhll/AI18BlWXNYMHoBcqkKWSRJI6BmiPEYK21yh6YVc6?=
 =?us-ascii?Q?p9fhTREQFEocabZnzwk/Zmgbv3I4ZpsBDtWXxjDnoFbMiqOUSoeChSPMBtNX?=
 =?us-ascii?Q?vg+j3mMV+wWpfPaIe18m5IH3i6d0nJsgkxDfCV0phIcyDSxzhQgIZSaNVu+5?=
 =?us-ascii?Q?vC/5t3nC1xfFiGZDVACqJFBI/4z1rbGalT9R?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:33:50.1424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9ed92d-90eb-4c81-c6a6-08ddd9e7ed87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9505

Add functions to cxl/core/pci.c to manage the cache of a CXL.cache
enabled endpoint. Add these new functions to sysfs attributes for
userspace accessibility.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/cachedev.c | 99 +++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/pci.c      | 89 +++++++++++++++++++++++++++++++++
 drivers/cxl/cxlcache.h      |  4 ++
 drivers/cxl/cxlpci.h        |  6 +++
 4 files changed, 198 insertions(+)

diff --git a/drivers/cxl/core/cachedev.c b/drivers/cxl/core/cachedev.c
index 1cdd94520ceb..85989cdd1eb8 100644
--- a/drivers/cxl/core/cachedev.c
+++ b/drivers/cxl/core/cachedev.c
@@ -5,6 +5,7 @@
 #include <linux/pci.h>
 
 #include "../cxlcache.h"
+#include "../cxlpci.h"
 #include "private.h"
 
 static DEFINE_IDA(cxl_cachedev_ida);
@@ -125,9 +126,107 @@ static struct attribute_group cxl_cachedev_cache_attribute_group = {
 	.is_visible = cxl_cachedev_cache_visible,
 };
 
+static ssize_t cache_disable_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t n)
+{
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+	bool disable;
+	int rc;
+
+	rc = kstrtobool(buf, &disable);
+	if (rc)
+		return rc;
+
+	rc = cxl_accel_set_cache_disable(cxlds, disable);
+	if (rc)
+		return rc;
+
+	return n;
+}
+
+static ssize_t cache_disable_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+	int rc;
+
+	rc = cxl_accel_caching_disabled(cxlds);
+	if (rc < 0)
+		return rc;
+
+	return sysfs_emit(buf, "%d\n", rc);
+}
+static DEVICE_ATTR_RW(cache_disable);
+
+static ssize_t cache_invalid_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+	int rc;
+
+	rc = cxl_accel_cache_invalid(cxlds);
+	if (rc < 0)
+		return rc;
+
+	return sysfs_emit(buf, "%d\n", rc);
+}
+static DEVICE_ATTR_RO(cache_invalid);
+
+static ssize_t init_wbinvd_store(struct device *dev,
+				 struct device_attribute *attr, const char *buf,
+				 size_t n)
+{
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+	int rc;
+
+	rc = cxl_accel_initiate_wbinvd(cxlds);
+	return rc ? rc : n;
+}
+static DEVICE_ATTR_WO(init_wbinvd);
+
+static struct attribute *cxl_cachedev_mgmt_attributes[] = {
+	&dev_attr_cache_disable.attr,
+	&dev_attr_cache_invalid.attr,
+	&dev_attr_init_wbinvd.attr,
+	NULL,
+};
+
+static umode_t cxl_cachedev_mgmt_visible(struct kobject *kobj,
+					 struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	u16 cap;
+	int rc;
+
+	rc = pci_read_config_word(pdev, cxlds->cxl_dvsec + CXL_DVSEC_CAP_OFFSET,
+				  &cap);
+	if (rc)
+		return 0;
+
+	if (!(cap & CXL_DVSEC_WBINVD_CAPABLE) &&
+	    a == &dev_attr_init_wbinvd.attr)
+		return 0;
+
+	return a->mode;
+}
+
+static struct attribute_group cxl_cachedev_mgmt_attribute_group = {
+	.attrs = cxl_cachedev_mgmt_attributes,
+	.is_visible = cxl_cachedev_mgmt_visible,
+};
+
 static const struct attribute_group *cxl_cachedev_attribute_groups[] = {
 	&cxl_cachedev_attribute_group,
 	&cxl_cachedev_cache_attribute_group,
+	&cxl_cachedev_mgmt_attribute_group,
 	NULL,
 };
 
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 2279c2690c59..667f75043f9e 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1232,3 +1232,92 @@ int cxl_accel_get_cache_info(struct cxl_dev_state *cxlds)
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_accel_get_cache_info, "CXL");
+
+int cxl_accel_caching_disabled(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int dvsec, rc;
+	u16 ctrl2;
+
+	device_lock_assert(cxlds->dev);
+
+	if (!dev_is_pci(cxlds->dev))
+		return -EINVAL;
+	pdev = to_pci_dev(cxlds->dev);
+
+	dvsec = cxlds->cxl_dvsec;
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &ctrl2);
+	if (rc)
+		return rc;
+
+	return !!(ctrl2 & CXL_DVSEC_DISABLE_CACHING);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_caching_disabled, "CXL");
+
+int cxl_accel_set_cache_disable(struct cxl_dev_state *cxlds, bool disable)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int dvsec, rc;
+	u16 ctrl2;
+
+	if (!dev_is_pci(cxlds->dev))
+		return -EINVAL;
+
+	guard(device)(cxlds->dev);
+	dvsec = cxlds->cxl_dvsec;
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &ctrl2);
+	if (rc)
+		return rc;
+
+	if (!!(ctrl2 & CXL_DVSEC_DISABLE_CACHING) == disable)
+		return 1;
+
+	ctrl2 &= ~CXL_DVSEC_DISABLE_CACHING;
+	ctrl2 |= FIELD_PREP(CXL_DVSEC_DISABLE_CACHING, disable);
+	return pci_write_config_word(pdev, dvsec + CXL_DVSEC_DISABLE_CACHING,
+				     ctrl2);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_set_cache_disable, "CXL");
+
+int cxl_accel_initiate_wbinvd(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int dvsec, rc;
+	u16 ctrl2;
+
+	if (!dev_is_pci(cxlds->dev))
+		return -EINVAL;
+
+	if (cxl_accel_caching_disabled(cxlds) != 1)
+		return -EBUSY;
+
+	guard(device)(cxlds->dev);
+	dvsec = cxlds->cxl_dvsec;
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &ctrl2);
+	if (rc)
+		return rc;
+
+	ctrl2 |= CXL_DVSEC_INIT_WBINVD;
+	return pci_write_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET,
+				     ctrl2);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_initiate_wbinvd, "CXL");
+
+int cxl_accel_cache_invalid(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int dvsec, rc;
+	u16 stat2;
+
+	if (!dev_is_pci(cxlds->dev))
+		return -EINVAL;
+
+	guard(device)(cxlds->dev);
+	dvsec = cxlds->cxl_dvsec;
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_STAT2_OFFSET, &stat2);
+	if (rc)
+		return rc;
+
+	return !!(stat2 & CXL_DVSEC_CACHE_INVALID);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_cache_invalid, "CXL");
diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
index 60563b391844..14e6f543ade9 100644
--- a/drivers/cxl/cxlcache.h
+++ b/drivers/cxl/cxlcache.h
@@ -35,4 +35,8 @@ int devm_cxl_port_program_cache_idrt(struct cxl_port *port,
 int cxl_dport_program_cache_idd(struct cxl_dport *dport,
 				struct cxl_cachedev *cxlcd);
 
+int cxl_accel_set_cache_disable(struct cxl_dev_state *cxlds, bool disable);
+int cxl_accel_caching_disabled(struct cxl_dev_state *cxlds);
+int cxl_accel_cache_invalid(struct cxl_dev_state *cxlds);
+int cxl_accel_initiate_wbinvd(struct cxl_dev_state *cxlds);
 #endif
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index e5dd132be7e7..dc0800d79cf6 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -20,8 +20,14 @@
 #define     CXL_DVSEC_CACHE_CAPABLE	BIT(0)
 #define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
 #define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
+#define     CXL_DVSEC_WBINVD_CAPABLE	BIT(6)
 #define   CXL_DVSEC_CTRL_OFFSET		0xC
 #define     CXL_DVSEC_MEM_ENABLE	BIT(2)
+#define   CXL_DVSEC_CTRL2_OFFSET	0x10
+#define     CXL_DVSEC_DISABLE_CACHING	BIT(0)
+#define     CXL_DVSEC_INIT_WBINVD	BIT(1)
+#define   CXL_DVSEC_STAT2_OFFSET	0x12
+#define     CXL_DVSEC_CACHE_INVALID	BIT(0)
 #define   CXL_DVSEC_CAP2_OFFSET		0x16
 #define     CXL_DVSEC_CACHE_UNIT_MASK	GENMASK(3, 0)
 #define     CXL_DVSEC_CACHE_SIZE_MASK	GENMASK(15, 8)
-- 
2.34.1

