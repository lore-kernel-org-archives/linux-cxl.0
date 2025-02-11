Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE151F3FD5;
	Tue, 11 Feb 2025 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267711; cv=fail; b=m61KYtcaYIDcvhKFu3Z/hDaIJN20BwjpnkSYtR/gUgCdp27fdF+AlOAEnpSVXlli7gUBiyRCuSjyJgWMPoZsIsyxWbM0lXUhtMegj1E/Jd24MmNi6ZpJb2I8OpSq77k2WsSIMhXX21OlezFPpFP1Vga9pIX+ctXYthNy9jWeJz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267711; c=relaxed/simple;
	bh=eXY/UiiI5qCbcCI+05tDl6pqFT6aB3pNX9mWth6j8pg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6eOvrZ/z0kU6gT3+ISENhmlJX2I6AVq4ZfzZ0/ldL+A3hfPuUbkzo2GB/ZuVi9H7dgEQNvgGWD3FnZZ25i3L3Zi+gVZEJZt6ictS0teIyTYTBy41f9zYKvdMaoFVK4jYa1arTgvlY8OoOCU6Dul0Ywa3CmESz1zWQYBsgIj/LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K7sAflwx; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K7sAflwx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffve97t7+iiMz6gFOasJW8j1CjDKjT1fOt3WAi0QW6zQUQA3X29liQ6FwFPpII0FiSgGebmtBiGwSuPD01kjig0l2FuueOAHeddN2OcSzpPGxCCmNbnFBt8yBmpRGrFkJqg5c0pXSeh8OfTw1e0QR7rNDGNv14pRzxCl38CUOXsC0XDTMbkV/+3N4Uq0NyQ0QBf6NWsyeHANu4m6EhnEA+TUJTbkCCRVwWm7uG4CkVieONwmjkHzxFWF3vNXDAyh68MPBG9Su8f+b/Rpw4/neoMCeM0hOdQaBESp8xe6wcNBFbFoA4/lHEasty0LCIAxU4ep9ankdoC/hSoeLVM3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTkWcxULBAqJbGCoTTIZjAvuARv9agc04ZWt8/i0EJc=;
 b=REmXVnIRwdthtRkoUetM4l50AZzMvM9n2ztVZi9T3Cn2VYTbn5eOtQt2wrn9pCS/iyfanjg3VkXCYjRtUtp0jqgqw98NjFWcTTWhzEVlTNXdK+9FWD0ifI2Qy9bXpJF70nFNXn0LGN83ZiakvKxWiQxrEg79t4GBqdQdEVC7AgdGukIeBZ6/b1fOXzUcAeBxk9740qMnpCeKEU9F6jjjukLCXSckAelmnmhz0Jcxlp2UbJrndyXZOQ1qIGKOPzpY5tBKiOfLIk9EsCmTpFvbVOGuKRfjC6NuBHxp1CQtxY/x4Bwv9YlIwK3uW4Yu2QYYK+Y28h5DXloumkmoQu4bPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTkWcxULBAqJbGCoTTIZjAvuARv9agc04ZWt8/i0EJc=;
 b=K7sAflwxHvg8KdQLnx7FV7tlTv/yRBi4DwIjzQt5SmMoJplpiLMZq5I4unKgsOaONmOYfKDwtKtT1XJXfVicpGMCLMkmULmB7lzFcqXQNKOdEw6HgjhWMRIWINCxsgGaHkRkyF0h+rf19WdiYglBCnZipLzyi0r1WqPa0e/Eipg=
Received: from MN2PR10CA0031.namprd10.prod.outlook.com (2603:10b6:208:120::44)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 09:55:05 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::60) by MN2PR10CA0031.outlook.office365.com
 (2603:10b6:208:120::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 09:55:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 09:55:05 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:55:02 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 13/18] cxl/region: Add function to find a port's switch decoder by range
