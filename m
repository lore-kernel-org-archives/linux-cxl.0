Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9AB40B0E8
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184840; cv=fail; b=DyAJHhCXUiD4bWBMWLMO9SfVqlG5p4Bw1tin7/EvltHDoSAjCOpQSPJKgaYZSjNw/vKC7VHIED+S52lY8DYWR3aiMgaITve7ShPolmC6n1rY4mNAhL0RqBd3oZqyB5uevAWnI7pU4yEHO2rhV7ReAvTcJwA6F/vmbSW0V5EkDfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184840; c=relaxed/simple;
	bh=JJ97p8266qoB3WWbFZvNDKA+mxgsOOj7Gv3CyTZlUGw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CR2dZwFt8N6bVwF/yOTyr1umEYowf2MoijXXS9eUoCwioM62muhVn6CliZSBUyMs28rjRG0KZSO2qNp8lxQ2Fhg8cNW3FH1uWegpOF9zMkCwnGAf7wdUQi45LPFZ9apbecPalByGKnKDfw/RZS3x4W07Z74gywc6OdMUX0rKny0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mNeRHYpy; arc=fail smtp.client-ip=52.101.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mNeRHYpy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zv8tFCoeGleYnImBl8SQxvcNyzg0Cj4gSNOeNcCJmIJZiUOItYxG/JTDg2gdrqrclAjphjgSUtrICGiGOjKZ5FqksLcZHb0M3LQM2HrcFanlN4GcV+Ftu0Uns1otPDmA5+I/Eg46HKqQ+SYtCtFmAkbXLfL8O/KGJHJCwQ9hLDmTnbmFBPVoMwWrIP073W1Y8odRn5lszPfBw/AZrrt3KMBNi2MMz5KmVeKy/zyHnXEXr3I3JS6YtDMWqZPUL83Txm/mXiKa0wpzGTnA8AJ7XMgwvGNWW3Ka1aex+YFYsw/q1XmsGm5RwBwr2WQ/d3S4A+bmm5WvAkyozvRjT++G4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvAc9B0ZJKpUgsdk/KvKzL55XM3gS85HrRErEbyeTXo=;
 b=NgISpIUuelHGiOn2ntlJZWD1zCsw0QQ16wKPYg/IMS37QSx7eqW0ZqRs60/g/H5Stjg01DouQ7/mLTIw/e/AR4WP5ou0B/xDAv2TwhEN5YDVp7Uvx4Me3vidmDnMd32NhFZSRavlZJ7rkn1I+7OwjDe2VFaQ1gQ5Bh/zrxo3jFU++LKOlJy4jIa7Wfe9LKGNy9AEw5SVg81grCjDd87FMTeSXo8PxsjVHb3NZ5UMTQ2r3WpSf84HiFPZCDDIZEZlbd77t5/8Gkefr3a5aHjMSk/9dFxUo/KC/BuFqgFXXOJxqRcLyJC7eq/uauVP5m9wYzUuzVEORapHMNczVDd8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvAc9B0ZJKpUgsdk/KvKzL55XM3gS85HrRErEbyeTXo=;
 b=mNeRHYpypyJ1wyyV3SyWIGasRZTbpVC/okXwbHi4fXACOdXAAZWf1dPR2/VV+cCN36aCAUxHMMQCPa0+G3K8U9CCoyboZH7DFF/iAyirDTg6/S2k/du9npG87/sPypLrqVdw69EcmSd4u4wfO+Wpe4LlN8BZab+GAN5OGGvkbm8=
