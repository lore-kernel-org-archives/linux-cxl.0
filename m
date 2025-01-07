Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7F61F7075;
	Tue,  7 Jan 2025 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259107; cv=fail; b=i/qGU3LQ6y+2C4qSeBiPaISjfcPltuY54tB7MhAE3//e4bpuWrhxTq5IfFkpyygucZt2N072UF+h/rbFM5PYm3NrQJ23gegGl/NO7Z4IxPIksOWHYCF/RoOw8upsphWwxOy1l6DtRiWz2eX4SPf5dZNeh02zH4pknCSpFlHX5yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259107; c=relaxed/simple;
	bh=rNZRtzQTMD553IXiAYDSSF8MVNYmXQDPkFT38hGJN6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRw7PQuG2xPr5BhHqh7+g+8UREDAO5oaCSjcLNaYWiuzGVchmqpPPdPpNATeqbabyIXhUa7tBJNpEo2g3i/KLf3gAUH3fQB+Ue2aKW+TZgOi3XmBUaPYB+AtJShXtwRsbvPp6mEZg1VnkTsRJUpoZCxo5tG4GAaihOBh9n3H3HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QEn/kk9S; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QEn/kk9S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MphZGfPsGgwHKDUceRym/zhK7yzBPzQ5gzfqQeFvNANN85PtOzfubYZiXR7i7sSU4tPhBQh3Voxnen5uhg6VkjHpTZMxIES3BBNie33PgG/rGtQDx3jJHmBoRwVC48oqriiOuRsqtpSFgGB28tViMr3fYnfhl6j9z4MEd5U7Vb9pMMNJFuzRFv7KFMnOyzDBH9qucRSLqy/SSnE+QpjLVJuZCcl9xcCDxqGDwObEQ/7obtH4owzQWeuOYxAP5NNhgBMQK/t9Z/m89BUI/nRwcKa9sqMR8/mtkcKhBS7KEY0DZ9kUVIhmzy9ik6A1eSaTD+BTJaaIYcMl0t0bPvybdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnCChBjI7SQpu0xLR9cDcEpbd/eC43KRBYQi+wSDXCI=;
 b=PiiomaV29aaFTeCdMzl0CSl/ZimPR7MNdRbNVOfhL5Apj736pW6YF5vkRVQZty8EqRw/Up73QYGaZ0dLaHSC2eFDnktts0Gma67hJylLtFP7U8a2zVM9WurA1SHKVjNSI8QxT/Es8f4pnD3ETf/eG6gIstK/5APEx/J4TyBT8fntRXm6gKAf71alprvAsoSz9RM+NBSf3MlGBpGvTzl5OBHgV9oUZFcM8xP6kck8R0CXZMQidAFYminie0lpZqQljMdqxZdHEhBjRrGaPPgmSERhkFEcJ8goktNXxvuEX+quqDICaPi3db/YodhsTstZkms+so+0iCV4aa8XZFJCOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnCChBjI7SQpu0xLR9cDcEpbd/eC43KRBYQi+wSDXCI=;
 b=QEn/kk9SQ+rJBLJnWAr0CPiHngGB+7VV/ZP0zTRyDJEEe6rsb7XjIzNevXhW/qomZdEKEA0jLXCa+a5Sy7icU0fBr49Lfvm5n6v19i9c/8HLq0bJOeyPCZMcjYxW01ttcy4eXdws83+GTtYBJC9nWbAOOE74p3zRB2kwtxDNJKo=
Received: from MW4PR04CA0072.namprd04.prod.outlook.com (2603:10b6:303:6b::17)
 by SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 14:11:40 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::f1) by MW4PR04CA0072.outlook.office365.com
 (2603:10b6:303:6b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:11:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:11:39 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:11:36 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 16/29] cxl/region: Use translated HPA ranges to calculate the endpoint position
