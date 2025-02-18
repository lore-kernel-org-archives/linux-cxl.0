Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C366269882;
	Tue, 18 Feb 2025 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885112; cv=fail; b=Y1QpWD/eKROnJ5TLutXz2oayoFPKvVS46FIXVlNYh9XD2rftg0ByGuZIroTBxOXTiomvvhYEkAry5eSYNmp5sjmIThJHgtFVGZM5kID4H6qBuYr1eTsqKFjhocCiY/8UeLU9Yol12BjCwkDLTa6MOxM7bVkxDT2qZRjTcEOcoa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885112; c=relaxed/simple;
	bh=C7AmAMdgZWUKlUpcfg+3Dn9g4OxWNLfiV405YarsSGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbuJYqdKg8D+EgmXVAkBwr0l5EW4f3o9phAxhiTYPoXFniQUh6v1zYX8bWW1ZZm4rVTZinjqfaAoXjz/6iWm8Ln6+hfnmFdJXRj04Ai+NWZ3rB7fVCmAhgqump+O65Z0wXsm3c+w9M4txcrR2C7tjxcEvtm0Po3TLde3LIWJ2D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0pP07dej; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0pP07dej"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wx0Lzs1SUHAVXPzLcI436lWfvxklf2IMM+Kt4rwi3QcWKOR9EKUg9i/yC2gM3PcjucaZhjSVW9K8+wOpFkHwJgtszECzIJ4Tk0SzbEy8N8opr+8K7Ljs3dQNafZ//cIZg0Yu11W6Ku+pYOuikiSMJzMYkw1HoNBM+ZXPgxeylrctFdvI2udP7xrBnpxDj/3bQtMPzf8DWu44ZvbmRgUvPUrJMmLbFqgiOM+bBs2aIeiyl5DrHh6AJfeZAEr9wVHty+IDUQPjH16nKWxR4mir2XgQNW3/+mKL0nHNkqItwL7SRPWCSbL3Tghh543sjQCo0WUBxhs3SFRhgwCMd3nNsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1xk0pVkBcrSi3PbMOp2S9KPXLQxxHhyy0apuEAP5L0=;
 b=NuMGC1bdz4z+7XvoIUi5ClXRRapR1l2dPbLkosmuA2UTazYT/Lc2as1Kj7zWuEDZbzFLv60m5HvOrSFML9AVhQHw8Zxo3QSyDwV8pukzAEF5BhMjqX5qys4BS1El/g3uWVCgm7Nc6bmksMP6Bt1wMPt/xmz7pOEa9CR3wAxQe416LH4WwGPmtxWxkmX5zokZLYtM0mdvMXtjt/ZH9nVIo7HAWohpTuYkI1C9ZlzQ6api5aNKfkQICe0LEHYgHTbcHMPMzH/hUKu9eyr3gmf4ZZflI3i7PUZIe4Cb+6SRwnDUdROrHrHGrJof41rfRL0O1svhrOsHI+xuK5awLkDNrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1xk0pVkBcrSi3PbMOp2S9KPXLQxxHhyy0apuEAP5L0=;
 b=0pP07deja319HuYeG0C6Mo9WAIFmf+ajFUwRGn/y5yhBInuR7/AlHAJp/qLwDv2YZCwRarR0LMwnUp/MfNoC0WLZAaW1GtQ++l5TUmXY+MDC9Wj3n1QcfTHTM9G3n8cgutjBqGJ7crjHwmFanPLdWIT0I+p5wtooA0pCh91wcEA=
Received: from BN8PR04CA0039.namprd04.prod.outlook.com (2603:10b6:408:d4::13)
 by SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 13:25:04 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:408:d4:cafe::e8) by BN8PR04CA0039.outlook.office365.com
 (2603:10b6:408:d4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Tue,
 18 Feb 2025 13:25:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 13:25:04 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 07:25:01 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 09/15] cxl/region: Use the endpoint's SPA range to create a region
