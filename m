Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBC938B128;
	Wed, 11 Mar 2026 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261436; cv=fail; b=JziYxw/xYOesr73mcokx+Wk7B9JjQsv9Hh3+5TfwS1JnG5BibCUtaNuFKcu89o+ufIXOnl7KcuHjIUHgaaPVUDJaqsLJHlsSfrafxHt4SLpoM3zjAFOygpGjtqWZR/Z40c88rzbORiHlLhfUUXyHOw0DDeQs9GsXy+ARtSnjly8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261436; c=relaxed/simple;
	bh=e4n10ohjFp6RXqcpVVlyAItBgYZ71DyFYfVTlwZtef8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWhJsDNvZKlS/GJfKxQEGbT7rb/G7k+Yr2KRnLmN0NM8sIwAKVmXJZKNkFcCue90GBBodndY6QOD8TEFYsBey/a3biXlAYnh6gD+T1gk/QetKbWc3aDEfH+MhZ0J5u/AXPm/B/6UyL8jigYKE32rSIuQS3xCBu1VVu3OdcR5FDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qUW/meIW; arc=fail smtp.client-ip=52.101.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qUW/meIW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaO+xXgh2IwBh+xMoDMa8gIWVJ29VAZumCVVPC0lGl0rwuCERlzQyxwfVvNa5PxoFSlZI8XNQNbaaAiHHNa+iVwyFY+51+twyI+RNWJ8Wf/loC/td1+sp8Y753k1WGgJH99k7ZGf08cQa74qkexZMO5cg7TSALkR5m7h9t0Q6pzAno8fwP3zzoHTSNXMOHzZnvf4LeoA0csXsARwF7SpDuOGzR48xWVYeCROlpeeQdvRLj+fxM7vA5SFwLf4wu+pW2SIARtwGg/CBbfkNRZ5Hj7jklXKmhcE0ULeo7JhQ7QTsGf/oektFj43Bdiy19tjY0Oalb76Y//dDfZiX9eh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kcutj/1qDb0w1eYvBzYmjC7sE8B17aXoQwdEUaGrQQ=;
 b=MhOF0r+vY6ZG96EHtrHGY7p22cdOog8gazolXNFHUZCrYuMaCt1EgUZH9SA5ey5JaN8VE6jYyidXv5+kIrafOylwYOAo0OrGEUnVbRHh2wp7fQ5PCIX0F2VvlSlqinMU10qfZIeFCD5vVcoNI2lgL4gv8Gpogb39kUyW+gl/n0hLOfJK77E3jrYOM448nNJBDoR905efVmU0kn1Y6bjG2BnxVux0HrT22OtLiM88KJet8A29vO5nNr+KiRR2SX/qole2qD22b2gMgd64EwlgY4OE1AOgLzU76k9mN7ncdecee4p3FSEIStS2vTKIUEBn9/lfxWEBJv8uoSPXMXTTZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kcutj/1qDb0w1eYvBzYmjC7sE8B17aXoQwdEUaGrQQ=;
 b=qUW/meIWJZlS5IL6QKMgwhOJzc+eqXTY2ceds+ipsztXZvmJsgUvbeq6dsuv0FbLq1m8ph/cYseZhrfoU/biz9uOhRicTCEK2dqa3Oft6RG8Fyg4kggkme9U0M2HiG/otfUW02IPqKvcIguFs+EO1NxlHN5lRad1u5cubfXMZYK2ZKeXcf1aFPhziRiesLoocxXyVYx3oICxyHDB7FshKhGmgb9yutUVhixBgEwUIDFckrzt8e02VUvEmJ9FrYbhTNhjzAi3mPMyz9NfGI13hEtr1jzlKBZ2xZI7UabwbT05MWw1unOXs+VmghAJkODFy5tuh9e/CoTEm2S6+0SZig==