Received: from CH0PR03CA0291.namprd03.prod.outlook.com (2603:10b6:610:e6::26)
 by BL4PR12MB9506.namprd12.prod.outlook.com (2603:10b6:208:590::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 17:33:52 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::ae) by CH0PR03CA0291.outlook.office365.com
 (2603:10b6:610:e6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 17:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 17:33:52 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 12:33:50 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>
CC: <linux-iommu@vger.kernel.org>, <benjamin.cheatham@amd.com>,
	<terry.bowman@amd.com>, <robert.richter@amd.com>
Subject: [PATCH 03/15] cxl/core: Change cxl_ep_load() to use device pointer parameter
Date: Wed, 23 Sep 2026 12:33:30 -0500
Message-ID: <20260923173342.5584-4-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|BL4PR12MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: 5696ba35-a257-4a8c-3de6-08df1998d5bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	y5xAvKqank0lJiewrKPshJOTg/Xhi3q1wS0Kg0svn+28/WErSFddpn46z6IkR/dsMyrqZPYcFWfo6zfhkpMaVtUBhJPNBQqUb2bd5zQvVSmOlFDCbMcesgynLAcNT6HAkoD0h7tbem7FHwG4D4YacJ+zP4cQRTYtTNHjc/7OWJ27OWSOiHaK1UuHjPBQlHwOE+yVRG9pWL6denEMYL0v7VundXKiGjeGfDWv+OSShl2jj3td+aZ9VqHpu0oiki4ceuGsIPEyE2drbJUW0F35cmhYQxQefJmZSC+6aIy8HiqRwgo11NsRhSCfW/8RBiSlOjbBzup3y9J3xQsUGAtr5b555KsZfU7YqsHOiB7wwRldaxvGA6V3xEtLjWiOVZiu8zdxUUpqovng4ijqM5KAd8pIsh45NWW85G+yN62a2z3qHgOSzxBeymQNy1p+v8baXSpIcszj0dpQKUBnjd4YtioCEC0AGx3zFECW4IS6L+55NLz8goj6YmSzPWMJXB2VqDvvvk/Bq/89pv2nt1r0TTEoAktL3RHttSjtUL1av+8TUnzd9Os4h8ZDSFytoJj4+cBcdROzrhEwsvVVst96vRCS2eWwUzm9DGT/OGgK3B4P1emmqEoabp1g2vcQmEm7WKE8g+8acf22i6/m7oTEa1YGXB1sVDeTylVUsmw+b4moQc+ejYKcIBYVN0f+AWXrHmPMQWoF8huylLdGN7owtQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E1NzEx5JzeSFY+Ys3CuusLJU3C5m3UYB5lqNv3lcuQ23lyne+B92gHFzY5Mk3EsPTgslGhXyUshqQqe6pPwaKTV18LV9Qvmup8CuUHWd0wNu/G/KSgI6Kwoszw2zUAacChePfpe0qw+312zlozDsZevYsUl1IghHlBDXxO8W/so2xs51BjG6OT0katluI0cGMBeYH9F5tjcuykVC9J8NDYKqwv8SITa4QZdYCwbRyYzWzlYrW75Tn9YiCuydqaY2Wp/ZjFHfcZG1EL31EsbL92Z6ogH2ZHwbz/Fr0hd9ukcCw3PuHqRk8spxFFihmlMyEnOl2F/ORespsPUIRkFU2LNBKmVbZ5cEUnG+SP2qFTcb6ijVaOzRJvfSzsGRXtCiZgrzFWjC/3WLPREqzLfDMtuV0ObFWWzzLzj3uq5sGHv5fuO6ieyKX8MhOqqsX9jG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:33:52.0658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5696ba35-a257-4a8c-3de6-08df1998d5bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9506

cxl_ep_load() currently takes a struct cxl_memdev pointer parameter to
find endpoint devices under a port. Change this paramater to use a
device pointer in preparation for adding cxl_cachedev devices to the
CXL port hierarchy.

No functional change intended.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/port.c   |  4 ++--
 drivers/cxl/core/region.c | 24 ++++++++++++------------
 drivers/cxl/cxlmem.h      |  4 ++--
 drivers/cxl/port.c        |  2 +-
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index c0f066c0d3d1..6181ec730ec2 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1504,7 +1504,7 @@ static int port_has_memdev(struct device *dev, const void *data)
 	if (port->depth != ctx->depth)
 		return 0;
 
-	return !!cxl_ep_load(port, ctx->cxlmd);
+	return !!cxl_ep_load(port, &ctx->cxlmd->dev);
 }
 
 static void cxl_detach_ep(void *data)
@@ -1529,7 +1529,7 @@ static void cxl_detach_ep(void *data)
 		parent_port = to_cxl_port(port->dev.parent);
 		device_lock(&parent_port->dev);
 		device_lock(&port->dev);
