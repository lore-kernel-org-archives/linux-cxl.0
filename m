Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB63747CC98;
	Wed,  1 Apr 2026 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054516; cv=fail; b=HRM/Z6YYlnI8tqQ60PcbsTLTJ5HQ1Kl79DBerT4+0JCkExDdds//q+VbVg0XwWjZrRPmgLE5G5VuZ9S2ViSbECT6yXbrIYhGpKJwLxP3zBcNq4/kx+4jh1WhZn0lSNGz7tPzOGmVj4qoY2TkuzxTqGty0+3Xn7PkkjjeR6gHXtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054516; c=relaxed/simple;
	bh=zyJuRmRD4IduuavNFAyt/nTJ4huI2Rw/qpToxdnLrwE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWncq7Il60iloAL7R1/Qdm7SIxcnPZtC0/yeryhSmZ5UYF8dlZxFAJjDER13B1tb20InKFuIvN2PZLcQR4o2zlcZj2c6OoRZ9iP5CveAbh0iOoSzHhuOoE0GB+35mgmq7lO+c875TEjKnL9dyFjeOrXfo+byDYJNDapacWNFdcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aY3R5EB6; arc=fail smtp.client-ip=52.101.43.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aY3R5EB6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxMy3cNbKYfBPoNC38KWjTnHp7wD69chGZ9kXZQ2o3SU2xOGVmlOaHmbL2xoLJB/O9ZmCrJySQ2RcT4/66chQa37tX+lxuhqt2kgbMe4vfq2LLwwnB2L2MDaYgKwSqCZkZpLrjRcE6iszntegZyqgXhGPgR4lgj06zsEOJnCIdkm210uiIC0etNchnK6osztv05Immy3OlImT89EpltQkmYrvzOZCYQvxJ8tvWwqNfYzEgpBjr1GnUZlru7UUfLJNUCqAG0IS4cPUE3Xr5njRa780+mrQd0lONz32fSxC7aNJy+iUlDBGRp+TZLRXjVMotG7tDkSDlNVCbfwJNwnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CywdbhIFUrMQw5CcE10L5D6QWxLR2qziki0gj47Sco=;
 b=lazWWvSgy06JvCXzgR4sdnneuEiUmfuuv6eLf9hvYv2wmhaWcvmr3duYAGBf6l4Wh94VA8+KlR8sBBysRgC5SjoWRzdH8eUFy91ti8NO2Dd+Qzq/E4oLAsmwy7DM6TaGC4SGzojjeIurXt7S3KLH6w5bDlCKFST9I+LVMAY0DAVR07jrbTEsdWZP3IwGl1UQHkbjbLmpBPY4MjVW/ZyKgws7Pw09tEpKDILf6h3lu9o57gzcjJPCmTJ+n3FCbypi2eqdks3VrJzAHrltv8D3KppzEgr+i9xNlHxUfzYktE7wwS1p0BydkTE6ozl/lMr8joj5pQJDxtoXFRgP7OC7yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CywdbhIFUrMQw5CcE10L5D6QWxLR2qziki0gj47Sco=;
 b=aY3R5EB6EPJVD9A2NTNi9aGt8XJcDe3b5Ma4AAqhknSO4Bi6oXkltne1gKEvHoNnxzh2KW6iNc4mfZ5YV3rWMA59uIqIaUD4b2uM2bPAhF9B1Evoh563fUTaOqrP0qoWisj8T9gtzPd07Mpuij1ZxiT+1pA3+4rUNAi/1JBhc3zUdWCFQgbLOj1aOWRbmPTbw+qtzzkqq4X/FnsmuPjnRAUkLFj5KCr7B42bpPpeBt1x3CUFETnAwhzV2maXvfePgCrPhuA38dPOWFKY9avOXP5eYp6vnoiYhOrFPF2dCK4Ug0HwJZmOWcuWmLnKleh9EFUVY43VqNOWqInJxTWpbg==
