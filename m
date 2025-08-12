Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99C422B8D9
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 21:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034260; cv=fail; b=IQClDp+redDYOtPynyB9KGpjX/1JCuNn4rfa0wm3TBmQjx7hq8q4ep40QpKkbcXdYc1knQyN+YQq/I00H12U4fkMDR34RCK5/+3sb/wM3HqkDsFjyBinggI7AK3rTrhdCmE1y+pnhDpEw/fIn1+gRYAOcI7QaSiUW1z1nXWUHvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034260; c=relaxed/simple;
	bh=Pe61mWsR+fhw9gv/JkUPuGJnqEyTou4WJvOhA5QKBoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gS9L685P5uh8LTZykixNItMjb5uOtKx2SQT0TVKVQq8evv0qMPxnp9+Kpiy0swtzXZlOxMbZTT//hNf9oYUfCFk/2RNwawcwGuN0gca8RRivyq1/bVTaA61AzVLgykAYk3jCzizUVeRixEhWwr9TLZGeij2OzEDdlHi/+PPjwPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IDUllsdW; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IDUllsdW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7Tckpv3Ph5oR0iCgf5A5dK/Rb2cLkNCGMKz+rCJyYT/mmqSmxFLF+nWt0OzRPYOMyOOfurUsk69j/b8yLvAgV95iEKB3biH06U9aT8wHe4sRZTLqknwCdohm9GoVxqORCS299ptZQO157uVexI3uqQ9uoUH66irvPz9nGO/OzgJHYdh+B90N/SKaHHn6BBiYGf5NuqETh1uVl8xHf5kD+ohUCEUfUq0QQObPOWS4I9e6/BVLJ4/K7tZd1KDpj/fTAqCkQhxG7eWRwQRv3FVqgQPCR6Gl8IsGeLbT2Z98Ig+zxzSQ2CHjsESyDlrliViKaZ2OAm6wMzdEKClnBAwmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BjZiOxu6Gc+W1pFOp77S+0S72Sy5BfMeIjI2fDV8/4=;
 b=AbZCVkh2tRWDsMQ+pAXhfnlD050OrdsGnp6MXNkdgSH3HRRP3wdmxNXz7GUldqdgPhSk2/YjJhCI4Ul1tizPKpaCHXVWVUUXqU/MTVpn7rOgLX6fmGluVQWk/2KhNUbsZpNFTuqkyDaYwUA8IGEo4DWORItPyOR+zFu5rb5h3xNA/fkhnbqMn927sanPeALAvxZ34gheSHyx3mKYAffUIFxtq/sPc8FDcStTuthya+05J/xsyn+M0gKKN+phN+q3UepuRwndrBv6/fmiR0y6yYNLIwywpK0irPcMDzJHbLtZ6rH0k82iA2cwqNXVy6e9e72d8MmmKEMsF48ejYtMEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BjZiOxu6Gc+W1pFOp77S+0S72Sy5BfMeIjI2fDV8/4=;
 b=IDUllsdW2LHzD2VKwrc1ymofK63QjmjyAGHKACZUqh+IgR1zKgwdujuD6KohdVaN8atC465SjipqZyiIP0GlYfY19YQYQlzJM6tt871PpYBtTw6cOp7KJ325YJN74my+AqoPXOJXNeX9tRmHkGB45UTrWnjO9Jw/8cdLGY5EtP8=
