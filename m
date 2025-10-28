Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013013.outbound.protection.outlook.com [40.93.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3957405A;
	Tue, 28 Oct 2025 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644911; cv=fail; b=qC8W7YftzBBzcO8pKCykzM2oeh7synWkWqWQjbZ6k1u4WGgyc3fv6Usu7LOQ3IkJt8zTdduqHlQC8swIrQLp0ousocVVL23etQIszA+cC+0AYE3Lgd+6RP1g0GJqH8NR21tYaOXZDmtIwmU2bLEo8QYAMOXeWOnu5h5PyVJUk4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644911; c=relaxed/simple;
	bh=kdAHt1PeqEoTV6Fpt2AAJHvvSKp7YhVHUznoYdDuCIo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YKC2PPPoW7l3c+5wA7/AJqsCwqWPamAXAab0lu93Oq9+NVreV2BTtK7vZe8UVLif7yuZBGbAHI3fK/cFmPLphfZDCZCSEMvLn/YOHaMWb8V+NFpidZ4bEpS97dkrUJR+eBGd6bf8lsbZbQDE5g4TG1DkregNlbeJIOp7fre/ywk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WnXR/QH0; arc=fail smtp.client-ip=40.93.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WnXR/QH0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eu+h+vQT4TxMVVo8+HdgvQ2VQNH90XAKCW9iQEQBFocoR0TGwBdi/IAV3naAM7fbTlfqrCA7ABG6W8M/dqhAPu8ESU6rDiHJgTM+tV0QVvJF7MLTWuOcEexoAGOXCFS5QUHCMxpl2Th1lLQ92KDaC3Kvl9Ys/GP+wOKL03MUpriEqRDkQtj3QNsDfqOC0pWQta8prbogIArcaPXFHzfcJNozDddXQmCSPqNMAqruuDM6O4b/Jr42SChThVDHIPa4mQBtfVwEPA2pQ/WkmcoevR1Oipm11wfdPkdWUq3TXT9xU6B/OUc51ufIwWODT2U9gb+sw4OzBaSa5CAqUHe0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcQTAb8VWyUrSlYXrgmKId2U1z9yACkCP+jVd92sF+Q=;
 b=pbN85Vb3NquIE2jV6O5ZuLke4AIlE/OhIn8kC+4zSxUzWgGQZWUOZjnl7dt+MCMw1LWnaQeIvqteJA12xtpZmaDLbn3bd/vUhHSG6DPLzPREg6/dgNlaAieM4MYncLH56J/NkXwdG3N6lxF1uUnHh6bBkXC/jx4kNixvk3oytIoKx7328aY3PNq9RAFPZiFSwFRjGW5xeRsxIlaAN8ulpmPTbElp5hwC5CUJqX7IH3mdDBQqcA2SjcyW3tuOW+EDlLAfGr+wpBveKTVuKxOfvpaP7hyS1DHL3zauQ4DsXJ6DNuS75lu6Er9FeuBRy7AXR6rQEb+Z40wJzhQRvaAZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcQTAb8VWyUrSlYXrgmKId2U1z9yACkCP+jVd92sF+Q=;
 b=WnXR/QH03nZ5AXuVFEu7tfsv8hkV0JbmArqwtzdcnWbemygE7bhK0bGnxHrmzeNX9CbZgXmn0SWFgtQO7MzRx2JuPSqC5mxgqjZs/QUl/FCQEnMga+Dv9ywl/i6O5sshlatln3lbYbrDj6GicLBs029x8sPljppP3Tk+DwqeHBI=
Received: from BN9PR03CA0203.namprd03.prod.outlook.com (2603:10b6:408:f9::28)
 by DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 09:48:24 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::e9) by BN9PR03CA0203.outlook.office365.com
 (2603:10b6:408:f9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.17 via Frontend Transport; Tue,
 28 Oct 2025 09:48:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 09:48:24 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 02:48:21 -0700
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, Terry Bowman <terry.bowman@amd.com>, Joshua Hahn
	<joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH] cxl/region: Support multi-level interleaving with smaller granularities for lower levels
