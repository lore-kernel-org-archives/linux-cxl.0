Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F831326949
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 21:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897338; cv=fail; b=mENpcqXc8ap6oQgIfR+J4h9rcFgUev8TjSte9vR7ejSDaj8Za2eQM4hR2gbL/136V4u5QcdWxGgWKJmVFzIjCiQlEnbYHze3BhNjtYV9AtwvA+6D9kFsl/Trethza4mnsHykdBs6H0Yk9oPM9O2rN1tyBWErr9/Suk7pOlpIvZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897338; c=relaxed/simple;
	bh=T+z38lk5/Wgd4iC/9XOq2q+t5I3czdY78N7WeFUJQ8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7pSZaegJelVg/yErv+Ez9X4qOIpCCruKKvytw0To1Qg090p4GsZeKtAY9G2OkU33ElVE2jYnypIxQ+GMdRV+nNtHpTnFzTscTvj0xZcLoInaPCJ+Mo0oU1XGOdLYb0CdhsWUiWb8pII1uDN0j4nQIMtzYtpgTjQeYSTlUpcQW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u3zeOQxM; arc=fail smtp.client-ip=52.101.46.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u3zeOQxM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAmu54YQZkFFIGoKQghCrrNShxdnj672wbdubPCFE4N3quDkjoy/Vl+SWWg7S1ho+9IAL8nTqTI7T9YqO/7Yo2sC0Q1W88LNj1cBlKlWmGIGRCpOMnaImq5oJDmsVnEd8ZRAxns2yIFMz6hUh8cBRWkUBpgGsjiC+YWFO1EWW0EyzZt1+IT7W5PlqpRgpdrXbl8w89kAm4/p/SsoPD2HaW/zYeUdB0P2j2cSFDKEYzPXnF0pQ8P6WeU+olu4G3miysZ8W+jEZg0IpdTYiU7TVB/VkcgMQ/Ki/U1fEy1oqT8zzn7EEI6BNKQ+4dQc/Xe7DPcFeBXhOkh6JMVHLrlQSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wq9bFXBvhsZGYJG084WMBNaLhsCijxy/Mnmc1Yl8MZE=;
 b=pZ3fT239T6suFYapNC5AzIxz6IYE98z6aKVRFvPvsILPPUH0sSIVaK+qxRkdU/ous7aGHYjEm2fO1I3QBVnBdTNjndkiy0UO1GUUzO6EX/Q5fJVTHCA328hvIUWieoIOF/MNnD3xcg75Skv8ryTAghY3NZOj4qpLFAlgWyvJr3P1aLZzhmo8O8RkeqY1E9DUIYo5zYRhIvqNaCk0N4sKVpdwUonH3w5jJ/Fazec2x51TzL0GtQnZhN8F117ry0hQ3S99l/WsGTbOvQ3gfb2LzGgMU0h623shSQ2n41a+EcxKdb5s8q5eys2aVqcDWcI4/ohuL9d/IY7m/Zi1Als7UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wq9bFXBvhsZGYJG084WMBNaLhsCijxy/Mnmc1Yl8MZE=;
 b=u3zeOQxMq458c9OZ9sOT29jOPpvcgX3K0fcl9OE0vPRrAr8YsMmimuyXlku32j1/eixf4wppPcVS6+sWxIJ4j8gPzNgkfOPeUqEipzqsbJHov1ltjXfyiBwhMKd548XtvYoXZ2FP7yJFRXitLriniiy3hxZz+/TeR4wJub4Qmy4=
