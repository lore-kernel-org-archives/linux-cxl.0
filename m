Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013055.outbound.protection.outlook.com [40.93.196.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F62EBBA4;
	Tue,  9 Dec 2025 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303687; cv=fail; b=kcqx7T4GR5gBOFsEZVr7gkExKp3urSVo5ThZcY892VzB+D7gI0/PnnUK0ESgwNFmSzg2XYoJCF6u3DN/BlUxoywRNwcxaJk5PQUvU8j2z4PW7JMlQxhQIbhHrz2hVwVsjC+I7LdQa418wGV1Kuk4jbxySqEq8Sly72KolD4Pcr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303687; c=relaxed/simple;
	bh=Y/1VgocAEMKQsho4uCuVYn9xMZ/sS31BUmMLuwm2eYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qf9IgiVzxgF2Ph0K5SdX4AfLXaWXDOWds6pO5jQQS7luQsf0sZWBiFpERuKNTb0Mf5DpN/CAvZiu1kJ4SMoQ0ZYW7KJMltzZ2xQlg5yXBZRjNx30Bz9E5WLgDpkK8N/xwAEElob07qCIqjJtEBZ963H6fPKtHSpAe2V10HJ75M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fzxz/E6c; arc=fail smtp.client-ip=40.93.196.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fzxz/E6c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeOI6fg2jIRB8s6U/MviuWlPzoeOgrGNMJz2sW35XEwTBT12rpwmZe8gY23DR0EZaYHrhZq218uPqXb7baxVFi+PY62eYaURrhiOoHhXcVa8gUth46PQi9F6JE3HFKL5FBbj1fvaNrtBCW+8xdE0Jx1ZI1r2NUAbjT9S5ldOzOBn2snViM2BTggJr/3FyHIbyuuDigddluIE0/qYciZYxl8RhHPM6kYqUBH4kaFnw+bnuJ5KxX3/v/zbLfHfCNQVB5XI994dyav1X29L3RjF5TVT/XP7Hp5j0tA+Gi4dbrtMiMr4whfLcvzoJF75cNgICasy37e6DVi1ABlwgHP3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLdvlBewrX0IZ2Qzn4/bys7Od+pwRFsdXiBlApmT2/g=;
 b=qn/pMpjJJkdepDZz+A7vsN1ohslvDS1c2uY2tN1L6CP/lOla08g1jHmkPLkAYAoH8nmAP2qRU4b5XpR/H+vMZTqaZnXDAISVfeTo/8z2034oqDhGGs1dbFnQKA6wQMhFELx1zHFW/xhYS4Yve+eDv/SU6HMNmZzRSc0Nf5oE1l0ntbSk4wi3dk9uAyyGt4kccKpcWqMHJ6IWpk+vStHP0UtkAD8NWEarlJx/JJ8xGcmiTaO0TUL9SdAtb+kzjDW0u2/GMLA9ltkxsCjy2TGYl/4H2bolqx2AZ42TnoYkILvzQmg7Rnk0O259KhAeHSe8OsgP3jFwWmNZObV+G1o9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLdvlBewrX0IZ2Qzn4/bys7Od+pwRFsdXiBlApmT2/g=;
 b=fzxz/E6c50m907CV+ULGo1hzR1fxz42MkvbeTHs/O1sw1frksJoq1iPHUDiye6alcX2OmCZ0O2DA06OsMiGEVi4gW2TeEQPhi/VQdDTiIssQVwwGbNjqc6yzsz5XKi0AZVljtpaHZAvdGeG7X6uqsM6PA+39+nE3dEktlVU8cOs=
Received: from SJ0PR13CA0082.namprd13.prod.outlook.com (2603:10b6:a03:2c4::27)
 by CH3PR12MB8484.namprd12.prod.outlook.com (2603:10b6:610:158::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 18:08:02 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::54) by SJ0PR13CA0082.outlook.office365.com
 (2603:10b6:a03:2c4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.7 via Frontend Transport; Tue, 9
 Dec 2025 18:07:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 18:08:01 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 12:07:59 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v8 01/13] cxl/region: Rename misleading variable name @hpa to @hpa_range
Date: Tue, 9 Dec 2025 19:06:37 +0100
Message-ID: <20251209180659.208842-2-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|CH3PR12MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: a78d43ef-ac07-46ca-b559-08de374de48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oaf/1LEF+RtYNhJGCV7DBuof89JWu3fz3oB3BKxq5thluMF7JwZKxQqUjZhv?=
 =?us-ascii?Q?PBx5B5ZPLu7X1E8Xo5P/qybMkIOyjBEZPotjXxtj0eghX5hkzKc4qerujh6L?=
 =?us-ascii?Q?9nitz4XKCo3/WQfRbhbqymASVlYJIrha3LVP6Ti31Trg0Q11JrptWnsLyJ/X?=
 =?us-ascii?Q?uhMy//ynH2l8Lqer7EjslQKQk1sdkSdejryZw/pV6KSQF0W++1cEc6vq+BlN?=
 =?us-ascii?Q?I/yuZDJN3zF7b19fFj8qpxzi1PmZFJlXMNNJw+bR4D5/ebItdz8y8QN4VCLO?=
 =?us-ascii?Q?YKWmGbqvHOGq5IDXvfa2ViE8bg5QxTwSza0H9BKEI2e4sVcGuUcDNGL8PE/Q?=
 =?us-ascii?Q?cgEaOTjHiGidqLlgHa6gv5SoFevnunLxCxsfihKEhuM8LFBDTeZCilxBAO88?=
 =?us-ascii?Q?HTtx90un09P9qzsO76q+nDoUlFPOuKaRBoyHg/5LUfZkZtnK4Tv6XFoW5ic6?=
 =?us-ascii?Q?K62q7hW8NHxPxAk4feYnhd9/tPKTeiEgybey+tXtx94O+GFif52onSgOqBAd?=
 =?us-ascii?Q?ZCmWYnf/duubeYQ1sF7D7bDTOi2Ed8bAujxUQuicMNprOIDl7/OKMohas0Gw?=
 =?us-ascii?Q?CqyeDve4md4n3U8tX8XX+ewvKJNHOwTrEWpEFA3mJH6QknRr8/t1UKGstRxx?=
 =?us-ascii?Q?uDOD1G4LxL2OaWhTikeBBzYsssmVS5vkjV5EUOY0onOmUtBa3nBt2pWYevqz?=
 =?us-ascii?Q?/EoHs6eBTLKZX+y7yNLoTSx8zmfnprDQmaBPax1u39SCrZ2IKE4XYqpSe7lW?=
 =?us-ascii?Q?5Pg+Uk9b+lzm/kzYFcFJVpq/9P38WHg4gK+uRQugukmi2vwT6s6HorLQRTPc?=
 =?us-ascii?Q?OUj7qW7CWTGCJanvhHYMICCRY1XOxLz+2VmGzPbmnKMEwm7RJd5bCH4bvxyQ?=
 =?us-ascii?Q?qC+UDuYJz6BnTyqPmQZqN6uvKJnZxI6mXWvQli7wNAIHhEZ7M0wNGc235+q2?=
 =?us-ascii?Q?BfMQvK61wTRcyzrRfqmUg5OIuBASkGRpKfbSkWXigle4aLew63KWH6LO7+ic?=
 =?us-ascii?Q?7lWTfmXGj5ief1aZwthQc3COrZAioOo0zw0rH/pcQKa7ypf/rQJLpS5t3RIy?=
 =?us-ascii?Q?HfCQ5+fep7ZiOZompVC5CAt3+kGUZT7si//EHx5TLzT3a4CQwqUpZR0v9xaw?=
 =?us-ascii?Q?XH3yRJjsXk8qeNKY6Ff5NMgkplLi7ijhAi4/z+DpPvpq4PywqB2uT7k9HFjZ?=
 =?us-ascii?Q?NdzP0meUcYKMP57EXdaMgad4QeEGOoDrYSc9Lg7GN9gJjY7QTlZi5zXpUjF0?=
 =?us-ascii?Q?+oxqLBkzN8vCzSHp4L89JZRjEjbxPJyWVeti9h5QFAbC2CA9s3eA1hXV1KXA?=
 =?us-ascii?Q?8fVcmTYwg7wqmTIFUVI52c9Y/5rVgHGS4jELdQ0c0o898FVwywQQpub2gtE4?=
 =?us-ascii?Q?UEmjSzob2+0HcsAgCG2hlaGvWC80URvo6ebedUR02ePOlnJ9nBqNzrDdD5Xd?=
 =?us-ascii?Q?2fhIJlk+SPtOGc2Um0sftSJquPmvI2j2mLW8earHMDWcg0xW5qxvwTfTiVws?=
 =?us-ascii?Q?ZO4PHqg8egeSRPa8GuLbaOI3n1e4kqMZUNZzZy9BwLiizi3W6OUKR3T5gH6l?=
 =?us-ascii?Q?IatPeootJAVzGiShjDI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 18:08:01.8453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a78d43ef-ac07-46ca-b559-08de374de48e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8484

@hpa is actually a @hpa_range, rename variables accordingly.

Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 2cf5b29cefd2..1fd2a13288e9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3471,9 +3471,9 @@ static int match_decoder_by_range(struct device *dev, const void *data)
 }
 
 static struct cxl_decoder *
-cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
+cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa_range)
 {
-	struct device *cxld_dev = device_find_child(&port->dev, hpa,
+	struct device *cxld_dev = device_find_child(&port->dev, hpa_range,
 						    match_decoder_by_range);
 
 	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
@@ -3486,14 +3486,14 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
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
 
@@ -3559,7 +3559,7 @@ static int __construct_region(struct cxl_region *cxlr,
 			      struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *hpa = &cxled->cxld.hpa_range;
+	struct range *hpa_range = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct resource *res;
 	int rc;
@@ -3580,7 +3580,7 @@ static int __construct_region(struct cxl_region *cxlr,
 	if (!res)
 		return -ENOMEM;
 
-	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
+	*res = DEFINE_RES_MEM_NAMED(hpa_range->start, range_len(hpa_range),
 				    dev_name(&cxlr->dev));
 
 	rc = cxl_extended_linear_cache_resize(cxlr, res);
@@ -3663,11 +3663,12 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
@@ -3677,7 +3678,7 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct range *hpa = &cxled->cxld.hpa_range;
+	struct range *hpa_range = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	bool attach = false;
 	int rc;
@@ -3688,12 +3689,13 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 		return -ENXIO;
 
 	/*
-	 * Ensure that if multiple threads race to construct_region() for @hpa
-	 * one does the construction and the others add to that.
+	 * Ensure that, if multiple threads race to construct_region()
+	 * for the HPA range, one does the construction and the others
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

