Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0F1269806;
	Tue, 18 Feb 2025 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885136; cv=fail; b=INmTX4GTiMzcFQByOJa26lLujm2Iik/tsAFUkHJ6mWjRwnNHBfGGFqgjA5SQ1kqQjDOfbqD3XRSc+ASYre4b2TtbxZHiteYvdv2gVbyPHM9KVn1hUFJsqKUmQ+C3hMk08sUj9G2a2Uyf4uSuScwGyGpe5cpiatQcv09wy2S8Ez8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885136; c=relaxed/simple;
	bh=B2NOuoWIhIpVQ5TA9tVdhUED8+IywxVqa0NtcNbdsdE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQ3RYBuQ46I4PialRGrVOP9Qa4BT0wbHhQNOA5WDw1nxMD0eLHquGuWA3D1mIW8YyaPH8PgyBOKonTcDLTTtlYX+czsTRmze3aqdvB9s87Ph6fzz92Q4dEsPJPa7NBg+gfMx08WCzchKS8h6yvAqOsJIkSBrTUl95ag8NW4RYdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V0mIDm8Q; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V0mIDm8Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uogwRIJh5rFxq0P4LkDeQZexzHFukdYB0jCSvfOxy6eh4nx8la6pghu+19mcmBD5Evt1mxyRXkXOmxxqU7kJJLn4eEAWUtiQrawJ562tqfEx89Y+zvBBotoK1+MWr/kpbx0fBQh4t+KgGtzRjjEq5oA2T6eJxgPqZl/Io96uGannNSnBFyYNiD0Awxu40UMWJ/YmShFRxoZgdCXSvNGcy2p5bFMFwJRzN5L81y/tWwDIUn6tuJ8CJJrMMJ9u0zc6k1BL40cLS8YneXVw3kf9JUaeSBXU3OxaZKRVqS5x2Cn0tUFOEuI+OsnDR5MRbhnktXbor4DcP35hhuRxmC1Z/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvFwIViJvyplI9Pn0NRjCIfr8xV2Nh/nJeHyZ66UQK8=;
 b=tkhyG1ZKmr5LFK3/jlOKFgFv6Wy98UI+km5MST+3fRQOt4pAJ8QygVigiPOX+czL3eDvQmaEoYmb4czMrYmQ3vCtPb1b6o7bzGZUj9df5rns6mK7SsNUP/upCL3mHsPAwXdY38tCP+PkJ9ob7XibhiV4f6rOCaqrpc99Sg2qebswJV6X6shpt+LARBA35i2GiSlkkGnBjwoUpCmZNIz0Nx/RbKawS0AUJduDdVmffHIrJXRa40mIOPdRlK1MksoSDMXkQgssRedGGV9IBvyU7flFzBZB95NAg5r2mUu+c7Eh10igsMXDvE540DGO4jIKukDSmYl2MhgvcYdxGhQbog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvFwIViJvyplI9Pn0NRjCIfr8xV2Nh/nJeHyZ66UQK8=;
 b=V0mIDm8QW/5Wbe7rOPHULSGn0EDkFgEPZQtVazwl/GRDOrEgElXcMBzbEOEgPg0ml1pfhLwJed8DSjjP2AF1HNX7ZeuP2sbHLoYvd+dhqOEFLduU4iH44qThq/sG+938qYpsq8u0a5tEma9jRCD2465CN1T0uVeF6p5kJdjTld8=
Received: from BN1PR14CA0007.namprd14.prod.outlook.com (2603:10b6:408:e3::12)
 by CH3PR12MB8283.namprd12.prod.outlook.com (2603:10b6:610:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 13:25:29 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::8c) by BN1PR14CA0007.outlook.office365.com
 (2603:10b6:408:e3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 13:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 13:25:29 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 07:25:26 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 15/15] MAINTAINERS: CXL: Add entry for AMD platform support (CXL_AMD)
