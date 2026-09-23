Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010049.outbound.protection.outlook.com [52.101.193.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5853E834D
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184848; cv=fail; b=AlKG6zvlkqgdoZ4U+okY+HPe5eij/vCvHBxQgA8OlrMaL+sVnvYV+gHIJS5Q8Ffa8r+eOv01C3fmzKXk1/XvFs5mu4+6rwAXxnZnWB1PKxoDsMdEX7tXyV87jQn3F0ufZr+KJuvoPC+SyJ0apukDv7LzloLJ+7hfSlyUDV+DLR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184848; c=relaxed/simple;
	bh=cxd+hlJxfss1Km0uEHcMfks88WA11FjekY6WJxxdeZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8xLRWSo8kzSLf7b/eKCYkHMZ9LZGOMJ7lQ9VVfDguWxryYfGb+zcWG/XKovuG8ghRL66kSYwTzReotg1yCUOE8teXk1ieHRck4tLaSzphMUPAyjMOGH27J+Q7gJXa+Kwm+6RF7PR4q3clN9X5x6wXpzwKQ46k23iY/pJ2zi96A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ywG/SuYE; arc=fail smtp.client-ip=52.101.193.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ywG/SuYE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIkPZcygmFv9PFkfLtFrL7Rujdx3XBWTis9KgDzXTeIhYQy/pRcKY3SpLEbZJrYtAY2dF95V3szKpBE305fSFZQHx7l0FcTYwJOTEcU+LevTCTJ14izpfIXGB027RzlgeVchBz3Qn9+oFKE705QfQbNCTQsP8qd3XU4PnJnc3ZpqWUteUcjDa12lPzILsb68wnBnlXd649lHPzc98Uv3k4kx70ii5yupZzUt1IyGWSp/brkEanJuNhj0o0ndlhzkZ+Rfl66sriX+aDYVRLGNfUNKw58c5iUbdWCT0keneD7lGkWgdw3hE+X7yTWOz2lTd8o2LagMC6a0h3zs8g70cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWDzcDAFLdLwgP67jr9rYTLwKODJ+bMIF5VYDoCbq0o=;
 b=Y6i62319bZQDr+uwnVHXaMWRzLDBIKEE4Bx7TsaJIgedymFzUzC46jZJGdpEn5n67vFhUf9Kfw9Q7j5ipz6OkabkGYHM+HlLPtyrQwc8szFaNHXzUfJk14s6jAm7A3HHDzUu3irLuNN51z+D+QFpdIBi+wkIprexUFqUDuKd1e+xSZhnwHFZO9BW2LkUdoXAAqStWryf4moDdAho6MDnwTqp6O48H0T1IgusoNLxlVeV5ZGkgqF5INnDLtXNu2pMtpb0dc+YlSV95zifQXTFNFjAA90D7YA6q5idmcgr/iMzPbT5e26S1F4VIciy8xVprjx4t6ffz6frpN5PO1O4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWDzcDAFLdLwgP67jr9rYTLwKODJ+bMIF5VYDoCbq0o=;
 b=ywG/SuYEo1TNO4Cgy1VdETktT4aVzyIPFUav/3PPzcS1+pHJYvn6ahABGaLcXpewAKNLKDWwbqxwspFFct391d25Nt5AW5cQ7cGJmlAkty0MrWvYaQK8rH1yCHVW2hWm9Oirh+ZuXYm+Fhn1DeDErcqBxoZ6hfOa45axGZ7hwQ4=
Received: from CH2PR19CA0009.namprd19.prod.outlook.com (2603:10b6:610:4d::19)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 17:33:58 +0000
Received: from DS2PEPF000061C7.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::50) by CH2PR19CA0009.outlook.office365.com
 (2603:10b6:610:4d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 17:33:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C7.mail.protection.outlook.com (10.167.23.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 17:33:58 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 12:33:57 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>
CC: <linux-iommu@vger.kernel.org>, <benjamin.cheatham@amd.com>,
	<terry.bowman@amd.com>, <robert.richter@amd.com>
Subject: [PATCH 12/15] cxl/cache: Add snoop filter creation and set up
Date: Wed, 23 Sep 2026 12:33:39 -0500
Message-ID: <20260923173342.5584-13-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C7:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: ef19678b-3c60-4f71-245f-08df1998d983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|11063799006|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	IKQi36jl6rznsGp3z1CgEFgFq9yky5Luk1C8WMF27qjmYL9s7LavxigpWbBWDo+q4hoeSdxddM9/VhxR1qsGNEt1b/FRyoJhBRYUZ1vDIyyK2Occs97dYpo6vJilwHuDiU1bf4m/GsMm0PqjZ/qBrCTczrT8R9+keqF7VBOaEvHksxxHR/pzdG/KOlz8WUTaI/y5IXLlvxgTmnagAMJ67+2q5i4BQUPzF3JnlkNdY8pHvHbQxpS0xcgfGdU9azf4YWH2Gfh4ittSeOZRkIA2psvNTb9iKq6TnukM3HpjhDZNfYpoRebKuGcun4udDvN06LqnTn96uOqSbaPSAnWhQnN33ER5lANroL9esrur6VLkC17gT8XcQIP4LJ2G5JJWE8A+o579OMEUyGvCWgs10b47HolRcMg29Q6YQubw3z3PnawVEgW0nRVVA+FC7IFrLXLEl5VrGpuhIuzuBn6u5CH5qEWbHz6Pa7UptFkwEoSWNQQbYOtecwRZ6xHpu8q/JkgyJwd6Tp6R3ON7mPCILF87olvJ+Heb6mZw37GC+JPVzG87J/gfk2VO2rar89m3HKnP2XlX7UBAV2fQN2q+FTiAiA7rK4/GJTHwBeFjj+viLliKDaIWPCtk/do6EYhEbrh+eoBJyk7c9EXv+oRIWPLFlTgvFsZC6Bp0yBlBQ6od8VebZPjKAMu9UZCDZqdw7V0+LWwdh2cge40qFHrbEg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wf4Vb/W06NwRPbZLi8V7b1A3bjPcF5ybFgokDT0xRpxH9fW+aLHQjiz0eWHpM23sfzzWCEwZabwHEEdoCAB2wxM848n3nmQ0GiLGbtYN/dGJTGwXAlyIybSa9weDx4UP33fB56VQZkqjY/aYTbAp7eGLjlFSBA/XnZNgnHFX+pNxCgLWaR//6S59g7dhHw/qCeeQaAdjGBG1KofXv+8LnfLK2Uu2i4HIKd5ljScOG1NKBgJvzoy/TniHtIru15Mm9pZuxgqJ5ojSYOgU/IIsQNnxwmzl9xf04AkxDN0FWVobM5ERjvgMQTJzr9YVt5EB898HZ3E3tYpej3d3tfXer/3cwHMfEsPlEn7jCacwNpWu0DhbsygW0t//aqq6ofR7g4HqYWQcv24gAVlKL2SXGaOwRNpinsRl06TzTmwlqbSNsf84m138Nd3POXuPT+D2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:33:58.4474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef19678b-3c60-4f71-245f-08df1998d983
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385

The CXL Snoop Filter capability (CXL 4.0 8.2.4.23) is used by the host
to track CXL.cache device transactions. CXL-enabled PCIe root ports
belong to one CXL snoop filter, indicated by the root port's group id
programmed by firmware. There may be multiple groups and multiple snoop
filters in a system.

Add the capability to track the system's snoop filters to the CXL core
and point dports to these filters as part of probe. Allocation of snoop
filter capacity will come in a later commit.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/cache.c | 119 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/core.h  |   7 +++
 drivers/cxl/core/port.c  |   3 +
 drivers/cxl/core/regs.c  |   7 +++
 drivers/cxl/cxl.h        |  16 +++++-
 drivers/cxl/port.c       |  10 ++++
 include/cxl/cxl.h        |   6 +-
 7 files changed, 166 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/cache.c b/drivers/cxl/core/cache.c
index 7810772326e9..f07c49cfacec 100644
--- a/drivers/cxl/core/cache.c
+++ b/drivers/cxl/core/cache.c
@@ -6,10 +6,14 @@
 #include <cxlcache.h>
 
 #include "cxlpci.h"
+#include "core.h"
 
 #define CXL_CACHE_ID_COMMIT_MAXTMO_US (5 * USEC_PER_SEC)
 #define CACHE_DECODER_MAX_CACHE_ID (15)
 
+static DEFINE_XARRAY(snoop_filters);
+static DECLARE_RWSEM(snoop_rwsem);
+
 int cxl_port_map_cache_id_rt(struct cxl_port *port)
 {
 	struct cxl_register_map *map = &port->reg_map;
@@ -566,3 +570,118 @@ void cxl_cachedev_deprogram_cache_id(struct cxl_cachedev *cxlcd)
 	__deprogram_cache_id(cxlcd, &root->port);
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_cachedev_deprogram_cache_id, "cxl_cache");
+
+/**
+ * struct cxl_snoop_filter - CXL snoop filter instance for tracking CXL.cache
+ * devices below a dport
+ *
+ * @lock: Used for allocations
+ * @avail: Available capacity left in the filter
+ * @size: Size of the filter
+ * @id: Group ID of the filter
+ */
+struct cxl_snoop_filter {
+	struct mutex lock;
+	u64 avail;
+	u64 size;
+	int id;
+};
+
+static struct cxl_snoop_filter *create_snoop_filter(u64 size, int id)
+{
+	struct cxl_snoop_filter *sf;
+
+	sf = kzalloc_obj(*sf, GFP_KERNEL);
+	if (!sf)
+		return ERR_PTR(-ENOMEM);
+
+	sf->id = id;
+	sf->size = sf->avail = size;
+	mutex_init(&sf->lock);
+
+	return sf;
+}
+
+static void destroy_snoop_filter(struct cxl_snoop_filter *sf)
+{
+	lockdep_assert_held_write(&snoop_rwsem);
+
+	mutex_destroy(&sf->lock);
+	kfree(sf);
+}
+
+static struct cxl_snoop_filter *find_or_add_snoop_filter(u64 size, int id)
+{
+	struct cxl_snoop_filter *sf;
+	int rc;
+
+	guard(rwsem_write)(&snoop_rwsem);
+	sf = xa_load(&snoop_filters, id);
+	if (sf) {
+		if (sf->size != size)
+			pr_warn("Mismatched snoop filter (gid: %d) size: found %llu, expected %llu",
+				id, sf->size, size);
+
+		return sf;
+	}
+
+	sf = create_snoop_filter(size, id);
+	if (IS_ERR_OR_NULL(sf))
+		return sf;
+
+	rc = xa_insert(&snoop_filters, id, sf, GFP_KERNEL);
+	if (rc) {
+		destroy_snoop_filter(sf);
+		return ERR_PTR(rc);
+	}
+
+	return sf;
+}
+
+int cxl_dport_probe_snoop_filter(struct cxl_dport *dport)
+{
+	struct cxl_snoop_filter *sf;
+	u32 group, size;
+	int id, rc;
+
+	if (!dport->reg_map.component_map.snoop.valid) {
+		dev_dbg(dport->dport_dev, "missing snoop filter capability\n");
+		return 0;
+	}
+
+	rc = cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_SNOOP));
+	if (rc)
+		return rc;
+
+	group = readl(dport->regs.snoop + CXL_SNOOP_FILTER_GROUP_ID_OFFSET);
+	id = FIELD_GET(CXL_SNOOP_FILTER_GROUP_ID_MASK, group);
+
+	size = readl(dport->regs.snoop + CXL_SNOOP_FILTER_SIZE_OFFSET);
+	if (!size) {
+		dev_dbg(dport->dport_dev, "CXL snoop filter has no capacity\n");
+		return 0;
+	}
+
+	sf = find_or_add_snoop_filter(size, id);
+	if (IS_ERR_OR_NULL(sf)) {
+		return PTR_ERR(sf);
+	}
+
+	dev_dbg(dport->dport_dev, "assigned snoop filter gid %d\n", sf->id);
+	dport->snoop = id;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dport_probe_snoop_filter, "CXL");
+
+void cxl_destroy_snoop_filters(void)
+{
+	struct cxl_snoop_filter *sf;
+	unsigned long id;
+
+	guard(rwsem_write)(&snoop_rwsem);
+	xa_for_each(&snoop_filters, id, sf)
+		destroy_snoop_filter(sf);
+
+	xa_destroy(&snoop_filters);
+}
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 35eaf636adc9..7a6a496a5017 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -229,4 +229,11 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport);
+
+#if IS_ENABLED(CONFIG_CXL_CACHE)
+void cxl_destroy_snoop_filters(void);
+#else
+static inline void cxl_destroy_snoop_filters(void) {}
+#endif
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 047801faa020..f97ece7cddbe 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1272,6 +1272,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (!dport->rch)
 		devm_cxl_dport_ras_setup(dport);
 