Received: from BY5PR04CA0011.namprd04.prod.outlook.com (2603:10b6:a03:1d0::21)
 by MN0PR12MB6128.namprd12.prod.outlook.com (2603:10b6:208:3c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 14:41:45 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::41) by BY5PR04CA0011.outlook.office365.com
 (2603:10b6:a03:1d0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 14:41:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:41:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 07:41:22 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 07:41:15 -0700
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
Subject: [PATCH v2 14/20] vfio/cxl: DPA VFIO region with demand fault mmap and reset zap
Date: Wed, 1 Apr 2026 20:09:11 +0530
Message-ID: <20260401143917.108413-15-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|MN0PR12MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: 66589cee-41c3-4c19-f225-08de8ffccc16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|1800799024|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	URksfL8oDi+sAyMqU14iBGca39IdMIJH/DuAEIQki8oyOV3HvIPfOXqYZefLP7q3KcFEYs+3Bh9qG24OftiUOl6bDgIfc2hfbtmWFL3VsfaLpviIeMW5/oGMfNvdGc6aqfH+rRAE4UlS/JiqG8kMpM+JR/1PCxvZEmCc3+00RSCE3su2pLDPZf/1P486/IPsOyjLYba5Z4XLDXp6z3OGLezDoR2I6dkmyhEgLfCPhGc7wrKLD2ECmz9czaFWsmA03+kpa0E+GfWUGebDiXwvvyQmP2gzpBPzZHWyoVq7NdC9wQF6scgFr37a/nLOM3gd1nnKofW7kxLu2AhlM4Th5XKls9J6It00WqoaHTtTKquKnPkLvjy3AJm1TGH+vVNOS/OCNjKm2Sa1GMBxmVDJk+Pqr+1ikPkbmFK5gMcqHsXxwQdqwHVs6T5YExjhOg/Ucrhd8TIDbFfwyENrsgKHMqWHHCM5QYsNOb2UgE6Vqt52+lOIgST5juxBdXiAZirSBjGCanUPwJZlcmPSW64U1UcORXh8W0m36NnabUrxd/JY8P0iYOj0i4Xa7XSn3imk2NplOVT0ooKkC/z8KPANnL/eeVljrrjn73qJ9zjPqFuF85VXQl20d+TSeqUJLA5jvxNSMUXHXiVvF29lCQFAFN6/1qdHANmXyJPVcWSufkn9K6C67G5Od6aCfUfIbjeH+TeXz5qzMXxY4b1xqXYjnBEBKrJfsT4W3ancnTXrvyyfZiUTSOcsK7Wwq79xHL7RKYJb/bDGusYe5zVqbox2UGdRciY1z4hhtzXuxrR5Lxsjflh2iQVCsd9KLs6xztNL
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(1800799024)(376014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Er6GdcLkmU+D+f64rfemfXDCrXQc9Bd7Gf22eRDWzL7jnAAHZBeSW4XbXomYSE+iQgv1IwlFyp7Mso0CthD68bFppgxyQ0xzQ8rcWWokbCzMfA+MkUdmofaYszPFYPBddwQEn6166tiHlMJ2JFTmqf+1TL+K5t+Nf/XKobs2Yl3SpEcsnwCgRcgTiaSwK8O8M8wj9TFpCnXiL86twGeYHamLjTwcfKfL6WYXszJtLR0vsi4fgQ3BjajbmNVNcLWLiUMAGoNaA66gX5PjN5A4vWQ/O/c3Y1mXNFu5w+RJEZwbelmbtqdXrcSSmQzGv15COZ/qwnkTCVpqgbLy3xiWUUHp4fpbFsN4ZvT/TfPF+K8RzP4+6hFBCBdNSfUgNDO4cay2QoLlrColUiNdjQF6GeB/fJKMiruo8Gn4fnAr8NdeNEcJRvRlU86x/goWYXJY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:41:44.9745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66589cee-41c3-4c19-f225-08de8ffccc16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6128

From: Manish Honap <mhonap@nvidia.com>

Wire the CXL DPA range up as a VFIO demand-paged region so QEMU can
mmap guest device memory directly. Faults call vmf_insert_pfn() to
insert one PFN at a time rather than mapping the full range upfront.

CXL region lifecycle:
- The CXL memory region is registered with VFIO layer during
  vfio_pci_open_device
- mmap() establishes the VMA with vm_ops but inserts no PTEs
- Each guest page fault calls vfio_cxl_region_page_fault() which
  inserts a single PFN under the memory_lock read side
- On device reset, vfio_cxl_zap_region_locked() sets region_active=false
  and calls unmap_mapping_range() to invalidate all DPA PTEs atomically
  while holding memory_lock for writing
- Faults racing with reset see region_active==false and return
  VM_FAULT_SIGBUS
- vfio_cxl_reactivate_region() restores region_active after successful
  hardware reset

Also integrate the zap/reactivate calls into vfio_pci_ioctl_reset() so
that FLR correctly invalidates DPA mappings and restores them on success.

Co-developed-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 187 +++++++++++++++++++++++++++
 drivers/vfio/pci/cxl/vfio_cxl_emu.c  |   2 +-
 drivers/vfio/pci/cxl/vfio_cxl_priv.h |   3 +
 drivers/vfio/pci/vfio_pci_core.c     |  11 ++
 drivers/vfio/pci/vfio_pci_priv.h     |   6 +
 5 files changed, 208 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 30b365b91903..19d3dc205f99 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -435,4 +435,191 @@ void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev)
 	vfio_cxl_destroy_cxl_region(cxl);
 }
 
