Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C792421A453;
	Fri,  9 May 2025 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803260; cv=fail; b=P2wIqP4hgf2IngXyk02Faejg1gkk+lbyMaECSG0a2QPmhngxYXqSLIDUUOdlKPGC2uDaodM5IZ4eu5FnIAw9RGRnh5k48DTZj9mO2OMuOzhkv8rXuWdqfYlEHY2ifOT85Ya85XMDeKgzIPcOdq1QrixAxRkr4athWo6E7rNGosM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803260; c=relaxed/simple;
	bh=MaRiCVbNICzlldY9hCZNUnIQWggsjuo9IzLY1ZxmzQ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bdbihZMvz7yyGXjJRnJRc2dOwD9T5dTH5ff2Xfw6AWBcv/+27URuwwMsGha8pBu0X8Tg9lssAEKEi1hFfmHZ7ioBSJynyT7JF9WuKLaGls/zlqNpLNko8MSF1J/O+t5t6++eB+sU6ijg3kF3uQPS2WZnfO68PT7nfOpQzpt65x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3KalP1TC; arc=fail smtp.client-ip=40.107.212.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3KalP1TC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4VyApryHxKrwbR9qmhEn8rxUFW9tpDWQF9leBo6QzrWS2Y5wMxwZ8W7ZIc7BQfO2QZArCe8E938T0i0Zszniz7yAVUPyVdCxV0NUT8pdi09G+BKO2OEMFK6kktRyD8BKkKQEFvk9l+tnDYxdTLnWPigb1q9AFrTMY8NGbBMPjHgxZCmdONiIRq1kkRsnRxsvstI91BYE6MWVSAnMjLuuFmK8CUPz4j9Lts8sO4OFJBTMK2PNdLmeJWf+UWNgzEvkHCLAatfBhmp+oiMjhySuVdnsK9ARENIJzhEK6NZP6qG0megWvb9hqLKgOQoUTT1OzEepZ4o3dXSvEsUY8ESfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gSznS90ECsYu5HzjH9uBznyaZuVmv3WtoAvRL0Q0pE=;
 b=AbB5Q8X4d9aM70cXVnsXzOayOv4GTmlWun620Sv8J+ROmaq1tV/xRl6247sY3jzDgjo+6f5h8Z4WIrCYJVKa3rmg6q9wxTk1Rm7qmPG3BS8ZDaqfBlIebArPGAs4Ph3o5yZRK7amBxK2n/0iqw1NMrdotBNdF2ypY/uRWS0LpadDP5inwZdQgIX45lLeNS5oSNiaWpZAZY3QhIzQkAxGjxwxXefFfse06Ws/lgSsH1d9tkBxV8w31wzOR/A5lUH8BdM9EqSN+RWXJ7yo18pgP+mGnrRTf3+fT4CdQop3+Fm5y7gteCsOQe+a8WnZ5shzGYv0Jj5JVweynzg2T5SPDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gSznS90ECsYu5HzjH9uBznyaZuVmv3WtoAvRL0Q0pE=;
 b=3KalP1TCFRTf/7AjcvFRlCUjDxpW1HjBG2LlkXL+JHOgbGB0mgr+PADxWeakl3MplsoTVqQLmJ8tImP0Swrvzc11sKZmJ4pKsswJtWjl1n+Q0Qkr2DXYYkj3NoPPE6yaZ2DtOaHvCs7jiDcfxt5JmOs800CSm7nYhGOGj/HBEDY=
Received: from BN9PR03CA0946.namprd03.prod.outlook.com (2603:10b6:408:108::21)
 by PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Fri, 9 May
 2025 15:07:35 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::ef) by BN9PR03CA0946.outlook.office365.com
 (2603:10b6:408:108::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Fri,
 9 May 2025 15:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:07:34 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:07:31 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 00/14] cxl: Address translation support, part 1: Cleanups and refactoring
