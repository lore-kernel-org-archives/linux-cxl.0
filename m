Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38BA429806;
	Wed,  1 Apr 2026 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054529; cv=fail; b=iJb7Czv/Ky8A09RL8c/RBLJ5H0ot90suhJy7cy9I+1eieGRqmsy10TA6Ox83aapBT2X2/7VWJ/Gkx3CNzIV66qRkB7Yus7s+uqF5zmKis7g1pYtuemZBwb8TPhd0fuM+dYMpzky/08eUyJcVWeJ8V0JWSimSutU28DZs3a6tv6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054529; c=relaxed/simple;
	bh=nr2QnWoBN/0g5cP9umDBp103Ls6oPH+cAhV88eIuOYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+HveK8Ng/x7TTVG3gZgJLABHbZduukBr+HmEdox20JMJ5cgXBg0I375fOvR0C5BRE7NyxCVoVkiYcScMSi7GHDXX5sEMsFdp5IUUCwFieaDSoGa+66+IP/SG7hTo2i3n93oubaZiKRjHZyMNf/kRpQGpwVwa2lcFH+acXMSRB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qpe6hAXG; arc=fail smtp.client-ip=52.101.48.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qpe6hAXG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXZWbxEDnDcYK3cxuiPmakMXHC3ymmANhs4cVE0UnmDwmS01wesBVxLxJhUUUCHpCPD53yGEDsyAwmebjRF5W/3QJHlFyl5lArECO2qCfJkwyk0zg5AtXaGrb69yIE185vHrZn8DDugIZGyTpn8xlFSu61w2WVPbIRpPfiUp0moNPR9yQJIlSsInSjgGTqikpkiaPzWmjwyKKa2tzc12FDyHbsZE4aMnQxMFyeGcza9KUchst8YxJ2J3M/Q+LoNT+nHDpfvbnmOqWT5LkctmssqwmZ8ajUsfQaaqk64V09s2g7VCF71wEgN0uzPVqhTehKu23ACm8r2H057JDmApuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppzCk7ulIkbQ5RJzgPPsc1aR4Kl4JNvXEdzbs/itF+Y=;
 b=SsE+oovnyDscWUour/bxDy6Pl69YaZonfcqOD2L2SQhHrjUD3eqNTsNso3IF6KyYNw2PD1H3BGZ2cd7ADrzyWkcz8JvlyRUCL1xr7sBqOiq0KBF7zVnj13LR9h/XEMCBWpG5SdA1RRscA8iFksO+16ePzuCawhxb2v+O7LT0EJyiDRriAkbZ2SUJP3RhC/f5NSi1LUDD/k9nV2sFihMzuTuESZ5gR2jxb+L6WQ7xEjCBxgP9xJ3ChvnqUMiU84LvfVK5le8pdgCkwDSnDk7ZkmPbCGGb/Tfz4TojicBFZSd2Meq78TCbdgPmODdOn903Be4KEs35i7n+ET5U4Gm6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppzCk7ulIkbQ5RJzgPPsc1aR4Kl4JNvXEdzbs/itF+Y=;
 b=qpe6hAXGSn1Zrd588FWyiM98yYZX40wSqY9t5Jj4p+XscqiGgeZrpCx+NeCSksbkWvli2M0al/zKRxuLhV0ut/n/yPB9pfhToKPMR86A7iLmSUVbXK+QG2MazcsKPilrwhi2uQHYbYdSvHC0i68RhBgyMVqKCzCI1IN7NkbDziZGE0Tzi4foaL1fYd7vMuGWqE/2gJZWVSDpxPglDQZ/h8g1npPYjsGrFrdM0fAcLqB+hFiK2rZ14lrIkp3NdOdaMDqWEj0vfp26SvL0eMC/VSCChRLe+cNP/6+AlrqDTKeWnXRKr5o2KI4Wyzaqs/5scY5+sywe1vlKuaF6T5u7Mw==
