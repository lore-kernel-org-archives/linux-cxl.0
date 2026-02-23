Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013000.outbound.protection.outlook.com [40.107.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6843A285C8E
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856811; cv=fail; b=SrAwi6V9vsKmvwn3CxMTc59N8WfICldrxgAaxK6Yd1EaZvlaYbymD3CIv1xfwlGD0HF9B2eIqyKQ2Jh3akrYg3MGPYYEDcXpDnHamxp5owWVDzQ6Waye6FV+VAiETHr0xSkO+OrVW7dTxZwuSzcdYD3BVtEcpjhs3knX97/wiZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856811; c=relaxed/simple;
	bh=FCdaJDA+ccn4Qsmt0yyS/b9qC3RCd94PchPzbPTny6o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eTxEoagS8tEarvwqqSWcHfptynvUtsfM477QiGip869Bq9bXd2eZGVmEIheoSbVt25DOuWv4YfOymPVHk85hJnnqSLP7yRsx4gBesYfyM+EA531RJFAgPuE2R3P8Ro7lVk5ZDTbGjP+d5+fRzYiyewStHkbvtkl5FPxRFUPM18I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gKwL8+a2; arc=fail smtp.client-ip=40.107.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gKwL8+a2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNlFukSNnOJKov+zkUR/rXT0X1Jx2CtTkszjNFLzmnF/3ZnlFnKIKiOxayDNFSYm0t8bmzFtbmlbfIr0F6wpjNuUbCKvAhtscvA6H1bIEahE61A5Bp3oZ7bL8W1dgXjUP6VtqIpViqVoOT6O1vghYdyVyo3ZJLiDk/ov88Tp0SAVJLJwc6Mot3F47Zbzb3zEbtTXpOe9yk9IIKa3A+cAl4Kb8/10uuEFvMSNVrMoIPbwgo/SNab15csPSsFn0v5TuC+hU7y/+ydHmXVINQugOO1kuXjWy2+ON/xblrAk8hEQDqMMkFX7OauieFayC5ItxVUEr89GvdS4YvhqsBCtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zetmFLClOMUWxLhE/hblXRRWyLC06DBWJrqDAhPeOt4=;
 b=QwqYT2/31YRu43nVhw6Wn4zlV6JwoBY8Dt1gW9IuAZTzHUISZaXXpFBi7YwGmP3kXfE7UfkYXLT6KxgCDZAU36dK2rEGn1ksvYbaDvI2WYbidrg639WFYx0xSFkqG9JpXqvHpMvwhrYdOJ4pYl5QRDJckTgr3RICKHzgOUTGcTIwRi+q/+eWKf2eJxRyXtqXT9YWEfDQL4rudmcMyJN+no/ueLwvl7h65S55/kQfunoUunHk7FyDF5YKhFutweHjwSkmyAiaYvWdGWE8C1OODnuQyf3gmvm6ytGSDsDvhZKD0rE18LP6y48VVy4LI05LcacUbTjdooCitSL7jUQBMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zetmFLClOMUWxLhE/hblXRRWyLC06DBWJrqDAhPeOt4=;
 b=gKwL8+a2cVgEoKaBQIs8DqqQKCXUPOeESKuOiu0Uu0Vr5/xZE8ybte+2m9tJ/2dUBFWQe7hMvUA2X7AJo6aS2vH+hVJzIbD0pUNJUrpnXJwZmoaPQeyOCmioKJccZeQPoaRr/zXrxBnZuNSpA5IZ//Amf3nitruVHoh8GLklCZI=
Received: from BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::11)
 by CH3PR12MB9393.namprd12.prod.outlook.com (2603:10b6:610:1c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 14:26:44 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::2e) by BY1P220CA0011.outlook.office365.com
 (2603:10b6:a03:59d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 14:26:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 14:26:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Feb
 2026 08:26:42 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Feb 2026 08:26:41 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v1 0/3] type2 support preparation
