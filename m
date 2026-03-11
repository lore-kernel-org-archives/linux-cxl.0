Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7080C38D681;
	Wed, 11 Mar 2026 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261407; cv=fail; b=jRJMmQ+WiCiBONlviODiea1xDJFbuPqH/iZJTFNUE8q4rLkro/8rEcjZ6VxigbJeeuI9+R+Ttz/GVefp8P3boESzEDLh0hcUM4GaYPD16dHIo9HTFotSurWZeERrTs7iI5nMMncVPTwh49tEOKOFEYP4MFws0opLKLhZx5Cz+RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261407; c=relaxed/simple;
	bh=ZhB5QafXudlZCeB3PpFEyBe8e11HpLuVTdsbpem5eYo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtOur55POFPk8ImdaitdhLFhGp1y6lTclkP0gRVSqfC/HnftaIGvjrDRbPkvitkkDvZ5AwcFM/5dn74OP/VYJfM6/CNqNqK+hiXIkJVdz1JHlHPgd10NZxdyafvkJH00brKkT4+H+Td4unybOUqCLpyaWaerZBFQwZmP9HVnH6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JlD8ak9C; arc=fail smtp.client-ip=52.101.85.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JlD8ak9C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCN60P9oCnzcxPSYDnPLqU1dMiUHWLPg5VDNSIHlTtBmxeEG355R1+4rL/D7AErzra0O+8OuDMqc7BCPPXLQS1WdK2oYTNMUzi42cHaIFI02xaDJ8N1F43FfAiMJ1gWwlO7poBXISNFtyaQ6vWXdH3TNGszpLAcg+51Qlf+p2tmLjL0LfNtqoXNjleMWglKicZNLs59yekxl32ZWyeH6A4oE8xdKAaFoPSD6tOg+3KpaKdI6p6rubNdQB7/kwDeLWRdaFbXhRhwlo6SalEHGJSC0tZi70p0OeRWh7jmkPpGqAN+koBClYZuIU2QmBdtcXfIjrF9+UsiPPuX/Kr7apw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OY33U5hux11whPm0liBGFXpZ7h571LDlZxYV/wE/KZE=;
 b=DIM6H0UiU/RGwI1DRM2nKWQ0HRDza5Hs/3FtSI5aFfn/jLpFZNYj1K1O4UZiUhox1QSu6Filb9NEnmzQnC1RW7lYt4vY6Pe18SFt2dZatdwt/TR+n8r5OYWMvmqnR1MB/W4wS+M+dx+yCGMFe6tJ7kN71Kv7HxuLyDqKiH838gzfG/Wv5oCEej9HGnK5ZZJBYPw9oG/PiZcHnIKPFmRUjzX/qAIPKXFfZv63/sjUfX3w5dF5Ro9PuWfi5t4D6AMB/nHjpPRGeShX3blC/69sLfay829vflncUwrDF43AT+VINVIrjVr26sFoYWVjorRIAm304o3EYtdy1YQtLcDDYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY33U5hux11whPm0liBGFXpZ7h571LDlZxYV/wE/KZE=;
 b=JlD8ak9CqIVsODoJFJ1aOt/4DVrJXr8w/1KgYZWY15Swp/Y/bgXDQ8VjHdGb67i5ErsFMImRBFn5kZOiIDFrq/SweYasGWmyve+xaYhF2fwChn2Z3wZr2kLVhv+gq0T+iQqxl8BcMR2YT8mHi7aVAsQzTcrx4/SQxkwyZwPrCPm7vhDGTiBLKhs5oVv20ALhvhX7nVAJID48CyunlB06TDsSKPIDy/uPO37kHRE0yJAF8O9wrz3TzXcrhR9hsdiSZxfgkQP0YzEr1/pkObMLHgQlUBdBYlYjp6c2HvR+1Kt++dYtvsj/1u2cIP4bxAxnGvAgv203vFOtiK7ELpCmWQ==