Received: from BY5PR04CA0019.namprd04.prod.outlook.com (2603:10b6:a03:1d0::29)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 14:42:01 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::ad) by BY5PR04CA0019.outlook.office365.com
 (2603:10b6:a03:1d0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 14:42:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:42:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 07:41:37 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 07:41:29 -0700
From: <mhonap@nvidia.com>
To: <alwilliamson@nvidia.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alejandro.lucero-palau@amd.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dmatlack@google.com>, <shuah@kernel.org>,
	<jgg@ziepe.ca>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
	<kevin.tian@intel.com>, <ankita@nvidia.com>
CC: <vsethi@nvidia.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<kvm@vger.kernel.org>, <mhonap@nvidia.com>
Subject: [PATCH v2 16/20] vfio/cxl: Register regions with VFIO layer
Date: Wed, 1 Apr 2026 20:09:13 +0530
Message-ID: <20260401143917.108413-17-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260401143917.108413-1-mhonap@nvidia.com>
References: <20260401143917.108413-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|IA0PPF84D37DD5C:EE_
X-MS-Office365-Filtering-Correlation-Id: 08060c6d-7719-45ce-7f05-08de8ffcd56d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	X2A+A1auVVdEU79iOl2fv8s80LGiP41KtxijqoFp8JIwak6Y1FliX0YIGCuDjX+OCMdn2DaQfFqGJmb/L1vIJXslsEenajq7cxVtt/V7u60QR0DU4YjUCPGwVFm4D/ZQYeX4NsQ73gD40JhaVSFgmM94gdzDpM7h7E0iw8e0oLLg69GKDqJlNG//DzZ06R/6+2vjIgdEjEuPKthgoo7TqF+T5zqZMlBRNKmQB1NRw3VuRJ4weBjXtv7gSvuE0yzHygwCE0urdyHOORv9pYMCdiLZvyh9UC3E4l1DJcSDRl4VCIjIgockazJS25LU0SxFmEuCHhHa3oqJBh31hrhQzoWf6aKIgCC1XteakhCXBeh12nJ0Z4gT9zxoceG+qGtQXkFxz4RdCuDoq0zHr1q1UM84wCBcN8YQ/YHFd7MBcHGkMO7JlV3qWl2erhqr3UyUsg2WFaySzQDXZ00aIHtyW8eZ0swWYW23A696s5ut8lvxqpW5FlSLkmFh/AQ8QxH7cSbsMbv+973Ks3p3crJ6D8iuogFDHK9RnKujQZ6exY3jk1NDP6leimI83W/J8FU5QC+fzR5epvFybKwFULs9jTeJwKDBY5PY0nOVwtglaW6VHxgFkf7bJRZkTbWgi7lRr5dEZ4nXkilIP15hU165a2FUN8+vDDY8Ub5W+c/MoUZrlx+MVqSjkZtVHmhmxDnq7RQJHudxuzLZgHqUaFUObbAEpszwL/ddCFpUgFpS6DJ03an1zOaZqPXGbKWrLIAt/s+CY3JfflsXy2NSwawniOfPSDs0USN68tqOwDnuFXmczgsRn+slQJRXYMM8526H
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3r+d70GQkjlrbbqJqfJls0Ovbe8CD7RcdvAwkjuFghEdykELqYVTLryEO9pXfdHo1153d8G1emttnOTMx1ImcPBiOzaG9CgE6eJVnmogSDssgZ0IOxtF8nKLwo2UXu36Jft3PnsV5eCZcX/F8FxSQHVPD/Fgsn7u/AhMRRk7o1n9+vjqXlIG3U3AfnMtQwFiYPioXM5mENhGdSHe7fC6yn/59IaW9H2snbpVs+CS6mFkDLzMck48rJBYKy7pN33WMKVWRMJ5ZyTYnhJyO222UkVyEnCKtYalwuL0zWOxFJK3njoLgr8YJVe4xgPOSqQxGAKW67Nn9+GtwPd3C/yXdAtAHzSLD8kQBDRgvw0JGUCmfyzVEcwHmgTOIFhfIN8w/jU9/yYi1DYhQkbEIn8+CTqCVhGxEY1/+URjtvni+dJMDHV3xndEBsjMWH0OLziy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:42:00.6537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08060c6d-7719-45ce-7f05-08de8ffcd56d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF84D37DD5C

From: Manish Honap <mhonap@nvidia.com>

Register the DPA and component register region with VFIO layer.
Region indices for both these regions are cached for quick lookup.

vfio_cxl_register_cxl_region()
- memremap(WB) the region HPA (treat CXL.mem as RAM, not MMIO)
- Register VFIO_REGION_SUBTYPE_CXL
- Records dpa_region_idx.

vfio_cxl_register_comp_regs_region()
- Registers VFIO_REGION_SUBTYPE_CXL_COMP_REGS with size
  hdm_reg_offset + hdm_reg_size
- Records comp_reg_region_idx.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 98 +++++++++++++++++++++++++++-
 drivers/vfio/pci/cxl/vfio_cxl_emu.c  | 34 ++++++++++
 drivers/vfio/pci/cxl/vfio_cxl_priv.h |  2 +
 drivers/vfio/pci/vfio_pci.c          | 23 +++++++
 drivers/vfio/pci/vfio_pci_priv.h     | 11 ++++
 5 files changed, 167 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index a3ff90b7a22c..b38a04301660 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -75,6 +75,8 @@ vfio_cxl_create_device_state(struct pci_dev *pdev, u16 dvsec)
 	}
 
 	cxl->cache_capable = FIELD_GET(CXL_DVSEC_CAP_CACHE_CAPABLE, cap_word);
