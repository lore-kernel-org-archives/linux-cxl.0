Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010049.outbound.protection.outlook.com [40.93.198.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9862F5A27;
	Tue,  9 Dec 2025 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303703; cv=fail; b=s4dgvXePxB8VYt4kTLKqfKCfrL55yO4hAmx1epVwPzt8JVmsU9GDkiTeEth+elNy6IbCKYDI+csXiBfcFZRRfvgjTK3Ib12hbmwl+cudHoaBJivuRN18YBfWsMwD4vlHN//zQFk73Ql/0OQGSeT5ugP0Yko6+tUXJPqs8b0VRAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303703; c=relaxed/simple;
	bh=UnhNZOeIDzrR5EYSMIl5U+USG5hsj0gXtRow+YByx8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJUJ8nilvwE1sYFiAj83yQbCufS0/5pt5lFoYuJ4te5uk6wBJvmKMSSWScKPksxrpf9PzKyHlWs+NPf3FVI/kdrbIr/V9jsWhKNEF7lEgpFtF52D4SxP7WWffRetGYLyf0erunHa350OmOiGtV16HS4H1VACSkUwzuuA8vYHjHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=42AMvvwl; arc=fail smtp.client-ip=40.93.198.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="42AMvvwl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knv7ZwrcCcOU5Wz9ap7u2HAocHRz0rPcva/Qn1HYP/ZRibB2jeZC3OCo6ReTw4QQh32N1ExX88y+f0Jq4KB0H2eMmgAT0prPOEn+Fke4391Q8b6JepVRtb2SHnFXj0zKZ9aaDkdSlTvpDpXB1ywVAb1Z7H1Xub5LgFNrhJhCKZ0dAGoPZ8RBva0Yk3qyr2wrgZMgyPiYhteAqExVAq5uUtUB8cPxFxhFqQ4rhwrZ8B+BeByt1mC+7GOXd+vlLG2MtrfXvZ+1QI7fHtF8MX0NQzidOHRHOouiPGKns1CLwN56vAOCkoYhHYWn+bs/cA8XBzdxBRaKIZwmKq8whs21XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7PHh7TTTN9dNQWtfRfdQqbMSOuxccGPU4HgB3LxkiU=;
 b=QLq/wc9DYdP86t3FZFue4+kuxI27rrlZkwZ4TvKKQ0D78F2ufkLsi2OJgWfv4PkHNybHFVBX5RjzPJURzdISO+hsGnXLO3x/WCg7Yux2anJN2Cto5qnFpZXaeqbBtKcr6/T6/TLwsMr7DbdmyZH/GcDjGq6HaSFIhdh+SOIZ006QLPZxHB9cQb/wC11VsFNm4AatxTG5MMq9YJagFFup0XwxF6TmqWj42UOFf5Y8NzEu3SGmQC35gzjzoFIAp9jUsA/xjY8jf6akI5NeJAB9Z0cLejcyitDdi088WW2J1/rb4TAbdmeJagXuqpA5nM8ViWo5lNfoa3ivcfeYph59HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7PHh7TTTN9dNQWtfRfdQqbMSOuxccGPU4HgB3LxkiU=;
 b=42AMvvwln+QibqdY8H8/KlckLrrg1pJexy0fZMWAbp1rAx09aJB8wgj5wwFMhxWtzsuPaMjdaS8YdGG1mAgOsPpOcx9ILIEc6957kCNchK3sWuew2Yjfcv9t5gBbCLxPE0g4BppLvva0ajtMXUDEvFxCFGuoBnAzF2gqwaL1Ay4=
Received: from SJ0PR05CA0102.namprd05.prod.outlook.com (2603:10b6:a03:334::17)
 by IA0PPFDC28CEE69.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 9 Dec
 2025 18:08:10 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::2a) by SJ0PR05CA0102.outlook.office365.com
 (2603:10b6:a03:334::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 18:08:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 18:08:09 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 12:08:06 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v8 03/13] cxl/region: Store HPA range in struct cxl_region
