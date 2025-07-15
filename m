Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1E32C031D;
	Tue, 15 Jul 2025 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606763; cv=fail; b=U8EAwU/YJ+ZsIZMS2o0KXLSp7Kzq+omDMxueqr2Fq/5gZ+w1fePw3LFyFU7FXA2PpiPQbJFAKKzNq6U+2pjJhFzgphg/2q0guBXe1thKe2ZlN/oPsOYLEa5dVL3y+gKugMlfQfLkMCT7IzTSGbY+jfrRW0lSuX+FGj1OV9hZxCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606763; c=relaxed/simple;
	bh=2gTW1k9i6G+krJSvdKALYPWznxNj6CaPJAqS/ehLz04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dz68g6xpt9R+4gGoPkK558WEcbJ3A8CRSxIqHRXLc2y7G5Op5+Wf4SA4qfmfrbaGGm+3B7WmNd7FRJ6AXL9e0GbxfkerYLbBiqY/kmpm9OZaveL3KPbKWndnDSeDmNZkO7ffNkU5vHvLHsac90r5nxa1ZbN9ROgquSUAPCYgDZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R6h8gNhC; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R6h8gNhC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyWafG+qbU1/IkAwQmbIMW52B5ks6lC1e532jaCQMopXPuPcKAFAKSFF0d1EIRQOUgsdAUJ/52C+ZNtXSlV7hosI6YwSRCggmtTRc87SYoJ1Qp3V6WACll6Hja9ya7OxCZ14mSaCmcA4OzwoL4Kr8+RqqZPMt3azdfzkWrOMvd51DGW0JzCy8mIHCYsmQ4Zycxz1g0C6xglJuOZ4uxDH0yKjkroBoVJBfKxmqfiYJTdYQwdo73PDUV3V4Nn3ZfZqnV3LXWmByhvT0Zo2JddBQOHugIvXymh/8TNwS0lVvg746LtuTtTwB+EhWn4x829mS+R7ZRphMISnweWeUyZFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gO+/ojJMPmly9SXbOOyJ8th1e1/qTb17631L5LZ1DTs=;
 b=cSNVOKXAbKSYLBVAGIApgWT53fdNZ+sPk4bkRWFSZIUF6JFTOOIpLN0D75oVrKO7S++LcQZNA1syXv5zsuuQ7RILyy0vbsiVmljyOvz01si8P0Z8B0PAgQzC5bUF4mwQa0STRPZ01rsqNRX8FcwtaHlpRKF6nm0LzMp0ofXuWNvQrzOjFA6OkzP1XjnOkO3iEX0kGaqJpv7eeVtYOKSvaxBKYqnYDyBCUKRjm3rtXuSl1OqUlhpbJ1AIBwQhhfK8/RKisU8BylHP328ZQIKHI8yxnRAy+T3msB7Xj2eh/IiL6CWWVZX0mdkW1zqlihe7V/SwbnhXVMguIWDhabKDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gO+/ojJMPmly9SXbOOyJ8th1e1/qTb17631L5LZ1DTs=;
 b=R6h8gNhCvFHuLYwaezkcEhAJjf0QGU2mVBVMY+B4uzcJTOrJb/wQ748v+3FoAjlBPkX0oiynKcpdEfM2O4En90RpRC5RlhfJowZZDCUi8was0oFnbvg3peyuKQqQ8K2DDjXWmtzJ74h/0W8GlxQXMT8HprwQeKv9Uh9MXW6tcMg=
Received: from MN0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:208:52f::19)
 by CY8PR12MB7587.namprd12.prod.outlook.com (2603:10b6:930:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 15 Jul
 2025 19:12:37 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::3e) by MN0PR03CA0030.outlook.office365.com
 (2603:10b6:208:52f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 19:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:12:35 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:12:32 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 06/20] cxl/region: Remove dev_err() from cxl_find_root_decoder()