Date: Tue, 7 Jan 2025 15:10:02 +0100
Message-ID: <20250107141015.3367194-17-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107141015.3367194-1-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|SN7PR12MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: c255b0db-fce0-4444-0c30-08dd2f253491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s+ybea2Abpiwrt8i8sjXPoREBa5wjFU9rz1LiCZERwbmQWBKYxCy4fTQbup/?=
 =?us-ascii?Q?+/N32SiyX5SBd1zsurR5a27B779XCZ9RdRfLiz1uM/vVfd7dqS/evXQ1LjYh?=
 =?us-ascii?Q?PdFWMB7l9masZFjyqKQ03Ysvx7Ohny/0HirPrMjdIW4C8U+pwVcElXyJtPEM?=
 =?us-ascii?Q?7EfqvDx6j9NKSU2ofQMFoSEOuWe60QvudXb6g3s6Ftklm9Jrkx7B/+Zi4k0Z?=
 =?us-ascii?Q?eD2am47ym6FBhKB5TsY1BozBTrI5mgkC4iUczJVcf49Gt60CCrx+vTkgaJf/?=
 =?us-ascii?Q?w9FOWIHAL+gCrW51SUgT+TKKWwx57t/yrC/70YMAqsprtgnhTgdQoWy4dbPg?=
 =?us-ascii?Q?G9R8aVj2VMrhco5Q8mn4dwJE0Oo+HA4PuYGrQdZI8NZaLOqtfaQZQ0nilOWR?=
 =?us-ascii?Q?h5/wb5q1T/gnjQChjrL+GAfN/MyMQYdDbYowOGH/c595QVGyLrVYhMiI4+nD?=
 =?us-ascii?Q?qe91sIRw0fSrZOIlcwMYzCZs/DwZMBr1Q8kVAaAGMEABGaxEx1gk0YdAP28G?=
 =?us-ascii?Q?34hV6QL1LmlU/+4uPA7gSSJeXqb2RgLw+RuscY6WIMRaEJD6Jv6AY6eJwBPO?=
 =?us-ascii?Q?h3KWA/uLVOrvxNYjXvj4T5ezECz6jqJFpbalO4GgcloPf9qd5GkjxQxnCD7N?=
 =?us-ascii?Q?f/aFG8kLU4aEhvN6qRiY5oNB2hl92CXB1r5+zRBJXKIOLJ8Sws/0wlkEXOhM?=
 =?us-ascii?Q?nGe9WXNgF/UpRphNivTv6yn8HPHuHr+OSPKLyjGqewTemFaHjZj+aui9YWYX?=
 =?us-ascii?Q?TsL0zVKE8iLI5KTTwBEmzZbjk5hUvmivjUBz6MDjyuvjMTVClypyMBkabEl/?=
 =?us-ascii?Q?vhpoD1ZelyznQk7jeup2Fr+jmb+MTtkOVk3n3kmw6JrMYX6oH9cCSu/7ycUx?=
 =?us-ascii?Q?vcTUaSqTyuyWWtNWYiIApAnUL5NJxjqnfV+HFO7skAYFl3F9d4MtwgeYLJLV?=
 =?us-ascii?Q?w+oZsYrVEquBrS8WXj/0/dU7IRxeXprHKIGBaQ5KQ6BrMZR4HpF3vj1h78XH?=
 =?us-ascii?Q?+gzxIUv+WKndEj3Gkd+dI4rfWlnc/rvfg5z2DR6TH68oeKXfWQ0Qov9mEum9?=
 =?us-ascii?Q?GQpZ+461u6b0vaUagYan67RGHgg9kZVsVwu63pqaumUp+zKlEvUlwNvIU6HU?=
 =?us-ascii?Q?Zux1TTvUWVjGKgKVlY5T02pZzWRT3AiQz9bN1oY2GlIoBrGSpZ9HXZff/DYP?=
 =?us-ascii?Q?04e2uGP7K3SGMhY30lxMk9YZZlnDFfOAaEdJyuy1++Hg6QzF/Ol+XLm2CSRz?=
 =?us-ascii?Q?4CoAZVKm6F5M6FxMzWYAiHM0inr/wJmZiNjFmRtnLvuZFgtB3cUmMYutvBuu?=
 =?us-ascii?Q?XmZ+FLiXJwyWG3arZCQGWDF8VYqG5hjF+xJpLqDJQ2GeS1q812i2uDAaK6tF?=
 =?us-ascii?Q?bnjlsTwTfwjuP9ITO1zAPaqoJDdcus5LTXViIByGxhkEBO3U2YL5uVsImRw7?=
 =?us-ascii?Q?/aC9YFXAgdtAYPp8zdOwtVvOg9ltIsOFrJrfmnYoVbxEHdqXJ3N1GQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:11:39.7132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c255b0db-fce0-4444-0c30-08dd2f253491
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715

To enable address translation, the calculation of the endpoint
position must use translated HPA ranges. The function
cxl_endpoint_initialize() already uses translation which could be
reused to calculate the endpoint position.

