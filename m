Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1151F2372;
	Tue, 11 Feb 2025 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267688; cv=fail; b=YfZ3Ai1CxfgqUEdVITY+pmkz4Ir7jaEm049pp2M4+V+tD33tV9EYdRISatHxiO4xOsDgVZyHLiWypTBh+CIujnuiiTL+ZD0YqhjIVcNPLoF0iRkFuCul0HU0dxN7gOTnSCAAVTPWE8V5m+QKI0D49VIJgeTnLknD8yP0gSVLEAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267688; c=relaxed/simple;
	bh=qxHs+bgFy9j4iYvEYn78kj41ih6fNm3215bEAu3c+rI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujRjb72iEH+2Jg9ZnIpZ31EVd7vJ5s5kMXlNj5Ww4xlSqs+uYNnOy8S1EAi3RhXl7zgpBCrdXE6UVKg1yN3LBBV0P2OEdGTA8grisfOBOzw4aZA5zdHv7afDIs7onWP0pSORBMFbSOm+N5prA+6mTYjIgCD7gLkQpfeR9OZTaNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2wX0EWZ7; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2wX0EWZ7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oulbfm/iFA1ht54OLXjt4WunpXQ368/G4aJZoFqufe3GUisYybK3YweBg0dLZAkJ93weHpHSLcO1M1qPqMaErPlRkc4RZ1pWVKD3ZD1KXGIwjE08/ffcMUPs9fCWVQhS1cY4kpbAyMzP5w545LtuiuFUZGcqws8T9wmUSFZBR2o35g7hncbV1dAu+vUw9fMIN6iuev4k0M2QNFCKp1w56g4hVsKyNczlHxD9ojGQNsrSI4JmE/UOz9y8brbDACfzdFml/+jsB3SAbra8UF2KnyOOenYBqC5OXR6TOdvc5eBHXMf7Jz0nDeaHHG8+NgVgYzF1J+DiSlFjT1P1oX6MdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwuBs0CXisK44oY4fbyINuNSs+vMe61qWB5UFvCIZXg=;
 b=hj3P59T4i4fXWPBS7N2x105gM68CQJD70fAZpQW/VHKtaAjjUerxo/BU06EMsfqZaSQ61K3HqfK97buUaOrwbGekUXYArJIUiMjUCrxpx11xZC7PEp3uQf/3ph7C7WxkVWfalNx+/OPrIUYoqpYq8FY5hGaOuYSz45CmUAQBZ0eYjdWlRraV6ChyO4KgQUPcN2I/6omLC7dsk1ixG7X1Id8ECf8uu/rQCRpmJlp1Y8XWRe9y8asa2FjJ0JsyAb6yD+G02XBdVRYpFn54sR7e1U3IhjdCLZrflzPf//vsIUNPYxRoZg82ezkLsYnmdlzc567fw6qhfjyeRJVXfN7iog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwuBs0CXisK44oY4fbyINuNSs+vMe61qWB5UFvCIZXg=;
 b=2wX0EWZ7yYPjDJs3kYYTrSgAkcZlRe0GRhCbl4auklWmC6Q7p4q9f82F0Xbi3JpJDpO22Lg3jbRHc0wo6k7agEQSeV3mNGCwRvnWQhgElzm9qCKBmbNnaKWD8QXbgk1ceK8iHAl/4GtQ0yGhIr5YdBdx0IO7MeS0FAU5JeKyCQ8=
Received: from BN9PR03CA0664.namprd03.prod.outlook.com (2603:10b6:408:10e::9)
 by PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 09:54:42 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::fa) by BN9PR03CA0664.outlook.office365.com
 (2603:10b6:408:10e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Tue,
 11 Feb 2025 09:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 09:54:42 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:54:38 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 07/18] cxl/region: Avoid duplicate call of cxl_find_decoder_early()
