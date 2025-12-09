Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010020.outbound.protection.outlook.com [40.93.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AEA30149F;
	Tue,  9 Dec 2025 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303708; cv=fail; b=h3g82yR87VwfEUjfBvzK9Cw9beIeaFY55ClrzGF7HI7zy1vbt3LxuVdzaPgYlajxtP5GvyVYoenoUt0wgeo6NggRAK5vyIqrD6s2l02gHiOgxs7clKxdGyflHmaFc6TcYzSiq5AHkqdzzfYBXKAI+HJ5XLOSLTWxDQ+iUXqocik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303708; c=relaxed/simple;
	bh=8Uod48PeKqzHymM8Ew9P48uC2xFyudVcVPURycG3SEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ih5MNq/6kGZ/uFjaqbRFDAz7FqfEsBukuNny2aXl/mURJDTNQLqCQAHPXjG9a9M3BrQfErMcVkC2HR6C3ALGvKZj+aKWdOOVK7GipJWJ0cNGmVMQriPxOUeyj242LsHsLQ9x7eV7QgVdwEPYFih36T4Vb8rmjEbIvw51bqBP1Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BWUkQx/j; arc=fail smtp.client-ip=40.93.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BWUkQx/j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dH3Zmo2C8N3/FJx7vMBocibnmQAvccur0QylAEgRLYvHK2IL1RbBkRe2aJ0wS3DlT6S0ulQ78x5cmupJTJc+O3hsWJuWdXXnSUnkocqhcpaMX62dOTXCkXw+mchS3trHW850adzRZD8uIUaXDGunuK1NQbfKjdbrJdLKpV6bvUUxPJ78tZZakf36arrZgq4WgKlumNCLWMGHO9BP/3IUYkUcxouNXEynO+UV4LxTs7dIgkwWNMuAZoFLzcwEx0Z+sihlggfn+WHOeRjMOSte1nVpaNFJQu45XeJRzdb5+RVAW1W6i0zRTeodSX/aPwDuARFj3mjWWoSE60nSVUYORw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9UwJtm1ZjE2xGsmQ1LyN2IBLvynoW4Ns5Zvg+6lMuY=;
 b=G3MuRqLccV2nbcHKh8dioTR9MUHArbyl+7/TRwbiQ9IVDVCxtbIveRfkDCb8kJJmIk+PJ4++5YQQPhJOLGYmFrAH+gKTCYTQ8VxABi/7cVviYM5EBRDXrGHC2ELJZBIGWVfq40HDq3r5B6GgSvbJVSH707FNS2Ga6ERbLMfH6S+OA66r/mUY8YL+i7YPquoIs2FOpZKIqmYb0bpBhzeBItTBQhIN6NCpFfpduHOJOp3QIjKc3IWiBbEp4eUcy83wRSTXK75L3EMEljGiMyCPqev7UWIXvKUTXJIVewBp4C/ezOAHcmrCsgvqxQOT3rtvqPeR6CmsweoagMEkCrhkEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9UwJtm1ZjE2xGsmQ1LyN2IBLvynoW4Ns5Zvg+6lMuY=;
 b=BWUkQx/jthU2E4Dg5NjogptWqThZ1iYWBGWeryaOkGvfetX4s+UasZwLLoIiaClEqgnBJZMTmEWxPPiq6nT067PAV9RAGxS4FiUDajvBksRKPWGe3SQVRHUj4HqWh2qBSSSP/ajK7XRdShWqK5hBtaH7UDPPeL7KjyZI59aWI5A=
Received: from SJ0PR13CA0037.namprd13.prod.outlook.com (2603:10b6:a03:2c2::12)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Tue, 9 Dec
 2025 18:08:24 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::15) by SJ0PR13CA0037.outlook.office365.com
 (2603:10b6:a03:2c2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.4 via Frontend Transport; Tue, 9
 Dec 2025 18:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 18:08:23 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 12:08:20 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v8 07/13] cxl/region: Use region data to get the root decoder