Date: Tue, 11 Feb 2025 10:53:43 +0100
Message-ID: <20250211095349.981096-14-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f00ff2e-34f0-43bd-e270-08dd4a82293a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VsOdameZolqA0RS70R9PEdnYpaiN2xP91jla6UMcACjz4NnBsMw4J44DpGD9?=
 =?us-ascii?Q?ZGMaHRhdHHB9KIBoZAWpxOVSma7Xd9wgodXdfzwc1C8bGDJLJnrOEAHQi7ef?=
 =?us-ascii?Q?P76ubck8AuyZKjZ2xp6K7ShH8ZBII+U3TUpXAHS4g172thdcmgQjDCEjw/jK?=
 =?us-ascii?Q?eJa1V1CNUiT1uVbVKhe9OkWauXcQYdPDs3VEu6jzv/c8Mfse8WSA4uwS8sgn?=
 =?us-ascii?Q?9rhGUV5rx/LkvFd0gpKQ5tfRvddpkQthQdBt5WeNz/M6WgRofexG/MuI2CEJ?=
 =?us-ascii?Q?mRUsdFA/mQ5EgIfTCZLu/YQULsczkJ6kqmQjjRxxuASG4LPUfMqYMx9mjjIn?=
 =?us-ascii?Q?5Sife7KFYeYswuTjCXWdbH/rQP5MbFs/876qwEYt6Xq3Z9kPCjG4ynT9Jz9/?=
 =?us-ascii?Q?6ivHAjgtqR76nClrNq7jqj1bCvHPFO3YXdmWO2pmtsDuIEnBQN94rtCEg57z?=
 =?us-ascii?Q?dI6HkStPMUOAce8VyuLXXQbd5XkTlnQD07t18WPEbeKEMPVgcdY0nGUKZZWY?=
 =?us-ascii?Q?vTjFIvq3hyepnal8XaI9avIx8m9FK5N/cLQHtNImbw81JwIAA8duH+MZVv5J?=
 =?us-ascii?Q?HCnzyYWx8MwgtDUbtDqs75Lb42LifBPeSuSzfeuQ+ZJuJIKIIKgX/K6R6opz?=
 =?us-ascii?Q?R9/caE3ryEyM9fE9w8xR3Qk46Yc6y0m0Yp2x3OzVFGVArVMMejSAGIP2HVHb?=
 =?us-ascii?Q?NUGUF42R5LMLoRmRwZ9vLTS6XGeDewDwC+T1stKZcNTvbLju+dIahHy66LOv?=
 =?us-ascii?Q?U553lhXnBSF7FUchHTY+ak42XJqF7qh/TPshRPdvdNbTCLa4+0xadMF1UIE3?=
 =?us-ascii?Q?i5HzP2CQJ6bIcuyW0dM6c/dXix0lYMWBHEbQWh7Get9IbUuOj4Z2anJ+S5On?=
 =?us-ascii?Q?L2J9f8HuVxW+m3ONnljnbyAYMilnwwDXIL+k7JLNQml+NP1HpODBAI4/YJwO?=
 =?us-ascii?Q?i7RDu9b9B6GAlPtj/g8eLeEllXzY5VsDOLNbiy16zeGN4HKRZwE2WYvIaKyF?=
 =?us-ascii?Q?3kF8yy9W/N2D1YC8Q0ViCRIYi+KJBgbttBQgoOPpZ6dX1x2kqOEjNsNeA37k?=
 =?us-ascii?Q?o95Wfu0MpLvc8F3ubelE5ZaF4smel8/lXr0AjOoMnkQDTcSzH8WrSGe9QPcS?=
 =?us-ascii?Q?MN/CifFqkH3MPasYEbIh36gOalXlrfPR9YrgRJZPPPbi0+9K09ykKJ9a0ADo?=
 =?us-ascii?Q?lCE5XMJPHxxu5aNFmo2cz+qPf2RTQA+0nsEtZHTtMriGeLchmiZzMlWUYRGj?=
 =?us-ascii?Q?kAG7s1Cv7SFrg6OvunASwmszUPuJ+ycaX2fGp/pEFCmPfv6KzLTCCDNv4hoO?=
 =?us-ascii?Q?xKfT+xV+BJFs6o5mM7UjvdTgxTu5tzZv6Ru3/PquzT29vQA7MzHzsGoKyLzL?=
 =?us-ascii?Q?ApDAHNmsWKnofRvAPcC38WKMAL1CKf5Uaug5W6P3YDbbR0blwDFfmnB7JXoj?=
 =?us-ascii?Q?bWm4j5BbnWgku5Fg8waqSz9g5cDlYwlUrWfKOJlaz1/Emxw7Doh7aFXkyrjU?=
 =?us-ascii?Q?46h8fJ0qHrrYD7E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:55:05.3782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f00ff2e-34f0-43bd-e270-08dd4a82293a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031

