Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F096640B115
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184846; cv=fail; b=JBs2nJD74YdRBJD8MBywmeZ/0Shw3+0URpR5Uv+pU0BtEYlpOaMw4xwIF3INfgGlqIZK4cjh2zoy7giP9xlyNhW+iEvcBZHnGtHGF1VE5qBOzjKGWtWVIjeO263wOJADLLhoRQbXdaxss+nhfHG4kox1Ub90u47UTlGiN5pcGHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184846; c=relaxed/simple;
	bh=fWjqjKORCIEpZPrf/JS38eNazvZSsphpNQHpUwBGTvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhKJX3diDnRTGzfGWRhG78OVQ+2iiQ8rr0Z7mgqxxbO9079reqa+bQORLl/5Kp4V6Vn3HJJSm+cERIO1rBSV+3qm0m+/zZWMGwxC9WiSVDq1zRoOyWJ1csvbsAqPQ/WhKEDACijQ0XNt47icHxwEckrug4u0B8fuNHGixoonqqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nq21hzE8; arc=fail smtp.client-ip=40.107.208.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nq21hzE8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p32HTDhhtaVRMXls/BSRQldy6SxOkhZKs+m374TzNn2o0WchuctIAZ3ykSRk+QZOkiuW40ocQ/Ruh19sRkRTPEo0QybpJfcsSGwo5r7HmRFnrTOWwx4FdQAkIGGTg2hJ5bDOHcj1skPLeA4Ji69DXQmm544kJGmTpjX+/pfATOhSfzZ7CVq7W4+U6pPsaFZIeadX6y3CdICluBP+TvGH3IbzfROdsQLJFFNos2waXmUT/76ceLKt8dqy2iC7own4PsUvwWxZVK/7Cx/yijFZoI3DAJyB9ZyYMRyVBpZdalhgJnKcsHSfqPiOyl4HylJscg+FWFWwTuKLXySqkjev+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ir3swwxlHHTDiiTpFel8ktiTXu6Geh4ai/d8UV5k47Y=;
 b=BeN8GMZIiCr3EiKoYseeE03qSeh2M57Lza0jtewshrv6hMbqJAIp0qKF+ytdfOd/lC0LA6ek3DGilmVwJzmLawVqJaOIvg43ut5tT5mWJLSUK2T4fw2QZ6gw2BHqIB8UhJEJNVJo1HI48gL4mgBM5W0s/1Nm8DpIKfr/lsnun7N0mdLRyzN/OJwdwjHmndtM0jmCT4ysH5uN/UUkdEJSnk1EnmAPOe+701l0iQZfQol3yvstvGp3IYrn14p1dV3g1lfGBRA5YIlI9ztnmkOSQt8qJ7lgJapyjDpQEnG8zipJpRCiPCAQ0BNEZG77cp/fHHCwWUC6uDpXAUsP5Y7fsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ir3swwxlHHTDiiTpFel8ktiTXu6Geh4ai/d8UV5k47Y=;
 b=nq21hzE8dsMLLKEuWlw8UEMeCDnx7Mn1KC/xuY3Fjd0RWWccfJRcB76wO4uI7xMbI1JdER0MEmG+qsYCmq5X0bUA8R5XQJ3XpHKWouCWSznzbxSI3cZOdNn64syqaVorYCduyWDo4EUjlcyx2dHEh/TBM2FSFyRiZEzVHEuM9Ow=