Use translated HPA address ranges for the calculation of endpoint
position by moving it to cxl_endpoint_initialize(). Create a function
cxl_port_calc_pos() for use in the iterator there, but keep a
simplified version of cxl_calc_interleave_pos() for the
non-auto-discovery code path without address translation since it is
not support there.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 66 ++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 007a2016760d..c1e384e80d10 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1813,26 +1813,29 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 }
 
 /**
- * cxl_calc_interleave_pos() - calculate an endpoint position in a region
- * @cxled: endpoint decoder member of given region
+ * cxl_port_calc_pos() - calculate an endpoint position for @port
+ * @port: Port the new position is calculated for.
+ * @range: The HPA address range for the port.
+ * @pos: Current position in the topology.
  *
- * The endpoint position is calculated by traversing the topology from
- * the endpoint to the root decoder and iteratively applying this
- * calculation:
+ * The endpoint position for the next port is calculated by applying
+ * this calculation:
  *
  *    position = position * parent_ways + parent_pos;
  *
  * ...where @position is inferred from switch and root decoder target lists.
  *
+ * The endpoint position of region can be calculated by traversing the
+ * topology from the endpoint to the root decoder and iteratively
+ * applying the function for each port.
+ *
  * Return: position >= 0 on success
  *	   -ENXIO on failure
  */
-static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
+static int cxl_port_calc_pos(struct cxl_port *port, struct range *range,
+			     int pos)
 {
-	struct cxl_port *iter, *port = cxled_to_port(cxled);
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *range = &cxled->cxld.hpa_range;
-	int parent_ways = 0, parent_pos = 0, pos = 0;
+	int parent_ways = 0, parent_pos = 0;
 	int rc;
 
 	/*
@@ -1864,17 +1867,30 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 	 * complex topologies, including those with switches.
 	 */
 
-	/* Iterate from endpoint to root_port refining the position */
-	for (iter = port; iter; iter = parent_port_of(iter)) {
-		if (is_cxl_root(iter))
-			break;
+	if (is_cxl_root(port))
+		return pos;
 
-		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
-		if (rc)
-			return rc;
+	rc = find_pos_and_ways(port, range, &parent_pos, &parent_ways);
+	if (rc)
+		return rc;
 
-		pos = pos * parent_ways + parent_pos;
-	}
+	return pos * parent_ways + parent_pos;
+}
+
+static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *iter, *port = cxled_to_port(cxled);
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct range *range = &cxled->cxld.hpa_range;
+	int pos = 0;
+
+	/*
+	 * Address translation is only supported for auto-discovery of
+	 * decoders. There is no need to support address translation
+	 * here.
+	 */
+	for (iter = cxled_to_port(cxled); iter; iter = parent_port_of(iter))
+		pos = cxl_port_calc_pos(iter, range, pos);
 
 	dev_dbg(&cxlmd->dev,
 		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
@@ -1892,7 +1908,6 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 
-		cxled->pos = cxl_calc_interleave_pos(cxled);
 		/*
 		 * Record that sorting failed, but still continue to calc
 		 * cxled->pos so that follow-on code paths can reliably
@@ -3252,6 +3267,7 @@ static int cxl_endpoint_initialize(struct cxl_endpoint_decoder *cxled)
 	struct cxl_port *parent, *iter = cxled_to_port(cxled);
 	struct range hpa = cxled->cxld.hpa_range;
 	struct cxl_decoder *cxld = &cxled->cxld;
+	int pos = 0;
 
 	if (!iter || is_cxl_root(iter))
 		return -ENXIO;
@@ -3280,16 +3296,22 @@ static int cxl_endpoint_initialize(struct cxl_endpoint_decoder *cxled)
 		if (cxl_port_calc_hpa(parent, cxld, &hpa))
 			return -ENXIO;
 
+		/* Iterate from endpoint to root_port refining the position */
+		pos = cxl_port_calc_pos(iter, &hpa, pos);
+		if (pos < 0)
+			return pos;
+
 		iter = parent;
 	}
 
 	dev_dbg(cxld->dev.parent,
-		"%s:%s: range:%#llx-%#llx\n",
+		"%s:%s: range:%#llx-%#llx pos:%d\n",
 		dev_name(&cxled->cxld.dev), dev_name(&cxld->dev),
-		hpa.start, hpa.end);
+		hpa.start, hpa.end, pos);
 
 	cxled->cxlrd = to_cxl_root_decoder(&cxld->dev);
 	cxled->spa_range = hpa;
+	cxled->pos = pos;
 
 	return 0;
 }
-- 
2.39.5

