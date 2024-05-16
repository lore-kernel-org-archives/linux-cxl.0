Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4A16D1AF
	for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847157; cv=fail; b=igwkWeZeBXl1Gf0mZEeMs0ttiS8MbRY6S78oQhsuIppSe3zyiOn9z/JXS5N9Dr2kwsyWOEP6t/C/chr5/SDO1lG5EuSepcBi/B5yg7tYZdKXm8JY7twLNtYG6E+OxPaOqaGaJ4KFds8aG0/M24ss9/FLuIKGl+dIpaoSQ60kHXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847157; c=relaxed/simple;
	bh=SbFhcvNUuJ0DPXQqf/ZWa3JIoYTMp+MZ9a56yfwEtXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViRLs/f1h3gyLg0QhpiOK0SufOeIxXJf7oz1nubXg+P0EsJA9OjX6+N2H/kMhDoY8lneZNThQM+vOR3tV2vRHKxCO0vh/gkU/JLR5jS889Bf7m6c0e9lj6yJstUqReYNZkDg/IcvPiBVynDPqnT+288L4KFLSxqvAto2K/a1ekk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ne54+u/u; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ne54+u/u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9pLLawsbWqYgOTkbnBNvFCERb4MtjOKsprpir16tFnyI5WvlTEOl6iX6YRTNlWF56fUD924i6Ug2w4YcVy5TdzWUNeXaJgEvRIYy4lwdsyEroTfwQ45O3OYo+a4zvMY5sRBT5GWCdBV0kkGjeWQG7O8PYPLJZyFmSxlNXC8LUrBcPhgvovZlyOXg41s+w9gM2CiykKz83ovEasWWJF9AkN5FmppIctFXEoW7HNCUGf3+JAt1+0Q5R1d/i4l7yHIGNctU5/+98rU+zC3FlW7drU4qK/w4f2dzT6A5NYaDbQ/+7oPYG4nGh9K+kwE7ZWUeu3OgEURc423W0tvcLh7iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFrAspxP+4El5sWxFHEQ9Sov+BayPt8OsR1QraQ/OsA=;
 b=AAwmAl8c64sx52UcYU1YRwvH/ZSeIqW1o6vnQChnIQhXBQhxKBFGLMkTPWBpr5TKzj1iZwpvZ9sZESiD/RiW3IeCnoSrY7EquqDRoMWnpPeAW/HN8tzxUHcCAalczAGhm8RkTWDJ2cxAlL2HmuGxvgTFXwLlX6ZKyxkP0kRxMY8UwSYKp0Cs8qsHYcS/Uj3+bAIXv/nrcVQpuRhR1OU4TFZP6Izh4hRiwY4sK78aKmFW/tOHnBpdJjHSyrCo639WZw23g+iyrKUE/AEx9oitGmGoA/B3Cgf7h9UKghFImUv/6Ngf2URvufnx7Pcz2drl6qmC9xRtl+3uiwi4O2izrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFrAspxP+4El5sWxFHEQ9Sov+BayPt8OsR1QraQ/OsA=;
 b=ne54+u/uJneRRUPUdFEdxflod4h0WzEFKQr0AFcF981/MtopQe9/bqbKfOHSaZNvssu45rQABcnhYQ419ipo9GDP5NylgiqS+YwfDYTgF0sU9ak0/He6JKc0IM7Dy/mF2aWwxYHzA1J8w6BRymZp6UAXldVdJzhu+IFYkTCTEeo=
Received: from BN0PR03CA0046.namprd03.prod.outlook.com (2603:10b6:408:e7::21)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 08:12:30 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::7e) by BN0PR03CA0046.outlook.office365.com
 (2603:10b6:408:e7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25 via Frontend
 Transport; Thu, 16 May 2024 08:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 08:12:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 03:12:28 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 03:12:28 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC PATCH 12/13] cxl: preclude device memory to be used for dax
