Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5475B269AF4;
	Tue, 18 Feb 2025 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885091; cv=fail; b=DDKxdZOoSmzMYdYwriZvTrHqYQwnkzvbHreMV2s0w4Md75MEhR2M7TAkxYnZ0/dWiNt7YtQTpKE+VQSSFZyD6yzi2qpja39DRqTZLYM9gJpiuKYS7kK2jdVmw3fJQD3nm7d3KEcisYuxusgE9yikCGopGnw+x22DbLygKy0aoYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885091; c=relaxed/simple;
	bh=yOzdNh6zIBv1cljNrqquojJGYuAmChUnnnMQsE6eWS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnLXPMMTpdNiELln00IMwrTQDE6IGaeSxmdow4I5dqYQMT8EltDD6B0/66IjNsBYLNdy+mOgfy76dYmZS/OLIytkNC8iWM13w9pRm6MYmFdD5n2amv3jUwitMeTEZaNWPfsYSzn5bt00JTxmnXd4Zr0DkvIDZJO9iqf3QhYbEU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GmDTYbJe; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GmDTYbJe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihQp0NikUgc3qFjecBP2KoxV+klE8GD8AkQ9t3/8Lug5A7NFPbfX673DIvBjRtXHS5iQYTO6J/kEhPeyTNWN1C2EqTHH15YZXD82KGfb2CnvuDFbL81+3Zrpfs+tbCv1x2MEKhcDYH9di5SM7kyGp7Ng63G2Me8lby1Mi1aD7frZR2if0v8JZJZexfVo0ADbRmX3fM84Hq0L/OU2rWHKNkNuhTbE48Q3D3RUkL1TnVPVEuJOy7FTf0fHCbab+Nnr59MdJ+FcHr40ayP1VLxdBAof24+8gt/Y7RW66tb2DlmJIpKuHLm5UboJmkT0tK8jqjIKrIShN8Os8TWThcttfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUZQwfZPFZtIrKfViZyjKesvVL0dnbgLW3sHWp+YEoU=;
 b=lc02U/iPYMCsxI79UK1+4mEu93RzyGSR+tONvRDYNtWvprWAW699ymCGIssfWjhoeB7JUYH2NXF2MzFrVbcZMeUVIiJBEZwF15kfqgJvTj9EhJ01HeBIl1FKXDKqeUoDt5ViNhfKjAj9y/DtsQO/yWv0Ju0q+GOy1205jjluXHZ7ZkKYA42i5dv84JhKCG2AlRRKWGQgAaeULE4f0BaCkqrpbMBVIo4Aolr++FDA02OBbOsmg7IDj+cBGiStnCH+rD92Bkp+8WL+L9SvoldAl6ih0jVYT6rMt1N8LxT53LKEr9i0OrjsSA8UFTVWlwJsTevszpWXbM/RefTXdJ5vKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUZQwfZPFZtIrKfViZyjKesvVL0dnbgLW3sHWp+YEoU=;
 b=GmDTYbJe6rsuqv07nplzjTL6Z25cVTd9z5KqYO1X7str217WzYAr5+J2lg8kU+Ftvgt2XasSF2XWa+SQkkdjWZ2tiZ2aCIeYiOPrUwITl0Go3nwaUNEhdctIH9t+bSRfEebjW8UuUmBMP6oNIuU+sRkEB8D1TL8M3dHEXkcsG3A=
Received: from BL1PR13CA0016.namprd13.prod.outlook.com (2603:10b6:208:256::21)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Tue, 18 Feb
 2025 13:24:46 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::d5) by BL1PR13CA0016.outlook.office365.com
 (2603:10b6:208:256::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.12 via Frontend Transport; Tue,
 18 Feb 2025 13:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 13:24:45 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 07:24:42 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 04/15] cxl/region: Calculate endpoint's region position during init
