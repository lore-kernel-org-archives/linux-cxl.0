Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE926D4C9
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034292; cv=fail; b=CCHxBdmCi9llImGINfU44Ah4D2rwuiAsiLbW3Va/6QMotvaeeiAjlir5YrHOdS5TS+d0HqDEHC8JggfFUac410miGXEg5ugYlbo6YZRJukqFBi7J0nKoNLlJzlPq/L+PUBHc6xHwbWh/iWZAbA72vKtT+LpJmvyfAcmDIvxMavA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034292; c=relaxed/simple;
	bh=IcrG6A20Q5yqbERl6dta2LkvyOiBL8zfgj/0ne/eW5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Akj7WA6hyGZqFhFfgDod2GICvUYUyIGfYHc/iclsY06mkRy+1eYBAg16tVRz3XsMwjQCxqXLbwwZILrHnigrBtcL1V+K0HRD7tdsE3J6Y6rzszRBD/1VaaDmld+aVrh4gxOU5WZYKvWZrzffxAwl9b7XOqsBIhktp4Y3rLxOlmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xB8FOcyf; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xB8FOcyf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pn7To8PQvYqiaIuwE9ldUt2jQh8WUjoroxmRb2OA4a7bb2kFtLlonQ1KCv3zlQ3T6ZswgH0wGD9SYGolgLhpFgE13LyKG2x8fpi/yhewURwNvSxD/iGzutRXrACsXNb2CbVTeZDi9zsaBBkfGZvycYC+x/7lUadOIYEnt+M8HhRqU+/S9gmBQ1nLh4Y5SRLh0B1Q3R/BKDVcbtwEFWNzapAom/96DVqJAUvuCFRE+rzgvg45pRPy3aZL3bpAMs/DGDXBNc5PU9zieIZLGIL0YmlzmywfDEgM+a8VIk6hSmUMO0M22EsUzmNa4cqHb4ZQLK5nvRLlbAAhWHinEZTczQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnpxO8hzokbalnjqlpLyfXD9p6HWUN38JuyNwvTfx+4=;
 b=KLiP+jYfr1Z/lcjF/ajhdYJrv103lXSC46/GoyF6P7tWR80kczoPgaJiEPwIrOylYBxjVxsSqYdVz6DDfzspl7iNz2fI8fcN2J4ceGOspjYmV76BMk8ZI1KcYqIUp+8xa6Hto/evowTcJCXX3CzVwPk3XTQJVkGK8qg5ISQPwh+nlpxNm00lo6mJvZa43nBVasaLzH3mvh/0f+yN9yRd8H8WrPsIzpELG5y2jOzmwKlQ1IuxqcXTGVBsmJqiyN6uze2rLTA1jEuRPa/pMy6XTp/sPGvTzXyNMosxxzMEiv85wvyUhasTnR6HfQOn7UlCj0iIgnybul5ocYvT1DI4sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnpxO8hzokbalnjqlpLyfXD9p6HWUN38JuyNwvTfx+4=;
 b=xB8FOcyf8Nj70LIIYMv+rsja/Kz+Os4OssmdML6Ty3Zl78hFaW1wdx3b48YN6isr2MdshjlV4WP8B9ZMIihrp10a1SXwKPjdnKcZGb9iFbeUPsqg4bI0+sdHuwWJwbfsU55FROLWPA9lwUgQfiykXTYaEm+obsA6tvMenkP2fSM=
