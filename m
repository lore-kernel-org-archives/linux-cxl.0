Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010025.outbound.protection.outlook.com [52.101.193.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D180C40861C
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184846; cv=fail; b=ajnMZ6XI3hq4PsaspLuFgpIYIJxV6He6EtkefviM86UYEnHsn5uvoh+wXPmji9JNR2lQ3Y1h5Q/Kjg+QX1M4kAO9+aFZE871t4TNWMzHsWCR05HR6GTKXxFb/cs1V9heSjQMd3lC0PZe6tQEIMssIfDYv1fOohHtbm78Wf4qykI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184846; c=relaxed/simple;
	bh=l4au84ikzA+oF0E2FcbX4qhaQYV/fZrEj6obHqADOI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F50FFIANnykK8jip2p0EYU1VbJJQSaZ1CR7g6btWhvAB3sztKct1qX3Euv2jZgoESXyYw1nJF59Cm+hJbECL+mMY7SYMeGDGHELYq7oqf0+d8i9yD1swkKj0+fDG4q1Yj5E9zqDMZy6ViDgLNkX/GIsZ6H2LSEviSG2l8vCve9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N+NwXAd6; arc=fail smtp.client-ip=52.101.193.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N+NwXAd6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOV+IkuWe8ByELcr3/fIvZoHKl7AMbpTVWe4MHwsIUx9Q14X50eIq01CdiYBtT4piFYPwkA5ouaHKxKAzmgx20UbuUD5JTKirFofbHw4J9D865Xhz83WnQYeyPxrftCCPAozcABjI5Ga2UAyktbFiPwnjKFWKx5PusWR3fOfOE4cChedG6XsntlTWg+96ttU1rumDcljLaq8vIhVPrFFRb8QapvwGiXaBcdZy5hPSgnCk1zInJMw5+1g5eonYvWdwIx4Y0ExAd3T2fNv/7l7nP63kqf3GWH70JAcYf834uG5lTOt9kfeTFXSJuG28gNSxkHLfIRB2verND/XALvmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koD3I71qaRW5PCN5h5/W4YISmjrUu3EUjKX4Skg0hs8=;
 b=oyW9JynWqXBIKV1rHv5LGKW2tq0OJkIBamAjiHOgHBpME1JGY4gpjcI4JNNfzwmWq4RZk6l0o6uXwI4cSH7K0xQxvEO23lduEeEhubtM8cakzThPLBxRHxykHTlR5AseFsbq2egB97ldeGt0JbazA1CXGUFx2N1JOlJN479UMFLk01QXD3yFXjiw6MzIMTtnb6HWBDcuKHr/hd7F3LdVmHB9RqO1egDaoo4a8OnPs/6ceIdtSOmh7cJz9tH4tUxGy8buBB+lO967mIb679Rgs79oJ+8vI0lsl8FQHii0HG+UTEl+VDZVi2GJcY0KP2p6zD6LJNuZyGUnZVru/GzQtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koD3I71qaRW5PCN5h5/W4YISmjrUu3EUjKX4Skg0hs8=;
 b=N+NwXAd6GcJSGIbVZPujefKsUXGzphBgD/cM3TKASc923JWFD5Z/HIlfka0EYEw7wNgGt8dxSJ2R0oV2R45Mvcr/2MYvBbRumpY5oUyshp6WziuR4fhmWsoMyXXiq5CffvSae9DIpMCIHv5ZVSiG8/C2OXe0cUkvB5qIY2eIxjc=
Received: from CH2PR19CA0027.namprd19.prod.outlook.com (2603:10b6:610:4d::37)
 by DS7PR12MB8418.namprd12.prod.outlook.com (2603:10b6:8:e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 17:34:01 +0000
Received: from DS2PEPF000061C7.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::8d) by CH2PR19CA0027.outlook.office365.com
 (2603:10b6:610:4d::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 17:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C7.mail.protection.outlook.com (10.167.23.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 17:34:01 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 12:33:59 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>
CC: <linux-iommu@vger.kernel.org>, <benjamin.cheatham@amd.com>,
	<terry.bowman@amd.com>, <robert.richter@amd.com>
Subject: [PATCH 15/15] cxl/cache: Enable CXL.cache on successful probe
Date: Wed, 23 Sep 2026 12:33:42 -0500
Message-ID: <20260923173342.5584-16-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
References: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C7:EE_|DS7PR12MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9b4f12-1bed-4c54-c345-08df1998db30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qWmuLcisoG4UwYfc8OLFRUrfdOJ4JpKM8Uxv0kUSPpzABGYzWDbhH+KCi6QDNOJhPxTQIoOiRIV1xeOJKcZ9MjJM4Xp5TCFinUFMwkdR17vHRTq06cHQXTjDuNBzk1lcx1gPZeyjaUp4JRBcm2vKMwvhsG/x5vk9YVHL9TnCvUPjpGAN9dqb1dXzs8jHUZDOnXpcf6YI7M2PudMQ2uyL5ejpFlenOxP5JulKWd7vsMeh6zG9xnf7Ho8V63D46xVtgkfumZSf1mUT3xxDs+8p1ILzVakzvE1+8Jp7M4YR8tSjr3HvJgMTuG815kpPbYNf+Q92ZfGPKHMn/lDZnxrqxUJ5e9vHkP86BYhkcBKTvKRue9p+dwMnvOFZ1bgLejDFxaav8q4c0/KGrLL5g6HWSfswg/CqeO2+kckXUQlPd6TrvlsU3dL3JrNjNjRPGkvYFHbSpA9bHVcdA3Dt1lCIQUxdsDrtkTyQY3ZGAluB4rhB3u7aVOf3RnrT6unlY7W/G3oiHluerHoN80WXqxAgxwnY5sG9BnFgc2Gc4V19Lb7/gq4r5UXh6bsIxYIJpcbhv3sFmZDo9WcQykMmiNb/bBD4ERL5Ux/mbFGOvUQMcBqGw3e9JQ/M55tWBC/olQ2geEWG/kC67FwbijM4ls3j54fvM+rKHkd71BL57vSCv5/KBwMPhgr7Sw3Z3oj+sWVDFVeIzx6tv2vyxhdKeyWF+Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TuTPn7Jilng7t5VC+HrEc7P+iyna2AF8YAaWjbR7nzWjOlHqmPen6+HnVtaf1LcPVaLMzbg9x04MeSvWjBK+mw/CWXIMwiRyQNnlhRC3HR2qYHdU7UHa5o9xNVh/+Hq2H3miL5YX7i6ZdTQZ7CQ33WAlh0wdcR8f6V2fimYVol/06PJsYnXtosCUQlhQoFKXVYYlJO0jpnL8G3puxNqmK2shyx947gXV676BARBNyTFPEZ7FXRXfES4LDkBWzEmQJkTYGgaaZpU1Y5Sc2wScLJKCSDpQk5dIguuCSeMp2XWeRtqOEklM51l/MB10KEdH3/mhEO0LsFy5ses1Ik4+VRr0BEFFRiGJdAsV1EVUw9twNJijat5m6lU+gj2kSBz2TxRSxx96sQ75lxxzcEucMmJ+m84AzlkdTuMMyVJv27o9BL96C0uxuo2ypWm44/Po
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:34:01.2216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9b4f12-1bed-4c54-c345-08df1998db30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8418

Enable CXL.cache as the final action of cxl_cache::probe(). After this,
devices may allocate snoop filter capacity and set up DMA regions for
using CXL.cache.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
index f73bf96d231e..a321c4a55f82 100644
--- a/drivers/cxl/cache.c
+++ b/drivers/cxl/cache.c
@@ -261,7 +261,7 @@ static int cxl_cache_probe(struct device *dev)
 
 	cxlcd->cxlds->cstate.gid = rc;
 
- 	return 0;
+	return devm_cxl_enable_cache(&cxlcd->dev, cxlcd->cxlds);
 }
 
 static struct cxl_driver cxl_cache_driver = {
-- 
2.53.0

