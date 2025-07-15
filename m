Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D0428F948;
	Tue, 15 Jul 2025 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606737; cv=fail; b=GwAa8TNLUep+DC9eovZiEWigkIVvwCK+OB7Zir8OaMBm6iIBehHT/qjffL/xhgvvKInlcRnP2NLhvRt5SeuOmbpLbxqqXOCvSonYSU978P5dnfUo/mMFnfeeQIMwLn3ptNAgOIHU3iqkNHbsb8ZjYarwbor7btWhZe3Y+YSBrp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606737; c=relaxed/simple;
	bh=RNpewsMt/vlV1CSFJX77daPiEEgsfe4TJ/GrwG2wHkI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cx1Cgysf2Cskt2Q1R4+brKTbN4b0xyu4Nui64t68/euOUmvQNGVbtCiE2MqVKIuQ8JD/VOWNtzPbqF9gNyG8wIX+mgsoAlw7vIieBIBIWGB52OnZQG4xFgr3TyjaHuhgmGZvGPw0Mr3nR4a0iyZC6/+Os6aAiAJCjnFE/o+Ydtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=19uNd/Fj; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="19uNd/Fj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhpB64Y1jHNE8v6Hs3cAM49hu13rpwuQBUJiwUIEHJffqTH+hx8mJ8qExT6uJmidQTb0B/3mFX6etjsKKuWMKjIlSMxXEDSJOpRWOPKBG8XlxG/e7wEfakWe6deveKzKVy8TK02AKFg/QKD2ixlOalQ63PVodKhsMukl1IBt6QfF9TYKqMKDLg9a6hNzgZPRphG6tLOLPtJGe6HYlrCJllXqAAeGtPKSw6dOC9S365glLba2mN9tjS7gIKmVYRm/x66mSNNQji8jRFHx0xyctLAV4jplLMdQYy4iTE+0InpzujgJwd2Z7WbQzeNtXg/ZY1/hd37ka6EuvMl8H9yo1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79ySXySHjpmZzI7f1MPt6iTE2yi/7riP8lDMWQZ39rA=;
 b=r2d7p0jq8iS7hRtvnSqkAD1h0mxMgT0UPEiUiJeEidFsbJcgAYwXzfn7vrCEm58lh/I0ieXazfAbDqb4XtSlrUWgtsw0F93q5M9jX1p5rqgDgUMKJZu49LQz2yyPdopTNsuPr3LIhT6HALFEx3ia1jbn9MQd1gXxxbgqeGWUWkMsgOII7OYbGt7re1lLHInEs2VqkptPXKQRZgwqCx7XivoB5zUTCPFBMPaXNcsRzwADP/89wjiqIX7DNYGwDL9afLA0bPPtDEkhoBa7Mxt0nc5QlxK581Gq9tsfqNw3jHUEepHJH/CJubyC9dsPby2swnMU0l/2itJaO3sVSGg5Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79ySXySHjpmZzI7f1MPt6iTE2yi/7riP8lDMWQZ39rA=;
 b=19uNd/Fj57rUSK3y67edxeqPI5kLuA/S0rHv/+bMYL7vfOJO6p7b3M4t/7X/KcPHg9Tkg5osXdIVrAhVNHx1TaObE67YeGHmTq8RF7AdQ8eBIvMhTc5FvkBYKz+7BE6YiZZck888V01AcqCn//OxE2hXepINWc742TyEEma3VNw=
Received: from BN8PR15CA0062.namprd15.prod.outlook.com (2603:10b6:408:80::39)
 by CY8PR12MB8411.namprd12.prod.outlook.com (2603:10b6:930:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 19:12:12 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:80:cafe::d) by BN8PR15CA0062.outlook.office365.com
 (2603:10b6:408:80::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 19:12:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:12:12 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:12:09 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 00/20] cxl: Address translation support, part 2: Region code rework
