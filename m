Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB984307AF0
	for <linux-cxl@vger.kernel.org>; Thu, 23 Apr 2026 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965260; cv=fail; b=nss1h9avkErWDV920oU3H7nx7YLOnMuz9rotyWgv3m2gUbcJt/1lCCL2xK3bQV1ExqRqavfwBuYqQGyCn09Mp+P/lzVzedsfBtpXOU/rovvZDGFiyRxOJ8NK6f+TqX7Ufz9s1sstiUpcPWd36RYC5sw4mhDviPLzntHKlL0fvBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965260; c=relaxed/simple;
	bh=/5OEZk8qA4cgwM62Ufg/+6ZJnTQH9fiOR98+DZwYSh4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7rDvcprFhuu8RO89n/HGkIR/2tPBtAXH6dF2MPFHTcMQkWBYh6dC0U8wImtbGeu7SPCgGggaGNcfBDb33z40YsdqKhU8W2WvfOXKcmkvGFmcJ+eRixBxy4WV1FCvQT1ZsP0S357+ZcSzzPVeVycdS9orS+j3sCCS0JmPc394aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TP/mXD5x; arc=fail smtp.client-ip=52.101.52.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TP/mXD5x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYrLz1ot1waS/PqeV7i9JXvcjksSjXn4sJykAdO4TSCFQ/C6afzQD03HeYM9nowoZihYk/HmsQanvOm2bamYjAiR8gGNNMD87FAgUs26aE3eO4kv19fkxzMpAhAK65dtI4ohWcWGIGCyZzfzCE4hQ/mfEfUxICnZC8+mnjuYpuqBTkbzj3HpjVSSmgQhDvXsOTYHFv1G9kXPwqWGCopzZpPN4fmTIhv82aWlnT/fzCOo8b9DK58VYm12QaxMTWlkktbkU2/8Yw1ePSSxNAWmMGqo9pZNqGHfCEDLNpj67/iIJ3ikd+ur0YvCzOR25weGu/87/nXtgkZ0WBhMkXH4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgAVOLoDTB3v90wWxw45YkioqoI4JXlu4JoaSkpBFpI=;
 b=k2S7wtG7Bz/cv+tfdDq94eGS8D2ve379911l17NnP8aoDwfhb5uuvZlNjzyOwcGCfBLiHcLJTYdRRwsp3HXRqp+PMAYadGTlh9lj0kXJSpUTGM6svnYFCYtagAprIIVquJylUy3fczjuFgoRmNdl+mfdgdEgzG6MUTyPulLwRbGxXnXO7/cegdkgCNbsO5UCsiVhRuepsupF7mKMDB4qHVTD33BW3L1KaBDtQrvKDu9stpbIE2+nh2eNO48zYlg0pHeWiC+NAOoLmtECkhaimDs6sUYgBm5lXnknfYvUYxaXOSfBB0UKZeDfPm7HNBVDnkmqA03AkZraUekGEnwhHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgAVOLoDTB3v90wWxw45YkioqoI4JXlu4JoaSkpBFpI=;
 b=TP/mXD5xCGZlasdFtn0GWYrtms++ty+fKL/lIQYJ0HXfzk0HycARig9IeOJUh+PH+xIAcVSrU5wwNd0qoH7mMQIhrttJn+wi5IlmF6oBvC1PQ2vtGa5WEm1DWpSITqL5Awk8hVAMEPgT+beNK961VBD4+aPOtBCKYMvbIJqk/H0=