+	dport->snoop = CXL_SNOOP_FILTER_NO_GROUP_ID;
+
 	rc = cxl_dport_map_cache_id_dc(dport);
 	if (rc)
 		dev_dbg(dport->dport_dev,
@@ -2629,6 +2631,7 @@ static void cxl_core_exit(void)
 	bus_unregister(&cxl_bus_type);
 	destroy_workqueue(cxl_bus_wq);
 	cxl_memdev_exit();
+	cxl_destroy_snoop_filters();
 	debugfs_remove_recursive(cxl_debugfs);
 }
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 2809c72fb2eb..07c3a9926b49 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -93,6 +93,12 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			length = CXL_RAS_CAPABILITY_LENGTH;
 			rmap = &map->ras;
 			break;
+		case CXL_CM_CAP_CAP_ID_SNOOP:
+			dev_dbg(dev, "found Snoop capability (0x%x)\n",
+				offset);
+			length = CXL_SNOOP_FILTER_CAPABILITY_LENGTH;
+			rmap = &map->snoop;
+			break;
 		case CXL_CM_CAP_CAP_ID_CACHE_ID_RT: {
 			int target_cnt;
 
@@ -233,6 +239,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 	} mapinfo[] = {
 		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
 		{ &map->component_map.ras, &regs->ras },
+		{ &map->component_map.snoop, &regs->snoop },
 		{ &map->component_map.cidrt, &regs->cidrt },
 		{ &map->component_map.ciddc, &regs->ciddc },
 	};
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 63efe98d1c89..4c4ed6123b4a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -41,6 +41,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 
 #define   CXL_CM_CAP_CAP_ID_RAS 0x2
 #define   CXL_CM_CAP_CAP_ID_HDM 0x5