Date: Tue, 18 Feb 2025 14:23:50 +0100
Message-ID: <20250218132356.1809075-10-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218132356.1809075-1-rrichter@amd.com>
References: <20250218132356.1809075-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|SJ2PR12MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: f63f9f71-7f63-4462-be3a-08dd501fa7c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gz6qVFb5wiwJZBVRvwto2qHVuYFswcp+Iay0HTHKwosKX1AvDQpm6lPA6fiM?=
 =?us-ascii?Q?OvwUpMGEGtErazCMCL28NPeSdGhyPQvfBqstGdpJoNF1wYFqmt6Y5jyIx/xr?=
 =?us-ascii?Q?mKdDRoFzXiUHf2t+bPPlvYS4D2SZANxhivIXqvK4xZpJsQXl965+F4PEzGlt?=
 =?us-ascii?Q?6L1L87oymCUmjhrfRMrYLfWwyW7b3gvyMIZCWJjW2C0a6kBp6i3AmTYzvRAa?=
 =?us-ascii?Q?XoR/0iKhdwatoAg42sLrqqoSE3ymYPqXVjFyszrkpH0SK9RFWN0IvjxpTq6u?=
 =?us-ascii?Q?gwzRXIvDxaqy7Tm/lzeScXAokPB5zv04otskEIqdTToAt3LC7DuAm8yKB25n?=
 =?us-ascii?Q?wTKkc+HE/W0k235DcEp099pjVzRcOe9AZRCoTWu5FTP3VA4nhTqtiOPo0lMp?=
 =?us-ascii?Q?CEJoXWCYMBk5OhJDkbXaL4+rCu6lUFOh6Svd6BWyqPwLG/v9aonGRoxAlGNo?=
 =?us-ascii?Q?EyBISSRBzcPBWKnLVLV5o0K7PHBV/5R9cNKyCFKV0C40tU0/KTq1JNs4VbNX?=
 =?us-ascii?Q?sjhwnk4tirXPSbfFdYP1wRhGdVsCRSjz7PrSPBghwOxM541rjkB5aykParqH?=
 =?us-ascii?Q?eyw8rmGw7sEZxjLq+sqGwd31KWac4hlNwwMbF9PvIQxPXo0KuM/PXybDVjjY?=
 =?us-ascii?Q?mKdJr+vGJTzApW01HrQR2I/MjeGrzibfzlnYimpv+kBUT9A/hDvW+J0VdwUh?=
 =?us-ascii?Q?Qy0Lo+y9Qw1lVEn1c5uwVzVb/G3fuwPzU2aD+NpeT5WYT4XkTg95pzVfqOjx?=
 =?us-ascii?Q?06ldRCuVNEGIvXGeIb0xwj5Qi6vN1jaOiMrAMrlYr9Kn3iLqc0UCSrZej2qq?=
 =?us-ascii?Q?rXS29vWIPWmZD2MoRTbLYMcbBii655Tr0HY6WECA7hvtmYmPiiqTfyb1UYmP?=
 =?us-ascii?Q?NW6QXVxfPliCnsT836D112wg+UGIWgye4yu3B2ThMRnPdEzTrArhmizBRSg4?=
 =?us-ascii?Q?/XkbCoOe3kqfiqn8ja02O80iaSOcr7wvGfl9rCAcNvkYhJ7ucS0n+/QoBhRN?=
 =?us-ascii?Q?fEfxbevBfXHo4gz0vdarY9hsKUpUkPrKZwuvAX/rYPGRPLrADec0uw1zTyIG?=
 =?us-ascii?Q?0rrE+1R0VD5n+kJyHigPrZRQGLgrblMCM5gxzgMeVvkOo9aF3EkbHTuLJV7h?=
 =?us-ascii?Q?SGam7kiyZBtWUI+b2Jot2rYyIvr3ZRSWv9fnbtq6mJFZqJk6PZCF4YaZjYMI?=
 =?us-ascii?Q?UoUsEm1uRQV9BPdE0uPThzKFtMBYJDpzre+H7+QgHXbSvNN1nxHm0s45EN9E?=
 =?us-ascii?Q?1PTwqjUFhXkkvPdn50KvsnvakcGOWKcBrtgWQ/nrUq65hMFkVmj8UpCWU/7U?=
 =?us-ascii?Q?kVQCkfZfOhATC4dQlZNE7cVFFAlE06qrTYQn4uZ2f9BRZ2bP43fFWh0GKoK7?=
 =?us-ascii?Q?AvqVtVfiV5zDOkpM+JvTPkSZ0QcdUtJ8ROLRCcejcO0R4tbJcDUvqmHtrPkc?=
 =?us-ascii?Q?eY3ITix0jDVEqovQMQ+jt0hEFGJ4K7YxT1IKOGgiINm9KPMn03MBE+CLEVYh?=
 =?us-ascii?Q?bRNWl7FvNu6dXFY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:25:04.4800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f63f9f71-7f63-4462-be3a-08dd501fa7c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8690

To create a region, SPA ranges must be used. With address translation
the endpoint's HPA range is not the same as the SPA range. Use the
previously calculated SPA range instead.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ffe6038249ed..6e0434eee6df 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3445,14 +3445,14 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
 	return to_cxl_region(region_dev);
 }
 
-/* Establish an empty region covering the given HPA range */
+/* Establish an empty region covering the given SPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 					   struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct range *hpa = &cxled->cxld.hpa_range;
+	struct range *spa = &cxled->spa_range;
 	int rc, part = READ_ONCE(cxled->part);
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
@@ -3493,7 +3493,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		goto err;
 	}
 
-	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
+	*res = DEFINE_RES_MEM_NAMED(spa->start, range_len(spa),
 				    dev_name(&cxlr->dev));
 	rc = insert_resource(cxlrd->res, res);
 	if (rc) {
-- 
2.39.5

