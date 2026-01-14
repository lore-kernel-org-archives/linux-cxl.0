Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A6D3A4ADD;
	Wed, 14 Jan 2026 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409366; cv=fail; b=EOceu9Ir7ni3SOOfyc+jYRGtimylPXth7EeElB0DwUkwwYisSGH67abQZVPTFWFY+ICWNWpWGPqEocySVcnAi8/RLMgjdzIiP5IR9l6Y/EbbJTV/w1af0vDcysy+kTCouyaq+C679FOhu3dYPRon+ZKSEiws98YnOdGRKYNlKa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409366; c=relaxed/simple;
	bh=+8WOrg6X4MAR1aJ1euaZ1yWKHUmjq22f8wkI1SuIR18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyALhDfyEioL6F4Sqe9NELaHi1UHBm1GP6/yfr8/ilLYrk6CPXzQMpQFEMbbYRm8QZVoAARvnaturR2/CCC39QzDEW1+GPOVdj/VAKM9fr5+97nnelQVuazmZynaUbtcE9rWhQoB6XiFFKv3xrhmDdqiZH9gb8X8PO948gmSosY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sM5JPB20; arc=fail smtp.client-ip=40.107.209.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sM5JPB20"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHIzu5BgIl+tIPwmhwgi/2UmYbPBNVf9HEGfyPh+Jq1jv5D6Pb/AZ8MFAcPUe/SyGLRqPwHIH0hjSyXiR64Rr9lqcdx0GIjbxADLZlq56Y7qZlClsiwvZ38u6C8YOHtSRxBwFDIk5ZHaLJcL+W4XlcMi7hPIe3zNbnHEB5IU1swn4cHJC/+FhmNL2nVfNcqFgP9KL8OoWNxXIBN9Pg+1FNCThCpM8x5Bs1r8luIgNZ7EJua4hiT3JT7sX2tB/uqbSTO7VCJqkSP7hR47Tf4ycbdRLNgLT/yAMMA633V3AXj6wbDEX92iZ9iD/vtPDnLPe24vG8AqozibfUPKyhCj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mt8hgpmX3uUUpddMkt6UeK8qE8HBdFGhqQDjlReIWSQ=;
 b=qVxeHFYoKxEworS7rZAzDhXLC6talznebC+1gGa8AbEITzJSGIgqOEDWdALndmdiXhuuXPwL2Rp0QgM6qtMqTsyxo2FpdWqlWmASL6hlWFiRnf/yiY+tW48o91BMuSJy4nHVf2Z9JAVDo98qE5tWIQGvHmfD7Dl2kdIFG11dlEWZiEeo3RGjAZI9UB3KddbiwLvcGvZib4p2c9hzCq6jSWbxSL+YJeVGw7ZG9As+KfoPiNUb/+smDPHK8mXzPrh1IkvRZGB/KmAkv6Hdf7BEJYum0A/j3erjAynqo+0WDDQ3rxXqwwbPLybvTUR2UcC5vRX/TfEZGIt27cSfiIwOBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mt8hgpmX3uUUpddMkt6UeK8qE8HBdFGhqQDjlReIWSQ=;
 b=sM5JPB20rJWPFBJ07AGhUSS9OQf2gq0NJorEqLv3O+seAswd0JdeKYN7eN10x6pwuATt3aaWLtKUuGQ1xdHgoKXeuqGHpMwpkGwkKQ1ptzkCcjA5WQtJd7Sd3yuayXOinSVwF9VxWd/SnCuKtVQpcqxfX1X1cBq+GQzu4+UdjHs=
Received: from PH8P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::35)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:49:17 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::f1) by PH8P221CA0008.outlook.office365.com
 (2603:10b6:510:2d8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 16:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:49:16 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:49:11 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v10 03/13] cxl/region: Store HPA range in struct cxl_region
