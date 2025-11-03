Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F5A325486;
	Mon,  3 Nov 2025 18:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195785; cv=fail; b=pBeeyMHkShmPdqOp4meAw5E2NI++PyNFlG944feOVdx/jEZa5Y8UcxzmQzp2d1AfVdKiy038hJ/IpZ4MAGPop5oSz7+h4bajpjW2ySAjYZT4H5bkI251gv4xwTblf0WKhUXeP5EBAkwJGAFStcgFEPVzdCg+ot0GbMyIbn1Aa8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195785; c=relaxed/simple;
	bh=X5DyU17vixBg/iwFVji7Iv/0jPHfaG97H+2JQtYPTug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGmHsvC6rxGiVWyvUH2Byoo915+iMJ/NnbNSSbXUp4vlHrF31fEjRgWoJvPca/s2HKfgurvCJgUbGw+w+mqd60CGfov3Zid7ZaUlUGadSK8izsBq5pvVWU3ZcDxF41VNj1kLJWHoV03C5WVkzD1e3GgMbFyg8xFtKjSbVPRjknI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=waUjT0wC; arc=fail smtp.client-ip=52.101.46.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="waUjT0wC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNV0PVejAwjXpt53V9CWSlBgYqG5/X0WOHirllR/2E0FavAt4s/0QSJ4bdyGh/3I0gFRu7Q9zbh955Y6Q6uWhFqYubrfFVb6OErTACwbFi7EwAMfXS779DG2IW2Vw3Gw0/TByEgRbBFEZ7w9+hXa0HD28jIs7QFLkMTEQSurk85tgfaJ+TK4tra1WKdO0T1kATK3QsCd/8U766Kcc2lx4FNXeA7ZVALqeIgqSDasiLqRcNfENlUCw4+ehQ+Kd+mStemXeS4vpJIeP6HYHu1TEs//8OoIX0s5G6MSdhfKI1lDdF5XDJkT+jLOHtpSl1YjjhjbdS/yqX4Ta6y0QJho/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idNK61gB1kLSUaY2VauNcNrSy/R+NozwFw+8qDzqeD4=;
 b=GdnKiaWd7HOp32uWzkfvEyjD4MELqSYIB9qWFEIJmKt9yG8hNKLZTCRsCNN0BX+o/PFixIXduFKM2uefxw2hRWoWsvcdFyc4E18z2blahBDuY5zo6/jzVSrKpHQIXgHHk3LvYbgiENzw/FWHLY1gi7k1GjTXESnfQXdwP0eZAWvK2VBPFSSBi5keD9f0fAkbn5jX03IBnNGZ0dgi4lfIOv9gV/4zhqO50fHBDOFem3nW7BfOtJaKAIJNXOf7HgG3E4Snaxuobabl46eiyFEJb6/iq/YJaue39h8qRRf9/uC0jszTjYVwfxlcukVRB4gwhZJTxgC21zec1E8NFeRjXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idNK61gB1kLSUaY2VauNcNrSy/R+NozwFw+8qDzqeD4=;
 b=waUjT0wCpOaiowkUhovdiMwb2mg6lKOPQHRYabQ/5eT3HRgw3hz8aZIhHrDcknivurs0USOioDN6VxDDmzyFl1VfmIVWWQKNpwVsAj5xGE9iCcX94h4qqXfGyGIphp2Zi451+m2jMzr1LarTBqxfzpnqG/Y6ktFTmGHr6F7y0xw=
