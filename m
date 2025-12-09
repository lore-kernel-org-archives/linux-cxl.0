Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011047.outbound.protection.outlook.com [40.93.194.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28693016E7;
	Tue,  9 Dec 2025 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303707; cv=fail; b=MKe2MXcNOy076jOHPHYJ77dp/jNpS/uZgiLlW542VYcEoTbgvC/VATW4/3DAHIU9ZWniC+GOLoMdTEzD2hgUpLsjIbYgJpNH8gvSrhjX01FmduYdspU7uxAT3bmRzDvAGdZQqL5ijvxtKdEznmor0tx3nRDf5vFIh2vyU2wGGQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303707; c=relaxed/simple;
	bh=srnczzczdUjjsiZ5m3qxogQ+ykFONUf5frkRiyHgtlM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lca0O6U+sN39S9MGAAhg2aA2rWUeayNDIg4LiwNlpUjUiIz4Dyn4iBv11AG7pre+WH3CTSwJe4dBY8pb2kDFxQR1hJG6WHS3LqXkDZZ3ZHrv+HZ10oyHw3ZhjhQT7BsfC0ev6qTmo8U1bUsDMXD/2VYWlrXux51kmk+hEA4A1QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UL2j2YY+; arc=fail smtp.client-ip=40.93.194.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UL2j2YY+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFYUSuowflaqkD/icwMhXtGZtKMaesPMMKUr9D+U9WwXX/aWOcaNFLQfdlGJNrtver9b/kt2PVF2SlGL73UvEV6qaIb/JD8GDMIxrZOiLc9SLgk0Q1rxSySxlg9DCIOyA1dMWfdn/twkeOql4qmbdsIP6dJvPLT5qamwGVdpg4DEDdgDyUdw3zvWf4wU3srAd93XHcMLSNRI7uI9Qu752Isf8Y65/wp67GVB5aKmdXRXHPI/dMIpDE05DDzMiQX6cSWq0ieNrLczLUwLZuO1X0wp+LYuBCUwizVzq/zEcDe0KeTRpRcxZMQps6XFAwGs98WMvlyUvVQWj1Jvnz4/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zb4EhTCbleBssuKGDmQqVQcvRPB/ZWEO54hBolY34Zg=;
 b=EfZO0p0smXafc/SpYOYek2I1ZUmtsognPZ8Ia6LZXIZXpgpEtOMaVgYXnXwBeMikU899f9AuqN76nlCT7HpmTbC4LI5zaGd3nPYxAPq4Z/CHXelpQOF52FZylPoiFkUbc+yYvXRdQoMZL/8TY0u+vMoLYFJWrlCNB83S7YtZ2CQCxJy1shg5Cymg76udLnDo81sGv8Ghbx7hfoosErmc+ejIfZKyARDv8exj5VOy0plrZABvvaaTKmlDafdpfIOP4GcO1kco1KG33eivxfySEbsTngZzIZKs784SVPm+zLAy3gVpmR4P4H8cLuU4mcRxBvyYX9/L8k3rtuc24UKKzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zb4EhTCbleBssuKGDmQqVQcvRPB/ZWEO54hBolY34Zg=;
 b=UL2j2YY+8T6fFB3qr5Fh54U5KXuK6B+KkLYo6tPJGdJ7is24fBPtcaYfyrInKWzkzZ3Ex63kM4zxUjcrG4V5GAJvulyJ2a/OhGiLlim6XXuT9Yu36UjGmYFmQNIPGmyBf4nnTAu98x4AyVOsyqeSpRETMTCFb85LISx9WzyAdNQ=
Received: from SJ0PR13CA0063.namprd13.prod.outlook.com (2603:10b6:a03:2c4::8)
 by DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 18:08:20 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::ba) by SJ0PR13CA0063.outlook.office365.com
 (2603:10b6:a03:2c4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 18:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 18:08:20 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 12:08:17 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v8 06/13] cxl/region: Add @hpa_range argument to function cxl_calc_interleave_pos()
