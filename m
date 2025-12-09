Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA74E301709;
	Tue,  9 Dec 2025 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303724; cv=fail; b=nldkr5DBztebbAEpir+NZS8NFgoLfWMWUWPiEeMbZiSc5q8ZtiV1DjLCekwjKtKBaywe/N4NuhZDIV6I9UR7mFh/qRQ6JSoYxDEXZoboEYXYMCAPDQDyeR2Ch8mjLNLfU6iDqs7UBdZLcDM/vgGjRr8fq6tvK6mvghnes4hwZkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303724; c=relaxed/simple;
	bh=AuE7Y6Oz/TuH5cpCyQmeW0b8w8cTuLh7JqcsBkpKdLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4IBoDB+OK3RGnSxYtm2K+pDUpf4+PYez+Ige5/hX9Vu6WqQdt4UEjxL+O+nFJxoEnSjuxyG1Ucei0Wk+ufrU51C4xR8bEyN+b7pSSp28IGVDSPJ9MBCjsrGUvcCdVXGjpfwiONgdQqwNtVXwK2ShiE/iVYOfjk/ku9f9cON0lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n6yvgLDk; arc=fail smtp.client-ip=52.101.62.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n6yvgLDk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQNieuGLkCM46saKhuqqx9e+y3wVlBT/W+L0Pm5fEDNhXrtHlEGJJXvKl9ZEN45H5Fjdr8vQqigeRFiQPo1fpG4mWVxO1MewihOt+3hIwFvhQOzL+lvb8B6fOYcLpETwQ2/7IJqPbUtFAhMnHRSjPOxG+icAcQhVb5W8/Kql7P3Cw/wb7DdsvU/RVD48GQVQxRs8uvuO/9r+vmydrhvWDvNRDUHri7QYyicGyfOeAo556MJbgdi2CJxGf6xQRQk906ipKfmBZhQWwRzNzkPLEW6nWYItyq5+DkpbNsGmGzo+HVnfe0/qfhey63WQBlMVthtRrZmwn/J0nhHrtIzJtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+bbps8ALF3cZ4yHSwCA0qOGG/YpV5CbivabCsxOi7Q=;
 b=R15NPOpYtqav0JPDba2w7lgMiCSSZ1hhl23j5ez7CwJgKGUO4u5s+PvOf/5ZuhU988KkuBQXhtWtnWvsMHZh4B/H5D9qVCyGlSbNhxGTg+iWeC3l2Vj0y/2HI7VL/81fkmGLohgkVBP2nSaNfb2PV9q5gQh3leRpEhAlpvO2XwKiQDsDYgWRf5iOvK1rwaRFi3z69cI+rCk/MGY250aMePL3sRDhBEAYVfcX3rHB93P/ptNJQ8IsuSclxOBSy/6p7JtfjR/4NJrbMH5tHYEm+bqiup6P3mYwR7BEH241EFpiWFMTowlLp13x7lHvZekYOVwy8jMVVgbqc5PGhEkD7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+bbps8ALF3cZ4yHSwCA0qOGG/YpV5CbivabCsxOi7Q=;
 b=n6yvgLDk5ozo/xkMlSItmjWipR1T2S3RINBdVbDboLF3nRNjxxSY5W7SQiXcypiki8KkjbdSBhc1vsFYJk699hcxATcFItcvIWOy5BKOg/oz5SJ+HmKwweZm2tbUKNaRWTtxJZYILf91tJSkveGt9lauZ717JklSjL4iJReV604=
Received: from SJ0PR13CA0069.namprd13.prod.outlook.com (2603:10b6:a03:2c4::14)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 18:08:39 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::d4) by SJ0PR13CA0069.outlook.office365.com
 (2603:10b6:a03:2c4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.7 via Frontend Transport; Tue, 9
 Dec 2025 18:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 18:08:38 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 12:08:35 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v8 11/13] cxl/atl: Lock decoders that need address translation
