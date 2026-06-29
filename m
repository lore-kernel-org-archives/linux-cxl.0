Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C45F37C0F8
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754873; cv=fail; b=TWFEQ9puyECd8fSRboFcqLcZD9yAgXmkm7tZU3TkEeMu3EmF5uJsaEs3ZNFgXjTern+Onn7HMphqh3Wy7/cmLV8RTU3vqYFasoQaZFxa4ILHKO1pHMITwpbArAUXpkax72v1Gt3XXNELkOgHPq0qosmH70OyFW0FFPnYtnx2eHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754873; c=relaxed/simple;
	bh=a0g4jjNVh4lvaZYOYuH8gB76MITytFthVFrDpOpVIVk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpc0CFarLL0pvZIOcoFIYpCwkREYvXW3W0ep01gAl/fwbizfWS6E+slQ1Husrqm89J1ijA2Kkuo4FekJ4mNu66d3v3mk5u5ExNqapMxc5SQ8RzEosxI0Rt3i/zUBfXB29JICm0y3mKCoyUJmFWlrB8P9a5mr4CMTqcE8yGRsn64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kuEP8cKE; arc=fail smtp.client-ip=52.101.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kuEP8cKE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cp+EIjPrPNGP9DIYiBrEOYLtaU0iENicQdLliuKE1r5dpig11HGEd2xApzJxpMp8ZDMs34urfSNpQZc3fLaxP9mirG9etRjtbWunREBRvYXEJzQgvqrHwpKl7K70QyN5lrvEh6SZFR0CResgdER+SjVHgMWAVdfLaU+E+uBKH0SFIvSKH6xtHGlB/tTUXqaq5zbmjA9cDfYZ1vHVkSwQouRokb7oi/DkbcLW43qMvii/F/bSyPqDggZhM8vkUMrCISsHHsihQdnM6L9+M2OHPaRSrE/xdVbJjC4eQKWQy+zqBeZTFXJnd8f8sjOAWNpzQBdowbMk3nmguX86fxJQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Inq3bILZWFMkPpHo8BwHyYcid4nkNzr+RvVCuowXOy8=;
 b=eQ1Hoffp8ilsMdWzTBqUbIYGrLIw7TSFNjQD5xsx5Yf0/ylarsFKnqUyJRixjucaVqdKYX80+EpOwowkOf3REww2Y0PaPpDDVamqMNKXzb9wW6KgohHX/VA7yaQAchdtVwwJfUTmnxOZZAz1QNvo9BvmEEnLa9r4PVlRlWOf7NbLQyEyE8mmYA4f2gLUlQpq+VPJlxoGiZxXs7sMCnG1vIftXFDlob9b8L173n6jvZTaug3jFESBW9ZJPiqVm08DbeHRFoqrJYPFGeep6wVVW5/w2GwydBlTetTIRnOYjKnPX30jVpKY7D+zHjOLsEfqTEuX3cPHTXXovzSfkBczyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Inq3bILZWFMkPpHo8BwHyYcid4nkNzr+RvVCuowXOy8=;
 b=kuEP8cKEO9RFtdL4ltNPjFgOpqSngOceAO/t1gD3BjADUpZyO5+nbfzGGB5Jyl951Moc7iWNM4roJewlB1UsNgZbUcTC5eF7L4z6K0CI/vpmmZ+raiv2kMIHd0Lr0g8q4Edfg7MeD7UMCsg8LH43/O0OsekbsCIMC8dNXtKVDO4=
