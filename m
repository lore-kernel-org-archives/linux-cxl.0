Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC7735CBA0
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897400; cv=fail; b=UZWlWn7ttR8TJRNmHgIgnAcXaldxiFMFdt5svMlU5P6aDL7ZlZn6t9XmI7rEQj28BIcXc4olM25zuvX897GmMkXWYzBNtqJmdlWMv/YKe9cJxCMzFAlzORxNWw/zcHc98lwHU/ugetUflPkk7DbQ29RjcE6FV0ExPjuQXNgsld4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897400; c=relaxed/simple;
	bh=0AS7wO7KGMd0651C0uWRGAZkGUdzYYAf4fLsLtgA2xM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZdNrOdabj0Ao+SyPdsjnHtLGNpjIdKXxcH/EQDoyqsknSBMADYsqGY8BqsLtIvmbA52IkUbOJ/ByRdGhrZoEZ+ajDsZMMqbjGJJGGmtm9xwSVTALtTODNp9aVp+i6DmdpTg0H9CCe+4zZiW7YX2Gr0yGIXHNQpCyDGuf2xP7IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wpRgHi3b; arc=fail smtp.client-ip=52.101.48.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wpRgHi3b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhjX64FUHVfP0zJ7F9EJ5QW4XVefsIoo4WYXXeGHrC1M6g9t/eEzBAmIsoPciK9znx+kCDGDkbeCx5zAvvoItiajK8unZYK3L/xmd7fFVHqjizpqjZF0gFxgJYeeIoKR2E8Po1K4eLOxdterol3/OlCzO7S89n8TeKkKcYsYoGaX4+Y99Ssbgnu8rdb2A7WvkLI9XWGynfNxxezzXor6eo6NsBVzJbip7RAo5ehrBv3+Zg1StzlNloFofog1Cdrbwjaoc48UnkNEF32r8l/IsAOC2a3Y5QTnlUa0FVnO9+5ihDB1LmREUHxm6PkhFAGf+aVmxN9U9yRTX3WE0EsLhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJiy3zi915ieu30jzfJToSmnwncyFsD5fRp2A5GKMt4=;
 b=cZcmlPxLZhtWKx60EDXk6H6lalEmpLzNeZjh96CMEJZsXZo+KtpwJvHwzjKzy8xRRbIO4B24+BPyR3Zwyk83LHIN6qWPzlkf23bhUDNuRq4cqFS8f3Twuu9Hfpy8t1V1Ug+60wpwUA2NQcSctSyccOICjYF7RoH7cu8m5J1ELWmj4yX0gu1IPEJuyVZwZyz1wug3zZTmLYDLKj1xlfoSSOfq6idkqwPpOzrefn0+6U6b7c4FbgG1zB9RkbtLhICof2PrA9YkC8jwxKjuKX/wQHX5RmyKiw3s35u9lcBawy25GhyhA3dKFef4KDOwQhzhMG7GqcFjNMbiqWcigDPVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJiy3zi915ieu30jzfJToSmnwncyFsD5fRp2A5GKMt4=;
 b=wpRgHi3bH8YtnXNqSO0iv56Q64/55wUhWHokU0W+RijjK60rnSynYfDFthzIe9u5EiR7p2eiFvhrcxF3UqeL002FBiCPiVeIGuzG85JoMgG059/d8D+iCagXi5sDSPCzywnXX8iptthmoNxsh46zaFZW3kJtozIe1vIQYhFplnA=
