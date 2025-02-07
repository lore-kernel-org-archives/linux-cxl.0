Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D22B248186;
	Fri,  7 Feb 2025 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942755; cv=fail; b=XZzER9pe8h94HrIOsFguHeASG34RQAvlYHgvA1XRzVedv4YXaAmLByrLaay+XdhLv2/Jw3nHKtTzeAkVECJsUpmCWARXofV6YxsFYSU0kepVIXtFutb6YQk0c09st3jiHsjT1shDMk/qEm+eyN9HxfFPMH3YrHLwlgl5nS4wRMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942755; c=relaxed/simple;
	bh=+8XZ+c+eU32PrdL0UzmsNXYeEM/G0RicivRXq8Epq8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWeCM14bbnnG5n3OtQVx8YFiUxBkthUQhbxQavi0nMxAmSj2qLt8z1cVJCirjF1DltrRTB7r6/9PH1AL/Iu+v7HNDSPiUGJNX/tJR9t3fgHwduaIpyUeOWb0iNBhjaf6irjbeWIfXHsCBIsiczFFwNdh3iMCfVJiLEqSqcRoM7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3eLME9Y9; arc=fail smtp.client-ip=40.107.100.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3eLME9Y9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyXIuuNZfkSf66fUq8rB/udiNQsz9mrZf5WNtMOsmCiRpVtRLV+omXc0nPFwNWbP4cYRuFQ+UOn9COP2hpqNeMTnkbq+mv814YgjGKyTTXvg0zaMtXfaw8ToG1CiR3oaIxLuOpPv633QfQtxOaZ7DjYZ/CcYpyNizJNRyEz/RGItoK4wdQ62SySrd5uwchnARtjHCrnDUHOWezVMXGtB5gTLxR5HbjDAeDXIBi7TCqW59AZqzqU4TPkoomuGF5Fj89PtnYjAXC0eGOYSISuuYjpxoTYBqKTtbGHMWYf3+D++6RCQcafswKfO6DjQEGw3KWsYSdXEyFK2lT9A4CCt3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaSifXuwFSjEQy6dqBlQkXHmCFQMTAoxoaB5ZkHufis=;
 b=aIl2qLVBVDG2Ii2LpLNJr2fVhek8C7JBlTZ5zq9yNwy3VNjvc3LJMtMruKMo3yg8rjdVE1i/tnAceTDkIWHRovQuxsQtOeXL6RzCiQKxLDmBf93YzqSe0nYkxlItHwqU16V5EtWd3ZUAuD7bcucsi84brYohkxdI1NixNC+TA6KIIYrjg4BBp/NZK9QUIYps6AtrCf6QmS/br4XAaKCoPSqY17gn2zXZIofz9qGsSRfMU21tYTeGDq+ZOsn79RR9XWyKt7Ag5qrYBxDp/VgOC/Is6HAQ8KaD4y5Do0F2APd5C3ZpuFKeWZ3ubrd8OlyCVCDbpCci0prXL0OWDiYF5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaSifXuwFSjEQy6dqBlQkXHmCFQMTAoxoaB5ZkHufis=;
 b=3eLME9Y9jyZT1Qdw14+danK3lxF3FywYuxuUXhW23ygY2KIHySLOui4uVePoc3NQdw84wPYVDvCqSjNSFsyidT3LOdwj9gEOrRnfcHN5PkMKitOml/LPCPbqJ4PJyYdEk9RgExdDd0aT4/Nk/a8MWL1qjcS4CO44B/0JRC9D5eU=
Received: from SJ0PR13CA0034.namprd13.prod.outlook.com (2603:10b6:a03:2c2::9)
 by BL3PR12MB6426.namprd12.prod.outlook.com (2603:10b6:208:3b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 15:39:08 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::b8) by SJ0PR13CA0034.outlook.office365.com
 (2603:10b6:a03:2c2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Fri,
 7 Feb 2025 15:39:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 15:39:08 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 09:39:03 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 14/18] cxl/region: Unfold cxl_find_root_decoder() into cxl_endpoint_decoder_initialize()
