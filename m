Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212172DFA25
	for <linux-cxl@vger.kernel.org>; Thu, 23 Apr 2026 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965146; cv=fail; b=cgzo+nzlwdsClJ0d01s0hmMk0O8BLZ2QM2IovDf5BfyxntH60qu5T8kA9ATBJ+fPWsTPUmtyxdqBSLZUh9NWYCTb8vwb06ZlmGwjtTlUTbqtI7nCWC15HJ7temibo3RZAobUl43c7ET3j+VB9vQz/+zDfMUPDSBgEXCZetDKTV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965146; c=relaxed/simple;
	bh=fnLp21K2kX1NL0kkXOMFu23ck/j1+jMXYPaGxZZZAFQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSZKzrDKNnTrl3c1HE77xdAouRa7DxW9+qo6+tBpF1oQe2YZDqba22pGtK1Y7f0IC/ozxgGHP2SVxurbCq9zE3//8m1C3hn4pz8W8YI0qtvCUFYp3kL8Vvz9E9MZjh7yYDwR85L2jEQef9WIw7K43yFVB0kpau2cgzMKMTQG+kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zk8jIzup; arc=fail smtp.client-ip=52.101.48.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zk8jIzup"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCECvww+e+UjY/KB0fp+gJZF4Is6dpJ3iUH3SRDqtEGMWGnrpr9SIw0m/w4Rj4DSXML5VlICpLNCI4ZNKQijyqkIoHRZDmxnjZnYZ8WPXQp0tuk+7wf+yJePmwKzjGHz6RHmG9naWdHL66FQ7m2IY8OKu7XDjuWYluXvTypBbAmuHwNcRNRsC7uPXgq827aPsfFOMU1uJ+ZeOhK7NCgTTaqRj9GoCZ6GUFOgqnvY5+7puYYU0qFWTjm8TRNZZyM2kKRualnnVs+NokB/D1cZ6dA4evJsCv1N6sfsZ+hp5Jg/6aYOIgz1A3Aua7Jf4/KP/gvuQmjAI8UmwEfVnZRjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mZ8OFZW2DAeYl1EakHaI3bXEkWXAO8vewb4ILCs4NI=;
 b=tN87RTHzpI+84rlg+OQHWKvvFaomSu1sVRf1aRSdRLszyg/B8fWrE/a058n9InFFSqSAqD8C9EdD+pyV0XiM2il3LDxnwp4flOyJCKoBw7KSzd50QcNbWU7+5EPTHqXg6Ugo3jqN5IJrilLDKdjyzPQ+RblzxnX48WhU7heBUeHy64eLw3nDMzDDdObM44tuWtZvMlB3Lm/ngPtd/IydZ5MT3kyJAILCY5RR5QIIwtJ13zG770/KrVEQVqhpkYBYP60deecfbrOElE9vgzxC5irEj9wtwtbCQ4hNlvTvQ6wEcnSjQlc7l4vOw6NDHztV+ddMUkRdai/0uOU9dbsZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mZ8OFZW2DAeYl1EakHaI3bXEkWXAO8vewb4ILCs4NI=;
 b=zk8jIzupECU3WMrvIwdskts1adz674WByb9ND/8+P9GgJDTE6ZSyYYrTFsqkEkBupgefUL+MuSBGMVXSdjJDzUuzUQ3lC/lQynioT+cfFj8WkGes4YYYF/bTZbRjPdkoHjH3scam+z4wsMznjaAHC6ct4WDi+vq2EgXIA4dKwJ0=
