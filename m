Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4467E58D
	for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847150; cv=fail; b=A/vhUyJu9OHwpNqfF/DwEzblshayeouWYsmqg6L5ZW5oh5D34w2ZdwVCBJJyEsZAd09UMdTJFSsj+yDfBlwM9iStf2ELkJrbSy2MNagMTBqH5SGckaYjdtor1hriX3XhTsR/qAuB6BTli67hisPHlkrQE+KjyzhltZmtz0GmgEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847150; c=relaxed/simple;
	bh=kN9IZQ7T7E4n63OS7vREzH3d82jNHckgtnRm4o1yZKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDEEmswlfhKYS9VRna56VCPOogMph5yn0yl/yS1UkTQRhD4ttfQLAH11onmkqoFu/4bbYSCCvmtE4j+Qw88h1uED7kwhpee8nFndAmslUlLJJn2uW31oc0l8dhqwnOVSmg1P0lxJLL/9CruSoQfAxOa24CtHqxrYnyiMg7MvecY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lVKM3FhH; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lVKM3FhH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCP/9Wvxj93WwBszt9ceNQbv1gYrOZYmpr4tqM5c2Miw7E0m5gdgfrYqqh8FkC3r9v7x3RuXcczRdNlmIgpQ4rKsq7gEo5h2UQWZ/5nBvSX11L4/YnZ5Lv3AKe3uEgHQ+7xZjkalPiW+w7ByAon+uwZHZHppg+SSLi7EG5ZL/zRIBgaaPwNqlIa9G1TPp0hzPcCRmV6J9dDjsaO6Zxmp0DpYk2brYp/Sp/RycoKuw8wNwOD4QkZAec+PWxhYAc5aailrLMETFhjAnwfu9kZY4SSPNVFbCcvl86BwY8VLkePrr6k141Leia0u+Bpcq0qaJ8UTG21sYmawj5ZX6sH31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVn1IW9P2sa5eVgPMqQ6DaYw311Qqeh5957jWgj3pKM=;
 b=C84giUHOeYqRXfDg7znp/bPCUHwzAl2LuY1V2umA09g8xgFl9N1uHkuGG6S+RMPQuQzb2+y8scyYYs9PS86+DIxvOT4Fivh5ioQtZK1d3GMdI/9Xia4Z8IUCi74Q/GtI2q/U17jzILiVlP+y94mKE+bTpe6Vk3f2tGlN3/Nxo5dj0MtDc7v00hQ/24my3FjJ2qzHNmSAE/mSNlvAh4Cq5UAavmkVoqk2S2udvOQXKrUAKIVB984ZdrAJWWwZ+/tCGom6DOSEIG4XhU5aSVaYU4X9WPO9SS089J6wqdaXgK6gTqP9AQljldPVRynUk92kmyF3w38I69Kcps5qylHfJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVn1IW9P2sa5eVgPMqQ6DaYw311Qqeh5957jWgj3pKM=;
 b=lVKM3FhHsiF8nD5riNsOkeelr8ryAUV9Txb94FUqTYn/ddryS6L0X057eeECk7jGcgd2alKnI/7o+9hT6xZvbznZli4vIi7VGk+xtGrrtQ1g0qImRdF4bTkTU+lJvVP0cZb3K1DYdLw5EV+fjfDI85jsW6Lvimvd7fC7NNofPjM=
Received: from BN0PR03CA0044.namprd03.prod.outlook.com (2603:10b6:408:e7::19)
 by MW4PR12MB7287.namprd12.prod.outlook.com (2603:10b6:303:22c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 08:12:25 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::c3) by BN0PR03CA0044.outlook.office365.com
 (2603:10b6:408:e7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Thu, 16 May 2024 08:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 08:12:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 03:12:20 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 03:12:19 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC PATCH 04/13] cxl: allow devices without mailbox capability