Date: Tue, 28 Oct 2025 10:47:53 +0100
Message-ID: <20251028094754.72816-1-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|DS7PR12MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 4576cb39-0104-45ec-4262-08de16072330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lkssumm5M9rbZimcLV2x/9EALj6CFKCjo7BFYsD89VX79wyFA/EwsrXfZfPz?=
 =?us-ascii?Q?yycXEYtuPuLexhV/ykGEZU7rEY3EKTuhqLtZowHXpCKdV3JEvqWfG80MCQy0?=
 =?us-ascii?Q?8F4Irerhl0DLOz+M7a05edPQD3QVAP4qC+2+AOep1uJLK4QWB4GVDUtYHHh2?=
 =?us-ascii?Q?5Lqhi9CppWqzmIA3csopR3cwleNtc/pU7HvKLXlTwtyljBdkaJlrA6HjVbfB?=
 =?us-ascii?Q?bxrk3iMIt0RXXN+XH4BixIlygH4L+e7/++2SEcO7qfp9pynXgTYevBPQC35W?=
 =?us-ascii?Q?ftzuZaYH8BusWcNR/O2eiFxt/80UqNUUmuNA3l9wyCe0jv5YHsvvXs5AtQZP?=
 =?us-ascii?Q?PLZC3Oc4b1GuPKMGEya8QIxCqWuou/V8YAiIRVzQ2phKR5SJBndcuq0o1+ox?=
 =?us-ascii?Q?K7OXYg1cQNAFiUxeLV8tHwGidEUkxm8JZY4gR1/BRSu00I70Dc+qmbLjg7xX?=
 =?us-ascii?Q?9sHFeo8NhwryONV/rxewOpe4MrPF7sSrTHjko7skO3nZLIBpIKG/BteqVZ3s?=
 =?us-ascii?Q?Sa5+Jor8HHbVFh9YblAedtQHIg3ah5iKW+CvP+2T87akdn8lxZImdYFTJhF0?=
 =?us-ascii?Q?ZWBVrqb2VcbHGrD/fQ9jSqEeoFYUhFcbn1W02YLtkrkPDlDOxPwUgQr4bjMi?=
 =?us-ascii?Q?GHn6gyE8UnQr0m2+VPrixy9cSgpXVstNNQ2SetDA23YDzOYIpKF9o6i50FAv?=
 =?us-ascii?Q?2QaHr1RQ9KNu6RFEEYZ42Q1AlLTMIjdOz5B8bwGgBJy4k+2z5giMk14PbZ5i?=
 =?us-ascii?Q?91HUR91Om+WjPcXLKhYFI6FEX91uDo7jredrWHeVLTk7KJ/dKke3xe88u9o/?=
 =?us-ascii?Q?1IMqKWG4Eijh5rFbv1hSoY703vFwAjdHuK87vnEgmyb8VABSypBAbLg/y8uh?=
 =?us-ascii?Q?cR9P7hoLllOzopo4wWR5vWwJXZoxcw2QulG9iQ5O12yS+OR+fd0D06GMu3RY?=
 =?us-ascii?Q?AHL+j9r3gyAyIrmaxA4Oo05pwb3e7R108NA5Lcz8rKGelYg7tmB4RQ8ATXtD?=
 =?us-ascii?Q?85FqqxuhOZMWyuE3xVvPmjVULka+PEmryO9Q0ymUhnXjSBJzmvCBNmRc/B/m?=
 =?us-ascii?Q?HS7n9Ht295eOku9wD9Wq67RkeIUIg9YTfNPcRPsqncqG7EtPIb0U6iZ10rcU?=
 =?us-ascii?Q?s18zB/sbcRz+/z9fmHQtnoPpRiwHARhViATGCzWbd5+QuOAmqPE9WB4CSA4E?=
 =?us-ascii?Q?bv0VyAvyVIEytLYKdYcZt1mofiJoqjpO37G3R97W34fk/6ZWG/ucuxEEpoVW?=
 =?us-ascii?Q?0X5Qb9WYRLKNHA+rRgICGZl0W/r/qVARH1esraDB6U9oBLOF3/0OR1EDz5v2?=
 =?us-ascii?Q?m4ogkYd/dVR0/dUIljZDS2CtWOlkd+dRfGwHDJkJw3k/qYWmZ72iSaxk5PGL?=
 =?us-ascii?Q?6+XRgCgE5DmP4O9Z/UYeIBpHuZQPDTKUtt1lQMQUcvC6EPACXz9zWJ3qmCL2?=
 =?us-ascii?Q?zVXjoFS/fN8RrGG+alK9Qx3TyW2pWNTja+7qDZIDj/GkYKcbXrKMCTzMbKOR?=
 =?us-ascii?Q?noJjI2qs3wxMtRD52sKmdpdbUxwPSX5X4+zGtXoOIEMO6NytHGZEu94GN2WA?=
 =?us-ascii?Q?4ITqyvO3dOT7q+ze+iI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 09:48:24.3710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4576cb39-0104-45ec-4262-08de16072330
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8371

