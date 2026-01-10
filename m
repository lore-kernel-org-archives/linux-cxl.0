Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E644031ED8A;
	Sat, 10 Jan 2026 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768045754; cv=fail; b=deM8Rms6GQOwxTU3UiJUkC0FXVq2eF+4+8xsxtISjQSyl6ofkD29czi8NrvJUlFDLz1niJu5oqOvphQ4GPxIVmq9hjxZBLS8KFQ4tJlwWTLLGiTgz10FzKdS9C4AwYVbm+B4vPkneU/wUd35QxBoEXnnSVLQm/i1NRKAAjQ9VS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768045754; c=relaxed/simple;
	bh=0ExRveAcGvMosfFv//dG5idANZVXBekdJM23DTZwQgw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYsJjsJLyWa/y5S3qpWodxJpz29yM+Ni93pifrMJQyjWerLRVWVpZZCTuogm/xOsS25xMkSCxI7mP4/avZcpu/Yg72GAZRKuM0F29pXFj4tFGJxcHyOF5szWkS3GXfsaWlhIGhV5zltFHHWqMFERCgGKLEkTEyl0eqxHHVO+H9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lPxi01JC; arc=fail smtp.client-ip=52.101.53.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lPxi01JC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdf5hcMPE5XRCX8EoSh4vRRBCLunyc3CFODI+U8W5shH/Dn500crnEacC/uwddP6Qpn96c6S4dBEa7bbWXr/jtE0Zm1bnn5dMRCb7fZ87e5GcUNZyRJn4cW03PG+POX5BvLauz+IbEAvGenCQ5X6kfTY1CSyc9QwdAcMhQRQKpCp1PU2eQhJdXJB1Hx//K2er+2rlt0+S3HRNKJPCI3mIQWMynxRO+tsZy0JajhWO1WBU3Vspw5vjEyw8QJyZBGgBxVzWS+VKpGBzoFxAC9mUrSwZh4rEHHEWYORff+X4iFbp16/vr6Xpp+d6WBuZpgvea7FF64Up2WER4hyJZB9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LqNxL4mex+vflacz4+zTNOkvQFID4AGjUm/hHm0VSk=;
 b=MiYkh6uOcAMxdMptqwfpAY0E1e36QD2XrVjfzoiGL8FqlLGUwOaUdL4CAyQ1Gwes7TF/HcIierqGfanN1dHbJI1sA23yqgGW0yef+bMeuGk4E9UZ+LIsi4oJktLL7YGVHwKrgx/G4y3kDhMfkNT5qj8n+hmj//XODdTgtR1bxbv+x2dKwn3obMpTHaLrBaZ+5bJNVz/oMnNQXWKi8BWPLJfCYXrAup5cb3saipUttMRzbKaKl1IGNErmzT1tuWJ0fecOXE6CnDvzGgp9nUv8qZ6X32PcI8K1PSnENqZwphyoZ+indh8aALEDnVOhBSZv405ygLRr52lBdw1HqN1YvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LqNxL4mex+vflacz4+zTNOkvQFID4AGjUm/hHm0VSk=;
 b=lPxi01JCe/Xjk4byXrLdneTKl+fDWtYYrjjZSEl/+GLde+z3Vsm97DOIGDR7JBkbltw6soOziadw159YCVrpQRiKcE2IvF26Tp26JW1AFNKlrJLGE0UVKAqRj0D6lcU7YY9jUz5oQ8VCouh1KqH/BE22n3GFQrsXf6xDFPaCvEE=
Received: from SA0PR11CA0175.namprd11.prod.outlook.com (2603:10b6:806:1bb::30)
 by CH3PR12MB9146.namprd12.prod.outlook.com (2603:10b6:610:19c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Sat, 10 Jan
 2026 11:47:55 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::a7) by SA0PR11CA0175.outlook.office365.com
 (2603:10b6:806:1bb::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.6 via Frontend Transport; Sat,
 10 Jan 2026 11:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sat, 10 Jan 2026 11:47:54 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 10 Jan
 2026 05:47:50 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v9 07/13] cxl/region: Use region data to get the root decoder