Date: Tue, 9 Dec 2025 19:06:43 +0100
Message-ID: <20251209180659.208842-8-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209180659.208842-1-rrichter@amd.com>
References: <20251209180659.208842-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|PH7PR12MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a21206-6671-43c3-4caa-08de374df185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i0qYTXD+TFhrlB3mYPwbbgsK93jHnCzrL/tBn3iv7/UZi/w045zXOow+CgNS?=
 =?us-ascii?Q?fiXJo2+JQjUEhKPJRoHDR7rmdv9R5C6pths+zjm8JN75TGJRbv2xPy8oTRTw?=
 =?us-ascii?Q?RhQCc/q9WFnQsdxbc+QYrmsto+pj7C114PsE3PFZdKIHgzf8Qhn7e+aehj++?=
 =?us-ascii?Q?IYi8rxbJIza2Yu7eYqG3lcW/ubU896oVRUzLLkX5Iyy9N/G58JHymuxDviT7?=
 =?us-ascii?Q?8J8wRhY0VRgHzv7HwUXcMsc3PR5dupwlG4/isD02XY1qtaQsvjfiLgUhFdPH?=
 =?us-ascii?Q?qCYUiudaVkL5MuDc+52hxltw1bUqjrlWzGdicZimBW3io7BJDHpuZNf4z26F?=
 =?us-ascii?Q?dC8d2S0bnb4tpRutFTpaNRPAVfbNQzDQR/I2mhsJAIbhT2k0Y5L/Job9Vm42?=
 =?us-ascii?Q?7IpLuLUksBMFeiWX6od3QYAx37wIKV75kSafXkZy/Po6/mjBzW+IH3DK7nn0?=
 =?us-ascii?Q?BRWcI6oFP+j3E6T04S5HiMYJ37SUBKccKUgqGAcqhYsklqL5VlBJ31IsjM5K?=
 =?us-ascii?Q?+Fcy8Xp1aSCHLGOg0R52KqHZWr/bTJs9Zi6/m89fqqo7c3y25V35a0s8KbJi?=
 =?us-ascii?Q?rf5udJsPi9S6nE/Tu0PFD3YK+yHetyOImjNPmQvux0EIj47wdHeVOyOLzedr?=
 =?us-ascii?Q?6tP+W/2TVBP+I7x2Y49oKbeIXnUXXaTm9HydlwidKjibPZ6kl071Cmsx0To5?=
 =?us-ascii?Q?f/9Fmmx81o+ID9h+Za4kjvqz8vHJ3HmSBv6cZl9dSJYfDK3fgUrbULlpEILH?=
 =?us-ascii?Q?pfoAzMaLHdJYmlSX9ywNqCH0H8zeUAksCTN2QOe8LeX4iDIACYbJiQtrXcDA?=
 =?us-ascii?Q?ULce8SXKwqSGo5x/mLCYRggUzpZVvm70UUrFQXWpOH8TIFcNPnrZ2sXds0S8?=
 =?us-ascii?Q?f5D/slWJK7jzgKTEdzXMD8Ha3c7QLDWxEmpip5fl9CzTiAVih7zdA5H4C20K?=
 =?us-ascii?Q?WD6rGAWav6Y9u1fPMRlOcA8mGO0nOGjCZpVU9Jxg5KypbZu77G4nVRsq250X?=
 =?us-ascii?Q?hGR0VCuOq2yoD5jZ+gqGMOnkYCqyhm0+ro6PKDusui3B1RPU1MS/XQGJsFlH?=
 =?us-ascii?Q?pfRFc90zfZBfDCUUxiPVNMuKyE/TU0w8LWpRhhfm6awW+WoyQM1yb1pYXoJy?=
 =?us-ascii?Q?mwUsTBwiJkszgoETg7Mb1SIExBELg3zjlb2DKoNvpPc9VBUBBS7a4MYrimM6?=
 =?us-ascii?Q?of6LuK7qaYc+bmEDZJ7AhzuUio+BD1Oto3Lq6XtzpWcs5ODgW2eHslRXK2NG?=
 =?us-ascii?Q?WtblDAgbHyQ7EQ6flhPHZobo/vfkNmqyB0/UHfTZg6xUXsAKfGlO/Ac5/GQU?=
 =?us-ascii?Q?sZuc8OFxWgkVZJDDfZebuR6vmKUxfNxfMdeyCtCzjcek0X0+5bUZ28O/UnmO?=
 =?us-ascii?Q?h3rUDN6lGW7rvJA4Zg0kVS0bkNn6FrxFpNPBtKNROE4T6oMGmO9GcFh56ald?=
 =?us-ascii?Q?02i+XmyVO4JEv0u3JmLNddrGdQdW/tm4j065LGc/F/1c47sfmUYdWFimfQTw?=
 =?us-ascii?Q?/Ij2ct8bP2H+bXbsZl9MJX6hffADxoO3U1K8++t3MMEzvABPzzwHuPN1/7mF?=
 =?us-ascii?Q?xwfMHyiMQbRd667TclU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 18:08:23.6470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a21206-6671-43c3-4caa-08de374df185
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396

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
index 71e80223f475..e4efb281def4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3466,47 +3466,44 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
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
@@ -3703,9 +3700,10 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
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

