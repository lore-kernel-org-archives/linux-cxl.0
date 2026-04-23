Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0A6311C15
	for <linux-cxl@vger.kernel.org>; Thu, 23 Apr 2026 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965141; cv=fail; b=qyfSoAMrc+0f7eqzltfH4UFJnXpk3EboUATouRR+MbOWQYTwlvSWo8aREVz/JrW4NhkcAVSvXETOZOTSl789+U10rEmDvc36j6/gT3IfbqartTuBAfmPwAo1LLvPirJ1ork4UgEq1PDApYB2HxwKdQJyioxe3U191mFjzpgDTcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965141; c=relaxed/simple;
	bh=4QUclxe2u1/EdIoxPoePPGNJyRnqPrcs089WSqaDH4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G85Br8JeFo2a4eRF1iJx7lDqCtUm3zGhRd5XUGhBb6h2oMibmpWFkqO+dnf0CF7zIKSQNcg2RxpIqJyfWnwdt/3AB3OEAW7hhvi1e2Y35DIdVlbBjgu0mahZ5nbl7krMPvhypUDsOVDVhdEqxID6w7aEAdjJjM9RoEk38japTAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d08T0Wbz; arc=fail smtp.client-ip=52.101.56.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d08T0Wbz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAq8aaDdyJNHAT+t0y/Q0QLvZvlaeKIf/2OfZgxmDkv28D61WNB3RAXNogyhUv6ZbpPIaKczSg2ZROL8b7rjPPj3IzkNTDNZIQp+L801F6Nr19ve3oOn2Ffoyp3aAzpJYlM86VFbjAPu+GdZKxi4YpECrwX2A0jXeBWs7yWWw+dy79678V2ezbjdmOA9oKN1D9w5iU3rYFCPduEWJ2LZs1LB2KQJD2uq3LyrtP0iNjaf2E/oEsVyboUFuACG81OqOdSF0WhKyiFdE+OVXlhcuC5Ipkn6nSRHDW/cIuKAjXj3azHumQfV6f492mTnDEaUFV1E7uqHSYfShdox4b7VxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1lvlWsGdSnjWGwhxrmF53wGzFJP6r2jyf38dRBWWLM=;
 b=h74mwcx7rGmdOTQqwo1PLViV8I2S0XOgY02xpSSMfJB3XnuoThkhmvMoMulagisNfI6vlqgtPV0RuUbxjIK7omtIMI5gJ1NYnCueTpcZj/mtqgShBHnVkl0VyNzzSXpZMrCn2s1ktpkxwl34ndlQxldZldF7norNU0Ss/kMOD9KIE1XgyWtEwYkQAcN/jnlS6tqMVHtACPqCmyqdB0aXe0OSjzWRtp1uKXHiGfmy95Uuf9HGHpp66OEjfdzd6jTOurMwTgyjlxmohvoWw+vtx64oZQi8jvY1KffBNrAIAHoIkVZF5Xm+BiurkXyYZ3Hhfz77qKM/PSk2MeNp9R6bwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1lvlWsGdSnjWGwhxrmF53wGzFJP6r2jyf38dRBWWLM=;
 b=d08T0WbzgBRN/S3VWWiqPCNjWdMvVTZX8V4jOAJ3yGjNyW4FsJS/OxDW02yFa5+kMaa7AJjLSBsxFQS1ci30h0vWwqeQmoRJBWlqJFGp2E13NrQ2W/y3ZuuyRliv22v9ELlcGlm6/vTQKRxYerdzqa0pBLbrIUpsbTLjPSudz9A=
Received: from BL0PR02CA0142.namprd02.prod.outlook.com (2603:10b6:208:35::47)
 by SN7PR12MB7153.namprd12.prod.outlook.com (2603:10b6:806:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 17:25:34 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:35:cafe::35) by BL0PR02CA0142.outlook.office365.com
 (2603:10b6:208:35::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Thu,
 23 Apr 2026 17:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 17:25:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Apr
 2026 12:25:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Apr
 2026 12:25:33 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 23 Apr 2026 12:25:31 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v26 5/8] sfc: create type2 cxl memdev
Date: Thu, 23 Apr 2026 19:05:25 +0100
Message-ID: <20260423180528.17166-6-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|SN7PR12MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be23888-ef88-4320-82b8-08dea15d5363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RmFYiKc8hGskMcLi/LlM49Kg3F9h2xDYEmzQ6SYsOYPV+d0P0HqtSrtiEvv4RbCeTU33evf6GLo8kKyYvNKFCqwPmd5R6civj45g9lIn39FPRovjOXmrRck6Durs9LaQ1XjujMF60LRzr7QkIOOKyNKDdyXJUbysk7sMp+e9ABq7TcfWZvABagw7/4bFMywGhMboGmZlryXDJxsx9GJ3uUY0GvaJFnmsox5HkyugTCIDaFQ+KXl4ezCdMuDp/quwwYAilGIQ6PzW3Xlfak7m2B3PSFKuTWk/5aBJOTCr5pNjeqSK2FAU5ogy9Fef01Z1k//2Rqs9SCHYbhAB0qlhq1mixGY1A8w2bHxotUzPiFBT7IzQjXfjh4Ac1+HmpxwyjImu+TR/gjRHfq+98Y1Ud8WwbOWOtcdBuOme8IGcifU96JrcJJgHGCGtjv04nrvZ+IWAGVmqMFv5iPiiL+E8YqlVNxNk9CayA9BksWw2XoB3okoJCMjtFCu9EwNGswrhnYzX+h//6YODroECi7BAq01ZBNRMkDjfcXZFDPOYlecDdyJ5SEiPolRoK5iYFVsyxJshmUdOm2sjkYcMn1iolGL9iYxYSX7N0MpQ9bv+PSw4GuQ/zofQcOEqOLtxh22+XO1kWLIePm2alXTgMQBkx7sXHhtBNgikQ4J39HwNlEiVj0FKk5EUyqd0//Gd1r5hGkH/SpT3Ub8E7g7IN+v8521Il5yx2p0euKZz8u6a1wqJs65xVJoc2bAclIG9qi9ErzgHMYeNHENv5dn7iM7JSg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GSxFH/ikhvVxdmdPqg4Qd7fYApCooRAEaM328m6pHSKL6Gqsima6G6vCgZGBQZJH6hZBkQ10HiojgqBdWWeluSkPXS7bUgEKCr85DH0aCGotgTktbGINkgHjGaL/R6iuMRjgDD122j2+MCQLJNv70jj8Os5/+ZwRey10xCLapw4sWjD2yjoeAqKLtDhc6yckAaydpvNWtLZjivbai4If5k7tLmgaPohZpQWuVX785n6FUm8VPCFM7CG7uZ8kIBrHvK7+vzSk6IdAZKze3sfBDZiHjtHEMrLXWbTqUdQhczV5e54O/e8CzOaJAwgO2H5ODhPrS2LiwKwzNc2/HzomaKZIzdwUF0XqE31DEOjUbFCm8hZuasqMiUnrbB8Sl9FGhZrCnPYWSZMEwHw5ejfXNJ892OLPPDazzdgOhO0PdS2UR5dJU++QnQnVmldx76Z4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 17:25:33.5801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be23888-ef88-4320-82b8-08dea15d5363
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7153

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 4d55c08cf2a1..7d8a6c2133c8 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -75,6 +75,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return -ENODEV;
 	}
 
+	cxl->cxlmd = devm_cxl_add_memdev(&cxl->cxlds, NULL);
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed\n");
+		return PTR_ERR(cxl->cxlmd);
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1