Received: from DM6PR05CA0051.namprd05.prod.outlook.com (2603:10b6:5:335::20)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 20:37:07 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::5) by DM6PR05CA0051.outlook.office365.com
 (2603:10b6:5:335::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.15 via Frontend Transport; Wed,
 11 Mar 2026 20:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 20:37:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:36:43 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:36:42 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 13:36:35 -0700
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
Subject: [PATCH 14/20] vfio/cxl: Check media readiness and create CXL memdev
Date: Thu, 12 Mar 2026 02:04:34 +0530
Message-ID: <20260311203440.752648-15-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: 125e3338-b950-41a2-e0ab-08de7fadf697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	97cSGeU55p2mzWykshNUfv/OfA87fUyHtau2MB2Cp3fGvq69r1ZRy9Rgm6El6b/xOSMVmdEDotZ6tQ6KYZbXndWVqT34I5hA86VBS5WPjAq7slPKf8XTPecmr1GDs8u4vzc5ntL23GDQbYxMhTy9Cs3EVQiT+/Q5DYtotWhAvhacxfpyp9RkXWLnJ4HExlRidCfkaNWCbr/Q2ZC34ZV69Ju2TMtC6Sw4XZ7NE/6vuHYJP4rxo3MCz3/5VkCzAyhMmJhiNa395Z4Lhstxwast9fTQDDJuZ4cpl+tplQNF4qxxKqvTBy31WCqicH9f5xEC+FooCpyFZzwc8k6BJGjsqiXw4PppE36pcdQmOBL8AyL8NvRP27bvHee9uWafC8G39gVrypwGxXEhMEGU+Jt4q0yAsCLPiu0r6YHwI1FS8cLPrLXS2TpYpD4n7clpv0nncvuOXeRZZsl+4GMCLToF/3VpUWDthNwctJsw/+kj9p3W7IzKh3ECBakUeftqhqmIJ7NFzBUC4StsON5jc8q7qToBo1xsOD9q5QccSj68olzONIclqVRxbh7Lm2efASZOm9Y9BgBmri7Fl/vQvtkQn6FWgwn15xAWDh6ZZEQpS6VNcOAg5a1hQHge4gFTpGE3POsesOOIpmYz3yj1bU9tAVs+JE9USeH3nVAejO22qt5Hre6PZgMD8Xh4vbUGZ1CY+z5/fVsmsb3sHAxMcLOAURNXYRZWMRnlQKBxR6WEmDoe1is3ROpGGy32DXMWBE3OHDmPV+lpBAQmoHOnUE+e/Xmqm04letSi4hNbnXJmgppNbqA8OhGLTPwq4EmRIQiR
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mQO3AdbRK8eGzd90D9W1ZdJpQfdJXkLOJFzzNRNDoE25KV2hEinXRHwbD52isuT+aDbDzm1AXFT6G3SYy133pjz+JCXl18Ey6RgnqxDnXaEph+2v9qzc/BH8L62y+CeGRBJ6V9WsASm5d6ISKsphaquCAIUpgD9RORitX68/OtOcOjhV2OYrt3yBvNacbVh5dQoIQlG2Fkg2JRt8tMx/Mo3+b0/yhiRo60iijdcooSi9AUvjXrgYBnDJO9qnFSzaoShTomN1Y1dnVe+YfiZclbMlMLAto0SCd+09RlioAOJ6Zk7we9CIOI4F5N8H1gm9ZgI7HDQ5wX/cPeQ58kugHx+vthzi/GJkfu3xtkqeQ+hUOrUGUygXSDNVyYirNsJZ71QfZ4iR5t9hMxVPyhgZHEaGSaqZ7rL7uVN0HL4HzlKlyIUUg31cQ7mcN+xhe0u/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:37:07.5032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 125e3338-b950-41a2-e0ab-08de7fadf697
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450

From: Manish Honap <mhonap@nvidia.com>

Check media readiness at probe time and create a CXL memdev for region
management.

Media/range-active check is performed at probe time to keep the
vfio-is-advertised-as-cxl behavior consistent. A pre-committed HDM
decoder already implies media is active, so set media_ready directly
instead of calling the potentially blocking cxl_await_range_active().

For memdev creation we need to determine capacity before calling
devm_cxl_add_memdev(). Read the committed decoder size directly from
HDM decoder hardware registers; the CXL core will see the same values
when it enumerates decoders inside add_memdev.

For firmware uncommitted decoders, handling will be added in a later
commit.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 67 +++++++++++++++++++++++++++-
 drivers/vfio/pci/cxl/vfio_cxl_emu.c  | 48 ++++++++++++++++++++
 drivers/vfio/pci/cxl/vfio_cxl_priv.h |  2 +
 3 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index d2401871489d..15b6c0d75d9e 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -132,6 +132,37 @@ static int vfio_cxl_setup_regs(struct vfio_pci_core_device *vdev)
 	return 0;
 }
 
