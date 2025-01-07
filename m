Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B421F9F62;
	Tue,  7 Jan 2025 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259139; cv=fail; b=YTBpw11CnTBQGG85Bt+zZUme92S0v9cYBG/m3qvSILyEfLMvCO5wAsBT2jwdA02nSuRk/R3DmT9PMp/GW3lFVMtKkXh3OPQiQPVmBGjjw/q1lL0i6xDy60HCoUQg3GIqkbXv291B1eqJOez2a0YAUjPCRb5psiaUkweVky0rTSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259139; c=relaxed/simple;
	bh=1bRgQmNnBd8YlnuEkwby0ggKjyWzPSVrY3rP+h1aYp8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inHVc5JGVD1Srb1S4Hoo2oGCTzaBWRnzBobhqcxVfKMrq0a0gSbT90+H1Xuu418nKA2Z5RhrXHwPbgZenUA2N2np0VItmOsGDX40AqHx0NtJNVfk+sZemKqpTygK60jYxRRPDQm7P/srwKCR8lv3uKdH46f8+7Pt5e+4egWOMXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PqozN4Wv; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PqozN4Wv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGzr3AHLxE5W59fgb2oxqQ75qzFSEl9O6CMbXZvOxwmosYRSpWBJdh97ZhWgRhzCIcq5GnKPydxuE2ah+ufZtbsGqFPAeq7qw95ENxS8nmqGwfg7F2LMwVCLmyY320awxfeygTOw+jEvBXCnPAqReXv6AwTQj5sIfy0OL390hB23x0i+veOSIz65UXY4Q2e+gFc/g5N6WMUjawOZls4QAfRZqcLYGO9/h7coR00tN7+wVQuQr+kff+GxHGz9THwzSNeLTiDrmVtAjs1ELPVKcAOht3ugFAEOqqAlY4QXoaCV/bx/1Dai8HAo9ou70V0w8+Ia+jUlehhvFa1wjgU66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAzuidAJrMfw7DRjezyawEeEkQue7uR7vQtmyTOR2IM=;
 b=VaUMajbwX0aO6ybGzGDISD6GQQhpXizJzBZv1djllaxkG8jmh3eIbYBdnDeLIS9O3mmKvzraPFkkBZBolx1XtRS8Q5/QGP/yKdPx9e6Yz2Cj20j+GkzQ2INZqEbzrAm7jQhQ98boQ3yNe7RDAjfO+wtiCFu/V5hBJZvusJTmwFIFouR29HgKR6triRfDt6oOZRyTn1L5pBgeHyyXQrEjmfjrM1/DwzIaDyKCTePP19Kn+/gaYy9Kvk/dki6FLUgHVT0hHubIqhxVQHZKekDTFT9uJ4Dot/O0rRiNTWv+4tyC7UWX/3K7KoMBdTiqq6PPc0mMlJ9rlqngH86khvppkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAzuidAJrMfw7DRjezyawEeEkQue7uR7vQtmyTOR2IM=;
 b=PqozN4WvqN7wm+C8wBBvGf4kJTvqmox6uhh2rXdhHHdhpOT6s/sbSGIc4NMtN3qOcttOHiyQ9tVUcpUQjvc1BFWnzZ1fYa6SmXYoKa1ffOwPa5ssLjsZd42AZG6AkNKZiU1mbwrqTwVAWbnIUBtvJIhoJJyKh0PU36Nz493RiIs=
Received: from MW3PR06CA0004.namprd06.prod.outlook.com (2603:10b6:303:2a::9)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Tue, 7 Jan
 2025 14:12:08 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::14) by MW3PR06CA0004.outlook.office365.com
 (2603:10b6:303:2a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 14:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:12:08 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:12:04 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 24/29] cxl/region: Use endpoint's SPA range to check a region