Date: Fri, 9 May 2025 17:06:45 +0200
Message-ID: <20250509150700.2817697-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|PH0PR12MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d3b1a8c-7fd6-481f-ea82-08dd8f0b3a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NF6f1Rw7QK140i2eT5CzXZ9MRUffVRbOgomjkC1X71C8RTrfZRHI85jYrbg9?=
 =?us-ascii?Q?eAnugJos3HC+VroHRsKharV9MscLKlHxxewzUgtZCYbUW7KT5nAnMbF+ldd1?=
 =?us-ascii?Q?teUuAeG1RnybcD7tH2NPBIxoq7u2JEr/kOCS1uQsghIyTCy4vx/S9iF0xgAX?=
 =?us-ascii?Q?WP+uTbqZRgsl07/rGMo7/rr5CrI4O0fb+QgFaltR7rYqzGW0+VH2gv3/m5s/?=
 =?us-ascii?Q?6Ha9D/WR7Bbnhrlzmb3GD+UaxBIftO+zYCZktwPbj+eQUdJlH2uOfDlbGzuv?=
 =?us-ascii?Q?E70+syL/I0Inqs+YtZuINmPbx7XHLT5d/ZbIZLkfVA6iYjtkCuNuBoEZE0/z?=
 =?us-ascii?Q?k8nsWvqGs2DKKJKh+t+i5BX7O/AgGNnTOi0+XQT4y54NkUJ9JWMtiVu7djai?=
 =?us-ascii?Q?rKJHfGzfeAFazuoszVp5I4rRth8YBg7PAoANR6x8ULvvfr9EugwIC+Gepfgh?=
 =?us-ascii?Q?5ot/wkJRBAs98eyvi+FdOf4FIzkxf44pv7cp8FcE/yazjTClNMGQ0FkNbDC+?=
 =?us-ascii?Q?uxsRhoSEjTMosOxalfiheX/4QLB3+d+VKvGzbfQCRqpphNlOqA8Xu6lj9Ucx?=
 =?us-ascii?Q?tFkaE7WUA1DKwWy9Qtl3I4+ImKQWS9hI3bAhRZPwvkEDAnQXbBRu0y8wy5IL?=
 =?us-ascii?Q?rSqqYyIaHUtxx3oBNPb5ZIt+NBEcaAeBhB214uz96FoX5Dri5xu1DDVlr6wC?=
 =?us-ascii?Q?KzOpVPnLPrG3C1p5dDQtKaatGZRow7FPW76ApGAWooz45rRCQpYF3UAmj7Pq?=
 =?us-ascii?Q?UjPr3/JwBQ/kUNTdKKITb9j8GHee8qyfqXXeejlzPDDcwF9ZCcSG29Yyvtzb?=
 =?us-ascii?Q?1SZj5UgRHZ/MelkK2QIXidRNdS/UCrYc5ExEYdDsj4M5v4I/CEPXXBsvsUN+?=
 =?us-ascii?Q?FQxsgCu4kcW5hu2bfVFDTI00PC1rND+NldDDnd5YjC9e0hOaYlxhXu79vO+m?=
 =?us-ascii?Q?HVS173a5arUMM1pXEb4aChaCV0fSaGUTT1hA8SCpcpwrZMASK9RXMTcyV3XD?=
 =?us-ascii?Q?mBOXOM2Gkfb9Aa6veB1iVeZRhouVBKEVm6d73nPL4uks1bw0NKNVmYc1IZQU?=
 =?us-ascii?Q?kAjG524b4/MR+mKeNpHPNmovYHbXcH+yy3BNboh2SdnJjHTTgga5heMC2GEC?=
 =?us-ascii?Q?moEx9SGbio0PkpC5V0pufIl1GWJett/pYBRb6opYFz+dx3jfY3VRWf1MoCNd?=
 =?us-ascii?Q?qCOBQCLZ5HP92N/01fdlTpos/f7u6k2IFtU1uNZAJOvfcDM25Ps8cXQnnphF?=
 =?us-ascii?Q?PWa80pMP2PanCzgWgOPFAY2NmULTRcMBkDdxb8K7Qn+Q6hDUs1hfouoXS90o?=
 =?us-ascii?Q?NvnBpZMFCx7d5PW9pS0oenlKkmBkTKYYouCuRqLfx1l/2XfgtRyRFh3T+twf?=
 =?us-ascii?Q?M41j+C1zsLmp1ZIJxq2mcGQaISImyLnXgJBOwe4yUxx4+X/KkAPSIx3gZbEv?=
 =?us-ascii?Q?MGYcJO2hHkhonUjwxSZVufVA9rMxhDnY5hPSfAZ6C7GCLG2cv39C2eMCa81H?=
 =?us-ascii?Q?IIroKjZIWZrW0syu6hHJ6j7hZFDvcs7nbqdU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:07:34.5175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3b1a8c-7fd6-481f-ea82-08dd8f0b3a83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790

This series is the first part of adding support for CXL address
translation. It contains cleanup and code refactoring in preparation
of the actual implementation that will be sent in part 2. Cleanup and
code refactoring have been split in a separate series to reduce the
number of patches of the series. Even without address translation on
top this rework improves esp. the region code, cleans it up,
simplifies it and adds debugging messages to better analyze region
creation failures:

