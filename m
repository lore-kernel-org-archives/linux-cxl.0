Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A17442FCC7;
	Thu, 16 Jul 2026 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222038; cv=fail; b=a2JFvTmuOCYGAt3WWZTwK0dxGEloDwC4d/h/caNzXNKRB4Nk348A8ZjnHBhU+AX+MUsYVkeVGB3JxyNIYeGnnK2ZF4fUQxXDhySjzzhOV9y+ScoaBVol2LAj/ynZD+23QPFdcdl7VrZ/loLKPu40Vrw82ii67D1vBo9CaBW6kuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222038; c=relaxed/simple;
	bh=QQs8HOZxSSFOucdIG6gu5VPk6LhEWiWxM0cdw5AGv+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEYXNz49b9mmmAGurTSRdSF6pi+eTfQvzgh1fxawR4zbQeOY9QYVI4KELcMR3vuoiHdNMrQil8aP0rpJgaxjNyz+HSYesQFmMhKznDz/V9MTXCmZSD6edCPsWgIACTbxXfpGXl1q2yBDGqdi46AXgL4ymkLiqY90d9HHaLkjyQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AG7FfBla; arc=fail smtp.client-ip=40.107.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AG7FfBla"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGD/LemixSzGRlglEc17bJjTWtWuk3EbIM/3DrEHKA0Zxx/1RhpVC/BigUC1bmDPFpxrjNeUelnhGxbDvLCOzqylFSHaRgJFhcIYVBE3qz69iCWcJYelUwZwLpU0zNQrsHBQurW5+kfVpy4dENBMVwUGOGPND/G6L8FyDzDyy1s5xgsilQIyI974GmrHfMlKTzmFt2JAIzPL/+GjtaH0+YSYLVqZzyVfnM9qhaLFbJILwZHMcSqy7yS+nZZlbPS2sZigNwwciWqtaHgCFrO703AkPZghHOWfx1wOp9i7BYlNfiAdCM1uFGD6mFyksaTTAMQ89JjdpmRsgjqFz6Dmpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUWwilggm5vi8SJ7Ed+tpbFGjs3RbjKm5E9q3ceh4tk=;
 b=SJY+n8qLa3o5mG8xcTY2cQ6QXDSJOxRWO0rXPEsyJ3hHpIT/4cyamT/oAWOq2b8szx/kPyggiJ4yCp8xu7bYZGs4ycYObiNL24WdBjwM+vSvPfzNT1Q2aiKlXuqlwiFgqU+aV6StUF6/LvleYP7G7+tX1hizQtkXZZBKsaWpVgfeYquYI6EQPZ8zhOQHqCecLaW6L++fQmO4o87jeF6EhKONRnGfFyAFP2kSiIfhdRUUzGCMEf8q7Uf2DAEnKl1ziBeuTkCJqwxlzCj5j1e2NISdQ/NBUCi0qu1EjF7lqNa6pJovf0jO5EynjpCJ4sBfw40ADvXTuYic3pHPtTCK7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUWwilggm5vi8SJ7Ed+tpbFGjs3RbjKm5E9q3ceh4tk=;
 b=AG7FfBlaVtqJfnisSfrVbU12OHTy3nRxuru60UtmkMgBQ4QoJk8ytnPFPTMeE4YXcS+fbadJikCRmjJamOUFGSu3BxlKtsPKTkFWUH6/0inlo0pJY06imjxnMvBJmW7PE+HHsrP1AKQZRuh5Q5Ztzz6Pp+bw/SY42psmTKIWMmA=
Received: from DM6PR02CA0113.namprd02.prod.outlook.com (2603:10b6:5:1b4::15)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 17:13:53 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::90) by DM6PR02CA0113.outlook.office365.com
 (2603:10b6:5:1b4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 17:13:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 17:13:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 12:13:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 12:13:43 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Thu, 16 Jul 2026 12:13:43 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 1/1] acpi/hmat: preserve hmat_adist_nb notifier block
