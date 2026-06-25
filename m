Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1183EC2F6;
	Thu, 25 Jun 2026 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406604; cv=fail; b=jLoxGndYy7XHDjhUZXf7+LJbcd8JuWfmWFml5SQR7p66w6Nq4/maa8YtRoCpsZshf0ifC9EtjEXYmpuPQFv5Ulyrqr/sgSxW7kMNmgziNHGCbhAKEY1/xsmEk++c+Dx7Q0EYqi/Kv3S9F5Z0gflqaqoGUFAQinYxA0X0MDZF1O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406604; c=relaxed/simple;
	bh=3/fkxY9UrCu5Fjr/pSIsPH1ttUJ1QtOpAAC7tmRPc04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqN4zEoIhCioCalSzf+sGw5QirDXjJ6sIupv5yqp8eqGj04dF51PYkyWVIghW7cjpVu1utu8RUThv+AWS4Yp6+wqnx/hQznl8e5eWGSo6EsLRaludZOmiiUnqy4ciI0km+kFrCncpLcJOm8V5CTmMcqAwNbGDJQMhi2C2R6gPww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QUiPtG2e; arc=fail smtp.client-ip=52.101.62.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QUiPtG2e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRMc92bhI7KbsTGM4MSb/SbMk/xb/tecNKAeJDJoJftj5Hbncnq4DIfnVc0jjiDCmChg3r7ZLPXudwX3N/94nPcQ9jyD9aRRoEqNrTWp9TYIjYdJ5MEk/PHq4ng5LEzyVwDTuyZxZ3+FoTK2ib22fA7Qwln0qTDMWPUPEgr0AeqE0JyqsI20LzZK9mrpJnKQ+VTpMT7KxzWDyDBmRtEDhWOf8CtOHdHJ7eeIcZ+z5z1/AXS9LY0YKisu6spaz0SJ436ovaHbJsdgi4ZstV7mFhkgKu2BmsUmZfKayGIjfhLy8W0SaQBqmWCYgp7QaEFaNt1hDvHsRTNf0e1bksDNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14lhtxV58ZOG8RVlPCjyTYJmvBT8SJ3Zs8SLNuR3zO4=;
 b=OYfFmFUbv92r/FJQohECIZzh9KCP00MWnyxm9xIjZZ9TU/IQX0tT4ygPFDTP4G19xbDMM9BT2z0STkl8rk9vpN5FKYKbseUYTBhJgb2pUrrlul4DL+PF+KbV5uDknoeTAOmZM7jJapzvh5utTrqnlEceazDL31dPu+XiFk0iUyzehVraPiByg3PxSUykeBCQfs9EsZJRHwEN8yLnWU+2TGbdD5zTSYEzxsfKhLO0C3kqXNfn5sD5JsHWlaKe2QyhpCAcdYbTeSTzJDykGJ8xjoedmYWDCjtCsqMuvMV35QUC2n7X2g4y4LlXR1eoTMCUC6ry5+r1B+g8j2Mq1O5eTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14lhtxV58ZOG8RVlPCjyTYJmvBT8SJ3Zs8SLNuR3zO4=;
 b=QUiPtG2eNMGd0aO0Bv3kLxkh4G3/6rtMrUV2Nhxb9qTuwo3wPgBXr5O/kxdx85ZIgLJ7J4BlBRQS3o07uCCMRUeIAnOujaMUsftL5y6vVSEqPXqvLbjyoFlV9lef2cY5ltTvzso+wSIKyYMYWwXe61hqmr8AWr8o8C156G8gMRyqYec8Nt5cIbygr3ztsj9u/dM/vV/J6I5YQRxOqDCn2j8N0soAKXDFeSPCA8QhmFoftLEeoJt2PkTm2aQMFMhQ1qpug3FTth5RSbrIviZ+bFynl2Se/9RPSM16ws3Y3/0BjZatEYS5wVq0JwdBPrpM1Yn4dKpUPF5ladZ0xYG1ZQ==
Received: from BLAPR03CA0052.namprd03.prod.outlook.com (2603:10b6:208:32d::27)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 16:56:39 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::10) by BLAPR03CA0052.outlook.office365.com
 (2603:10b6:208:32d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Thu,
 25 Jun 2026 16:56:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 16:56:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:56:10 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 25 Jun 2026 09:56:02 -0700
From: <mhonap@nvidia.com>
To: <djbw@kernel.org>, <alex@shazbot.org>, <jgg@ziepe.ca>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <ankita@nvidia.com>,
	<alejandro.lucero-palau@amd.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <dmatlack@google.com>, <gourry@gourry.net>,
	<ira.weiny@intel.com>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v3 11/11] vfio/pci: Provide opt-out for CXL Type-2 extensions