Date: Mon, 23 Feb 2026 14:26:30 +0000
Message-ID: <20260223142633.2994082-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|CH3PR12MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d30c7d2-cd34-4fbd-dbe7-08de72e7914e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wjc3jjNK9FNueIECoyRwT8Lhhtn+zIxUkr9/EgddKt85t5WUnNofNMKKyGfJ?=
 =?us-ascii?Q?tcsMa0C9P4ziDrlNm8wckZDRrPnfwS5LqJ+ZptRcYCHdonJdT0T3ID2DWRwv?=
 =?us-ascii?Q?g6TD8ljxgC5YA1EbfPNtH+UBy35EIYzxUhc8XMsGFNhR2dhn14O0+H7beClu?=
 =?us-ascii?Q?Cy1nqQsoaiIvR2HWiJUdoy8PCLKavYkcO5Hk1JX31cxnoNR4DhWHDlPIyAkP?=
 =?us-ascii?Q?4jMx1Swc7xL2iC8ZLLV9EQRCU9xKJy4c7fs7d3BGrKzaB0xJCsYk+kq+YJGB?=
 =?us-ascii?Q?piULWl6u0acmylQldbwtzeZ6hDPAWJ7vlazon3c2cGQrCOQlCXogoGvP7im4?=
 =?us-ascii?Q?NaX09nMKON8sUUDjVKR/lM4pk4eyBSLWaudEFfRtOILWMUqY5TkdyLY7obAG?=
 =?us-ascii?Q?2YiEwOi377hpRV2ayT7V66NgsHFNFQ62uuftetwVwNvvnUfi0jfm6+gW7Y4h?=
 =?us-ascii?Q?wZq/ZH4SRkgG7tEp4rsDTRiBNkcj5oNJfndrF/Rjb5dxd7vzoInxCvV+/Vqy?=
 =?us-ascii?Q?3ONNwSuSZIb2vsmyntRxxE22XYHd4Qx4bg80wrLYjAX7Hqtnz0CfdRfLf3bf?=
 =?us-ascii?Q?gGRfcGvgDS6tNoEGv0Tvsd7lEK81jLS8nc5S0A5QetObdz8YcbejBJdgi71C?=
 =?us-ascii?Q?9aqqJ8K3mpTsRPQpe4XYdQXa9j2XYkcEslWuogQIiewlMkm6QvRbITeTJ6Lz?=
 =?us-ascii?Q?PVt20glpcRm5PSID7ri2DXLStWoye6QpOdyL8S3HMovARWZ15tnhthO4tEtS?=
 =?us-ascii?Q?B6AXXDihiMUtAY0S77m8i3ErwXlOb2VCF2LiHELBl2rNbnPUTTUgoyZu9Fpa?=
 =?us-ascii?Q?Df/quZP4JR6QWSFS03XpGQuiQYKj4TxQ5IsTGozvlyogOLYsILDpP5RO8pWv?=
 =?us-ascii?Q?fCNOQMzU7aSLGqh039qw4hlAGxyzLuuUh5es630FDkQ07dt5s0cNy3XgHOwD?=
 =?us-ascii?Q?oLiOuMZQjkKW38om7RUNCRVJQePT8v7Wk80WLg39Y8vduw8j4Zx+hVRuyctP?=
 =?us-ascii?Q?7llsl4F6eMvDgbCtQ7+5FBZBEbx1bUvqVlQRYFZTeHCr+1ixbCkiTkK+oYqk?=
 =?us-ascii?Q?c0HmaW4dj9HIcYRiyLAdn1WjrTwWMjffySRoCW0KQuU0x3P/nffZ6knkd6fL?=
 =?us-ascii?Q?Ismn09J29d475jkHnt4Snd0MphqGPMLV9T4AOd/9gKSXpuX4kVth6j5Qu/S9?=
 =?us-ascii?Q?YaG61FCFMctnzQs9mbSFbND41fvu6ekwVipu7J0rop/zofaLK+9OZoSTgfuP?=
 =?us-ascii?Q?z3jzXhH15mnNFCJj/Y/FJdpz4c57JDAogvGaza7/ZvtrKqOkkQ9voW5bZuSa?=
 =?us-ascii?Q?VoHIEJ+Ib9MCcZQH50bI2xuJOkdvUrSmwgXaxIzl1NBbGOq9UtMwGcXCg2ct?=
 =?us-ascii?Q?R4Bb6faF+mhI6GR8weVRFr7w2QKCNBCCaB+1da1nZUIjYAIqZj4haM9LFGGd?=
 =?us-ascii?Q?o0sR5Dd3ukM1lA1wGRScVkE5bIGWmbCcCYI7buqoAiZ+RpiWe83TUoXF7A3D?=
 =?us-ascii?Q?Eru2xNZSOjX2wbLwsfcKwwJNxez3UXJL3L5fOTS/W4n+CHY8/V8PWZUsQ8Nc?=
 =?us-ascii?Q?eSRjALaXk7Wnfzjo8iVHwEVX8ez9WetcmE2Qe0Ne+d1g4aa8+cCFZ17+/k/A?=
 =?us-ascii?Q?OEuRLqAZwpYcoHiJFTQApsMrm/oPPv/Kz3wQaRwKQsndV9beDCnvdi0WD3YG?=
 =?us-ascii?Q?bJnY5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gPFwSrHTSHstMuj9oEfVlG6kL0LHckkYKNg/b2awCs0BgoOE3H97r4PPUgLs6aZW+ylob1Q0Wb/UCZ8PJHo08BDu8nW+VtyCrYHUsg96Ybzqa22mWVFFlSrgoLYv6SpMm8hdu2dzgHHJyG6cN7YPWCSozm2aafgrGt8gmFE0FaT2Zc8lLE7oqjgoLgTCVjV/pQumEWpwLn+SekB/2xwBP3ibenDQDvYYZ/prUb2HQdgKbK6/57Nz7MvK2nxoXWTTJQIEcVtbjmrES4anQ2X3fdRweJpiSFZ1FQt3FdD2rZ3WpaojqGIoLF/TzZaOEc4s7uh9zrhmzPdbZ+s6tgPVZAsC++UYNUUEV37kqNcF6YVOxQtH0Pbp7QBwsK1t4CYuWmaKgkoWaVSc3QITKZTIFLdV3dWBhpepQ/3dpAzjBeNuN9IBkwkBA7LFx9Nq9hTK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 14:26:43.2727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d30c7d2-cd34-4fbd-dbe7-08de72e7914e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9393

