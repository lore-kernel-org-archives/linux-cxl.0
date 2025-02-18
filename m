Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32202698BE;
	Tue, 18 Feb 2025 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885087; cv=fail; b=ReY1m9ihWpQ0WrUY9C7t5QhJemhPfNZk/tKHLbx/4qA3IuEN3f7PAYFMm/fCP72gD/diTCGqVJh4fF8GkGKzInvf4SglpRdvUOtcDJDADoMpk4/AAsi8Rxd81Vuv9MoTNxarqAkCNoLIS4nwN7bdUbLvcjAkbuva6PXEFwx3u8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885087; c=relaxed/simple;
	bh=vsIU53x+pLsa60szRD+JVvMrOmDpDjj4K561Al4hR5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5hAKu2ek+lvBt2mO2Vc1jfbEco+2zuVEzxlJjTVusEVQz/mtXj2UA1nISTeDmjGWokHtR7uZ0q5ro+/oTKJY6B29sM66xlcuPOz2nuYfx/x3aZdFgyev+YoGKC4nFbgg5tUdTXWYX9B165coJhrQp3N2R056VBWkMdzymHGvq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oI/5+5yt; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oI/5+5yt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gO2Q8+Y10qRrtDkdbL7LJohKSaEzowXkJEhI+RFh/io4tnFlwYH+wbYe5ZsBkR8ljw24+lXCN9phD9ulSRCavYpTo5IYCXNpeuhexVu+wmwV5djEgsjaWGIbtwxGWi8tzNNfwIFOCI5Qb1/ZcCVf7Nq95rGcfCW6vBqLpOdtgpL22LTN53o32pFqOe5MUdpSieXPIZYlrl4vZ3wyXjrtm6jPD7XkXUlJqBz5gZR4HJqVkgZEtBEuLJlXdkkf08Fq9tVTDESyMfTmHcYP3aHKU8b4JB81KTsCBYBPPbfgMaCnvkVX6+7AE27n5IF8tSt9rVrGk71UWE4pVmM9EADrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3TbG7TswUs/dp06LrCs9aRPUm6h/8YCYuTaWQMBMgU=;
 b=paQsIoAIDwGY0Tj2kpmI/zwMKH1IpUFZKBxG9psXkzTMjpPfeoQNOCMeOvQs4wvbkS/cuBCBlijHJ+++jgduLt8hlh0jrkev4XON0OnWkm+rAMsSRsmZSDXT2cdkEbN1YSeH6CgfWjctabsLBVlaaKsxYN/Vf5+6IUHo3JOfqvC6sG0Afyz2bKEXWw5h2zQi8YJV84+KAZDoY5Atu5/MnUYx/JTgTvEtdvhDzfi27IjA6qsEp1+IN74VaE+AuqxW4eo41nE0tPfvsj0lj3U1SdAqpio0DU63Mn1u3yQocCFDF+W7RGDOLwT4e3CRYV5QOBfGge5VGTJCRtnWib5oGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3TbG7TswUs/dp06LrCs9aRPUm6h/8YCYuTaWQMBMgU=;
 b=oI/5+5ytKUc2LIQWqRvPAwNj5V5cPZq1HzuK43eoZbrjGoUrC85M9vaRhG28bQRIde7kFu2PSI65vRZBKcQw8bu45a0dWt+fJE8/Y+Sjvq3+eC6uaE/zb5I8VRi69es4vWGUjMHW20ib2YbtR19Q592/6jRbenEaSTMkk43aDUg=
Received: from BN1PR14CA0018.namprd14.prod.outlook.com (2603:10b6:408:e3::23)
 by SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 13:24:42 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::ba) by BN1PR14CA0018.outlook.office365.com
 (2603:10b6:408:e3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 13:24:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 13:24:42 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 07:24:39 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 03/15] cxl/region: Factor out code for interleaving calculations