Date: Fri, 7 Feb 2025 16:37:49 +0100
Message-ID: <20250207153753.418849-15-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153753.418849-1-rrichter@amd.com>
References: <20250207153753.418849-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|BL3PR12MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: ad149374-8c18-4022-60bf-08dd478d8fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?za6HSJ6Hkg2XfznzabvrlQZoTejnp6An9qYeSeYk+3HA44Ce23QVxs5auZ3c?=
 =?us-ascii?Q?iDfu6ULgPF6El8NgN8E05N38bcqGBMplfUr2PDOlBAdR+wtoXP3TzjdWwp3a?=
 =?us-ascii?Q?r65MF2hpjwDwgwZbJkjcvuetX5LtOxQUapY4qqh4I2DBqRRHDGN8mKEMDXY+?=
 =?us-ascii?Q?DJ9rlJDv/GqB74eUJnlSpoiFA93rMD7DkvAnwtkejIngk1CvNNBaZTXux6kc?=
 =?us-ascii?Q?uwPenW6Eh/vLZhEx2hkyQU0e69LK6LYbik0ZGqdXM3spc0z1P1rzlew24GS9?=
 =?us-ascii?Q?HFOr5Yy2hIcacU4d1aVP4c94enIKeHNFqTlbf27FfOcpTZmc5zN3mWIMMa+Y?=
 =?us-ascii?Q?h3m0p8lJ6JfNvo/cXqhSnO7A3GorxdJY3/Dym1jmytx6UEdZJcPQp42ZVaRf?=
 =?us-ascii?Q?UDwZvBHLARIE7UZSXOPgc36O/fpLE+BlE92pNLJx/nWAutyM7KUvhrKCb6by?=
 =?us-ascii?Q?lNJB646Ly/bh865rUF7gfNnc5M547NEhtpBIo7/pj6Gf8zNySk1wKCvj+nXS?=
 =?us-ascii?Q?g/n045tyfc/AKDoqwaWIh5JPLSncV5FcHqrP8lSBouy+CVsMwxGnGvB73V8+?=
 =?us-ascii?Q?9H9ll3JCIZhMoRioEeHJraH2cNzryQ5vjB6xAa9do0sOt4ju2jBe+P/AZr3R?=
 =?us-ascii?Q?c9P6+nodFCT7qcaXZ4HI4DLaXwZjaiHzj/bothyLEUM/vpy81nmJwRDZaZOK?=
 =?us-ascii?Q?OT3KlWrtspcC4eYLXxr69P/K2lXLRRZrt2u+5dj5jcmneKwhdzdAd0/S/OT6?=
 =?us-ascii?Q?CTfMbzOqy16fc1Kyzl2Au2Yo15A34G+CZ8TkT4kEAVixw5El5V4PNHtgabqw?=
 =?us-ascii?Q?YaQTzK0sY/VYlGWtp6XZJreucR0XkgTAH+Th23O+yhWlceCcZRpl7zqKHHbb?=
 =?us-ascii?Q?hP80xJjzbkT3xUxUW/WXvsS0b85h3gKbP109vbWe+3d3uq7h6o0pa7JekCIZ?=
 =?us-ascii?Q?61IikOoktAkUhSXhCONbSd53bcJr0xNeKeqGc2EHY9ufq0Ii9blFy7/ChmmC?=
 =?us-ascii?Q?CgKc//dov4qU2Bg9UwzZyVOQwVRU+GpnhRu7qbtzIAuxAFICflycaaEDQvaI?=
 =?us-ascii?Q?IdUbUhUvzMAWVhZfeI/eCpdDiBkSJQBfV5ufQWSosLG/GvyLwjZAPvMVW9Hf?=
 =?us-ascii?Q?Jh6JUjzq6BH3i2HJu8mVjBrBBX+CFdX4Kbh1NnNEos7WvOtyp7/HmMw4KScU?=
 =?us-ascii?Q?KQSTITXLLUzo0L5yPg/WMMJA1CTo2zbTOCGRUhSuC6otrOeT6yvvm/ECmDD4?=
 =?us-ascii?Q?qqhrJ+Y96xkxo83TkdIYwagxq88rRBwunn6zts8fOEJpuvX6NYpIwWvqKSO+?=
 =?us-ascii?Q?9zcQlL62wfvo+iNIhNPQQ2FqAAB3nBZmoQxx+CHqtJw0dN62AjCgMHlDO19s?=
 =?us-ascii?Q?h/Xo9mIk+7G7GgJ7miKjZ8T3SdPKv4DkG+w5neimlSbyHKqmRJeNJq+S6TTF?=
 =?us-ascii?Q?3hIrE9TkEaEoVrfamdG1gSbOPNdqJt347TlfxBnuUB7G50MJQyBZKPFUN1rS?=
 =?us-ascii?Q?t8MUBz/sQ6R49A4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:39:08.1225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad149374-8c18-4022-60bf-08dd478d8fad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6426

To determine other endpoint parameters such as interleaving parameters
during endpoint initialization, the iterator function in
cxl_find_root_decoder() can be used. Unfold this function into
cxl_endpoint_decoder_initialize() and make the iterator available
there.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 15286acdf6d1..728cdd9925a8 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3220,8 +3220,7 @@ cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
 	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
 }
 
-static struct cxl_root_decoder *
-cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
+static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *iter = cxled_to_port(cxled);
@@ -3232,7 +3231,7 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 		iter = to_cxl_port(iter->dev.parent);
 
 	if (!iter)
-		return NULL;
+		return -ENXIO;
 
 	cxld = cxl_port_find_switch_decoder(iter, hpa);
 	if (!cxld) {
@@ -3240,12 +3239,12 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 			"%s:%s no CXL window for range %#llx:%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
 			cxld->hpa_range.start, cxld->hpa_range.end);
-		return NULL;
+		return -ENXIO;
 	}
 
+	cxled->cxlrd = to_cxl_root_decoder(&cxld->dev);
 
-
-	return to_cxl_root_decoder(&cxld->dev);
+	return 0;
 }
 
 static int match_region_by_range(struct device *dev, const void *data)
@@ -3370,19 +3369,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
-static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
-{
-	struct cxl_root_decoder *cxlrd;
-
-	cxlrd = cxl_find_root_decoder(cxled);
-	if (!cxlrd)
-		return -ENXIO;
-
-	cxled->cxlrd = cxlrd;
-
-	return 0;
-}
-
 static int cxl_endpoint_decoder_add(struct cxl_endpoint_decoder *cxled)
 {
 	struct range *hpa = &cxled->cxld.hpa_range;
-- 
2.39.5

