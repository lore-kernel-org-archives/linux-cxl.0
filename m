Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013059.outbound.protection.outlook.com [40.93.196.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA9B40B0FE
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184837; cv=fail; b=GcDFUymoXlr3k0zkQQwPj4ndSSkXi737Co44874tCuQ4AT5lucYKWTRppxxrUkvmPS36Osni0tC7x67qZF4QjKSTnwGTycA5HUykLVBwBsb2jCHGRqoO2ugOiGTlK8h68EPAnHcBRB0u0dWq+K7vdzg6/ZgnzF53rlSpQVeaZnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184837; c=relaxed/simple;
	bh=9YT8IrdJtPiDg25aQOI5zUDX2/QWOM/6gJo5hNy9Buc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKcxDcSvfXDUX2wWV1k3Pf7Aqj+gWyv3QC4y0Rf1cmR6gxzAPHQE46sSAZjfTRd4Zgp6ykoXdJmk6Xb8gQIhbeQhuK8NIT3YLpsbISrkhLF+7dZ/r7Yl5h169UN7VGOkubkx0++GsI/1BMm+fbDChbDRietoxfU08ZnJ2wBo4Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3u0Ow7K4; arc=fail smtp.client-ip=40.93.196.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3u0Ow7K4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBCGy07NwejHza7tiYyN2qan0C3/iVVgGcplDSQAalnzSVYHNwKjcvE0fLbtz86pACY+KoVXdldUcKyAxRxPFXbUidMf04eobu0ezYgsMylV0EisgIv5FDWfT83MtC9hNLM2nEKGZ3csnqbNyQrSXB9ma1FYyUOCYJnVbn3d/5wcEEcCLxgTx8kYBGhcCMqS8uRdliu2poiiuiCEPNjmYPbaawf4RPrsFav2/sQLqejo1RlHhVn91RXm94ld81gCtW+/F7+js9dav30rLmoX6CRCCW2U8UVthx3oBdq4GaMtNTcV1LPbS7UzDq8sy1UuwFMQKdh5ugApsjwx7NOELw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1el0k0XTToHuFLsi/GieJjatY9lu7D/KurREfr/uoQ=;
 b=n2pgLiKahOVMj87Hi+LnT9ZP2P+nmzqOigspQR/q2ljFuhQqoyjhnh4pyN+FNsDWePQSsJNh7qhJWHasx4ymfhrEh4bWfCXQMSwOULaGTrCoq1ZrwXd7aJpVMIa3NH9sbL8FYtQ7MziZU4uNLSDhN8LpMuDHvggtzwHUXvl6jOomlTd2mLDPplPpDrY9HzLqDUeF0g1ztrm+iA7GDvenyz0Z8pRfdifxwPBheK+WNmj2l4uirJCOe+5GOBOS4q1Eq+Dxm/zM2fbk2sHAxu8YWUgtIJJwU8Xc6wmdfPCQGYRZjGbIIf39/TVT/TB4q47q8phGpsYXB9EbUNCt3+7JUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1el0k0XTToHuFLsi/GieJjatY9lu7D/KurREfr/uoQ=;
 b=3u0Ow7K4bS6LNKuIyb1f8nmUPWcG4MnMC4RL0HJ0Nd+clsFiKH1rfbIumUvsZy5JwGJRV3zPXK+sAMvuKx5QXX/xww/iRPXp7h1M/pMBrHV5HhcDAhtNtRuMRa1WLdUT+Cz82syqXhCPHfCUQms6FK/WmxU4XHQPv+AuLxrVnTQ=
Received: from CH0PR03CA0273.namprd03.prod.outlook.com (2603:10b6:610:e6::8)
 by LV3PR12MB9437.namprd12.prod.outlook.com (2603:10b6:408:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 17:33:50 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::98) by CH0PR03CA0273.outlook.office365.com
 (2603:10b6:610:e6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 17:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 17:33:50 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 12:33:48 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>
CC: <linux-iommu@vger.kernel.org>, <benjamin.cheatham@amd.com>,
	<terry.bowman@amd.com>, <robert.richter@amd.com>
Subject: [PATCH 01/15] cxl/core: Add CXL.cache device struct
Date: Wed, 23 Sep 2026 12:33:28 -0500
Message-ID: <20260923173342.5584-2-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|LV3PR12MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: c3426e00-e0b5-49de-8e38-08df1998d4a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|3023799007|10067099003|6133799003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	+csBoN9arzqcPh9mvjUzm8L2PBJhH4wnUWY75itJdhL2ylTrp7L2T8SLoROcl5OIWruYy1wWQSWwdp2niAcCUnqJbL492HV5hZYLDCYCcMMGYG/yiLHTbtwKha6kxXjti8N55Uqkp6l7Qjy8Ihqdymmx3Wp5imzgscLVxZwsiCe+R3Utk66Z21MaFb2NI5pN3s51YaGLRyFFxAiV4JY5TniwAlqJV09GJeqnjrr2Z6eNtZ/MLFbigoVmARs1tFPVz873xaYYhcmJktUNbv0c3yN0T5ky2wDb/F1VfeY6y7ciieGn/KRi9aCaPvOQRTH39lUhOqMffx2Ad7m3VQK5HrqGOGcoVJ3Snb0+CMOHZKI1jIQTIstAV4Auw6AeR/keIEtq3HsTUu9aex5hAyEVHioToeTaK/MfTvG32zuQwBUbhGle3wShdSXWx7peoiCK0K+3U+mS3NeBCRLbPS836LpuKtl8EqjCA/NfMdk/p2T9qaxiHcyIh0fG1veUmOo81+UgZWWfjOchWjaNW34dDVElPUDED2WfjxiY57yU/I24paYGl9ndt7Shh6756BgrriWxmrSZ+w/ngvy0rjOKH8J6AZ3AtiC6h6kznkPI+aXZV8JKypOmKysFNlo5OXNe+DD2FHST4UMOwyNfZp5yGyGa0xy99/aDumUQ1snO2b9txfVYCqAl2zOyitIlcSm7P8xCs6G+CDssEPZ6Dzs7IA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(3023799007)(10067099003)(6133799003)(22082099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Bgnh0eSwdF4PFTC6Xxz10IYWtf2ySvUprBd5+om+LIIC9kTs14joVeaV8C15pJE/57WApZZHb5vRkdxr2RphuE4xpIJjzu2YF5fwDYML6FKxg1uHCFNRVMdiaCJILPEE7/XXQXA6i7SyeAb0O4g5FR8oSmnyTf8phx+4Kt7aWY091PV+dbz0jGg0NNjfmR/pGfAW2BFja9DE1VnDvex9T5rT34+B4bU1UbrSi8P+yaB0rqP4LX9Xfp5d/G2WXi38V7z4XEckXl/L47HF42HqQzZ3oeGUUTNrqkXElkfa+C85Znnw8M7TUpd4JZkfYShRcESdDawV1RBwaAc/RSukTon62mMja/fyQd1kBlWeRge/dc81OjsjWeWrnotQ1sDRMmOB4Zz3dWJODOCt7gVKlWLYMCb+XrThqF0uJfkBOHz+tRmJ20qa83EJ1KZMfaoY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:33:50.2260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3426e00-e0b5-49de-8e38-08df1998d4a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9437

Add a new CXL.cache device (struct cxl_cachedev) that is the cache
analogue to struct cxl_memdev. This device will be created by CXL type
1 & 2 endpoint drivers to enable and manage the cache capabilities of
the underlying PCIe device via the CXL core.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/Makefile   |   1 +
 drivers/cxl/core/cachedev.c | 119 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c     |   3 +
 drivers/cxl/cxl.h           |   1 +
 drivers/cxl/cxlcache.h      |  37 +++++++++++
 include/cxl/cxl.h           |   2 +
 6 files changed, 163 insertions(+)
 create mode 100644 drivers/cxl/core/cachedev.c
 create mode 100644 drivers/cxl/cxlcache.h

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index ce7213818d3c..f51575abe5af 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -9,6 +9,7 @@ cxl_core-y := port.o
 cxl_core-y += pmem.o
 cxl_core-y += regs.o
 cxl_core-y += memdev.o
+cxl_core-y += cachedev.o
 cxl_core-y += mbox.o
 cxl_core-y += pci.o
 cxl_core-y += hdm.o
diff --git a/drivers/cxl/core/cachedev.c b/drivers/cxl/core/cachedev.c
new file mode 100644
index 000000000000..3a7a60165f62
--- /dev/null
+++ b/drivers/cxl/core/cachedev.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2026 Advanced Micro Devices, Inc. */
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <cxlcache.h>
+
+static DEFINE_IDA(cxl_cachedev_ida);
+
+static void cxl_cachedev_release(struct device *dev)
+{
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+
+	ida_free(&cxl_cachedev_ida, cxlcd->id);
+	kfree(cxlcd);
+}
+
+static void cxl_cachedev_unregister(void *dev)
+{
+	struct cxl_cachedev *cxlcd = dev;
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+
+	cxlcd->cxlds = NULL;
+	cxlds->cxlcd = NULL;
+	device_del(&cxlcd->dev);
+	put_device(&cxlcd->dev);
+}
+
+static char *cxl_cachedev_devnode(const struct device *dev, umode_t *mode,
+				  kuid_t *uid, kgid_t *gid)
+{
+	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
+}
+
+static const struct device_type cxl_cachedev_type = {
+	.name = "cxl_cachedev",
+	.release = cxl_cachedev_release,
+	.devnode = cxl_cachedev_devnode,
+};
+
+bool is_cxl_cachedev(const struct device *dev)
+{
+	return dev->type == &cxl_cachedev_type;
+}
+EXPORT_SYMBOL_NS_GPL(is_cxl_cachedev, "CXL");
+
+static struct lock_class_key cxl_cachedev_key;
+
+static struct cxl_cachedev *cxl_cachedev_alloc(struct cxl_dev_state *cxlds)
+{
+	struct device *dev;
+	int rc;
+
+	struct cxl_cachedev *cxlcd __free(kfree) =
+		kzalloc(sizeof(*cxlcd), GFP_KERNEL);
+	if (!cxlcd)
+		return ERR_PTR(-ENOMEM);
+
+	rc = ida_alloc(&cxl_cachedev_ida, GFP_KERNEL);
+	if (rc < 0)
+		return ERR_PTR(rc);
+
+	cxlcd->id = rc;
+	cxlcd->depth = -1;
+	cxlcd->endpoint = ERR_PTR(-ENODEV);
+
+	dev = &cxlcd->dev;
+	device_initialize(dev);
+	lockdep_set_class(&dev->mutex, &cxl_cachedev_key);
+	dev->parent = cxlds->dev;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_cachedev_type;
+	device_set_pm_not_required(dev);
+
+	return_ptr(cxlcd);
+}
+
+DEFINE_FREE(put_cxlcd, struct cxl_cachedev *,
+	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev));
+
+static struct cxl_cachedev *cxl_cachedev_autoremove(struct cxl_cachedev *cxlcd)
+{
+	int rc;
+
+	rc = devm_add_action_or_reset(cxlcd->cxlds->dev,
+				      cxl_cachedev_unregister, cxlcd);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return cxlcd;
+}
+
+struct cxl_cachedev *__devm_cxl_add_cachedev(struct cxl_dev_state *cxlds,
+					     void *attach)
+{
+	struct device *dev;
+	int rc;
+
+	struct cxl_cachedev *cxlcd __free(put_cxlcd) =
+		cxl_cachedev_alloc(cxlds);
+	if (IS_ERR(cxlcd))
+		return cxlcd;
+
+	dev = &cxlcd->dev;
+	rc = dev_set_name(dev, "cache%d", cxlcd->id);
+	if (rc)
+		return ERR_PTR(rc);
+
+	cxlcd->cxlds = cxlds;
+	cxlds->cxlcd = cxlcd;
+
+	rc = device_add(dev);
+	if (rc) {
+		cxlds->cxlcd = NULL;
+		return ERR_PTR(rc);
+	}
+
+	return cxl_cachedev_autoremove(no_free_ptr(cxlcd));
+}
+EXPORT_SYMBOL_NS_GPL(__devm_cxl_add_cachedev, "CXL");
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 625e4aa427db..c0f066c0d3d1 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -12,6 +12,7 @@
 #include <linux/node.h>
 #include <cxl/einj.h>
 #include <cxl/pci.h>
+#include <cxlcache.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <cxl.h>
@@ -78,6 +79,8 @@ static int cxl_device_id(const struct device *dev)
 		return CXL_DEVICE_REGION;
 	if (dev->type == &cxl_pmu_type)
 		return CXL_DEVICE_PMU;
+	if (is_cxl_cachedev(dev))
+		return CXL_DEVICE_ACCELERATOR;
 	return 0;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cab8ce39f465..72d2686a408b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -853,6 +853,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_PMEM_REGION		7
 #define CXL_DEVICE_DAX_REGION		8
 #define CXL_DEVICE_PMU			9
+#define CXL_DEVICE_ACCELERATOR		10
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
new file mode 100644
index 000000000000..6ca887e078a1
--- /dev/null
+++ b/drivers/cxl/cxlcache.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __CXL_CACHE_H__
+#define __CXL_CACHE_H__
+
+#include "cxl.h"
+
+/**
+ * struct cxl_cachedev - CXL bus object representing the cache capabilities of
+ * a CXL device
+ * @dev: driver core device object
+ * @cxlds: device state backing this device
+ * @endpoint: connection to the CXL port topology for this device
+ * @id: id number of this cachedev instance
+ * @depth: endpoint port depth in hierarchy
+ */
+struct cxl_cachedev {
+	struct device dev;
+	struct cxl_dev_state *cxlds;
+	struct cxl_port *endpoint;
+	int id;
+	int depth;
+};
+
+bool is_cxl_cachedev(const struct device *dev);
+
+static inline struct cxl_cachedev *to_cxl_cachedev(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, !is_cxl_cachedev(dev),
+			  "to_cxl_cachedev() called on non cxl_cachedev device"))
+		return NULL;
+
+	return container_of(dev, struct cxl_cachedev, dev);
+}
+
+struct cxl_cachedev *__devm_cxl_add_cachedev(struct cxl_dev_state *cxlds,
+					     void *attach);
+#endif
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 802b143de83d..f0077ffa0d91 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -158,6 +158,7 @@ struct cxl_dpa_partition {
  *
  * @dev: The device associated with this CXL state
  * @cxlmd: The device representing the CXL.mem capabilities of @dev
+ * @cxlcd: The device representing the CXL.cache capabilities of @dev
  * @reg_map: component and ras register mapping parameters
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
@@ -175,6 +176,7 @@ struct cxl_dev_state {
 	/* public for Type2 drivers */
 	struct device *dev;
 	struct cxl_memdev *cxlmd;
+	struct cxl_cachedev *cxlcd;
 
 	/* private for Type2 drivers */
 	struct cxl_register_map reg_map;
-- 
2.53.0

