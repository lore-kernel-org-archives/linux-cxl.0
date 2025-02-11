Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD53C1EF092;
	Tue, 11 Feb 2025 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267663; cv=fail; b=FB5HTP3OMjQSw6yslS46+jnUjTwZe/LrGPhKYeS43JLLCjVfK3JHWKwW++F4/Dzxu4ZYk0DN2nWa9Dj7b8nmciCbddoCnu1vMXoByuwLWYYcG4wnQvdPuLVGVeuhqt5u3aBMe0TcqeIJHRS72/x73rEwKdNl/laYfoLGkYMfkbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267663; c=relaxed/simple;
	bh=cI0+wZSRY4pb8s2dzZ5VZPrThgHg/mZM2wV+izLLGDY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EqRbhq+49zBVvu0CcZ9xNt0fo62w9pnu40SA4qGGJwZqUtdE458LqV4rRPKWfqFMjWN42tqZP/yr5k0pDjTWwiL0R368ZsXa7QHvAXWoamUGSXSl6Y20hMhu05nS+M23NT2NgwOv+fCdRY0P4oKOYKV9AIzlmV5M2syXPDpG63k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BncGMRG0; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BncGMRG0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7bTC64tJDEza4sce3AePRn38sdGINfYjcZik4swgg/vFFZaHKe76R5/KEUVYYTS5gDzZDQwi01os8nbIO4jJWYT9wEuG0sK+r0Ulnz+WJ99wirF6hinscr6rg3JOKLLYMPiLhNb/ApUHtlU0f9Q/RJpH+zQDOPTKNum1LuWjyrtCREADKp8JHM2DHT5kYK2L1TTZ52JFnJYvsD04F8ozNXz++u2F7y6/8kI6xTtRJCio9KxnWoMq1R+cmo1MbSNJuou16mWOVLF2aOuQ+O9ZGzQU2Adq6m4n8HLkY00v25taFT6qRqkNR+sNLuGgVbGOgxy8I9oSRLlyvN8BWFuuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpnvKrfFIhUaduZ/GV8tLVUSv2+r0EXytAMw8y0W8bY=;
 b=S2vqt+6Iozjd3ZdCON7lHn/HxklPC87J3Riz40vAlY5iOg3SgSzf5vIYsDhGgL5lcK9srUpiYefzULcfezhnc4YmK2QOsqs0Xw6rGH22d27YyEdQGVEA99fyEonkZV3IpZvIWiSnlTBnIK6j42O3ZWXV7nGtP4ZgK0s8meh30MhD/8CmxEIh2PFPHL+xPdAH4CVoqT+Ck7CWOsq3X0X7HvWiG3jFj7C0Eywp7EAOuYfSVKaPBKyuGAdj9lBfd4BOC8phGPdMKhWcXOICX646sDfzUmCQR6W19lM3An1VdISNBdc1D9Q/4+CmwN8e2Nw1pThTiBtztxRES5Ss3eLxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpnvKrfFIhUaduZ/GV8tLVUSv2+r0EXytAMw8y0W8bY=;
 b=BncGMRG0En1+8zaGxkv548cF6TmMmEB/rqSgXmWszWNJ1ZwuAZm2ghjP08Yq5zNaWYCYZLCp93VlUlmUl9Cd3m1TdLFNMrU0EU6nOjr3R3HveTrurplCC3VFpZvaWOSmrXrpCggFP5K2+CXMMzu6ekTeUImdS4eUYuR90IbPBuM=
Received: from MN0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::10)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 09:54:16 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::e3) by MN0P220CA0017.outlook.office365.com
 (2603:10b6:208:52e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.11 via Frontend Transport; Tue,
 11 Feb 2025 09:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 09:54:16 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:54:12 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 00/18] cxl: Address translation support, part 1: Cleanups and refactoring