Date: Wed, 14 Jan 2026 17:48:19 +0100
Message-ID: <20260114164837.1076338-4-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114164837.1076338-1-rrichter@amd.com>
References: <20260114164837.1076338-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: e123d305-55c5-41e8-e65e-08de538cdafe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pu2OzHpTPrmHHjit5NoqNYpX5ITN6eRlqsnbmsOlns1Aym8XG4EbcSzkw5Aq?=
 =?us-ascii?Q?YTCRQsi862HtJCh8Rlwv3miyXDPHeZDP3SIy3IviGwN6RpzU/NEmGlfWP5OR?=
 =?us-ascii?Q?YB2oZ3IQOUbK5oHeZmO4I1UgYAh+BXnI7CZgynrrTfZtfkJI7H7d1qm0ZETB?=
 =?us-ascii?Q?B9qFKOewEZKG7HjyQ14yok1lXPez2kw+FGN263kPWhTvLT3xvdKLxX1WC85D?=
 =?us-ascii?Q?e+qktR4gc2MOfYs1FjzcBXjyD1/WPfY21nPmigtTO43GosULPOdCtYCHUKO8?=
 =?us-ascii?Q?Wuglb04zPrAyDQJCUGhsQulzmEh86/i8Kr3/QTxnOwhmrv1tRa97vadlVzuo?=
 =?us-ascii?Q?5SA1CQ19zQEaXiIDFmvwUOJftep+9JPKN9i5T6mCm5cY4GRh1NllPf7MDzZY?=
 =?us-ascii?Q?yhQpbAXsUoZmx8rJRC3S7IrYxfv0Xo5BB5sIef0isEwcQ1CuJjgfDEb/YhTw?=
 =?us-ascii?Q?jiUNngcyydDCcJo1GjbHVmuXQalZRAhZclHC/Lt37jazQgqhzkJj66WJuRfn?=
 =?us-ascii?Q?Q9u9rgYbcdvREBdjm1g9vFAx7fDVkw9P1XOQdYAlHK63U0V2MBmXrE7Snl9Z?=
 =?us-ascii?Q?qu2nlrPIGj+4By1XnWpWt5O1M818+4QPLAnfVSuM5zLq6Dk9G4cR7gbOVhs+?=
 =?us-ascii?Q?DxuQcToe9FBf3CdyTjfI/b4xSN//KElG47UlBMNa2QCKU4qQhCab0dWWrs7g?=
 =?us-ascii?Q?C8P06Delxb0oSvcIRtEtVHmVz63PLMctge+pdJho3ORUBDfCtEc7yvcyIY23?=
 =?us-ascii?Q?sfEXcSVSdK+wrvhFeLcQ0F9BucAazM/ndx8YLnpb44ctODzQyghCLCrjawn4?=
 =?us-ascii?Q?3U/ZFJZawOlQcl33eXJHgAEjGR0dr0ZQpmW+YHcTNMUMOtsAI0NQA23fwx10?=
 =?us-ascii?Q?8MBCnBh41ZP8wSXZiXY5mHdmDlHgcdtoC+VWLYtdhBcJMKM08MvqT+uKPJmB?=
 =?us-ascii?Q?1ngnlih3FphoBXJ4XQ4X18qAjBxP5QAOgdweM0mha4e3MhiwW5W3K8wq3uYB?=
 =?us-ascii?Q?qosFZzMARDUmj6HViNWaKet+0uPIpEOzCFSS1FLdibG1/lYADwgAgT8BVMvW?=
 =?us-ascii?Q?T9/Kx9pVJchAWXTXTSBQymScqeH7f5saaDSfwupVYbMVqmkEYHE7wODyYZbx?=
 =?us-ascii?Q?BPh3sispSUOKY9rPXczT0nxKdvsggUgJeVVV1zH+BqA56q5Ujyy26GAgq9zb?=
 =?us-ascii?Q?urZruxDZG9lUPSy+1bxmnsOHKj4zRq5EV0ZGYQSFheDNIOjo6MAcfY03vhks?=
 =?us-ascii?Q?TKyxfhnWC1ucGoT/uKYcf9Ikiok1VzP786jIWkR+anRVqxbmLkXC3fPioAGs?=
 =?us-ascii?Q?zF2XxcmGYrzOJJtVRPMve8vUxIZAsF41QWZv0NxQf3PfiIcF84DTEvGTPbvm?=
 =?us-ascii?Q?CYoSjPUuiUBq9av9ugPGP5sV5P6Xvq/mZaSktRR8y22xZN6mCTkXTj37Pvsk?=
 =?us-ascii?Q?jEWhoV0LXJavxmOm0FCFCq3mtUfXcMS9ClB02d78j6hCzTjKOPo/DpgkrZgg?=
 =?us-ascii?Q?ibgtV5KVckV58luGj/emtj/FfGtmEw2R40cOYlsbjuQGrtYmCuvC2Fg1oslB?=
 =?us-ascii?Q?WNJ9/TOxzQ2ZmNCwq1B2YFVc/i0ZXQTdqvjtBU/hr8Ko8q62yvTbb8kXC7lp?=
 =?us-ascii?Q?lDUyjv1pTQoKrNFXVa3o+ZBncjr5o6Lcbbs9xo9AJsIzZR+pYUd9LZkqIDJV?=
 =?us-ascii?Q?CKkdGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:49:16.6991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e123d305-55c5-41e8-e65e-08de538cdafe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917

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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 7 +++++++
 drivers/cxl/cxl.h         | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 22bd8ff37cef..04c3ff66ec81 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -664,6 +664,8 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 		return PTR_ERR(res);
 	}
 
+	cxlr->hpa_range = DEFINE_RANGE(res->start, res->end);
+
 	p->res = res;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
@@ -700,6 +702,8 @@ static int free_hpa(struct cxl_region *cxlr)
 	if (p->state >= CXL_CONFIG_ACTIVE)
 		return -EBUSY;
 
+	cxlr->hpa_range = DEFINE_RANGE(0, -1);
+
 	cxl_region_iomem_release(cxlr);
 	p->state = CXL_CONFIG_IDLE;
 	return 0;
@@ -2453,6 +2457,8 @@ static void unregister_region(void *_cxlr)
 	for (i = 0; i < p->interleave_ways; i++)
 		detach_target(cxlr, i);
 
+	cxlr->hpa_range = DEFINE_RANGE(0, -1);
+
 	cxl_region_iomem_release(cxlr);
 	put_device(&cxlr->dev);
 }
@@ -3579,6 +3585,7 @@ static int __construct_region(struct cxl_region *cxlr,
 	}
 
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
+	cxlr->hpa_range = *hpa_range;
 
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
 	if (!res)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 10ce9c3a8a55..3a5ca1936ed1 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -530,6 +530,7 @@ enum cxl_partition_mode {
  * @dev: This region's device
  * @id: This region's id. Id is globally unique across all regions
  * @cxlrd: Region's root decoder
+ * @hpa_range: Address range occupied by the region
  * @mode: Operational mode of the mapped capacity
  * @type: Endpoint decoder target type
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
@@ -544,6 +545,7 @@ struct cxl_region {
 	struct device dev;
 	int id;
 	struct cxl_root_decoder *cxlrd;
+	struct range hpa_range;
 	enum cxl_partition_mode mode;
 	enum cxl_decoder_type type;
 	struct cxl_nvdimm_bridge *cxl_nvb;
-- 
2.47.3