Received: from BL1PR13CA0345.namprd13.prod.outlook.com (2603:10b6:208:2c6::20)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 21:43:14 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::f8) by BL1PR13CA0345.outlook.office365.com
 (2603:10b6:208:2c6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 21:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 21:43:13 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 13:43:12 -0800
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>
Subject: [PATCH 12/17] cxl/core: Add CXL snoop filter setup and allocation
Date: Tue, 11 Nov 2025 15:40:27 -0600
Message-ID: <20251111214032.8188-13-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SJ0PR12MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d01d80-6f10-48e5-4aaa-08de216b50cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7WQcVgjUQLEqqySUecakU+eyPGA9+LG85uEbyjSYyM/wR163QjtH7Vi4W0Gc?=
 =?us-ascii?Q?/fA+RFELbVSJ3sWz4nr4Y7sMnvuyQraA9hmGqqlDr7cn6SsUh/dKRCu7GXfz?=
 =?us-ascii?Q?Tvf1FuaTvM9/7YuxCOeZo7dUhkCmizAhtPXqpxLYYfr87i6y0OQJQyYmE/Bt?=
 =?us-ascii?Q?YUsyc2IP4beE3piyeewbLU5buSpw86PNER6WUJNhp1aQ5NXSIJ5eearox1l0?=
 =?us-ascii?Q?onRhm2AEdU7dZt1KjuFcyi0YO2KEbANcVEABs5ipz2s6e3JjOjrkpF1dNoaq?=
 =?us-ascii?Q?Gt7V+bnwFW/E3sh/aVnB0PEIolhY2D+XcUlmJW9sqpjV04IRUfmwZzbs32zz?=
 =?us-ascii?Q?iZzKJ+8hlLm8kWL5IEdfzM0F68wNGREPcrupvSOwKwAoquH25WPAFahUfDAu?=
 =?us-ascii?Q?TICpkYm//luHCJ/+2xQeE2o/dEhnU8nv9j94Il63w0VuH5Ry3vSsGp+/Dc4k?=
 =?us-ascii?Q?SlC58bxZArTkSOgbE76KepO4Pz1kqS7DcmYGCSz1p3OVKZIXV/F699vEO+fZ?=
 =?us-ascii?Q?AikTXxi2Jt+uZeJ5DYlmeVsdYYbN9chdiBVeaE13aL2PxC68edOMR5BLUBBJ?=
 =?us-ascii?Q?fCM4pYBxWsCvlZKSam4BB6krbCqmF325bMo4u1XVHSX0YulpXIOqE6wmJlkO?=
 =?us-ascii?Q?8/A7PzvgdvwSQZVsFZinXr4l0ltZoRM4iKxbZ91M213kF3CPx/Sh5lZN5PWT?=
 =?us-ascii?Q?1YPn4ha6coPyncMQYsOle3S+MMzZ/c7gX+Gp0KkgIV0zXX70MgDnEtcXnD9T?=
 =?us-ascii?Q?a0ZcjN9n+14BEBi3ZswgRFMpjOnIcP28sqeh2V2hHAK0v1aL0EL7GWEZcYxJ?=
 =?us-ascii?Q?O79wPFH34oN/uB08WnvLhrnUf4M1fjTFwCEdaraJGvgvzAI0Vd3bBxGg02Y6?=
 =?us-ascii?Q?cH2mNdcXfiyd8oA38/EeLAJYGuHwGj2rj4jo+Wnl/DoqYjfwLmf+dZh/Fw3c?=
 =?us-ascii?Q?gzgAhQu9uWP75r4A999pDaKlxPds8yyS1djKsmqOQHftGyjyb2b0FZvd6hOp?=
 =?us-ascii?Q?LQaciJqoqupcRuXR/YqtOOEdFWGPjwc33A9lczPngp/op8z6TLzm+GvQ3nzX?=
 =?us-ascii?Q?B1JKGbFFoZH6ey7iPV4NlOPuJA+4Iq3j0drHmaY2HK0+fOM/AdRGWIEZficK?=
 =?us-ascii?Q?vIN3sjSze4FRG1ftJqza/zw2mz2ht9a0bl8TZOJPXCPrzhn8lH47KVezyk8I?=
 =?us-ascii?Q?VwWEIWmPpSPr1hCy4kJ2ZxeCf2w43x92W14FMnzsm1InDIijirP/r22lPTOy?=
 =?us-ascii?Q?DI2x24kj1OiFp0socLxYAjqeAkVibiyabaMHj6PsGXW1NKCrrCnwwFYrLJ+8?=
 =?us-ascii?Q?YRvRUbBVt5iISVNImQSE2Cwzb00ez6js51XeX0vlrwHtqgk71cXe1xJfotWs?=
 =?us-ascii?Q?fnua9PeTUNRqBdCgo6+UYoSSG6+1qaHVvIkO90TeLTEviLVol/CbB6ThcfzV?=
 =?us-ascii?Q?cgj/lVNXie0gNe4eNGgj5uV9aGFP+uYUC9t5akLnGmrg4e6UY8v/c5WeOWA6?=
 =?us-ascii?Q?maGTqNzDdynPLIWL2KLITHXGGnbvvtr7P1KpM3dfVYKADeM20alV4G0b5m6W?=
 =?us-ascii?Q?VFVPhkHCjideez4DvjI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:43:13.3463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d01d80-6f10-48e5-4aaa-08de216b50cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941

The CXL snoop filter capability (CXL 3.2 8.2.4.23) is a mandatory
capability for CXL 2.0+ root ports that is used by the host and CXL
devices to manage CXL cache coherence.

Snoop filters may be shared by several CXL root ports, with each snoop
filter having a unique group id. Create snoop filter instances as CXL
root ports are added to the system. If the snoop filter already exists,
add the root port to the existing filter instead.

Snoop filter instances are used to keep track of the amount of CXL cache
space active under the filter. The CXL specification allows rejecting
CXL devices based on the amount of filter subscription, but determining
when the filter is oversaturated is most likely implementation specific.
To address this, add a cxl_core module parameter to specify whether
adding a CXL.cache device's cache to an already full filter should fail
device probe. The default setting of the parameter is to allow
oversaturation of the filter ("strict_snoop=off").

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---

Jonathan asked about the allocation policy when the snoop filter is
"full". I had the device fail probe beforehand, but it got me thinking
that it may be worthwhile to add an option to over commit the filter
instead, hence the module parameter. I'm game to other suggestions, but
a config symbol didn't feel right since the setting probably varies by
platform/user.

Also I'll add Cache_SF_Coverage support when this series goes out of
RFC (I forgot to do it this time around).

---
 drivers/cxl/cache.c     |  35 ++++++++
 drivers/cxl/core/port.c | 178 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c |   7 ++
 drivers/cxl/cxl.h       |  14 ++++
 4 files changed, 234 insertions(+)

diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
index dcc9816d9b37..40c3ffd9c89b 100644
--- a/drivers/cxl/cache.c
+++ b/drivers/cxl/cache.c
@@ -12,6 +12,10 @@
  * device-specific driver is required for discovery and portions of set up.
  */
 
+/* Controls whether failing to allocate snoop filter capacity is tolerated */
+static bool strict_snoop;
+module_param(strict_snoop, bool, 0644);
+
 /**
  * devm_cxl_add_cachedev - Add a CXL cache device
  * @host: devres alloc/release context and parent for the cachedev
@@ -54,6 +58,22 @@ struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_cachedev, "CXL");
 
+static int cxl_populate_snoop_gid(struct cxl_cachedev *cxlcd)
+{
+	struct cxl_cache_state *cstate = &cxlcd->cxlds->cstate;
+
+	for (struct cxl_dport *iter = cxlcd->endpoint->parent_dport;
+	     iter && !is_cxl_root(iter->port);
+	     iter = iter->port->parent_dport) {
+		if (iter->snoop_id != CXL_SNOOP_ID_NO_ID) {
+			cstate->snoop_id = iter->snoop_id;
+			return 0;
+		}
+	}
+
+	return -ENXIO;
+}
+
 static int cxl_cache_probe(struct device *dev)
 {
 	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
@@ -93,6 +113,21 @@ static int cxl_cache_probe(struct device *dev)
 			return rc;
 	}
 
+	rc = cxl_populate_snoop_gid(cxlcd);
+	if (rc) {
+		dev_dbg(&cxlcd->dev, "failed to get snoop id: %d\n", rc);
+		return rc;
+	}
+
+	rc = devm_cxl_snoop_filter_alloc_capacity(cxlcd);
+	if (rc) {
+		dev_dbg(&cxlcd->dev,
+			"failed to allocate snoop filter capacity: %d\n", rc);
+
+		if (strict_snoop)
+			return rc;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index dc001e136782..70666a059d1f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -34,6 +34,8 @@
 static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
 
+static DEFINE_XARRAY(cxl_snoop_filters);
+
 /*
  * The terminal device in PCI is NULL and @platform_bus
  * for platform devices (for cxl_test)
@@ -810,6 +812,175 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 	return rc;
 }
 
+struct cxl_snoop_filter {
+	u64 size;
+	struct xarray dports;
+	struct xarray devs;
+	struct mutex lock; /* Used for filter allocations */
+};
+
+static int cxl_snoop_filter_add_dport(struct cxl_dport *dport, u32 gid)
+{
+	struct cxl_snoop_filter *sf;
+
+	sf = xa_load(&cxl_snoop_filters, gid);
+	if (sf)
+		return xa_insert(&sf->dports, (unsigned long)dport->dport_dev,
+				 dport, GFP_KERNEL);
+
+	return -ENXIO;
+}
+
+static struct cxl_snoop_filter *cxl_alloc_snoop_filter(u64 size)
+{
+	struct cxl_snoop_filter *sf;
+
+	sf = kzalloc(sizeof(*sf), GFP_KERNEL);
+	if (!sf)
+		return NULL;
+
+	sf->size = size;
+	xa_init(&sf->dports);
+	xa_init(&sf->devs);
+	mutex_init(&sf->lock);
+
+	return sf;
+}
+
+static void cxl_destroy_snoop_filter(struct cxl_snoop_filter *sf)
+{
+	xa_destroy(&sf->dports);
+	xa_destroy(&sf->devs);
+	mutex_destroy(&sf->lock);
+	kfree(sf);
+}
+
+static int cxl_create_snoop_filter(struct cxl_dport *dport, u32 gid, u64 size)
+{
+	struct cxl_snoop_filter *sf;
+	int rc;
+
+	sf = cxl_alloc_snoop_filter(size);
+	if (!sf)
+		return -ENOMEM;
+
+	rc = xa_insert(&sf->dports, (unsigned long)dport->dport_dev, dport,
+		       GFP_KERNEL);
+	if (rc) {
+		cxl_destroy_snoop_filter(sf);
+		return rc;
+	}
+
+	rc = xa_insert(&cxl_snoop_filters, gid, sf, GFP_KERNEL);
+	if (rc) {
+		cxl_destroy_snoop_filter(sf);
+
+		/*
+		 * The snoop filter insert failed due to a race, get the already
+		 * made snoop filter.
+		 */
+		if (rc == -EBUSY)
+			return cxl_snoop_filter_add_dport(dport, gid);
+
+		return rc;
+	}
+
+	return 0;
+}
+
+static void cxl_snoop_filter_free_capacity(void *data)
+{
+	struct cxl_cache_state *cstate = data;
+	struct cxl_snoop_filter *sf;
+
+	sf = xa_load(&cxl_snoop_filters, cstate->snoop_id);
+	if (!sf) {
+		pr_debug("failed to find snoop filter with id %d\n",
+			 cstate->snoop_id);
+		return;
+	}
+
+	guard(mutex)(&sf->lock);
+	sf->size += cstate->size;
+}
+
+/**
+ * devm_cxl_snoop_filter_alloc_capacity - Reserve snoop filter capacity for a
+ * CXL.cache device's cache.
+ * @cxlcd: Device to allocate capacity for
+ */
+int devm_cxl_snoop_filter_alloc_capacity(struct cxl_cachedev *cxlcd)
+{
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+	struct cxl_cache_state *cstate = &cxlds->cstate;
+	struct cxl_snoop_filter *sf;
+	int gid = cstate->snoop_id;
+
+	sf = xa_load(&cxl_snoop_filters, gid);
+	if (!sf)
+		return -ENODEV;
+
+	guard(mutex)(&sf->lock);
+	if (cstate->size > sf->size)
+		return -EBUSY;
+
+	sf->size -= cstate->size;
+	return devm_add_action_or_reset(&cxlcd->dev,
+					cxl_snoop_filter_free_capacity, cstate);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_snoop_filter_alloc_capacity, "CXL");
+
+static void cxl_destroy_snoop_filters(void)
+{
+	struct cxl_snoop_filter *sf;
+	unsigned long gid;
+
+	xa_for_each(&cxl_snoop_filters, gid, sf)
+		cxl_destroy_snoop_filter(sf);
+
+	xa_destroy(&cxl_snoop_filters);
+}
+
+static int cxl_dport_setup_snoop_filter(struct cxl_dport *dport)
+{
+	struct cxl_port *port = dport->port;
+	struct cxl_port *parent_port;
+	u32 snoop, size;
+	int gid, rc;
+
+	/* Capability is only support by CXL root ports */
+	parent_port = parent_port_of(port);
+	if (!parent_port || !is_cxl_root(parent_port))
+		return 0;
+
+	if (!dport->reg_map.component_map.snoop.valid) {
+		dev_dbg(dport->dport_dev, "missing snoop filter capability\n");
+		return -ENXIO;
+	}
+
+	rc = cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_SNOOP));
+	if (rc)
+		return rc;
+
+	snoop = readl(dport->regs.snoop + CXL_SNOOP_GROUP_ID_OFFSET);
+	gid = FIELD_GET(CXL_SNOOP_GROUP_ID_MASK, snoop);
+
+	size = readl(dport->regs.snoop + CXL_SNOOP_FILTER_SIZE_OFFSET);
+	if (!size)
+		dev_warn(dport->dport_dev, "CXL snoop filter has no capacity\n");
+
+	rc = cxl_snoop_filter_add_dport(dport, gid);
+	if (rc) {
+		rc = cxl_create_snoop_filter(dport, gid, size);
+		if (rc)
+			return rc;
+	}
+
+	dport->snoop_id = gid;
+	return 0;
+}
+
 DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
 
 static int cxl_einj_inject(void *data, u64 type)