Date: Tue, 11 Feb 2025 10:53:30 +0100
Message-ID: <20250211095349.981096-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: f774f90c-eb63-4e21-705a-08dd4a820c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n0BKAEHVTFNgnY9jVnr2UuS4ItCZVURHJH841GHohATaU63f2zNUPXnLXqKO?=
 =?us-ascii?Q?mi1bF/xryzmYCZCa2/PvVF34Igc645W4hqJVMS+2R3weJcjVkrYYGwjA9bgN?=
 =?us-ascii?Q?pIKAMfZsFZo37B9bXLd7rn8jDg8YP5wpNc4UWe13TXeqxEuaKfhcag9e+a/x?=
 =?us-ascii?Q?HKJp56ryVJxZmdsSerDkrozB3EL+y2E9H/iahdkchpTMhfuOVIiXbi5JPrI6?=
 =?us-ascii?Q?IrJVaclQ5y00brq++fJX5Ez3/JIc+RVjvVjVQmQXk54YfolrVaKxaJxGlK9q?=
 =?us-ascii?Q?ECWwFnLVXGS44nlqrxcCwdvZ41jrsH6ACB70hSrrfSrDfUZV28wmQG9sjZka?=
 =?us-ascii?Q?1wNrNP+mxGIn5h0O/ky39pc2BfqorBv3EKYSZ/rXEFJxFKjwOc4IGns3R3ew?=
 =?us-ascii?Q?yYjkdSwGrdyvSrcbEFQngqnqXWuHzu0TeWTMIBePEMEhrZbbVD0/r/NBKlJx?=
 =?us-ascii?Q?BZK7oR7aokvdk4cor32bm5EI2Kvkt0VDbnLB4nJCK9kII7DB8LkgMW2+cAK4?=
 =?us-ascii?Q?RL+FxqXQu52CuwzNqX/m5niUUNNlrzIXh5UeInarbm7oBK2wRpgUgJ2LS99y?=
 =?us-ascii?Q?cw8W3kI/xVAz/hKTRNbGrEbVfdd4zY2p/YVM6GSxbHtuYLSDWhKJ9ne17hgx?=
 =?us-ascii?Q?e894UIBPmg00YXD/qi/CS7Jz7paKWnCQOvxJFCgbBVuLTRc4pzLNzEIRLm5H?=
 =?us-ascii?Q?SAppgagUZM3v2VpjJ+L+j016wwfUr1a78yYb+hPeomgFTrrsYBP2YY7p76fX?=
 =?us-ascii?Q?hb69Kol1Mc8ZntDVdb/aHlhSXmQk/fKXwWLFJSSlr/AozEyu9W/1Ky9Mmn+H?=
 =?us-ascii?Q?oojQkile8cGaPmXAMcevBh3be0+7+61HZEa42fEavCdW1mgOEyZGieLax6Oi?=
 =?us-ascii?Q?E2awOO7rqLnnt0CHdyw4NiiowiwwO4dZsdYo849/5WzuFeprVpstsohtK++n?=
 =?us-ascii?Q?WHuyRWQm5OkUns5jxp3mzIKFXEPHKjtjfSrHaymH9ivYtZRT3YSKKRdjtEKE?=
 =?us-ascii?Q?XjYSVSIba0kk1nqKVC/K+yvjH9oT6gbyk0SPpKaGmT10699LXqkojlDywfGu?=
 =?us-ascii?Q?1p7CCMCnkkoN5yksLslUWz8yXpI26j6GpOb6o63yy+37yEGj+Usczqucs/MO?=
 =?us-ascii?Q?gP8lvQKKu1nTaM9DMYo8AkiQ6ecLxISuGMMD2Od7AHh0Vber+1mzYyMf5IOx?=
 =?us-ascii?Q?/FIfS4BnU5RNezHLlX7bgACyhDVb+Ss/vAYOyLbv/Vh8xYXSstzNn1DyIMLi?=
 =?us-ascii?Q?nGGlcGILyv974vDddlzvVmZ2OWyB8batamHWYi6oNRlUCdOZPF8jaJTWoY2j?=
 =?us-ascii?Q?hJGUkY+Fpls3lZi13xD9KHUNvhfXDKTJ2XiDJCqkKafY1kxtFSwknHcxtqyc?=
 =?us-ascii?Q?zen91PBw2muIgF/TbdtBVvgIbN2nTxQylpUcI8eW7++XHZpMBB7Bgc5F1NTj?=
 =?us-ascii?Q?PlAi6x5uYQmKyiHKkLavQjhu7k/HnE4iBF+TKqqN44lmg6u1RBwWl6wa35Mo?=
 =?us-ascii?Q?9t/Vm3IH4MAcDlk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:54:16.2697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f774f90c-eb63-4e21-705a-08dd4a820c01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972

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

 * Patches 2-4: Cleanups and comments around cxl_hdm_decode_init().

 * Patches 5, 6, 13: Adding and modifying helper functions.

 * Patches 7-12, 14: Refactoring of endpoint decoder setup.

 * Patches 15-18: Adding and modifying debug messages.

Most of the patches were part of my first submission of v1 [1], some
of them were already reviewed.

[1] https://lore.kernel.org/linux-cxl/20250107141015.3367194-1-rrichter@amd.com/

v3:
 * added tags to SOB chain,
 * fixed NULL pointer dereference in cxl_find_root_decoder() (Alison),
 * updated subject line of patches that add kernel messages and
   included example log messages (Alison),

V2:
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

Robert Richter (18):
  cxl: Remove else after return
  cxl/pci: Moving code in cxl_hdm_decode_init()
  cxl/pci: cxl_hdm_decode_init: Move comment
  cxl/pci: Add comments to cxl_hdm_decode_init()
  cxl: Introduce parent_port_of() helper
  cxl/region: Rename function to cxl_find_decoder_early()
  cxl/region: Avoid duplicate call of cxl_find_decoder_early()
  cxl/region: Move find_cxl_root() to cxl_add_to_region()
  cxl/region: Factor out code to find the root decoder
  cxl/region: Factor out code to find a root decoder's region
  cxl/region: Split region registration into an initialization and
    adding part
  cxl/region: Use iterator to find the root port in
    cxl_find_root_decoder()
  cxl/region: Add function to find a port's switch decoder by range
  cxl/region: Unfold cxl_find_root_decoder() into
    cxl_endpoint_decoder_initialize()
  cxl/region: Add a dev_warn() on registration failure
  cxl/region: Add a dev_err() on missing target list entries
  cxl: Add a dev_dbg() when a decoder was added to a port
  cxl/acpi: Unify CFMWS memory log messages with SRAT messages

 drivers/cxl/acpi.c        |  12 ++-
 drivers/cxl/core/cdat.c   |   2 +-
 drivers/cxl/core/hdm.c    |   3 +-
 drivers/cxl/core/pci.c    |  44 +++++----
 drivers/cxl/core/port.c   |  15 +--
 drivers/cxl/core/region.c | 190 +++++++++++++++++++++++++-------------
 drivers/cxl/cxl.h         |   9 +-
 drivers/cxl/port.c        |  22 ++---
 8 files changed, 187 insertions(+), 110 deletions(-)


base-commit: 5585e342e8d38cc598279bdb87f235f8b954dd5a
-- 
2.39.5