Date: Tue, 11 Feb 2025 10:53:37 +0100
Message-ID: <20250211095349.981096-8-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211095349.981096-1-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|PH0PR12MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 773bdb28-7b4e-40b4-7366-08dd4a821b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GPvUSIAuNp/CazM6AfXMUfG02llCy6UPKy6KW+P9Fnqtw/E8+6yBwndHyzyb?=
 =?us-ascii?Q?xbTRte14CGth4nzElfvoiPCKBng1JIq4I9KejJiaizls3NsMICnQqr23H2hp?=
 =?us-ascii?Q?HFEcOKoxAji4q9RcTzIY/UOJ3yGmT1cMfe5h2RQGU0+2XZ2j4mq/YcePiE+o?=
 =?us-ascii?Q?xSGSjkRx3OW19My1uNV+RHLNOan+BVxKUzui1N53PX+JwN4oF9Z5scWjNfgK?=
 =?us-ascii?Q?pAL3dxnqY6maXFdyEosQ7us22iXhbCXms2QYvUxvZQOhF189r9oJbiCR0ysY?=
 =?us-ascii?Q?4bC9rbwplujmP8rqdGkrR1LMPMBeSCIf1R5Cx/ZsQKCxduGUlpyS8qytwAcl?=
 =?us-ascii?Q?2DjBijQVz+BfasZ9eYxZCQXvC2SfNmc2imrSt77VcSnoD/pN7FkQcl6TMIoX?=
 =?us-ascii?Q?JqoDDmeJ6aSOtSkpByiSlAkMhFxp3fkZJjn6WZ946cEx+anf7ImiI6DHV3R+?=
 =?us-ascii?Q?UfWE45zVGk7wQoprGWAFS3npdH5Z8EdNYr7yLGCqugbqFqfAy0vjigr8Rppn?=
 =?us-ascii?Q?6mvQgpuef5rjZdoCtVBWTGISsQLQkag6t9KnPklmni7dS+U0UpHVrBlGtEbo?=
 =?us-ascii?Q?Il1ifBRgDwj928CDN71MQJ0SZ2u0vN2j5iCtllJlb4yo3Qn+IheBuW/6TV61?=
 =?us-ascii?Q?bmS4WxszNXosJnjFH6ODsU2trQ4CRNQUkPKVIHbqHuBO6Ot28Whq8NxhrXqn?=
 =?us-ascii?Q?zwbil6bP0y+/TjqlqBwlDj1pdZ6FpRslEqy7dr9HqPxkBIj1I/kUmePZQ/aD?=
 =?us-ascii?Q?WHOYewr4Fx7k6tByFxcR5s+yl+DdlpMMlHpCg1zv1zJk8ZV7w7sKNg3KfbZ/?=
 =?us-ascii?Q?2X5gGoJn77c4suGnDhG4jPqZ2av2Ad0q1thO+gHTCmjaCxw9fx+E1P0U3wEv?=
 =?us-ascii?Q?D/foUm9DYoLhE2LUC0Vg798jq9qZU1LUWbeMQ0ANWjAG8WplMqdtK/mmJjuO?=
 =?us-ascii?Q?sSpnJEjOcDoeUiZpOWDwYyw6ZA0jFwFZtjkDL960M5A4eD6ZyF6vgICdClCT?=
 =?us-ascii?Q?XbuPC8hdjk3WTvxoUGgZURayHTHIY4EImhjBAUd1IIg+cwfof5tbPjblISoA?=
 =?us-ascii?Q?ogbVGumxJlDnSSHRCbHbdKJa7LQOQMRGP6I15+uWRJ/8bp6YmCKfqd5xJoWy?=
 =?us-ascii?Q?iyemYdEqbdKeu2zlpkf196byV5J5E8xjYNYb2mG1owMBg0YaKBVJlqSSJClj?=
 =?us-ascii?Q?LA/sUELR2/oRydiGPMTuzZumKhVrvgp7iiE9TbB86DNIEpOhRRtGYHi7jfwZ?=
 =?us-ascii?Q?AiJ3CHhux4iiZopbPhMb2fgYFMo0MUn8uzYC1o8rbe6OaaFWjW4qj0Zq23wB?=
 =?us-ascii?Q?8v08Z+4YrDeZYxOdjaPdj6DojnQlzWXoQ8F21V0PORKpa8aVz3c6grPv+MxD?=
 =?us-ascii?Q?LF8/zu6RK/jWgY5zVKY8+WkWjLqt46vBqolUUG86Cn0i03ByKyNGnpAY6cxg?=
 =?us-ascii?Q?rwpGJ+4SmNOCP65hpEnNfHrSHY//zvi6zH8tHQlhLIrhTizrMX9Zqi6OiSC0?=
 =?us-ascii?Q?SFLzutblTtjn+cM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:54:42.3067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 773bdb28-7b4e-40b4-7366-08dd4a821b7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7957

Function cxl_find_decoder_early() is called twice, in
alloc_region_ref() and cxl_rr_alloc_decoder(). Move it out there and
instead pass the decoder as function argument to both.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 13e3ba984a53..b8201c2faa87 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -908,7 +908,8 @@ static bool auto_order_ok(struct cxl_port *port, struct cxl_region *cxlr_iter,
 
 static struct cxl_region_ref *
 alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
-		 struct cxl_endpoint_decoder *cxled)
+		 struct cxl_endpoint_decoder *cxled,
+		 struct cxl_decoder *cxld)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_region_ref *cxl_rr, *iter;
@@ -922,9 +923,6 @@ alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
 			continue;
 
 		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
-			struct cxl_decoder *cxld;
-
-			cxld = cxl_find_decoder_early(port, cxled, cxlr);
 			if (auto_order_ok(port, iter->region, cxld))
 				continue;
 		}
@@ -1008,17 +1006,9 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
 
 static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 				struct cxl_endpoint_decoder *cxled,
-				struct cxl_region_ref *cxl_rr)
+				struct cxl_region_ref *cxl_rr,
+				struct cxl_decoder *cxld)
 {
-	struct cxl_decoder *cxld;
-
-	cxld = cxl_find_decoder_early(port, cxled, cxlr);
-	if (!cxld) {
-		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
-			dev_name(&port->dev));
-		return -EBUSY;
-	}
-
 	if (cxld->region) {
 		dev_dbg(&cxlr->dev, "%s: %s already attached to %s\n",
 			dev_name(&port->dev), dev_name(&cxld->dev),
@@ -1109,7 +1099,16 @@ static int cxl_port_attach_region(struct cxl_port *port,
 			nr_targets_inc = true;
 		}
 	} else {
-		cxl_rr = alloc_region_ref(port, cxlr, cxled);
+		struct cxl_decoder *cxld;
+
+		cxld = cxl_find_decoder_early(port, cxled, cxlr);
+		if (!cxld) {
+			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
+				dev_name(&port->dev));
+			return -EBUSY;
+		}
+
+		cxl_rr = alloc_region_ref(port, cxlr, cxled, cxld);
 		if (IS_ERR(cxl_rr)) {
 			dev_dbg(&cxlr->dev,
 				"%s: failed to allocate region reference\n",
@@ -1118,7 +1117,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
 		}
 		nr_targets_inc = true;
 
-		rc = cxl_rr_alloc_decoder(port, cxlr, cxled, cxl_rr);
+		rc = cxl_rr_alloc_decoder(port, cxlr, cxled, cxl_rr, cxld);
 		if (rc)
 			goto out_erase;
 	}
-- 
2.39.5

