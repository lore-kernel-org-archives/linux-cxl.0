Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEF6634E2
	for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847145; cv=fail; b=oxTCnM8IfSFa8LG0Ftr1u+c+23B57RevA9UCip7R0EusAE4m47Ybq7fV7oPbTaIR8pkej0r5yvH/FW6YQjx+FOYTz60tIFSvtATPfnQB8e6a5cgQNinvVkqhHfzxa4kBQW8+/EdkFlg+7PirGsGuWmQqYep4R3ro39CjZN2djFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847145; c=relaxed/simple;
	bh=HFLthIfn9AtWJc5j+N2AHQ1h8gyFPwXbSGUFgQZBQcE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psHqCMNOLeXPJwBzPHqdOCV3kMQ2RdO+6q8o0BdLeESjHIf/o+ewBlSH/q98sg7yOTjvhABgxAcyX+iSfpJcvCYFQ7AR4BwnLQo8yLaUTI0U7LVRszu7PN/dBmMNtHA35hte2LNCBIC9UccgwDgLxC3GRQp+oHSR7JpkR1vadLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nho5phFm; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nho5phFm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6AUk8ne+O4814rsxOdvgiey6UHKbHD4VwQhrticflYYdTprxkntuddSngBqNPj2FWqHBWrFf8egy2eelJxhk9o19dW/zkhTU/5xzwIn0CFcYnJNXcIcZDu70WK1uI11Ho1f/prqmPPNVQUT21nwCGGt1D5slEhWVWTuIpYzA6LFSHnt/eehYK0huTgMyL+ew5quBN+RH1Sx8uda5h1ATxyB8J5P43wHG2Y+VRjqrm9/n66h5MxaDwVJfyCnTa9dibc51DRNMwS3122MWfG7EYeseQvDPPnbNMahnI7BE/q8qNNvGReymyoCe9AYOZcDYjUcame1WRaqjohU7iDFwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07snWkj8/D+ofAWAJbmqaj/kX7dw5JkwPvwZeL36KWA=;
 b=W+nCJ3LY3EQ2R3J8o8cDhQKQW/yJf0F606z6u5uAxyB/hmXydWEP0ErPC39QYip4oXwS0KMs9n+RHK4x6obEkx3RuoIicM6R+thmc0nrrAVOs+c1L7mFVn/PfX7ZDzidmLmsZYP0/ufx4c/eCZt4Xz3BBaDslOvmq3cD0XFDlQnrv8XuZsQnl47tewfXUd+PV0/Eg/XsjC884eOTh3SS/QTICfhQ9J7pIZEixI/O49MX5JoixZmPeS9BoG3PSVoeJ3WkEa7kTum+yuBUpDqhmabJE1pYEtmsSTU1RqaHArhGJ5P5PEz7ccBSMRYAEVSkf2WDDqYETnvxBW8dJmbrQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07snWkj8/D+ofAWAJbmqaj/kX7dw5JkwPvwZeL36KWA=;
 b=nho5phFmgQ1qZyU5I5EQEW637+0Pc+3yNj4nQ2VEjwHKG8ZHivOYHZOjdWPfaYupkQtqwtrUSS8gCrxD6G39GCzd+3gAW2a1S9SbPlcjLb7gNcpW8M0Ghzi9LPRB3/LjsVPhZIHkKq7QsyNh3krG8EUUSQyCVtj3mwIMDyu1yWM=
Received: from BN0PR03CA0049.namprd03.prod.outlook.com (2603:10b6:408:e7::24)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 08:12:19 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::65) by BN0PR03CA0049.outlook.office365.com
 (2603:10b6:408:e7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27 via Frontend
 Transport; Thu, 16 May 2024 08:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 08:12:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 03:12:18 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 03:12:17 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC PATCH 02/13] cxl: add type2 device basic support
