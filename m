Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011007.outbound.protection.outlook.com [40.93.194.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA6B388E44;
	Wed, 11 Mar 2026 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261360; cv=fail; b=YZRxexGXmQzjti5Y6cczfq0j1/vHASiX45Y38qNpJ37HymLP5wYA6PrNZLJs/ozxFNuRMFRN4Tszj/OtqMBNiy56c5/2boEQl5ljO9CpNP3AWkfsX046Eu87br4L1962WUP3KzyxzK3QpsAicUzmMypBw2j+U9YrBAjIf08JLYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261360; c=relaxed/simple;
	bh=oE5uFv5dAMUI1Vu6fnn9d12u+eQet13FwDEda9yalak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3whr2cL6Uk/94+gyER6oGbp9jUz7Q8vgRoab2583uIG2iYEnxUodNInAX1OlC4RAI33DK/K0jQDwqyYRcVsyf4+ZJ4vatXSVqj0isGuKDlrhNArUWV57jN5W9GaplIK5vvHwvxuGfZPXa9eAK71JVx78vOgeytl+SnZw2BSPGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DKvsAf/i; arc=fail smtp.client-ip=40.93.194.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DKvsAf/i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzW6oPQrM4vnBrpv/L9zn64i3WsNCCE9ka3aFr+HJ6RG8rOopXB9y+/kF8/oLJ2cfzthPUWbyjiT9XFT4mbAytmtLtaeHH9+aok3Vejg6UfbS9YbwXggeUDxP/BaDJ7rRaC4t7/TwEj9FtzfTy2U+yzjYx8Od0t+CqzKfbZY48mEB5D1pddMj3tcVq+Z7kyHlmMDRM2Ziyn4sBCmezWdHx3WMhFCR6vKTvYb8LjU0XV+bodZIOUPIG3yILSLkdQQzdv375NDnfUKknr2S+j/EkiepCl3tfMDvOYXE1lwRVh54r50VxV8FRRVqhQyEgVTWn0o5p4XCbMtnHZSBI7ZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQ3fYVpj9CKY4z2r+rWveKB4c2mwG689sxGowIrzm58=;
 b=gl8BUTeQHFYSt+A2dUw4ajVXMHVkGoHuNy8x6yF/1ehMzoJwUAxI1xz1ul/f6tF+mv6bIdYFV685dT/PxLaOnu4KZmsqRe8QkJg2YTElUXQ+ZMecRcNLW0JSDZkIRy2epYZ4bj+j1E2NLM5m+yAkfhfVghzypmVYp4UhSq/4s0/2ZHap1YF3Tl46feZJDCF2g5GwfWoPu5WRQrrv9I887rkVfaKNt8EV/ajCAO2PUiMc26gYTwDNoGHVaLQqqcoQPXmSTDDj7hXy12l4jn9gc2cnAvg3aoTmcfdS+Y410XzSETTQiaeu9CvcZKAoyZtojoaG0xGiD+Afc1Bk+eJXdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQ3fYVpj9CKY4z2r+rWveKB4c2mwG689sxGowIrzm58=;
 b=DKvsAf/iUUjCWQVXqOHGgrk7WGW79vOdEZNuhDF6VJTFQ3b9WZOxV/s9JzO22/ekADkFmCRBbagCxvcUdrWFmUAjihP2gKF4W+KWYFg/V/3BBOAqz7dHREXs6E9u4+qQ82QbsjOxTVCNOkNKQBVdmARehEbaYnbGYdyAknHds1qlltbkpHPLedqkGvyxam886WZj42BexA0AHy8sq01UFE1rIQssK0p1MIKg76m2j3jYTzilJEP/H256DMCXyzdav5Acmj59DkmKVFmK/8hcL3dZ/RAW+k8mzgT+FlnxcuU0PBtfgJrqojrfxlSB1Okhza6eJd+2fgn/SB5l2iNt3w==
Received: from SN7PR04CA0088.namprd04.prod.outlook.com (2603:10b6:806:121::33)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 20:35:53 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::29) by SN7PR04CA0088.outlook.office365.com
 (2603:10b6:806:121::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 20:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 20:35:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:35:27 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:35:27 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 13:35:20 -0700
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
Subject: [PATCH 04/20] cxl: Media ready check refactoring
Date: Thu, 12 Mar 2026 02:04:24 +0530
Message-ID: <20260311203440.752648-5-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: c9355dd6-e280-42fd-6a0a-08de7fadca3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	of2LLsAGqtUtV455hk31HJSxc6GR3j8DPwHHpciuPbDGtD5qIbPJ6f+IDQ4QTRRqnXStJBFhOat5ZNHR44Vkd5ZSzH8DA/+RfZQ1P4fzCFwjobHiDu6+HYatrGIjIRvmxsj9XE9o8Zfn47BHFs6pN42UbP6upO+N2Ii4vFI0AlR+ngK516igJiHzYK2wu9B7A+Fo/VkEvGjIdCGnlQc67YJTSi2/mbSIs4KDfRIgXJBIk3Jzvdd6debBNHy/CrisSNEhezZdRF3MLGiMF50mJ2D11bxtR+g3E+QHRyQlMFHDA4/3ED4d+vV6KGoB7AlYKrtKYIAGXCW4X6edvoLwEfDl4ZK/vwC/6n7r5ymAJz7PJD/wPEESrdRxPNLDMDqZIq2ModkZZULau8Ajp/QUR8P9WUiXL9CxVhyTSAC99r3eK3Hgwq7le4sm2rmvwJGV9Z0cYBX+Mz0yNPPQe06c9xq+WWcEvCppnG3zhluGZAwHarYupBKL8KMViK7FrzqcyBwkb0FKMn4pLdRcrO1gQWRDdlL8gLnubUkEcGXoDM8fRXgZ2t0y9Qeb1cP7CvIgLqEjz7P1WhKgHe8ZUrEaDWJKC9aTWdNYnqc55GOzmRolqVEXrajimxY/ZvBPStv296SURK2bMRCd/xdnXpKswPJ7RPzyqUGbTFRNdhtGYMDjNN6i99cD4iXp96GRWfoAIUFds3tYGzAuiarFvycOZorKOVlwAY+oZwSnQGQABxWsHqFq+LIDVQBrOlRplyZbaNC/g7KM4/S011AwFuG+XA6wxHCF+kpW1DhMyO/MvRrcZ3PFqWN2pTKgFcGZ9YlK
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8rFt1jVIKUMug/URqPdiWWHoSeF48rVcbRui2UGrElaZa2yARToGyQKU51KS46FzARerK2oYsz01mo0Lrm9MnQZKZWxx8R/d8BczhjA/JqiMEsd3z/rPdqI7D33tfPPktL5ccvIQDgkZykrX1hH6LDxBvfKyPLTF2v1hqBpp+cDrELs/cw8g/6X2wQ1XM46DW5j2rcvQufL0fbsxYWD8FvrWEnobzdBO3S+eputtivhdt3QHgvWZYIJKCtfEPxWfSyg3g71J9rFbrgdmoNmUJ+7P8JKQAbWR2+Kltc18xOWjIZWnhVR0Xds6txBJZs9qLeE1hZjdv3ApyPJ0E1pp+ha1AutbS3Qi7dqK/B2ShYmJAc1lNMj8aAMN+oR9wCRHQob8e2DUgWDKrohLnRhsRl/dfSuyieFmK9cVymANZiv49k+wQsaYSjZM1yWAcNDv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:35:53.0929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9355dd6-e280-42fd-6a0a-08de7fadca3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833

From: Manish Honap <mhonap@nvidia.com>

Before accessing CXL device memory after reset/power-on, the driver
must ensure media is ready. Not every CXL device implements the CXL
Memory Device register group (many Type-2 devices do not).
cxl_await_media_ready() reads cxlds->regs.memdev; calling it
on a Type-2 without that block can result in kernel panic.

This commit refactors the HDM range based check in a new function which
can be safely used for type-2 and type-3 devices. cxl_await_media_ready
still uses the same format of checking the HDM range and memory device
register status.

Co-developed-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/core/pci.c | 35 ++++++++++++++++++++++++++++++-----
 include/cxl/cxl.h      |  1 +
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 52ed0b4f5e78..2b7e4d73a6dd 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -142,16 +142,24 @@ static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
 	return 0;
 }
 