Received: from DS7PR03CA0176.namprd03.prod.outlook.com (2603:10b6:5:3b2::31)
 by DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.14; Tue, 12 Aug 2025 21:31:28 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::bf) by DS7PR03CA0176.outlook.office365.com
 (2603:10b6:5:3b2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.20 via Frontend Transport; Tue,
 12 Aug 2025 21:31:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 21:31:28 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 16:31:27 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [RFC PATCH 08/18] cxl/port: Update switch_port_probe() for CXL cache devices
Date: Tue, 12 Aug 2025 16:29:11 -0500
Message-ID: <20250812212921.9548-9-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|DS7PR12MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: 119b9f5c-86d6-45ce-5ea5-08ddd9e798fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hwBfNkKd1phwy7jap6hDd7ez2DzSS7nDEY5JQwCpaQJiLcq9dcW6j6XhNqcw?=
 =?us-ascii?Q?nNQv9hC48jAofxfSxUotSopzRiW1ZBMnilGr3CyNa7LdDxgU86POlF74PmRG?=
 =?us-ascii?Q?p3EAJJNGQSmWmwYPzreKdlEEGlCpzpN+olpTYgSRhleWCu5edDdmlEfsEBKZ?=
 =?us-ascii?Q?zg3i8zGs7/HDVxCb7UeR3EO2ZDw8E0dcPZwzfxyVMKedBNSySiQF5Z6eUHqJ?=
 =?us-ascii?Q?90k/6qOq5HihgRQDdfb60WfgZjF9/FF+3rEj88YPx5md2K95R2JsKjifW6Lp?=
 =?us-ascii?Q?D+IcJrR5/BggteDaD72XvDmkm01cuEtHLzJrT66Q6MNw0Yl9TiI5uzv2gRqD?=
 =?us-ascii?Q?cz3jUv5A20nCp9hn2Qxk6TJe6w45zoetVzdOuMuoXL6f7GIl4bSP5Jhxwy+I?=
 =?us-ascii?Q?hU8Td0VRYAqFUwbL5hgN1cJmk+VJB3uALVAdgT6HZKBnJXpiw0Y9fpRVRuCz?=
 =?us-ascii?Q?tdiyX0Ns0C5cul4PyvIhqEIE/LpDqIX2F9dhgfyIRomUXNzEOOk8eCaMMAd7?=
 =?us-ascii?Q?Jx813Twy1hVhHc7bPg5w3XFb+UHRjeWHXZ3lyA/oYCl7EJZva5EsLDYIjipb?=
 =?us-ascii?Q?5zzp92ZMT9EgnE+NQLhueNztDIZDErG2O2dKazlmLKRLhbBApHIsPa7aNN7g?=
 =?us-ascii?Q?XA4D4DXqHLmp6tZVs1T+JTYU0uoTBMNIYAIjs0jWGPZ5W/78pL9LwD+RVLwg?=
 =?us-ascii?Q?4jqqIT7t9G0ySP5XMMpF6TELC4lgPaAJH+XEtao3x1pqxdOK7FFp3Z1s1gXr?=
 =?us-ascii?Q?+iKeVxJ7YvjGYUPa8xSVRGuUk5eS63AxBXwXMrk0HZMxxcgXlvM548IiJrEz?=
 =?us-ascii?Q?4shFZCXXgzub3WYhKKx96YUEPauINAXaUCfLX/cbYKQqa0wDOpJOE2RP0upW?=
 =?us-ascii?Q?qULFrey+T53rwpD0zh1O8JrsWlRjPf/Xryj31Ve+WpRcHLONgNxfK3Y7+Jha?=
 =?us-ascii?Q?Zyk42Q/9Y0gDvnxJFKIzSTlVe+QABX47IykgzL9/btpe8KFSS6ldlAeJyiuR?=
 =?us-ascii?Q?K+1BZudnp/pZGGunIqxrbSULU0f/ThfKnKjQcjFfqA8IyZ44zHyJxw5/Ldc7?=
 =?us-ascii?Q?EzKMzkdxX3iD/cFUbNjMHEoyFz4osFhHxSWIxW0ZefDtahYkEV5LTYAHk08E?=
 =?us-ascii?Q?GHVkgRaOuhjOpk0zNOZ8rmHqSVzfHBgV3k0nk8TQu7F8I70YkhKtEt+JPQbI?=
 =?us-ascii?Q?vQ+4wu6pPHIyEu9l1Mo2IOMonB5DTIzbJ/Q+RES3w1XveluZ6rP9oSKJtWvV?=
 =?us-ascii?Q?YlY9prjCD0PoMh+U2W/teOweMeLWJFfP7igbGE941T3OhSw0SQSJGKi+qJlB?=
 =?us-ascii?Q?2DZtLBRtuwRsppMeFnrrUJJMcWQhRvuKyusCfsQaCtWRcyYNTTFb9CTXhNu9?=
 =?us-ascii?Q?ZEO983B7wS5SYPKGGVYkeiIu7sLuhpPUCfgCOSikZVi8y9ExjR5yzVoauqPt?=
 =?us-ascii?Q?DdqsRRo8dzCQfoVf44cYCQrbw39Hbq5hHYVWtS/GVNqxPKqHtGlupGRMNMOD?=
 =?us-ascii?Q?45LSihdXKk/XnD4F8PZ5r3InsX+1kYjYg+2y?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:31:28.3008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 119b9f5c-86d6-45ce-5ea5-08ddd9e798fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837

CXL switch port probe currently assumes there are only CXL.mem-capable
devices below the switch with preconfigured HDM decoders. Now that
CXL.cache devices can be added below a switch port, it's possible that
they either have no HDM decoders (type 1) or the CXL.mem capabilities of
the endpoint haven't been set up yet (type 2).

The HDM decoders being disabled (if present) is no longer a gauranteed
failure condition when only cache devices are present below the port.
Knowing what kind of devices are under the switch port isn't possible
until the endpoints are probed, so delay HDM setup and validation until
endpoint port probe.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/hdm.c | 31 +++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      |  1 +
 drivers/cxl/port.c     | 23 +++++++++++++----------
 3 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 865a71bce251..6e04f1f4c166 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -205,6 +205,37 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, "CXL");
 