Date: Sat, 10 Jan 2026 12:46:52 +0100
Message-ID: <20260110114705.681676-8-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260110114705.681676-1-rrichter@amd.com>
References: <20260110114705.681676-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|CH3PR12MB9146:EE_
X-MS-Office365-Filtering-Correlation-Id: 905c7517-8fa4-43ed-7b8d-08de503e17a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Krz9MotZr2ll+9ymw4RLTrG0q+wCCqO9GF2GQPJMn87/XrwBqsUJ82z4frYi?=
 =?us-ascii?Q?bfnXW+pVbPgFIweslsPI50gcLPA3DpjlXNIW2MYFSVIkGVOeoyYYdg3AH/wz?=
 =?us-ascii?Q?9Y5KZ0ir1shky2V1w4l4jeRp/G9WCFT4CCZ+WjcMOnFrM76bgCvyntYHuJbL?=
 =?us-ascii?Q?pVx3T1c7EQgZrg2lI+WLD9MTr/IgXvlufPPwG9jCxQhmiGQvK7NlYiIJS1Oo?=
 =?us-ascii?Q?fi0hYwtWKPicSRUYKSuDin4kqeXDrII+kNUUUNAzFtNuA0AHzb1yLrOYxUSY?=
 =?us-ascii?Q?eVbgY26Fvaf3UTudJQbKj60Uuhr/qea9pRHknlabPSoGqqFTgw158UahcwhZ?=
 =?us-ascii?Q?hTCdUAueDxI3dPBH7f1zU6RKgC5gssQGbtUP6q9PDk/C0Yw9N+JIlGd1TQHJ?=
 =?us-ascii?Q?tJMZbLkOyFRop8QbeDyJf4QbXucZBxo3md5H7iBWFtJrljCeq6YdA8fVPVcH?=
 =?us-ascii?Q?R7Ufm+oVs4RasM/NcD0b77cScgi8Z5CAVAFwfYwwPAHQYIf4dHE3Q+bCX0jM?=
 =?us-ascii?Q?o1IAifQrNcrbXG7eoCWsEMYMCgh5xfh7sQClLCHF8fu6+j5K+SE37IK31H3N?=
 =?us-ascii?Q?nNtBIxIlPAxD4+93KhPBRc5WaequGY2FAf7l1E256PSNMHaZvSJiOjV3DR7c?=
 =?us-ascii?Q?k/eRsn2ZFwgMDS9IEHl2zbbXwNoVbZHh4BmV2vaRJU2RqI39xnfdT39I9J7r?=
 =?us-ascii?Q?m+sOAQB3YyTF4zxuMFLnM6negj/johDg+J2FKB4XddBa1KrktX6VfaAQ7j3e?=
 =?us-ascii?Q?UrxMzd5S1Bsp085rbBLVOM54FdZoHx1DeKDG9aaA93zBZ8nQQKXjYB1WlaZl?=
 =?us-ascii?Q?IA69aNGM5syRiosUwbgcXGUbYmbtnYsmAavgL1XsdYfr/cWLiroz0mEyHVHF?=
 =?us-ascii?Q?WKU/AthuDr40WmqQXOrvJAiC20MuVZgjhM+6tUyhO5XqedQ+ihQFJ4vScUxn?=
 =?us-ascii?Q?FB4z+0LkxLfiJILIOvZUiWiutH+iLN7D/xBhIH4OX2D/9X30iy61SzK+XVwO?=
 =?us-ascii?Q?rGn12zcbDi2H/sjFKAv/vNH9XfSjZEdk0SLcM1VDPylT8K4sPp7srrDKax//?=
 =?us-ascii?Q?8OPMTz6UyXmUgFjqXElHz+iQTiP4js20Gne2x2cA9OzYXHDhEBWysGF0QPW8?=
 =?us-ascii?Q?cq9lEJV6Hnoam/SYh/V39fn/cbVReJt9Huz4zRZcLAEYwZTLU9//yaj4McvO?=
 =?us-ascii?Q?zdh05Kw+35/Bw2qWFkL15YCfbPcwpt6tmucEEx/xSuG/E2c377gRspPZrYSJ?=
 =?us-ascii?Q?CwOb7nWAEU8FsZ0pJNHOl09BYPiZRDxYBA1aGb+6HGsu+fAPRjp8S7k0ROjW?=
 =?us-ascii?Q?3u6dKBU/kOS5blNEnU+LRpHTiWgNByrDPgzVq9uGNZ3qhaBcMjj+ZB+mBLoe?=
 =?us-ascii?Q?JnEMs8pUe73sfWh/Wl3WY6yktQ13O7ni5W4yt9s0kpS5jXjn3gwyi75OGMRI?=
 =?us-ascii?Q?47APhUA8dW6fdjGI2uT5ct1X7ArPAv4fHtV61Q7fUnZfBj/4S+GN26tb5WFi?=
 =?us-ascii?Q?3FtEBFv/30XZ4Nar/x5xp3/mKPb+QQN+8Mn25mpTc9LGs4ILGvBJhbSWqbcJ?=
 =?us-ascii?Q?IamltderR1moeFln10o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 11:47:54.7759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 905c7517-8fa4-43ed-7b8d-08de503e17a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9146