Date: Tue, 18 Feb 2025 14:23:56 +0100
Message-ID: <20250218132356.1809075-16-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218132356.1809075-1-rrichter@amd.com>
References: <20250218132356.1809075-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|CH3PR12MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: b720c0bf-fe3e-4ecb-56a5-08dd501fb661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h2vpT3+ejypB583dVb/LngeKNtiTQitrWAE/XDdDio1eRGIgKFVsuHdS6Av/?=
 =?us-ascii?Q?cO69ZB1Lth3VMC09/31ysgYShyESetdWU+TcLYB/0slGbvaUOVeGy33t+VgY?=
 =?us-ascii?Q?Twgcbkz2IwW0dR8edsaJCr05WeJyoSM3ON+k/wkutX5QWPbmN16gZGUqQf26?=
 =?us-ascii?Q?dP4E6pVRkY7aH0Y5K3HFu1/rHoYFt4iAeMntvgw4LERb7WCytHIr/9iSVtsA?=
 =?us-ascii?Q?l+dhUTiKsSGxBqyW1P0LS1VXxRgHjwrxyNl82aXJh7Gt2LTdnhmL2sHSSudY?=
 =?us-ascii?Q?sagXfEH20AYpmumxFseuTNlNHOnpUHgSY+JRMcut5tOmnjVYzBo6jCFgx4jv?=
 =?us-ascii?Q?mhL43GjFyK5hzy8D8ULihiYmfRT+10EJjcPO8DmrlXTcz4XgrSR7rTMh5ioG?=
 =?us-ascii?Q?Ii1eqgcAeO0SSF2s8rB0DqnvlcdF7uU5VcqCX+Znt2DLQKnK3PEJGgUM2+kg?=
 =?us-ascii?Q?7rkCYm07NpKNM82A3bBX0Z1iPZP08X8xbNr9Y52neCObgF9dVYRsQo2pjNbU?=
 =?us-ascii?Q?y2abDi6i+BwtUKR5Tl3YLLcRqMd4nb4XYpUII1Jd03+U4ibUMZMzKa3N1qz7?=
 =?us-ascii?Q?WK3pBVzla/auEkxORALbEdTLnTZUINMaM/XBZvEK/DEScw9x/gozr/MATB3Y?=
 =?us-ascii?Q?AtvcJIN0Xf0hE2X8gRjPX5scFn5bJ1gxo6tOK1/0U0CeYvdNR1FHENqRWMJo?=
 =?us-ascii?Q?Kt/zjVvYhd/dLMstIhEBKDxXNhgPOG1DKEcDAAco5kQ6zkGpJkN5WeZBKqxk?=
 =?us-ascii?Q?RqLyoe/+1DVwvYG37bqjzpu7TsA9MvlZ9ycKCCzUmz6bJUUVDDWAbjRxehYZ?=
 =?us-ascii?Q?jbngjeImmjwiAKF+24/cTKbADDggFnl51MQivB4TbnbQPJDd/khd1ebbpzvW?=
 =?us-ascii?Q?owBojidQJ+IqhObADSxdbwGLo0ExlifwClvZcL7FlxObGz7L0x6hInrj2B3O?=
 =?us-ascii?Q?XrN59iJbnv2B7m4nUdShsyx9kgCF44EwGT9+UrRQCHX+pWKpUnA7TwnA+KV/?=
 =?us-ascii?Q?4HewThc890aRO0Oxn/p4qYBjRWDQdmGuzGHXqlxR/FcfIAVgOHBYZ8ac/t55?=
 =?us-ascii?Q?0Cg7groIc2XjbXDG2JlaHocPsr2rfDQSLtQPeXLOdNtzigRv3e9rHFb0u76o?=
 =?us-ascii?Q?/cxf8AkW6q1B3m1xTl3R3rziDo4pDZMOYZnkLlEbq6rKYzvwkajeIC0FEWPy?=
 =?us-ascii?Q?+fMwVdSb1983cdohTFsb6HwMc8UzAVTSKXJ0soDx+PQojvOhaQujqfZI0NSb?=
 =?us-ascii?Q?yO5GdaT28Dm9Hzvvvo0CODq9GAaA/NxABplQwiuEZuwsd5c6ljHlXZQRLVTb?=
 =?us-ascii?Q?O9/hnSCU2ECPfOU1Y8flEHiLj7si98uCUNjErgqlv0gAaJcoJSQzIG+NE8GY?=
 =?us-ascii?Q?U99qJzKDz2bNF0MXn2kc8Tx6wsOfuktSFTOKQBSVi2JgLO74dOX/DNK0A/M9?=
 =?us-ascii?Q?L9+5bAN+4Hk8Dfq6u/iyHEWwF7JZFa16lcWg5z/tgpg6wXiV2ogBZYSRDdGy?=
 =?us-ascii?Q?XkcZct7YUV/dtO0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:25:29.0050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b720c0bf-fe3e-4ecb-56a5-08dd501fb661
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8283

Adding a maintainer's entry for AMD platform specific CXL support.

Cc: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa065..12eca796fadf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5842,6 +5842,13 @@ F:	include/cxl/
 F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
 
+COMPUTE EXPRESS LINK - AMD (CXL_AMD)
+M:	Robert Richter <rrichter@amd.com>
+M:	Terry Bowman <terry.bowman@amd.com>
+L:	linux-cxl@vger.kernel.org
+S:	Maintained
+F:	drivers/cxl/core/x86/amd.c
+
 COMPUTE EXPRESS LINK PMU (CPMU)
 M:	Jonathan Cameron <jonathan.cameron@huawei.com>
 L:	linux-cxl@vger.kernel.org
-- 
2.39.5

