Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012070.outbound.protection.outlook.com [40.93.195.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF73155757
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856814; cv=fail; b=h1UoSiB5KSZmaGgqpQXRyodA/moDvfHsKMNRHL54d9VRh2T5giTaLV8RTRseMRPx02LrCmMziINqhAWHjvbv7RqJhhSW1cv7D/8Bh0m02hln3oORcxyOD3Bn9smrj1aa5c9CBOuRdyavyy3xoZY6lp/cdImqQQrj81Gfla25Kfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856814; c=relaxed/simple;
	bh=D3xxGWSWtWsvwNJUH3RpNt1m/Gnq1FavnOM583gMM7E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKw1JCdutlrD/0wtU5PsaJ3beiIdHbZa45UJDl3/sotMbMHMO+8WXuyqQhA2JECxb6jdaSniYOCGlqrzVDp0Ou1G9iS92CwtTowVw1xNXZwzG63Am5TGiR3EBH2lbC33yJjwME4IrDrLSP8GHcAFTLoM7ow8kCB3jH0qUvHhjKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b+InVIPO; arc=fail smtp.client-ip=40.93.195.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b+InVIPO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkG4ZJNHWhDHTUGazN+t4XkXaJrvBwxdEKC2SilRYUFRW0KLWF2acIv4Md4QEm51bZv+2pavWOeehSlX0TTapDL2MQCELXr1Jt35EFnpqfYTjyjn9hWk55ANvwTkHm/mn1xKSG6/1dAzqumsetV9lAVE/KzOF6kcZMd4aZP5sSlZjIcyABPcKoZ/lmTJSNN0rjTXyGDl2EuSET0qau4331m8WsKWG/yAyPXcwvmJlldcZWGG+76vfLScjeZr6QYE2VDWHcemGb4Jhdbobf5+N/kyKrGPkxojNEG31iAe0LcecFPoGqBRYifFgMU/TeRTllgyqPDaJ/nFiZDorw7M/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlA8LwEW89VTJ86NJQKuzOfTC9a6g/7XFYK0ct2SZZE=;
 b=aWWXddAHetaw7TvfU7r7NkEt8hAxtKc7A37hSXcgAEPrYr0eS8yzB2ySn0+bXlc7teQoLlNMg2IrWru2jtbWhTEUZ9TYHx67CdaUBTR1bmmWOrcf8AGt9F3vTGGdy9u+GxIOVKKH/9ycwOwoUUvkK4nV8ytYtvO2tVc7X2bDaqMtAH7GwUJmOiMsxudTFC2HqbBtQg0rglRqo1fJcD9Dbqino/9Hu3T1+8EG00L20XqZlw7m67z3djZPXEfDYmwcOTKQKkUVX5/f2Cp4VlrMKq0mcDYBzfR8niKCgHtw7idvrZIsUBMPWITWX5tBeNjF2HRHXCqPybE7qtl+DNFW3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlA8LwEW89VTJ86NJQKuzOfTC9a6g/7XFYK0ct2SZZE=;
 b=b+InVIPOPKV9yR4VclbnIKhPcbSDswGTxttbkiBvIH/tF9SI8mmNxgdqAQdj5DKgoolJxNf+9oXUZFbMAFGvM/kXnh5OnTENLXGYBI/kDPhZ/MHrnnJzKdJuKhzj8E6y3OvJuVJ0T6e87OvX9vFoQA6//clExvL2O6GpjzfzZHQ=
Received: from BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::14)
 by SA1PR12MB9002.namprd12.prod.outlook.com (2603:10b6:806:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 14:26:45 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::c1) by BY1P220CA0001.outlook.office365.com
 (2603:10b6:a03:59d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 14:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 14:26:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Feb
 2026 08:26:43 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Feb 2026 08:26:42 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v1 1/3] cxl: support Type2 when initializing cxl_dev_state
