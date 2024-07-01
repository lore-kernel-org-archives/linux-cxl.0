Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E0416EC19;
	Mon,  1 Jul 2024 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856117; cv=fail; b=UbLouoT1d8ie8QXLHKgIAXb0DTVD/KF2CGLWJRqjWyHJpZOSC2m8LnxcTPxq9zJ22cIOkFxfb3SRq3ngzDcCd0JTjCGHIK0zHzQldHwCjeaPPF3IJ+RAM1HRyXN+XlThTvpFPVzTiXKeIrKnnsyyRYJWe8dBbwlM5X7RkW2dWsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856117; c=relaxed/simple;
	bh=i1Isd+rAPjpLFj73cHX5Iy78ewxgsubyerpMCUB8Exg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZirtSsnmGsupHT39nH0r1bmSlvPxkuB9qYOh6mbgSZomKjZGSPGAntlrJkQ9apsXiGG98jOC5FawBDjBL+pnWfHqKl9RvZ29jcbE5HGWRahAaiDtiq41gv9Clu0TfWm1L8pSrIdNZfyiwfpeFCsccD7LO+pS5pFU5gQdSj0LKaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wi3L4vSj; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wi3L4vSj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2SO3ziq3KL2n7Of7HLWjwszAPkBvYLI03nqrjzGhZHRQa4Lksc3EyYu4kP0Vt8GlNhH1sQVeYEmIaLf2817ISCBStb82gRy/Gz1i831d+UOcRpt1XVa15luSxd2nyLvPbHWXDiW7qfOYdMjCeilo2ajUzzbvpVLxKi/7cb74wg9anptd+nCqqsj9HV0JZXWo3EznAGV/fYXMINwNJfqPsl2qX2JmheKas3nfuGoiTYe9SvT9eZnlp0vn98vn7PNSKHOQMyZ/i+ln8xcKp7/JF1Wr06gRGEXKXF68EFQphwTvcDe2ikhLsAFdEEDb/1eDg4KiYHJXfs5JJ9PFJjlAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xgrn84JS7zg+8EfybpCUjXN8siRMFlFrd5niEZIv09s=;
 b=m3fP99Xcfe8QQFsf7fwOBB3owo6tGsKGOXt0V+UODXHYN4SS/eyzUIjqlgg8xyQj4ajH41xVdEpzJ9HGFVI/tlS8hgkornsZw0TTMfH/URseqsNLcaJNy6XLCHT8y/4GLEVGLxyG2vVu4G9r1HAxXF6o1503P3j1wKVkqycVKc3EsUE4+ED8VhIBKKshyVISBDg+rFnJTJjmqzKCAIt1fySGW87BSx9UihhHTl1M63mkStkI2m1UJ3YmDebBBpgYnnoWPVLW5hdA/GG4VV1+nQ4lq3AJCSkcHakBTnpm+wZbQh4psURPbJzQa5qSLnFeWI9HhTPXkhIhD+B5w2aavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xgrn84JS7zg+8EfybpCUjXN8siRMFlFrd5niEZIv09s=;
 b=wi3L4vSjVM/B074EAEx928eb6vHO1iJRN3YSsnJjYU97hhjnHp8iHcNqAuFmBHYhJWnbmOk/oRVzvjITOGFgGlNhUOwQnsX99UwlGhBnXMIVF3vIuYaSYEexAwWAnikA+RHxo0N4roSCtTDCtPkls53IF0TvBs5co/W0COgseRo=