@@ -1177,6 +1348,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	dport->dport_dev = dport_dev;
 	dport->port_id = port_id;
 	dport->port = port;
+	dport->snoop_id = CXL_SNOOP_ID_NO_ID;
 
 	if (rcrb == CXL_RESOURCE_NONE) {
 		rc = cxl_dport_setup_regs(&port->dev, dport,
@@ -1207,6 +1379,11 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		dev_dbg(dport_dev, "Component Registers found for dport: %pa\n",
 			&component_reg_phys);
 
+	rc = cxl_dport_setup_snoop_filter(dport);
+	if (rc)
+		dev_dbg(dport->dport_dev,
+			"failed to set up snoop filter capability %d\n", rc);
+
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
@@ -2585,6 +2762,7 @@ static void cxl_core_exit(void)
 	bus_unregister(&cxl_bus_type);
 	destroy_workqueue(cxl_bus_wq);
 	cxl_memdev_exit();
+	cxl_destroy_snoop_filters();
 	debugfs_remove_recursive(cxl_debugfs);
 }
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 5ca7b0eed568..280978b34d2f 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -92,6 +92,12 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			length = CXL_RAS_CAPABILITY_LENGTH;
 			rmap = &map->ras;
 			break;
+		case CXL_CM_CAP_CAP_ID_SNOOP:
+			dev_dbg(dev, "found Snoop Filter capability (0x%x)\n",
+				offset);
+			length = CXL_SNOOP_CAPABILITY_LENGTH;
+			rmap = &map->snoop;
+			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
 				offset);
