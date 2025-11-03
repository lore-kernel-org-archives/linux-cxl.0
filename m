Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012001.outbound.protection.outlook.com [40.93.195.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AB8320CA2;
	Mon,  3 Nov 2025 18:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195740; cv=fail; b=tmqHf+Q5Qk8vIqsmyNE+s4nXBKF3pM1hOte2epdhlPLZidQ6bEMv77Nv77LwAQ0AcuNqruOHEqiELSShV2F2fSO3IqpEJeAtElDT+UBOqf4ORgWYnBwMI5cDD78MB43hMrz9f8Y8hDSG35tEmZLt7X4U/a7cvWFAvD3GAzgp3aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195740; c=relaxed/simple;
	bh=Q1fR6DERifKddJ7perJ72QXAUjLVFtFTfmTvp3w6JOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSWuqeYt3ad/z+p4vRPETeNhBp3WRZWYmRpZpERuBa9uA9pKbzenqZsIkdW37J0noRoO7FUESTHYhGW8tqwlc2OJvH8vZyZeohj145+MdMLw+eNgNreUHPuM0cRJMrhEcXF6j6/wsXKryHVH4yAMlTE0dNl/6RsGBTkJm6S69W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5jaZZmRF; arc=fail smtp.client-ip=40.93.195.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5jaZZmRF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTF1j1oYqRV1HpueGi9A1ORIJFyN3E23QuRRi2BkTpCUJVblW9Pefh5aUjpITcr21LZ+nS4BkaAFeoyGHnqJjNAzgadMZTweylKbnP1S0EQdXYpJwEt/qr5uo7u3VnTwHwP1CrZKAJpbx1KsUANCfeaRBMTMMZGTtP2xHJLnsX4gTxoVQ1J+8zg41dtmRdFgMpdrd4shjxvjEM7jhtlx3QoFPul81u/vuUeje+daKhSl42eM6E8c1UZNT+bXqgq+SNg4G59nyl1wYETrnMPkUIKD9aB0sdpQ7KBq6vIeBpb2MqrqUSf00i5VeJMoU4F2RM3ukPPtoMbtm8ZQ6q/SsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwMBUEeAuCMzOj5ggvvlKBQdl528Ynr8mzJjyaStdVc=;
 b=Fuq5BZF5PrC419IPYP/FgIgMuvQqxOSnGTwE7s9vLc8N9Tm5wrq5eUZuabtvndYXYJ2lvdSILUzdClMkSAccQfq8q5cj3+v01gR1bFUx6KAPB2REw8pfeXz4WFHFdLPBO9sqOWoRO5u0xTx7ZRejfo8EJrN6Ie5ixwpeULM2i8vMV/Ae3XKGqclOsbl7tlWHZYHTtVOJkecF3N3qZpjSvux7dW4h3T782P1rTZeoMtbovFvxMpaTMeJCWQkDehOGBTLg2JIIZ7Y2NXrjhLsTr2STwYzOzq+dKUPp2xUAyOgz+FTrMM4GDsvVYzmiHrdsdpYnvsUkpXos1hcSygc1ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwMBUEeAuCMzOj5ggvvlKBQdl528Ynr8mzJjyaStdVc=;
 b=5jaZZmRFzZwqQagWIQGLF3GVR0VDdf/y8aVRQSbvfLvBkxEM5dtOjp1DwoNWpx3pyMuFVUM0yxKNiPRBErFs9+AXTFltubOntw9ZZyzJvt+qwpflxX/Mg46C46vvyD4joOHvPT0zvr/eoT+qvRoL1OOs6bdStoziDIJTq30XMSQ=
Received: from MN0P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::27)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 18:48:52 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::35) by MN0P223CA0007.outlook.office365.com
 (2603:10b6:208:52b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 18:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 18:48:52 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 10:48:46 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 03/14] cxl/region: Rename misleading variable name @hpa to @hpa_range
