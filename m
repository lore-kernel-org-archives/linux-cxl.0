Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036971F2B84;
	Tue, 11 Feb 2025 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267703; cv=fail; b=BlvlcxiKIvF5FVSSS7pS+tLWdbUxMhjye/XybtMfIQVb/kg2d37WEHIoGTQsmj46O4MVBShxy/Ee3FKkwDOg+1fkAKToIzLPIqRkFNeN1GHOdUxV8YOYRhcxVlgCHLA+7K0NdP2lHL3n/L7P80jF9dbaNVpqYifX4dWNo+L/4EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267703; c=relaxed/simple;
	bh=iw1MAgInLdgM767gc+LbuEitstI6HAa/+tYE2iBwQ6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLqmXMsdamt7Nik3sqdcI8rCnOWmmaYjGBCpw0XkFRkAaLqHSgh2MHQ545yLK6vwAoj2mMeMcNm8j58emQzYfq7i6JOADgwSN3bAf0GNInjVw37eRskG7Sund9j8w2AkhME8odkq3erwbBxBs2hHOl/XPpDnbmjgW/sRq25KJhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dvDpzJD6; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dvDpzJD6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvwXJ/UkhU2fyVK+pXA69YzLTXDs0iErKuXhvAcbPp6KVughc9DMKy4M8rjozZM08zw6KTyidKRUGQMspCjKg42I3BISv9amP+Ks/2Sne03JjjoURXsJuxNMSz5fFLqgOEO7oA3WESMLGe2kNVB9OrDB93Wo6VsbL14THb973Lxj2mEAQoBZdEcp1KPJUMUQwnloPnJm7eKHDKI6MKLANAwQOuFm4Mu1iOb0mF9JQF+nM0Qp+7gwtva42upJQfVsPrH00DGdSOgdfrdOMK6TrnG/WJZ3TxSqQ7Afn8xW6WnGUtGKsZsoxAJZcrzNBkx/hevaSDG6MuBJ5d0qjbU4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WatghIPd3YvI5JLiZP7QTZZNM4t4hCxaMVt6lwignDQ=;
 b=hFm/IMyNJehRZZN/iZuYxTtvnDhF7ajz4fkPRoHXA16SC31KVpxakAE2wFk6BE8rdUch8E0O7mh5PO9yC4X/7u0swewRQ7o2k5cK3FvxrmcaooWd4UWwuCKNJ40fbBBjsgWve4xPX4qzm6V9sA//lu1r1OG3xcHj4IhWqbu63+V6stZHPmbLSaQcuKA1PQL53ylrD9hvW8L+oqlUIAre/QxW4K8MJUG9MjoRSygq7xFCnl1aN7vEBCfURFdKQTFHkhNty81gxfvbxVXmCSMFI+5wGY0o6LecKHcQvc0bOoSwvz177S2PT5nF0CVqKc7xDy1WwU70jaDcU4vOYoFkbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WatghIPd3YvI5JLiZP7QTZZNM4t4hCxaMVt6lwignDQ=;
 b=dvDpzJD6tCYtRW1lbNAlrOWvB2oR7Afz2Xax/eV9ETvi4JGkHdZ9VwamNpOouc39V2UVy2iMhqT6mwj9tQO2OPTlpSP+lwax0HHk+Lbsu+FYquVg4+EfnTQ1ih4MY0Jgs8t3W5RAtZi6XEDXfmzL0S8XqrMaOB3Iftd71Rap8sY=
Received: from BN8PR15CA0026.namprd15.prod.outlook.com (2603:10b6:408:c0::39)
 by BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 09:54:38 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:c0:cafe::6f) by BN8PR15CA0026.outlook.office365.com
 (2603:10b6:408:c0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 09:54:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 09:54:38 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:54:35 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 06/18] cxl/region: Rename function to cxl_find_decoder_early()
