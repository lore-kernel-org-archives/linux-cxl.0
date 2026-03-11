Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9594937C921;
	Wed, 11 Mar 2026 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261390; cv=fail; b=rng+1odIOpuDu1e6L1WK3DpQ0AIfoWXo1r68VZLd58anny/7AsUMxg7ET7xrAiLORL5DFlx7ZKE02VaVLnEuXprcQ/cv0fX81sLHu8fmV02YlqWBUNFmYq11EJB/Ogyp+4SogtF7ndYoEhDW69bYE/sby5nqPH1eFppg0HUJxmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261390; c=relaxed/simple;
	bh=cM4QtJwwBlDpMqFmy32r5EfWXUgBUB4hEzDPByOyz1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3zBIuapH8trZhfLxUQ57B1yiPbCWrq0WJ4GyeYnxuE+MLPhSPbzz/eq9B7Fa7T1blUh8qa1u2o/6fH1+/jGpyR2VuUVBF27zRVIi9uXW6Ub46IUKvfWvVA6vlE8Qap3T7u/HkbvJ9NkeYSekRnNJLKMv8KGmjKRezgO77BKTBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z7VdMxJ5; arc=fail smtp.client-ip=52.101.48.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z7VdMxJ5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXgiEItWWtOdS88aDPhQz0rOBh6iAUu6C95D9c+/HJopm010Bm1qzuAWmrqxweAgY9bDUfXxuevbWAypfSeEuS7DJg/4W5vK2gIu/l59ElQB11MbpzslRnZjInGyul2zOOth/8MmCHrSciy+Ij56UT5e4r3UmQpnpMC7LIXl85xWgvUw1mgJwZTwuhZamS9T5IxbYHl73QmkNdiDyLD9STlVNEfNahq3S5FcnY41p7PHAfilO5JNwTg8oD0+P4Gff01VIPY8mUftyZh8mxdNGrk3td60pAVipeO+C+a7OghyARmE4CU0zqsuxvQlxI8B3L9hM1rQXgywOiMTOI0/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeANyQ+Rx1pFztcnXjoT47J7YdYtjJUvNDPSt0EJbIc=;
 b=fX074Xk83IioT3mPz566V+/lPlfO/aod+EjuXxoQiUdPYLQHExVmZ4p6A4vwNuPLKOrQTimVtbe/O9Ic6F5bkv/E8lDUp4zGtwLNGwOkPh2KVznW9urJFMT2hEgzlxCZRFJ+zZ2uE/wJ5Q1yr3+1/mJvPIj+go6Gc3is+bQyFUcMZB5zhc6hGdoAwpIc00+wLpGf3XgCszAaUoXxOjZvzRjFRR7UwECncfEcDoX4Mozhnj3IXvE6R7MvkPvIh+UkVYSLpFKbgmQs7ib9vAfvZbmDuQnFRjyORrrDhWhNegrO0GGnYZmk0qbPhpdeb4WR/kk6+CBNJ3rcXNh5HxPGfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeANyQ+Rx1pFztcnXjoT47J7YdYtjJUvNDPSt0EJbIc=;
 b=Z7VdMxJ5EXkxc3y0cTCwIBcdYLu3ELnpCiWEdbzkOUAXtyQ5/BVIF/G5Z5zwUb+j4WtvNeFrPzN4mIRJiLv8fRn0wAtS2g8UZs+ikz+NyN9CnNKaBbzWaTZG87zm9tvz6XYyEC2ZDncdkbTfV6RGDs92l0eqgP1O3j11LI46INPIBHoZOvbAswhUmv/4rJXZwrIctrfmkqeNEQ4mathcHaJ0Z1qSGvs1I8P314RUyqPWfV7CTgzOvRB+Y4qxi+5OFYthMmo4T6EQ74pPKCWaJGBQ1seDzQ3nQDihj1UstME55T6GOGNr2o5LLUPXpvzi5JcniOVnCFgCgRpWXigPSQ==