Date: Thu, 16 Jul 2026 19:11:14 +0100
Message-ID: <20260716181114.35962-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716181114.35962-1-alejandro.lucero-palau@amd.com>
References: <20260716181114.35962-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 182b206a-d42b-4290-23ae-08dee35d9c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	O2topskfSCTzbAGT+djVYP9etCdxTjLn2oEZoOsZAL+CLV/SYbX7wgHqjcyQ7YkjH/5Vr1FJQZ1GrKM2LiK88wKwhZXhfLJJhruF1Wzo80+rslWMjLfTFoMBKiye7ezX1yYK+eMNTUDODg7pDOjzJTo0f9LCA5Q9rsi9yMiRXiHyTCvHqA9nzRm19ADlR9vYkQsYMfRLmVpBBIbeppibwM3j9GiJF4Eatu3OuRy6Tos0a1FrkRpdeA2WhWQIi+F6qEZIldy9q33hIThjqxlriM+7B7PKoJfBAfSnwgYKbfTeajc4UAS3MlBit3kiB0C+LhNtBjgk45C6bvDx+shZi+ahJ14Pa+z7pZ6uMa9jYhpX+oZhNSbqMPxnyPuc8nESvDs0GxI0azsmnYKLcnFK/9/XXg08FBCIM173JiupTbI2Aqn0rsKQ+ZU3y/1APZMf9dqNcS2qxqLZR/EcSyQrxwyByKQVp1GACvk0txwkCU/7v69uf9gB8LHSlGBcpOhJ+D2x8i3M21HMjpbUzPvNmtKh6fwAmSLpVouKwA7cHGenHHKbgVmHcVxcLGMU0Nk+UOTlab594fWPcExSrHQkAMMO0UVoCGrMC0XSVzStsFHkFSu3uylNwQT8TTC5PxXRWidG1MtDETNEA5himtS8OSQNJeKAG864gTdMoFLuBAnzWlEbOr2kxK+9n5LoYEYANcPm87Qp4Nz+sUlQAo+PQg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ylGQfhdVHLlMFi8lOoUbEzkOu5t2o3GihWtfEvKxnJYv+0FPPBbB1QHa/+dnEA8jXgtImnGnEQRsXeg34cQ0A1t4d5bdWpjzR79BeJJc9eZAk9ByrqFPgehYduAQAHiKJzgWhCsWmk82v/uoZIdTQwW/aSxzo9oEf3unDxeS1Hp7MZ0KQ3RsmwAsRBrSQm7FPmyBxJn+0GLigfAnvNBDJH1/OPjT14Fc41UIKx+U47qevKVeB/EtjuIVBAnRDwyw0FO+2aSoe0Rqn7daG0I598j4bQQYL1jzuoBTncWCXBxvSckLcAPIF1TBu2QeN2QXSClsCTlL1wfuG7OQHILmVdAW56azu9tYe8VwtmkoEu9fhQnkJ027j4Oflc882gJ9vD7RkvqCfP3AiAP3hZWJnrG7q+QQKFFpd9TlB2IyOrBKFdWHwdVRimuE5vXnKGVQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 17:13:52.8048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 182b206a-d42b-4290-23ae-08dee35d9c6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200

From: Alejandro Lucero <alucerop@amd.com>

Remove __meminitdata from hmat_adist_nb declaration preserving it even
when CONFIG_MEMORY_HOTPLUG is not set. Otherwise further notifier
registrations using register_mt_adistance_algorithm() will find a
notifier chain likely corrupted.

This is the case when cxl_region_probe() calls
register_mt_adistance_algorithm() what can happen when CXL regions
are dynamically created at any time from Type3 device(s) or when a Type2
device is initialized at its driver probe.

Fixes: 3718c02dbd4c ("acpi, hmat: calculate abstract distance with HMAT")

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/acpi/numa/hmat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 9792dc394756..3006789ae31f 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -995,7 +995,7 @@ static int hmat_calculate_adistance(struct notifier_block *self,
 	return NOTIFY_STOP;
 }
 
-static struct notifier_block hmat_adist_nb __meminitdata = {
+static struct notifier_block hmat_adist_nb = {
 	.notifier_call = hmat_calculate_adistance,
 	.priority = 100,
 };
-- 
2.34.1