Received: from MN2PR14CA0022.namprd14.prod.outlook.com (2603:10b6:208:23e::27)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 17:25:32 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::e3) by MN2PR14CA0022.outlook.office365.com
 (2603:10b6:208:23e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Thu,
 23 Apr 2026 17:25:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 17:25:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Apr
 2026 12:25:31 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 23 Apr 2026 12:25:30 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
Subject: [PATCH v26 4/8] cxl: Prepare memdev creation for type2
Date: Thu, 23 Apr 2026 19:05:24 +0100
Message-ID: <20260423180528.17166-5-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: d25f1ab1-6649-41e2-40a2-08dea15d525d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fNGrs5+xPbSkDN0zl3/MV3bDZCwX5Cl/dbY5Q1jmS3yLx/0uRVKta1wunQcX83XGhZTXrmURtZZ28ulROszi+WcA0Aru9ikxTOKvK2eaeG5lXci7FQpRaJhpUJ5lyG6DGDeYxaJWKk1i2NBIPjTECli+YoZLECAbEysLvXseRWvRt3PXTJN1/E9Mke1dHrxG7NiDpX+duErswvsP+LQwi8gDINeyAAc+/kV83uZ1n9LolVp5Z6fusyQyuOGpINlaqc6Qkw0myXjEakxOGdv5ra4IpQigb8JIFI7zGoNXl0HWcMMEVmsSBksmbwHFBWfHM1qfSz44yzEwzcH22jzfd3Wlkxc2nOFJO0L+sKiDirhjm5I24ouekVrYXCsiJ3L5r5/TykhdgXL5DLrP56zg2Fd9g5lIKWmeXyCUedHUWbGmpeyTTp7W1R9a6IBs1rUK9KUYZSxF9t2/5HezZfHQzksyur7pR3ZsAqiUyB8TZagKljs2IFz7hKpOf8PWoJ44PTlbp59XTfq0j0B8dtJ0LkXw71b5qv6fP+AB4YHS0oipLf1pIiQJs1PKzT4Um92D1a4Ws8U2AJa7xdX3z+w/84i8VECo8qCdDfw34Z3IY6AGvT+YatUEbh+6gAJ/g17y201GjEHnhcUNuFwTMFzMg198wMVoHud8407xs/tRWJADPJz5aQIPkxyCiWDcFSsh1O/g99y+gDYTQajezP7Zs9cHx5lOI09VxF+q+qk/bTv7Yyog2gn7WOT49AefV7G4H6hzlipTjaD5VcYRUyFZ5g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SATu+UsXdGh6/v5C/AGhY5j5wK6Id20Gj1pZs0k29fE9cEN8/+jPfnSGqG6jS42Gbzv8U9Nnc+HI3oHkAHOMV3YcPE0snhtHv574bIxjxkMaRW+PAWnxBitIvV//mOPc5RCKPQZyN4/xy2TZwIZFirlve9PnyepGrW3wdR7Kc86DofTehOnzFtUnXcyZ517tKmx0O3YRBa+jnLeigIL8fxM8W3I2aUVgaNvWwrSaF3oK/138LZ1ag8iwvbGMGXsZJPYEE0uos3+C61ah+ZXQT2Vw3TexV0gUhCUiuowd/xsErTidkSb6zZis6WuQiE6Calt25ShNNZ6bKTUb6znx2SInnJ1zV1wpGVfq4cyyHdAUsvyNl5viIAxCmY+ZOA85fAjFIyrs4KE1eOlzwYVBOKVFu6bj0HEghVkNPn0vD9WemWosH7nNBeyBgaKjbv8v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 17:25:31.8623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d25f1ab1-6649-41e2-40a2-08dea15d525d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231

From: Alejandro Lucero <alucerop@amd.com>

Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
creating a memdev leading to problems when obtaining cxl_memdev_state
references from a CXL_DEVTYPE_DEVMEM type.

Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
support.

Make devm_cxl_add_memdev accessible from an accel driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c | 15 +++++++++++--
 drivers/cxl/cxlmem.h      |  6 ------
 drivers/cxl/mem.c         | 45 +++++++++++++++++++++++++++++----------
 include/cxl/cxl.h         |  6 ++++++
 4 files changed, 53 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index b8ff1c07e528..ef39803bb139 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <linux/pci.h>
+#include <cxl/cxl.h>
 #include <cxlmem.h>
 #include "trace.h"
 #include "core.h"
@@ -579,9 +580,16 @@ static const struct device_type cxl_memdev_type = {
 	.groups = cxl_memdev_attribute_groups,
 };
 
+static const struct device_type cxl_accel_memdev_type = {
+	.name = "cxl_accel_memdev",
+	.release = cxl_memdev_release,
+	.devnode = cxl_memdev_devnode,
+};
+
 bool is_cxl_memdev(const struct device *dev)
 {
-	return dev->type == &cxl_memdev_type;
+	return (dev->type == &cxl_memdev_type ||
+		dev->type == &cxl_accel_memdev_type);
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
 
@@ -776,7 +784,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 	dev->parent = cxlds->dev;
 	dev->bus = &cxl_bus_type;
 	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
-	dev->type = &cxl_memdev_type;
+	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
+		dev->type = &cxl_accel_memdev_type;
+	else
+		dev->type = &cxl_memdev_type;
 	device_set_pm_not_required(dev);
 	INIT_WORK(&cxlmd->detach_work, detach_memdev);
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 776c50d1db51..92cca400d113 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -34,10 +34,6 @@
 	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
 	 CXLMDEV_RESET_NEEDED_NOT)
 
-struct cxl_memdev_attach {
-	int (*probe)(struct cxl_memdev *cxlmd);
-};
-
 /**
  * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
  * @dev: driver core device object
@@ -103,8 +99,6 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 
 struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
 					 const struct cxl_memdev_attach *attach);
-struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
-				       const struct cxl_memdev_attach *attach);
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index fcffe24dcb42..ff858318091f 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -65,6 +65,26 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
 			 cxl_debugfs_poison_clear, "%llx\n");
 
+static void cxl_memdev_poison_enable(struct cxl_memdev_state *mds,
+				     struct cxl_memdev *cxlmd,
+				     struct dentry *dentry)
+{
+	/*
+	 * Avoid poison debugfs for DEVMEM aka accelerators as they rely on
+	 * cxl_memdev_state.
+	 */
+	if (!mds)
+		return;
+
+	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
+		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
+				    &cxl_poison_inject_fops);
+
+	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
+		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
+				    &cxl_poison_clear_fops);
+}
+
 static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