The CXL specification supports multi-level interleaving "as long as
all the levels use different, but consecutive, HPA bits to select the
target and no Interleave Set has more than 8 devices" (from 3.2).

Currently the kernel expects that a decoder's "interleave granularity
is a multiple of @parent_port granularity". That is, the granularity
of a lower level is bigger than those of the parent and uses the outer
HPA bits as selector. It works e.g. for the following 8-way config:

 * cross-link (cross-hostbridge config in CFMWS):
   * 4-way
   * 256 granularity
   * Selector: HPA[8:9]
 * sub-link (CXL Host bridge config of the HDM):
   * 2-way
   * 1024 granularity
   * Selector: HPA[10]

Now, if the outer HPA bits are used for the cross-hostbridge, an 8-way
config could look like this:

 * cross-link (cross-hostbridge config in CFMWS):
   * 4-way
   * 512 granularity
   * Selector: HPA[9:10]
 * sub-link (CXL Host bridge config of the HDM):
   * 2-way
   * 256 granularity
   * Selector: HPA[8]

The enumeration of decoders for this configuration fails then with
following error:

 cxl region0: pci0000:00:port1 cxl_port_setup_targets expected iw: 2 ig: 1024 [mem 0x10000000000-0x1ffffffffff flags 0x200]
 cxl region0: pci0000:00:port1 cxl_port_setup_targets got iw: 2 ig: 256 state: enabled 0x10000000000:0x1ffffffffff
 cxl_port endpoint12: failed to attach decoder12.0 to region0: -6

Note that this happens only if firmware is setting up the decoders
(CXL_REGION_F_AUTO). For userspace region assembly the granularities
are chosen to increase from root down to the lower levels. That is,
outer HPA bits are always used for lower interleaving levels.

Rework the implementation to also support multi-level interleaving
with smaller granularities for lower levels. Determine the interleave
set of autodetected decoders. Check that it is a subset of the root
interleave.

The HPA selector bits are extracted for all decoders of the set and
checked that there is no overlap and bits are consecutive. All
decoders can be programmed now to use any bit range within the
region's target selector.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 201 ++++++++++++++++++++------------------
 1 file changed, 108 insertions(+), 93 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b06fee1978ba..79d35def7c79 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1323,57 +1323,119 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
 	return 0;
 }
 
+static inline u64 get_selector(u64 ways, u64 gran)
+{
+	if (!is_power_of_2(ways))
+		ways /= 3;
+
+	if (!is_power_of_2(ways) || !is_power_of_2(gran))
+		return 0;
+
+	return (ways - 1) * gran;
+}
+
 static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
-	int parent_iw, parent_ig, ig, iw, rc, inc = 0, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
-	struct cxl_switch_decoder *cxlsd;
+	struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(&cxld->dev);
 	struct cxl_port *iter = port;