Date: Thu, 16 May 2024 09:11:53 +0100
Message-ID: <20240516081202.27023-5-alucerop@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|MW4PR12MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ee4924-b57f-45f7-ba31-08dc757feb47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RO94yRxgfXg6wnNZ4Bw9CYFyGZOdPWryy1KcMej59m9VfhX3mlRTU+4tYOuq?=
 =?us-ascii?Q?QTQH3j9g6x5514kXmnsoKiuMoOsN0ExLGFnD2FpbUYekuNHrpR9SrOpE8gNF?=
 =?us-ascii?Q?lW0DajzUcJxZJiWLhAfUG8mBagL5eP+kBx+0QTLu+orqzzlro5nhCGsZFbeL?=
 =?us-ascii?Q?foUNfZHQUb+GEM1w4WxV3Bbon4feuGmTsyXb307etbYJmxju6gevc/jWYiM4?=
 =?us-ascii?Q?NrXvB7ESZxXmbfuQA1uS3k+pqQuNcZx7zp2nt1MWZ/Ft2JO4sVM7WTplxWKd?=
 =?us-ascii?Q?Hk5cwcRmOUWEDhALxK4LGbGGjfWfAGNnlhLVt+WQ6OwqCvOgZStwuX469tJ5?=
 =?us-ascii?Q?xYfb951iBILzoa6RRxhJCnAIIMcuPIfKhJgf7d6jOx6CK290Ut8/eLDiXDMw?=
 =?us-ascii?Q?+gdZ5QCxEJv57hQF3OvosrUpcv6eoxYlg0Iyb9PSv4UfRT5knjSwIbXOxfNn?=
 =?us-ascii?Q?zQxxjkzxL7iEH7GSgKBPp33Fv+QqAQ3jNaFnCecD5/ajsIOEBexqDy7BbvI8?=
 =?us-ascii?Q?BZWPNLNthRJTYdACwTk4Cld9Nd4yPTI8s+eQ7zpXLiSB1GD9nxjBsTjA69ZN?=
 =?us-ascii?Q?ER6AxmwxbaDaJqMqFFUOCOgKaIcEwT3LYWMIMQY62Ay/KLwl1EOPiitj20Ug?=
 =?us-ascii?Q?v941sWZzfmBqmClNe7qgKL/+kIdH/pHiapvndHtYlLzb2J/KWlBfIya9KzG3?=
 =?us-ascii?Q?krBB0VWsTRdHI+OQk6ZMVl9WK+R6qBm1cgsipLB3iBEuDaoeizYe/kJtaEPx?=
 =?us-ascii?Q?GBEE0WRA33qdpOliAUduMmrA8oJ9/pQm9zXHJcyoM10bQ7y0H5NG+YvHEGIN?=
 =?us-ascii?Q?OVVTHdeNvbOa/V/v9jp76xlXCSSpQpVVJi7MZJKtbO4e5b0k936Q6QT5sb87?=
 =?us-ascii?Q?gJPMwP2FOncfi04ZosNppw8xdokuQdKCsCa26opScfR+ftcGE85TykrO/kw/?=
 =?us-ascii?Q?H02LjfjKQDkaDEgIOX9S4OK8I3mD4wEQbc/f8IFNv/czXdTKEXYWFqCVvCjz?=
 =?us-ascii?Q?lLZngOOo7w9uZ45X1DvYumJtJYRF/dC0+Nc/aS8aY8Q6HOzc6twi/atQd6zj?=
 =?us-ascii?Q?PbJRGHGybQBrTGe/doxH0nktDr0VbfI07vHNaZSi0QeX5W8as3lSS3jJVZIF?=
 =?us-ascii?Q?MfWj/JOvPcvLfrI/QzLfnuJLg0xPTG+0lcSWKf+sarzDlLOll7PLcIprrVYx?=
 =?us-ascii?Q?eHs3sILQ5HVQxyhPwTYrnJ4BQX7bVV6w0rRKIJj4i6aGH1974jiHwBUr4+j/?=
 =?us-ascii?Q?WQtbV8r2r3zUnSlkWPg7jcLscG/U9lQ1R1Wyqv5xidmGGHgKmQ0SxVMK6HOv?=
 =?us-ascii?Q?GnhLJGaF016nMNvOLFzbfEv3s39dtF5NxEQbwJZzU10ShSSexuaylOOf9dXx?=
 =?us-ascii?Q?tZokxyxCIfe/bPDqGGKR1vDr7yXy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:12:24.7941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ee4924-b57f-45f7-ba31-08dc757feb47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7287

From: Alejandro Lucero <alucerop@amd.com>

A device not implementing the CXL memory-device class code, aka Type2
devices, has mailbox capability as optional. If the device registers
mapping does not show such capability, do not treat that as an error.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/regs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index fd165e718cf2..5434a7c899fd 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -437,11 +437,10 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	case CXL_REGLOC_RBI_MEMDEV:
 		dev_map = &map->device_map;
 		cxl_probe_device_regs(host, base, dev_map);
-		if (!dev_map->status.valid || !dev_map->mbox.valid ||
+		if (!dev_map->status.valid ||
 		    !dev_map->memdev.valid) {
-			dev_err(host, "registers not found: %s%s%s\n",
+			dev_err(host, "registers not found: %s%s\n",
 				!dev_map->status.valid ? "status " : "",
-				!dev_map->mbox.valid ? "mbox " : "",
 				!dev_map->memdev.valid ? "memdev " : "");
 			return -ENXIO;
 		}
-- 
2.17.1