Received: from MN2PR14CA0019.namprd14.prod.outlook.com (2603:10b6:208:23e::24)
 by DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Thu, 23 Apr
 2026 17:25:37 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::35) by MN2PR14CA0019.outlook.office365.com
 (2603:10b6:208:23e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Thu,
 23 Apr 2026 17:25:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 17:25:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 23 Apr
 2026 12:25:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Apr
 2026 12:25:36 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 23 Apr 2026 12:25:34 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Davidlohr Bueso <daves@stgolabs.net>, "Ben
 Cheatham" <benjamin.cheatham@amd.com>
Subject: [PATCH v26 7/8] cxl: Avoid dax creation for accelerators
Date: Thu, 23 Apr 2026 19:05:27 +0100
Message-ID: <20260423180528.17166-8-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|DS0PR12MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: 23727903-f94f-4901-4bb6-08dea15d5567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JkLaT+zsJTyjrDjSTYxiFUAh+hDeNMleUggl6ZCuKhDvAFY8HdvqMHLOPxtx/Y0plppH5NJZ/CA9/vJ+Dt41VjjovAND/R0xmoiZTBJdC4XzOVCyQD0IHcvOy7R9JKBf7Srky29ok3HuszEJuL9ScBaeVrSypVICdDOtAcYd4s14BqFQFfkfCfiVpqjO/3t0ksDTwnW40rEeJKdWM89sxtRHGwek0xanGqGtNbgO9kJrMfmMoWpUg1TmZcpbpY/cTLTQwGzsbvbBhUAkXuFrs1w6dJAjjXlpSkCyXx7hSO4+DRwqdfiR+aQ3NRERQYQL2NH/Zr3gJcJj5dyVH+tnrRqJ5pjZI0S8ZjtBZMoMMcUBDt8xCabuAafLdb3jkLy+9gx9nTCwHs0cA8WbFKUpVkldbEAvJzbfVVY32w4yYCo9et1ONnM31hoP32AhLQPVWJ+t6wWmo6GmEVe1K9oV7meIRZE0Y1FJ2+nls0esDCkOZsvFnJ/xoR1SBoZTUTHBs4oguvnR50b0IpW+iOkvd9vd8Lu6hRMo04chPq9dKk1/4Kx3VL/kT9oJiA9J/KeivA3J2WrJkVjRLTsNgPoR1sjbASdUN6mLMeI4wSQYY9mjY2lAncVPaoKPCRgc/gblCip4LDCKK9LhH2c1QOJGOLsQalf45UE6Gh2hfe678+HZoGO9haLNakyQVNrOYKvr4RJ1u4NpB6iuPOFD1OkrYutqGI5XZpgoEGZG4e6JJfsKd5OgA/zi4sOV5vO1uZgMMnkBlNgruOi9dQQXKfO+ag==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mMg37OmT/i5rDAjG8pdyOniJoLCvPOSZl2lWqAeb5tfkubgtUIX/v7EAQPs96AEnawigQZUr9bYN+LUZMY1rZt8lFSk2hc/BAvy8oIiTZb+A2Urdj1p2YhlTS9xliCV3sS44zxTSkIdTt5lfeC0ckLQG3APgVfwIoQk2uAQNK4TxA5shUHaMrbdWVLMZ/1739pFOzdhjQNeRnJjI/b1uXcxZ4OnVL/PYEb18zxX5OqBOTXYZIBNNQeW14X8lrb2ai9K+CXgdqVtEU3QwhlL3btT4ngM5IQYt/OHZmnDJYu4LmFKUJtLJpZSjz9TJhw7ko2LSOS5uWyLil1hIjGK8IHJ9zWbLOWuDEhEJyAFKf1KvLkKrM3C5nc2gO0rvjihT7HzBGp5bE0T635MgZJbcOjq2qclifWjx5nXXAKxEnlfsj+oagCwItSY9OvXdDh27
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 17:25:36.9572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23727903-f94f-4901-4bb6-08dea15d5567
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses like DAX.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 68f5a1fd1b1c..3af2aed6c6f1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -4165,6 +4165,13 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	/*
+	 * HDM-D[B] (device-memory) regions have accelerator specific usage.
+	 * Skip device-dax registration.
+	 */
+	if (cxlr->type == CXL_DECODER_DEVMEM)
+		return 0;
+
 	/*
 	 * From this point on any path that changes the region's state away from
 	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
-- 
2.34.1