+static vm_fault_t vfio_cxl_region_vm_fault(struct vm_fault *vmf)
+{
+	struct vfio_pci_region *region = vmf->vma->vm_private_data;
+	struct vfio_pci_cxl_state *cxl = region->data;
+	unsigned long pgoff;
+	unsigned long pfn;
+
+	if (!READ_ONCE(cxl->region_active))
+		return VM_FAULT_SIGBUS;
+
+	pgoff = vmf->pgoff &
+		((1UL << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
+
+	if (pgoff >= (cxl->region_size >> PAGE_SHIFT))
+		return VM_FAULT_SIGBUS;
+
+	pfn = PHYS_PFN(cxl->region_hpa) + pgoff;
+
+	return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
+}
+
+static const struct vm_operations_struct vfio_cxl_region_vm_ops = {
+	.fault = vfio_cxl_region_vm_fault,
+};
+
+static int vfio_cxl_region_mmap(struct vfio_pci_core_device *vdev,
+				struct vfio_pci_region *region,
+				struct vm_area_struct *vma)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	u64 req_len, pgoff, end;
+
+	if (!(region->flags & VFIO_REGION_INFO_FLAG_MMAP))
+		return -EINVAL;
+
+	if (!(region->flags & VFIO_REGION_INFO_FLAG_READ) &&
+	    (vma->vm_flags & VM_READ))
+		return -EPERM;
+
+	if (!(region->flags & VFIO_REGION_INFO_FLAG_WRITE) &&
+	    (vma->vm_flags & VM_WRITE))
+		return -EPERM;
+
+	pgoff = vma->vm_pgoff &
+		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
+
+	if (check_sub_overflow(vma->vm_end, vma->vm_start, &req_len) ||
+	    check_add_overflow(PFN_PHYS(pgoff), req_len, &end))
+		return -EOVERFLOW;
+
+	if (end > cxl->region_size)
+		return -EINVAL;
+
+	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
+
+	vm_flags_set(vma, VM_ALLOW_ANY_UNCACHED | VM_IO | VM_PFNMAP |
+		     VM_DONTEXPAND | VM_DONTDUMP);
+
+	vma->vm_ops = &vfio_cxl_region_vm_ops;
+	vma->vm_private_data = region;
+
+	return 0;
+}
+
+/*
+ * vfio_cxl_zap_region_locked - Invalidate all DPA region PTEs.
+ *
+ * Must be called with vdev->memory_lock held for writing.  Sets
+ * region_active=false before zapping so any subsequent I/O to the region
+ * sees the inactive state and returns an error rather than accessing
+ * stale mappings.
+ */
+void vfio_cxl_zap_region_locked(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	if (!cxl)
+		return;
+
+	WRITE_ONCE(cxl->region_active, false);
+}
+
+/*
+ * vfio_cxl_reactivate_region - Re-enable DPA region after successful reset.
+ *
+ * Must be called with vdev->memory_lock held for writing.  Re-reads the
+ * HDM decoder state from hardware (FLR cleared it) and sets region_active
+ * so that subsequent I/O to the region is permitted again.
+ */
+void vfio_cxl_reactivate_region(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	if (!cxl)
+		return;
+	/*
+	 * Re-initialise the emulated HDM comp_reg_virt[] from hardware.
+	 * After FLR the decoder registers read as zero; mirror that in
+	 * the emulated state so QEMU sees a clean slate.
+	 */
+	vfio_cxl_reinit_comp_regs(cxl);
+
+	/*
+	 * Only re-enable the DPA mmap if the hardware has actually
+	 * re-committed decoder 0 after FLR.  Read the COMMITTED bit from the
+	 * freshly-re-snapshotted comp_reg_virt[] so we check the post-FLR
+	 * hardware state, not stale pre-reset state.
+	 *
+	 * If COMMITTED is 0 (slow firmware re-commit path), leave
+	 * region_active=false.	 Guest faults will return VM_FAULT_SIGBUS
+	 * until the decoder is re-committed and the region is re-enabled.
+	 */
+	if (cxl->precommitted && cxl->comp_reg_virt) {
+		/*
+		 * Read CTRL via the full CXL.mem-relative index: hdm_reg_offset
+		 * (now CXL.mem-relative) plus the within-HDM-block offset.
+		 */
+		u32 ctrl = le32_to_cpu(*hdm_reg_ptr(cxl,
+					    CXL_HDM_DECODER0_CTRL_OFFSET(0)));
+
+		if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED)
+			WRITE_ONCE(cxl->region_active, true);
+	}
+}
+
+static ssize_t vfio_cxl_region_rw(struct vfio_pci_core_device *core_dev,
+				  char __user *buf, size_t count, loff_t *ppos,
+				  bool iswrite)
+{
+	unsigned int i = VFIO_PCI_OFFSET_TO_INDEX(*ppos) - VFIO_PCI_NUM_REGIONS;
+	struct vfio_pci_cxl_state *cxl = core_dev->region[i].data;
+	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
+
+	if (!count || pos >= cxl->region_size)
+		return 0;
+
+	/*
+	 * Guard against access after a failed reset (region_active=false)
+	 * or a release race (region_vaddr=NULL).  Either condition means
+	 * the memremap'd window is no longer valid; touching it would produce
+	 * a Synchronous External Abort.  Return -EIO so the caller gets a
+	 * clean error rather than a kernel oops.
+	 */
+	if (!READ_ONCE(cxl->region_active) || !cxl->region_vaddr)
+		return -EIO;
+
+	count = min(count, (size_t)(cxl->region_size - pos));
+
+	if (iswrite) {
+		if (copy_from_user(cxl->region_vaddr + pos, buf, count))
+			return -EFAULT;
+	} else {
+		if (copy_to_user(buf, cxl->region_vaddr + pos, count))
+			return -EFAULT;
+	}
+
+	return count;
+}
+
+static void vfio_cxl_region_release(struct vfio_pci_core_device *vdev,
+				    struct vfio_pci_region *region)
+{
+	struct vfio_pci_cxl_state *cxl = region->data;
+
+	/*
+	 * Deactivate the region before removing user mappings so that any
+	 * fault handler racing the release returns VM_FAULT_SIGBUS rather
+	 * than inserting a PFN into an unmapped region.
+	 */
+	WRITE_ONCE(cxl->region_active, false);
+
+	if (cxl->region_vaddr) {
+		memunmap(cxl->region_vaddr);
+		cxl->region_vaddr = NULL;
+	}
+}
+
+static const struct vfio_pci_regops vfio_cxl_regops = {
+	.rw		= vfio_cxl_region_rw,
+	.mmap		= vfio_cxl_region_mmap,
+	.release	= vfio_cxl_region_release,
+};
+
 MODULE_IMPORT_NS("CXL");
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_emu.c b/drivers/vfio/pci/cxl/vfio_cxl_emu.c
index 11195e8c21d7..781328a79b43 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_emu.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_emu.c
@@ -33,7 +33,7 @@
  *     +0x1c: (reserved)
  */
 