Received: from BL1PR13CA0366.namprd13.prod.outlook.com (2603:10b6:208:2c0::11)
 by BL4PR12MB9477.namprd12.prod.outlook.com (2603:10b6:208:58d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 21:42:13 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::c0) by BL1PR13CA0366.outlook.office365.com
 (2603:10b6:208:2c0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 21:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 21:42:13 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 13:42:13 -0800
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>
Subject: [PATCH 07/17] cxl: Change cxl_ep_load() to use struct device * parameter
Date: Tue, 11 Nov 2025 15:40:22 -0600
Message-ID: <20251111214032.8188-8-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|BL4PR12MB9477:EE_
X-MS-Office365-Filtering-Correlation-Id: e93ea800-1a05-42d6-467c-08de216b2d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w2/ZHi8/0HgZXW8mXvP9WwIXWzMZLh2URAJjEZRobmE8Y0mIm/hIYIbmcuqk?=
 =?us-ascii?Q?+bSoiENStTqlK8sSRlM3p3tnzA/x5XLE77MJuL9dWkKdQbBWdLwCidsHpeHF?=
 =?us-ascii?Q?IhUJOzqDuL6dJShqZDW8E17V7rZmF0wONH/ll4zRRC/B6SgVVMLOYksvjXrN?=
 =?us-ascii?Q?gEdLBPdXUtlR35LCgygLG0CfRX3YVOTs2oFGJ9K0AetyHdiRWWurh4Ts7YFV?=
 =?us-ascii?Q?ugLUbaF2Z4sUipmOnBN14/A7rgirR9hnrzwWylcKeYkm8rMU7UizaAysvEb/?=
 =?us-ascii?Q?RASEELAU0FBPQVybPEM6CjU3o7aIeeefE3gSncfbQgv9oYwzR0q5VS6Z/q/w?=
 =?us-ascii?Q?/D4kz7wwSIw92fcOXy/Cnfpl35OhdzFfv3XA1G2kyWnfU2OpanPEki2YF68p?=
 =?us-ascii?Q?nkA7JnLCYy69U6gioW536fxBps0OA0qVWiiMVllKkCW7v+UVDl6X8ND1mUbn?=
 =?us-ascii?Q?rfzgry2fX6+ehfs0qfmgC4dDisC3x/xwRSHDTRBSIoD6MObLZzVwAZLYC0zP?=
 =?us-ascii?Q?xK/dYAYR+dxVbQ+aX76/6VpLsAVllUnyXkf54iEn6C+bQsOI0AMwGEzgTLux?=
 =?us-ascii?Q?MB3LUCZeJv7qDToLCSpOYNl0HxKsZKIZrRk0pYk/jPDaPIT6AKsOZBHG0AGS?=
 =?us-ascii?Q?8dAKOxiAKbz4G9RIMwf7AGmVOOmde+ZGnW0zUU1wyyu7ClB7E3W55U2eq89m?=
 =?us-ascii?Q?MvtP3KXCMG+XShZbDMj2Bewth5DbfPuJKsKwBZpSkjy9vz3IimiMGVvbOGaE?=
 =?us-ascii?Q?lrRzCxYePDmYcrMOX2QlcbEJIMkhVBz7nSKgNLScxZ4kfU8+rE03lmWf5zyT?=
 =?us-ascii?Q?7VIAai7MBdzYnaw2G3J9jQNfa+wNQT2N6NdOJ+qzeko2LkvdJ4HDapK7agK7?=
 =?us-ascii?Q?RvzTN8u7W3ni7J8LxA8DuizFszX7uCbtDdoyUelBhsZAXs/ZPFFWpXp+6PXo?=
 =?us-ascii?Q?1iSSLqCujZyeoPusD5J8U2mzt4RIISqL5P1gDRCCHZ2c3mIA0Gh3JcD6AC3u?=
 =?us-ascii?Q?nROI5NE9H2S+KYAA/7x6fJDwQan5iCA5uumaOVGapi6qtFoAhP1sUEWuXdPg?=
 =?us-ascii?Q?+Q7eoPv/vZO7OzORb4o2vtDCmvqF50jsY/BOgLFSM6ifwm1nV27aic5ISdA4?=
 =?us-ascii?Q?MCIO8lMD52RrOaaxHFeQdi83nO0iCRxVjd7eUe/x0VuzsrvvhuLoNbLD0Bxf?=
 =?us-ascii?Q?wtJRBIdHlcv4UJeo0wFwMueyXOoaZ5/2KwFlXCqVejO3HVEv0Zm0cXBFdHIg?=
 =?us-ascii?Q?0g49rV0UvObkL5k+KhTGwYD+yL9prScc4vMIAo03Ee1JDlfhRKAo4ESLcU/D?=
 =?us-ascii?Q?4laFhC2lqwbl9A5PX6hfH3cLerDO//3IcjwUN/2a2A7YcIxf9Jkfk+OkcpXK?=
 =?us-ascii?Q?WsrKi4ey+UeD69Bs5gg26jyRFXjo6XZjlB2+1C7+HDOtA9LCnJz8Ecs7vGNh?=
 =?us-ascii?Q?9oz1lwBfYLhXsrwucBkBplFDQPeeOdyN4u2nY1+TG9dd9yWqY+nb183l6Vsi?=
 =?us-ascii?Q?7gwUpYGKzmjbLR90keafLL0Ntsw+5g0XcP1pqyMh4bB/7S0OWq6ZSMoAt+BL?=
 =?us-ascii?Q?c6abYP7rLxD+kS8mvEM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:42:13.8466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e93ea800-1a05-42d6-467c-08de216b2d54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9477

Once cache devices are added the devices stored in cxl_ep refs will no
longer be gauranteed to be cxl_memdevs. Change cxl_ep_load() to use a
struct device pointer to prepare for this.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/port.c   |  4 ++--
 drivers/cxl/core/region.c | 25 +++++++++++++------------
 drivers/cxl/cxlmem.h      |  4 ++--
 drivers/cxl/port.c        |  2 +-
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 4ac8f6f83d80..2cccce49e3b4 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1480,7 +1480,7 @@ static int port_has_memdev(struct device *dev, const void *data)
 	if (port->depth != ctx->depth)
 		return 0;
 
-	return !!cxl_ep_load(port, ctx->cxlmd);
+	return !!cxl_ep_load(port, &ctx->cxlmd->dev);
 }
 
 static void cxl_detach_ep(void *data)