Date: Tue, 11 Feb 2025 10:53:36 +0100
Message-ID: <20250211095349.981096-7-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|BY5PR12MB4050:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d342d9-c67c-401a-6a29-08dd4a8218f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d42R28uOKMjbhzYTO1YQVUfMCvMDGU75gGOBWpAeGJ7dfEIdxmpasC3S8Qxs?=
 =?us-ascii?Q?ggdI1sT87d5ClkiGnbkFxrfmxdiAry304wr2tBozmeS5U1wnNhK0YB0RMduF?=
 =?us-ascii?Q?/hWD4OQ+6G/tH2MBqYIuGjzUmqOMlHpcUR/p4qq19TTcDa+E78anQ7kF00J7?=
 =?us-ascii?Q?nYsYLsn5YXZpA7SOXVoYHMxQFoDbony793wBxaBvamamAAgq3obRAGowX3lS?=
 =?us-ascii?Q?ov5e8jmYIVW64K88Sc32VgUDOvMAdoM1/Hxt4OTYicUcDEQsVUb54e8kve2Q?=
 =?us-ascii?Q?ofreJypdXx2Cri6150s0pi3NYH9AyO8j1/G4DW3rjzjDhLP/tlnCmqGy4W4k?=
 =?us-ascii?Q?loowMyiWBgYe3vZn9+8lpoG2wR//bh+0zI97pWhPcH6dXg1h2DnuGxLEcKz4?=
 =?us-ascii?Q?1+oFFQrph4B+MxK1g1/unLpylHzOOxLW6jh0dfgJluuZxfcFlFrydNOv+/gW?=
 =?us-ascii?Q?6kYF+teVksIkSZE4nWn4XV3cus7bw6na4WJqJ/ZqijKCsrG0Bms3iR5X+/Rx?=
 =?us-ascii?Q?X08ahDn/gRvGlPh552XcUfjC8nQTN2CblavLxK+2tdORu+aAODKIlNOl3DtC?=
 =?us-ascii?Q?pSAV+ki/5kqDUT+YNaHhJR0BmX8m2SQ/h1cpmBr9u3sCvAXqGa+Txz8I1gIY?=
 =?us-ascii?Q?J9NRv3DbIRHvQvP0yhBx/K1NQ0/ggiq5Xf6moUVPTqrezp3lbe6/YqOAjav7?=
 =?us-ascii?Q?RIaJ2M97ELyslozhWUxnTeVp69nEQJchgQtHHW6mBxNIA/wn6ritipW3GrA8?=
 =?us-ascii?Q?jZsIcDNm9rS71+rlVrFE828gZGB6acoTgg1d0ujcqDNLqFlK62YLk503fFE/?=
 =?us-ascii?Q?+guVIORR5XMMP1p/DutX4HdG+xUwCYLk7HxsY28lLxZ3Q1V/O1bVFjHHKUer?=
 =?us-ascii?Q?1CpPNLK8fq3bMbl3sHJnsMHjCibPaBKCqWqMCRrEZT1DVHP8gZWQOLzJeZ6O?=
 =?us-ascii?Q?U5AL2mBA3d3Qzj2suYroWhICzNnIZSAMk2D5HWPaSTYgjAXGSeeRmRaBAfgS?=
 =?us-ascii?Q?uGvgc7IcreJpiYjkGXYKEeD6u6qq8uGoxo0YXib0iBm/STSzsto4U9bg+WFO?=
 =?us-ascii?Q?Ts52+k/esDXNGT6G5dzRqaO6OZW2//4qiW+u7kdEIvqCgY8Jrdc+6zuhSwBv?=
 =?us-ascii?Q?a5/Jc2oqNX8lgJZNp2r8G0jS81/+RBDoEphVjyKm/P/E/LupR+LQPQakQSA4?=
 =?us-ascii?Q?C7pYy367R3WgmH+6l8Pjw8P2Q4i5n4D/nN+tCZcoiuR3T/BPntX6k8KnC4dr?=
 =?us-ascii?Q?V268WC3UNFJUzXY1Xb1kGUvbE8TXD4kVCAd/mT5db/KMNAHfzztSuYgcsWu6?=
 =?us-ascii?Q?C0MeljgJv5BXa4QI2o3lPZPG8XTPPm7hUBF5GUMhwFVpVPoTAkKrWNTHnOE7?=
 =?us-ascii?Q?4HlPeTmmVtRFdZip5q0sN8udfWxtUUZj1e/6rzKK0oXGj+0LqIpw8sOFTCPh?=
 =?us-ascii?Q?LruJx97+0Uc/OiCdBFaajITLBlCqy2fEhF2CdIxVzH8hyGcue8+WhayOy/fq?=
 =?us-ascii?Q?6zG10GD4YavkhWk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:54:38.0662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d342d9-c67c-401a-6a29-08dd4a8218f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050

Current function cxl_region_find_decoder() is used to find a port's
decoder during region setup. The decoder is later used to attach the
port to a region.

Rename function to cxl_find_decoder_early() to emphasize its use only
during region setup in the early setup stage. Once a port is attached
to a region, the region reference can be used to lookup a region's
port and decoder configuration (see struct cxl_region_ref).

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 54afdb0fa61c..13e3ba984a53 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -850,10 +850,17 @@ static int match_auto_decoder(struct device *dev, const void *data)
 	return 0;
 }
 
+/*
+ * Use cxl_find_decoder_early() only during region setup in the early
+ * setup stage. Once a port is attached to a region, the region
+ * reference can be used to lookup a region's port and decoder
+ * configuration (see struct cxl_region_ref).
+*/
+
 static struct cxl_decoder *
-cxl_region_find_decoder(struct cxl_port *port,
-			struct cxl_endpoint_decoder *cxled,
-			struct cxl_region *cxlr)
+cxl_find_decoder_early(struct cxl_port *port,
+		       struct cxl_endpoint_decoder *cxled,
+		       struct cxl_region *cxlr)
 {
 	struct device *dev;
 
@@ -917,7 +924,7 @@ alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
 		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 			struct cxl_decoder *cxld;
 
-			cxld = cxl_region_find_decoder(port, cxled, cxlr);
+			cxld = cxl_find_decoder_early(port, cxled, cxlr);
 			if (auto_order_ok(port, iter->region, cxld))
 				continue;
 		}
@@ -1005,7 +1012,7 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 {
 	struct cxl_decoder *cxld;
 
-	cxld = cxl_region_find_decoder(port, cxled, cxlr);
+	cxld = cxl_find_decoder_early(port, cxled, cxlr);
 	if (!cxld) {
 		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
 			dev_name(&port->dev));
-- 
2.39.5