Date: Tue, 18 Feb 2025 14:23:44 +0100
Message-ID: <20250218132356.1809075-4-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218132356.1809075-1-rrichter@amd.com>
References: <20250218132356.1809075-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|SA0PR12MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 45be2ac2-1fc1-42a4-99db-08dd501f9a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K1Qw3Mv4B3NDGphkz1RRnoUKYDOFiOTdGnI2wnW1bf3msd419sx8mok5hu6V?=
 =?us-ascii?Q?8cCSguPi3HlP5FFVYKkEjH+uyfA60x+GBNGD9hThbmF43xhJ9PVrxFRrX+J7?=
 =?us-ascii?Q?n4+K2O12EBjn+YMY7JL2jJmBaFGnW9uAHjiPWqGP7gNQz7P+Kd8K+DKwtkiJ?=
 =?us-ascii?Q?Nk+G6ngzgGc7+HAHRuP9aYTK3a/jRm6l8cUaVrgLPhjI8F1zVT8HoAm0X8WA?=
 =?us-ascii?Q?5e58Ss924KKxZclZoVPigT8gXmvHljI3fXw9WmgplFLAb1hyU+ZclYIWfFcJ?=
 =?us-ascii?Q?Jh+3dII0da25HzaGSLxyDQRssARzMYINyvRzSW6vQoaWTSdtc2wNihqSv0xB?=
 =?us-ascii?Q?cxLBqtLVdtorBUI+a3AKD5bZjryPG5NmGneR7JsSgh13kj+Aw/QQmjuRLjQE?=
 =?us-ascii?Q?M+Y7gYYSGX6GcbUeKwxgJ7q0lxsIt/uVIxCKs2aNxG4Di7pf/C2/zVued+P2?=
 =?us-ascii?Q?KFbXPI1/jHjZgF3Uq215BZ22dGJ1VjA/EqoQzAMeWoUf7iMvj0UiDTlIwZHZ?=
 =?us-ascii?Q?niCStNSZIVQ+ROF+mf4UCwB3cJk4R5EBxiI8EQgfC6OAKclUTA1lhM/kRfUM?=
 =?us-ascii?Q?6LXqwWM4mUd4fuO8t0ZXOIJBnKpNruLc6fIZmPDLACLFpzSShtY52sEIOhgD?=
 =?us-ascii?Q?YT+mimV2nhtcxQXLdMHJak8CsAOFM70dHmkCq9WmHWF5ZNAhVm2Vjlf5mLaG?=
 =?us-ascii?Q?FiivYKasYhQCtpXN0U9X6dOkxvCBxG3Hx5JYdl0LB3AwVd6aN+XDQQUK/0h+?=
 =?us-ascii?Q?SOp7SQH5r6zsZA5er3Bs6aZTEbv7sDF8RhqxOda1u9wnglMVztoOnIEmTOxB?=
 =?us-ascii?Q?wlAGvvbvs1rHx+ygc10ADuqnzWyRP9IrnmVopr/VHhxV16QT0zA9mTsaJ4UW?=
 =?us-ascii?Q?vDZ2Dmco1Fx4qIF6RbqHtViRl91UEA5FBWt2Z/LqNh6o07FmjuxaKqhsqDrU?=
 =?us-ascii?Q?SGEG5ebFzXicx0MI8r0bRd7qKQRKZp1qACiQx+gCn2tVFHmhlbMav8/+SizO?=
 =?us-ascii?Q?NRvbNTLRRfWX+sUo+oqsZfOMNtB/SvHNPNooHlOWQB9KDmFvwL9wKKSMPehJ?=
 =?us-ascii?Q?T7Y6hNqNJhYrssTdy8o0FE68Rq0A9Suv3peGOeTMeygvjdFdF/zT1xJT86yL?=
 =?us-ascii?Q?S2MtzOH1e72p2zjYbmemgYFr5epYwRgiTkfBnrbVnR+nekQEPZ47ZPI7F91c?=
 =?us-ascii?Q?3M5iNy942hgUFrShBG5Bmp1GJG8OFQOyR6DSCWAONu06wVkkrFkamOhkNTTZ?=
 =?us-ascii?Q?VFeDyBj3qhwULC5oJKjVOIb0WhzEnA4S/kKy5V7Emacz5IrqjuubxWtdQe75?=
 =?us-ascii?Q?zRTW+QqJtMnXz5sth5B46xKnS3EFUOyhj4n0yCLybiSiBjAiFqvgdiOMQr1h?=
 =?us-ascii?Q?j7Hmx5sYNAymmw0pEYPk/Nv2OxUKv4pa34QkA1d1zSqAQewx4963eq2osUNw?=
 =?us-ascii?Q?0sLuVxgxg80JHfndj9QEbUsHlElrJIyrgCvUHuxqg3ey+hm3KQBBnNKrhKfM?=
 =?us-ascii?Q?8dg3Hscft+IDsy0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:24:42.3017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45be2ac2-1fc1-42a4-99db-08dd501f9a88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076

