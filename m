Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013021.outbound.protection.outlook.com [40.107.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC3D42AA6
	for <linux-cxl@vger.kernel.org>; Thu, 23 Apr 2026 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965138; cv=fail; b=gs4npd8HQd+1+M5oWRblnLm6cEPfyLrtMtM7OadMZxQMk7Pe2TxomQPbSyqNcc5uENrTS1cp7Zh5ZOAXigI6O10GQweDTC3F+IJ6nt4a3zF2fxJknrU6b1DnSKL6XOuMeZwMFVa4MLQbiojBD1e8gzKs2+Mvu2QMs8GTHxGBsgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965138; c=relaxed/simple;
	bh=ryrFwo3MjIgHWW6BQjyARKJAyuD/OQNkd0G7l9PQqJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzwalDjiR3mHtXZAUqX6akLWSmaz0XMf0ydD6OxeSRHtfQYUXj4pn7kEFgfWTjx3N9D+UBRKm82cAvVJyuIP5mvtGa4DQcX6dSXNZeLrMJUfhRxdKuRYyUd4DF0i647kmg7tgivCq7VjPWWWU+XT9/QqV+kelBq+DZXnue3v+IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z0mlHqVa; arc=fail smtp.client-ip=40.107.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z0mlHqVa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3o7X65sWMbdnyLYzukAb1asRMOxqrH8bsidV2zVv/EfMWmAZMsjh22OB1WBz1VXMZq7NvM27C205jKrqr6bUXal/vKtx7qN/JhKfg9wNaKIvGRgvKlnMZCzX0ohm8HexkY64vanOLnjgocGmyz3T7n8jTy6DZur8njRzKxpHofODWOqHvvi91+1sV0SKUjTRnxIibov8eThFdqTW3U5Mx0YiMr5n4Q2hV0livtUov2YKmILConqvibBV8hPY6M28FWaI5dFSiSyslgRNPSCe5O2kZ9Hywxo/QsuL702UszfAU5sKaCeWsjdVIuTNdugZsrE4+JnLyRdmalBhuFB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEdC+uBaOQ46F1rkDZm8CLAU3B7EJsh+4FIilNmRMfc=;
 b=UDCKxkBdPRbybByRQBb7TO8SwckB5uBVxjpQqn+TmzAFbtip0CSV88TTy1ADLD24/k8MkUiwL8xhtaSM7YEPOsA6DN0S0+2333m8Fi6k1FRmc2noaMEYzAD/+pP80xkXWSZvI+/N1XkQ8J/6+yfpXDNVbgQRStdPXoYaF94ogkIZzchItMeemKQQThJiLcs0EUpCH3lUl5Hn+aI3M0DDj+SkPL9uCFmDmztuZfVrlBXHkn8fLJtV5j+E6g006UjGl4ya/jv/KMM2gZJpICLU0EwWP3P4azyqGre2QpW45OnbBP1DHXnRxr0LhjYP/JKjaOr9IbjItCL+3UQ2JQ3tNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEdC+uBaOQ46F1rkDZm8CLAU3B7EJsh+4FIilNmRMfc=;
 b=z0mlHqVaoeaisH5vn+sZWkhLM8tLI5xTJM4DHpSYHUgNdplVPovKCidqG2bOrQp5w/pNG0Vr4C2ePvYPWXENiAnTBPCY7gL0wDis4qi8gUbvw2jIHJJeqAGC8J4hq5zpx6AF+vBwCerrIsynx4OwmZlJenATIzMHpKpJb/KVGGc=
Received: from BN0PR03CA0040.namprd03.prod.outlook.com (2603:10b6:408:e7::15)
 by MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Thu, 23 Apr
 2026 17:25:30 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::fb) by BN0PR03CA0040.outlook.office365.com
 (2603:10b6:408:e7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Thu,
 23 Apr 2026 17:25:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 17:25:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Apr
 2026 12:25:29 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 23 Apr 2026 12:25:28 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Ben Cheatham <benjamin.cheatham@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v26 3/8] cxl/sfc: Initialize dpa without a mailbox
Date: Thu, 23 Apr 2026 19:05:23 +0100
Message-ID: <20260423180528.17166-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|MN0PR12MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e2c415-7118-472b-bde6-08dea15d5181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	JWgyNJXdLUMvPwoZTtKbH1N2omAoiXDhGfgFbmmMnxsNMGxVWAtlKeVWIPnoI1L4mSZToMhPFK2FNZV+18deFtPM/aHIFW9kNJLodLS5/mBdrUUfdvyFgqSQntxQCBaNUZWpHKNw684iSQ5lRvauxnnhQjDz+Oz7HHb0gkdGhHvn5WuoKXTxYIYjwE4gRxydejzfgcFqex2AioRpyKDkqLLOBrdSKQr4AAglD3r5EZhUx/PKADM6aQD284Yama992TQKyyYWT2Sh0PYKONc2go8D/wvCrIPL+j4ifbWYMh7Atp7yMoKweas5jZAg8uDZgHLkb3pIj3aSBVpHPkn889/rO3vQ8FMm7jB/bnACt/Xp+gbIUdG1u18l1XA1w/67wCFVeGPLBQXvNY8EWdHj2vfmf7+ToZF22tDAd15fORnMGZQhrRRSmLJA0UV53lgaUafTFxOXXx98P/Ri7pcjfzadnkfTXTVD88E2Wcn40KSpi5xHw1fPNO1DiHCdLrPZk4P88sV4xPuBzTuHpPTuRWJY6RibBl/PdDdfjAltRjJuMjQ5Vc/WWxucgfptjhD3fEl6+9VHwjkYEK9EScgBrHC5xew2OwpkmvP0hRlfKNJM8NKy1jgxHiM+yvNHI4oRRxr0VadQLzhxu+7s+37zxsBocEEJ3oKuQmcfdahrZGge50j9GB0EhFYnb5OLFVwYgoFW0Ks3QIuL9AoyuqYnXrUJFmzFHV28ait+B2vhYcNvJZcT1ybpnjAREJxZhtZ2pjMT5A7Z3JAA5x4TxG0UkQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zuIOKTM4vm16cOjv8JpIXBcoLWc+jAywobhpw2fRstjKWLdXybLnWmRU6GF1YYUOy2fpSftLp5+uXga4P+bxjpXWAd6ljjjyccDhi2Jxwk5SpzrxZevnVuV2oXQ3UIfQDw204UldctMkD+AHfy+4dy4JiK7obEyy4Cp7OW+fA+Et7BiS4mjTF9sdFkOcWsLwsPPWYajbz5yLbnrXSAwwgJeaa2FbYOhjWn0UjmeXIhYTrl/xwjTiD1fiY1XSPnx36W/YYVgLNfNZp3HHcz1/d741kmcCoYIFctQnux6g3Ci4v7W4V18y69rFAhXG0xF9qw9DkSK1kWQ6+dTL9UCnKF0e40xEz6m5S/qO0eZvMkq1YlbZpkPNzZ0NjuRBxagTUAqRq8WoTA3dNOIHscspdQz61vuyRu7bLAIFUvCPP2pQ7MNvwbXs2beYTUg5S16+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 17:25:30.4205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e2c415-7118-472b-bde6-08dea15d5181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6004