Date: Thu, 25 Jun 2026 22:24:07 +0530
Message-ID: <20260625165407.1769572-12-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260625165407.1769572-1-mhonap@nvidia.com>
References: <20260625165407.1769572-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SA0PR12MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d9ca088-2353-4a7a-cde2-08ded2dab955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|7416014|376014|3122999024|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	+HVNrroEXGNp+/LLUkC2RFDc0nFYwpOJkjGnrNEFL8NaP+8b1oN/BPjez1L8OU/aCCDET0DU0MMv07RJaZy/MH7OzoNn111VbT4mSNfoEV/l6eeJtiRbt2YD2aCu+VVtdDHg9p9qnGAqb1AWeBqSdTNks3VEIW+/J2dzdaRzZBNRqW3BvX07OpJtCXDDjKA9iE/rQ9J7ajQCdum03V8NseDgXWcFbB2nOqvuAOat8f/BtLSOtj3LHOYPdnidHkg8UnUXvpGII2Fjh6sdZ2B8mBsWDmuv7F3qBeIy8+BQ8hykuhu+mifOghPe5O1XywXNN+F+p1UsPHOhkvmq74RznLdBOFIfkRu03l53S4hsyUYQNY8Ty6ljrxjiwsqvdj57YhlrodRRUIbjXNawGZiyteRdsu2sehuGzxi/LhmeU8hIuAFaivqZDsaS9zlyFSzFNqabPNx3fE9kfQ0eN9R8b0Lx1+vEKpUii0w/BRGcdC914ob3Fa3l/lVTm9IqiJHCS730EALwhNEe53P2qLJEkNK53gvIJc/j51UjrOYSZu9K4CGM8h2dYXb6gey4K13sW6UZYEpVd/IXTjBB/5KU5MeCKaKo7lne6p3Attg3tPbty3JmgGFVb9lQsXvAudQ4Ti5JQLAetbGun/6bCSoQfkwDF2IEWDbtr3sAkH3HG645RhyOJAcmaF7qB43Xu/eTq2VP+W693O/f7UiwMJapbKsCdGX7ay+Stu7lZekrJM2oYudgPDyOBikdDuepREM5
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(7416014)(376014)(3122999024)(22082099003)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5XnCEvrXuLp/0CHy8T5ExK5+SLkntbloq8W8Y8gGIl3NXyAF7FVKcTkCMPeeyr5IJC3CSYTjnI9BMAal571Xkn19f/RAL/qDZ13UaIgnJF5w3x3S9bQefuhKxL63jmuIo9uMmVdBucopsbyY80cc6+97p682O4rceA9j5BoBj/TTv0xWSQGpMVut1pidfUz0GvDq76sJ4v6HdhZ9zh0Dsk91CNdqRty4vLLrQqOl3CvGxXa4QqEz4266ZgBaeYGdStv81/cX1BHDySBPaQ7BqDT9beG0i8rY9PGpEKY9rEvZkkDHIN07CF35pL6xEei1IALbA8fCxswe1vr7lSOxaeFkP/0+QrooBMa/HH9vAPuf98NXmpBRkJr4hZRnVmAdgk903u01zfL6oqeMiAg+daurQmzRguuhsOOb+3GnUY9HyGzz/ukTPUs5v9eVSDZI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:56:38.1386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9ca088-2353-4a7a-cde2-08ded2dab955
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384

From: Manish Honap <mhonap@nvidia.com>

Add an opt-out so users can keep vfio-pci's CXL extensions out of the
path for individual devices or for an entire vfio-pci instance.  The
build-time gate is CONFIG_VFIO_PCI_CXL; the runtime gates are:

  - Module parameter vfio_pci.disable_cxl (bool, 0444).  Setting
    disable_cxl=1 at modprobe time makes vfio_pci_probe() set
    vdev->disable_cxl on every device it binds.

  - Variant drivers (mlx5, pds, hisi, nvgrace, xe, etc.) may set
    vdev->disable_cxl=true in their own probe for per-device control
    without needing the module parameter.  The bit lives on
    struct vfio_pci_core_device so it's reachable from any variant.

vfio_pci_cxl_acquire() consults vdev->disable_cxl as the very first
check and returns -ENODEV when set, which makes vfio-pci-core treat
the device as a plain (non-CXL) PCI passthrough — no CAP_CXL, no HDM
or COMP_REGS VFIO regions, no DVSEC clipping shim.

This mirrors the long-standing disable_denylist opt-out shape.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 9 +++++++++
 drivers/vfio/pci/vfio_pci.c          | 9 +++++++++
 include/linux/vfio_pci_core.h        | 1 +
 3 files changed, 19 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 8a00b776d7c7..905f74f4e725 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -234,6 +234,15 @@ int vfio_pci_cxl_acquire(struct vfio_pci_core_device *vdev)
 	u16 dvsec;
 	int rc;
 
+	/*
+	 * Honour the per-device opt-out (set by vfio-pci's module
+	 * parameter disable_cxl, or by a variant driver before
+	 * registration).  Returning -ENODEV here makes the caller
+	 * treat this device as plain vfio-pci.
+	 */
+	if (vdev->disable_cxl)
+		return -ENODEV;
+
 	if (!pcie_is_cxl(pdev))
 		return -ENODEV;
 
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 0c771064c0b8..fd226cb65d8b 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -60,6 +60,12 @@ static bool disable_denylist;
 module_param(disable_denylist, bool, 0444);
 MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
 
+#if IS_ENABLED(CONFIG_VFIO_PCI_CXL)
+static bool disable_cxl;
+module_param(disable_cxl, bool, 0444);
+MODULE_PARM_DESC(disable_cxl, "Disable CXL Type-2 extensions for all devices bound to vfio-pci. Variant drivers may instead set vdev->disable_cxl in their probe for per-device control without needing this parameter.");
+#endif
+
 static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
 {
 	switch (pdev->vendor) {
@@ -166,6 +172,9 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return PTR_ERR(vdev);
 
 	dev_set_drvdata(&pdev->dev, vdev);
+#if IS_ENABLED(CONFIG_VFIO_PCI_CXL)
+	vdev->disable_cxl = disable_cxl;
+#endif
 	vdev->pci_ops = &vfio_pci_dev_ops;
 	ret = vfio_pci_core_register_device(vdev);
 	if (ret)
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 541c1911e090..20e9599b3bd7 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -127,6 +127,7 @@ struct vfio_pci_core_device {
 	bool			needs_pm_restore:1;
 	bool			pm_intx_masked:1;
 	bool			pm_runtime_engaged:1;
+	bool			disable_cxl:1;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
 	int			ioeventfds_nr;
-- 
2.25.1

