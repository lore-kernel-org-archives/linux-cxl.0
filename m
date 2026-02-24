Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F15D39C63D
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946822; cv=fail; b=FHDkLQrDqUHzLy6wKXc3grpl0tjBLp4EcDxSnSOv8bKDmDvW3JDQU8UHRV8NdT8geUuGuB/cVHwk4pfnXVAin5NmiDctPBU8TI2wiULWtfVbWw7051mAQbLhNwGRJsCyySclJ8EdCX9vgF3VEdnOgBjodB+C/t7bEQ3ylA1SvX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946822; c=relaxed/simple;
	bh=iCPWdcDVqh9/TCk8pVPchMSqFBm6fzEZRvwdcUEgexs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kLjFrT1JZGtw+WVhUdRwoVy03RAEYDhENRjTROOans3Icm7EaSO19B5cpv/43M5BshN7N2jBZ/E0SSzgt4OLql+JjgznWOGpuEaTqjjGROjFeY7XnDwkQhR5MUUGf+Qv5J6tVeklgYmjheFxtjvX3cJuQBG3QwjTppcogp4Tg6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DUetRL8P; arc=fail smtp.client-ip=40.107.209.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DUetRL8P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pC2TwiSe2RCFygmA0G1EMOWk1yCfb74xosbpY1+RsZ1IClybe3ZQvfTLroLhT1tSeOTWi3Eg+BH9ILIQ7KZNoOcyEhhZjluiVSZLM8TCifsi+do5AnQ9/EHl6xd1pbtP2HffZSguuI0LMiMvpTo90n7LgMdjTd/NYagAbgMmX+IAjcvHptcemfLV7OptBnqlpxPljaNqh7u3PXF5S+rpNd4GvT4IDXw3+Bz8ZadriatmE+uF+zW8Da51IHayfmXeIvElSgos7DzK1vu5MMXCFEiS6BFu2biyypg2jzABmiE7KlyNOpEEKW+Vth8SDggzbG6SMZrlAz8fQSEV3J7+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xb0scMjENigEz9GySzqr1wcrfuPqd/YakeoBLxgK2mU=;
 b=KidYzUxEgaNjroctlu5h6n9OWB2+6CB6YswyuHa5GdXTDVPG0+oMslEhiwVCUfpENqxve2oF7RlEv64cHX60WYHWWGMgNmd3RC5VkRAofOAOa0a6h73XLQPOUCLL3rFA3yHhRJVOkOed5LI+Hbx4e8Q49EWn0UgcsBSeR5Q5aNZusszzIvzwFZ0v7UwaiOwOWQ4rjsCHKm26OghdOOaZYktMK64OjDHwZrfG1VXfx+D36NWDEyPw1KMEWYBOWp3wy0lvutY6scE3gawR8mNlbC2PPcedggFQHk/8Y3heYPga/26bzXkkOyK+4L6Q7yXZawJWLWTJZa+0jm0/RPcaDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb0scMjENigEz9GySzqr1wcrfuPqd/YakeoBLxgK2mU=;
 b=DUetRL8PRZ8NcRATPk5EVgXd5D2jQdv+5NFuzh3L1msGrdmj/9fPOpkKjxsdP+/v7TO/V/i4/nbvwuKKRFOdmitU6gDtggXb0dU/sKDrwfkuCzWrAZJexnM4mmrD8Vpl+Fo5x4ETvvVj5rgMTo6uEsp/9agkNnLZw5MMC1iUPu4=
Received: from CH0PR03CA0220.namprd03.prod.outlook.com (2603:10b6:610:e7::15)
 by SA5PPFC3F406448.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Tue, 24 Feb
 2026 15:26:55 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::9e) by CH0PR03CA0220.outlook.office365.com
 (2603:10b6:610:e7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 15:26:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 15:26:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Feb
 2026 09:26:53 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Feb
 2026 09:26:53 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 24 Feb 2026 09:26:53 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v1 0/3] cxl region changes for Type2 support