Received: from SA1P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::24)
 by SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Mon, 1 Jul
 2024 17:48:33 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:22c:cafe::89) by SA1P222CA0029.outlook.office365.com
 (2603:10b6:806:22c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Mon, 1 Jul 2024 17:48:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 17:48:32 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 12:48:28 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Robert
 Richter" <rrichter@amd.com>
Subject: [PATCH v2 4/5] cxl/hdm: Setup HPA base for address translation using the HPA window in CFMWS
Date: Mon, 1 Jul 2024 19:47:52 +0200
Message-ID: <20240701174754.967954-5-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701174754.967954-1-rrichter@amd.com>
References: <20240701174754.967954-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SN7PR12MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4a8632-51cc-4b16-191c-08dc99f6067b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pTdL0kt00QjL6G2HPW4gavFqFbWhCX3hVqQO/Jxm6qdlGN40JmCYDXvqLXHt?=
 =?us-ascii?Q?o1xs5xJVssephvFLTxX8YgRK33fccIfzqsguEtm9RB55Li8Ug8g7v/gazoJd?=
 =?us-ascii?Q?xA02JAUTnKNzYaEc0aUy/8fVjal+85Ig2jP2yz6dDS7pSGEbYufyOjz0FZ2Q?=
 =?us-ascii?Q?PX9VtAeQNVXdK4HKNF0fADJL1LwmOUOkI5VHPyONtK8jF3hY4q7Xpax1vj1O?=
 =?us-ascii?Q?hlB5AIca0c+xHTRjq0EOKULNXOdUBUfCccxDWWurM8uPpnK18uWhWHxH3i7o?=
 =?us-ascii?Q?gcmTpYxFOY3GVv5CYRcn9oMSuAJPlLvnK/TxEVZ4tvJezYfzez2QNj2r99Ju?=
 =?us-ascii?Q?Ob/1HdpYUYuvaPNuyaOVwrc1iOzxk4ESPYE6OHnLs3+DVeHI3e/0sGwt4h5S?=
 =?us-ascii?Q?H8Aa/LoSknJaA3RCAJBqfQbiCf62UfepJVk8HJSjsPFnHkOPhFkyqoNn8tuq?=
 =?us-ascii?Q?AlrR3aXsuRqNIMhJ17GdD2GoBzDhKca2wCEtUhL9NUG+h+k1VYH0r0AhGx0f?=
 =?us-ascii?Q?kCDSLXG/sfw7Em3CeQW49xovz1jnE+NKUgeJgbedhcmtafb1OysI6qbZcmBm?=
 =?us-ascii?Q?A+P89JKE17p2mE1nigNbJOtL2zs6Rsws2m5p88TL7ff7zG+Pz60XMyOk3Zm9?=
 =?us-ascii?Q?ElOkhROywvVl54522mhMXWmDuiJDl7KzLZUoDW48BfmVkFiedN9AhSSvnxiX?=
 =?us-ascii?Q?MsdnezISXXebgtzTIYEwHPwHBCY0P01xPCutyhfLO7AvMx6ig0f7ImzR/rVb?=
 =?us-ascii?Q?dfbELrJB7mUVxKSDZU85anpcnTWqTNgzD2m0Wu/rje0w9CutshhnhPWjpZqM?=
 =?us-ascii?Q?X1JJ8KY7cIiL1MBFBF1z1jZCj7eOl7shR98L4mIVWs/B8GypD0LZ3kXtL74n?=
 =?us-ascii?Q?HE1gYkl+NFmfW5E0GF9x+KfXeohwMGFu4ER1OkbZMKDxsYw5xl14jeKH4hR8?=
 =?us-ascii?Q?T5+43mTYtYNTmm+fKTEiDcJB85QMA8I7p6N3pOGddQhmmeNE4BIJxofPfdZT?=
 =?us-ascii?Q?XFQg/mKhTG10C0nmy7N65zUhDCpq83xSUrF+yI6C8lb/fZlnoip0Z75AdSpg?=
 =?us-ascii?Q?QyrRUkcgXqfmh6O550zKxnuVnom9SfLg401xDkS2VgMlsBpOG5izj5WzOK7d?=
 =?us-ascii?Q?BMwdfYV70FSN6T/CEpbJ5UzXIRLNO4uhxuGiMEGN4p+SPZbmPxOWz8Xa3xPL?=
 =?us-ascii?Q?0dfL4LeNjTeJMGPSU/p40pi8hhasphcnTuCrTcPsMvgkr9xAYOlQSm+P2mcV?=
 =?us-ascii?Q?kOyifODvpxuaVXkci/zZGjoPQMbWZIg6zyMBWsZNapGraZdgKL/lQmqjQxCL?=
 =?us-ascii?Q?Kky9ypKyvXcv2UoMjY6UO5YputrbNxXvYkrB/oMdEzYx2vR69AGpgGIkp6YY?=
 =?us-ascii?Q?cXhFomRW6KY+NzrxO0w77YONN5m2jlT2w4QTsqSVZJ0edulSQ1w9DivViSPu?=
 =?us-ascii?Q?V8C1dwY8MiEdPu8wb/LeJdGG4qTk+5sJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 17:48:32.8721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4a8632-51cc-4b16-191c-08dc99f6067b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8817

There are platforms where an address translation between decoder's
(HPA) and the system's physical addresses (SPA) is needed. The HPA
window in the CFMWS can be used to determine the address offset for
the translation. Each CXL endpoint or switch is uniquely attached to a
CXL host bridge. The host bridge is assigned a unique HPA window in an
CFMWS entry of the CEDT (host bridge is in target list). The hardware
base addresses of a CFMWS is an SPA. With that, the offset can be
determined using the HDM decoder's base address from the registers and
the HPA window in the CFMWS entry of the corresponding CXL host
bridge.

The CFMWS entries are parsed during host bridge enablement and set up
in the CXL root decoder during CXL decoder enumeration before a CXL
endpoint is enabled. That is, the endpoint's host bridge's root
decoder can be determined. The HPA range of it marks the beginning of
the HDM decoder's base address and the offset between both can be used
for later address translation.

Setup HPA base address (@base_hpa) of a struct cxl_hdm by determining
the offset as described. Use the port's host bridge and CXL root port
to find the corresponding CXL root decoder containing the HPA window
in the bridge's CFMWS entry. Only enable this for platforms with the
@hpa_xlat_enable flag set.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/hdm.c | 69 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 50078013f4e3..5164ff807537 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -125,8 +125,73 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 	return true;
 }
 
