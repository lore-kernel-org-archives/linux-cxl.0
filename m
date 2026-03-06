Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5AC3EDACB
	for <linux-cxl@vger.kernel.org>; Fri,  6 Mar 2026 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772815676; cv=fail; b=BQjTURlcfD/UgVmJ7MZcn4y1J+KCxke3vpyfTjzzyFGW3pt98jHh7ejJCJKtYYJzC8sLHf6yh5vudxyuVg8vFYrFka2qQ+bDzmvTnSqbRUWPK1KoY9QLBu0XjWyqpn4HqajcK33McoAkDrv8vp0FDecFjGfPL6j4CUVZGJGuWQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772815676; c=relaxed/simple;
	bh=lMKnoQTmDCbjQ4gi3wT+r7c1/CAXfhLQuceQKOZhEJg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sVDCdbzgcXHKacDB9u8FoSaj+xErxLFYok5sZWWO941JIDXOwZC6dUVHL4qx93aRyJwm5v1gaJ2G7OUWKfEsD8kTVZlfPclWSHe4UcybW82j7xc6iGK8OLb4wm6uZyPsdF9+RuvaHYgRMcpZ74UW73sWzLezcYn2N1tX3JiNNuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PGiSnZ1f; arc=fail smtp.client-ip=52.101.43.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PGiSnZ1f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzivM7OQSWdIKp1pMdcThrvynuhXhVNPrmGY7cGrvQ9GpiVA4DzFHtZAW620aJ8D/JS4IXtQMfM31vOQkE0KQRcHTcjDkFf63BtNpoevITksDsU2bGc1SYn4vggJAfSFn3C1oFWKie42s8DK9e3cvZACnY/BY8sfWDtp+gpdqSNX2Vnyk05ZE5WgwylXRL2pFHza6dw5TK3H/wubtz6P6EwCYFDWaDGPaFxb79Pg7od1ptuOseSd/woAge8jMuU06uOMtRRlNnFc8RGKLp3MAu3VLqrYCj2TaPmxzCYVBdAmvRDGR8XZsfeafXd+7wvY83C/28qoScLKvDPZnEtgvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IAy7oKdCjTNkW+KyFxbDGKRNEF63R7JN36Bc57K2+4=;
 b=b7M55z4sWv8SEjTKgoGTdwaY9hcprQG2RXv+YrmTit9fKqh1PvB/zwWeX014C7HQJXZYtAUdMRxXNUeCLks1MC2HzqsOAeymVnY92p2xI85YbvThcoZVqUzuUFVkXym2RHcJPXJuFr/xthJZhphI3Th5Svy5nflnX6vXYEvmBXj2Gq335KkWEwValPfId3s7tqdYEs4p/G0PxxpoPEfOKYKrwaVbqQvNrHkavbhzjSxKxWX2T4S5OQJSVrtP91+OP2tJJXimKgvRFP+lOiCCHM+upN8R63ivt8iSkZgWeyvLav+WRgDZ2Ul+bgq2AzQHHkTiqjpSwfYTT0e2iV7ayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IAy7oKdCjTNkW+KyFxbDGKRNEF63R7JN36Bc57K2+4=;
 b=PGiSnZ1fU6rfCeTZZdWPLmPF8vTK6y4KWqGZO0bCdP6ZjyxfYXrFcu231NMst6jr+7ObAqpuhlzPg+DRgIxqCIUZct8eX0yvxvU7NhVan6HE/N1yszcpZn0vLpuVemIlCA+KOw5cP4Pk+BqwigTAKzgP+q9fW/hGhLs/xwIMOEg=
Received: from SA0PR11CA0144.namprd11.prod.outlook.com (2603:10b6:806:131::29)
 by SN7PR12MB6959.namprd12.prod.outlook.com (2603:10b6:806:261::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 16:47:49 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:131:cafe::4) by SA0PR11CA0144.outlook.office365.com
 (2603:10b6:806:131::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.20 via Frontend Transport; Fri,
 6 Mar 2026 16:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 16:47:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 10:47:49 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 08:47:49 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 6 Mar 2026 10:47:48 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <gourry@gourry.net>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 0/4] type2 support preparation