Received: from CH2PR07CA0035.namprd07.prod.outlook.com (2603:10b6:610:20::48)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 21:30:55 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::79) by CH2PR07CA0035.outlook.office365.com
 (2603:10b6:610:20::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Tue,
 12 Aug 2025 21:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 21:30:54 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 16:30:54 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [RFC PATCH 05/18] cxl: Change cxl_ep_load() to use struct device * parameter
Date: Tue, 12 Aug 2025 16:29:08 -0500
Message-ID: <20250812212921.9548-6-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: f0557656-79c2-462e-bad6-08ddd9e7850d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rdqjua3m7IN5+/10kExgQbrZbfpCtJFKKUoedkQGTNkRsKaLBaAorQ8ENlpN?=
 =?us-ascii?Q?MA46xU1QgK+ie9TPI6ps7VgqSHCSKM4EKkV+XOyd3WeeSDuPsoWS9asKhhp7?=
 =?us-ascii?Q?8712j1VAmY6vlPJ+hupakh5CLIMk3emIYJNzwSzAB8IClWUylz1LQ6kZEmip?=
 =?us-ascii?Q?WYSN2WvdNaYuO/3fkhKJ+oktQTQQXJm9+/XzcskPJbU5JoXSiHNzuHHuO6qK?=
 =?us-ascii?Q?pfFgjf61acJkzOvEnaE3mhNySHX5+uBePH2LQj5BjUtcpPJ7KTisS3eWmO+N?=
 =?us-ascii?Q?6CLDI7kBNCKCv6Cv43XH1MF473H70aYUYiJ03Xq2D79q6Vg4zEeCexBus+ix?=
 =?us-ascii?Q?wFPQaTAUyU+CT86NG+XByxsC5bs4z23o14T26AB9xxf7qRW+Ra+wZMuShEew?=
 =?us-ascii?Q?rpkMrEJzpSNbMy+Aj9DR/7SwHa9M9izaBaOuA37rWPpyBR5WzJK6MI1ieqtV?=
 =?us-ascii?Q?foeStMJ8NrU7rjE1wNM9lfDV8IVNVFfEz6Gmn8DGTjsJXHINiFfhsUndSg2r?=
 =?us-ascii?Q?nQzOx1w8B6ctFcDJmY5gfEa95hbGMCcaIFGjYbmKZKfs2FGiswTgLHgxlP+P?=
 =?us-ascii?Q?XB/uy1MjCWl4h+QKiEvk3/RAtOemSUHGi1BjnNviL04DKTMMmn0cgp84nGhI?=
 =?us-ascii?Q?Hb2azan4gUlno0PAtq0G5PFmpflTeofF1SbVMWG+arseFV0czVjiM9IVyRxU?=
 =?us-ascii?Q?Ywerfs3Jwc7k0XJVYdsBZILwTeZ0KLDBGXfXNCqmVIT6SGZkUK093/MuMbLY?=
 =?us-ascii?Q?N22WIhJOMBt0PLexpAfGz4Opd82ohiEyz+MfbL2dJksNEXcVgxPiEhy6CubM?=
 =?us-ascii?Q?pOqNAu4NosnvT7HMPCkNbsaarhzElQRqxr3/Tl7r44V74RAuq1Abjck7wvuN?=
 =?us-ascii?Q?uVG8rn+A0HiDWePcOt9ydco4eGTCXd/Xm/NkombQjZVZ34BSbbcQHkBqhFhi?=
 =?us-ascii?Q?3/95dig7EoQW1sbBDYGmRSbcMOWBl4/k5bj7l6N1bIDHgCX2783R85Yh8SBl?=
 =?us-ascii?Q?p8sl+1d9zTdGPeb+w9txEFoQn1iEsGP58wGFd6VNES3MT/VpSK6pYCnusiUs?=
 =?us-ascii?Q?xyMRp/GkINEKvZejEPmJNs7FtA7dqM7rdR+9jpQnHVrET52KS6Y7qrW10vF4?=
 =?us-ascii?Q?Xkb6iNKkkQUDn3sSXXVZjFSPQLuXFM1bPDkGmIoH9kXl3IsmJox9hXDbCld8?=
 =?us-ascii?Q?SLEXNY0l9cojsJaNAjSTLb4F6jmgLuahZxiPLVqMbFR1UM3RdhJb1Imap08f?=
 =?us-ascii?Q?zgf6q/5StzwqrJRUbHFleQUGPfPnJmsRTEcyWk1sR3E58w1V1wkH9aLV4pMs?=
 =?us-ascii?Q?BYhyshC84fneGQcVm4YUmngUMKFipj2CXS5UHN/cdMEeL1vDkep4gDxtesQZ?=
 =?us-ascii?Q?2/tD2a4yidBQBR3CwKG07ObgYRrqkOK1sRKuP0DZKlBcD/0HYxzLWObQaqdJ?=
 =?us-ascii?Q?K1mKB0QYDGbX3VdesFQIePxy2sdcz6jq+tl96xbClWo1GUyqJJZAQSl4Aytd?=
 =?us-ascii?Q?2NRq1YxCK07KiKmgv49MO1GxPodxFX0Miehs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:30:54.8621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0557656-79c2-462e-bad6-08ddd9e7850d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282

Once cache devices are added the devices stored in cxl_ep refs will no
longer be gauranteed to be cxl_memdevs. Change cxl_ep_load() in
preparation of adding cache devices to the port hierarchy.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/port.c   |  4 ++--
 drivers/cxl/core/region.c | 25 +++++++++++++------------
 drivers/cxl/cxlmem.h      |  4 ++--
 drivers/cxl/port.c        |  2 +-
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0d27c9e8aa64..0eb406d4a131 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1532,7 +1532,7 @@ static int port_has_memdev(struct device *dev, const void *data)
 	if (port->depth != ctx->depth)
 		return 0;
 
-	return !!cxl_ep_load(port, ctx->cxlmd);
+	return !!cxl_ep_load(port, &ctx->cxlmd->dev);
 }
 
 static void cxl_detach_ep(void *data)