Date: Thu, 16 May 2024 09:11:51 +0100
Message-ID: <20240516081202.27023-3-alucerop@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: b14c2c3d-d01f-49cc-f11a-08dc757fe815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B+k1AXiind9KpMpV0ucn4rzc8Yet3XTMSBmqcPenCXnWvBbyhVdP90exJqSK?=
 =?us-ascii?Q?rEYWUYGpHOI+sJP8rjo2wXQh4kwuRdiwdQ8Pga0Lmhje7VEUd16FqWU0mSKS?=
 =?us-ascii?Q?cODOLWmC4U2n+d2Fp8P0W9kgHVHncZG2CTExDRjnXYiToeovEcGqNS/fTCRM?=
 =?us-ascii?Q?UPrJwtgbXVsFVHK9r/ksczR7Lc66vgCnDs0Cms00pJcGy5VsbQbuiamRqQtl?=
 =?us-ascii?Q?daZjeW5xHENwMsFEM/8HtKvAcxui4M1mRN7M5vJJZEEzmtJK0uavgFIntKjw?=
 =?us-ascii?Q?OX+QFTAcyD5EkMDaKMgRua3M/vgL5FjJZ8LAS9hwlwnd1bVHWvAwlBHSQaIG?=
 =?us-ascii?Q?sbfbQqMEhEuMP7LZVNCQbjXPWYUC2Pt1JrKqeqzebSCi/YI1xjig8ghBcyuF?=
 =?us-ascii?Q?CDuhlBnGs3KYhx+ps2ezdgwZiYRlYsE0ODKRLvMz6f9dovSovb+WHfhtJEhM?=
 =?us-ascii?Q?M3oiv6+vb2EIb8k/4/bjq4HBpe3DijkJwuP5XITfOFDOBs36TKHeKACXlL2c?=
 =?us-ascii?Q?zaVgX4dQ0VbmIYiq2pwJDWg3G0OIzPvrzZRn7w/T0DE5G0S6+sasRERP5xZQ?=
 =?us-ascii?Q?7xPeq79L4yu3f7wlah6H++I12MpocNjKhMlVyhh6tnXbNxZ944FcZESYrPvk?=
 =?us-ascii?Q?C2g19PBVHvoXNQSeQz9AMqeaQx9v5ciItpI5ogYF5EkRbE7/vQ/vIe2NBmYt?=
 =?us-ascii?Q?9FLW3eyKMQz+a2vKkZuQxhJaV3m30InMW5YW99DZ0W7EPjF0pAXq/DYxHk/x?=
 =?us-ascii?Q?i/f6JvT+xomZEuxJa44JB0PccjmTlI5dBhWmEd8emMVvZFujquPV5AZDDlcr?=
 =?us-ascii?Q?fyikx2/2FX8BMF7icsvC+M/haoKnmeXEVQIICy3BmiJKQNoz244G9ojrHegg?=
 =?us-ascii?Q?e6srZEsNz1T5jYQlqZ05aTNPJESEX9gpuhSomjUA8RMwbQ5dKqgbaXkzjQux?=
 =?us-ascii?Q?ZflwKsWeubHH3bWy+rvFwX3Y+XFZ7NaRQDrrL3h5LjX+1kqLVwLnxY6sqgNd?=
 =?us-ascii?Q?w/T3kbs8UDORhxgjkuW4VE2c1vGxK9sPHrfCNCy5E8K37YSPQZjiGzlP6lEu?=
 =?us-ascii?Q?3o2LphFDxQtuIZ9dpwvIf2qrRwt1dFViX6NIFzv75fB+hu1z6Mx7D76R/6tg?=
 =?us-ascii?Q?2y2HyTjrvApHLjSgwvZumT3aaTvJAy/Euq1KzZEQ1dgO5VHqujiM8243MRS9?=
 =?us-ascii?Q?rsb413msZc9uXT2Bj/uQ6QUXIgshQjBocl0QPORDz0R6mTZa8OTGpK5q7CdQ?=
 =?us-ascii?Q?u8cVGHUoKVZktz72SJHZQc4NYoDdmkq/FNv+w84jfjO70LF21hfQ+Rf6LV1Y?=
 =?us-ascii?Q?D7xN33ZiAa/ACU8KpBRFmRCIMBb2LutqmilmyBzcCP+Dr6bQT3B0XoNSLcN2?=
 =?us-ascii?Q?qNxTnx6wOub7K4l5LWLquyi6XHiu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:12:19.4191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b14c2c3d-d01f-49cc-f11a-08dc757fe815
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170

From: Alejandro Lucero <alucerop@amd.com>

Differientiating Type3, aka memory expanders, from Type2, aka device
accelerators, with a new function for initializing cxl_dev_state.

Adding a type2 driver for a CXL emulated device inside CXL kernel
testing infrastructure as a client for the functionality added.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c           | 15 ++++++
 include/linux/cxlmem.h              |  2 +
 tools/testing/cxl/Kbuild            |  1 +
 tools/testing/cxl/type2/Kbuild      |  7 +++
 tools/testing/cxl/type2/pci_type2.c | 80 +++++++++++++++++++++++++++++
 5 files changed, 105 insertions(+)
 create mode 100644 tools/testing/cxl/type2/Kbuild
 create mode 100644 tools/testing/cxl/type2/pci_type2.c

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 07cd0b8b026f..0336b3f14f4a 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -659,6 +659,21 @@ static void detach_memdev(struct work_struct *work)
 
 static struct lock_class_key cxl_memdev_key;
 
+struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
+{
+	struct cxl_dev_state *cxlds;
+
+	cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
+	if (!cxlds)
+		return ERR_PTR(-ENOMEM);
+
+	cxlds->dev = dev;
+	cxlds->type = CXL_DEVTYPE_DEVMEM;
+
+	return cxlds;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
+
 static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 					   const struct file_operations *fops)
 {
diff --git a/include/linux/cxlmem.h b/include/linux/cxlmem.h
index 0d26a45a4af2..e8d12b543db1 100644
--- a/include/linux/cxlmem.h
+++ b/include/linux/cxlmem.h
@@ -859,4 +859,6 @@ struct cxl_hdm {
 struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
+
+struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
 #endif /* __CXL_MEM_H__ */
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 030b388800f0..a285719c4db6 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -69,3 +69,4 @@ cxl_core-y += cxl_core_exports.o
 KBUILD_CFLAGS := $(filter-out -Wmissing-prototypes -Wmissing-declarations, $(KBUILD_CFLAGS))
 
 obj-m += test/
+obj-m += type2/
diff --git a/tools/testing/cxl/type2/Kbuild b/tools/testing/cxl/type2/Kbuild
new file mode 100644
index 000000000000..a96ad4d64924
--- /dev/null
+++ b/tools/testing/cxl/type2/Kbuild
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-m += pci_type2.o
+
+cxl_pci_type2-y := cxl_pci_type2.o
+
+KBUILD_CFLAGS := $(filter-out -Wmissing-prototypes -Wmissing-declarations, $(KBUILD_CFLAGS))
diff --git a/tools/testing/cxl/type2/pci_type2.c b/tools/testing/cxl/type2/pci_type2.c
new file mode 100644
index 000000000000..863ce7dc28ef
--- /dev/null
+++ b/tools/testing/cxl/type2/pci_type2.c
@@ -0,0 +1,80 @@
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/cxl.h>
+#include <linux/cxlpci.h>
+#include <linux/cxlmem.h>
+
+struct cxl_dev_state *cxlds;
+
+#define CXL_TYPE2_MEM_SIZE   (1024*1024*256)
+
+static int type2_pci_probe(struct pci_dev *pci_dev,
+			   const struct pci_device_id *entry)
+
+{
+	u16 dvsec;
+
+	dvsec = pci_find_dvsec_capability(pci_dev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
+
+	if (!dvsec) {
+		pci_info(pci_dev, "No CXL capability (vendor: %x\n", pci_dev->vendor);
+		return 0;
+	} else {
+		pci_info(pci_dev, "CXL CXL_DVSEC_PCIE_DEVICE capability found");
+	}
+
+	cxlds = cxl_accel_state_create(&pci_dev->dev);
+	if (IS_ERR(cxlds))
+		return PTR_ERR(cxlds);
+
+	pci_info(pci_dev, "Initializing cxlds...");
+	cxlds->cxl_dvsec = dvsec;
+	cxlds->serial = pci_dev->dev.id;
+
+	/* Should not this be based on DVSEC range size registers */
+	cxlds->dpa_res = DEFINE_RES_MEM(0, CXL_TYPE2_MEM_SIZE);
+	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, CXL_TYPE2_MEM_SIZE, "ram");
+
+	return 0;
+}
+
+static void type2_pci_remove(struct pci_dev *pci_dev)
+{
+
+}
+
+/* PCI device ID table */
+static const struct pci_device_id type2_pci_table[] = {
+	{PCI_DEVICE(PCI_VENDOR_ID_AMD, 0xbabe)},
+	{0}                     /* end of list */
+};
+
+static struct pci_driver type2_pci_driver = {
+	.name           = KBUILD_MODNAME,
+	.id_table       = type2_pci_table,
+	.probe          = type2_pci_probe,
+	.remove         = type2_pci_remove,
+};
+
+static int __init type2_cxl_init(void)
+{
+	int rc;
+
+	rc = pci_register_driver(&type2_pci_driver);
+
+	return rc;
+}
+
+static void __exit type2_cxl_exit(void)
+{
+	pci_unregister_driver(&type2_pci_driver);
+}
+
+module_init(type2_cxl_init);
+module_exit(type2_cxl_exit);
+
+MODULE_AUTHOR("Alejadro Lucero <alucerop@amd.com>");
+MODULE_DESCRIPTION("CXL Type2 device support, driver test");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(CXL);
+MODULE_DEVICE_TABLE(pci, type2_pci_table);
-- 
2.17.1

