Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7C63101AE;
	Fri, 12 Sep 2025 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688347; cv=fail; b=iL0suMu47O4EUzPglRBqehb4WLuEsPP0iaPWyMlxlJZA17Q40eUNDLro0ZQ/+0n9+MzOEVhKwSg5rdOOhA7cGO/L1nrJsW7RlC2ivDIfILUBZAF20PqpID6QYNKJeisMHngNgnSQ3DYhHWxL90Z/gq+V1o4vCVvXnELpKyhGSSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688347; c=relaxed/simple;
	bh=3nD/UTAL1znSLViDwmfn6Bg2ylrr5PQXUlfBE86Dmzo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9fl36esS6Bt2EtFD3U+BIq0nKJ/h/FpAwdyjmol2Y0dbFbcNxTvDW7bcGInjBlbKM+49BZvMaj560ONw2XB/dswyGVP9tLnRd/eL4wpUhvOcuHM+3xlQEBl5/rXklWI3UC4erbQclAZsDvLi+L1dLip9lQ+6YxpMTyyXuGUBok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BMqOw9I2; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BMqOw9I2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYfrv71grnu7v72Oh1TFpXiSec8AeAPHxuLEJI4yu/4HQrzBI2l/ch/d1PhLhLBVzD2PMcXLCOMcw6K9xB6vbhAUqpiS4WrgN9YCwK5l01Um/dTfRxxHv5WQMaVWk8RRwbNlOK5e9NHlovhWVnsZJPbTxmtYVFLXOAnKxQ2h1k164ho9fB2Ujls8S4hn67lkinsPo6zCyIwDyCBB6IAgRIV/ddKyqEJyFnegLq5Y8po3t1DyZpqCOHrjmkkcDb4zvHfdwqIdVGZCQDMHifFGWjYrKsMsYLDiT2e5DlYewuVyco3IZD9Ozdk8nf0RMcWA1uaRjP0Myet5W7DqGx+XFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oj51Oi8DLTdBft+RqQztAGagbVtX2VAFkhKFTLZFBog=;
 b=fsyyl11fB456nvsC4M5brGHLj0ELbeynJgep6uh1ku/2OaYNf8WMFz44gV05eO88EppWEQiGUxvmrwlMKwESTZPVO3dR1x3g8dozyq6KCs8gKoQKiCMasul5TW5cGGitA8HoosRst2XzNkkivuR81JTr8Cg/Z7g7yyfYrpJ/N411oOA7sw4dYXH74RaYP1cuvxtnN0ggewVuZjEj3Z29o46sD/Vv6jiPNyZmUV0nuIYBZuIeo9+TDr4Q9u395YYGOgbLTbO0Cy5mfxerzZVL/DKhWiMRbNHx5vtPuXevk+Dtk0rEcWvgEA/oUNMUqzrk5pQdbD3xERlYyjHh6hcAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oj51Oi8DLTdBft+RqQztAGagbVtX2VAFkhKFTLZFBog=;
 b=BMqOw9I2WhLX3c9DJ3PQbu+z+qTW/2Wt0METN0CkKmA1TRXSchLmifeLuPD0ET7uYR4Ap3OXY1kIgVkNfy6ZbbAIALdgoiihGp18CcOdWDEHOANbKn2RQ1vfgz0KEp3e9EWzPtXEbkHE9hi4JBqBPmetGsXYjQ60N3OfOP0ZZAg=