+	cxl->dpa_region_idx = -1;
+	cxl->comp_reg_region_idx = -1;
 
 	return cxl;
 }
@@ -509,14 +511,19 @@ static int vfio_cxl_region_mmap(struct vfio_pci_core_device *vdev,
  */
 void vfio_cxl_zap_region_locked(struct vfio_pci_core_device *vdev)
 {
+	struct vfio_device *core_vdev = &vdev->vdev;
 	struct vfio_pci_cxl_state *cxl = vdev->cxl;
 
 	lockdep_assert_held_write(&vdev->memory_lock);
 
-	if (!cxl)
+	if (!cxl || cxl->dpa_region_idx < 0)
 		return;
 
 	WRITE_ONCE(cxl->region_active, false);
+	unmap_mapping_range(core_vdev->inode->i_mapping,
+			    VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_NUM_REGIONS +
+						     cxl->dpa_region_idx),
+			    cxl->region_size, true);
 }
 
 /*
@@ -601,6 +608,7 @@ static ssize_t vfio_cxl_region_rw(struct vfio_pci_core_device *core_dev,
 static void vfio_cxl_region_release(struct vfio_pci_core_device *vdev,
 				    struct vfio_pci_region *region)
 {
+	struct vfio_device *core_vdev = &vdev->vdev;
 	struct vfio_pci_cxl_state *cxl = region->data;
 
 	/*
@@ -610,6 +618,16 @@ static void vfio_cxl_region_release(struct vfio_pci_core_device *vdev,
 	 */
 	WRITE_ONCE(cxl->region_active, false);
 
