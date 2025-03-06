Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA83254AFD;
	Thu,  6 Mar 2025 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279520; cv=fail; b=uhyzxqSjSme+YbJnJi9opraZuuT57/dIf3Wi0EPBO9z3ybGPOnrCoA8whvWbb1qBfStCuucSCok4ZEZMLic2rhmJdlMmsnbp6KDnwfG44gerXip3hNHQdftXYqSWlwi4wp8PeQo8SXuWmseDKFER1CxzLYfRAMwik7sC6BArgqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279520; c=relaxed/simple;
	bh=rFzyIS9gUdPyvo7qYzMG+tYOh7V4/FUtSVa8fuiTBhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvVe7jO+fHGiSrWlKsSO5Q6vFuGlODZ2aEQbHN+LyZ+q0ek3YE7/IGRm9LnPd+4ugOmSG/Ob2uLKbGv7+Ipebg0ooLOnnL+2B0jD5UFs2Kgd2OJ4479HqZU1GDXro3T7L2P86S8MhToRTAFBbkuQI6wMgkC05DrdMk06oJZf66M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fUM6Slg3; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fUM6Slg3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpQmOpbNxs477aS24gYOErAn39c5DvZMmmXjEMIPEqQIVZL1FeGKIlMMkN+nf441OwHWf1bzvPx65ciJ57czB0CEPPz6z46kLrv1gjbRzCm/283GBKjCh7iFfBy1F9pMAIYBiQOH3zl+ZCI15M1PHde7wucZE4DFXgc6FmJwLme8OFQIcViM9xTF7Pgeh6FDsvYkUscO30llT+YEKkXpdXo3Yf17HiKYqIO72agCJ4wGvtp6RW4UGq+XuDRsOaTjgOSl2DDroogEpufJ1DppougWGCWDJE4bF4NVhbO64Iy1bg1GzQOEaKc1gO2ppuzFZv4NUQqznGomOVF7BFC/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuzWqDpz1bdJ/BbF5OJ7so8CNlk16Ya7kQh2bbQ3ZWA=;
 b=LyF8YacCSXtSS9iheQu1aDxDYl5zt/cgAMrwpBOflqW4+nFZEgYQwKLxQoql0k0ndVw3eNcoV9BuO9HPRzxF+64TLM8GqC0g6KaTricCqq6CqYUcZJGbPOhiQzgCODJab7tK69OHv/wxa2gp33cn1jeEEaZCgMVpeoPnB1C5pfhJ6hb8VHfz6lAuJQ7L+3nettn6GruBYgO/TAYpXoeqvkBDrQHr/tEmPM8Y4J3oSg1/+xa0dUDrq6lWeCgD3uwPS091Q2DM7roTU1SoUjgPjx9qTA4EfDbP+uIyWXThLVs/u8m6fYDsh8sULElCzzeBFJmrBtZrH6wQSkr2pTm55w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuzWqDpz1bdJ/BbF5OJ7so8CNlk16Ya7kQh2bbQ3ZWA=;
 b=fUM6Slg3H0Y3vyHNsj7T0GlXJd1LrUECQ+Jmw3nG3MCYMz32KeN5BJDBUxTh/itdyaMU/x9z2qn9WIEBqhnrUCGNeclXnHVRTj74QyZDPiQsz7+u4x7gFhZQi4sZ+MpugxDbxSYslXTuxd1s4nWqrcDfYfNtN8HLExJbwKJCRgU=
Received: from SN6PR16CA0057.namprd16.prod.outlook.com (2603:10b6:805:ca::34)
 by DS0PR12MB8477.namprd12.prod.outlook.com (2603:10b6:8:15b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 16:45:12 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:805:ca:cafe::a7) by SN6PR16CA0057.outlook.office365.com
 (2603:10b6:805:ca::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 16:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 16:45:11 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 10:45:07 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 01/14] cxl: Remove else after return