-	u16 eig, peig;
-	u8 eiw, peiw;
+	int ig, iw = cxl_rr->nr_targets, rc, inc = 0, pos = cxled->pos;
+	int distance, parent_distance;
+	u64 selector, cxlr_sel;
+	u16 eig;
+	u8 eiw;
 
 	/*
 	 * While root level decoders support x3, x6, x12, switch level
 	 * decoders only support powers of 2 up to x16.
 	 */
-	if (!is_power_of_2(cxl_rr->nr_targets)) {
+	if (!is_power_of_2(iw)) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev),
-			cxl_rr->nr_targets);
+			dev_name(port->uport_dev), dev_name(&port->dev), iw);
 		return -EINVAL;
 	}
 
-	cxlsd = to_cxl_switch_decoder(&cxld->dev);
-	if (cxl_rr->nr_targets_set) {
-		int i, distance = 1;
-		struct cxl_region_ref *cxl_rr_iter;
+	if (iw > 8 || iw > cxlsd->nr_targets) {
+		dev_dbg(&cxlr->dev,
+			"%s:%s:%s: ways: %d overflows targets: %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev),
+			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
+		return -ENXIO;
+	}
 
-		/*
-		 * The "distance" between peer downstream ports represents which
-		 * endpoint positions in the region interleave a given port can
-		 * host.
-		 *
-		 * For example, at the root of a hierarchy the distance is
-		 * always 1 as every index targets a different host-bridge. At
-		 * each subsequent switch level those ports map every Nth region
-		 * position where N is the width of the switch == distance.
-		 */
-		do {
-			cxl_rr_iter = cxl_rr_load(iter, cxlr);
-			distance *= cxl_rr_iter->nr_targets;
-			iter = to_cxl_port(iter->dev.parent);
-		} while (!is_cxl_root(iter));
-		distance *= cxlrd->cxlsd.cxld.interleave_ways;
+	/*
+	 * Calculate the effective granularity and ways to determine
+	 * HPA bits used as target selectors of the interleave set.
+	 * Use this to check if the root decoder and all subsequent
+	 * HDM decoders only use bits from that range as selectors.
+	 *
+	 * The "distance" between peer downstream ports represents which
+	 * endpoint positions in the region interleave a given port can
+	 * host.
+	 *
+	 * For example, at the root of a hierarchy the distance is
+	 * always 1 as every index targets a different host-bridge. At
+	 * each subsequent switch level those ports map every Nth region
+	 * position where N is the width of the switch == distance.
+	 */
+
+	/* Start with the root decoders selector and distance. */
+	selector = get_selector(cxlrd->cxlsd.cxld.interleave_ways,
+				cxlrd->cxlsd.cxld.interleave_granularity);
+	distance = cxlrd->cxlsd.cxld.interleave_ways;
+	if (!is_power_of_2(distance))
+		distance /= 3;
+
+	for (iter = parent_port; !is_cxl_root(iter);
+	     iter = to_cxl_port(iter->dev.parent)) {
+		struct cxl_region_ref *cxl_rr_iter = cxl_rr_load(iter, cxlr);
+		struct cxl_decoder *cxld_iter = cxl_rr_iter->decoder;
+		u64 cxld_sel;
+
+		if (cxld_iter->interleave_ways == 1)
+			continue;
+
+		cxld_sel = get_selector(cxld_iter->interleave_ways,
+					cxld_iter->interleave_granularity);
+
+		if (cxld_sel & selector) {
+			dev_dbg(&cxlr->dev, "%s:%s: overlapping selectors: %#llx:%#llx\n",
+				dev_name(iter->uport_dev),
+				dev_name(&iter->dev), cxld_sel, selector);
+			return -ENXIO;
+		}
 
-		for (i = 0; i < cxl_rr->nr_targets_set; i++)
+		selector |= cxld_sel;
+		distance *= cxl_rr_iter->nr_targets;
+	}
+
+	parent_distance = distance;
+	distance *= iw;
+
+	/* The combined selector bits must fit the region selector. */
+	cxlr_sel = get_selector(p->interleave_ways,
+				p->interleave_granularity);
+
+	if ((cxlr_sel & selector) != selector) {
+		dev_dbg(&cxlr->dev, "%s:%s: invalid selectors: %#llx:%#llx\n",
+			dev_name(iter->uport_dev),
+			dev_name(&iter->dev), cxlr_sel, selector);
+		return -ENXIO;
+	}
+
+	/* Calculate remaining selector bits available for use. */
+	selector = cxlr_sel & ~selector;
+
+	if (cxl_rr->nr_targets_set) {
+		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
 			if (ep->dport == cxlsd->target[i]) {
 				rc = check_last_peer(cxled, ep, cxl_rr,
 						     distance);
@@ -1384,87 +1446,40 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		goto add_target;
 	}
 
-	if (is_cxl_root(parent_port)) {
+	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
+		ig = cxld->interleave_granularity;
+	else
 		/*
+		 * Set the interleave granularity with each interleave
+		 * level to a multiple of it's parent port interleave
+		 * ways. Beginning with the granularity of the root
+		 * decoder set to the region granularity (starting
+		 * with the inner selector bits of the HPA), the
+		 * granularity is increased with each level. Calculate
+		 * this using the parent distance and region
+		 * granularity.
+		 *
 		 * Root decoder IG is always set to value in CFMWS which
 		 * may be different than this region's IG.  We can use the
 		 * region's IG here since interleave_granularity_store()
 		 * does not allow interleaved host-bridges with
 		 * root IG != region IG.
 		 */
-		parent_ig = p->interleave_granularity;
-		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;
-		/*
-		 * For purposes of address bit routing, use power-of-2 math for
-		 * switch ports.
-		 */
-		if (!is_power_of_2(parent_iw))
-			parent_iw /= 3;
-	} else {
-		struct cxl_region_ref *parent_rr;
-		struct cxl_decoder *parent_cxld;
-
-		parent_rr = cxl_rr_load(parent_port, cxlr);
-		parent_cxld = parent_rr->decoder;
-		parent_ig = parent_cxld->interleave_granularity;
-		parent_iw = parent_cxld->interleave_ways;
-	}
-
-	rc = granularity_to_eig(parent_ig, &peig);
-	if (rc) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
-			dev_name(parent_port->uport_dev),
-			dev_name(&parent_port->dev), parent_ig);
-		return rc;
-	}
-
-	rc = ways_to_eiw(parent_iw, &peiw);
-	if (rc) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
-			dev_name(parent_port->uport_dev),
-			dev_name(&parent_port->dev), parent_iw);
-		return rc;
-	}
+		ig = p->interleave_granularity * parent_distance;
 