+	/*
+	 * Remove all user mappings of the DPA region while the device is
+	 * still alive.
+	 */
+	if (cxl->dpa_region_idx >= 0)
+		unmap_mapping_range(core_vdev->inode->i_mapping,
+			    VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_NUM_REGIONS +
+						     cxl->dpa_region_idx),
+				    cxl->region_size, true);
+
 	if (cxl->region_vaddr) {
 		memunmap(cxl->region_vaddr);
 		cxl->region_vaddr = NULL;
@@ -622,4 +640,82 @@ static const struct vfio_pci_regops vfio_cxl_regops = {
 	.release	= vfio_cxl_region_release,
 };
 
+int vfio_cxl_register_cxl_region(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	u32 flags;
+	int ret;
+
+	if (!cxl)
+		return -ENODEV;
+
+	if (!cxl->region || cxl->region_vaddr)
+		return -ENODEV;
+
+	/*
+	 * CXL device memory is RAM, not MMIO.  Use memremap() rather than
+	 * ioremap_cache() so the correct memory-mapping API is used.
+	 * The WB attribute matches the cache-coherent nature of CXL.mem.
+	 */
+	cxl->region_vaddr = memremap(cxl->region_hpa, cxl->region_size,
+				     MEMREMAP_WB);
+	if (!cxl->region_vaddr)
+		return -ENOMEM;
+
+	flags = VFIO_REGION_INFO_FLAG_READ |
+		VFIO_REGION_INFO_FLAG_WRITE |
+		VFIO_REGION_INFO_FLAG_MMAP;
+
+	ret = vfio_pci_core_register_dev_region(vdev,
+						PCI_VENDOR_ID_CXL |
+						VFIO_REGION_TYPE_PCI_VENDOR_TYPE,
+						VFIO_REGION_SUBTYPE_CXL,
+						&vfio_cxl_regops,
+						cxl->region_size, flags,
+						cxl);
+	if (ret) {
+		memunmap(cxl->region_vaddr);
+		cxl->region_vaddr = NULL;
+		return ret;
+	}
+
+	/*
+	 * Cache the vdev->region[] index before activating the region.
+	 * vfio_pci_core_register_dev_region() placed the new entry at
+	 * vdev->region[num_regions - 1] and incremented num_regions.
+	 * vfio_cxl_zap_region_locked() uses this to avoid scanning
+	 * vdev->region[] on every FLR.
+	 */
+	cxl->dpa_region_idx = vdev->num_regions - 1;
+
+	vfio_cxl_reinit_comp_regs(cxl);
+
+	WRITE_ONCE(cxl->region_active, true);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vfio_cxl_register_cxl_region);
+
+/**
+ * vfio_cxl_unregister_cxl_region - Undo vfio_cxl_register_cxl_region()
+ * @vdev: VFIO PCI device
+ *
+ * Marks the DPA region inactive and resets dpa_region_idx.
+ * Does NOT touch CXL subsystem state (cxl->region, cxl->cxled, cxl->cxlrd).
+ * The caller must call vfio_cxl_destroy_cxl_region() separately to release
+ * those objects.
+ */
+void vfio_cxl_unregister_cxl_region(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+
+	if (!cxl || cxl->dpa_region_idx < 0)
+		return;
+
+	WRITE_ONCE(cxl->region_active, false);
+
+	cxl->dpa_region_idx = -1;
+}
+EXPORT_SYMBOL_GPL(vfio_cxl_unregister_cxl_region);
+
 MODULE_IMPORT_NS("CXL");
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_emu.c b/drivers/vfio/pci/cxl/vfio_cxl_emu.c
index 781328a79b43..50d3718b101d 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_emu.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_emu.c
@@ -473,3 +473,37 @@ void vfio_cxl_clean_virt_regs(struct vfio_pci_cxl_state *cxl)
 	kfree(cxl->comp_reg_virt);
 	cxl->comp_reg_virt = NULL;
 }