Received: from DS7PR05CA0001.namprd05.prod.outlook.com (2603:10b6:5:3b9::6) by
 IA1PR12MB8221.namprd12.prod.outlook.com (2603:10b6:208:3f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 17:33:59 +0000
Received: from DS2PEPF000061C2.namprd02.prod.outlook.com
 (2603:10b6:5:3b9:cafe::1c) by DS7PR05CA0001.outlook.office365.com
 (2603:10b6:5:3b9::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Wed, 23
 Sep 2026 17:33:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C2.mail.protection.outlook.com (10.167.23.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 17:33:59 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 12:33:58 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>
CC: <linux-iommu@vger.kernel.org>, <benjamin.cheatham@amd.com>,
	<terry.bowman@amd.com>, <robert.richter@amd.com>
Subject: [PATCH 13/15] cxl/cache: Add snoop filter allocation
Date: Wed, 23 Sep 2026 12:33:40 -0500
Message-ID: <20260923173342.5584-14-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
References: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C2:EE_|IA1PR12MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: 51fd83db-f3df-413c-b00c-08df1998da01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5iPle+1KFeWw8Vdkd3EnlvjYGoshnZdnsHTRF0Zp5dqB3fYqFDRA5L3u/ImVJn23lKEKGRBwN30S/6+QNGcu/S+MLIAWRUjRtpAWyoo2Ra5zfTOnuVe1oLqUSgrxCdNzCs89OJToED6D3DfBSjgxlUA2E2EuAVvuIoCkMDNdxiPJvUMsFKWmfLHoDb0YLKummJiCwpjMp+zOre+qhEzBWq8+tuaQXUYwW4Msk1EGcUIWwdg/pKdjutBM8DDmO2iXMGUejmS83bl5XZMzBMMemGmNyNrirUNjCDqJsreNybfaQisY/Z+BugW95IEP1u1XL6m1W8TYGV7C+Ik0BzKK9qCMwehKKfN00LeQSWSvehA4PCbalkmO81ttK9Ny/JI8ZR5PdvH0ecxnraBVuBaDx0IsO0jNjNegtbUZKKjSvTqZEt1BtGEIMRNubjm6SFLWJcuHnQGnAoI487j+kQtdIHaEHPP1puUccj6VB/2tc+emurpQptPL0wLVNX36c12YD73Dz8fDJU8Wg0nSysMPUOki3u/wVdynMX0oSrVNJrDulf1tCE9JEAUUTajiNlErG2XCJyaqszqa8bMeuP9yd/atEdiPpglKJuiNvHM2+AuDNfRFsURXekbHOvMRo+qYojnNnLKaKhKRFfaBsJABOMiGU9R7kA4YhiBwPlr25FNinr+qG3JR2rSrVgbFvPw58/qp1z65MrAU8CTKB0u58Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wjSzcVPQrUPy1DMMQEuEwW6W3d0pq1SESTivAxdz0r4slHYP4dLbL5OVXafYfZgq0p8/l+izasXQw7Za5npMyxTuED78UUe2e6B9vSGehCfrE/TD7jAk83LSzpDkVvWn6Q9ELPSK11PpsOAxc89g9nsrk+80zLUkN79tqDlsx1CMr+Rr32jgEuUWuIAzDAOKhRu9u46hbMMQjJTTqhbqN0Jrj6l/bBacLsNu6Kb3yc00uM5QvDgtdSWg/hZKKx/5ctJMq3zWmllWo3UuhLFKR4ySiu7w5wlXp8atMOwrDIkZA6tF/r+eLnFv70II9cbY4WTemY0SvKIHFxtuZ+l1pDPbpihf6yZc84P9HYniA0dQefj0ySTBkVxBjXyNe2Tj0+1szW5f/mVZSQdpKnO7krYDVnj1UJl202T6R7HIQM6G5KiRkjZgb8l+7hCQQc/u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:33:59.2425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fd83db-f3df-413c-b00c-08df1998da01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221

Add snoop filter capacity allocation for CXL.cache devices. CXL.cache
devices are expected to allocate snoop filter capacity equal to the size
of the address range they will cache using CXL.cache before using the
protocol (i.e. before allocating DMA space).

Devices may also indicate whether a CXL snoop filter being full is a
failure condition using the @strict_snoop member of struct
cxl_cache_state in struct cxl_dev_state. If any allocations on a filter
are made with @strict_snoop enabled, any allocations afterwards fail if
the filter is full regardless of @strict_snoop's setting.

A full snoop filter may cause performance degradation or unpredictable
behavior depending on the host's snoop filter implementation.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cache.c       |  26 +++++++-
 drivers/cxl/core/cache.c  | 125 +++++++++++++++++++++++++++++++++++++-
 drivers/cxl/core/memdev.c |   1 +
 include/cxl/cxl.h         |  13 ++++
 4 files changed, 162 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
index 40d1e8330df7..b4574a76ac0b 100644
--- a/drivers/cxl/cache.c
+++ b/drivers/cxl/cache.c
@@ -179,6 +179,20 @@ struct cxl_cachedev *devm_cxl_add_cachedev(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_cachedev, "CXL");
 
+static int cxl_cachedev_find_snoop_gid(struct cxl_cachedev *cxlcd)
+{
+	struct cxl_dport *iter;
+
+	for (iter = cxlcd->endpoint->parent_dport;
+	     iter && !is_cxl_root(iter->port);
+	     iter = iter->port->parent_dport) {
+		if (iter->snoop != CXL_SNOOP_FILTER_NO_GROUP_ID)
+			return iter->snoop;
+	}
+
+	return -ENXIO;
+}
+
 static int cxl_cache_probe(struct device *dev)
 {
 	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
@@ -236,7 +250,17 @@ static int cxl_cache_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	return devm_add_action_or_reset(dev, deprogram_cache_id, cxlcd);
+	rc = devm_add_action_or_reset(dev, deprogram_cache_id, cxlcd);
+ 	if (rc)
+ 		return rc;
+
+	rc = cxl_cachedev_find_snoop_gid(cxlcd);
+	if (rc < 0)
+		return rc;
+
+	cxlcd->cxlds->cstate.gid = rc;
+
+ 	return 0;
 }
 
 static struct cxl_driver cxl_cache_driver = {
diff --git a/drivers/cxl/core/cache.c b/drivers/cxl/core/cache.c
index f07c49cfacec..429c997b2ada 100644
--- a/drivers/cxl/core/cache.c
+++ b/drivers/cxl/core/cache.c
@@ -571,17 +571,28 @@ void cxl_cachedev_deprogram_cache_id(struct cxl_cachedev *cxlcd)
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_cachedev_deprogram_cache_id, "cxl_cache");
 
+struct snoop_allocation {
+	struct cxl_cachedev *cxlcd;
+	bool strict;
+	u64 size;
+	int id;
+};
+
 /**
  * struct cxl_snoop_filter - CXL snoop filter instance for tracking CXL.cache
  * devices below a dport
  *
+ * @allocations: Allocations on this filter
  * @lock: Used for allocations
+ * @strict: Number of allocations from devices that disallow oversubscription
  * @avail: Available capacity left in the filter
  * @size: Size of the filter
  * @id: Group ID of the filter
  */
 struct cxl_snoop_filter {
+	struct xarray allocations;
 	struct mutex lock;
+	u32 strict;
 	u64 avail;
 	u64 size;
 	int id;
@@ -597,15 +608,37 @@ static struct cxl_snoop_filter *create_snoop_filter(u64 size, int id)
 
 	sf->id = id;
 	sf->size = sf->avail = size;
+	xa_init(&sf->allocations);
 	mutex_init(&sf->lock);
 
 	return sf;
 }
 
-static void destroy_snoop_filter(struct cxl_snoop_filter *sf)
+static void free_snoop_capacity(void *);
+
+static void __free_snoop_capacity(struct snoop_allocation *alloc)
 {
-	lockdep_assert_held_write(&snoop_rwsem);
+	struct cxl_snoop_filter *sf;
+
+	sf = xa_load(&snoop_filters, alloc->id);
+	if (sf) {
+		scoped_guard(mutex, &sf->lock) {
+			sf->avail += alloc->size;
+
+			if (alloc->strict)
+				sf->strict--;
+
+			xa_erase(&sf->allocations, (unsigned long)alloc);
+		}
+	}
 
+	put_device(&alloc->cxlcd->dev);
+	kfree(alloc);
+}
+
+static void destroy_snoop_filter(struct cxl_snoop_filter *sf)
+{
+	xa_destroy(&sf->allocations);
 	mutex_destroy(&sf->lock);
 	kfree(sf);
 }
@@ -638,6 +671,94 @@ static struct cxl_snoop_filter *find_or_add_snoop_filter(u64 size, int id)
 	return sf;
 }
 
+static struct snoop_allocation *
+snoop_alloc_capacity(struct cxl_snoop_filter *sf, struct cxl_cachedev *cxlcd,
+		     u64 size)
+{
+	struct cxl_cache_state *cstate = &cxlcd->cxlds->cstate;
+	struct snoop_allocation *alloc;
+	int rc;
+
+	guard(mutex)(&sf->lock);
+	if (sf->avail < size) {
+		/*
+		 * Either this device or a device already using the filter
+		 * can't use an oversubscribed filter
+		 */
+		if (cstate->strict_snoop || sf->strict > 0)
+			return ERR_PTR(-ENOSPC);
+
+		size = sf->avail;
+	}
+
+	alloc = kmalloc_obj(*alloc);
+	if (!alloc)
+		return ERR_PTR(-ENOMEM);
+
+	*alloc = (struct snoop_allocation) {
+		.cxlcd = cxlcd,
+		.size = size,
+		.strict = cstate->strict_snoop,
+		.id = sf->id,
+	};
+
+	rc = xa_insert(&sf->allocations, (unsigned long)alloc, alloc,
+		       GFP_KERNEL);
+	if (rc) {
+		kfree(alloc);
+		return ERR_PTR(rc);
+	}
+
+	if (cstate->strict_snoop)
+		sf->strict++;
+
+	sf->avail -= size;
+	return alloc;
+}
+
+static void free_snoop_capacity(void *alloc)
+{
+	guard(rwsem_read)(&snoop_rwsem);
+	__free_snoop_capacity(alloc);
+}
+
+/**
+ * devm_cxl_cachedev_alloc_snoop_capacity - Allocate space in the system's snoop
+ * filter for a given CXL.cache device
+ * @cxlcd: Cache device to allocate capacity for
+ * @size: Size of allocation
+ *
+ * NOTE: CXL accelerator drivers are expected to call this function before
+ * using CXL.cache to access host memory. Failure to do so may result in
+ * unpredictable or undesirable behavior depending on the host's snoop filter
+ * implementation.
+ */
+int devm_cxl_cachedev_alloc_snoop_capacity(struct cxl_cachedev *cxlcd, u64 size)
+{
+	struct cxl_cache_state *cstate = &cxlcd->cxlds->cstate;
+	struct snoop_allocation *alloc;
+	struct cxl_snoop_filter *sf;
+
+	if (cstate->gid < 0)
+		return -EINVAL;
+
+	scoped_guard(rwsem_read, &snoop_rwsem) {
+		sf = xa_load(&snoop_filters, cstate->gid);
+		if (!sf)
+			return -ENODEV;
+
+		alloc = snoop_alloc_capacity(sf, cxlcd, size);
+		if (IS_ERR_OR_NULL(alloc))
+			return !alloc ? -ENOMEM : PTR_ERR(alloc);
+
+		get_device(&cxlcd->dev);
+	}
+
+	return devm_add_action_or_reset(&cxlcd->dev, free_snoop_capacity,
+					alloc);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_cachedev_alloc_snoop_capacity, "CXL");
+
 int cxl_dport_probe_snoop_filter(struct cxl_dport *dport)
 {
 	struct cxl_snoop_filter *sf;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index b3419df586b9..e169301bbfcf 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -751,6 +751,7 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 	cxlds->cxl_dvsec = dvsec;
 	cxlds->reg_map.host = dev;
 	cxlds->reg_map.resource = CXL_RESOURCE_NONE;
+	cxlds->cstate.gid = CXL_SNOOP_FILTER_NO_GROUP_ID;
 
 	if (has_mbox)
 		cxlds->cxl_mbox.host = dev;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 22b9c8c9c06e..5d550dd70870 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -165,6 +165,8 @@ struct cxl_dpa_partition {
  * struct cxl_cache_state - CXL cache device state for use by external drivers
  * @size: Size of device's cache
  * @unit: Unit of device's cache in bytes
+ * @strict_snoop: Whether a full snoop filter should fail allocations
+ * @gid: Group ID of the snoop filter this device belongs to
  */
 struct cxl_cache_state {
 	/* Public for endpoint drivers */
@@ -175,6 +177,12 @@ struct cxl_cache_state {
 	 */
 	u64 size;
 	u64 unit;
+
+	/* Should be set by endpoint drivers */
+	bool strict_snoop;
+
+	/* Private for endpoint drivers */
+	int gid;
 };
 
 /**
@@ -264,9 +272,14 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
 
 #if IS_ENABLED(CONFIG_CXL_CACHE)
 struct cxl_cachedev *devm_cxl_add_cachedev(struct cxl_dev_state *cxlds);
+int devm_cxl_cachedev_alloc_snoop_capacity(struct cxl_cachedev *cxlcd,
+					   u64 size);
 #else
 static inline struct cxl_cachedev *
 devm_cxl_add_cachedev(struct cxl_dev_state *cxlds)
 { return ERR_PTR(-ENXIO); }
+static inline int
+devm_cxl_cachedev_alloc_snoop_capacity(struct cxl_cachedev *cxlcd, u64 size)
+{ return -ENXIO; }
 #endif /* CONFIG_CXL_CACHE */
 #endif /* __CXL_CXL_H__ */
-- 
2.53.0