Date: Thu, 6 Mar 2025 17:44:35 +0100
Message-ID: <20250306164448.3354845-2-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306164448.3354845-1-rrichter@amd.com>
References: <20250306164448.3354845-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|DS0PR12MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: 133903aa-046a-4f9b-8b82-08dd5cce42f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IZFlmdBQH/5ew9uZJ3ZQ0+2ubRU3NmS5XyZFuu74/37ItwDotP3ckTifaJvQ?=
 =?us-ascii?Q?suRVUG+sZ+IfDW7y90RO1nNYi1XuRHsdSKJRi1vtgX3ty6/o0cbTZZWfOFcE?=
 =?us-ascii?Q?5EPB1yZnXEHNf9TxT6wBzke3mTmIMBHOSicggcXdxAeFDYQXvax+93KMhH4C?=
 =?us-ascii?Q?WpLYB4P7kx/D77vPM1yTwOjNQPFwyfGk4ZwgXz797QCoBIQLq0dwZuD/jgrr?=
 =?us-ascii?Q?3p+sXt7ry21vXlGm315XCyrJXLY4rqladgSKmWomolCCxCQgPrvX9vG2E6Hi?=
 =?us-ascii?Q?cPDVRt8ggx8lTmTOIJmdV85mzAezzJgdwDo1pF7xXs0VXIF97P94jbYRemJ5?=
 =?us-ascii?Q?yF2yki3bpRiUXixjpyltxh+6QyCJT6UmRVrwH50NtSm+lX7T9E+pBP8wkGOM?=
 =?us-ascii?Q?yQKxgym14HnTXhoXjrL1w40LDtLwkfCk69mBINfSiF6LChMHEKDNpfsWtOoK?=
 =?us-ascii?Q?lYkZWzjoN3RG3Cad6GNmmkGdvMpw5xKZ8cZYoabHH/ONH+MOY3enM0c/2Hfz?=
 =?us-ascii?Q?KJWyPcctUX0z1vr/iZvvR9WvjbOcvBItBX6GepcEGo3VaOIbQp8R2E1Bzn17?=
 =?us-ascii?Q?S7VbxqQrL4Vamm0m9Xde0yn9RlZ8fGG1qUxt59hvvlOdhUjRpVWf0gOnCLPX?=
 =?us-ascii?Q?cclWURSs4PxAByfSLS1fYJtjsM15lilcEqaQC+rJ9ei37Of56CiqEXJvBFjm?=
 =?us-ascii?Q?kqOVGub+3qVOgbRukxW7iCfGIzx4idTy2VMpUNWs83MW1/joiGWEEEzcItGP?=
 =?us-ascii?Q?ESaBZp84eGjvVSno3R+K+ob3E96LBxg7xoEjy5HXyMQZgYafvT4l2KUF03kv?=
 =?us-ascii?Q?Oo2YqYZYbl5N/zekZ+vJq4/qIddtMjqax7pTrTzHJZoryOjqkKOH8Da0oZ8M?=
 =?us-ascii?Q?Yv8GVw7t8xP9s1RgZR+pMRXZA+sVo+P159Zphb7cNbGEw/G9OPTzId1zSTYA?=
 =?us-ascii?Q?8NUKb4cBoJtVheRkELU50G+ywuATdWa3T0WWKFlS1ooazBzELHD+QTGDXG40?=
 =?us-ascii?Q?UvNvrLHXxa++ImnI3mFGxMACtdyId2fifXyHX2QIHhb2cI942LBgeBE0G1DW?=
 =?us-ascii?Q?JbneH2mLHzM7nu4xuPnHRk7QcHKK64JKg1MBQZDObGwPc31YC/gxEPipujp1?=
 =?us-ascii?Q?VP0NW738M7+Vt3rqJlYqx83tBtVvXjeDtPj3K9rViu4LexOPirJjxmClql2K?=
 =?us-ascii?Q?qwU+xNQa51rZBHiKVfAuhXVviTZYnEwI8hupt/6sKZ7uQCyX5HH5TbQOj0p/?=
 =?us-ascii?Q?M8KI+ZUfS8W6lccSQx6D7YTmQlfbgxBbLrSl3i1k9nawhbo625oKMnkbADtQ?=
 =?us-ascii?Q?yG2NzXCmE3gFYZbKNvMrK8WEJAFmFUI/vIlo8DxgHEuQoutPKmR+OgNz8D3m?=
 =?us-ascii?Q?ipX7Ymuxr+44rONb1FBCv+bbF0u3GlF+JZsqUgB9sXHqy4oBO1pvz+diVW5o?=
 =?us-ascii?Q?PiAxsl7s5DbPECGtlnbVPotlWnlL6nm8aU9eoh/Ms7Iib00nCZNUz0zc/lDF?=
 =?us-ascii?Q?eJo09AOs/sm9D6c=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:45:11.2456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 133903aa-046a-4f9b-8b82-08dd5cce42f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8477

Remove unnecessary 'else' after return. Improves readability of code.
It is easier to place comments. Check and fix all occurrences under
drivers/cxl/.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/cdat.c   | 2 +-
 drivers/cxl/core/pci.c    | 3 ++-
 drivers/cxl/core/region.c | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index edb4f41eeacc..0ccef2f2a26a 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -28,7 +28,7 @@ static u32 cdat_normalize(u16 entry, u64 base, u8 type)
 	 */
 	if (entry == 0xffff || !entry)
 		return 0;
-	else if (base > (UINT_MAX / (entry)))
+	if (base > (UINT_MAX / (entry)))
 		return 0;
 
 	/*
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 96fecb799cbc..33c3bdd35b24 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -415,7 +415,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	 */
 	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
 		return devm_cxl_enable_mem(&port->dev, cxlds);
-	else if (!hdm)
+
+	if (!hdm)
 		return -ENODEV;
 
 	root = to_cxl_port(port->dev.parent);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8537b6a9ca18..cbe762abf6b3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1940,7 +1940,9 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	if (p->state > CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_dbg(&cxlr->dev, "region already active\n");
 		return -EBUSY;
-	} else if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
+	}
+
+	if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_dbg(&cxlr->dev, "interleave config missing\n");
 		return -ENXIO;
 	}
-- 
2.39.5

