Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB91F7086;
	Tue,  7 Jan 2025 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259093; cv=fail; b=HyW7ivt1QGgta5bJDin4eYp7W5kRwSuOClV+ZnsR9A08pIm9wWS66adseYTYeGbKDVhX/eOxgSfXURWDz9UPy6i/KrhlS8ORnZ6T5LWnKOyf720uBzDt37Iu4L/kh9b+AC/43PhKRn3VSSiU/68JsR3Wu5GTxeiZ1fptGAhqVvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259093; c=relaxed/simple;
	bh=Za7dgU+BrqdH2ql8PzR24kIqnU1REa6VsxuLuvXvPkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZvAR4NGFr49ck8WI/kfdVfbs1Vy8UwHCyi+a/y31OAyJfILDKE06PzM3o2k084M8ODwgk9ZObQR3ffu6OSRkYB8t5hA4lSOPuSPJnQ5OT03WZU3GJre6mx4NTnTMoHEjrD36qdIxj1RSKlg9qH/IuhG2NzFo72YBuSyrVJdQ2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2eyEAIGQ; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2eyEAIGQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zq6Ndms6fW2DkNetsnzGmi3FjCxPpG21UkeHRP2czR6fKHn3LVQfkmRxSFjKlXRDjWG4cLSNbAZxcqUFbRK7b4X7SZSyGvRFeKJZUS9XX7H8FB+0kOriSKgyEJxva1M3fL/5vQgd3cnROEukyV55nDCp38FgGID/UboSkfL49QC3oh8TUj2ZPUUx9vGrbOsSiL9hZ7wT4R2arFg9lRI8QSB6qTXicV85xWjiJ+VAJVraDRJFtQU/6xZYICco4WcZCDuHCMl53q31j3j/sox7ufsc+UDxyjD3CtDIcIfUPPT65fyaKlpD15HO9ihJStBpnGxO0VDlGKp/09GI06LghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WCBeL5jVq9Pt0WUb5ulXGX9cpFI0x7I153mlhnn7+I=;
 b=Xi7/er//g5Qjk5UwCD2s41UHoPi7PN/q6bLGOw9Y6sZ284Gum0NswmTM/eNpqx0BQyG593QRg1EGIombiM5g+7BKXQKI2VFbpoiSTgzflu9qenzOHPUUPdm8TeJmIBG0JRKcADXto/07EgLm+61Qrc9YBsyZn6S9I6qZBZ6r8l8SIE6oow97IulxK7ZkdFecm856PL9HRzWhIYpDY0ShSS6eesF5Bq6RZ0sRu0GLYBMZYOMCSpidPOJjGlKdFpgk51aSmP8REDafwHaRjGpiZJMlc76G+6hZ3z2ktELAJz3Qle3Kfuc8bieoGdYrq6/UVqZuAiJsHFv7FdVk/KQJ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WCBeL5jVq9Pt0WUb5ulXGX9cpFI0x7I153mlhnn7+I=;
 b=2eyEAIGQtOO4vG6DOJhC39F0w1B/qvlxNaL8ocI7QBt8B5CuUTJ2o1HGZQYGWuaCPisdq1ri2Zs2M1PSZ3s/wdZR9DwCgeUnwGkxilVDNfYU2ngKxvUjUrfNbYJFOuFFocdED07smTKmShRb3y8NLBa4N9XCITYgmUK6gA/V1oY=
Received: from MW3PR06CA0001.namprd06.prod.outlook.com (2603:10b6:303:2a::6)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 14:11:25 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::6d) by MW3PR06CA0001.outlook.office365.com
 (2603:10b6:303:2a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 14:11:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:11:22 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:11:18 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 11/29] cxl/region: Unfold cxl_find_root_decoder() into cxl_endpoint_initialize()