Content of patches:

 * Patches 1: Remove else after return.

 * Patches 2-3: Cleanups and comments around cxl_hdm_decode_init().

 * Patches 4-6: Adding and modifying helper functions.

 * Patches 7-11: Refactoring of endpoint decoder setup and cxl_find*()
   including cleanup helpers.

 * Patches 12-14: Adding and modifying debug messages.

v6:
 * added tags to SOB chain,
 * added more occurences to remove-else-after-return (Alison),
 * updated description of cxl_port_pick_region_decoder() (Fabio),

v5:
 * added tags to SOB chain,
 * made comment a oneliner in cxl_hdm_decode_init() (Jonathan),
 * updated patch description introducing parent_port_of() (Fabio),
 * removed EXPORT_SYMBOL_NS_GPL() of function parent_port_of() (Dan),
 * renamed functions to cxl_port_pick_region_decoder() and
   cxl_rr_assign_decoder(), updated descriptions (Dan),
 * added patch to replace put_cxl_root() by a cleanup helper,
 * using __free() for reference counting of cxl_find_*() functions,
   added cleanup helpers (Dan),
 * dropped patch adding CFMWS memory log messages (Dan),

v4:
 * rebased onto cxl/next, commit 0a14566be090 ("cxl/Documentation:
   Remove 'mixed' from sysfs mode doc"),
 * added tags to SOB chain,
 * reworked comments in cxl_hdm_decode_init() (dropped moving comment
   and updated patch that modifies comments) (Jonathan),
 * reworded patch description that removes duplicate call of
   cxl_find_decoder_early() (Jonathan),
 * moved some patches out of this rework and cleanup series (Dave,
   Jonathan),

v3:
 * added tags to SOB chain,
 * fixed NULL pointer dereference in cxl_find_root_decoder() (Alison),
 * updated subject line of patches that add kernel messages and
   included example log messages (Alison),

v2:
 * rebased onto cxl/next,
 * added tags to SOB chain,
 * move patches with cleanups and refactoring into this separate
   series (Dave),
 * added patch "cxl/acpi: Unify CFMWS memory log messages with SRAT
   messages" to improve CFMWS log messages,
 * renamed endpoint decoder functions to cxl_endpoint_decoder_*() (Li),
 * reworded patch description that moves find_cxl_root() and reworks
   cxl_find_root_decoder() (Terry),
 * small changes to cxl_find_root_decoder()/
   cxl_endpoint_decoder_initialize() (Jonanthan),
 * updated comment in cxl_port_find_switch_decoder() (Ben),
 * cxl_endpoint_decoder_initialize(): Simplify variable declaration
   (Jonathan, Ben),
 * cxl_find_decoder_early(): Added comment on function usage (Gregory),
 * reordered patches and reworded some of the subject for a better
   structure.

Robert Richter (14):
  cxl: Remove else after return
  cxl/pci: Moving code in cxl_hdm_decode_init()
  cxl/pci: Add comments to cxl_hdm_decode_init()
  cxl: Introduce parent_port_of() helper
  cxl/region: Rename function to cxl_port_pick_region_decoder()
  cxl/region: Avoid duplicate call of cxl_port_pick_region_decoder()
  cxl/region: Move find_cxl_root() to cxl_add_to_region()
  cxl/port: Replace put_cxl_root() by a cleanup helper
  cxl/region: Factor out code to find the root decoder
  cxl/region: Factor out code to find a root decoder's region
  cxl/region: Add function to find a port's switch decoder by range
  cxl/region: Add a dev_warn() on registration failure
  cxl/region: Add a dev_err() on missing target list entries
  cxl: Add a dev_dbg() when a decoder was added to a port

 drivers/cxl/acpi.c        |  10 ++-
 drivers/cxl/core/cdat.c   |   2 +-
 drivers/cxl/core/hdm.c    |   3 +-
 drivers/cxl/core/memdev.c |   4 +-
 drivers/cxl/core/pci.c    |  48 +++++++----
 drivers/cxl/core/port.c   |  23 ++---
 drivers/cxl/core/region.c | 177 +++++++++++++++++++++++---------------
 drivers/cxl/cxl.h         |  13 +--
 drivers/cxl/port.c        |  15 +---
 9 files changed, 173 insertions(+), 122 deletions(-)


base-commit: 8e62ba590160f91abba6490d9c17aa13bada4752
-- 
2.39.5