Date: Tue, 9 Dec 2025 19:06:42 +0100
Message-ID: <20251209180659.208842-7-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209180659.208842-1-rrichter@amd.com>
References: <20251209180659.208842-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|DS2PR12MB9750:EE_
X-MS-Office365-Filtering-Correlation-Id: d8259a6e-d933-467c-c270-08de374def8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EcNj3T200DBRYjL9Dupj7NjnxTKIlsr5Whgfy80QPo5uRqMC+EqiTKFpvaBt?=
 =?us-ascii?Q?5HCB7FLV53cw3I9F2nZ36Xent6rX9KhV+VvwVu+nSy4zksqrN2iOV4JmdwcY?=
 =?us-ascii?Q?PX9hnnPUoNCyeJXDAPtNiGbUP3Wc4/knS6ozAW7zjJI26ADkib2PFva50E6s?=
 =?us-ascii?Q?E7BLNPuGs+hJGeFwkLY7Fhhq4dlXrjzeLeHMMNs6xWN3jQtJPdTL7MBTUQd2?=
 =?us-ascii?Q?O8ejMTmZEAWnCetsfYPrUdEPcj/AXFunfAxkBGx9Mn4oL03reSiJ8eHz8m7c?=
 =?us-ascii?Q?+/m18gGK8cD+wKtbOQM46ARMqd0XArZHzH8owIxi2CC4yNtSWsEM2Pw+My86?=
 =?us-ascii?Q?rXvz+un+IBrgXcovoq1IYgyMXHF/FwDi8goAwf1idDVQCGe9HEponhBarcQZ?=
 =?us-ascii?Q?4XmbUIi10PfkPgRdtObYiO/+VA++bCGgE4NNxJSujXNAhhT8KLGzyDPUfuLc?=
 =?us-ascii?Q?jkn0cGnmJoNDu6oRxIL99Q+JNLgCozPb5XImBdO463h1AL9Sh9kTNvuoZJyI?=
 =?us-ascii?Q?EgwMexLhFEdT/qip8nd80xIfEubqBFGcGKMXUwTh1JZALFzPg5Y6f0YXl6Ny?=
 =?us-ascii?Q?n0pTuKPtOK2pJ6DuuGy78EzFdNUs1rrjxakxGZkWn0liLtLihflu56JyvYwX?=
 =?us-ascii?Q?3vEihbnnXnus7TKf3POtn6qoJWzqxKWPTkeXQhBmbdCKST477XzQB9QkZbQF?=
 =?us-ascii?Q?e95iKpE016fk+tXROLxZNFOiQZsiksf8taN32EVq/pkVtCma6dwCj19kx/s8?=
 =?us-ascii?Q?u4cNLrpmy700sq55VFN+8up9tUj7GrbkxXQZFb39J4Xt49KTRlrMi/GxE5mL?=
 =?us-ascii?Q?XO4jfU55PaVjS30Lubo6gYRtTwUx/6PL9fr96DJt5o7/EvssZrXilGHV5ZFZ?=
 =?us-ascii?Q?5Pqw9k5mrEKtdej39HGQuTyJrj5q78K2g0rhT2ey0KrNpnyWR1i0lSVtXehj?=
 =?us-ascii?Q?wJpw2yuno82Kv5/80hCx2rVXRySE2rFhKCLr61ASzADeueMiaW2w3zalazEF?=
 =?us-ascii?Q?7cQHL/1cDHclHJAZ0coOjFNS/Mhnd6XiAxM286+HYj0waq8R3hgQr+8fDfmo?=
 =?us-ascii?Q?DAK5JI+ZQH3LvTeSQ0Pu3wwXa/deQhONXM0qt+DL+T6qQ/qbPdoavpFapBY+?=
 =?us-ascii?Q?CbsOUiZg0n1LIvgcGC2YhPcSYSb2e5PSayqba5mNOCAff2eq39H8wMO0VOMt?=
 =?us-ascii?Q?/Qejo9VsazxYy26Z009p1ZcWvPgvrSRN2P3Eg9bZg2O3+gHfgK0qJR9nIAS9?=
 =?us-ascii?Q?vXcOscBspCm7fCBJU92bH8+5dmrT/qPRbnHc7qLxoHaiTBgrfy0otvtZfkVY?=
 =?us-ascii?Q?Z24xr+yM7/5jKZ91LqMWhhH3VtADpqmxhh6ZFgLo6+5dO8tBZ27XNkfK97gV?=
 =?us-ascii?Q?tpFx41gmAbkJ0miVANEtu2/r9l5AcX/fZmVKdijD2cAYyOsqXd14Ng+4sedq?=
 =?us-ascii?Q?vVcfqYhSrlVwlm6672oNrKAvPKX+oNVwMNE3xpUDFxYyqWWSG8pJmjQnpmaS?=
 =?us-ascii?Q?1njXXRUv10znl+2M2Zr2s70OdtGb47g8+kT4AdorwePNNW/qzTt1zPC9MLz4?=
 =?us-ascii?Q?Smg66mvQysZc/CSiBuI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 18:08:20.2848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8259a6e-d933-467c-c270-08de374def8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9750

cxl_calc_interleave_pos() uses the endpoint decoder's HPA range to
determine its interleaving position. This requires the endpoint
decoders to be an SPA, which is not the case for systems that need
address translation.

Add a separate @hpa_range argument to function
cxl_calc_interleave_pos() to specify the address range. Now it is
possible to pass the SPA translated address range of an endpoint
decoder to function cxl_calc_interleave_pos().

Refactor only, no functional changes.

Patch is a prerequisite to implement address translation.

Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index dfb21e8b8fb5..71e80223f475 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1875,6 +1875,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 /**
  * cxl_calc_interleave_pos() - calculate an endpoint position in a region
  * @cxled: endpoint decoder member of given region
+ * @hpa_range: translated HPA range of the endpoint
  *
  * The endpoint position is calculated by traversing the topology from
  * the endpoint to the root decoder and iteratively applying this
@@ -1887,11 +1888,11 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
  * Return: position >= 0 on success
  *	   -ENXIO on failure
  */
-static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
+static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
+				   struct range *hpa_range)
 {
 	struct cxl_port *iter, *port = cxled_to_port(cxled);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *range = &cxled->cxld.hpa_range;
 	int parent_ways = 0, parent_pos = 0, pos = 0;
 	int rc;
 
@@ -1929,7 +1930,8 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 		if (is_cxl_root(iter))
 			break;
 
-		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
+		rc = find_pos_and_ways(iter, hpa_range, &parent_pos,
+				       &parent_ways);
 		if (rc)
 			return rc;
 
@@ -1939,7 +1941,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 	dev_dbg(&cxlmd->dev,
 		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
 		dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
-		dev_name(&port->dev), range->start, range->end, pos);
+		dev_name(&port->dev), hpa_range->start, hpa_range->end, pos);
 
 	return pos;
 }
@@ -1952,7 +1954,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 
-		cxled->pos = cxl_calc_interleave_pos(cxled);
+		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
 		/*
 		 * Record that sorting failed, but still continue to calc
 		 * cxled->pos so that follow-on code paths can reliably
@@ -2136,7 +2138,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 		int test_pos;
 
-		test_pos = cxl_calc_interleave_pos(cxled);
+		test_pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
 		dev_dbg(&cxled->cxld.dev,
 			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
 			(test_pos == cxled->pos) ? "success" : "fail",
-- 
2.47.3