Date: Thu, 16 May 2024 09:12:01 +0100
Message-ID: <20240516081202.27023-13-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240516081202.27023-1-alucerop@amd.com>
References: <20240516081202.27023-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 77d4dac0-a24e-4b9c-5d18-08dc757fee53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CuoNLg1ySzUA/KVoo3RNMg7TRYKna7Otwb6EIBJ+YElfhEkNf1EBMtOA0T+i?=
 =?us-ascii?Q?UyMWyRhOZR/p7o9RNG/jDVj8Vw+/oNwCNyJnPRInYZworUM4gfNi0wMmFz0G?=
 =?us-ascii?Q?kPHREuKk8AykjLfC4wky6s95Tcm4ovcZnuxkiAIAak0mbrs5dCtliewEl9wy?=
 =?us-ascii?Q?9GX4a3imngRlnIk/2UeGh9SPWIJ3ynAhqRwgxu0viyb03yZOl8qtaQLm/6zG?=
 =?us-ascii?Q?YaUrrVyk9vfkD8ZssSUyOFUxRFKf0wpzXueHrRoIfIO3LT3mMPVI9QP8Hd5B?=
 =?us-ascii?Q?XW8h20rMkfCs5X3ZXmcUk6afQgHUd3InNNCyhNAABKBlXCYOlCVeEdYz7Fag?=
 =?us-ascii?Q?IFcmKxgEuwpoHjEWmhVljbY3c6WdSip/XZUfLs0oRzvDIx5Adlh32Lic94ND?=
 =?us-ascii?Q?T5q9ZMe03lsV8EehYmaypNbY73dgafY9aTt5q3Sr9sq9bPXmyr9AQanhoQNo?=
 =?us-ascii?Q?5CfhWHccH4iGkbG77LH1i5crCMkwCe1q2oNPDZvVqBkdNzStG7J+wVDdt7zK?=
 =?us-ascii?Q?LaOUnWQEFkdj4QrgBQhLK2d4zGuJXLKQr9TkaMtHQvYdKzImUamjWYBfsBnU?=
 =?us-ascii?Q?PBJZot9d4X1VsXy6hzoqE3DJtS2nJv6Wlm14TUKI8VdqBOmvO/MjndCijqzI?=
 =?us-ascii?Q?wnPzfIO1QAkTgzBehJTe4ea4h9cffWnQdtGLeWKY2S3G+pkMwFAcLmwA+Ac1?=
 =?us-ascii?Q?I4N+kCXzNMRIIF4DbuAOBNxRmKauWYvNUU8tTJhZW8Gjrii2aRY52FVvKfK/?=
 =?us-ascii?Q?UJgUc7sjJMKinf4mAs13zbuvpoelG0eQhbSv8DUW1fTFiDCY1174aww7x85n?=
 =?us-ascii?Q?ux78kig/2NzCmB8XZZ0Zx3L14PrWYP79Uu0g16P6bAfRZIGrzJQJiH2t8SYd?=
 =?us-ascii?Q?ALmzcd0ZlaFqxIRxaHXym9MPuKxvKPxGVVwiDZSrTWabQLTzJ3mPa3nIiIkx?=
 =?us-ascii?Q?l+EH0ky6zvFgmo53yRWD80lhNd5CYBMs6BDR9Pu0VUAZdqe8p1cqxOeq/SZs?=
 =?us-ascii?Q?cdbtsEcDl7UEISdi6gRgRS1zorq/aviwymslyfxmrEriuEGEHCRvtIT23q0H?=
 =?us-ascii?Q?fbFgFNNEQF+prqgh2FE4biwTbuNc64Cj+1KDfT7HrKcQvsrxhLCTbCfn8mmA?=
 =?us-ascii?Q?Q7FeTKF331uRUiB1I98/isnn0XTU8fZPd1yhjwfyofyL63Q29OrhX5dvnny0?=
 =?us-ascii?Q?GhPh+ig9B53MV8YbdmypNNMTfeVmjocwzLtrDoyl5Wb8uZqkgadk3XsvXRHS?=
 =?us-ascii?Q?RKGK1rgrRj9MTvKTdTS3KjvNIWlo6STauGz0ugIBSOmwV1nkhY3tCXhQR+EA?=
 =?us-ascii?Q?lDAbL8oSi6xrdpEHZlOHdAIt8r+aWTLIuSlJGoR8T/fv74ywwgH9BgGyEsaq?=
 =?us-ascii?Q?Au3ePLyyN4wxGoa1GfTNmLYZvPYe?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:12:29.9036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d4dac0-a24e-4b9c-5d18-08dc757fee53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 014684ff4343..0716c2b8d456 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3485,6 +3485,9 @@ static int cxl_region_probe(struct device *dev)
 	case CXL_DECODER_PMEM:
 		return devm_cxl_add_pmem_region(cxlr);
 	case CXL_DECODER_RAM:
+		if (cxlr->type != CXL_DECODER_HOSTONLYMEM)
+			return 0;
+
 		/*
 		 * The region can not be manged by CXL if any portion of
 		 * it is already online as 'System RAM'
-- 
2.17.1