+int cxl_validate_endpoint_hdm_setup(struct cxl_port *endpoint)
+{
+	struct cxl_port *sp = parent_port_of(endpoint);
+	struct cxl_hdm *cxlhdm;
+	int rc;
+
+	for (; sp && !is_cxl_root(sp); sp = parent_port_of(sp)) {
+		cxlhdm = dev_get_drvdata(&sp->dev);
+		if (cxlhdm && cxlhdm->decoder_count > 0)
+			continue;
+
+		if (!sp->reg_map.component_map.hdm_decoder.valid || !cxlhdm) {
+			dev_err(&sp->dev, "Missing HDM decoder capability\n");
+			return -ENXIO;
+		}
+
+		if (sp->total_dports == 1) {
+			dev_dbg(&sp->dev, "Fallback to passthrough decoder\n");
+			rc = devm_cxl_add_passthrough_decoder(sp);
+			if (rc)
+				return rc;
+		}
+	}
+
+	if (is_cxl_root(sp))
+		return 0;
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_validate_endpoint_hdm_setup, "CXL");
+
 static void __cxl_dpa_debug(struct seq_file *file, struct resource *r, int depth)
 {
 	unsigned long long start = r->start, end = r->end;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c857c112772f..0dc4e5c96459 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -932,6 +932,7 @@ struct cxl_endpoint_dvsec_info {
 struct cxl_hdm;
 struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 				   struct cxl_endpoint_dvsec_info *info);
+int cxl_validate_endpoint_hdm_setup(struct cxl_port *endpoint);
 int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 				struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index fbff4900c69d..56030066a652 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -75,18 +75,17 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	if (!IS_ERR(cxlhdm))
 		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
 
-	if (PTR_ERR(cxlhdm) != -ENODEV) {
-		dev_err(&port->dev, "Failed to map HDM decoder capability\n");
-		return PTR_ERR(cxlhdm);
-	}
-
-	if (port->total_dports == 1) {
-		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
-		return devm_cxl_add_passthrough_decoder(port);
+	/*
+	 * This isn't an error if only CXL.cache devices are below the port or
+	 * a passthrough is possible. Finish set up in
+	 * cxl_validate_endpoint_hdm_setup() during CXL.mem endpoint probe.
+	 */
+	if (PTR_ERR(cxlhdm) == -ENODEV) {
+		dev_dbg(&port->dev, "HDM decoder capability not found\n");
+		return 0;
 	}
 
-	dev_err(&port->dev, "HDM decoder capability not found\n");
-	return -ENXIO;
+	return PTR_ERR(cxlhdm);
 }
 
 static int cxl_cache_endpoint_port_probe(struct cxl_port *port)
@@ -116,6 +115,10 @@ static int cxl_mem_endpoint_port_probe(struct cxl_port *port)
 		return PTR_ERR(cxlhdm);
 	}
 
+	rc = cxl_validate_endpoint_hdm_setup(port);
+	if (rc)
+		return rc;
+
 	/* Cache the data early to ensure is_visible() works */
 	read_cdat_data(port);
 	cxl_endpoint_parse_cdat(port);
-- 
2.34.1

