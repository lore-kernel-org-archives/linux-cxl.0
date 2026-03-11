Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013063.outbound.protection.outlook.com [40.93.196.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B848538D6B1;
	Wed, 11 Mar 2026 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261450; cv=fail; b=C4xyK0jFXNqQJaf2GzM9P3p8F5mVES72+Ytmp7yAbckJsJ9/ysLuQT2THUgRJyvi32986J0BeqsQ/nuH4y2QMoOJVi2GhG72u8XHdjF8MPu4s02H+psUunJG7dFZ+C0vim7WFKKbuaOBmkZfRwq5ANTLqNM1VSCyjK17pQq7Bi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261450; c=relaxed/simple;
	bh=rXGMc6Sr/cIZ9IBFx7m2ApfDX5EVV+BVU0aQyT4qpBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHTW1SeHTu38O4++bY7sv/gOlSZ+9VPNRbTACgS9rl6ZI1YPtjQTQrcqy8j2BKkUTmZUdzeShCxHGiX13wHwkurG98zavgX8QFsgFaHaG7hhAxB/II1R3ehkf5AcnqgM/+S/07ghZowg5Uzs5gPhpv96Mc+DCCTrKTYk4molo20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m8xTTkhQ; arc=fail smtp.client-ip=40.93.196.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m8xTTkhQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRZ9z9Q3LD995HteLyQHu0yz7SRHh8AwamjmrrDnoQTHVIwanjQwCn9jRiyOeLwqSjrAzvAmJKNN9sZu8i+Xyh1Si8WT3UBFF92q0SiZsa88ju3OKk4khT6KPkSw/VNg3+rmVjI7c7/l3w1xq5FZB6ctivuEVwiiZfhVuc2KFyzZYlby2FRhiifDy14PJ1zDlGKQ2fXkffCyYf0Mj7CCNKE+ff7lf/W6DHgG1rSmq9NfbMRpaD2OmEHizyEclCmzU+Bbbfd5szkQRtc08bI7pGNonaNAnTNzx9SeyWxnCNlq7+BCVuDEwmo9gfBDNfM6Pi6RC0jDoVN1hln/I+iRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7lJoS4Cw9QYqXlHAy9v6/zR2Ngn7a6lj9xyG318lo4=;
 b=aC88qw1goVnZrNXGIB9HPCHCdxO9bHcW1WFPcneTkIaw5ArhHJsUfwrOubMBmYAmui2CMfeY+o8q7ob2SyfYmOGKMZ0JOmzhZDGE4WMapwB3eEHxa5qr9w5+dtC+f4k2WYzOY3WFht0bwqJAeaV4UomMjxQvPqG4WBDJs88EEm3Zv9IDox3+S1VO20wGS9RDCjhOKTSRVAnrR/AjdYcmWvTqHr0/Pef7nHMH750DbwWOTrtT9Z4NtH901VwH/qx4CIjqZL+TNCvTO324+8xCO4MWYc2HhDo3luXpWUrhCo7bO+CnJ5MNqPkRdwEr0y+s/ZDuZolAIawRr4zAkeEtdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7lJoS4Cw9QYqXlHAy9v6/zR2Ngn7a6lj9xyG318lo4=;
 b=m8xTTkhQvD3I0lNqurGn7l4wdjqBrKRxhRtfsk/1usbZrCNXMFgWe98NsqfRZklD2UzkQQyUgCT5bI7+38xvX/hpTZrgnW5JCzaX6d7KsqqyYTkELsMV3g9kVpGK1B6LE+j290e16oD+IvIKgvw7AwxWjlH1FV3Q2x00WEdgU56f74twKBKWnifa/Ev7/VdIlUo+WZxImEUqZSDLw59JJAh8QadYfycUc/oii1LQINjmnandpmLZisMpK2bU5c4QssEMuUBf73z6CCqCJ0qlVSdwUuBx/wOTbZAOJHUja+3RRCv6HA7FvxCDr7gju3PLX0lrRu9DgdTRedYk9X+gig==
Received: from CH2PR08CA0029.namprd08.prod.outlook.com (2603:10b6:610:5a::39)
 by IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 20:37:23 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::5f) by CH2PR08CA0029.outlook.office365.com
 (2603:10b6:610:5a::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 20:37:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 20:37:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:36:58 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:36:57 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 13:36:50 -0700
From: <mhonap@nvidia.com>
To: <aniketa@nvidia.com>, <ankita@nvidia.com>, <alwilliamson@nvidia.com>,
	<vsethi@nvidia.com>, <jgg@nvidia.com>, <mochs@nvidia.com>,
	<skolothumtho@nvidia.com>, <alejandro.lucero-palau@amd.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <jgg@ziepe.ca>,
	<yishaih@nvidia.com>, <kevin.tian@intel.com>
CC: <cjia@nvidia.com>, <targupta@nvidia.com>, <zhiw@nvidia.com>,
	<kjaju@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <kvm@vger.kernel.org>, <mhonap@nvidia.com>
Subject: [PATCH 16/20] vfio/pci: Expose CXL device and region info via VFIO ioctl
Date: Thu, 12 Mar 2026 02:04:36 +0530
Message-ID: <20260311203440.752648-17-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260311203440.752648-1-mhonap@nvidia.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|IA0PR12MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 210ccfc9-7ad6-43c2-e28c-08de7fadffbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	87x/eIrfjvFXIkNszftOmB1qX//eGlXbEI3Iz1gZlmlbtXAayT/iu95y/pRukLiMgI8tricwdp3LYbZPmKvxqjEPqDJxc9yh66gcZZi0kNuTu6Z+5aXZZK1unheiV45MfFBjm3fO1S0h7ffFJb1isFmuC3KZU0qnASsxnUWzODBLM8mGXWT5MyF9pScq7zlA04djE8KXV0m76qLoy3yw0S7K/y2Fr9V/JzT+1RlWnynjVgvvCnycy7yA7PtwSm3l+vaJo0nirrFQ5bUjLe73J3C6v8O2ceTRhZPUlmaZsk07Fk+iIeCCQkjaQ/SPdWl6VFFXjrqd6x4f/UkDZYgKp1JzAC6nMHLQS5Io3f40xgPj2Xqn7lxePfuwQjJ+zra7UBDXngF2UfQEtyR2BfAwnbPs7NoAqv3qKO2LGk9/NMcSS8Vwduj9nz6U6tGOn+O8kL2H0lbk4GHV/KVJWz3BS/jhwC60r+JPFYdI9MNV8Jl6A0OOHFiV9ppHx6RlNlRg4/QVsdnAr0o32Om4G0ZgAVpACOYp0pgeqj/xTrG0YY5LkToBRjmWH93lyMI6IMGJIJdZRcSqeckeu/QVm1qeR1OOC7ZrvNR8YAjjNkDm5ZxBgRj9TvHJsaAqTne1J9Qx31u8t8XZuNrlua75gShbQEIWvMitufcS2KH1MwiCjuSd9vpyyB8s8moALcV6+AmkbC/80chR9nUv1TTx6M+4X9iM+dNWSGpCJ8e/3hJX/K1BL3yCz5OtQq4/GU/9sF71wKyH90g9CT/wqGCIv5e/3pQC8Yd9uTMyWaG22g2hdbk57VdxNn6ZVZ8GBnN7FZjW
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XNFNniGyr5ns0p6AMM8vbHqebOLuOLQwS4PfzX6JP64IeRXk5fnQh3sklw+bt149v2Ne/ObGeeevbAnFIoLmiyMmSj5TDcXmcrENBzaisunPqGRKRRI4CN7TlIpDZ8zpwSkPlRv+iarrkNkltKqecPyM81pqgpYKi4GH3Q2W/OEwh34Uj7ZypUhg1P3J1bRULyuo3Y03oikbUOVzEy8yGxgSiWjQnhqw7BBFSD0Hc41Boc7Mn2U01/zS0loCLhphlxuZpUTV1TMl7iYhyi9lVEyH1ey45J5hGN6blG63Z9CkYNAFkFI8unCwoGdXKCijb0poGom3yGtMxLSo21Z2o/MPNTtIm6xomAbgW64TRQMQFjCb6S2Y13FnOqVB+DsHc1pTZ5XXQj9bognsVOKaV6FYduJbM/bt/wDmFf9Gb6wnjMAmTkDOAcG3wIOpxCKm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:37:22.8419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 210ccfc9-7ad6-43c2-e28c-08de7fadffbe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304

From: Manish Honap <mhonap@nvidia.com>

Expose CXL device capability information through the VFIO device info
ioctl and hide the CXL component BAR from direct userspace access via
the standard region info path.

Add vfio_cxl_get_info() which fills a VFIO_DEVICE_INFO_CAP_CXL
capability structure with HDM register location, DPA size, commit
flags, and the region indices of the two CXL VFIO device regions (DPA
and COMP_REGS) so userspace does not need to scan all regions.

Add vfio_cxl_get_region_info() which intercepts BAR queries for the
component register BAR and returns size=0 to hide it, directing
userspace to use VFIO_REGION_SUBTYPE_CXL_COMP_REGS instead.

Hook both helpers into vfio_pci_ioctl_get_info() and
vfio_pci_ioctl_get_region_info() in vfio_pci_core.c.

The CXL component register BAR contains the HDM decoder MMIO registers.
Userspace must use the VFIO_REGION_SUBTYPE_CXL_COMP_REGS emulated region
instead of directly mapping or reading/writing this BAR, to ensure that
all accesses go through the emulation layer for correct bit-field
enforcement.

Reject mmap(), barmap setup, and BAR r/w for the CXL component BAR
index in vfio_pci_core_mmap(), vfio_pci_core_setup_barmap(), and
vfio_pci_bar_rw() respectively.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 84 ++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c     | 16 ++++++
 drivers/vfio/pci/vfio_pci_priv.h     | 19 +++++++
 drivers/vfio/pci/vfio_pci_rdwr.c     |  8 +++
 4 files changed, 127 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index e18e992800f6..bda11f99746f 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -18,6 +18,90 @@
 
 MODULE_IMPORT_NS("CXL");
 
+u8 vfio_cxl_get_component_reg_bar(struct vfio_pci_core_device *vdev)
+{
+	return vdev->cxl->comp_reg_bar;
+}
+
+int vfio_cxl_get_region_info(struct vfio_pci_core_device *vdev,
+			     struct vfio_region_info *info,
+			     struct vfio_info_cap *caps)
+{
+	unsigned long minsz = offsetofend(struct vfio_region_info, offset);
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+
+	if (!cxl)
+		return -ENOTTY;
+
+	if (!info)
+		return -ENOTTY;
+
+	if (info->argsz < minsz)
+		return -EINVAL;
+
+	if (info->index != cxl->comp_reg_bar)
+		return -ENOTTY;
+
+	/*
+	 * Hide the component BAR for CXL. Report size 0 so userspace
+	 * uses only the VFIO_REGION_SUBTYPE_CXL_COMP_REGS device region
+	 * for BAR MMIO (HDM) emulation.
+	 */
+	info->argsz = sizeof(*info);
+	info->offset = VFIO_PCI_INDEX_TO_OFFSET(info->index);
+	info->size = 0;
+	info->flags = 0;
+	info->cap_offset = 0;
+
+	return 0;
+}
+
+int vfio_cxl_get_info(struct vfio_pci_core_device *vdev,
+		      struct vfio_info_cap *caps)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	struct vfio_device_info_cap_cxl cxl_cap = {0};
+
+	if (!cxl)
+		return 0;
+
+	/*
+	 * Region indices are set at open time after
+	 * vfio_pci_core_register_dev_region() succeeds.  If either is still
+	 * -1, the device is not yet fully initialised; return EAGAIN so
+	 * userspace knows to retry rather than receiving 0xFFFFFFFF.
+	 */
+	if (cxl->dpa_region_idx < 0 || cxl->comp_reg_region_idx < 0)
+		return -EAGAIN;
+
+	/* Fill in from CXL device structure */
+	cxl_cap.header.id = VFIO_DEVICE_INFO_CAP_CXL;
+	cxl_cap.header.version = 1;
+	cxl_cap.hdm_count = cxl->hdm_count;
+	cxl_cap.hdm_regs_offset = cxl->comp_reg_offset + cxl->hdm_reg_offset;
+	cxl_cap.hdm_regs_size = cxl->hdm_reg_size;
+	cxl_cap.hdm_regs_bar_index = cxl->comp_reg_bar;
+	cxl_cap.dpa_size = cxl->dpa_size;
+
+	if (cxl->precommitted) {
+		cxl_cap.flags |= VFIO_CXL_CAP_COMMITTED |
+			VFIO_CXL_CAP_PRECOMMITTED;
+	}
+
+	/*
+         * Populate absolute VFIO region indices so userspace can query them
+         * directly with VFIO_DEVICE_GET_REGION_INFO.  Custom device regions
+         * live at VFIO_PCI_NUM_REGIONS + local_idx (see vfio_pci_core.c:999).
+         * dpa_region_idx / comp_reg_region_idx are 0-based local indices, so
+         * add VFIO_PCI_NUM_REGIONS to get the index VFIO_DEVICE_GET_REGION_INFO
+         * expects.
+         */
+        cxl_cap.dpa_region_index = VFIO_PCI_NUM_REGIONS + cxl->dpa_region_idx;
+        cxl_cap.comp_regs_region_index = VFIO_PCI_NUM_REGIONS + cxl->comp_reg_region_idx;
+
+	return vfio_info_add_capability(caps, &cxl_cap.header, sizeof(cxl_cap));
+}
+
 static int vfio_cxl_create_device_state(struct vfio_pci_core_device *vdev,
 					u16 dvsec)
 {
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 48e0274c19aa..5352e7810fed 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -989,6 +989,13 @@ static int vfio_pci_ioctl_get_info(struct vfio_pci_core_device *vdev,
 	if (vdev->reset_works)
 		info.flags |= VFIO_DEVICE_FLAGS_RESET;
 
+	if (vdev->cxl) {
+		ret = vfio_cxl_get_info(vdev, &caps);
+		if (ret)
+			return ret;
+		info.flags |= VFIO_DEVICE_FLAGS_CXL;
+	}
+
 	info.num_regions = VFIO_PCI_NUM_REGIONS + vdev->num_regions;
 	info.num_irqs = VFIO_PCI_NUM_IRQS;
 
@@ -1034,6 +1041,12 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 	struct pci_dev *pdev = vdev->pdev;
 	int i, ret;
 
+	if (vdev->cxl) {
+		ret = vfio_cxl_get_region_info(vdev, info, caps);
+		if (ret != -ENOTTY)
+			return ret;
+	}
+
 	switch (info->index) {
 	case VFIO_PCI_CONFIG_REGION_INDEX:
 		info->offset = VFIO_PCI_INDEX_TO_OFFSET(info->index);
@@ -1756,6 +1769,9 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	}
 	if (index >= VFIO_PCI_ROM_REGION_INDEX)
 		return -EINVAL;
+	/* Reject mmap of CXL component BAR; use COMP_REGS region only. */
+	if (vdev->cxl && index == vfio_cxl_get_component_reg_bar(vdev))
+		return -EINVAL;
 	if (!vdev->bar_mmap_supported[index])
 		return -EINVAL;
 
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index d778107fa908..c1befe7d028d 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -156,6 +156,13 @@ int  vfio_cxl_register_comp_regs_region(struct vfio_pci_core_device *vdev);
 void vfio_cxl_reinit_comp_regs(struct vfio_pci_core_device *vdev);
 void vfio_cxl_setup_dvsec_perms(struct vfio_pci_core_device *vdev);
 
+int vfio_cxl_get_info(struct vfio_pci_core_device *vdev,
+		      struct vfio_info_cap *caps);
+int vfio_cxl_get_region_info(struct vfio_pci_core_device *vdev,
+			     struct vfio_region_info *info,
+			     struct vfio_info_cap *caps);
+u8 vfio_cxl_get_component_reg_bar(struct vfio_pci_core_device *vdev);
+
 #else
 
 static inline void
@@ -183,6 +190,18 @@ static inline void
 vfio_cxl_reinit_comp_regs(struct vfio_pci_core_device *vdev) { }
 static inline void
 vfio_cxl_setup_dvsec_perms(struct vfio_pci_core_device *vdev) { }
+static inline int
+vfio_cxl_get_info(struct vfio_pci_core_device *vdev,
+		  struct vfio_info_cap *caps)
+{ return -ENOTTY; }
+static inline int
+vfio_cxl_get_region_info(struct vfio_pci_core_device *vdev,
+			 struct vfio_region_info *info,
+			 struct vfio_info_cap *caps)
+{ return -ENOTTY; }
+static inline u8
+vfio_cxl_get_component_reg_bar(struct vfio_pci_core_device *vdev)
+{ return U8_MAX; }
 
 #endif /* CONFIG_VFIO_CXL_CORE */
 
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index b38627b35c35..4f1f4882265a 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -207,6 +207,10 @@ int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
 	if (vdev->barmap[bar])
 		return 0;
 
+	/* Do not map the CXL component BAR; use COMP_REGS region only. */
+	if (vdev->cxl && bar == vfio_cxl_get_component_reg_bar(vdev))
+		return -EINVAL;
+
 	ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
 	if (ret)
 		return ret;
@@ -236,6 +240,10 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	ssize_t done;
 	enum vfio_pci_io_width max_width = VFIO_PCI_IO_WIDTH_8;
 
+	/* Reject BAR r/w for CXL component BAR; use COMP_REGS region only. */
+	if (vdev->cxl && bar == vfio_cxl_get_component_reg_bar(vdev))
+		return -EINVAL;
+
 	if (pci_resource_start(pdev, bar))
 		end = pci_resource_len(pdev, bar);
 	else if (bar == PCI_ROM_RESOURCE && pdev->rom && pdev->romlen)
-- 
2.25.1