+
+/*
+ * vfio_cxl_register_comp_regs_region - Register the COMP_REGS device region.
+ *
+ * Exposes the emulated HDM decoder register state as a VFIO device region
+ * with type VFIO_REGION_SUBTYPE_CXL_COMP_REGS.	 QEMU attaches a
+ * notify_change callback to this region to intercept HDM COMMIT writes
+ * and map the DPA MemoryRegion at the appropriate GPA.
+ *
+ * The region is read+write only (no mmap) to ensure all accesses pass
+ * through comp_regs_dispatch_write() for proper bit-field enforcement.
+ */
+int vfio_cxl_register_comp_regs_region(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	u32 flags = VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_WRITE;
+	int ret;
+
+	if (!cxl || !cxl->comp_reg_virt)
+		return -ENODEV;
+
+	ret = vfio_pci_core_register_dev_region(vdev,
+						PCI_VENDOR_ID_CXL |
+						VFIO_REGION_TYPE_PCI_VENDOR_TYPE,
+						VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
+						&vfio_cxl_comp_regs_ops,
+						cxl->hdm_reg_offset +
+						cxl->hdm_reg_size, flags, cxl);
+	if (!ret)
+		cxl->comp_reg_region_idx = vdev->num_regions - 1;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vfio_cxl_register_comp_regs_region);
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_priv.h b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
index b86ee691d050..b884689a1226 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_priv.h
+++ b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
@@ -28,6 +28,8 @@ struct vfio_pci_cxl_state {
 	__le32                      *comp_reg_virt;
 	size_t                       dpa_size;
 	void __iomem                *hdm_iobase;
+	int                          dpa_region_idx;
+	int                          comp_reg_region_idx;
 	u16                          dvsec_len;
 	u8                           hdm_count;
 	u8                           comp_reg_bar;
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 0c771064c0b8..22cf9ea831f9 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -120,6 +120,29 @@ static int vfio_pci_open_device(struct vfio_device *core_vdev)
 		}
 	}
 
+	if (vdev->cxl) {
+		/*
+		 * pci_config_map and vconfig are valid now (allocated by
+		 * vfio_config_init() inside vfio_pci_core_enable() above).
+		 */
+		vfio_cxl_setup_dvsec_perms(vdev);
+
+		ret = vfio_cxl_register_cxl_region(vdev);
+		if (ret) {
+			pci_warn(pdev, "Failed to setup CXL region\n");
+			vfio_pci_core_disable(vdev);
+			return ret;
+		}
+
+		ret = vfio_cxl_register_comp_regs_region(vdev);
+		if (ret) {
+			pci_warn(pdev, "Failed to register COMP_REGS region\n");
+			vfio_cxl_unregister_cxl_region(vdev);
+			vfio_pci_core_disable(vdev);
+			return ret;
+		}
+	}
+
 	vfio_pci_core_finish_enable(vdev);
 
 	return 0;
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 96f8361ce6f3..ae0091d5096c 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -148,6 +148,9 @@ void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev);
 void vfio_cxl_zap_region_locked(struct vfio_pci_core_device *vdev);
 void vfio_cxl_reactivate_region(struct vfio_pci_core_device *vdev);
 void vfio_cxl_setup_dvsec_perms(struct vfio_pci_core_device *vdev);
+int vfio_cxl_register_cxl_region(struct vfio_pci_core_device *vdev);
+void vfio_cxl_unregister_cxl_region(struct vfio_pci_core_device *vdev);
+int  vfio_cxl_register_comp_regs_region(struct vfio_pci_core_device *vdev);
 
 #else
 
@@ -161,6 +164,14 @@ static inline void
 vfio_cxl_reactivate_region(struct vfio_pci_core_device *vdev) { }
 static inline void
 vfio_cxl_setup_dvsec_perms(struct vfio_pci_core_device *vdev) { }
+static inline int
+vfio_cxl_register_cxl_region(struct vfio_pci_core_device *vdev)
+{ return 0; }
+static inline void
+vfio_cxl_unregister_cxl_region(struct vfio_pci_core_device *vdev) { }
+static inline int
+vfio_cxl_register_comp_regs_region(struct vfio_pci_core_device *vdev)
+{ return 0; }
 
 #endif /* CONFIG_VFIO_CXL_CORE */
 
-- 
2.25.1