-	iw = cxl_rr->nr_targets;
 	rc = ways_to_eiw(iw, &eiw);
-	if (rc) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev), iw);
-		return rc;
-	}
-
-	/*
-	 * Interleave granularity is a multiple of @parent_port granularity.
-	 * Multiplier is the parent port interleave ways.
-	 */
-	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
-	if (rc) {
-		dev_dbg(&cxlr->dev,
-			"%s: invalid granularity calculation (%d * %d)\n",
-			dev_name(&parent_port->dev), parent_ig, parent_iw);
-		return rc;
-	}
-
-	rc = eig_to_granularity(eig, &ig);
-	if (rc) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev),
-			256 << eig);
-		return rc;
-	}
+	if (!rc)
+		rc = granularity_to_eig(ig, &eig);
 
-	if (iw > 8 || iw > cxlsd->nr_targets) {
-		dev_dbg(&cxlr->dev,
-			"%s:%s:%s: ways: %d overflows targets: %d\n",
+	if (rc || (iw > 1 && ~selector & get_selector(iw, ig))) {
+		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d:%d:%#llx\n",
 			dev_name(port->uport_dev), dev_name(&port->dev),
-			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
+			iw, ig, selector);
 		return -ENXIO;
 	}
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != iw ||
-		    (iw > 1 && cxld->interleave_granularity != ig) ||
 		    !region_res_match_cxl_range(p, &cxld->hpa_range) ||
 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
 			dev_err(&cxlr->dev,
-- 
2.47.3