Received: from SA9PR10CA0023.namprd10.prod.outlook.com (2603:10b6:806:a7::28)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 20:36:37 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::c7) by SA9PR10CA0023.outlook.office365.com
 (2603:10b6:806:a7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Wed,
 11 Mar 2026 20:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 20:36:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:36:20 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:36:19 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 13:36:12 -0700
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
Subject: [PATCH 11/20] vfio/cxl: Expose DPA memory region to userspace with fault+zap mmap
Date: Thu, 12 Mar 2026 02:04:31 +0530
Message-ID: <20260311203440.752648-12-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a4dcb9-2c03-44b8-3da0-08de7fade4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	sCcky8QZyrREkU74jlkWEApcZqqAnba0p/eiuS1zhGahOhuKmMXmL/BKiom38Vtt1HyS/eavkzHF8pBEebAT8grB6nRoHSMAW4OuzR85MG2l8Jfk5n7A+yqrf8/6SxujNfgjmwG7jSMrc0VICiW0Pts/QkAndT+LKygEx0Yzp74Oa4+8T4FiO8e2qcvHOqecXvuXIKeN861jXM8LgV9qcNb71ce8emlpsxqqNYIW2w48NI/inMzfULz8PYvqbJ9bGe+h4cVaoR8yACIg5xALCgwHu9a55m+i6G9BE40/RNjU5kW4AXdZlIXHArzQUM7NqIE2hIr1rq4wTNgsUYK0sYrh+VTJnxVLkZ/tdANmJ9RvO2ld4jW4+wgrHxEW+iHf/pl0++qB0dl35JHF0feCHWBu397lVzYHomhqLMASH4t9Aq1sbp2eMXAVgnRW43erWQ7BID+8YE8MoLUHD1Q6evrGwdjS1DPA+LdiUu0Hr3H/REnYR0HKf26/8RUl7s5UQ785d3Q6nfz1i5IaNhhHSRLjKj10EEHbqnOvFzwUW+GZ6A3IyrtYax1fnY5nTbKGC/StJ6rPe0TVglTQk6DQKViSmXAozpPpcPjLJg8q2toWmk1kgEVasw1JPyZ67AhZuXedwqyzkGnYYHnCgn7iXwtIgB21p6MQO18ummih8Dq9pzAWWd/y1AIG8mQ1MJNdB5HJgnwCvD8LIyGs+pCemZulhXTd+5XAN+fhWx9XxkHJCq4L5QYHFERfr6MJpHFNzY7zb0+Zf3t2Scn45fgyK2VHQC79023UH7RLWX4q6r6+1DMC8k14+MenaEd7MDus
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dR+MAjD+LHa/BrKRwz8c7fB/F1wPPCElSPCDjX5FvI94RL9rYX1ApUaKFjnajXOtQr7vd4EcNdBhts4ke+9CmjMv7HHGrFYhBvTcpTjdTjG19LMMANeFp3/7uO+D+GBtF3PI+ZhYN/GZ4wNqlMvWBcfgBWIpKEiu7xBFu5nWyqSP5KBtuO5bcW1CNIDXhRNBMMNNdhqBRKVTLVV2wPjRwqEyfwmlMjJAx12hau84TLH+SR4Q5hJrZqckqYPgQldrn3LPXDym9DkWL8gqOs+LYQjDoKAZT7nLP8ev/pGI2FT2ja9pitMRNzNIAGOCV65B3CTu6piZ/42oa07UWG97VV1dYOZdQ64TGsj9fp5SyrhsUj7jnYiVbttt47YHGvLvAZMWHH1POfn4XPjD4lYsjMipv/So0c5VOXdoVJq8pfIczNypwebTi8K3Z2t+q+Yo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:36:37.4764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a4dcb9-2c03-44b8-3da0-08de7fade4b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197

From: Manish Honap <mhonap@nvidia.com>

To directly access the device memory, a CXL region is required. For
the userspace (e.g. QEMU) to access the CXL region, the region is
required to be exposed via VFIO interfaces.

Introduce a new VFIO device region and region ops to expose the created
CXL region. Introduce a new sub region type for userspace to identify
a CXL region.

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
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 222 +++++++++++++++++++++++++++
 drivers/vfio/pci/cxl/vfio_cxl_priv.h |   2 +
 drivers/vfio/pci/vfio_pci.c          |   9 ++
 drivers/vfio/pci/vfio_pci_core.c     |  11 ++
 drivers/vfio/pci/vfio_pci_priv.h     |  13 ++
 5 files changed, 257 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 9c71f592e74e..03846bd11c8a 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -44,6 +44,7 @@ static int vfio_cxl_create_device_state(struct vfio_pci_core_device *vdev,
 
 	cxl = vdev->cxl;
 	cxl->dvsec = dvsec;
+	cxl->dpa_region_idx = -1;
 
 	pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAPABILITY_OFFSET,
 			     &cap_word);
@@ -300,3 +301,224 @@ void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev)
 
 	vfio_cxl_destroy_cxl_region(vdev);
 }