Date: Tue, 15 Jul 2025 21:11:29 +0200
Message-ID: <20250715191143.1023512-7-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250715191143.1023512-1-rrichter@amd.com>
References: <20250715191143.1023512-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CY8PR12MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a59f139-6eff-4c74-98e4-08ddc3d38e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MvVQLe/eD5gFxh3/doZ5BDeiFVQJFqoIVj0L7DRtMoXTTkjJeq6cQ30HM55q?=
 =?us-ascii?Q?6Lax09bEUu/B5NtqxK9vdpaXun479H3hTQHS5A7wLroP1WGshly+dhKqJWPq?=
 =?us-ascii?Q?8ai2iVdjkpn+9He9vji/7CKFhIz2UnFqWXDJwSehyl4WlU6CloJhW5dyTwE+?=
 =?us-ascii?Q?2vxkcIUinCOL/t2zkrq7sGWluXd4MhsjtlXQFBXoKbILSF+2L/BEHQaFBMZb?=
 =?us-ascii?Q?fC0vGEUO7sIs6dOQ4SA0rYWhmCt69YQGVOmVrHF3gw5JaxP4AlFMhp+G9ZR3?=
 =?us-ascii?Q?9V4cTktfkxPRUSPWsphZxp5fCnv8BGrW5H4YPURTUeMLKRxQNs7Vv/xG7ljo?=
 =?us-ascii?Q?fJ/Pk9psu5VV+3ubNkxH/Y07jvzYnaIgk3XX8nGH9jcn+jOji1Lc3I3jyLjX?=
 =?us-ascii?Q?mEJi8UGuNZlblzxfQNGYm2iDAj2KShb2on4wOg8CVmUX16YUfl9uPAJ5V+BB?=
 =?us-ascii?Q?vzxQeu43cosfa/oIq2UTSe20l1kZcfzMk9bTNpHYqthuhZK+H+Fj70gTmntY?=
 =?us-ascii?Q?94FmsWXcwe/iGbuBlSxrDjyy+VukBaUhuEpqgntxvN44aC8psYCU1PGgPVTt?=
 =?us-ascii?Q?q+iMegxpEYzpYEPCokhU10SJ6Hj2kftTosjeS4Lk4VeTwk7tr9BGKEbeC0to?=
 =?us-ascii?Q?6n0ieHJTkrEIDnCjyF2/RioWArTljxsVRMBCsabwYu6mtdT+rE5c0lWbPQ5l?=
 =?us-ascii?Q?TYWzzNOaQ4WXARnvHfYpVzZtCAF/F6SS+PtpGdnMdT7GuLr8ckoQQUh+lBVz?=
 =?us-ascii?Q?S4/jdX2XmVsiRDbCmk1DQck3O6RZvH/EF59Bw8WWwdxEUjXT2aT9xNwG9ND4?=
 =?us-ascii?Q?Bltd3H2BzHIMR7VreLpIwpfpr7HEI2nndHB8Av9to2E3ecF7qQ3HHqX9kdhD?=
 =?us-ascii?Q?XQzEWGZpkCK0N0HM2AkK7zjdKyhuimS8AuBjihLbEg5y6Ay/lldAaygD9dkn?=
 =?us-ascii?Q?kzkSV9l0HllTMh2Xs9FLMjpxqIMOSTe6ZsL6Rqu0vlprG/sPFFJC4dYHTU6g?=
 =?us-ascii?Q?b6Y3PTgzSh6eErw5cWk/AKRXPU+7UIIPhw92yxDagxIKbXWkY2neZF8wVMkM?=
 =?us-ascii?Q?3wbjtlif6feDo/FBByPA1T/XjbZgyeTHamsDTpmbblFV9Ai1VOKOGsyjLDgw?=
 =?us-ascii?Q?Ke7A+zRJAERm9di/0zEGPopeqQ80HcuToNiEM81oMIpgbXJ49nBJbF1Xih2i?=
 =?us-ascii?Q?6BkATLCERhq+5UPinnV4kXMCGsPLwQ9haMuFCVYP2opLBrTaS4C7sZqZEHMW?=
 =?us-ascii?Q?9jl8kDR3tQLWWEUc2KBt1Zz4fyqDvYZiHF8LfT7CPbMQMcLqsZ3i6RoY9H6s?=
 =?us-ascii?Q?OBE4rTk2idqZSrgiWjFide6pePIIqOK0iO7RsIXx8v4+BIlZgq5PQ2K2Q17o?=
 =?us-ascii?Q?TYlHQYJ5VdX9ZcwXhfqbSkqSzbrEtKHwq8AYEykFRSYszy6HXJ6sFI6Moa23?=
 =?us-ascii?Q?BdM+0TLYYRJzSrFOIdcSrh7beaqvEUfKEAJrYqT32eTOGHOGoJQOBMqam7Fl?=
 =?us-ascii?Q?ZoE41WUcp2ql1Jp3lSRTERmHGaXMncO5wQ27?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:12:35.1113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a59f139-6eff-4c74-98e4-08ddc3d38e6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7587

cxl_find_root_decoder() is a small helper function. Remove dev_err()
from there and instead move it to the next higher level where other
messages are generated too and all parameters are available to
generate the message. This simplifies code in cxl_find_root_decoder().

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cfcd286251d5..760455c760e8 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3250,22 +3250,14 @@ cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
 static struct cxl_root_decoder *
 cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
-	struct cxl_decoder *root, *cxld = &cxled->cxld;
-	struct range *hpa = &cxld->hpa_range;
+	struct range *hpa = &cxled->cxld.hpa_range;
+	struct cxl_decoder *root;
 
 	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa);
-	if (!root) {
-		dev_err(cxlmd->dev.parent,
-			"%s:%s no CXL window for range %#llx:%#llx\n",
-			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
-			cxld->hpa_range.start, cxld->hpa_range.end);
-		return NULL;
-	}
 
-	return to_cxl_root_decoder(&root->dev);
+	return root ? to_cxl_root_decoder(&root->dev) : NULL;
 }
 
 static int match_region_by_range(struct device *dev, const void *data)
@@ -3444,6 +3436,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	bool attach = false;
@@ -3451,8 +3444,14 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 
 	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
 		cxl_find_root_decoder(cxled);
-	if (!cxlrd)
+
+	if (!cxlrd) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s no CXL window for range %#llx:%#llx\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			hpa->start, hpa->end);
 		return -ENXIO;
+	}
 
 	/*
 	 * Ensure that if multiple threads race to construct_region() for @hpa
-- 
2.39.5