Date: Tue, 18 Feb 2025 14:23:45 +0100
Message-ID: <20250218132356.1809075-5-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: bb1d637c-336e-4408-a2cc-08dd501f9cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WJy4tWtBBhXI+ICZ4ZBR3tBDeb0g2qCIU3yZE17PTrR3yeryyyKDMUQ7rwH0?=
 =?us-ascii?Q?d/eDd0F14cDGbDhjhoDu2g+FUXLStHzYnmLq8fmat7No81N5JRZLRWopVn0F?=
 =?us-ascii?Q?RzlL5Lj6ZRLFVCayEUp7UMbtmtdDWG1UiVdf5RB91clDLKH4W0Rc7gvrzuLF?=
 =?us-ascii?Q?yANv4mim23OYG3IfW4Jxj2CSAwVJ9cSlv0Di6y3sKZLU5xeE4noIEFR7xJ4B?=
 =?us-ascii?Q?Q4hZTA/mVR4QaL9OjADJxZvu3VhV/7/ImDUUiQ0c5J8vwYotLSzNBCAO8aof?=
 =?us-ascii?Q?1r/jNx7gXUaZoXLtdLauj21dGnz2A1yUUUKaAMFEgXpLGJGzn4U+CoYLVwmN?=
 =?us-ascii?Q?35VyECh4nXi0wVqcBf0o9CvXeQY9Lq6i/oXyXSBBN3XNEssWz/W897KsC2eV?=
 =?us-ascii?Q?sIv3UsGJLGip3csTpqz9g4yW66+wvvpR6fmSxjatpHTwcl767A/dnI9m11p1?=
 =?us-ascii?Q?vHMquJrA23XfXR6XRZqA2LVvQYZbUVBBlOuYFxdMuFgr134doVBhaLQQdVXS?=
 =?us-ascii?Q?kCJggViGs5YIEggfu83Pp69KrQ8Uqo4swul+F7P/IIM8TIiLB0u/VIuikHmt?=
 =?us-ascii?Q?yM6+Cr4WhhRdgUtPgdF1bqqBan3kGgsz88aK5G/MMTF01Rk3h+ia5p3XDudA?=
 =?us-ascii?Q?hyddpDsF0yRbbREsOLJXwEcOHXhXCE8+2LYlhfMbdUNzkLLTsLCRSOSh9ZFi?=
 =?us-ascii?Q?NrMWUcpD8YDpHb8L7PmXz7XgAzUb6cQise9lIqNVzqssdzG4CmXaWjoG3xvJ?=
 =?us-ascii?Q?b58aDBMstE3b08GX3ReyIYTCQj4HBBAj4koP4qV/VY4fsOTzDWW/v7i1ZRNB?=
 =?us-ascii?Q?ywRO70lspgw0mW0zBN98BlSBsFlgEcDFV26vyRf/sOXUy7+t47Dgj1OT/5YM?=
 =?us-ascii?Q?bHnuam8xAQ86/SRl1VNJdYvBLP4PbJLaOHD9ffWppLk841T/LsMdedcrPfKf?=
 =?us-ascii?Q?wqWBh1uRv/a9KU559VVmG+foHPY7CI41GUMD36422ZYe6JHeJmzF3hXhD3WO?=
 =?us-ascii?Q?tScX7iePTlpTFVLhijpiezOQ5Ilrjnfv7brIaSirR4sg6anFP0FLnc0mYbpH?=
 =?us-ascii?Q?nbQ/YrZcJST5Y65nyRvbQWUh5n2HWev46+qiMtoTVxYaXkIg05//cJLwv7/X?=
 =?us-ascii?Q?LMk9/X8XJ6y6jkaXFuJHOAaY+wtHvVt83yQxnWh+MQrrFLyVh8m0BF25qJy5?=
 =?us-ascii?Q?/9FcrRo2ciXafJXI/PJ6mXyKsutdRo4p1OphCO+kv56MJPsOfIhdC4z2krpg?=
 =?us-ascii?Q?jOe3Qqkt7fA/JJga1uJa5NF/zcS0hygbJcBRf7u4uQFiZ0sckaPYk8tNMyVh?=
 =?us-ascii?Q?HUpryWGINfLS02zCxfv9DrxYQjRVEDFS1Qguk1A7q2IhT86bcHIRlNFKGp7I?=
 =?us-ascii?Q?YYYeWG3ACh3X7nr5u83ZF+QvmEOmfiqSoQ81s0Az3ckui+dywwW2N0AqBtIX?=
 =?us-ascii?Q?/2fUCAWEjjghe8P3C0ea+t6a5aNxPT59xB6/bZZj0p2k/VDH2wu0v0zHADyx?=
 =?us-ascii?Q?ZIEQNX3mufpIqB0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:24:45.8777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1d637c-336e-4408-a2cc-08dd501f9cac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313

The calculation of an endpoint's position in a region traverses all
ports up to the root port and determines the corresponding decoders
for that particular address range. For address translation the HPA
range must be recalculated between ports. In order to prepare the
implementation of address translation, move code to
cxl_endpoint_decoder_initialize() and reuse the existing iterator
there.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ad4a6ce37216..6f106bfa115f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1903,7 +1903,6 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 
-		cxled->pos = cxl_calc_interleave_pos(cxled);
 		/*
 		 * Record that sorting failed, but still continue to calc
 		 * cxled->pos so that follow-on code paths can reliably
@@ -3264,10 +3263,22 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *iter = cxled_to_port(cxled);
 	struct cxl_decoder *root, *cxld = &cxled->cxld;
-	struct range *hpa = &cxld->hpa_range;
+	struct range hpa = cxld->hpa_range;
+	struct cxl_interleave_context ctx;
+	int rc;
 
-	while (iter && !is_cxl_root(iter))
-		iter = to_cxl_port(iter->dev.parent);
+	ctx = (struct cxl_interleave_context) {
+		.hpa_range = &hpa,
+	};
+
+	while (iter && !is_cxl_root(iter)) {
+		/* Convert interleave settings to next port upstream. */
+		rc = cxl_port_calc_interleave(iter, &ctx);
+		if (rc < 0)
+			return rc;
+
+		iter = parent_port_of(iter);
+	}
 
 	if (!iter)
 		return -ENXIO;
@@ -3281,7 +3292,13 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
 		return -ENXIO;
 	}
 
+	dev_dbg(cxld->dev.parent,
+		"%s:%s: range:%#llx-%#llx pos:%d\n",
+		dev_name(&cxled->cxld.dev), dev_name(&cxld->dev),
+		hpa.start, hpa.end, ctx.pos);
+
 	cxled->cxlrd = to_cxl_root_decoder(&root->dev);
+	cxled->pos = ctx.pos;
 
 	return 0;
 }
-- 
2.39.5