Date: Tue, 7 Jan 2025 15:10:10 +0100
Message-ID: <20250107141015.3367194-25-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107141015.3367194-1-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 3599724e-e87a-4c9d-31c3-08dd2f25458a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+VpeDWFK0L8VUTMa/RmKpu9zKp8kdlVLIS2gC5Eev3aNbeGWUEoD6P0dHuGF?=
 =?us-ascii?Q?BUGER5oTrJJpDH7CAV1nH7MXXwqyD/LVnjOF5W1AMh9439eW3mRVWabwRhMs?=
 =?us-ascii?Q?spPnF+GnyEI5AtGzRfxUYJrlWLTs3a8mBIBrEAwazcVErQcRCWM02iUMoF82?=
 =?us-ascii?Q?5xQ9l40paWe60t74BrUBociK3FzJ6OnxHCC8eAmPXOsirlGgSecij1BpOl/M?=
 =?us-ascii?Q?x4YbPk8HXUjZC9jQ8LTkwNHj3pgJ8oeMeDaX+8ebLL14omW3NmDU9oGq1a5O?=
 =?us-ascii?Q?Cl1P2n5nUb5lRGOtql2jis7sA3ptQzRBtl0b55fOZMpXO0SM3LNGLZlALZsr?=
 =?us-ascii?Q?isDSldOq4YVFQYBk2WVOxH8JJqWXD/59vINaouZk4iXQvI+EmYNrRrkI6L/L?=
 =?us-ascii?Q?2LUqtW18nK/ZJMb6Tot4rvgL06MVcX+CCcBgcOV+9PMbRP8NQcFMEA6ju0MM?=
 =?us-ascii?Q?ZzTwffc3YgYSNlJLW33kU4EV4vB/sSInqUxPGBZYcd0Fw9yN9jDMLS8gqEve?=
 =?us-ascii?Q?gtIOqLZdz44wX2SAvdCqrQzQI5RhJ0Rzda2HUU07/n+7vFMtomPNsA70p4S+?=
 =?us-ascii?Q?iOauiVr6BQxfrUYS5drnxM/XTL7thRt0O/cnKONPwJCCzNqXF7Mek4beT0wO?=
 =?us-ascii?Q?hZmkv3ddsFpOAaU81UqnAoQU77IoKazWDdjF1dHjblY5QWRgk5lwMPBbeUBM?=
 =?us-ascii?Q?2lG4KYmRC046AEX3PGrL+skhxSflpK5eHhoIsYV4yifP/oSo/UE9o3dO/b2U?=
 =?us-ascii?Q?U4u1rf0XhWhthxVnklo8USkcK3mOW62Euen3CPxcOTi1gJlrgmjxBuEw8OIz?=
 =?us-ascii?Q?U+hDIU/Xf+0JBptMatMsLLMNIHsf5hDH1aAra1JCgmNcNDkl7agsNzhy1yK9?=
 =?us-ascii?Q?Is3Oo5x/4rdsg6Kxlb+KLH7GMMMkLFn4t1A4EOQK6o4XZHSuO8tFySWi4ycl?=
 =?us-ascii?Q?D8NipX2//GP1rl9tj3iCtbzQmetJ0/0CyklXSo5fslS+HhXTNAex4lfIdbDf?=
 =?us-ascii?Q?sRwEjG+Q8VxEgGLn/GG6YCxibo6OL/Wo8J4DhImLp1vZK5JkR4gpY4z+g7Kt?=
 =?us-ascii?Q?AxbpeG6c6IPborUhPTcDdZT5WMAQ/9vp4elVCn+lgiCm1Cot54l7CGCdkLV9?=
 =?us-ascii?Q?nktyKYsD64IkGR5n2vAYJFXqMG25NAivJeRtjKDvndPyGB3J/cBkeltEl6/K?=
 =?us-ascii?Q?ibbZaGMRNW+/QVX6nXyYVTRM74zgbkzUpyA7ljC782MFJAOp6rpfIVJqbnWS?=
 =?us-ascii?Q?6eh5aIupZJ31HsjDX+btE1exfryw9LjehBiFWEEtIWh98H8sCpMYCSPcPtfg?=
 =?us-ascii?Q?eTzDMjYPKYLy07noczjuDG+gO58VcE4QokZoN+Fp6QTNh6DK9h5cdYMVg9+/?=
 =?us-ascii?Q?U7cjlKE9C51ITa5vG5jnfswVtXCrhtDBdrjWO6gmTAgclgsIbxQ76kGYFqDW?=
 =?us-ascii?Q?G4+2/ZdbZHU1F/rB8Q0BRH1hSEcViEqIFSxBYd4CD1b0sHGyzTt17lZuQt0Z?=
 =?us-ascii?Q?AjhShcxQz29281c=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:12:08.1271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3599724e-e87a-4c9d-31c3-08dd2f25458a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409

Endpoints or switches requiring address translation might not be aware
of the system's interleaving configuration. Then, the configured
endpoint's address range might not match the expected range. In
contrast, the SPA range of an endpoint is calculated applying platform
specific address translation. That range is correct and can be used to
check a region range.

Adjust the region range check and use the endpoint's SPA range to
check it.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c3322bae05b9..1dae7d36d37c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1516,22 +1516,26 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != iw ||
 		    cxld->interleave_granularity != ig ||
-		    cxld->hpa_range.start != p->res->start ||
-		    cxld->hpa_range.end != p->res->end ||
+		    cxled->spa_range.start != p->res->start ||
+		    cxled->spa_range.end != p->res->end ||
 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
 			dev_err(&cxlr->dev,
 				"%s:%s %s expected iw: %d ig: %d %pr\n",
 				dev_name(port->uport_dev), dev_name(&port->dev),
 				__func__, iw, ig, p->res);
 			dev_err(&cxlr->dev,
-				"%s:%s %s got iw: %d ig: %d state: %s %#llx:%#llx\n",
+				"%s:%s %s got iw: %d ig: %d state: %s %#llx-%#llx:%#llx-%#llx(%s):%#llx-%#llx(%s)\n",
 				dev_name(port->uport_dev), dev_name(&port->dev),
 				__func__, cxld->interleave_ways,
 				cxld->interleave_granularity,
 				(cxld->flags & CXL_DECODER_F_ENABLE) ?
 					"enabled" :
 					"disabled",
-				cxld->hpa_range.start, cxld->hpa_range.end);
+				p->res->start, p->res->end,
+				cxled->spa_range.start, cxled->spa_range.end,
+				dev_name(&cxled->cxld.dev),
+				cxld->hpa_range.start, cxld->hpa_range.end,
+				dev_name(&cxld->dev));
 			return -ENXIO;
 		}
 	} else {
@@ -2051,13 +2055,12 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	if (resource_size(cxled->dpa_res) * p->interleave_ways !=
-	    resource_size(p->res)) {
+	if (range_len(&cxled->spa_range) != resource_size(p->res)) {
 		dev_dbg(&cxlr->dev,
-			"%s:%s: decoder-size-%#llx * ways-%d != region-size-%#llx\n",
+			"%s:%s: SPA size mismatch: %#llx-%#llx:%#llx-%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
-			(u64)resource_size(cxled->dpa_res), p->interleave_ways,
-			(u64)resource_size(p->res));
+			p->res->start, p->res->end,
+			cxled->spa_range.start, cxled->spa_range.end);
 		return -EINVAL;
 	}
 
-- 
2.39.5

