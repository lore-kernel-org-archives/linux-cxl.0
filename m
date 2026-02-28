Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F337239E80
	for <linux-cxl@vger.kernel.org>; Sat, 28 Feb 2026 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299567; cv=fail; b=fb2Xj+8pbyZgPSZXb47moe+wiEE6dBfizTnhJnn7X43s11Dsg8ttrr4wYxEqZUWrDDG8L9lnagEqNuqM3Fs+MQ36Jqa8nSwkrOCa+RJZqyFNqn0qrjebJz3otsehVKlRdvUdbZz8nvM60gnQBQt6Lo+XG8YL/Wht/5/1X7MjEPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299567; c=relaxed/simple;
	bh=s7vmOv0E2h9TA7atJdOQkGUkVT7LJxky98pHj5me67w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCcvbkdKVMlQ5PWhd1LH/QlQqO5w9HLXRP3mnfoAa7OL0L+Zzt+B6ymNOzK9PqLWAHV8JXmm7GoFSJT2OhoazA8bKluIXhiVf9qdFojLHpHxO9NKKcl/SQCgnvJcEIc3wJrDdfaUGK7JV2/FQpeRrowcZ14ND1fU6uSv1O+ievQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XfwFGqQY; arc=fail smtp.client-ip=52.101.56.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XfwFGqQY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNLvCjA7JfXBQOVKUzrbGfyqntkezVxO9qhsfyR69sOxcUQ7ftPCUf5m4Thhcapmxj+iy/g0iT0NnVau5vDZPnQOiKV5nL7igKvHh3jLOWOm9b5QL/O1I2rA2KXTBMOalFAntdw0xNpFAkNfWl/c6Zgv1TnTrGdohIX845nFxWEhQhNprA+QskOfG26jAm9sJMvElOZt80c6OVrQSgIiJfqwAV+60SHiE2a8xB8zZ4uJLsq/4BVSW50qgqxMmHVWFlyUNRvmj0gaFfN1YCXfpfMpYIKSPCX5uRfSHNe4H0EuKnroGbFo8b1z/t0Gn8LE0/j6M4XNXAiQ6xs8cBGClw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+eBZ+PIGmvTtALNNKQLjAh+aOVOZB07eP6VBQOYyzE=;
 b=xHxn/im527509xKCvJpTiiskOzHZJDIDO1P2j0NXcjiYFfoSj2qoWhN8sgFb5VJ+piD4JL5ukWLaB0tM/Q9QUItDZ9LmWTsz7YMlCHs60GKCI7p9ReFVm7Kx48TgdWvjo+bBRkJPRr02lW4vVuGGQVYWlRPbyhkOgT+mm6wttZmEwxSStgTtBiqzRgu9P0ec55MtFzLAyyxghtsih9bF5+8/2z4flsUvg8xSEcVKS3p4z1JhlxqqFTMf38/g9pCz+lHWEVenqbg7OUEOM3ZRbEyfOe3jxf3WPYxS1Qm98r/fawroPu5meP2EfLZEz0ehkk2q8oUUMQbaVk3j+aH2Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+eBZ+PIGmvTtALNNKQLjAh+aOVOZB07eP6VBQOYyzE=;
 b=XfwFGqQY91TTme5CpT2MWJc6qgjPQTbbaGc0VGhiJRANRR0ao60taSgx8F8aiLFoqx9QUkMBuwyByOlFkYAM+WF6ZSPdaCaf6iY543xu3vAVGPo+BcLoOREQuiDLUlbfyRwQEP+AVhn5tFI13dhQAA7rk8ZsZqwmSe9nuCb2T1g=
