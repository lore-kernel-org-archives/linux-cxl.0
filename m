Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAA11F2BB8;
	Tue, 11 Feb 2025 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267679; cv=fail; b=sWeUzu/ZnBRS0W4XEBXp2WbvaHxD1r83aXQTCDg2UbyTEH81n+hdolxyn9G/r1dm6VjqKFS0xY79kkrXI7+0uszbjLPWy0yMOsO+wkKQO1QHIRAiuCGDARpmkmlJ6FV0x1pKkCmxXU3Td8vHrPdwtrEhR0mIR4g3D8PM8/xbDyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267679; c=relaxed/simple;
	bh=YT5fH+7dJYWL1Fyv6iMzf9dkDBThuRlSaIvrEFJRJ+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWZUazFxAFC+hc8Xr0XcedodYWjm6IJ2WskRmjKjlOx4EoZaMuBFt4VqlsYhbBgKoLxeeluMqjvLnnzVeIu4FpyKSj6pNyaB70ilUGMZB2x3SGk9ahtUJIZ9f/aby89+XCUMwVL+L9m6Sa8qHebNLY+OZka+gfql/T4o0lbLgtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E4TQh9Sq; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E4TQh9Sq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjmVDiTESizL+Ci0H+ss699MO7BSpKPXa4R228nEAjEGcBAfH4AjH2Mt3+9Y+G9kEGjXHqbmHrkLiFTxRmx7eMWxMywejHozmGVCQk7hlmVWRnn8G+4cbYnWKZquIM9YzxySYFI5ROxUBPmfU0Wc031Wiw5MleifWzNN9C8UnmXpG0FPKmDsrlV39jwJVHH6E7Sws2W3IpWW95zZl3fW8macj8n17CJwrh+sLBdkRlzs9CpgyNtjYLkIwwv2/04LFr9keVvceK0SCyNFRvfYyDiJg7dQzu0dh4F2gd4PN6G9rN0GWtwDPSNmnt1mDzldvka4iSLraS8HZ6rjKfd/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6DTYg2yKJe+0M3X3PdCsIHD3UwKbx7VgNeOD4ISEgU=;
 b=mhqQ41+3TTVvu3Y+m9VDP4C/taSwhNsoeUaL2gXFWYrtyscXygUuqO1ykPAh8uP3gtxq1aILPQcB9SD6T1YH2TAq74LjrWqv4Mokg1lmm+UmvwSP6q9DoPJW20MS8hpi802BUMlK8HFwyZnR8QMzbnwolISkrKn2H6n5iE9y9rjQx6Jv/2q5WrJmzOs+sWODWAH2n508wZIpdY6aYsmVd3eo3uIHxlfokC+QKjKS8Grn4Byd40YtbZIkijQgRWKVOlAPc/pGdzzXI3r173tVmvglOrA3txVtpRUVAfrNLjZ73FSJKJBIkf9JI1N+ks09g3+gkCcxzFKGB2ksYeIzVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6DTYg2yKJe+0M3X3PdCsIHD3UwKbx7VgNeOD4ISEgU=;
 b=E4TQh9SqxhuAkpFRibjquvnV/tVZLbi9jBgLmN0RomGyAIaOmsQAGhbibCrM3+3DplVyr+AgVrnGXyWgN2q8toZjq8nJPuwxnZ7y/WyQOdQr/pK20xi+Todt1FtBMPIlrt7kNEoV7lSM28z79gDnNZ/CoJITHeoOjHunvLPjPHY=
Received: from MN0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::9)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 09:54:35 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::2d) by MN0P220CA0029.outlook.office365.com
 (2603:10b6:208:52e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 09:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 09:54:34 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:54:31 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 05/18] cxl: Introduce parent_port_of() helper