Date: Mon, 3 Nov 2025 19:47:44 +0100
Message-ID: <20251103184804.509762-4-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251103184804.509762-1-rrichter@amd.com>
References: <20251103184804.509762-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 45540a0d-fb33-4ea4-07b8-08de1b09a211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H3nFdIdHll/wAvEOVhcnrUXOhBFAHz0TsmLxTsqYWVFslbB6wzfcUHkXueJ4?=
 =?us-ascii?Q?XBKBmZ0cE5dssVTNFn9ateIiR3qJ16L13GVwtIsr0QVbNj4hMXRi46CaztoB?=
 =?us-ascii?Q?3PsgpqtihAsgB5dMMzIBPLYa1g0j1IZ2oNujP+UhRI1KGiU91ZfMpIY2lFWe?=
 =?us-ascii?Q?SZOV+246Z5UhgMT7DfS6K7aPI4Dy9iunwXwxGjzKb1UjzONXzC6F5+fv6L58?=
 =?us-ascii?Q?S0Dzsvypp71onoUwRyw0EfiUUdRC0Lewl259TvgKCLZ4SNL+ub3FbhGI2ugo?=
 =?us-ascii?Q?jiu0N7kklQco46x2En/Z9nB9ejlz78OQhMFwraOEazl9ZyZXE1TNgdzlMXWK?=
 =?us-ascii?Q?j0KYC2CTzaafJC6KpFiTJporP4s8n6L8s1aIF+D1SNGSEvSDNMsGcJFnt3na?=
 =?us-ascii?Q?9IdfoTdM+ZaDebP0D7o526/Tg3v59u6WwiZ7Lvm7iy8AhlI3Ri57C2pZ/vqL?=
 =?us-ascii?Q?rWi5Q8FMJcQa4NF+Nw7umikFV/0d9x5yE4H+vZSA30uPSiu9+Ek4ukbonnMV?=
 =?us-ascii?Q?hPinIzSPfGZ3lIQxn6j/vRnh28Fj0QNCX7n0r7dcmgisT3ID55k5JrLsXcT3?=
 =?us-ascii?Q?uMsojelMq1A4ZjdIRhjm2sdARBevFFr03PqCru0qZ7TK66okjBO/JQMbqN/8?=
 =?us-ascii?Q?AqO4PxQEPqOTfiU91VcEVA03wIjdYGLO/6aS7pASakJkcmjeJ+HdlCgnGbk8?=
 =?us-ascii?Q?GAQcfN7yzPR0tBPfJzzKbDHZUDput+5pAH+N621ky5/Mq2j0/oXq9WLen3W7?=
 =?us-ascii?Q?HxbCIKSSzSUSyO84MVttRELyc08jFJ0CuBszLIpwx6cYA93wqGs2tt60L49n?=
 =?us-ascii?Q?qwUp/hYGYrN8DnGT2gKqnVCcuvdYCn3mZ9ockqyAcG+9NTPW1o1vSE/TRJY6?=
 =?us-ascii?Q?R7hB8kATvh0Ioda8aT2AtCsaxQhOMhD94Kvjv7eSj22CLHespMKXNbL8mdVU?=
 =?us-ascii?Q?2Y85FeuowJ1OmVpzKEAy91Jj7hvQsB8usuwYNdVVieLlaahTL8uNBJ+fmFUB?=
 =?us-ascii?Q?okEMI9TbqtK+td2tekeDd7K+wNiDOYX+EelHyr766rVfw8qdd1ABLDDvmiQb?=
 =?us-ascii?Q?s0i3jBDxfQncUvb+Xa625CA/dpM6CQdHGVdOq2w3ONmGjeWPtffSS1ssH1hA?=
 =?us-ascii?Q?HWZ3U9xyN82WoSoXR/J0SeIpyaPkDx/HLBuhYDd3jrOQAxb9DiUnymv5wZLO?=
 =?us-ascii?Q?cpk4R2oLyc1WRok8egUFhYo9kb5ZrGyB3eyzWDS6yvhBLv+gwO021zr2hNk4?=
 =?us-ascii?Q?SN5Haw2bdLIVNbA7L+G4g1D8iIhm8E7DdNhiSuewI7GcVbOQTbgD24deCLJN?=
 =?us-ascii?Q?BEcX23uOlz3vXSnPkIgg5vxVtOAOqQWL+dkq5+QqIMj8NeQBziFH70osyEdG?=
 =?us-ascii?Q?Idp/yYSSDuu35T5qWmCwqyF7yGkZ7Yr5bIX+37dQlgwWG7o5VwS2vOBPJqY5?=
 =?us-ascii?Q?0GinOqglAdmZyvbOjBEIfWMT4FMZT+eyJ/HMcKmLJcIh911q2RNryVRBXj5l?=
 =?us-ascii?Q?mGe4Q8e08PN4bYakj480IkWSkoiQG5CCUWcFwNPElZP2Tztq521cV8H5MRnL?=
 =?us-ascii?Q?QrZJSX3oWI6hfOcm/Ak=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:48:52.0429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45540a0d-fb33-4ea4-07b8-08de1b09a211
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572