Date: Tue, 9 Dec 2025 19:06:47 +0100
Message-ID: <20251209180659.208842-12-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: 3910681e-65b6-4fc8-bc4c-08de374dfa60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?piNTxzKESdQwLBagPHxTX30joGls6dgGxsyeaT2h12zqoVLYnMJMHyo6rRBZ?=
 =?us-ascii?Q?SMNqOYJDiKJz9q6KR7rkZtxQK/JLnKdkeZ7UsWyzrznrywVz+BJjbptLPJcl?=
 =?us-ascii?Q?n2/coWMPke8YGfrodghHCr+rYYqPSRZLlN8D83DFpoVsU+mDv54dSIOP/0PX?=
 =?us-ascii?Q?DOez+7TyqiWyhsIMJsCTfMFvXDlyS9xo7AGzHGDvQeu3GmnplLOMJzCaQmU6?=
 =?us-ascii?Q?X2TfuIlLYEpuUKS2TG9gZJVpKIwjzZzbdkmFzEDJODmuAangcdffAF3RaL6Y?=
 =?us-ascii?Q?FXwnEWNSozPSbmTROVtncMMu6gRCRzRqvvOdJJCunG18n1GmpUl98p86wWV0?=
 =?us-ascii?Q?WNaXNhZEZ7h7FNCJzfV2YuRewjQz0dQ9AjVeEZXZrVdivxaBjMhCzk6g99Lz?=
 =?us-ascii?Q?Xrbu3h2OBEEdialJaPy7ZA8b82erhu6NNhKyj4Mwc3WwJiE1fQ/nrk3hctBD?=
 =?us-ascii?Q?/9P8AFC8gfh/ExkjcSyTwbSJr5T1aUicxAf+bTiYELbUbzja/SnejU5mpkEq?=
 =?us-ascii?Q?IAt5XipxNj2h0F6FYQAK6EPyAH8/AxYZRIXTc3ebu5dxtH0phFyMRT6z0XqQ?=
 =?us-ascii?Q?n7xcy7XKgPvV44mcygfZ/dWATGiQH0Afexep3RppkR7RoOIJJ2MVy5ynJrFt?=
 =?us-ascii?Q?5U2Xr9EvNTtZn44Ql/Ki0IJ7puuXp41y4bSNaiJK/g5VA9hEF6OMT3+4Ttjq?=
 =?us-ascii?Q?S2zdqbKMayAB9juuZm8+PX7Wxu9ymkDUIDf0EqlOAABb9Mn/6+ekUHJS6CKH?=
 =?us-ascii?Q?Lrx+O3Km8NGNWPgGi4bslNqOcoj+MsHQo9CyNfjcNeji3xexsrgPnYffoevG?=
 =?us-ascii?Q?Zrvx5mf11Y3AZ+prMnqmk9iBiStp1NBXBRjzec1uNCue6f5nLyjzIHsa566Z?=
 =?us-ascii?Q?ScDO4roGxOSP5JlmNfGKubsIKKMmeWBjuxqdaQSN5VBNliPqm/r56k/18XK/?=
 =?us-ascii?Q?DZcXhSvn4/7axR8dDBc4UK34UJkmjkTug94H7n57sbexK8ZfOz697YxstgCx?=
 =?us-ascii?Q?dFURsesCNrFjHdUGwRdnzNBJKL7LHpaUHgjfl+sQPcgXg2nyyPy2dfZVlb/w?=
 =?us-ascii?Q?FBCwqMnIQnwj8IG5YLzYKjW1KriDi4vOCtF6ztB7HCB4BLf7IkP0ApUywVKY?=
 =?us-ascii?Q?jHowfrCfTNivL6uiGIyPoCkGemHCMrG3rz4Iern4nShCJ2cjxYbkFGijlmRd?=
 =?us-ascii?Q?JY3oApjFQSYgQQgIFqapqAXDkrLQHng3+9IzZixp3IMAbKs0tqF9QYuNq9Fl?=
 =?us-ascii?Q?Orop8C5ycrvZpDWjyAlM60VFdutc/RTlpyfDJiswNeKHVRvKnJnqix0hN9WV?=
 =?us-ascii?Q?VlbvPQfZcY0qo1goKTOBBhDg1DHNCYgTrzpXZwqcGFUDZMfqpka+p6ntmYWg?=
 =?us-ascii?Q?TITEkCzGjzgtwnDL4OoCWBU6ctJqUZwqfBt7ZcVIxVNZUsWT4aIW4ZDC3KYQ?=
 =?us-ascii?Q?wbitNpJK0s+cHaMRed5PW7XjzKm056U1X9CDz8a9eIjxIcjNxqCBBvH8YpCi?=
 =?us-ascii?Q?Z1lLnHXBIpcJ5hsai1s7bAbt1Pn2iV4krirIop1sYNLrZxSkfXLsHJAmza9N?=
 =?us-ascii?Q?gUnv9dyzEAE/DOxMrGU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 18:08:38.4497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3910681e-65b6-4fc8-bc4c-08de374dfa60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509

The current kernel implementation does not support endpoint setup with
Normalized Addressing. It only translates an endpoint's DPA to the SPA
range of the host bridge. Therefore, the endpoint address range cannot
be determined, making a non-auto setup impossible. If a decoder
requires address translation, reprogramming should be disabled and the
decoder locked.

The BIOS, however, provides all the necessary address translation
data, which the kernel can use to reconfigure endpoint decoders with
normalized addresses. Locking the decoders in the BIOS would prevent a
capable kernel (or other operating systems) from shutting down
auto-generated regions and managing resources dynamically.

Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/atl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
index 8293a55127cb..4bd2289b8bbb 100644
--- a/drivers/cxl/core/atl.c
+++ b/drivers/cxl/core/atl.c
@@ -161,6 +161,24 @@ static int cxl_prm_setup_root(struct cxl_root *cxl_root, void *data)
 		return -ENXIO;
 	}
 
+	/*
+	 * The current kernel implementation does not support endpoint
+	 * setup with Normalized Addressing. It only translates an
+	 * endpoint's DPA to the SPA range of the host bridge.
+	 * Therefore, the endpoint address range cannot be determined,
+	 * making a non-auto setup impossible. If a decoder requires
+	 * address translation, reprogramming should be disabled and
+	 * the decoder locked.
+	 *
+	 * The BIOS, however, provides all the necessary address
+	 * translation data, which the kernel can use to reconfigure
+	 * endpoint decoders with normalized addresses. Locking the
+	 * decoders in the BIOS would prevent a capable kernel (or
+	 * other operating systems) from shutting down auto-generated
+	 * regions and managing resources dynamically.
+	 */
+	cxld->flags |= CXL_DECODER_F_LOCK;
+
 	ctx->hpa_range = hpa_range;
 	ctx->interleave_ways = ways;
 	ctx->interleave_granularity = gran;
-- 
2.47.3