From: Alejandro Lucero <alucerop@amd.com>

For facilitating the integration of type2 support, here it comes the
first patches to be applied in preparation for impending type2 drivers.

FWIW, the first two patches are a split of first patch in v23, while the
third patch is the third patch in v23.

Not sure if I should have added the review tags as the code has not
changed, but maybe better a clean start.

Alejandro Lucero (3):
  cxl: support Type2 when initializing cxl_dev_state
  cxl: export internal structs for external Type2 drivers
  cxl: Move pci generic code

 drivers/cxl/core/core.h      |   2 +
 drivers/cxl/core/mbox.c      |  12 +-
 drivers/cxl/core/memdev.c    |  24 ++++
 drivers/cxl/core/pci.c       |  62 ++++++++++
 drivers/cxl/core/regs.c      |   1 -
 drivers/cxl/cxl.h            |  99 +--------------
 drivers/cxl/cxlmem.h         |  86 +------------
 drivers/cxl/cxlpci.h         |  13 ++
 drivers/cxl/pci.c            |  84 ++-----------
 include/cxl/cxl.h            | 226 +++++++++++++++++++++++++++++++++++
 tools/testing/cxl/test/mem.c |   3 +-
 11 files changed, 343 insertions(+), 269 deletions(-)
 create mode 100644 include/cxl/cxl.h


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.34.1