Received: from BL0PR02CA0100.namprd02.prod.outlook.com (2603:10b6:208:51::41)
 by PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 18:49:40 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::a9) by BL0PR02CA0100.outlook.office365.com
 (2603:10b6:208:51::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 18:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 18:49:40 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 10:49:35 -0800
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
Subject: [PATCH v4 11/14] cxl/atl: Lock decoders that need address translation
Date: Mon, 3 Nov 2025 19:47:52 +0100
Message-ID: <20251103184804.509762-12-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b43941-7602-467e-a797-08de1b09bee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a7svI22co2l0pjzb6wBMtkn9tV+Aovx7YIjdQrwsMZnJRcrZCiFn2ME7V2O7?=
 =?us-ascii?Q?suBltz6mjShWQGDgtoeM7L6BS9U89oR4BOKYwq9CeqMggqsxWOI7JrpKAzyR?=
 =?us-ascii?Q?eoynbweL5fdnPMEvQ6p0AXqfvOQJ5HPn4v5MlOUqlz7LjJ6ocNv17ktefwgW?=
 =?us-ascii?Q?3RQeGpcM44SIbnQtoNPgEfYCPBzmOM4uaV4Dqnj/wd42B9W5rtbPwL+RAghj?=
 =?us-ascii?Q?qkc30aiNcZRtN4SjktYvj1GQGwfCZD7hLfbggNDd926jRckeQSkPuHo/Ux/7?=
 =?us-ascii?Q?ls4XvEDMatdUw24Tag+B7IUvU0ZCpRlku2VZW6vneO72m9PlHfwQpfZOIUh7?=
 =?us-ascii?Q?lQMWBJINGZ6GMO2kWQ2NOE3n1ao39oDWuJKaobi84qRxuA77znM1h8GAfT+/?=
 =?us-ascii?Q?MbqlspI/bJpstnEOb/Xzqv4eZYFcZh1V6GozotmM77epxAvhaBioc+WOgD+Q?=
 =?us-ascii?Q?DYt/42POd55Rio1JI9E5wZ8UWlNEWr4RBWG56bA7k2zdd+KErIqbI7989+of?=
 =?us-ascii?Q?y6lGXK7VaN6BHhOs2oi5WtHWQ8EDjaqIcWTF9wiMlyG981M2q4V65st6Flpm?=
 =?us-ascii?Q?1zx/rHn5RG/5QPWRBGqmv2TRXzimtBpIt/kfA8almS7HsFvlf/g/z8A5Jr4S?=
 =?us-ascii?Q?6aPGJe5Xz3Bvy+K6ban3jhltXwvNiqSSNYD9yZd1LXmk3N2DpblaKDvLVYLI?=
 =?us-ascii?Q?5Hpp3v2ubT/I5sbBLvbI02wlU15SeJohsAVG3cxc6vf0m+0fAZIbSMHJuQGl?=
 =?us-ascii?Q?bbQ9VWvOop8TYFtpTjjIp9IdQr4EokLJ4HpjmLvucBUPsPNntHdjRfAnBYmX?=
 =?us-ascii?Q?wfwLYTVZuuHmaiVcZnQb2S1dCfghqDqS3uzWc6KGf5mC0QOx9r9e1631iSmK?=
 =?us-ascii?Q?NTvaACcP4jPeKFqqr10ukvf1AXidLicgOIu+jMlRuzcHllefXUhZGGsf0ING?=
 =?us-ascii?Q?/ZkYdP3gtD5ukSYWdSbLxO8ksPzJUI+VX3qa1UQ/q6b+XAelVpWxxypzcGF6?=
 =?us-ascii?Q?9fJTrNNvfre8WomOSJBKVuHjlynPNmtpmrBOv1z93iaT6dgYA9/heosi2/HO?=
 =?us-ascii?Q?nYjNkb84tDO9AZmY4hqy4fYIXkoFYNTbr/Pfknrk74c6n8+0TzzyQqPVzyUO?=
 =?us-ascii?Q?SagID8zkryjZRlnN82E39bJI1EQX2GLBW4QYSwc+NJyC2UYZqUYAXFvhb28s?=
 =?us-ascii?Q?VkgI6/L0uBtBwd/00SxNeaygfjJkH77MfvP/ICcQp5ifkvmhEyXRdTl11POA?=
 =?us-ascii?Q?ScFlvl2ByUWhY1txWCvQ9raOdqN5mw3/O4OZznhpd181UGQlH+G5fUFOqR+B?=
 =?us-ascii?Q?SiPzX8kZMieYwdCs0YSLXeG6Dc5Ts34V5l+b0CxU1SHdOFiK02xb4g/dN3I/?=
 =?us-ascii?Q?YuJsHctpmhSzBJEvSJ529xbTH3Du744supg9nU4bblXzahFnH3TZYh32J8Sk?=
 =?us-ascii?Q?2P0mbw1j4A/urFRbtx99Sa1DAxalaA5rqIaXc8gjlBNSylkwqfcM4DW5jzvx?=
 =?us-ascii?Q?vmWIGDaVsP5vGZO6JamGMTNT9qeZYcfegHhAPPEIgpH3S1jmBuhCJwifvQr7?=
 =?us-ascii?Q?OLBo8Ng91CwucGjcRUc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:49:40.4332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b43941-7602-467e-a797-08de1b09bee8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349

There is only support to translate addresses from an endpoint to its
CXL host bridge, but not in the opposite direction from the bridge to
the endpoint. Thus, the endpoint address range cannot be determined
and setup manually for a given SPA range of a region. If the endpoint
has address translation enabled, lock it to prevent the kernel from
reconfiguring it.

Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/atl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
index d6aa7e6d0ac5..5c15e4d12193 100644
--- a/drivers/cxl/core/atl.c
+++ b/drivers/cxl/core/atl.c
@@ -158,6 +158,16 @@ static int cxl_prm_translate_hpa_range(struct cxl_root *cxl_root, void *data)
 		return -ENXIO;
 	}
 
+	/*
+	 * There is only support to translate from the endpoint to its
+	 * parent port, but not in the opposite direction from the
+	 * parent to the endpoint. Thus, the endpoint address range
+	 * cannot be determined and setup manually. If the address range
+	 * was translated and modified, forbid reprogramming of the
+	 * decoders and lock them.
+	 */
+	cxld->flags |= CXL_DECODER_F_LOCK;
+
 	ctx->hpa_range = hpa_range;
 	ctx->interleave_ways = ways;
 	ctx->interleave_granularity = gran;
-- 
2.47.3