Factor out code to find the switch decoder of a port for a specific
address range. Reuse the code to search a root decoder, create the
function cxl_port_find_switch_decoder() and rework
match_root_decoder_by_range() to be usable for switch decoders too.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 48 +++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cfcd235f311e..72e991e7d9ab 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3189,28 +3189,44 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int match_root_decoder_by_range(struct device *dev,
-				       const void *data)
+static int match_decoder_by_range(struct device *dev, const void *data)
 {
 	const struct range *r1, *r2 = data;
-	struct cxl_root_decoder *cxlrd;
+	struct cxl_decoder *cxld;
 
-	if (!is_root_decoder(dev))
+	if (!is_switch_decoder(dev))
 		return 0;
 
-	cxlrd = to_cxl_root_decoder(dev);
-	r1 = &cxlrd->cxlsd.cxld.hpa_range;
+	cxld = to_cxl_decoder(dev);
+	r1 = &cxld->hpa_range;
 	return range_contains(r1, r2);
 }
 
+static struct cxl_decoder *
+cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
+{
+	/*
+	 * device_find_child() increments the reference count of the
+	 * the switch decoder's parent port to protect the reference
+	 * to its child. The port is already a parent of the endpoint
+	 * decoder's port, at least indirectly in the port hierarchy.
+	 * Thus, the endpoint already holds a reference for the parent
+	 * port of the switch decoder. Free the unnecessary reference
+	 * here.
+	 */
+	struct device *cxld_dev __free(put_device) =
+		device_find_child(&port->dev, hpa, match_decoder_by_range);
+
+	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
+}
+
 static struct cxl_root_decoder *
 cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *iter = cxled_to_port(cxled);
-	struct cxl_decoder *cxld = &cxled->cxld;
+	struct cxl_decoder *root, *cxld = &cxled->cxld;
 	struct range *hpa = &cxld->hpa_range;
-	struct device *cxlrd_dev;
 
 	while (iter && !is_cxl_root(iter))
 		iter = to_cxl_port(iter->dev.parent);
@@ -3218,9 +3234,8 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 	if (!iter)
 		return NULL;
 
-	cxlrd_dev = device_find_child(&iter->dev, hpa,
-				      match_root_decoder_by_range);
-	if (!cxlrd_dev) {
+	root = cxl_port_find_switch_decoder(iter, hpa);
+	if (!root) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
@@ -3228,16 +3243,9 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 		return NULL;
 	}
 
-	/*
-	 * device_find_child() created a reference to the root
-	 * decoder. Since the root decoder exists as long as the root
-	 * port exists and the endpoint already holds a reference to
-	 * the root port, this additional reference is not needed.
-	 * Free it here.
-	 */
-	put_device(cxlrd_dev);
 
-	return to_cxl_root_decoder(cxlrd_dev);
+
+	return to_cxl_root_decoder(&root->dev);
 }
 
 static int match_region_by_range(struct device *dev, const void *data)
-- 
2.39.5