From: Alejandro Lucero <alucerop@amd.com>

Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
memdev state params which end up being used for DPA initialization.

Allow a Type2 driver to initialize DPA simply by giving the size of its
volatile hardware partition.

Move related functions to memdev.

Add sfc driver as the client.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/core.h            |  2 +
 drivers/cxl/core/mbox.c            | 51 +----------------------
 drivers/cxl/core/memdev.c          | 66 ++++++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.c |  5 +++
 include/cxl/cxl.h                  |  2 +
 5 files changed, 76 insertions(+), 50 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 82ca3a476708..70a1da02ba9c 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -99,6 +99,8 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode);
+struct cxl_memdev_state;
+int cxl_mem_get_partition_info(struct cxl_memdev_state *mds);
 int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 7c6c5b7450a5..97b1e61ad018 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1152,7 +1152,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
  *
  * See CXL @8.2.9.5.2.1 Get Partition Info
  */
-static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
+int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_get_partition_info pi;
@@ -1308,55 +1308,6 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	return -EBUSY;
 }
 
-static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
-{
-	int i = info->nr_partitions;
-
-	if (size == 0)
-		return;
-
-	info->part[i].range = (struct range) {
-		.start = start,
-		.end = start + size - 1,
-	};
-	info->part[i].mode = mode;
-	info->nr_partitions++;
-}
-
-int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
-{
-	struct cxl_dev_state *cxlds = &mds->cxlds;
-	struct device *dev = cxlds->dev;
-	int rc;
-
-	if (!cxlds->media_ready) {
-		info->size = 0;
-		return 0;
-	}
-
-	info->size = mds->total_bytes;
-
-	if (mds->partition_align_bytes == 0) {
-		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
-		add_part(info, mds->volatile_only_bytes,
-			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
-		return 0;
-	}
-
-	rc = cxl_mem_get_partition_info(mds);
-	if (rc) {
-		dev_err(dev, "Failed to query partition information\n");
-		return rc;
-	}
-
-	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
-	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
-		 CXL_PARTMODE_PMEM);
-
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
-
 int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 80e65690eb77..b8ff1c07e528 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -585,6 +585,72 @@ bool is_cxl_memdev(const struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
 
+static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
+{
+	int i = info->nr_partitions;
+
+	if (size == 0)
+		return;
+
+	info->part[i].range = (struct range) {
+		.start = start,
+		.end = start + size - 1,
+	};
+	info->part[i].mode = mode;
+	info->nr_partitions++;
+}
+
+int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
+{
+	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct device *dev = cxlds->dev;
+	int rc;
+
+	if (!cxlds->media_ready) {
+		info->size = 0;
+		return 0;
+	}
+
+	info->size = mds->total_bytes;
+
+	if (mds->partition_align_bytes == 0) {
+		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
+		add_part(info, mds->volatile_only_bytes,
+			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
+		return 0;
+	}
+
+	rc = cxl_mem_get_partition_info(mds);
+	if (rc) {
+		dev_err(dev, "Failed to query partition information\n");
+		return rc;
+	}
+
+	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
+	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
+		 CXL_PARTMODE_PMEM);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
+
+/**
+ * cxl_set_capacity: initialize dpa by a driver without a mailbox.
+ *
+ * @cxlds: pointer to cxl_dev_state
+ * @capacity: device volatile memory size
+ */
+int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
+{
+	struct cxl_dpa_info range_info = {
+		.size = capacity,
+	};
+
+	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM);
+	return cxl_dpa_setup(cxlds, &range_info);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_capacity, "CXL");
+
 /**
  * set_exclusive_cxl_commands() - atomically disable user cxl commands
  * @mds: The device state to operate on
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index f88c2b3fbb2c..4d55c08cf2a1 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -70,6 +70,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	 */
 	cxl->cxlds.media_ready = true;
 
+	if (cxl_set_capacity(&cxl->cxlds, EFX_CTPIO_BUFFER_SIZE)) {
+		pci_err(pci_dev, "dpa capacity setup failed\n");
+		return -ENODEV;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index fa7269154620..1346771edc4e 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -223,4 +223,6 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
 						      sizeof(drv_struct), mbox);	\
 	})
+
+int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1