Date: Tue, 15 Jul 2025 21:11:23 +0200
Message-ID: <20250715191143.1023512-1-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|CY8PR12MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da62d70-b4b9-40a0-9dca-08ddc3d380f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u9sWnwEQmCVBNJLYCuU0N/VUipksew5eY+atv9AKZJ40twn9bSP6AaVCIVgc?=
 =?us-ascii?Q?YZ9Rm9qQyf5p8yDo97uCaC9WISQatkwPmrD6Pr3FPWQAIvHjuVsg6rj8jXMl?=
 =?us-ascii?Q?lo4TWes33pPJmsgasBSLDOa5m3v1cjQCtR8XVP+DeTW+lY5ux56PqLUwWNYo?=
 =?us-ascii?Q?zmjzCi4lJ8JV3o1ml8xgUAbQ3Qcz07pKocmTaFHfJbiuIByO/Oc0Z/KeFW0p?=
 =?us-ascii?Q?KAUyQ3Gjfm5DE85IKr8gci3DnVTDUvT7rvgGYVrL44I3dztnQ/ealG3maxF7?=
 =?us-ascii?Q?t8a8emZnS+71EQvUAVTg3SX1T0uJ4x/7upDDuzO+qt3hRDdG743pyqwnv60g?=
 =?us-ascii?Q?b8G9aKbfj2kRYqByTZIpxQZI2FSPs01400NX5D8XCM1lUaIShv8ojCnUiZq+?=
 =?us-ascii?Q?UTTbOCtvqGHJWd+Jb3dDroEKWS858OsDQI8YuaWXzzcshJIdxBGUe/8yYCu1?=
 =?us-ascii?Q?aE97wRI2vO9f/rwqupk7S25Djc+v2WZHSLdCcqinHIcZSpvrppkJ9veDVL+q?=
 =?us-ascii?Q?i3idMjC0p+4FUncxzHcLsnTyVMXaCn96zvILU2XYQ70D0UTvs8XvcRIs5Yhr?=
 =?us-ascii?Q?OirPP037UjLkuU2JOdiFSJHZrY4QBPCxuneO4UMP26Xsek3mCaHLBgRfQVO2?=
 =?us-ascii?Q?fvyEJGgDhB+4qZ4LX7gC1qzYtNAThNeVAACQcAKxMr8k6gnGES9aQakk9FoP?=
 =?us-ascii?Q?nMt0exxiBkdIyyPxUb2G95MrbYMJp4jt/GgxT5X812NyZJpFsTPB5BhTYF+n?=
 =?us-ascii?Q?AqP2LYgGfjayPVrTigz9CSYZPl2b+Ei/VP2qUEM40ujDNDWDC1cIvzMyb3tF?=
 =?us-ascii?Q?/06Z0XSjLP5933Isfa7n7QBEoGhrHERZqYk8+GLSDjkU2fdaUWHtfSx+C0NI?=
 =?us-ascii?Q?ky/DvRpCxoydzNo6IEEWVJSeIbHRgkS3MFOifTCONUnMl18MYmpOPPlLXjiV?=
 =?us-ascii?Q?qEzbp4gBLJJE+k+4nliPG3aIFN9S3mB81UCCu8RUMZIqQrKj37pdlbirgq06?=
 =?us-ascii?Q?Ifp9oyODAOu3sawXvjqk37s/zAqSayhSvtx1e1tO0u5DXhoxfcyGehUGbADK?=
 =?us-ascii?Q?R/CSyMBbowSXdr1b3h0PezU5aZ8j9WnXRT8Q3vnXkm0cYfFa/Cghhw9XOXdB?=
 =?us-ascii?Q?gvbrisiHYwBdzy2FqEnOe0wxrlVkkrvGJ8kchnqe5oAHp9I9jSgsufIDSqR3?=
 =?us-ascii?Q?zTNF6ulgOjkqfyrbjMlLLkUwl2HX+jsmdBxpm0xJtiVlY2MKaiRMYHs85ojr?=
 =?us-ascii?Q?lz4dQgmXc7AMM8RmGcfDfZ+4Qw2QbOOOcW9Vt3YtzoaT3dh8pOUDA1bNMViU?=
 =?us-ascii?Q?M4hkV2MuTX1hrmaN3ioWCNvRPxiqzFP6ZjUbyoNk2XCGBsWURN0r/ER/S8iw?=
 =?us-ascii?Q?uH1nKk/sFV2XJ/A/Hk28QiLuNuM0SOhUIX4ljhzUtQkNMEm0S3PFaBNkapbH?=
 =?us-ascii?Q?NOBcl3SWdSCa3H8zyyxnyVmxB9vTKHEanjrJUskwKLFVEtDqmnN49xRL4s3J?=
 =?us-ascii?Q?L95BrHuBobo6IGw8rk9lB8b4vefIYdTF5ODG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:12:12.5411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da62d70-b4b9-40a0-9dca-08ddc3d380f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8411