Date: Tue, 24 Feb 2026 15:26:42 +0000
Message-ID: <20260224152645.3441489-1-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|SA5PPFC3F406448:EE_
X-MS-Office365-Filtering-Correlation-Id: 680195a3-c7fc-4b11-bb0a-08de73b9245c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JpOeBM+Qz0eEseAOZPQZVmpy454YB05M2OOeI8iA7p13wW51C/rqgjsmx97r?=
 =?us-ascii?Q?6GaF9ZZh1VFwcHR9bUz1AOu16DqMz/ATT9/G0tjm3wB0hwMKUKF2GP8rwW+f?=
 =?us-ascii?Q?+AA+omLESqmnKd563C8L9Hd/uhNZ9Wh82PhIRU2HLR2kxOCx0IejtAVl++FS?=
 =?us-ascii?Q?ETWA4IsoDjlAOhuMOLij2ljNpnSPsonfVxlRUh7P8kuaVmOhRttX1ZPoU19k?=
 =?us-ascii?Q?ykkGUs/uZprs1thacNUP3eu61t1cLtpSgrklVNA52BezE9a38H3s+jabg9EU?=
 =?us-ascii?Q?f5KvHBYQbbAL2Q2sJyZomV3Owe+yz80SVbETnsycT8Sd1LMxtFN2iOCs/5aB?=
 =?us-ascii?Q?QiD4PD9/wvl/HB/YWhrwBz77uG8sl1Rw+eUsEi9qxycyfTk1Ut0KFj9QteUv?=
 =?us-ascii?Q?/Td42oM7DAP64YTlM1pUUp1zl83s4J/EHg5CsepNZEMjZHGLIxbrbtzYHRRD?=
 =?us-ascii?Q?V9U061hVpmQg+XemqgdzjmJLZcY0VuoYJD95XwfEMnTbSMksfJpgUV4KJ6GB?=
 =?us-ascii?Q?+b4Q8X8S/N7DqJTNmI8+peLCQuDtEIXCs+SnfRPnExRYdEgYZpFbxVC5e71m?=
 =?us-ascii?Q?sWMIKZp7VhlTkRBPvo3+49fcVD5/l+J3vA4/ZcDPfT+CIUG7XTONWNim8xSK?=
 =?us-ascii?Q?TuLOgzmWKdTJuvkJG71lvfrTaew5jFsSoK5HfS4MZTU6gn9JgWN99Mg6Blei?=
 =?us-ascii?Q?gcS1V2fuQvwPu+5wJKEumhqCEdvSwqSBHvLhxGzKblyq0g558VFf5+gzJGZB?=
 =?us-ascii?Q?yE9Nv9v74cBH1G+u1gBUjm1U/pGwvrOkWQ7M+gaXudjRwoWXZwNgR0h9S0HV?=
 =?us-ascii?Q?cUWSdQEvy/vHQ8xoKGwL01jaeMAZDprxR6YDhqnm2oQLB06awBVGQx9BFqje?=
 =?us-ascii?Q?WvItYMt7zK0GpCYAnTX8Szme0KeeY21Wjc0ECWuFsMKogFDc0eG/a4cz/2eF?=
 =?us-ascii?Q?Q+fhmQ4n5YeiMiBkWeV2HtqQ7vA57lXDKS8jGnR8QJ3sEDrqjb0g+tH8DjQy?=
 =?us-ascii?Q?jvCpcELNbdERott2zVs/ZrQIA8jl1wyURciyFDy0dVBONDVGo5zigG4l33ul?=
 =?us-ascii?Q?KcIEy/i1G0jg0wcGYCExdtgW7UdGEaW5R8Gji+/GZbpuMhV3IwnsWopLYCx2?=
 =?us-ascii?Q?BaFZgeVR4yCVaLnyZm/EKDgJOaThsesWMGt3+ZfSRg21+tfTqpt/dbPHhTTk?=
 =?us-ascii?Q?AiE2SmY9Wfod95W1Ll+PXZWkpwW7zK7kXBNPE6mqNeBfl4EkZO4w2ou4e1tO?=
 =?us-ascii?Q?2gglJ8gXq3USzHHEt0t260rL6cgOq8iNkhfRCO0oi+8MtAgmoTj/pELCDiwT?=
 =?us-ascii?Q?4Wa5vHVcXqtwSDKBpq8dMIWWHRIdtUjsi6r6ZH6b8I18IKm6MtJVeLlbIjoc?=
 =?us-ascii?Q?N+pjXnDUeHetaBZ6XTpjQAc6bYGusCWGMv6nPt5h9zGVmPu0eGx+fL5L/seF?=
 =?us-ascii?Q?XzycrUVFwwaxQaLvt5A6RqsKT46VEfYhi2kk+I4311bfsdzyIbkAbPGrK8Z5?=
 =?us-ascii?Q?C8wdfG9uoPztxuc2/pnTB+mpz8zRuvPoaovbdL7fIF4VPuMRwOQ37d5rLO5I?=
 =?us-ascii?Q?boLOaUPmq6XTSX3YpSZoF3myiryyXl8xF0pnM0KhZYV7LIroqaQ7nLJdPnJT?=
 =?us-ascii?Q?t8nySSDXWWWVdrtSXSWLKHUy1tfy/qjSkzQuTF+4vpjio3CcIsE6Lr7qxo4q?=
 =?us-ascii?Q?y/tcFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eWIZw+IffLVdTGWYXkiZmCV0/yMYEmQ3u8L2/oPV83NDQUGkeNrgmGc+SbC6rZUbODs3piq+k4J9c1Ayl/ZTfy92/Bi/ns8F04bHueVb5i1VwNyyEKks/mbW2F5e/VyI9S76jMpur5pLLfODydlevOc2Dj1kwlsx8KMuIYIF/ne3wIOSolCzYM2vo6fbMVPsSglIavoMzPbBfIChzFja51Bty8SerIMyjX4NUB7OEEJaTApgxELsHxYed/zxQVK+ohzf5Z8lyUyQYZpnb5f4wupjb4BKRv2ytHkOwJt4KyfckUFvMbQbHCwLtOKffNmG7Y44EEQTHQSQ7VyFz2Bzix006vKmiIUPwU4qpRhHbXigWoemiV7QE6q7ocMNYO3vZKjB8qq4l0ywIOj73NB4QJhzOemrBTkIT6QrAv8uGwaYL20+aYNSj/UMBj+wxRoL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 15:26:54.8837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 680195a3-c7fc-4b11-bb0a-08de73b9245c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFC3F406448

From: Alejandro Lucero <alucerop@amd.com>

In preparation for Type2 devices/drivers support, these next patches
adapt the cxl region code for required Type2 functionality preserving
current functionality.

Alejandro Lucero (3):
  cxl: Make region type based on endpoint type
  cxl/region: Factor out interleave ways setup
  cxl/region: Factor out interleave granularity setup

 drivers/cxl/core/region.c | 87 +++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 31 deletions(-)


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.34.1

