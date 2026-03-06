Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013012.outbound.protection.outlook.com [40.93.196.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635B347DD6F
	for <linux-cxl@vger.kernel.org>; Fri,  6 Mar 2026 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772815681; cv=fail; b=k7krZWn+5TDh4X3Ezuj6PelS/jTtGc7pkSPLnJsfzTKbCVVL1Fom6+d/jbNJ26cQYBstCul002bp8BHGIxBau5KTu2Y+mpEkVwuYqXWfDluwh1FAZ0fXLluLEV11N+XYKTGZAUio5i6Wg9klDR2ly8ysmleyUAybJZyHnh/b3pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772815681; c=relaxed/simple;
	bh=s7vmOv0E2h9TA7atJdOQkGUkVT7LJxky98pHj5me67w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qaN0MG038gREncB4WJ7UIVSBynID9Kb+L7w2RQaQ/KQ/G+X/Md2pkZHQ0rW6fn+3cU6lY3bCY6PlptBA+fJmJgFlO9Hq5ABcmMwSLhiZZKOMDZgqYavdwvNllgMRPlUIAwTjgTI0E7ET9l+oFqAJXWV7hZ4q8UKK4YXF0sXvYL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gTD54s9s; arc=fail smtp.client-ip=40.93.196.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gTD54s9s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTcYfE8T3f5dcPSAQzqAREbEbVekiPIRi0nIthiaJACxO9HYKh1InTHyEql/5qdju35yePMtcaixrylWaKVfWSYHKr4qEhid656LIFW43OocMqfSQliVrmcwlrfKNz3U5P5IurRG5TR0pUAfHLJxZj0k8nSay0IR0oCEpFjL+eib0KGwVr/z7s9Ha9nrVdOz/AhSIznKlW0P8gOwpK7MVHU3C9D3cLHR/hzp049jLy8uRaSfu2BgqCWUYGg+nlqYWmy/T7n4GCvuxQ8/ATp2XaT6u9/a/XQtqgHuhlXjqrKPU88IeInlfjYA4Ml3FzNW7CMc9nocP2uuuWK/qlV1Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+eBZ+PIGmvTtALNNKQLjAh+aOVOZB07eP6VBQOYyzE=;
 b=ez5s5pT3ro7odufo7zQ9gU5+Wv1MV7ghxXk6FT/Becu4hwDhYdd/gD+3XDbKi/1NAIzCIstUKqj/R5JMQMkT4jNBSmuD2t9iRhwK5+YhHCZCnLMZUNOO8/19uXFIcsix5MnqLt6ndpHgaC1IM6NsjgANbYsIshpXorMDhhfTXzicgOUeFn2KUHyJp7wsc7PHPPo0aHxops4h6BbPSMfQ3YlghhLImKCgRRMACKxxzPyI3mkbIIZbSGgVCW9HHF/ZScwvRaalmLu6koacWurlUJ0pewWFsxuHvxYbjP4EkfY75kOKkJYFxVym4CW4gJHNj/AzmFDflyhstNutq02sFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+eBZ+PIGmvTtALNNKQLjAh+aOVOZB07eP6VBQOYyzE=;
 b=gTD54s9sOs1gHdJ7OwG2GzyOB4uKgiozUT9vjA7VJFS7QnKeV18AaI30EODkSLOjJB68X5JRcjieKVQtqVNQEwI9qw9gwoM1Mv2BZRfqZyqgpeSzGh+XWYFdBCd24cNI5vNO3szWjQAPqEkaGAEnq/JxsePaUgav+guQ2HgUR7g=
Received: from SA0PR11CA0143.namprd11.prod.outlook.com (2603:10b6:806:131::28)
 by CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 16:47:51 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:131:cafe::e9) by SA0PR11CA0143.outlook.office365.com
 (2603:10b6:806:131::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Fri,
 6 Mar 2026 16:47:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 16:47:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 10:47:50 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 08:47:50 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 6 Mar 2026 10:47:49 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <gourry@gourry.net>
CC: Alejandro Lucero <alucerop@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v4 1/4] cxl: support Type2 when initializing cxl_dev_state
Date: Fri, 6 Mar 2026 16:47:38 +0000
Message-ID: <20260306164741.3796372-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306164741.3796372-1-alejandro.lucero-palau@amd.com>
References: <20260306164741.3796372-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: fffb9f05-83fd-4d3a-fd11-08de7ba01aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	3X6J/GYWFz5pGOVwL6ePDZV2p4CAcOoiImAGaYwBLk4r4BM4p/5KKRG28thl7hT/czjVX8NNiE/YsWDTCcQvT9xS6ImAUNTEpuXShHGuM85vmWD2p0rMHFmSXoSkcSWNeV4wVghsHQZSyQG0LEMs3n9XVqKlITH4R6bdCtZsk68nWGG70yopfqwnN0Sm1FicTfmu2S+6iCiYwxXMY4Tvodul6PS2ZdcYvoGwHXvGkmgysxY+v6i1k35dXywB/FHbOkiCKOhpZH+PjEARomSmyaZYrfvQ/L7vl5nQX2e+Tdr+mdVAQuaTnXVLTnH5f1kATfil6Mxp36Jo32O5H11LSXeDaY9H+n5Zy3/i/UhgSjRweqaWnhJltPrngxGPhZPF01Ihaop3CVWbA4Rn9YK91XthbXTR5ZynuYhn0z0RBhRHESuiUJ/6qvQEdp7nxTFjiCxBxBhPMio4r6Rdk3s5dBzb68MH9D1zqEdPQ172sP3ckogjZxry6wyXQUCEvbi2Q/FchPXraApzbUoDMkW/xJMjpFF36Y11LyYOmmxW6NhRR4bwvcKPdniZdtCGE4jzfkEHaORnkCNPAB9kVFHKb0ziHE+ECzEeW6rnm8dMI2a9/PK8wjva7nqPInCB4tPDGIXM2LroSeK5LsdxJ4AHtgAtBilgOYO1OK/W9wnKs9XMTcsH6SrL1nihttvPYmprt0sApojT9OFIIiHQTbAurA82xHj7JTWIw18s6OaTiuoFdjiKFyeFhDByiGptb3FgpcOdKC5mfLYJqoqskQdoaA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tx2fdHhTy8/ExMrhRKQjl43k3YmKWUPXwBQPuz3/6S9FhrQ/8/Ds++1nLShfdUsNlfNi0xDxq8GRyfQltpxqxkLImI//WDoLVOoqk/0o+aYcLD5ySIh/aZ8dcN5FWWtzJcckOV1pcQ/cC17lFQq2XXZrnNfcxJRy9TCyGKzlIvgkoTh34OV7fm1WfPMSmaZZR8AnNpdi8jD4m9EJ4IlGI5+5t46hUBAyQsoscD97I1r9P//UosjiKJ5AwoOu7SYv74byUhmCJoEvBqKYEVD7Q7y6FAe22fclovUzA0WHJDHbtNsmTroURKU7e0F/CgdUQr1Ck8JElDHd3rNLeML9VYuCa4HrAfk+CRitjUEidzibMXMp/p1BvKuVVwCiWa0XENVrY3tCUtG973lA4KurJM1xXt1qj+GIpN0mreCnBR/P3itrvqgB5xsK1cUyNrCI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:47:50.9409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fffb9f05-83fd-4d3a-fd11-08de7ba01aee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129