@@ -92,12 +112,7 @@ static int cxl_mem_probe(struct device *dev)
 	dentry = cxl_debugfs_create_dir(dev_name(dev));
 	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
 
-	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
-		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_inject_fops);
-	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
-		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_clear_fops);
+	cxl_memdev_poison_enable(mds, cxlmd, dentry);
 
 	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
 	if (rc)
@@ -206,16 +221,24 @@ static ssize_t trigger_poison_list_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(trigger_poison_list);
 
-static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
+static bool cxl_poison_attr_visible(struct kobject *kobj, struct attribute *a)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
-	if (a == &dev_attr_trigger_poison_list.attr)
-		if (!test_bit(CXL_POISON_ENABLED_LIST,
-			      mds->poison.enabled_cmds))
-			return 0;
+	if (!mds ||
+	    !test_bit(CXL_POISON_ENABLED_LIST, mds->poison.enabled_cmds))
+		return false;
+
+	return true;
+}
+
+static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	if (a == &dev_attr_trigger_poison_list.attr &&
+	    !cxl_poison_attr_visible(kobj, a))
+		return 0;
 
 	return a->mode;
 }
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 1346771edc4e..10a9b8fa2f6b 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -149,6 +149,10 @@ struct cxl_dpa_partition {
 
 #define CXL_NR_PARTITIONS_MAX 2
 
+struct cxl_memdev_attach {
+	int (*probe)(struct cxl_memdev *cxlmd);
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -225,4 +229,6 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 	})
 
 int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
+struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
+				       const struct cxl_memdev_attach *attach);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1