+
+/*
+ * Fault handler for the DPA region VMA.  Called under mm->mmap_lock read
+ * side by the fault path.  We take memory_lock read side here to exclude
+ * the write-side held by vfio_cxl_zap_region_locked() during reset.
+ */
+static vm_fault_t vfio_cxl_region_page_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct vfio_pci_core_device *vdev = vma->vm_private_data;
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	unsigned long pfn;
+
+	guard(rwsem_read)(&vdev->memory_lock);
+
+	if (!READ_ONCE(cxl->region_active))
+		return VM_FAULT_SIGBUS;
+
+	pfn = PHYS_PFN(cxl->region_hpa) +
+		((vmf->address - vma->vm_start) >> PAGE_SHIFT);
+
+	/*
+	 * Scrub the page via the kernel ioremap_cache mapping before inserting
+	 * the user PFN. Prevent the stale device data from leaking across VFIO
+	 * device open/close boundaries.
+	 */
+	memset_io((u8 __iomem *)cxl->region_vaddr +
+		  ((pfn - PHYS_PFN(cxl->region_hpa)) << PAGE_SHIFT),
+		  0, PAGE_SIZE);
+
+	return vmf_insert_pfn(vma, vmf->address, pfn);
+}
+
+static const struct vm_operations_struct vfio_cxl_region_vm_ops = {
+	.fault = vfio_cxl_region_page_fault,
+};
+
+static int vfio_cxl_region_mmap(struct vfio_pci_core_device *vdev,
+				struct vfio_pci_region *region,
+				struct vm_area_struct *vma)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	unsigned long req_len;
+
+	if (!(region->flags & VFIO_REGION_INFO_FLAG_MMAP))
+		return -EINVAL;
+
+	if (check_sub_overflow(vma->vm_end, vma->vm_start, &req_len))
+		return -EOVERFLOW;
+
+	if (req_len > cxl->region_size)
+		return -EINVAL;
+
+	/*
+	 * Do not insert PTEs here (no remap_pfn_range).  PTEs are inserted
+	 * lazily on first fault via vfio_cxl_region_page_fault().  This
+	 * allows vfio_cxl_zap_region_locked() to safely invalidate them
+	 * during device reset without any userspace cooperation.
+	 * Leave vm_page_prot at its default.
+	 */
+
+	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
+	vma->vm_private_data = vdev;
+	vma->vm_ops = &vfio_cxl_region_vm_ops;
+
+	return 0;
+}
+
+/*
+ * vfio_cxl_zap_region_locked - Invalidate all DPA region PTEs.
+ *
+ * Must be called with vdev->memory_lock held for writing.  Sets
+ * region_active=false before zapping so any fault racing with zap sees
+ * the inactive state and returns VM_FAULT_SIGBUS rather than inserting
+ * a stale PFN.
+ */
+void vfio_cxl_zap_region_locked(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_device *core_vdev = &vdev->vdev;
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	if (!cxl || cxl->dpa_region_idx < 0)
+		return;
+
+	WRITE_ONCE(cxl->region_active, false);
+	unmap_mapping_range(core_vdev->inode->i_mapping,
+			    VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_NUM_REGIONS +
+						     cxl->dpa_region_idx),
+			    cxl->region_size, true);
+}
+
+/*
+ * vfio_cxl_reactivate_region - Re-enable DPA region after successful reset.
+ *
+ * Must be called with vdev->memory_lock held for writing.  Re-reads the
+ * HDM decoder state from hardware (FLR cleared it) and sets region_active
+ * so that subsequent faults can re-insert PFNs without a new mmap.
+ */
+void vfio_cxl_reactivate_region(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	if (!cxl)
+		return;
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
+	guard(rwsem_read)(&core_dev->memory_lock);
+
+	if (!READ_ONCE(cxl->region_active))
+		return -EIO;
+
+	if (!count)
+		return 0;
+
+	return vfio_pci_core_do_io_rw(core_dev, false,
+				      cxl->region_vaddr,
+				      (char __user *)buf, pos, count,
+				      0, 0, iswrite, VFIO_PCI_IO_WIDTH_8);
+}
+
+static void vfio_cxl_region_release(struct vfio_pci_core_device *vdev,
+				    struct vfio_pci_region *region)
+{
+	struct vfio_pci_cxl_state *cxl = region->data;
+
+	if (cxl->region_vaddr) {
+		iounmap(cxl->region_vaddr);
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
+	cxl->region_vaddr = ioremap_cache(cxl->region_hpa, cxl->region_size);
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
+		iounmap(cxl->region_vaddr);
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
+ * Marks the DPA region inactive so any racing fault returns VM_FAULT_SIGBUS
+ * and resets dpa_region_idx.  Does NOT call release() or touch num_regions;
+ * vfio_pci_core_disable() will call the idempotent release() callback as
+ * normal during device close.
+ *
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
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_priv.h b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
index 985680842a13..b870926bfb19 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_priv.h
+++ b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
@@ -26,9 +26,11 @@ struct vfio_pci_cxl_state {
 	resource_size_t              comp_reg_offset;
 	size_t                       comp_reg_size;
 	u32                          hdm_count;
+	int                          dpa_region_idx;
 	u16                          dvsec;
 	u8                           comp_reg_bar;
 	bool                         precommitted;
+	bool                         region_active;
 };
 
 /*
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 0c771064c0b8..d3138badeaa6 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -120,6 +120,15 @@ static int vfio_pci_open_device(struct vfio_device *core_vdev)
 		}
 	}
 
+	if (vdev->cxl) {
+		ret = vfio_cxl_register_cxl_region(vdev);
+		if (ret) {
+			pci_warn(pdev, "Failed to setup CXL region\n");
+			vfio_pci_core_disable(vdev);
+			return ret;
+		}
+	}
+
 	vfio_pci_core_finish_enable(vdev);
 
 	return 0;
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
index 818d99f098bf..441b4a47637a 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -140,6 +140,10 @@ void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev);
 int vfio_cxl_create_cxl_region(struct vfio_pci_core_device *vdev,
 			       resource_size_t size);
 void vfio_cxl_destroy_cxl_region(struct vfio_pci_core_device *vdev);
+int vfio_cxl_register_cxl_region(struct vfio_pci_core_device *vdev);
+void vfio_cxl_unregister_cxl_region(struct vfio_pci_core_device *vdev);
+void vfio_cxl_zap_region_locked(struct vfio_pci_core_device *vdev);
+void vfio_cxl_reactivate_region(struct vfio_pci_core_device *vdev);
 
 #else
 
@@ -152,6 +156,15 @@ static inline int vfio_cxl_create_cxl_region(struct vfio_pci_core_device *vdev,
 { return 0; }
 static inline void
 vfio_cxl_destroy_cxl_region(struct vfio_pci_core_device *vdev) { }
+static inline int
+vfio_cxl_register_cxl_region(struct vfio_pci_core_device *vdev)
+{ return 0; }
+static inline void
+vfio_cxl_unregister_cxl_region(struct vfio_pci_core_device *vdev) { }
+static inline void
+vfio_cxl_zap_region_locked(struct vfio_pci_core_device *vdev) { }
+static inline void
+vfio_cxl_reactivate_region(struct vfio_pci_core_device *vdev) { }
 
 #endif /* CONFIG_VFIO_CXL_CORE */
 
-- 
2.25.1