Received: from PH8PR05CA0008.namprd05.prod.outlook.com (2603:10b6:510:2cc::19)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Sat, 28 Feb
 2026 17:25:59 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::48) by PH8PR05CA0008.outlook.office365.com
 (2603:10b6:510:2cc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Sat,
 28 Feb 2026 17:26:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Sat, 28 Feb 2026 17:25:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sat, 28 Feb
 2026 11:25:58 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 28 Feb
 2026 11:25:57 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sat, 28 Feb 2026 11:25:56 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <gourry@gourry.net>
CC: Alejandro Lucero <alucerop@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v3 1/4] cxl: support Type2 when initializing cxl_dev_state
Date: Sat, 28 Feb 2026 17:25:46 +0000
Message-ID: <20260228172549.1121832-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260228172549.1121832-1-alejandro.lucero-palau@amd.com>
References: <20260228172549.1121832-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 1154402b-a4c4-4ec1-4901-08de76ee7002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	VSxyBRERQzXgk+NJo6yWKP14nGApb2qekR79udblWvK2Knveh0Hwuv/ZNSBURcyOjIkRBmN5LHMgxNBaWHOjBQCrFeYlG6lXab1fbBm8kBEA4aSNe6u6UUF0CTI1Gp0GBOj6EcxHNeCs6ElB2PkXV85uL3QpwDEUq/ssWAEUlQjeqZdbCpgucIiLGntisksnOH8j+aSkRLLJlPQA/vzzSNtkihXoj2fZwytlOoyzYXX+moSfw7lpudriUeQpvn7GexszUXHk6MwqrE7ZivtvUwsDSJeicgcfkEM8GBxj+x5rJz0AtSPDoHFybV3qXgS+YXXsXg5zF6Koey3FVC6RemR0HBp41XGU4LssJSJo2k5QIjIiFY0GeAB4cs/fesbgG2byPbItYqLOog6kTkh7avp/UMyRiV/JmCaLRttdzVqJYXrWd+McRBLhOGoYXp+xhZghICtFekkJkTQGcfkJ4GYU2pOxnO3/YIBuM+VJdpGIPR3soe77Q0uJ8djMuysGQ83ht3YgfbyIWnF5mxV3bm9xPenj0fQ3g9FygT7Ojbw2tNpUdyV3i249CGXeOTMvMPAoDqpWxJD4kdLUWvQhCi8Iyv/HM8W9N+/ttHsvBG7x7GlqnySpPBP8/6UT0K8duqH9NYqHk1zxxUEEPb3uRvJOhBoXr1h3oXcohNUjkf+EV6zbn82FmRg6GOgajZxCA8whyEHlQR7amcVnNdElCsVsQ38kA/ncfrIMeVu5cNaxBLG2Rc0Lbe+xhMRyFD/E/HS+gI4NsDvfmE+LGGloi9TbugzcTn1/GpAs6tEO7eYzNBHbSwzP8vbSltHh8NiFEB6nMTjrLfoCyhOH4uJGHQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rjhoNBQWYQkWp9J2wcWZwo0mg3atvJ+Y55SSWLwjUFbKrEz/mxLdYoSdCHmtaULIccWiHg7+/M2aZayVeN1pM/v/99YmKJvHq9u3aRzuIrpWlyp7pmi2sK494mPHDaD50JxQWk5cRweEVGp8b/trCbgEgKis79IYTtR2BLlpCdNiYaGePf2w7GvgGGq3ulMJhTGNWt8J2qhzr+sW0SLZE6kCL3QMAYjurAMllpZyI+Bs53LFJ2oXP9UpqkdG5xTletpXymnjgHwyOukpDTiwYoYMpudOPsqmCHxh6rPNs5YVZtxIV1I/9dW2PCZOJyMSjczLp2rcuE8QPjukr66zU3OJ+fUfl6PCw69bPjziypburSUrOriTZXlvX9k6qHtywmTMjNII6zJ55N0kwnIxeGstXLxWHRAjCn4zK0UjOK8E9cx6WnRicW7N0NW9CI3q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 17:25:58.5804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1154402b-a4c4-4ec1-4901-08de76ee7002
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216

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