Date: Tue, 9 Dec 2025 19:06:39 +0100
Message-ID: <20251209180659.208842-4-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|IA0PPFDC28CEE69:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c81de9c-073c-4b0d-2cff-08de374de8ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/i635THFZb0SLDhllBY2tydrUHgzxeLDWzTKM0nZ2OmKHeF54FwWewV+0bx8?=
 =?us-ascii?Q?6fvF3YUhxFm5AqgXbMpoMl+bhEDYq0bqvdDYubeSC8REMeY5TuX32Q3Qiyby?=
 =?us-ascii?Q?BboRe0fBaI8siveyjUyCWt/RPLKQZBFfyo2W1Uu2Jtkk73gAbMkZExi3KpHr?=
 =?us-ascii?Q?hBxLeiQuY979ZIAzORE3LJlSrUPz3dDBvgx4lcI5hFDUqFVT6uOuwSJFvbqk?=
 =?us-ascii?Q?HNpEUfvL4GonI3JbcuCd600MxLcX0KknFkkeMBeM6VzFsZucldFCHHxyzQ0K?=
 =?us-ascii?Q?+rPnv2WzpBLoyRxg4LS3TRR0Ba4IRInFRCqj98gvLuGaK2Ts6L+3FSCjI2Et?=
 =?us-ascii?Q?slYdjgssIsLiRqz4xMkADzv0J6dwp8HhMxfcds+Wy5nFsBX739vX5oGY7bj3?=
 =?us-ascii?Q?xRHfnCv7KbsypGQkueZDBS+zgKEskZze2hso0P0Q1mw1pSgbRKMyDB71AdzU?=
 =?us-ascii?Q?Bxaz9FGkWPn/VEliwLWF4LCmJoCU2V1oMjlaUBbq0cN5p5WwGQ69VzzjXOZ4?=
 =?us-ascii?Q?FBCkru8SB4xQtpHDpCGbm15xT0P6l64omCHIyfh+vy6/69xk0mKdflaoLAOm?=
 =?us-ascii?Q?TzlL5pb1xPl/4+wxg6xK5fjI1GWzhmm8GqNdOGNeHMKGFBehChdmqal5FDfu?=
 =?us-ascii?Q?vl5+NwP2w2L4HC5sV7lHVzm3HB63ehL9THlC8/z4iI91+fsWl9q5+HTGYtXZ?=
 =?us-ascii?Q?BkVUcs0TqbCGVUuVbYvItOPBhfz6hxIXzCY7q2ItyqQOF1oBzyxjaftQ+olI?=
 =?us-ascii?Q?8jIQTRMPgVGAidup2+ApIw9mh5oRGq4JdsqMgM/4fLOZ4lKa2sjoQUzS4fJ2?=
 =?us-ascii?Q?Yh3BdWZIOsYT+NLRbodHJlpsmDE0wuKrekcqDqc/1RxLrRJeG07UHs6sdfhX?=
 =?us-ascii?Q?n/SfOYn5AoxEexCblmI79VJkOEVCvBpca8TsP/Y/grHkwuTOvGdfjASXPZu4?=
 =?us-ascii?Q?EublntU2wEd3sFkqzq0OOEQjmtVOvLhJF1cs2JSuea/Wihe1CspcdGc4vl1S?=
 =?us-ascii?Q?mrZ1LUmGkBWO872O/GWrYORbsXH7FISMkuHLEv4f8mTkAWNvi3psw4kj7mzt?=
 =?us-ascii?Q?5ZGbbfqTb6KauyRgpJpwwIKZR8Fp5ARDAT4hBIP7pFCgwE38Wj80trkscYkt?=
 =?us-ascii?Q?f/uShQj2qiDkTHkaew2mBWy1wZ7YZIFahG9hOYLOxqvlz9o2UJSaR9qeLZ3l?=
 =?us-ascii?Q?eUB81QJhD3nksPClXyLqDKyJN9IV9RtKyyEgEgBhvgzHfxRnrL2dBcDNc2Dn?=
 =?us-ascii?Q?aKRPQSJtEUSEyL0j923iM78zRYC5OR5jOVeDqmmh2+n81sLXbk+1Q2W1ZIXw?=
 =?us-ascii?Q?HF7WMGzRjLNqlNQ98KOt+IL1rLhvtHYoA97DcpgSC1elYctVGgDQEnLwJ5Xt?=
 =?us-ascii?Q?LS10IgH0eBSl5FKM3buzC6sJRsLQfO8GwsopH+aFa+1yKkch9TMJK6yVzrBv?=
 =?us-ascii?Q?T9DsYtcpu0zW+Ky3cwiePQPuFgO5ewXcNR32ei7WaDA4Ognr+HuAUnrxyAKJ?=
 =?us-ascii?Q?TESrxLIDfmrrH5u+pusHQfu05CvmDTl1cVxUJlQ+wEKJ2c04YWkbe6RzpLON?=
 =?us-ascii?Q?HrrQ2WveAGlqox2f8J4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 18:08:09.1753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c81de9c-073c-4b0d-2cff-08de374de8ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFDC28CEE69

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
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 7 +++++++
 drivers/cxl/cxl.h         | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 077cfc75e081..57cf3ab28f43 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -661,6 +661,8 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 		return PTR_ERR(res);
 	}
 
+	cxlr->hpa_range = DEFINE_RANGE(res->start, res->end);
+
 	p->res = res;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
@@ -697,6 +699,8 @@ static int free_hpa(struct cxl_region *cxlr)
 	if (p->state >= CXL_CONFIG_ACTIVE)
 		return -EBUSY;
 
+	cxlr->hpa_range = DEFINE_RANGE(0, -1);
+
 	cxl_region_iomem_release(cxlr);
 	p->state = CXL_CONFIG_IDLE;
 	return 0;
@@ -2450,6 +2454,8 @@ static void unregister_region(void *_cxlr)
 	for (i = 0; i < p->interleave_ways; i++)
 		detach_target(cxlr, i);
 
+	cxlr->hpa_range = DEFINE_RANGE(0, -1);
+
 	cxl_region_iomem_release(cxlr);
 	put_device(&cxlr->dev);
 }
@@ -3576,6 +3582,7 @@ static int __construct_region(struct cxl_region *cxlr,
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

