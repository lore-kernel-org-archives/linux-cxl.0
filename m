Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010068.outbound.protection.outlook.com [40.93.198.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA29396D24
	for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021686; cv=fail; b=CEOE7t1A/PhqdQH7YnhDLaivuHSjjPyLFi1ZVhrkgemqXUbkLK2aRfGoIYglTBg9k42fz3CrDiGyh++P6U1jcd8XA0RjnWX5JLadRe8xHiXJsFgEtRP9ygS1H5IWhn61jHToWgryVHtH6itBxN27Ck6Ga6TZR97M3sEL8x48Sm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021686; c=relaxed/simple;
	bh=1OZt2B1PXWuyYFEK0nxt8pbwol9HAdJRXOWKs6Q8ykU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlyBDjW+pIHvQ5xmQgzOQLNMk3WDuS2eymM3nLoAYdsuqWw5euApey2E4acrvOc4WjMfuqfUB+gHOHcOTI1lPiUjXcAEO602TzecY16gIqSvpvJZ8wbgeaWE1MQT9Yt6IOFx1rulZvkRme8dDx1rI3aAaIsFyeNA4igpY95KxBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RVn1lfGf; arc=fail smtp.client-ip=40.93.198.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RVn1lfGf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVYQbzqxCe7p8Hh6m28uwdjD4msBZpCicYzq8+zZV0oPODTOS4xtA6/DjWvspAWupdKgudFEiT+IAu8AswCBBi6nW+0gTvt/gzScZ4n0PKgLq9gnGKlRsdSzQd6R6un9VxN8Pmd8ax7m/PY4tyFslMSLSY7uJkJGNgpkCjxSLm+MRXdoL1fvffP9oNb5JThPFfd4liALRAd5ku5vvoqwvV9TDvQchHNHN/qalc0HFwvuk0Ah2liy+q2cQBpX27mRyLsQd0aK/KaIDd7ys/XVFHlz1R6J5Rxu4NaUoLIPGI2KV9EDq8IauoTg3Sx4bRbQBf83NV6Kx9jt4vcpHeYYng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paFj2DN5fmjWqsDDEmVzAlTWPwIWtUE5NyfttS3U4R4=;
 b=MrM/BR2xTFg0tuh0uyiCTbvpXB6KzSaBjDrnCPzUCxFv2jCiPDLSvUfl0SASpTJjvvMD25B2q7k592JWkyl+TGDuiScXIPIS1GQ0dfMFyR1ZZeVGzOr8FaWVqG04jkEUPa7hnIApcODd+xXfaFkrLCjoUX2UtXv7+oXg0FBTVWlL1c/20EjD5OLeUouVScPJ2BIa1KtMHCBOpGVgCH0uP7l3pC9a5dW0KAt95FgRZ6JASZHW7aswQufUeV/O0H7Lwb77HndJvYOZ2TVDvQmCo+vPyS5tZ17TpeceBNBVjjEDNhTqXj75yY3rZi/qEGTsmSzEDPqCWl09A6vQL2aqpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paFj2DN5fmjWqsDDEmVzAlTWPwIWtUE5NyfttS3U4R4=;
 b=RVn1lfGfGsu8+SxSvRRC0Fbew5z56rZ8IroXABQIbNdoTXgLj40g5TlYfuRSfJK/X/4PhKiPIlokieIDcbKsUQ3iR3ruyy5VeDOTVOAqBtjAlO1JMfDU766cgLdRyOs1ULWXWBC+89CqAmkc1eLV8q0mimB6MdRtUUMXgR8eU7c=
Received: from SJ0PR05CA0205.namprd05.prod.outlook.com (2603:10b6:a03:330::30)
 by SN7PR12MB8002.namprd12.prod.outlook.com (2603:10b6:806:34b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 12:14:40 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::aa) by SJ0PR05CA0205.outlook.office365.com
 (2603:10b6:a03:330::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Wed,
 25 Feb 2026 12:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 12:14:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 06:14:39 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 06:14:39 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 25 Feb 2026 06:14:38 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Alison Schofield
	<alison.schofield@intel.com>
Subject: [PATCH v2 1/3] cxl: support Type2 when initializing cxl_dev_state
Date: Wed, 25 Feb 2026 12:14:28 +0000
Message-ID: <20260225121430.3839189-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225121430.3839189-1-alejandro.lucero-palau@amd.com>
References: <20260225121430.3839189-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|SN7PR12MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aed9fab-942c-4293-1613-08de746773af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	deVaoo5BHBFdjMt5IXWM0HblnX0HgqkXVnDNsEjzqjw8n7ulvxVsW+3l9osS3DK3UP4C8dPRvIly0KmK1s055DegIwqJkG6dmllO3xCLPUF8glxe5kYsQfBEQxH32as45S5MQinGwHS8VXvAxj8Hs9cmB3vzfqddn8gf9TRMDWDHKpkDfel2AEn3dNF6w5IVlrF7m49kiaYSKpsrQBCvse1Xu/iVYpBsD/BcaKBy04m/sjlAXxuXPR+84Tyiv8+fmo5XIKfFeY/HnJ/feTyUqTJ9uFTAQcc9HBXzH9gRD/TfuD6lqDziPZtjuDZsS2QKhbtJ1L2sdFUmHJEIEq2FmB+pFdCIQaT48w4Eyaqv/DX3/6PExev8qZHgNqb2zpJ4QQgHO31S5WIE3Fzw5fT4ecOPL0hIzRV4yvNf6e9mnQ+aScozXIq2A0/XKexePuFEassCF3xEJObT8IBsmwnjG0/30KGEY5ZI9wcrsVfSMLT/W6UtAHqx5QHs9QuB7qCjJff2L2sMBsyjkqgKGZP+I4BeHzSFM0Qs3wgf4/Yz+TrBlZqmZ7z3vD0T0MvVd2auB5U2g5DvxZppJSTEC8fAt8guhPCxfigK4z6XX0RPRaZeTDDxQmSqSDAzgQuKninIOQT32x7SHCmSkb3tb+a6KB3fl0K0isjKz9sa5ysvvmWU+7AGALhNmVGzltfF2eBajCSU+l+jj2mcreDhKjzX3q8OoboGG3qcxHWyOEyqtosGi6uTj7HuzoeeKFYWP1KcA00XknZay1ND8A+EQpCvM7BMuZswEqWLq/X1lJWAtflckwEi7tJAv7Uh4hhtmcqFvkjBHzlAeQj/gAwMrzxbqA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BDxVzw3qDi/rnedRuh99i4ti60P/61L9yjmzlCZi64jYDZsa9C18ByJJkCpFefiQYZmeELKGhIjeIk7VdIYkc/Nqqxw2FTjy7NSlnn0vUIhEXJVVxbtyX5ORgA58iQC+B8D7cRxWy9Gf/2Nx0Qw8Sy1LmT2z7pCjSUV9OVS5NNkylrEWvD52BsExQ50es+xX3/Ad5VzUC9YENFpQp/WjSNhbqwIeZmq3cC6o2IVir+EwjMP3Rtz/fSN2gOIAjUMrK5lm2kNon1MXQyE3oNp1nzVUEODukuKoCxrUjLbPEXMNDvqE3BZ1u4FLDtcT1Gqe5SGmT7SNIzzKrx/Cjwry2HuvonlX7y+ttfj2ipmbTjcw1GFRNbLYd7HiCwfoyvOHoHEkhUXQwgO3r8xy/i9FK+bBT7LAyxrYebBUF6geDzARJIQtK43XOxU8M8WednXA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:14:40.3149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aed9fab-942c-4293-1613-08de746773af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002

From: Alejandro Lucero <alucerop@amd.com>

In preparation for type2 drivers add function and macro for
differentiating CXL memory expanders (type 3) from CXL device
accelerators (type 2) helping accel drivers to embed cxl_dev_state
inside a private struct.

Update type3 driver for using this same initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
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
index e21d744d639b..9daf4bc42692 100644
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
+ * @member: drv_struct member as cxl_dev_state
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