Received: from CH0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:610:cc::29)
 by LV9PR12MB9807.namprd12.prod.outlook.com (2603:10b6:408:2eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 20:36:24 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::15) by CH0PR03CA0084.outlook.office365.com
 (2603:10b6:610:cc::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Wed,
 11 Mar 2026 20:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 20:36:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:36:05 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:36:04 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 13:35:58 -0700
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
Subject: [PATCH 09/20] vfio/cxl: Implement CXL device detection and HDM register probing
Date: Thu, 12 Mar 2026 02:04:29 +0530
Message-ID: <20260311203440.752648-10-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|LV9PR12MB9807:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ae02261-cdb5-4829-cc92-08de7faddcb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	xwVNvWmd5H7OWJrflJZx8tXvSWxhJo5b8h3nl1L2MA7dTWDYWN46Mb3UZanqmEyXnQ2k8cGoc223W5SBa40KmseqjRAqZpQOdyMbk3e9I1pWBj46iZKFvDjgi1HLC0T4WaMfNEEJW4zEtjwi1ryWHIfa+z8Q9E0ZjFC9bScX5ViHxCHURkhjRp742fMlBgLIzc7GD97vUeZLgmqg1SesAx/dlSQvknrGRRJ2/QzOlTpmonXirSKADrCbml845om26xJEcIGJdrMCMdadzXP/wo0bvLplXSO0NDNumrozWZrjz6bzFCqSMt5wce90ZD8arN8Jd00WlyUZKf1/KHYs5zURcs+CqkHwKR9eJPVO3DHGyImsDPM6c57F9gDbvMhTK8J/bFhn1zaKFBjWs7YHKXfwXjhjjr/26XEokxoIX5C+GlAZJnFrEkc0FA9rCGdITHBgPRU30HtQ0esMMUCFsh2WiLYPgpD5+k1rZ9L9LAFQLpRBeRUrrtzXk6Ak/eVk3+4YSElJ42kRzq/DOpShzgHQEfofFESQ7HbM1/xd5tDggYs595dwErC5dH4TQIH5dLatbe6+TRFHS9P7elJVoeVOj5J0vzsCPJ3ByC9ZSZCGTbiFP0ecw51PVRJN1sWZpiMSm36MjnG4kX7nwdYuwY2Q076JgWMZfj56mKiJqyuD9zfgfB+VuJSWqQ9Y0Dz21r7ZqhuKdo3AZVzsya9997rJXjxIi4ms7p+ZF4a/CHUoBVJ8w5qCic4wc725IQSeoBTsL72vz7GjT9zgMxJfYnTs6lOCyO48L8PLplwHno9dhuJqzVuqQX9WlyqQzFNN
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FadSzgG0rNH9mTRQ/Or1Ej0ASQAEelrWOzyaQE7T4iJ5s7AtPBBZR2rW7HapLnl+hakB+juLQw+XZ04VjiHh2rxdc8ftvW280VCKp9GtmdsRaC7jm0Pcaz6DlJNWtjgbUu7KQZjkLGgMvK86s+F0IHs2jAWahcNOzOCGd1OrLboD+0igOpYjXmDvOFJ8azak5bhHcYKJhMeRvNePkMInneYhnsM1FUVkZu0YRS2B1EyzzzGVKbgqVWW0Jj2wV29bHOdfgKySgl2W2M5I/KnZ5xXCilcp7ImuJBDdialbNkukx34FTG/HZ9Y4JQerI8wYPXHDw2+ez6jEChXtYDJkyBzxUZTHusbGzWHi6Cus3NE2yO+AtWvEfIBaCnN+BOAz20oPz2mLe3Y4y7kHg/2UaC4cQO0CIvgdNDSwA9XfO9XCD0USciOwHIF1sFMkcvjq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:36:24.0897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae02261-cdb5-4829-cc92-08de7faddcb9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9807

From: Manish Honap <mhonap@nvidia.com>

Implement the core CXL Type-2 device detection and component register
probing logic in vfio_pci_cxl_detect_and_init().

Three private helpers are introduced:

  vfio_cxl_create_device_state() allocates the per-device
  vfio_pci_cxl_state structure using devm_cxl_dev_state_create() so
  that lifetime is tied to the PCI device binding.

  vfio_cxl_find_bar() locates the PCI BAR that contains a given HPA
  range, returning the BAR index and offset within it.

  vfio_cxl_setup_regs() uses the CXL core helpers cxl_find_regblock()
  and cxl_probe_component_regs() to enumerate the HDM decoder register
  block, then records its BAR index, offset and size in the CXL state.

vfio_pci_cxl_detect_and_init() orchestrates detection:
  1. Check for CXL DVSEC via pcie_is_cxl() + pci_find_dvsec_capability().
  2. Allocate CXL device state.
  3. Temporarily call pci_enable_device_mem() for ioremap, then disable.
  4. Probe component registers to find the HDM decoder block.

On any failure vdev->cxl is devm_kfree'd so that device falls back to
plain PCI mode transparently.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 151 +++++++++++++++++++++++++++
 drivers/vfio/pci/cxl/vfio_cxl_priv.h |   8 ++
 2 files changed, 159 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 7698d94e16be..2da6da1c0605 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -18,6 +18,114 @@
 
 MODULE_IMPORT_NS("CXL");
 
+static int vfio_cxl_create_device_state(struct vfio_pci_core_device *vdev,
+					u16 dvsec)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	struct device *dev = &pdev->dev;
+	struct vfio_pci_cxl_state *cxl;
+	bool cxl_mem_capable, is_cxl_type3;
+	u16 cap_word;
+
+	/*
+	 * The devm allocation for the CXL state remains for the entire time
+	 * the PCI device is bound to vfio-pci. From successful CXL init
+	 * in probe until the device is released on unbind.
+	 * No extra explicit free is needed; devm handles it when
+	 * pdev->dev is released.
+	 */
+	vdev->cxl = devm_cxl_dev_state_create(dev,
+					      CXL_DEVTYPE_DEVMEM,
+					      pdev->dev.id, dvsec,
+					      struct vfio_pci_cxl_state,
+					      cxlds, false);
+	if (!vdev->cxl)
+		return -ENOMEM;
+
+	cxl = vdev->cxl;
+	cxl->dvsec = dvsec;
+
+	pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAPABILITY_OFFSET,
+			     &cap_word);
+
+	cxl_mem_capable = !!(cap_word & CXL_DVSEC_MEM_CAPABLE);
+	is_cxl_type3 = ((pdev->class >> 8) == PCI_CLASS_MEMORY_CXL);
+
+	/*
+	 * Type 2 = CXL memory capable but NOT Type 3 (e.g. accelerator/GPU)
+	 * Unsupported for non cxl type-2 class of devices.
+	 */
+	if (!(cxl_mem_capable && !is_cxl_type3)) {
+		devm_kfree(&pdev->dev, vdev->cxl);
+		vdev->cxl = NULL;
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int vfio_cxl_setup_regs(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	struct cxl_register_map *map = &cxl->cxlds.reg_map;
+	resource_size_t offset, bar_offset, size;
+	struct pci_dev *pdev = vdev->pdev;
+	void __iomem *base;
+	u32 count;
+	int ret;
+	u8 bar;
+
+	if (WARN_ON_ONCE(!pci_is_enabled(pdev)))
+		return -EINVAL;
+
+	/* Find component register block via Register Locator DVSEC */
+	ret = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, map);
+	if (ret)
+		return ret;
+
+	/* Temporarily map the register block */
+	base = ioremap(map->resource, map->max_size);
+	if (!base)
+		return -ENOMEM;
+
+	/* Probe component register capabilities */
+	cxl_probe_component_regs(&pdev->dev, base, &map->component_map);
+
+	/* Unmap immediately */
+	iounmap(base);
+
+	/* Check if HDM decoder was found */
+	if (!map->component_map.hdm_decoder.valid)
+		return -ENODEV;
+
+	pci_dbg(pdev,
+		"vfio_cxl: HDM decoder at offset=0x%lx, size=0x%lx\n",
+		map->component_map.hdm_decoder.offset,
+		map->component_map.hdm_decoder.size);
+
+	/* Get HDM register info */
+	ret = cxl_get_hdm_reg_info(&cxl->cxlds, &count, &offset, &size);
+	if (ret)
+		return ret;
+
+	if (!count || !size)
+		return -ENODEV;
+
+	cxl->hdm_count = count;
+	cxl->hdm_reg_offset = offset;
+	cxl->hdm_reg_size = size;
+
+	ret = cxl_regblock_get_bar_info(map, &bar, &bar_offset);
+	if (ret)
+		return ret;
+
+	cxl->comp_reg_bar = bar;
+	cxl->comp_reg_offset = bar_offset;
+	cxl->comp_reg_size = CXL_COMPONENT_REG_BLOCK_SIZE;
+
+	return 0;
+}
+
 /**
  * vfio_pci_cxl_detect_and_init - Detect and initialize CXL Type-2 device
  * @vdev: VFIO PCI device
@@ -28,8 +136,51 @@ MODULE_IMPORT_NS("CXL");
  */
 void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
 {
+	struct pci_dev *pdev = vdev->pdev;
+	struct vfio_pci_cxl_state *cxl;
+	u16 dvsec;
+	int ret;
+
+	if (!pcie_is_cxl(pdev))
+		return;
+
+	dvsec = pci_find_dvsec_capability(pdev,
+					  PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return;
+
+	ret = vfio_cxl_create_device_state(vdev, dvsec);
+	if (ret)
+		return;
+
+	cxl = vdev->cxl;
+
+	/*
+	 * Required for ioremap of the component register block and
+	 * calls to cxl_probe_component_regs().
+	 */
+	ret = pci_enable_device_mem(pdev);
+	if (ret)
+		goto failed;
+
+	ret = vfio_cxl_setup_regs(vdev);
+	if (ret) {
+		pci_disable_device(pdev);
+		goto failed;
+	}
+
+	pci_disable_device(pdev);
+
+	return;
+
+failed:
+	devm_kfree(&pdev->dev, vdev->cxl);
+	vdev->cxl = NULL;
 }
 
 void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev)
 {
+	if (!vdev->cxl)
+		return;
 }
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_priv.h b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
index 818a83a3809d..57fed39a80da 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_priv.h
+++ b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
@@ -26,4 +26,12 @@ struct vfio_pci_cxl_state {
 	u8                           comp_reg_bar;
 };
 
+/*
+ * CXL DVSEC for CXL Devices - register offsets within the DVSEC
+ * (CXL 2.0+ 8.1.3).
+ * Offsets are relative to the DVSEC capability base (cxl->dvsec).
+ */
+#define CXL_DVSEC_CAPABILITY_OFFSET 0xa
+#define CXL_DVSEC_MEM_CAPABLE	    BIT(2)
+
 #endif /* __LINUX_VFIO_CXL_PRIV_H */
-- 
2.25.1