+#define   CXL_CM_CAP_CAP_ID_SNOOP 0x8
 #define   CXL_CM_CAP_CAP_ID_CACHE_ID_RT 0xD
 #define   CXL_CM_CAP_CAP_ID_CACHE_ID_DC 0xE
 #define   CXL_CM_CAP_CAP_HDM_VERSION 1
@@ -225,6 +226,11 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXLDEV_MBOX_BG_CMD_COMMAND_VENDOR_MASK GENMASK_ULL(63, 48)
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
+/* CXL 4.0 8.2.4.23 CXL Snoop Filter Capability Structure */
+#define CXL_SNOOP_FILTER_GROUP_ID_OFFSET 0x0
+#define   CXL_SNOOP_FILTER_GROUP_ID_MASK GENMASK(15, 0)
+#define CXL_SNOOP_FILTER_SIZE_OFFSET 0x4
+#define CXL_SNOOP_FILTER_CAPABILITY_LENGTH 0x8
 
 /* CXL 4.0 8.2.4.28.1 CXL Cache ID Route Table Capability Structure */
 #define CXL_CACHE_ID_RT_CAP_OFFSET 0x0
@@ -683,6 +689,7 @@ struct cxl_rcrb_info {
  * @coord: access coordinates (bandwidth and latency performance attributes)
  * @link_latency: calculated PCIe downstream latency
  * @gpf_dvsec: Cached GPF port DVSEC
+ * @snoop: Group id of snoop filter this dport belongs to
  */
 struct cxl_dport {
 	struct device *dport_dev;
@@ -695,6 +702,7 @@ struct cxl_dport {
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	long link_latency;
 	int gpf_dvsec;
+	int snoop;
 };
 
 /**
@@ -973,11 +981,17 @@ u16 cxl_gpf_get_dvsec(struct device *dev);
 #if IS_ENABLED(CONFIG_CXL_CACHE)
 int cxl_port_map_cache_id_rt(struct cxl_port *port);
 int cxl_dport_map_cache_id_dc(struct cxl_dport *dport);
+int cxl_dport_probe_snoop_filter(struct cxl_dport *dport);
 #else
 static inline int cxl_port_map_cache_id_rt(struct cxl_port *port)
 { return -ENXIO; }
 static inline int cxl_dport_map_cache_id_dc(struct cxl_dport *dport)
 { return -ENXIO; }
+static inline int cxl_dport_probe_snoop_filter(struct cxl_dport *dport)
+{
+	dport->snoop = CXL_SNOOP_FILTER_NO_GROUP_ID;
+	return 0;
+}
 #endif
- 
+
 #endif /* __CXL_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 942b92af55d9..2293ab27729d 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -301,6 +301,16 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 	/* New dport added, update the decoder targets */
 	cxl_port_update_decoder_targets(port, dport);
 
+	/* 
+	 * cxl_cachedevs won't probe if this fails, but it's not an error for
+	 * cxl_memdevs
+	 */
+	rc = cxl_dport_probe_snoop_filter(dport);
+	if (rc)
+		dev_info(dport->dport_dev,
+			 "Failed to find or create a CXL snoop filter: %d\n",
+			 rc);
+
 	dev_dbg(&port->dev, "dport%d:%s added\n", dport->port_id,
 		dev_name(dport_dev));
 
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index b99a9727e284..22b9c8c9c06e 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -34,12 +34,14 @@ struct cxl_regs {
 	 * Common set of CXL Component register block base pointers
 	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
 	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
+	 * @snoop: CXL 4.0 8.2.4.23 CXL Snoop Filter Capability Structure
 	 * @cidrt: CXL 4.0 8.2.4.28 CXL Cache ID Route Table Capability Structure
 	 * @ciddc: CXL 4.0 8.2.4.29 CXL Cache ID Decoder Capability Structure
 	 */
 	struct_group_tagged(cxl_component_regs, component,
 		void __iomem *hdm_decoder;
 		void __iomem *ras;
+		void __iomem *snoop;
 		void __iomem *cidrt;
 		void __iomem *ciddc;
 	);
@@ -84,6 +86,7 @@ struct cxl_reg_map {
 struct cxl_component_reg_map {
 	struct cxl_reg_map hdm_decoder;
 	struct cxl_reg_map ras;
+	struct cxl_reg_map snoop;
 	struct cxl_reg_map cidrt;
 	struct cxl_reg_map ciddc;
 };
@@ -156,7 +159,8 @@ struct cxl_dpa_partition {
 #define CXL_NR_PARTITIONS_MAX 2
 
 #define CXL_CACHE_ID_NO_ID (-1)
- 
+#define CXL_SNOOP_FILTER_NO_GROUP_ID (-1)
+
 /**
  * struct cxl_cache_state - CXL cache device state for use by external drivers
  * @size: Size of device's cache
-- 
2.53.0