-/*
- * Wait up to @media_ready_timeout for the device to report memory
- * active.
+/**
+ * cxl_await_range_active - Wait for all HDM DVSEC memory ranges to be active
+ * @cxlds: CXL device state (DVSEC and HDM count must be valid)
+ *
+ * For each HDM decoder range reported in the CXL DVSEC capability, waits for
+ * the range to report MEM INFO VALID (up to 1s per range), then MEM ACTIVE
+ * (up to media_ready_timeout seconds per range, default 60s). Used by
+ * cxl_await_media_ready() and by callers that only need range readiness
+ * without checking the memory device status register.
+ *
+ * Return: 0 if all ranges become valid and active, -ETIMEDOUT if a timeout
+ * occurs, or a negative errno from config read on failure.
  */
-int cxl_await_media_ready(struct cxl_dev_state *cxlds)
+int cxl_await_range_active(struct cxl_dev_state *cxlds)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	int d = cxlds->cxl_dvsec;
 	int rc, i, hdm_count;
-	u64 md_status;
 	u16 cap;
 
 	rc = pci_read_config_word(pdev,
@@ -172,6 +180,23 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 			return rc;
 	}
 
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_await_range_active, "CXL");
+
+/*
+ * Wait up to @media_ready_timeout for the device to report memory
+ * active.
+ */
+int cxl_await_media_ready(struct cxl_dev_state *cxlds)
+{
+	u64 md_status;
+	int rc;
+
+	rc = cxl_await_range_active(cxlds);
+	if (rc)
+		return rc;
+
 	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
 	if (!CXLMDEV_READY(md_status))
 		return -EIO;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 27c006fa53c3..684603799fb1 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -323,5 +323,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
+int cxl_await_range_active(struct cxl_dev_state *cxlds);
 
 #endif /* __CXL_CXL_H__ */
-- 
2.25.1