@hpa is actually a @hpa_range, rename variables accordingly.

Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a780e65532a7..bb889c891cf7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3363,9 +3363,9 @@ static int match_decoder_by_range(struct device *dev, const void *data)
 }
 
 static struct cxl_decoder *
-cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
+cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa_range)
 {
-	struct device *cxld_dev = device_find_child(&port->dev, hpa,
+	struct device *cxld_dev = device_find_child(&port->dev, hpa_range,
 						    match_decoder_by_range);
 
 	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
@@ -3378,14 +3378,14 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct cxl_decoder *root, *cxld = &cxled->cxld;
-	struct range *hpa = &cxld->hpa_range;
+	struct range *hpa_range = &cxld->hpa_range;
 
-	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa);
+	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa_range);
 	if (!root) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
-			cxld->hpa_range.start, cxld->hpa_range.end);
+			hpa_range->start, hpa_range->end);
 		return NULL;
 	}
 
@@ -3451,7 +3451,7 @@ static int __construct_region(struct cxl_region *cxlr,
 {
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *hpa = &cxled->cxld.hpa_range;
+	struct range *hpa_range = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct resource *res;
 	int rc;
@@ -3467,13 +3467,13 @@ static int __construct_region(struct cxl_region *cxlr,
 	}
 
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
-	cxlr->hpa_range = *hpa;
+	cxlr->hpa_range = *hpa_range;
 
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
 	if (!res)
 		return -ENOMEM;
 
-	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
+	*res = DEFINE_RES_MEM_NAMED(hpa_range->start, range_len(hpa_range),
 				    dev_name(&cxlr->dev));
 
 	rc = cxl_extended_linear_cache_resize(cxlr, res);
@@ -3552,11 +3552,12 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 }
 
 static struct cxl_region *
-cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
+cxl_find_region_by_range(struct cxl_root_decoder *cxlrd,
+			 struct range *hpa_range)
 {
 	struct device *region_dev;
 
-	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
+	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa_range,
 				       match_region_by_range);
 	if (!region_dev)
 		return NULL;
@@ -3566,7 +3567,7 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct range *hpa = &cxled->cxld.hpa_range;
+	struct range *hpa_range = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	bool attach = false;
 	int rc;
@@ -3577,12 +3578,13 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 		return -ENXIO;
 
 	/*
-	 * Ensure that if multiple threads race to construct_region() for @hpa
-	 * one does the construction and the others add to that.
+	 * Ensure that if multiple threads race to construct_region()
+	 * for the HPA range one does the construction and the others
+	 * add to that.
 	 */
 	mutex_lock(&cxlrd->range_lock);
 	struct cxl_region *cxlr __free(put_cxl_region) =
-		cxl_find_region_by_range(cxlrd, hpa);
+		cxl_find_region_by_range(cxlrd, hpa_range);
 	if (!cxlr)
 		cxlr = construct_region(cxlrd, cxled);
 	mutex_unlock(&cxlrd->range_lock);
-- 
2.47.3