Function cxl_calc_interleave_pos() contains code to calculate the
interleaving parameters of a port. Factor out that code for later
reuse. Add function cxl_port_calc_interleave() for this and introduce
struct cxl_interleave_context to collect all interleaving data.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 63 ++++++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c118bda93e86..ad4a6ce37216 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1800,27 +1800,34 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 	return rc;
 }
 
+struct cxl_interleave_context {
+	struct range *hpa_range;
+	int pos;
+};
+
 /**
- * cxl_calc_interleave_pos() - calculate an endpoint position in a region
- * @cxled: endpoint decoder member of given region
+ * cxl_port_calc_interleave() - calculate interleave config of an endpoint for @port
+ * @port: Port the new position is calculated for.
+ * @ctx: Interleave context
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
+ * The endpoint's position in a region can be calculated by traversing
+ * the topology from the endpoint to the root decoder and iteratively
+ * applying the function for each port.
+ *
  * Return: position >= 0 on success
  *	   -ENXIO on failure
  */
-static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
+static int cxl_port_calc_interleave(struct cxl_port *port,
+				    struct cxl_interleave_context *ctx)
 {
-	struct cxl_port *iter, *port = cxled_to_port(cxled);
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *range = &cxled->cxld.hpa_range;
-	int parent_ways = 0, parent_pos = 0, pos = 0;
+	int parent_ways = 0, parent_pos = 0;
 	int rc;
 
 	/*
@@ -1852,22 +1859,38 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 	 * complex topologies, including those with switches.
 	 */
 
-	/* Iterate from endpoint to root_port refining the position */
-	for (iter = port; iter; iter = parent_port_of(iter)) {
-		if (is_cxl_root(iter))
-			break;
+	if (is_cxl_root(port))
+		return 0;
 
-		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
-		if (rc)
-			return rc;
+	rc = find_pos_and_ways(port, ctx->hpa_range, &parent_pos, &parent_ways);
+	if (rc)
+		return rc;
 
-		pos = pos * parent_ways + parent_pos;
-	}
+	ctx->pos = ctx->pos * parent_ways + parent_pos;
+
+	return ctx->pos;
+}
+
+static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *iter, *port = cxled_to_port(cxled);
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_interleave_context ctx;
+	int pos = 0;
+
+	ctx = (struct cxl_interleave_context) {
+		.hpa_range = &cxled->cxld.hpa_range,
+	};
+
+	for (iter = cxled_to_port(cxled); pos >= 0 && iter;
+	     iter = parent_port_of(iter))
+		pos = cxl_port_calc_interleave(iter, &ctx);
 
 	dev_dbg(&cxlmd->dev,
 		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
 		dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
-		dev_name(&port->dev), range->start, range->end, pos);
+		dev_name(&port->dev), ctx.hpa_range->start, ctx.hpa_range->end,
+		ctx.pos);
 
 	return pos;
 }
-- 
2.39.5