Received: from SA9P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::8) by
 BN7PPFA8145BD40.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6de) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 14:45:43 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::6d) by SA9P221CA0003.outlook.office365.com
 (2603:10b6:806:25::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 14:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 14:45:42 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 07:45:39 -0700
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 02/11] cxl/region: Store HPA range in struct cxl_region
Date: Fri, 12 Sep 2025 16:45:04 +0200
Message-ID: <20250912144514.526441-3-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250912144514.526441-1-rrichter@amd.com>
References: <20250912144514.526441-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|BN7PPFA8145BD40:EE_
X-MS-Office365-Filtering-Correlation-Id: 4420b0e1-d44c-45fc-b2e9-08ddf20b0cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?niNinPH620fkgWLTr9R7mZBitsCekBhobwLuMnrP/55pMoMd+XTpGSeIgNxR?=
 =?us-ascii?Q?9Up4HDHcsqGPxtFnL0OFZBYKsrk3x1wQfthkOZ0GEQ2jI1rxK+JeJeMAfnai?=
 =?us-ascii?Q?JpL3NSdT/m7tj7VrYHLiDTlTGyhb8qfIhPWEa+ynhL07MiWXihOl4qfQ/yGV?=
 =?us-ascii?Q?xeCBdTW0QhDunH7k4drWk2kUmAbZ1vmX+Yo/pc1GLZTU4QarSJWTmTLwpy05?=
 =?us-ascii?Q?MoRH2DWRkmh+eqh3CS8L1v4FpT4JOcUJ9P6FWlgVjofhX1ykEuLMpWPnsn67?=
 =?us-ascii?Q?ZGQvDVSZqNjwH3hrgckU+itOqnWme3g9Rr/GFoTY46sGSwFvHnNp7jzkC36p?=
 =?us-ascii?Q?LcVSJkFLZmVadGiX9twjP0LCHE7KAmrGpWE9Aka8vop7IwyWlsidgZjGe0Ck?=
 =?us-ascii?Q?BuIFM5MurDPxF7XhSA1s6/TkFTUCHOVfojFOVJBPKhl08zQUSV/OqfpWLw2q?=
 =?us-ascii?Q?YX4nQgvIZz8OAHDg3HsbmueR/CIyf+VEci4fiH8IMNatT3bAi72b2j4Fd/iW?=
 =?us-ascii?Q?WURwiwKBydEFmkKS05eXshuiP8FLPvKjQ18AsC5eOLkl9ntxAhGfcZUhchaA?=
 =?us-ascii?Q?vsorQcoMH85CxQlqnsxwpACOxMZ4SsmSmMrVr9zWEfNGKegJaTgwUhDgiReC?=
 =?us-ascii?Q?zHNTMFdG115WKLTHZeH7hNQFrj9uLqm7VRS8i8kYCD2vWlaj6g4mTMMWc/hv?=
 =?us-ascii?Q?7OQYYSHCI/a1TxhfhqmTFEAa5sqBxi/pKHuhidQCXYF33j53xkwn7PzyDU15?=
 =?us-ascii?Q?1S1DxJc4yiV5d+/45N3QPa0emovr31VaTlBu2QZqRutAb293RiG9D6bQxwDs?=
 =?us-ascii?Q?bRNz+D4lkhQVb+gsyKeN7dnCsTDmXWfmhQFLWoSvtU3sddyOmQl1MQrGkXdF?=
 =?us-ascii?Q?bXxa0yW+2lnsP0j5xura0Ka6YAGVA0VSW/OD/x7LLR9SL9DrE0kPNurdNTXg?=
 =?us-ascii?Q?Fr0iXtzIjBF06oPlMWgKgzie0bzRm0pbArZ0s+xmDKW2vYoOfENHFtr0tfjz?=
 =?us-ascii?Q?OLCqN0FQNHdCc7eiT4I+f09EmP5JpBCikIAwXdwVXR/bNZ/lIYAxAKEObsDE?=
 =?us-ascii?Q?I5T0NtZTq3m9u1YtHeNkO+ByAnrU3BMQjHYTGWvAMhacjsQnZ0YvJ8ZW2yom?=
 =?us-ascii?Q?D1BxC1Z7Yxcvwj9M79AB8Lr1aQojSTe4mXF96Mi2QrjP4jCbVoX1gfu0K1n3?=
 =?us-ascii?Q?iTHFuoHHC/g+sf9tqeoXVZm3HOyFfYaSKI7f7BKug13YkNa7zzTYxgpSz8Tp?=
 =?us-ascii?Q?qZrA6ts48Ru0ThXLLbDUqK0sDHQZbBf6jyZ4osOHKRAXDgUrtCrmspy3NR3U?=
 =?us-ascii?Q?wJf1oFIm3yOp3CZh1nn3PyKEdMX3i0txEWNCr7zNkkzJG7E2oCiM1/qVjlKp?=
 =?us-ascii?Q?3egbrEF2iPpoEkaGiMJn89jyAeQhyTyao+iAvcEhndvg6CmmOkfL7hmj9tf8?=
 =?us-ascii?Q?F/2pV8jmLlM9WF/4mNsAJVfVOL5V0FrWW1AsBGNTge4aYccWCkEfZ5PfXGhm?=
 =?us-ascii?Q?whXDnIs4W1i4SJAG/AIt1JYNIN/ZlviD6CeF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:45:42.9655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4420b0e1-d44c-45fc-b2e9-08ddf20b0cd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFA8145BD40

Each region has a known host physical address (HPA) range it is
assigned to. Endpoint decoders assigned to a region share the same HPA
range. The region's address range is the system's physical address
(SPA) range.

Endpoint decoders in systems that need address translation use HPAs
which are not SPAs. To make the SPA range accessible to the endpoint
decoders, store and track the region's SPA range in struct cxl_region.
Introduce the @hpa_range member to the struct. Now, the SPA range of
an endpoint decoder can be determined based on its assigned region.

Patch is a prerequisite to implement address translation which uses
struct cxl_region to store all relevant region and interleaving
parameters.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 17 +++++++++++++++++
 drivers/cxl/cxl.h         |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 2c37c060d983..777d04870180 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -664,6 +664,11 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 		return PTR_ERR(res);
 	}
 
+	cxlr->hpa_range = (struct range) {
+		.start = res->start,
+		.end = res->end,
+	};
+
 	p->res = res;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
@@ -700,8 +705,14 @@ static int free_hpa(struct cxl_region *cxlr)
 	if (p->state >= CXL_CONFIG_ACTIVE)
 		return -EBUSY;
 
+	cxlr->hpa_range = (struct range) {
+		.start = 0,
+		.end = -1,
+	};
+
 	cxl_region_iomem_release(cxlr);
 	p->state = CXL_CONFIG_IDLE;
+
 	return 0;
 }
 
@@ -2400,6 +2411,11 @@ static void unregister_region(void *_cxlr)
 	for (i = 0; i < p->interleave_ways; i++)
 		detach_target(cxlr, i);
 
+	cxlr->hpa_range = (struct range) {
+		.start = 0,
+		.end = -1,
+	};
+
 	cxl_region_iomem_release(cxlr);
 	put_device(&cxlr->dev);
 }
@@ -3458,6 +3474,7 @@ static int __construct_region(struct cxl_region *cxlr,
 	}
 
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
+	cxlr->hpa_range = *hpa;
 
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
 	if (!res)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 350ccd6949b3..f182982f1c14 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -518,6 +518,7 @@ enum cxl_partition_mode {
  * @dev: This region's device
  * @id: This region's id. Id is globally unique across all regions
  * @cxlrd: Region's root decoder
+ * @hpa_range: Address range occupied by the region
  * @mode: Operational mode of the mapped capacity
  * @type: Endpoint decoder target type
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
@@ -532,6 +533,7 @@ struct cxl_region {
 	struct device dev;
 	int id;
 	struct cxl_root_decoder *cxlrd;
+	struct range hpa_range;
 	enum cxl_partition_mode mode;
 	enum cxl_decoder_type type;
 	struct cxl_nvdimm_bridge *cxl_nvb;
-- 
2.39.5