@@ -211,6 +217,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 	} mapinfo[] = {
 		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
 		{ &map->component_map.ras, &regs->ras },
+		{ &map->component_map.snoop, &regs->snoop },
 	};
 	int i;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index e8d66de469d6..de29ffc3d74f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -41,6 +41,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 
 #define   CXL_CM_CAP_CAP_ID_RAS 0x2
 #define   CXL_CM_CAP_CAP_ID_HDM 0x5
+#define   CXL_CM_CAP_CAP_ID_SNOOP 0x8
 #define   CXL_CM_CAP_CAP_HDM_VERSION 1
 
 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
@@ -152,6 +153,12 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXL_HEADERLOG_SIZE SZ_512
 #define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
 
+/* CXL 3.2 8.2.4.23 CXL Snoop Filter Capability Structure */
+#define CXL_SNOOP_GROUP_ID_OFFSET 0x0
+#define   CXL_SNOOP_GROUP_ID_MASK GENMASK(15, 0)
+#define CXL_SNOOP_FILTER_SIZE_OFFSET 0x4
+#define CXL_SNOOP_CAPABILITY_LENGTH 0x8
+
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
 #define   CXLDEV_CAP_ARRAY_CAP_ID 0
@@ -215,6 +222,7 @@ struct cxl_regs {
 	struct_group_tagged(cxl_component_regs, component,
 		void __iomem *hdm_decoder;
 		void __iomem *ras;
+		void __iomem *snoop;
 	);
 	/*
 	 * Common set of CXL Device register block base pointers
@@ -257,6 +265,7 @@ struct cxl_reg_map {
 struct cxl_component_reg_map {
 	struct cxl_reg_map hdm_decoder;
 	struct cxl_reg_map ras;
+	struct cxl_reg_map snoop;
 };
 
 struct cxl_device_reg_map {
@@ -693,6 +702,7 @@ struct cxl_dport {
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	long link_latency;
 	int gpf_dvsec;
+	int snoop_id;
 };
 
 /**
@@ -759,6 +769,7 @@ struct cxl_dpa_info {
 	int nr_partitions;
 };
 
+#define CXL_SNOOP_ID_NO_ID (-1)
 
 /**
  * struct cxl_cache_state - State of a device's CXL cache
@@ -768,6 +779,7 @@ struct cxl_dpa_info {
 struct cxl_cache_state {
 	u64 size;
 	u32 unit;
+	int snoop_id;
 };
 
 /**
@@ -832,6 +844,8 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
 	return dev_get_drvdata(cxl_mbox->host);
 }
 
+int devm_cxl_snoop_filter_alloc_capacity(struct cxl_cachedev *cxlcd);
+
 /**
  * struct cxl_region_ref - track a region's interest in a port
  * @port: point in topology to install this reference
-- 
2.51.1