Date: Tue, 7 Jan 2025 15:09:57 +0100
Message-ID: <20250107141015.3367194-12-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c27fb23-156e-4323-a96d-08dd2f252a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lxTizglWWWogIj9nmzUvb8F1PdoILyd7pBi2iVDtfvrO6EwjzPSsPdGKxiN3?=
 =?us-ascii?Q?M467fJbFcP/TH7+If/KFHTapEYSqTKjb0BDuPlkYuxWzlkQ4u/4gJyIeErNT?=
 =?us-ascii?Q?h1E5FtRZ4IHJuElHe+X8z7xHtabxiH7Jc/nbbTgrzVgJXek+APDsmdVOSapc?=
 =?us-ascii?Q?lKZLp8xkAEmZ8fhnGcOFG2/ynf+JkK26wkYb7tadk+7sD1E+xJnM4q2CNhux?=
 =?us-ascii?Q?LDUumVQixNKG1ltFdEYNVSTPkix0quWMPkGWlELOw/rxcu7ekfylDhpJrRj0?=
 =?us-ascii?Q?TcqkKT/r/1Pivpm/IT3v6CiiywBhPGTnpnDO1X4OhXU8sWEm44/Mv32wIg2J?=
 =?us-ascii?Q?PdRctZtUAFRTZYokuSEBbzfVEZbE7Os8rIDw74zERo8KjP6PjPRekrs1rwx1?=
 =?us-ascii?Q?5f4A73tnCrU3umHb8tyzeebLuIf1KXt0J5ik39R3YFUx/c4XDnCxTLZXBl8I?=
 =?us-ascii?Q?JQzK/lsmS/v/DbAXgbCYrLUJ4A5S3to1cd/2UGxlmX7l6L/TqGszBiOxYeQO?=
 =?us-ascii?Q?JUDTsKvy6BZ2xLaUp86XN6Q+jHBbTV9DbS+3N/QCwNNwGGZiuUYLlMo5dRKE?=
 =?us-ascii?Q?QqWmZSPhJOBLAE1C5ObbTOtyZpjhfT2j6I+h7kXSyb53qeDjnS/YXgeE0QKu?=
 =?us-ascii?Q?nPDnfYiZWdz5zeSnsmvBnYBTB5ljkIOz7LYg+srBDjhBmrJdieueUjFjz/XK?=
 =?us-ascii?Q?2hP+cQmeprwP9d9+JtOBAgYT7C+580TDEg7Qbh3SQOwoUVefqT8UbTw6wmBF?=
 =?us-ascii?Q?DGBXHUx9KOR/N0K5LguC+Qggw99E0nM5SEzzDgDvY3QM865TXowAZK/eq4zV?=
 =?us-ascii?Q?z8TCxke6zpAe6K4f9p/2i8yjfAABmCObc9YY04InpHFMyO/LX5TGKZ5DYzya?=
 =?us-ascii?Q?6tBIV1g4jForVSo1Tnliig1AkAHYDPxmQvrE4Rkac6+woRePXAxxpv6riplJ?=
 =?us-ascii?Q?ItV7a3DIHmw1lMCCwwITmRsU5h7bWGrtlm2BLtXU6K5GCLs3HhYLUjCLiG9C?=
 =?us-ascii?Q?JtIR7MwIA5XYTsXQpY75N6Uil/mqh2o1YUZqp/e/oB2Omvljrtus3gNHV8Z0?=
 =?us-ascii?Q?BVMehGyN/fdagChxN/n5LoXb6cNPEweMkrH2wzdgAlT7x+MuXso6QN+U0JF9?=
 =?us-ascii?Q?O32sxcck1Ts3ioC48AxIAjbzVwJ5n9tBAJmslqCSayw1LUUL+RWIbTWPMIr4?=
 =?us-ascii?Q?Z0AfyJYR3oaptJO2HaZVG5lh+VeCxs8givUNJs4xbTZzBpwbXs4guQOwU0Pn?=
 =?us-ascii?Q?JxyN5CS5DSo9nwHRk6WhC80B5VDYs36628Ca1NP4rbSSQUWYXX2zAQmvNvzW?=
 =?us-ascii?Q?NCWa5HDwe3A9UVi7If5OWcSnFf4qqC7Dg7vT6Lygil1lW/aMFFzYSTDno279?=
 =?us-ascii?Q?lbw69s8X3aaKpUdXYaHG/KuubvkpK4V9sDlgUqML3n96TBcsGfJs2CCmnX8l?=
 =?us-ascii?Q?p8thftognbU23AE3u639om3n60nLM2NPp5J44nFb55JKStykME50GsSXoTF8?=
 =?us-ascii?Q?jKd4gB7vYyg3aEw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:11:22.6582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c27fb23-156e-4323-a96d-08dd2f252a66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771

To determine other endpoint parameters such as interleaving parameters
during endpoint initialization, the iterator function in
cxl_find_root_decoder() can be used. Unfold this function into
cxl_endpoint_initialize() and make the iterator available there.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 48add814924b..6fcf56806606 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3218,8 +3218,7 @@ cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
 	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
 }
 
-static struct cxl_root_decoder *
-cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
+static int cxl_endpoint_initialize(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *iter = cxled_to_port(cxled);
@@ -3230,7 +3229,7 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 		iter = to_cxl_port(iter->dev.parent);
 
 	if (!iter)
-		return NULL;
+		return -ENXIO;
 
 	cxld = cxl_port_find_switch_decoder(iter, hpa);
 	if (!cxld) {
@@ -3238,12 +3237,12 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
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
 
 static int match_region_by_range(struct device *dev, void *data)
@@ -3364,19 +3363,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
-static int cxl_endpoint_initialize(struct cxl_endpoint_decoder *cxled)
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
 static int cxl_endpoint_add(struct cxl_endpoint_decoder *cxled)
 {
 	struct range *hpa = &cxled->cxld.hpa_range;
-- 
2.39.5