-		ep = cxl_ep_load(port, cxlmd);
+		ep = cxl_ep_load(port, &cxlmd->dev);
 		dev_dbg(&cxlmd->dev, "disconnect %s from %s\n",
 			ep ? dev_name(ep->ep) : "", dev_name(&port->dev));
 		cxl_ep_remove(port, ep);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 27e63e6dab7c..a8ed7161296c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -272,8 +272,8 @@ static void cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
 			iter = to_cxl_port(iter->dev.parent);
 
-		for (ep = cxl_ep_load(iter, cxlmd); iter;
-		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
+		for (ep = cxl_ep_load(iter, &cxlmd->dev); iter;
+		     iter = ep->next, ep = cxl_ep_load(iter, &cxlmd->dev)) {
 			struct cxl_region_ref *cxl_rr;
 			struct cxl_decoder *cxld;
 
@@ -334,8 +334,8 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
 
 		if (rc) {
 			/* programming @iter failed, teardown */
-			for (ep = cxl_ep_load(iter, cxlmd); ep && iter;
-			     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
+			for (ep = cxl_ep_load(iter, &cxlmd->dev); ep && iter;
+			     iter = ep->next, ep = cxl_ep_load(iter, &cxlmd->dev)) {
 				cxl_rr = cxl_rr_load(iter, cxlr);
 				cxld = cxl_rr->decoder;
 				if (cxld->reset)
@@ -1092,7 +1092,7 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
 	struct cxl_port *port = cxl_rr->port;
 	struct cxl_region *cxlr = cxl_rr->region;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
-	struct cxl_ep *ep = cxl_ep_load(port, cxled_to_memdev(cxled));
+	struct cxl_ep *ep = cxl_ep_load(port, &cxled_to_memdev(cxled)->dev);
 
 	if (ep) {
 		rc = xa_insert(&cxl_rr->endpoints, (unsigned long)cxled, ep,
@@ -1200,7 +1200,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
 				  struct cxl_endpoint_decoder *cxled, int pos)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
+	struct cxl_ep *ep = cxl_ep_load(port, &cxlmd->dev);
 	struct cxl_region_ref *cxl_rr;
 	bool nr_targets_inc = false;
 	struct cxl_decoder *cxld;
@@ -1377,7 +1377,7 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
 	}
 	cxled_peer = p->targets[pos - distance];
 	cxlmd_peer = cxled_to_memdev(cxled_peer);
-	ep_peer = cxl_ep_load(port, cxlmd_peer);
+	ep_peer = cxl_ep_load(port, &cxlmd_peer->dev);
 	if (ep->dport != ep_peer->dport) {
 		dev_dbg(&cxlr->dev,
 			"%s:%s: %s:%s pos %d mismatched peer %s:%s\n",
@@ -1444,7 +1444,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
+	struct cxl_ep *ep = cxl_ep_load(port, &cxlmd->dev);
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	struct cxl_switch_decoder *cxlsd;
@@ -1692,8 +1692,8 @@ static void cxl_region_teardown_targets(struct cxl_region *cxlr)
 		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
 			iter = to_cxl_port(iter->dev.parent);
 
-		for (ep = cxl_ep_load(iter, cxlmd); iter;
-		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd))
+		for (ep = cxl_ep_load(iter, &cxlmd->dev); iter;
+		     iter = ep->next, ep = cxl_ep_load(iter, &cxlmd->dev))
 			cxl_port_reset_targets(iter, cxlr);
 	}
 }
@@ -1729,8 +1729,8 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
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
index c401e3a1af06..a102b8eba5cd 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -147,12 +147,12 @@ struct cxl_dpa_info {
 int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
 
 static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
-					 struct cxl_memdev *cxlmd)
+					 struct device *ep_dev)
 {
 	if (!port)
 		return NULL;
 
-	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
+	return xa_load(&port->endpoints, (unsigned long)ep_dev);
 }
 
 /*
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 99cf77b6b699..edf0ff759fbf 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -298,7 +298,7 @@ int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
 		struct cxl_ep *ep;
 
-		ep = cxl_ep_load(iter, cxlmd);
+		ep = cxl_ep_load(iter, &cxlmd->dev);
 		ep->next = down;
 	}
 
-- 
2.53.0