Date: Fri, 6 Mar 2026 16:47:37 +0000
Message-ID: <20260306164741.3796372-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SN7PR12MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a50e56-eb24-4ee4-2500-08de7ba01a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	//9W2Sg9I3XoEvNpXKk6YI/hnXnWa/hAPYMqS6b7tKJdeHs+yMaOU3x1zfOUMeZtuVySNpzBIFo70rb4+Gq1gMlxa2Nw/zcw1G654aqQlkO5L+zd5fZAClCs2mKj+TxhHdL4pb6McQ4sc2Q4mdhpLbVD5bFaaexuWJRddJbENIrZk/tqQGDon9ibc2chkIIjbJ9FO/SFwUDwIRUK3ug8Ds1unPmh8DzjTCtHH4bItu4p7tpLyupAX7jmt9vTzVwhJjZhH1JWS7it7UvrA8w41dntbw5/s7t38Su3AMGAB4OUC8WRUzFWGp7jS5HO7xV0xFMdB94WQPpqlHPa2sbCpGqUo6desGM2xFS4fP+GwxO5bbumVJSD8CpAgbHhSLYdRhNemPZkM5+VSCedasIlQflG1oDIu8iuy4RqM3dI+N/T3uGSX5ljv44jmA9XWHEsk5h0NDdWyFOUmFvFAy/UhA1yGDZMW582icn1t9NaY4gmNMAWznpVu+8eWEXl6AWpoRqyb095OwFMTIqAoLPybdiK5IlLd2s9QobQUUHlSAneIlzi+kI86fes/Vh892J3bye+m49NhVbpE9cmXHtspdHUAw4aMyhSVBlKyI+d77Ecp56aD/uDvu6syad7n2A6iPjLur/nteufUukCr7tf6ng+rem/xD0fDUXmG8cyabsZr9Co17pETa9wgm6kJwAaKSUfmrykx+m0BqVqqbRONzBHdHGjrT8Gkr87K+uk1fsvgjKeAB7wttWgvFIpFNrlro4OgBP0AzkowiNoyIhIVA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IYL8KzREP64sy6YgghHwIbseVAW+ZQEkOSFsFM/y+S78WztFCGgCa6c3Er+CFrEyJSao9MeEIzdRAtqcaNWeFlkdgqsuoFRhTIuGfX+wcHeBsNjvYMf6WWsfuMtNBfSytoTBFo4q4JlPfHhEbbJoQHRF9IFs1kkAGQJ09ybgj5+1A/1Ca/HMQhILa0H96hNrvI6ZkGaoU5EEL9FLSDttLRGPhatPOrZ8St8UKOIObSJdH6lt1ZMBf0fyJCyz6SWtaiyHTi5nd0XyUDRz3GDM1X4Mk/GToHa034H7/P66Y50NF+IU+A/U4sBe8kSerVq8L0ekY1KgWfIvX8agVN2Cl5aofnFgC+vvX2TytWQ+Dj6AGZrCBIiWWITVsUf4Xz4WoNgv8ZlQ6jVz9IgA76R9ljLi9QSicEQGSe870JtXfm0A0iChTGXlTYx0UVdkAEst
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:47:49.7328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a50e56-eb24-4ee4-2500-08de7ba01a36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6959

From: Alejandro Lucero <alucerop@amd.com>

For facilitating the integration of type2 support, here it comes the
first patches to be applied in preparation for impending type2 drivers.

FWIW, the first two patches are a split of first patch in v23, while the
third patch is the third patch in v23.

Not sure if I should have added the review tags as the code has not
changed, but maybe better a clean start.

v4 changes:
	- clarify code removal in patch 4
	- fix commit author in patch 4

v3 changes:
	- fix commit (Greg, Jonathan)
	- fix member field comment (Jonathan)
	- add patch for removing redundant call in moved code (Greg)

v2 changes:
	- fix nit (Allison)
	- rephrase commit (Allison)

Alejandro Lucero (3):
  cxl: support Type2 when initializing cxl_dev_state
  cxl: export internal structs for external Type2 drivers
  cxl: Move pci generic code

Gregory Price (1):
  cxl/pci: Remove redundant cxl_pci_find_port() call

 drivers/cxl/core/core.h      |   2 +
 drivers/cxl/core/mbox.c      |  12 +-
 drivers/cxl/core/memdev.c    |  24 ++++
 drivers/cxl/core/pci.c       |  57 +++++++++
 drivers/cxl/core/regs.c      |   1 -
 drivers/cxl/cxl.h            |  99 +--------------
 drivers/cxl/cxlmem.h         |  86 +------------
 drivers/cxl/cxlpci.h         |  13 ++
 drivers/cxl/pci.c            |  84 ++-----------
 include/cxl/cxl.h            | 226 +++++++++++++++++++++++++++++++++++
 tools/testing/cxl/test/mem.c |   3 +-
 11 files changed, 338 insertions(+), 269 deletions(-)
 create mode 100644 include/cxl/cxl.h


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.34.1