Received: from CYXPR03CA0039.namprd03.prod.outlook.com (2603:10b6:930:d2::24)
 by SJ2PR12MB8883.namprd12.prod.outlook.com (2603:10b6:a03:538::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 17:41:06 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:930:d2:cafe::3d) by CYXPR03CA0039.outlook.office365.com
 (2603:10b6:930:d2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 17:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 17:41:05 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 12:41:05 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Mon, 29 Jun 2026 12:41:04 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Ben Cheatham <benjamin.cheatham@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Edward Cree
	<ecree.xilinx@gmail.com>
Subject: [PATCH v30 2/2] cxl: Support dpa without a mailbox
Date: Mon, 29 Jun 2026 19:37:27 +0100
Message-ID: <20260629183727.51502-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629183727.51502-1-alejandro.lucero-palau@amd.com>
References: <20260629183727.51502-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|SJ2PR12MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f4c696-154b-4dc6-5ff8-08ded6059881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|18002099003|22082099003|6133799003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	bobnrArwT1gPabCaTI8ibU7dWTV/om3sbfIC8wesuXUZrOZKVPhrTc+Y1WuhRd7dshIjZ/78guJc0NVeyV7wzHUsw2+JxoyuFaN8ykgpiZO4d9WH921DJuKvfA8wsqVequD93y9n7LmLw1iAkq70DIyDIrOb8NAYHjjNM8f6txAV3sGXAqINB26HtF9DkO8519WXScZ6ou4z4RopGOvKlWAIN+LFMJygxQTQS1NdAd7oCzbUeIekQS8eFENQtKoojGZGre73e8yf/zPOv4/LYxWivxwJMycW8FA0OfMoOiZFv6ORug+jVEDO1fEPzEwVfjihALJ9+yiOf81mioJ35xYBvl3bCTwH9tAPATfc1gGjRQ77Ap5AwcNUpElzo5JaWPlk0xPGgVhoTNZxifQbjZ7Ff/yw7/uHOMgkYYqD0B2CixDKrt2nyeqKvn5HtgGA4EPb8C5YUdiajJ0FiPla8uHO+5ItfNpA/Ym/wxXdwkBz+8pjazqJleXAm6jr/E58cGR7iT1ACTTwfO4JXJhFw/FzbngSqSSLBTbl5Q+91aRMEaYYsLV+y3UIwKyitaah/QHI9w1xIvLfZGTPfTbJKBWX9N4WHXJHnnLy5chIKxCuu7NBSMV6R3EvB2kI+wYexnptjBZHvLemxyEv2Zol/7vLau8vI+GRQeFdQMn50Suq8FZ7FPdejef2QLKiEbRDqXgoK7qYE9aSGC6jZV2i/A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YxqKVqppD8aivUdwCDSnxERY63xIpw9fGbTOZBv+1t5KheFGQo1vl7m6k6XGuPh2hxwQon9kWC9rk/sZLzsaz2JB6EHlz8bOITbOi8Gn3W+CpR7nIPhYv9+TU5i53Cy4oJjI5/w7Kc+gxWUYoS4KGoZsiPZt3xe3TJqsqjwydJPaIbsTmV9rI/WwyySNvdeLLBAOHg7aNrCq/RDOtZAz0Zwxh4f2H0A6GTk18U9DiRlYRUVylRP5EHmdDa4jBNn7gRCM7iarH1QYnB8WF8/Q2GGZiYeF0MT+FWBSYEtrcYy+i5cv0kQs0K9k2El9aVFcXhNOtx3LagvNGToCAB6DlUk7nT5FIPItkxlQnSkEjYQaaRhFqy5CaEMvN2jmJjR7hW8DH9Ys32LstWBckLg33bWgxF8BueElDywguQOn0FaxDLRP56UsjeZbfY3GYRu1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 17:41:05.4431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f4c696-154b-4dc6-5ff8-08ded6059881
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8883

From: Alejandro Lucero <alucerop@amd.com>

Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
memdev state params which end up being used for DPA initialization.

Allow a Type2 driver to initialize DPA simply by giving the size of its
volatile hardware partition.

Move related functions to memdev.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/cxl/core/core.h   |  2 ++
 drivers/cxl/core/mbox.c   | 51 +----------------------------
 drivers/cxl/core/memdev.c | 67 +++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h         |  2 ++
 4 files changed, 72 insertions(+), 50 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 07555ae63859..f7cebb026552 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -101,6 +101,8 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
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
index 33a3d2e7b13a..2e457b1ebc7d 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -594,6 +594,73 @@ bool is_cxl_memdev(const struct device *dev)
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
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 016c74fb747c..802b143de83d 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -226,4 +226,6 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 
 struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
 				      struct range *range);
+
+int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1