@@ -1505,7 +1505,7 @@ static void cxl_detach_ep(void *data)
 		parent_port = to_cxl_port(port->dev.parent);
 		device_lock(&parent_port->dev);
 		device_lock(&port->dev);
-		ep = cxl_ep_load(port, cxlmd);
+		ep = cxl_ep_load(port, &cxlmd->dev);
 		dev_dbg(&cxlmd->dev, "disconnect %s from %s\n",
 			ep ? dev_name(ep->ep) : "", dev_name(&port->dev));
 		cxl_ep_remove(port, ep);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b06fee1978ba..53ed3acbca30 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -265,8 +265,8 @@ static void cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
 			iter = to_cxl_port(iter->dev.parent);
 
-		for (ep = cxl_ep_load(iter, cxlmd); iter;
-		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
+		for (ep = cxl_ep_load(iter, &cxlmd->dev); iter;
+		     iter = ep->next, ep = cxl_ep_load(iter, &cxlmd->dev)) {
 			struct cxl_region_ref *cxl_rr;
 			struct cxl_decoder *cxld;
 
@@ -327,8 +327,8 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
 
 		if (rc) {
 			/* programming @iter failed, teardown */
-			for (ep = cxl_ep_load(iter, cxlmd); ep && iter;
-			     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
+			for (ep = cxl_ep_load(iter, &cxlmd->dev); ep && iter;
+			     iter = ep->next, ep = cxl_ep_load(iter, &cxlmd->dev)) {
 				cxl_rr = cxl_rr_load(iter, cxlr);
 				cxld = cxl_rr->decoder;
 				if (cxld->reset)
@@ -1013,7 +1013,8 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
 	struct cxl_port *port = cxl_rr->port;
 	struct cxl_region *cxlr = cxl_rr->region;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
-	struct cxl_ep *ep = cxl_ep_load(port, cxled_to_memdev(cxled));
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_ep *ep = cxl_ep_load(port, &cxlmd->dev);
 
 	if (ep) {
 		rc = xa_insert(&cxl_rr->endpoints, (unsigned long)cxled, ep,
@@ -1088,7 +1089,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
 				  struct cxl_endpoint_decoder *cxled, int pos)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
+	struct cxl_ep *ep = cxl_ep_load(port, &cxlmd->dev);
 	struct cxl_region_ref *cxl_rr;
 	bool nr_targets_inc = false;
 	struct cxl_decoder *cxld;
@@ -1265,7 +1266,7 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
 	}
 	cxled_peer = p->targets[pos - distance];
 	cxlmd_peer = cxled_to_memdev(cxled_peer);
-	ep_peer = cxl_ep_load(port, cxlmd_peer);
+	ep_peer = cxl_ep_load(port, &cxlmd_peer->dev);
 	if (ep->dport != ep_peer->dport) {
 		dev_dbg(&cxlr->dev,
 			"%s:%s: %s:%s pos %d mismatched peer %s:%s\n",
@@ -1332,7 +1333,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
+	struct cxl_ep *ep = cxl_ep_load(port, &cxlmd->dev);
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	struct cxl_switch_decoder *cxlsd;
@@ -1581,8 +1582,8 @@ static void cxl_region_teardown_targets(struct cxl_region *cxlr)
 		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
 			iter = to_cxl_port(iter->dev.parent);
 
-		for (ep = cxl_ep_load(iter, cxlmd); iter;
-		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd))
+		for (ep = cxl_ep_load(iter, &cxlmd->dev); iter;
+		     iter = ep->next, ep = cxl_ep_load(iter, &cxlmd->dev))
 			cxl_port_reset_targets(iter, cxlr);
 	}
 }
@@ -1618,8 +1619,8 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
 		 * Descend the topology tree programming / validating
 		 * targets while looking for conflicts.
 		 */
-		for (ep = cxl_ep_load(iter, cxlmd); iter;
-		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
+		for (ep = cxl_ep_load(iter, &cxlmd->dev); iter;
+		     iter = ep->next, ep = cxl_ep_load(iter, &cxlmd->dev)) {
 			rc = cxl_port_setup_targets(iter, cxlr, cxled);
 			if (rc) {
 				cxl_region_teardown_targets(cxlr);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 0b6339916559..499792f339de 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -108,12 +108,12 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
 
 static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
-					 struct cxl_memdev *cxlmd)
+					 struct device *cxldev)
 {
 	if (!port)
 		return NULL;
 
-	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
+	return xa_load(&port->endpoints, (unsigned long)cxldev);
 }
 
 /*
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index d5fd0c5ae49b..c2fbdbfe0b6b 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -177,7 +177,7 @@ int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
 		struct cxl_ep *ep;
 
-		ep = cxl_ep_load(iter, cxlmd);
+		ep = cxl_ep_load(iter, &cxlmd->dev);
 		ep->next = down;
 	}
 
-- 
2.51.1

