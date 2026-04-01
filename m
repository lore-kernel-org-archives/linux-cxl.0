Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011011.outbound.protection.outlook.com [52.101.57.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8354779B0;
	Wed,  1 Apr 2026 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054496; cv=fail; b=LTHvN42fbCzvarY8p3okGbiZ/gVLWLGALmb7kj4x0NgY5IaZXSU4GJYq8kfJ8tgGEZNTqndvx8Sa5pUkaglSJsTVoyeWFRctAttGxCFCRJzqPdQx0KA6KDR/C6A+TUKd2wLXuDowfNSRrOgnrsT5gAyEf5jvkQX97MqnESYKDvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054496; c=relaxed/simple;
	bh=PSUKfxYiBjbOGXI+UZ+yzSSynVKBFugSw/7R/RoCQRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYMAxYRbQqoNxXAO+aklkxmERnzjJJKQSsXtQtbbPVb7VLhqTrVYvXKWgbhaPFez4A/KfkVlCqny/dDQ/bXXySPQrmgGCVpZN+B0Nz0MFB37U55xvqeV59joyyFjvVHlGUFJzrsKP5+u6NiTkFJmM4NBQFMXZtwETR23JE+mWhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IayMhd3w; arc=fail smtp.client-ip=52.101.57.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IayMhd3w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpWzCEVD9sHP/Ng8eB+osEXrv2U0LqJbT4KqlXG+8FDNWxQ/ZaYgYs0u3hlEzVlfkl94v6jDcrm58BcaxvSmsUkqZDNUOjSiqnHWpy6mdkf23rRUI1v6UxYSfRGBe1nl1c1stLIjdyxNn/yZMtS7+DekBP+EXJ/HZPkthRUMZ4SHn+Mslo8cjjQnlF8T/sq4EkLVdjnRgwvcUeoMp2IdqCKBvgd6By27+XqOAh0RPq7TnqNDIdnR9e65W6eiH5mcDq0H0Z03AJDyC6D9leit8ZiVXqSTvF2oTLqhbfVJx59yvA4c/6K/RipJul55sBn7xsr6OA5RF8zfJqpHqoK+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbj2xnKn8lmK38Gjmqq8Z6gLWeZblrqIiMkO2GT9JAw=;
 b=FUUS16++u4i3OIb/nxIVV1vVDi+hiXM+DnK6ojDr+70E9eXHr0YzVeXySbI548WjOnO7GFlqk0wNPv4HXbED3cWDi5qa6hYutudS0Qayif7CR57CaD0k2zoIFgfl7QA6GSuEnx94NaksZGRzMF2ktwjwDbTp/W/iw+0F/1fQ9BNIjimx/aAQJb4bOAPBzhGh0pEi7mYtHJekbFSjl4xSfgHtSaOb8rmo7lHTAb+tZkC87XI9S3eI2dTHhjt9WiMZ84vI+2/XJccVI+08uJtCp8FFCaMj5B3bc0gNUxaCXnSDih47H/WYQT3y65d1nB0hHntzYlDx77ex1dXaaoFsvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbj2xnKn8lmK38Gjmqq8Z6gLWeZblrqIiMkO2GT9JAw=;
 b=IayMhd3wfoQFFLA94n5hhW+vRFBHTdG0SCjTxmYYw+lfZxnOrsJcrRh51epXEU5NK7UPlWah8A0GbQ8PTJApkWTACMAI/k5gY0zGr/0IDUAAfNhUV566/REwd22bWH0lIEUak9XF9IFTPt7lzUTbMf4Z+1K4WC5G3CsuFxbr1jOi6Jiet+0Pwu6hvoi/NRDswJ2mip4TcXVzo5L5vucGrqqEgxWPcYE8RnlQkunMc9DRO1YaIrkZeFTHr8mMw7awbySXPa3bCGuJ6pTmncC5xXWQGoNMAsTcruvG4X95nS973hjgA2nsz9zcvrQvzZEfFDyPHn92cWdNulEBVXCvdw==
Received: from BN0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:408:e6::30)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 1 Apr
 2026 14:41:31 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::7d) by BN0PR03CA0025.outlook.office365.com
 (2603:10b6:408:e6::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 14:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:41:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 07:41:07 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 07:41:00 -0700
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
Subject: [PATCH v2 12/20] vfio/cxl: Wait for HDM ranges and create memdev
Date: Wed, 1 Apr 2026 20:09:09 +0530
Message-ID: <20260401143917.108413-13-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|MN2PR12MB4045:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4bd8f9-86f5-46de-9a8e-08de8ffcc423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|376014|82310400026|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eu7uX4w3NlLAeu70trtSqE5OuHV0ss20JLIGuP5uy5ZGp/Bxqowk3Ke7Yha6oXcXFAUex2FRmyWJW4c/iNIonebm1E0wSISXn72/qRBGTwK5kZ0nvNbvEAglegjyfI+CDL5/sX+0GIMftTyf7kBRvmqzlRr8cSDadSfcGx9aj6C5wsIygimZDg2h2IHu7kXp7wWXfUK+N+iMikuXJuKbTjUtwvf1knQRjXgNXd8yWkPWyXW2dHdtp4ZEscXcqy1IPewdP0x+Ry08tSqdZTNcgisD6JXtCckGdxmF6jtZ2XfFYybsZr4b6pEkLaCpX21+dJWbtvBLlbZL4CX4cX9HPcD8P4CnVYE6U5rY4qNg+/qPZfJvcqjKJ0EEzhiyBwi9JwpAjXG1Oyk0i6zyxoYQ7gVD0p9QBwcZQFtto9t0YAuDAQOBU/F1dWqIrL3NByUX43Y44j+OCmEnyC4O8kSQZmG7AHXZF3nzqVEAg/KNF6PMyDsj6pvRiWfmH4prUUkV2mfiaPaQiFFKz6JPIMZFw47AZSCu8GAzQY2bV0agTI5gG599FiaQXtJaaFTtPH8WlFVHJkzvLkffaaBcW7rLZVEgedXcM85Qn1ZhSBeWco1Eo/ZgsUC5j4WJSro3X5tTYQ3YgPC7dtWZ6L+bcJta++sHHxQPmJ3zn/pl9JHvr6Dv8F94+zuVxaNWEgy3fcS0ge+aNBo5D0OLlV+scrHRncqjj0yI2ro1LD+czJqZLttbljbVdAaE4YcqEzkoQjmeCqbKmFz7sr67FEJ7qaKpB+Lf/nudG4crxRLK2SF3qdUQI0rL1aU5FS8UauRAViUO
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(376014)(82310400026)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j29ykWE5/QKM9BOzsuTohqU1NXiEOEREjNvpjh7crKOcsAc7GT0qihMUXhNnMNhUAQz8KtNeEQk8rXg9JYVYQLk8bpUJq8eYLf3SnV6wzTnzqDgzZWkx97T2dOg9kvBDtlZqKUhzFn8Ut7FVwAr/Xz4cfjoiPbhKTodBpbizj5SxkPSNVq3oRUJfOdVZZtgsvtMYWQBh7bykK7VUu94HTQYXDEBqDb5YOkr6hFDbdRSfddnBj1w0yE5m/qQiWxeCMC/40FUkaWQklTbCICKRDWSfuxZ3Q3eUwv1Bg9CUitxWfmOG9I3YeOg0P88pFj9JwnYk5BPZkLAjaLWSgmNRZOQIGqJ/BUIgz8PB+DHIHTBLUqgJ57d5u/AhEegg5eHVJPvofkY+fyfX4T00XubfLxjPPRH6STibkh0CKalNhLGiQ2S+GmDfu3D/1Dz4rnRk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:41:31.6404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4bd8f9-86f5-46de-9a8e-08de8ffcc423
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045

From: Manish Honap <mhonap@nvidia.com>

After HDM registers are mapped, call cxl_await_range_active() so we
only proceed when DVSEC ranges report active without touching the
memdev register group Type-2 may lack.

Re-snapshot component regs (vfio_cxl_reinit_comp_regs) once
MEM_ACTIVE so firmware final SIZE_HIGH etc. land in comp_reg_virt.

Read committed decoder size from hardware, set capacity via
cxl_set_capacity(), and devm_cxl_add_memdev().

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 56 ++++++++++++++++++++++++++++
 drivers/vfio/pci/cxl/vfio_cxl_emu.c  | 42 +++++++++++++++++++++
 drivers/vfio/pci/cxl/vfio_cxl_priv.h |  4 ++
 3 files changed, 102 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 0b9e4419cd47..02755265d530 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -165,6 +165,22 @@ static int vfio_cxl_setup_regs(struct vfio_pci_core_device *vdev,
 	return ret;
 }
 
+static int vfio_cxl_create_memdev(struct vfio_pci_cxl_state *cxl,
+				  resource_size_t capacity)
+{
+	int ret;
+
+	ret = cxl_set_capacity(&cxl->cxlds, capacity);
+	if (ret)
+		return ret;
+
+	cxl->cxlmd = devm_cxl_add_memdev(&cxl->cxlds, NULL);
+	if (IS_ERR(cxl->cxlmd))
+		return PTR_ERR(cxl->cxlmd);
+
+	return 0;
+}
+
 /*
  * Free CXL state early on probe failure.  devm_kfree() on a live devres
  * allocation removes it from the list immediately, so the normal devres
@@ -189,6 +205,7 @@ void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_cxl_state *cxl;
+	resource_size_t capacity = 0;
 	u16 dvsec;
 	int ret;
 
@@ -234,8 +251,44 @@ void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
 		goto free_cxl;
 	}
 
+	cxl->cxlds.media_ready = !cxl_await_range_active(&cxl->cxlds);
+	if (!cxl->cxlds.media_ready) {
+		pci_warn(pdev, "CXL media not ready\n");
+		pci_disable_device(pdev);
+		goto regs_failed;
+	}
+
+	/*
+	 * Take the single authoritative HDM decoder snapshot now that
+	 * MEM_ACTIVE is confirmed and BAR memory is still enabled.  Using
+	 * readl() per-dword ensures correct MMIO serialisation and captures
+	 * the final firmware-written values for all fields including SIZE_HIGH,
+	 * which firmware commits to the BAR at MEM_ACTIVE time.
+	 */
+	vfio_cxl_reinit_comp_regs(cxl);
+
 	pci_disable_device(pdev);
 
+	capacity = vfio_cxl_read_committed_decoder_size(vdev, cxl);
+	if (capacity == 0) {
+		/*
+		 * TODO: Add handling for devices which do not have
+		 * firmware pre-committed decoders
+		 */
+		pci_info(pdev, "Uncommitted region size must be configured via sysfs before bind\n");
+		goto regs_failed;
+	}
+
+	cxl->dpa_size = capacity;
+
+	pci_dbg(pdev, "Device capacity: %llu MB\n", capacity >> 20);
+
+	ret = vfio_cxl_create_memdev(cxl, capacity);
+	if (ret) {
+		pci_warn(pdev, "Failed to create memdev\n");
+		goto regs_failed;
+	}
+
 	/*
 	 * Register probing succeeded.  Assign vdev->cxl now so that
 	 * all subsequent helpers can access state via vdev->cxl.
@@ -246,6 +299,9 @@ void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
 
 	return;
 
+regs_failed:
+	vfio_cxl_clean_virt_regs(cxl);
+
 free_cxl:
 	vfio_cxl_dev_state_free(pdev, cxl);
 }
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_emu.c b/drivers/vfio/pci/cxl/vfio_cxl_emu.c
index 6fb02253e631..11195e8c21d7 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_emu.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_emu.c
@@ -365,6 +365,48 @@ int vfio_cxl_setup_virt_regs(struct vfio_pci_core_device *vdev,
 	return 0;
 }
 
+/*
+ * vfio_cxl_read_committed_decoder_size - Extract committed DPA capacity from
+ *					  comp_reg_virt[].
+ *
+ * Called from probe context after vfio_cxl_reinit_comp_regs() has taken the
+ * post-MEM_ACTIVE readl() snapshot and patched SIZE_HIGH/SIZE_LOW from DVSEC.
+ * comp_reg_virt[] is already correct at this point; no hardware access needed.
+ *
+ * Returns the committed DPA capacity in bytes, or 0 if the decoder is not
+ * committed.
+ */
+resource_size_t
+vfio_cxl_read_committed_decoder_size(struct vfio_pci_core_device *vdev,
+				     struct vfio_pci_cxl_state *cxl)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	resource_size_t capacity;
+	u32 ctrl, sz_hi, sz_lo;
+
+	if (WARN_ON(!cxl || !cxl->comp_reg_virt))
+		return 0;
+
+	ctrl  = le32_to_cpu(*hdm_reg_ptr(cxl, CXL_HDM_DECODER0_CTRL_OFFSET(0)));
+	sz_hi = le32_to_cpu(*hdm_reg_ptr(cxl, CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(0)));
+	sz_lo = le32_to_cpu(*hdm_reg_ptr(cxl, CXL_HDM_DECODER0_SIZE_LOW_OFFSET(0)));
+
+	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED)) {
+		pci_dbg(pdev,
+			"vfio_cxl: decoder0 not committed: ctrl=0x%08x\n",
+			ctrl);
+		return 0;
+	}
+
+	capacity = ((resource_size_t)sz_hi << 32) | (sz_lo & GENMASK(31, 28));
+
+	pci_dbg(pdev,
+		"vfio_cxl: decoder0 committed: sz_hi=0x%08x sz_lo=0x%08x capacity=0x%llx\n",
+		sz_hi, sz_lo, (unsigned long long)capacity);
+
+	return capacity;
+}
+
 /*
  * Called with memory_lock write side held (from vfio_cxl_reactivate_region).
  * Uses the pre-established hdm_iobase, no ioremap() under the lock,
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_priv.h b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
index 463a55062144..6359ad260bde 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_priv.h
+++ b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
@@ -22,6 +22,7 @@ struct vfio_pci_cxl_state {
 	resource_size_t              comp_reg_offset;
 	size_t                       comp_reg_size;
 	__le32                      *comp_reg_virt;
+	size_t                       dpa_size;
 	void __iomem                *hdm_iobase;
 	u16                          dvsec_len;
 	u8                           hdm_count;
@@ -83,5 +84,8 @@ int vfio_cxl_setup_virt_regs(struct vfio_pci_core_device *vdev,
 			     void __iomem *cap_base);
 void vfio_cxl_clean_virt_regs(struct vfio_pci_cxl_state *cxl);
 void vfio_cxl_reinit_comp_regs(struct vfio_pci_cxl_state *cxl);
+resource_size_t
+vfio_cxl_read_committed_decoder_size(struct vfio_pci_core_device *vdev,
+				     struct vfio_pci_cxl_state *cxl);
 
 #endif /* __LINUX_VFIO_CXL_PRIV_H */
-- 
2.25.1