+static int vfio_cxl_create_memdev(struct vfio_pci_core_device *vdev,
+				  resource_size_t capacity)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	struct pci_dev *pdev = vdev->pdev;
+	int ret;
+
+	ret = cxl_set_capacity(&cxl->cxlds, capacity);
+	if (ret) {
+		pci_err(pdev, "Failed to set capacity: %d\n", ret);
+		return ret;
+	}
+
+	pci_dbg(pdev, "Device capacity: %llu MB (from %s)\n",
+		capacity >> 20,
+		cxl->precommitted ? "committed decoder" : "sysfs");
+	pci_dbg(pdev,
+		"vfio_cxl: creating memdev: capacity=0x%llx bytes (%llu MiB)\n",
+		(unsigned long long)capacity,
+		(unsigned long long)(capacity >> 20));
+
+	cxl->cxlmd = devm_cxl_add_memdev(&cxl->cxlds, NULL);
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pdev, "Failed to add CXL memdev: %ld\n",
+			PTR_ERR(cxl->cxlmd));
+		return PTR_ERR(cxl->cxlmd);
+	}
+
+	return 0;
+}
+
 int vfio_cxl_create_cxl_region(struct vfio_pci_core_device *vdev, resource_size_t size)
 {
 	struct vfio_pci_cxl_state *cxl = vdev->cxl;
@@ -250,6 +281,7 @@ void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_cxl_state *cxl;
+	resource_size_t capacity = 0;
 	u16 dvsec;
 	int ret;
 
@@ -282,13 +314,44 @@ void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
 		goto failed;
 	}
 
+	cxl->cxlds.media_ready = !cxl_await_range_active(&cxl->cxlds);
+	if (!cxl->cxlds.media_ready) {
+		pci_disable_device(pdev);
+		pci_err(pdev, "CXL media not ready\n");
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
+	vfio_cxl_reinit_comp_regs(vdev);
+
 	pci_disable_device(pdev);
 
-	ret = vfio_cxl_create_region_helper(vdev, SZ_256M);
-	if (ret)
+	capacity = vfio_cxl_read_committed_decoder_size(vdev);
+	if (capacity == 0) {
+		/*
+		 * TODO: Add handling for devices which do not have
+		 * firmware pre-committed decoders
+		 */
+		pci_info(pdev, "Uncommitted region size must be configured via sysfs before bind\n");
 		goto regs_failed;
+	}
 
 	cxl->precommitted = true;
+	cxl->dpa_size = capacity;
+
+	ret = vfio_cxl_create_memdev(vdev, capacity);
+	if (ret)
+		goto regs_failed;
+
+	ret = vfio_cxl_create_region_helper(vdev, capacity);
+	if (ret)
+		goto regs_failed;
 
 	return;
 
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_emu.c b/drivers/vfio/pci/cxl/vfio_cxl_emu.c
index d5603c80fe51..178a42267642 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_emu.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_emu.c
@@ -300,6 +300,54 @@ int vfio_cxl_setup_virt_regs(struct vfio_pci_core_device *vdev)
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
+vfio_cxl_read_committed_decoder_size(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	struct pci_dev *pdev = vdev->pdev;
+	resource_size_t capacity;
+	u32 ctrl, sz_hi, sz_lo;
+
+	if (WARN_ON(!cxl || !cxl->comp_reg_virt))
+		return 0;
+
+	ctrl  = le32_to_cpu(cxl->comp_reg_virt[CXL_HDM_DECODER0_CTRL_OFFSET(0) /
+					       CXL_REG_SIZE_DWORD]);
+	sz_hi = le32_to_cpu(cxl->comp_reg_virt[CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(0) /
+					       CXL_REG_SIZE_DWORD]);
+	sz_lo = le32_to_cpu(cxl->comp_reg_virt[CXL_HDM_DECODER0_SIZE_LOW_OFFSET(0) /
+					       CXL_REG_SIZE_DWORD]);
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
+		"vfio_cxl: decoder0 committed: sz_hi=0x%08x sz_lo=0x%08x "
+		"capacity=0x%llx (%llu MiB)\n",
+		sz_hi, sz_lo,
+		(unsigned long long)capacity,
+		(unsigned long long)(capacity >> 20));
+
+	return capacity;
+}
+
 /*
  * Called with memory_lock write side held (from vfio_cxl_reactivate_region).
  * Uses the pre-established hdm_iobase, no ioremap() under the lock,
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_priv.h b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
index 4f2637874e9d..3ef8d923a7e8 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_priv.h
+++ b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
@@ -26,6 +26,7 @@ struct vfio_pci_cxl_state {
 	resource_size_t              comp_reg_offset;
 	size_t                       comp_reg_size;
 	__le32                      *comp_reg_virt;
+	size_t                       dpa_size;
 	void __iomem                *hdm_iobase;
 	u32                          hdm_count;
 	int                          dpa_region_idx;
@@ -81,5 +82,6 @@ struct vfio_pci_cxl_state {
 int vfio_cxl_setup_virt_regs(struct vfio_pci_core_device *vdev);
 void vfio_cxl_clean_virt_regs(struct vfio_pci_core_device *vdev);
 void vfio_cxl_reinit_comp_regs(struct vfio_pci_core_device *vdev);
+resource_size_t vfio_cxl_read_committed_decoder_size(struct vfio_pci_core_device *vdev);
 
 #endif /* __LINUX_VFIO_CXL_PRIV_H */
-- 
2.25.1