-static inline __le32 *hdm_reg_ptr(struct vfio_pci_cxl_state *cxl, u32 hdm_off)
+__le32 *hdm_reg_ptr(struct vfio_pci_cxl_state *cxl, u32 hdm_off)
 {
 	/*
 	 * hdm_off is a byte offset within the HDM decoder block.
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_priv.h b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
index 72a0d7d7e183..3458768445af 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_priv.h
+++ b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
@@ -33,6 +33,7 @@ struct vfio_pci_cxl_state {
 	u8                           comp_reg_bar;
 	bool                         cache_capable;
 	bool                         precommitted;
+	bool                         region_active;
 };
 
 /* Register access sizes */
@@ -96,4 +97,6 @@ int vfio_cxl_create_cxl_region(struct vfio_pci_cxl_state *cxl,
 			       resource_size_t size);
 void vfio_cxl_destroy_cxl_region(struct vfio_pci_cxl_state *cxl);
 
+__le32 *hdm_reg_ptr(struct vfio_pci_cxl_state *cxl, u32 hdm_off);
+
 #endif /* __LINUX_VFIO_CXL_PRIV_H */
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index b7364178e23d..48e0274c19aa 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1223,6 +1223,9 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 
 	vfio_pci_zap_and_down_write_memory_lock(vdev);
 
+	/* Zap CXL DPA region PTEs before hardware reset clears HDM state */
+	vfio_cxl_zap_region_locked(vdev);
+
 	/*
 	 * This function can be invoked while the power state is non-D0. If
 	 * pci_try_reset_function() has been called while the power state is
@@ -1236,6 +1239,14 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 
 	vfio_pci_dma_buf_move(vdev, true);
 	ret = pci_try_reset_function(vdev->pdev);
+
+	/*
+	 * Re-enable DPA region if reset succeeded; fault handler will
+	 * re-insert PFNs on next access without requiring a new mmap.
+	 */
+	if (!ret)
+		vfio_cxl_reactivate_region(vdev);
+
 	if (__vfio_pci_memory_enabled(vdev))
 		vfio_pci_dma_buf_move(vdev, false);
 	up_write(&vdev->memory_lock);
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 1082ba43bafe..726063b6ff70 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -145,6 +145,8 @@ static inline void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev,
 
 void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev);
 void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev);
+void vfio_cxl_zap_region_locked(struct vfio_pci_core_device *vdev);
+void vfio_cxl_reactivate_region(struct vfio_pci_core_device *vdev);
 
 #else
 
@@ -152,6 +154,10 @@ static inline void
 vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev) { }
 static inline void
 vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev) { }
+static inline void
+vfio_cxl_zap_region_locked(struct vfio_pci_core_device *vdev) { }
+static inline void
+vfio_cxl_reactivate_region(struct vfio_pci_core_device *vdev) { }
 
 #endif /* CONFIG_VFIO_CXL_CORE */
 
-- 
2.25.1