+static int match_root_decoder(struct device *dev, void *dport_dev)
+{
+	struct cxl_switch_decoder *cxlsd;
+
+	if (!is_switch_decoder(dev))
+		return 0;
+
+	cxlsd = to_cxl_switch_decoder(dev);
+
+	guard(rwsem_read)(&cxl_region_rwsem);
+
+	for (int i = 0; i < cxlsd->nr_targets; i++) {
+		if (dport_dev == cxlsd->target[i]->dport_dev)
+			return 1;
+	}
+
+	return 0;
+}
+
+static struct cxl_decoder *find_root_decoder(struct cxl_port *port,
+					     struct device *dport_dev)
+{
+	struct device *dev;
+
+	dev = device_find_child(&port->dev, dport_dev, match_root_decoder);
+
+	return dev ? to_cxl_decoder(dev) : NULL;
+}
+
+static void setup_base_hpa_cfmws(struct cxl_hdm *cxlhdm,
+				 struct cxl_root *cxl_root)
+{
+	struct cxl_port *port = cxlhdm->port;
+	struct cxl_decoder *cxld;
+	u64 base;
+
+	if (!port->host_bridge) {
+		dev_dbg(&port->dev, "No host bridge found for port.\n");
+		return;
+	}
+
+	cxld = find_root_decoder(&cxl_root->port, port->host_bridge);
+	if (!cxld) {
+		dev_dbg(&port->dev,
+			"CFMWS missing for host bridge %s, HPA range not found.\n",
+			dev_name(port->host_bridge));
+		return;
+	}
+
+	base = cxld->hpa_range.start;
+	dev_dbg(&port->dev,
+		"HPA translation for decoders enabled, base 0x%08llx\n",
+		base);
+	put_device(&cxld->dev);
+
+	cxlhdm->base_hpa = base;
+}
+
 static void setup_base_hpa(struct cxl_hdm *cxlhdm)
 {
+	struct cxl_port *port = cxlhdm->port;
+
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
+
+	if (!cxl_root)
+		return;
+
 	/*
 	 * Address translation is not needed on platforms with HPA ==
 	 * SPA. HDM decoder addresses all base on system addresses,
@@ -134,6 +199,10 @@ static void setup_base_hpa(struct cxl_hdm *cxlhdm)
 	 * == 0). Nothing to do here as it is already pre-initialized
 	 * zero.
 	 */
+	if (!cxl_root->hpa_xlat_enable)
+		return;
+
+	setup_base_hpa_cfmws(cxlhdm, cxl_root);
 }
 
 /**
-- 
2.39.2