@@ -1557,7 +1557,7 @@ static void cxl_detach_ep(void *data)
 		parent_port = to_cxl_port(port->dev.parent);
 		device_lock(&parent_port->dev);
 		device_lock(&port->dev);
-		ep = cxl_ep_load(port, cxlmd);
+		ep = cxl_ep_load(port, &cxlmd->dev);
 		dev_dbg(&cxlmd->dev, "disconnect %s from %s\n",
 			ep ? dev_name(ep->ep) : "", dev_name(&port->dev));
 		cxl_ep_remove(port, ep);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ad60c93be803..9bd44cf4615e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -257,8 +257,8 @@ static void cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
 			iter = to_cxl_port(iter->dev.parent);
 
-		for (ep = cxl_ep_load(iter, cxlmd); iter;
-		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
+		for (ep = cxl_ep_load(iter, &cxlmd->dev); iter;
+		     iter = ep->next, ep = cxl_ep_load(iter, &cxlmd->dev)) {
 			struct cxl_region_ref *cxl_rr;
 			struct cxl_decoder *cxld;
 
@@ -319,8 +319,8 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
 
 		if (rc) {
 			/* programming @iter failed, teardown */
-			for (ep = cxl_ep_load(iter, cxlmd); ep && iter;
-			     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
+			for (ep = cxl_ep_load(iter, &cxlmd->dev); ep && iter;
+			     iter = ep->next, ep = cxl_ep_load(iter, &cxlmd->dev)) {
 				cxl_rr = cxl_rr_load(iter, cxlr);
 				cxld = cxl_rr->decoder;
 				if (cxld->reset)
@@ -1005,7 +1005,8 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
 	struct cxl_port *port = cxl_rr->port;
 	struct cxl_region *cxlr = cxl_rr->region;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
-	struct cxl_ep *ep = cxl_ep_load(port, cxled_to_memdev(cxled));
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_ep *ep = cxl_ep_load(port, &cxlmd->dev);
 
 	if (ep) {
 		rc = xa_insert(&cxl_rr->endpoints, (unsigned long)cxled, ep,
@@ -1080,7 +1081,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
 				  struct cxl_endpoint_decoder *cxled, int pos)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
+	struct cxl_ep *ep = cxl_ep_load(port, &cxlmd->dev);
 	struct cxl_region_ref *cxl_rr;
 	bool nr_targets_inc = false;
 	struct cxl_decoder *cxld;
@@ -1257,7 +1258,7 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
 	}
 	cxled_peer = p->targets[pos - distance];
 	cxlmd_peer = cxled_to_memdev(cxled_peer);
-	ep_peer = cxl_ep_load(port, cxlmd_peer);
+	ep_peer = cxl_ep_load(port, &cxlmd_peer->dev);
 	if (ep->dport != ep_peer->dport) {
 		dev_dbg(&cxlr->dev,
 			"%s:%s: %s:%s pos %d mismatched peer %s:%s\n",
@@ -1324,7 +1325,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
+	struct cxl_ep *ep = cxl_ep_load(port, &cxlmd->dev);
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	struct cxl_switch_decoder *cxlsd;
@@ -1573,8 +1574,8 @@ static void cxl_region_teardown_targets(struct cxl_region *cxlr)
 		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
 			iter = to_cxl_port(iter->dev.parent);
 
-		for (ep = cxl_ep_load(iter, cxlmd); iter;
-		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd))
+		for (ep = cxl_ep_load(iter, &cxlmd->dev); iter;
+		     iter = ep->next, ep = cxl_ep_load(iter, &cxlmd->dev))
 			cxl_port_reset_targets(iter, cxlr);
 	}
 }
@@ -1610,8 +1611,8 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
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
index 9c9d8a878785..f6af7276fa2e 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -112,12 +112,12 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
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
index b991c96622d7..7d88a8bec8e8 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -214,7 +214,7 @@ int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
 		struct cxl_ep *ep;
 
-		ep = cxl_ep_load(iter, cxlmd);
+		ep = cxl_ep_load(iter, &cxlmd->dev);
 		ep->next = down;
 	}
 
-- 
2.34.1