From: Alejandro Lucero <alucerop@amd.com>

In preparation for type2 drivers add function and macro for
differentiating CXL memory expanders (type 3) from CXL device
accelerators (type 2) helping drivers built from public headers
to embed struct cxl_dev_state inside a private struct.

Update type3 driver for using this same initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 drivers/cxl/core/mbox.c      | 12 +++++-------
 drivers/cxl/core/memdev.c    | 24 ++++++++++++++++++++++++
 drivers/cxl/cxlmem.h         | 34 +++++++++++++++++++++++++++++++++-
 drivers/cxl/pci.c            | 14 +++++++-------
 tools/testing/cxl/test/mem.c |  3 +--
 5 files changed, 70 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index fa6dd0c94656..bee84d0101d1 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1514,23 +1514,21 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
 
-struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
+struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
+						 u16 dvsec)
 {
 	struct cxl_memdev_state *mds;
 	int rc;
 
-	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
+	mds = devm_cxl_dev_state_create(dev, CXL_DEVTYPE_CLASSMEM, serial,
+					dvsec, struct cxl_memdev_state, cxlds,
+					true);
 	if (!mds) {
 		dev_err(dev, "No memory available\n");
 		return ERR_PTR(-ENOMEM);
 	}
 
 	mutex_init(&mds->event.log_lock);
-	mds->cxlds.dev = dev;
-	mds->cxlds.reg_map.host = dev;
-	mds->cxlds.cxl_mbox.host = dev;
-	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
-	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
 
 	rc = devm_cxl_register_mce_notifier(dev, &mds->mce_notifier);
 	if (rc == -EOPNOTSUPP)
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index f547d8ac34c7..5b4988870b74 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -656,6 +656,30 @@ static void detach_memdev(struct work_struct *work)
 
 static struct lock_class_key cxl_memdev_key;
 
+struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
+						 enum cxl_devtype type,
+						 u64 serial, u16 dvsec,
+						 size_t size, bool has_mbox)
+{
+	struct cxl_dev_state *cxlds = devm_kzalloc(dev, size, GFP_KERNEL);
+
+	if (!cxlds)
+		return NULL;
+
+	cxlds->dev = dev;
+	cxlds->type = type;
+	cxlds->serial = serial;
+	cxlds->cxl_dvsec = dvsec;
+	cxlds->reg_map.host = dev;
+	cxlds->reg_map.resource = CXL_RESOURCE_NONE;
+
+	if (has_mbox)
+		cxlds->cxl_mbox.host = dev;
+
+	return cxlds;
+}
+EXPORT_SYMBOL_NS_GPL(_devm_cxl_dev_state_create, "CXL");
+
 static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 					   const struct file_operations *fops,
 					   const struct cxl_memdev_attach *attach)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index e21d744d639b..71367cb5178c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -523,6 +523,37 @@ to_cxl_memdev_state(struct cxl_dev_state *cxlds)
 	return container_of(cxlds, struct cxl_memdev_state, cxlds);
 }
 
+struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
+						 enum cxl_devtype type,
+						 u64 serial, u16 dvsec,
+						 size_t size, bool has_mbox);
+
+/**
+ * cxl_dev_state_create - safely create and cast a cxl dev state embedded in a
+ * driver specific struct.
+ *
+ * @parent: device behind the request
+ * @type: CXL device type
+ * @serial: device identification
+ * @dvsec: dvsec capability offset
+ * @drv_struct: driver struct embedding a cxl_dev_state struct
+ * @member: name of the struct cxl_dev_state member in drv_struct
+ * @mbox: true if mailbox supported
+ *
+ * Returns a pointer to the drv_struct allocated and embedding a cxl_dev_state
+ * struct initialized.
+ *
+ * Introduced for Type2 driver support.
+ */
+#define devm_cxl_dev_state_create(parent, type, serial, dvsec, drv_struct, member, mbox)	\
+	({										\
+		static_assert(__same_type(struct cxl_dev_state,				\
+			      ((drv_struct *)NULL)->member));				\
+		static_assert(offsetof(drv_struct, member) == 0);			\
+		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
+						      sizeof(drv_struct), mbox);	\
+	})
+
 enum cxl_opcode {
 	CXL_MBOX_OP_INVALID		= 0x0000,
 	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
@@ -858,7 +889,8 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
 int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
 int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
-struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
+struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
+						 u16 dvsec);
 void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index fbb300a01830..a42f273ff72b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -865,25 +865,25 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	int rc, pmu_count;
 	unsigned int i;
 	bool irq_avail;
+	u16 dvsec;
 
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
 	pci_set_master(pdev);
 
-	mds = cxl_memdev_state_create(&pdev->dev);
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		pci_warn(pdev, "Device DVSEC not present, skip CXL.mem init\n");
+
+	mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec);
 	if (IS_ERR(mds))
 		return PTR_ERR(mds);
 	cxlds = &mds->cxlds;
 	pci_set_drvdata(pdev, cxlds);
 
 	cxlds->rcd = is_cxl_restricted(pdev);
-	cxlds->serial = pci_get_dsn(pdev);
-	cxlds->cxl_dvsec = pci_find_dvsec_capability(
-		pdev, PCI_VENDOR_ID_CXL, PCI_DVSEC_CXL_DEVICE);
-	if (!cxlds->cxl_dvsec)
-		dev_warn(&pdev->dev,
-			 "Device DVSEC not present, skip CXL.mem init\n");
 
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
 	if (rc)
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index cb87e8c0e63c..79f42f4474d4 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1716,7 +1716,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	mds = cxl_memdev_state_create(dev);
+	mds = cxl_memdev_state_create(dev, pdev->id + 1, 0);
 	if (IS_ERR(mds))
 		return PTR_ERR(mds);
 
@@ -1732,7 +1732,6 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
 	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
 
-	cxlds->serial = pdev->id + 1;
 	if (is_rcd(pdev))
 		cxlds->rcd = true;
 
-- 
2.34.1