To find a region's root decoder, the endpoint's HPA range is used to
search the matching decoder by its range. With address translation the
endpoint decoder's range is in a different address space and thus
cannot be used to determine the root decoder.

The region parameters are encapsulated within struc cxl_region_context
and may include the translated Host Physical Address (HPA) range. Use
this context to identify the root decoder rather than relying on the
endpoint.

Modify cxl_find_root_decoder() and add the region context as
parameter. Rename this function to get_cxl_root_decoder() as a
counterpart to put_cxl_root_decoder(). Simplify the implementation by
removing function cxl_port_find_switch_decode(). The function is
unnecessary because it is not referenced or utilized elsewhere in the
code.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 50 +++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 60d2d1dae2aa..912796fd708e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3469,47 +3469,44 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int match_decoder_by_range(struct device *dev, const void *data)
+static int match_root_decoder(struct device *dev, const void *data)
 {
 	const struct range *r1, *r2 = data;
-	struct cxl_decoder *cxld;
+	struct cxl_root_decoder *cxlrd;
 
-	if (!is_switch_decoder(dev))
+	if (!is_root_decoder(dev))
 		return 0;
 
-	cxld = to_cxl_decoder(dev);
-	r1 = &cxld->hpa_range;
-	return range_contains(r1, r2);
-}
-
-static struct cxl_decoder *
-cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa_range)
-{
-	struct device *cxld_dev = device_find_child(&port->dev, hpa_range,
-						    match_decoder_by_range);
+	cxlrd = to_cxl_root_decoder(dev);
+	r1 = &cxlrd->cxlsd.cxld.hpa_range;
 
-	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
+	return range_contains(r1, r2);
 }
 
+/*
+ * Note, when finished with the device, drop the reference with
+ * put_device() or use the put_cxl_root_decoder helper.
+ */
 static struct cxl_root_decoder *
-cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
+get_cxl_root_decoder(struct cxl_endpoint_decoder *cxled,
+		     struct cxl_region_context *ctx)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
-	struct cxl_decoder *root, *cxld = &cxled->cxld;
-	struct range *hpa_range = &cxld->hpa_range;
+	struct device *cxlrd_dev;
 
-	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa_range);
-	if (!root) {
+	cxlrd_dev = device_find_child(&cxl_root->port.dev, &ctx->hpa_range,
+				      match_root_decoder);
+	if (!cxlrd_dev) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
-			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
-			hpa_range->start, hpa_range->end);
-		return NULL;
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			ctx->hpa_range.start, ctx->hpa_range.end);
+		return ERR_PTR(-ENXIO);
 	}
 
-	return to_cxl_root_decoder(&root->dev);
+	return to_cxl_root_decoder(cxlrd_dev);
 }
 
 static int match_region_by_range(struct device *dev, const void *data)
@@ -3706,9 +3703,10 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	};
 
 	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
-		cxl_find_root_decoder(cxled);
-	if (!cxlrd)
-		return -ENXIO;
+		get_cxl_root_decoder(cxled, &ctx);
+
+	if (IS_ERR(cxlrd))
+		return PTR_ERR(cxlrd);
 
 	/*
 	 * Ensure that, if multiple threads race to construct_region()
-- 
2.47.3