Date: Tue, 11 Feb 2025 10:53:35 +0100
Message-ID: <20250211095349.981096-6-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd6d5aa-5a5e-45c8-0de4-08dd4a82170d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ahKSeu14EM2yLPhkAXcBH6OSrcjatgWwRR2QPr34JFPVMY5hKDzUGcwTs2Ln?=
 =?us-ascii?Q?oAKLPgtBOc5gAAv1OdnN/1U8LzpQrp6+ZzaYMBWu2qpydnCfGlYzqeyID/3D?=
 =?us-ascii?Q?tR2oIKxCOUGNb3+3BITGnEFJIh27V64oHHngUc1SIPvJHQ/z+3IInN0nU3og?=
 =?us-ascii?Q?IIHa9dG3l3AGdOjNiHd3xpKgTVqKrqSDoUTj4F89kxOVNOZ/IKrQLRoHXgT6?=
 =?us-ascii?Q?MzWblsdcs7ihE3GE4fIK8LpUwVnr1lUg3aPGHthFtjMcPt2lsv9pFVr6Bprv?=
 =?us-ascii?Q?KOIJ9Y0331VJEY/jhCsLyqJDElVq7YkTS/MlsGAI0tTBk8JyGDQHE6/8qIpP?=
 =?us-ascii?Q?6hJ/89LaOYZA4OKp/WbZJY2u5l9taZZwSHThka2ry2BE6W2hCBku+uVWQ2G8?=
 =?us-ascii?Q?Vye/aV77NYKxOevLQjx4Or496SwL379UmFQRqZNSv4V2IdOFJ3eTrnNuvmHH?=
 =?us-ascii?Q?ZDVN+sjopv4WT+zjrAc6MJWnUs9ODO8pd969YfB0sTLKcsJTuVc+b48Togus?=
 =?us-ascii?Q?cN7Dd/OwDMmCJNZd4RUD4ZCN5EIzQPkRKMXWgCbSG/Gg9eUHjzpytLZIpDA/?=
 =?us-ascii?Q?a4vZwE0rlUjNrvcwTU7vpg6hiyqaRbDamdojE2ei6iCuW1TkPBTc/1LOcbyl?=
 =?us-ascii?Q?ke+tls+M92nKkxeWW1SMsZwtCel608RcoBQCaOmzhd8Cg0VUfRjZMVKp2Q7R?=
 =?us-ascii?Q?I+Y50zu5cHuqEtkDynsF4pDIva2Y90FueGCUSztXphhKnaE+BaUE7Ms20YlC?=
 =?us-ascii?Q?yhGYWQxyPix+c5J8EToRvMI0ygUhgl7NBGec17pD3jDu3VVoKh65A1MW+yKH?=
 =?us-ascii?Q?GvAwOlsbSTGb3iNHRl0k06qnJQ6kMo8kD6HKQ2qEcey0+QjfUWDTcKvasRKA?=
 =?us-ascii?Q?ShvByvEItX9VycggOaYEKXv4IiN2awwiayS0EmW1viYayThR3AJ3UYS6Hvl/?=
 =?us-ascii?Q?3PQe/WngZrMUAaPiXcUTdKbPYiHmakNJNxO51W9xLfRECGVc9fxIHyHxFESR?=
 =?us-ascii?Q?rdmk+cbo2gUaUWJ5TKo0XSjckXjD7neAyIqkJGzFU/ef5vFgZ6bTB/4/JwFk?=
 =?us-ascii?Q?CtTSbU7p/50nZm0ldEl85ydsvDFNVk6Z4/s0KKFakM2Juoy3NrJnWiNipB8S?=
 =?us-ascii?Q?3eFSdD5yHN2uU0vcZI6DgnrK79VziBjAt+Zj7czkgE0r6ZJLTibyWcYsRMGH?=
 =?us-ascii?Q?6wOJXR51A6MzDnYd2fdzlgJh4je5CUexs9MY0aSD/XIlmID8VEwLxl0IVql3?=
 =?us-ascii?Q?MAwmLMcNl+/VKXqCuKZSU9ucyEpb9Sa31ix9ArWF1jDb4DDPJPswWIZHnHeH?=
 =?us-ascii?Q?1hSZ4bk4hRD4v2er4epYax+03Wtv4BHqGONgPivR4evZYWpfviCFxNeaZzFg?=
 =?us-ascii?Q?Cm/leeSZOj89QI966X8kHo+bsI93NHc4FzReZxsApeih4/+RgEiaBlGL375Y?=
 =?us-ascii?Q?yB+lacw4px9Ne5HCuf9Sq9yPz3s2hYoIdEL6PTjmLkICUGQWBczAvCY9omlk?=
 =?us-ascii?Q?3C8tYBZALI0/YUU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:54:34.8788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd6d5aa-5a5e-45c8-0de4-08dd4a82170d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527

Often a parent port must be determined. Introduce the parent_port_of()
helper function for this.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/port.c   | 15 +++++++++------
 drivers/cxl/core/region.c | 11 ++---------
 drivers/cxl/cxl.h         |  1 +
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f9501a16b390..d19930c009ce 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -606,17 +606,20 @@ struct cxl_port *to_cxl_port(const struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_port, "CXL");
 
+struct cxl_port *parent_port_of(struct cxl_port *port)
+{
+	if (!port || !port->parent_dport)
+		return NULL;
+	return port->parent_dport->port;
+}
+EXPORT_SYMBOL_NS_GPL(parent_port_of, "CXL");
+
 static void unregister_port(void *_port)
 {
 	struct cxl_port *port = _port;
-	struct cxl_port *parent;
+	struct cxl_port *parent = parent_port_of(port);
 	struct device *lock_dev;
 
-	if (is_cxl_root(port))
-		parent = NULL;
-	else
-		parent = to_cxl_port(port->dev.parent);
-
 	/*
 	 * CXL root port's and the first level of ports are unregistered
 	 * under the platform firmware device lock, all other ports are
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5d252dfae138..54afdb0fa61c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1734,13 +1734,6 @@ static int cmp_interleave_pos(const void *a, const void *b)
 	return cxled_a->pos - cxled_b->pos;
 }
 
-static struct cxl_port *next_port(struct cxl_port *port)
-{
-	if (!port->parent_dport)
-		return NULL;
-	return port->parent_dport->port;
-}
-
 static int match_switch_decoder_by_range(struct device *dev,
 					 const void *data)
 {
@@ -1767,7 +1760,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 	struct device *dev;
 	int rc = -ENXIO;
 
-	parent = next_port(port);
+	parent = parent_port_of(port);
 	if (!parent)
 		return rc;
 
@@ -1847,7 +1840,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 	 */
 
 	/* Iterate from endpoint to root_port refining the position */
-	for (iter = port; iter; iter = next_port(iter)) {
+	for (iter = port; iter; iter = parent_port_of(iter)) {
 		if (is_cxl_root(iter))
 			break;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6baec4ba9141..0d7aff8b97b3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -721,6 +721,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
 int cxl_num_decoders_committed(struct cxl_port *port);
 bool is_cxl_port(const struct device *dev);
 struct cxl_port *to_cxl_port(const struct device *dev);
+struct cxl_port *parent_port_of(struct cxl_port *port);
 void cxl_port_commit_reap(struct cxl_decoder *cxld);
 struct pci_bus;
 int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
-- 
2.39.5