Date: Mon, 23 Feb 2026 14:26:31 +0000
Message-ID: <20260223142633.2994082-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223142633.2994082-1-alejandro.lucero-palau@amd.com>
References: <20260223142633.2994082-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|SA1PR12MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: c3797b8b-6a6e-4f33-e6c9-08de72e7927d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wadwX1/V4O7PVEXBpJcByUZAN3g2B6F0fDs4Ox46cnrqac3juymA9LKH7Rww?=
 =?us-ascii?Q?8wUsEyWicsJ2g+EiAMGh4GcX494I5HaILzjKscXUNnfZkwM86mGvH2yjbYeW?=
 =?us-ascii?Q?UFKnrxZYDk/gLZfBy87irBsL0ODrFr0e7vZjfimV6e4Ma8aYAZVeD17bUSpH?=
 =?us-ascii?Q?8X6RphHDRZzNqv8ovZgXuvGk/GRHA5b7QH7QppoAjZLYRHj5K9d188vODJ47?=
 =?us-ascii?Q?8vZTd2miZHLcNpvSJB1JRR9hPeHDFQMyemQDXsz10iYxnXQ5GAMnpqAPpvMb?=
 =?us-ascii?Q?wzFTHqA7msXJ9WFYj3QVik8z/VN9W/yMo80Hl43WxuSUc4VriDDWmBIi7P6j?=
 =?us-ascii?Q?WpO6dL6V02uC5tu9URwUUsPw+BxBBjG2Y4zBhtrtOCr1enBwW4eOwckENR55?=
 =?us-ascii?Q?e3BCBOGcEVsTI3yJUuZElf9nL38FG3tvGW5YPzDNnbr1Kvhh3TORcnOx9O+F?=
 =?us-ascii?Q?8I8IjnjDpjMa4Uz508sJmQ2rExUG8LcwrJ82AhG6MqsCsTXQrzM807D30wgw?=
 =?us-ascii?Q?0FVLNMMlblpbAiNLmQrRlwcLcxP19TEZQ40cRuJgCsag6JjfZu9r2u6i4eN8?=
 =?us-ascii?Q?wFRjxpyo8qfR0o57PONLjLqaAJo/nEz1cptxpffOThHGeCb66grzxx6x41wr?=
 =?us-ascii?Q?tgLhcfIveUvL+WaqmMxmkk0M2payX0PRe2e5+OoDZcbXdfpwLvcqqmNmgFzY?=
 =?us-ascii?Q?BPzx83aGtbIA4Y2ISg5X8haLtmMTCaVoe2wDTNcLn1vhnp3PJtFB8wdD+kms?=
 =?us-ascii?Q?JQfhZT4et+ckiz5f8QveotTG7nCQ50Med8+KBXjiWkW+TNyLfdHQh2tc5k66?=
 =?us-ascii?Q?5/4b0cUduyUXY1QuAao2ziorPuEGcS/1weEUB2B1FoDq7GF71b3E5ODkIF1/?=
 =?us-ascii?Q?HabtYBEotafr4yKlF0hNtVeG4UdcIzxmZngXotr81lN7ujvs2FbGN34l057q?=
 =?us-ascii?Q?MKsLR5J4cKu3+kjCvh3/NjsRixf1hcM+wI2xcAdI+bpKzcGnVX42K+3wmS1q?=
 =?us-ascii?Q?bojGOf7wfN0AGIsXBd99rav7fFFMGGESYvJ9y2+lt70usrnlJz0iXq8cEzA+?=
 =?us-ascii?Q?3OnkXER+xCUds+fsggtwt60VfM3g4g9Ozdioc/qDhuGrsc7u6bhlqMnKV0+H?=
 =?us-ascii?Q?xCONcP5WJtWwWxRoH/oVnSUpgsTGsI2vI2rY4LiVbPwFT06kLubQGcF8/+QX?=
 =?us-ascii?Q?1oN5X96NJ5xNS1BFg5ePPVSaee+bXJu63+mrN7fETKAiDaDF09Lpt6jbI0/I?=
 =?us-ascii?Q?KzEK2y/f44AwaSlu/j9q5OV+cE8+JGtS7XDnKpWK5mN6a0boJXm+sH1rSv5V?=
 =?us-ascii?Q?EaKIB5Pn3phBvOGa7sJxsZ0pekv6up/p5+PC8blzrOkFnYs356wSZyFAe1rU?=
 =?us-ascii?Q?1A8H8FYRCgt8hF7bLfUgpF8vPhWHhh7TICRWYInYDjcXIgZhv/vmmsO2NWeS?=
 =?us-ascii?Q?zbRwVYoh+toD9d+DUcY/njuT9j1R8dLKdGWgGVpQrK9BgfdRP8IG1SJ5sZ/D?=
 =?us-ascii?Q?ejKOSRaJi2bkmRA18KrzfYFntJUK02cNBgxisLW1wgZmr3DLHVMi1KgYbi0y?=
 =?us-ascii?Q?TaAH0S8w4BGxFY9R681ibQSA2hUGwOe6rgDx/Fvc0mk3uIJ0ZkkEb+mGfM1L?=
 =?us-ascii?Q?9S/gSa+zTbzLWEp4bVu3/f0ZZIbF2IoN0KrQ3vdlzhgZZRk8d/u/UZRS73vO?=
 =?us-ascii?Q?S0satA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qzMolgRBG+otAVSDiW1vbHSVB+xlm+COIRXn7x3SynG4IRxEzv03KLDtLDS8SL20Zli/8a3klH/FM8eu+zDtAQyQBWkNa3MR8xIhFm7SeKJrH3ZKHihAQ1Y8f5dt6bqFZqD8AL+IWQdOnD+aBDnDPGMWdmVL2A48kSvAdlQ3h4Gyu7+ICVi2DS5LYGKdLTxvrITkOfD4qrki5YK+NGI4B20rTYF1H6uUwTPQg+rN3jJHMTKvXaS4jFNy1jqxyf+Y5vNYIc3aFHgy3QJYy/ecATa95oytSksaAs0zc/5KlMSOHvR4NNS97KBdSKMwFvGU8X8REiVe09N+XYq9RClnrikVwSL54h2AAUIB6wCTp2bVXfURIGrARlUobIBNWYsaHd/wp40XQfnfWg+dxvfIHDPuXn/AIuhCHQGGDY214LoN8tnQqliBgzKLsFCdml+T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 14:26:45.2571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3797b8b-6a6e-4f33-e6c9-08de72e7927d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9002

From: Alejandro Lucero <alucerop@amd.com>

In preparation for type2 drivers add function and macro for
differentiating CXL memory expanders (type 3) from CXL device
accelerators (type 2) helping accel drivers to embed cxl_dev_state
inside a private struct.

Update type3 driver for using this same initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
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
index f547d8ac34c7..ad131f053bf5 100644
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
+	cxlds->cxl_dvsec =dvsec;
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