This series is the second part of adding support for CXL address
translation. It adds another rework of region code to address
implementation changes or conflicts of current address translation
code with cxl/next, esp. the introduction of support of extended
linear caching.

Following parts are currently planned, worked on or finished:

Part 1: Cleanups and refactoring
Upstream: 68d8b4f399e7 ("Merge branch 'for-6.16/cxl-cleanups' into cxl-for-next")

Part 2: Region code rework
This initial patch series.

Part 3: Extended linear cache rework
Not yet posted.

Part 4: Generic support and AMD Zen5 platform enablement.
Not yet posted. (Earlier version posted as part 2, v2: Generic support
and AMD Zen5 platform enablement. [1])

The general changes in the implementation compared to [1] are in
particular to use the attached region of an endpoint decoder to host
the HPA range and interleaving configuration parameters. That is, the
region's root decoder and HPA range are added as members @cxlrd and
@hpa_range to struct cxl_region. Both are introduced to keep track of
the region's SPA address range and the interleaving configuration.
Those parameters are the same for all endpoint decoders that share the
same interleaving setup.

The implementation must ensure that the endpoint decoder's region
parameters are always valid. All parameters must be determined first
and then a check must be performed if a region with identical
parameters already exists. A split of region creation and registration
is required as the region may not become active and may need to be
replaced by an already existing region. Several high-level functions
are introduced (create_region(), setup_region(), register_region(),
cxl_endpoint_get_region(), cxl_region_find_duplicate()). Most of it is
implemented in cxl_add_to_region().

Finally, this series adds a lot of simplification and improves error
handling and code readability.

[1] https://lore.kernel.org/all/20250218132356.1809075-1-rrichter@amd.com/

Robert Richter (20):
  cxl/region: Move helper functions closer to their users
  cxl/region: Store root decoder in struct cxl_region
  cxl/region: Remove region id handling from cxl_region_alloc()
  cxl/region: Add region registration code to new function
    register_region()
  cxl/region: Separate cxl_region_alloc() from devm_cxl_add_region()
  cxl/region: Remove dev_err() from cxl_find_root_decoder()
  cxl/region: Add new function cxl_endpoint_get_region() to simplify
    cxl_add_to_region()
  cxl/region: Rework memregion id allocation and move it to
    register_region()
  cxl/region: Change __construct_region() to use it as a tail function
    call
  cxl/region: Remove __construct_region()
  cxl/region: Separate auto-generated region cration code path
  cxl/region: Remove region creation code from construct_region()
  cxl/region: Move devm_cxl_add_region() out of create_region()
  cxl/region: Prepare removal of @cxlrd argument from create_region()
  cxl/region: Prepare removal of @cxled argument from construct_region()
  cxl/region: Introduce @hpa_range to struct cxl_region
  cxl/region: Remove create_region() call from construct_region()
  cxl/region: Determine root decoder in create_region()
  cxl/region: Add function to find a region's duplicate
  cxl/region: Early check region's interleaving configuration

 drivers/cxl/core/region.c | 514 +++++++++++++++++++++++---------------
 drivers/cxl/cxl.h         |   4 +
 2 files changed, 315 insertions(+), 203 deletions(-)


base-commit: 12b3d697c812aaf356e82d9e1f351fbb2ea97500
-- 
2.39.5

