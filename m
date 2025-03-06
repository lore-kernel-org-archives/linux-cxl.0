Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6743B253359;
	Thu,  6 Mar 2025 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279513; cv=fail; b=neW+I6zQ9w1RmN2vkKfJCwOCxOa4kMN4sJ3eC+LONhAU1dsvF8XaZYx4qPuXRXuJ6H0VY1hmzU+keyCHvaKzRy7HDOHUU/9sECsbPqnY9KJyAdEYFhUnimqVotoQsdCss8glSsXUcX0cwEHKgWON3lhPtSGfFmkMQa7Blz9ZOas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279513; c=relaxed/simple;
	bh=YBxh+N74E6KC7Wi5TsJ1AN0FnRgBmAVkIVG/S0T+t4M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qyo0dDNQgNFFrF1dyPVHg2yDwKOHKk+vMBXFBPPSprOQvhywGsyAXxtTfQkleMIt8BQMiXZvTjJblefNXT6YuYDrsAHc6OVk9YpB5sebjybCnCCuaTRygnTiHIm/KQ+7HGtEUhTexfgCIcn4cK7PlJ9K3zy89BMiZxgmMWOysNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dj2holZM; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dj2holZM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jujIKUsW6Pttr2P9xyLmi46v6Oz6bYmo2T1m/rrCOWyFzhUl3l+Jk5UPke4Vyy9OGxVMoB0FakRVFDi5h7qJgr0EHlRY36mLBQHm5to9f4PEkL3xM6XSYUSF+IYDSfZDR/m48og24Bl83z1qbxfPJCxEb9x5Gfabcl/TOevgrd/7ia+P/5uY+OK3ejMimYuevZ6VIMxGFi/7CFtP5hnT2Jtja4FzOyft9VmBIVwmXjUfhF9fqJ79fqbu2w0XKYYL26dQlMdrFD3+f+yH8Ck1jd02F9+LN0FuqrL4e2jDpvZJhU0AH/klRHaTKNeDeoKeEJ7qgHuSDfSV6KfeqgFF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUxjHOvKj93M/9erOpo9vcv6ejWZTUBW/t83C/jDXqw=;
 b=IM/AiU5D8Qk18qy4NTLNA1mASE7d60k+HGsCJ4StvRa2jqhgbrcIdfl3fB3zSfuN4BLRyCo7A99xlHqiVQ6VG4xnURSxv4bs0JF7n4c8k0lpFpDg5NG3Pqcd1L5nVDHXAhtP0zxn6FWBYXcLXFPUq3+ke23MG2DQOvJhHsRiHr7kcAxfEsTA3PS1KsFdSAxfm7g2kvjntCNr1UNZWyLh3X5CzG2+aVpVgAI3wdvf8REmLXzV5bGdX83oGdSg9uslyCEvrbzXUg1isGzmfwTAIUQodAyrio6o/JcXjxTZKOvZiwMpT8lA15hYiITY8M2T/T/jfsROT+wHKRP8ha73eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUxjHOvKj93M/9erOpo9vcv6ejWZTUBW/t83C/jDXqw=;
 b=Dj2holZM7ARU4YdUUGLyheKrjtyDGFfgmviSvpnRF9cAhtakDASJYNzogbGNF31WK87OJGWzKtzTB5AwHJRiQ6djH3JqyzeVWmaxHefS3yhCuik1A593Zsa1HTrSLrd/0Sk8waOOCYaxV4rDYQWDJyLCN5aE7+X8ZC3cV3a+5/g=
Received: from BY5PR13CA0024.namprd13.prod.outlook.com (2603:10b6:a03:180::37)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 16:45:07 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::71) by BY5PR13CA0024.outlook.office365.com
 (2603:10b6:a03:180::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15 via Frontend Transport; Thu,
 6 Mar 2025 16:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 16:45:06 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 10:45:03 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 00/14] cxl: Address translation support, part 1: Cleanups and refactoring
Date: Thu, 6 Mar 2025 17:44:34 +0100
Message-ID: <20250306164448.3354845-1-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: c5dedafd-53de-4e20-81c4-08dd5cce4075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LaLaF2/lCT35K0gN43/B2vyxf4qnWoucfkBSe4aKxVj2KHsJeanR0qSjRpdq?=
 =?us-ascii?Q?D735mfxEw3tw5ASQVjbntQ2CPOa0Z+wmRA60rSPkNUKpXCobAz3YibQoBQu3?=
 =?us-ascii?Q?bkmgFY6aporFVZ8fXtVy5O3Ltripe19LDDe/2R9RokjKW4M7G5vMmgzcmzeB?=
 =?us-ascii?Q?0pV/Cza5SlzcqxLTc2TpOj/YL3TzGyzenzANSTpQJjugPasNO5lA/gaANWUw?=
 =?us-ascii?Q?Zam9gExNo6A1cJl4AF4+rsvLnvAU+XM0Kyr1xWsnunMbKpJYYcWCXOD/y1cX?=
 =?us-ascii?Q?O5md+DqOuGz5+/31WPpmWRTNWIWi1lwpBpi+HqqRDytAD5VOHdAaGiI2BTln?=
 =?us-ascii?Q?/j/4e+2+ynogioiJZVWZCC0t2yIGITsxB3aYtbrVrcRVXubxzN7tkeEM3jDe?=
 =?us-ascii?Q?QTt4pjHKx8rhDaygzzaHNO9ytyV9QbDMkk3T9a0WCCJXaRZyLs8cpRRstCm6?=
 =?us-ascii?Q?LFW8C3xYilr//0Rs0K8AQn4Ysw17+nLlGF4NRVQZbnQN3tkj7bqrEVJ4dup6?=
 =?us-ascii?Q?F+Q9C80Q/c45DopvKBwr5SUDPjsKVc2+OOKMAAvZL7MKCGOBtEuV1accrFd8?=
 =?us-ascii?Q?lsIr9pdvi1+B5GJLkS70L1V1nqVbXmkuzafZ5cEbLvndG7KFA4Nvxh0enALa?=
 =?us-ascii?Q?OWJk3w4LHbok6BQwglU3uxTtJH0sStGyepJ2CDdfsRKcuEtDhzG1p82BmhB0?=
 =?us-ascii?Q?Oc7dbELVNTz4m+cKzmY9t7t56KgEUpt4A38z8WK2EgBrngC5HIX/3x5970Jj?=
 =?us-ascii?Q?n2O84RsDoo0img2H0MI7qjlFu2xjBOsyNlMAE/tKO3U5yzaqUqy7XQhtLCaX?=
 =?us-ascii?Q?M9rOrYBERwL+1XuWE49mTqvAJu3gNcdTMgkMnQhClq2Op50Qn3KB6U+8J7zC?=
 =?us-ascii?Q?M8rwH7MNWXCKYgCHTOOG52l1EPjttuQT0gvkxF/oW6Y+koLHh8gBMSbS1Z2u?=
 =?us-ascii?Q?nt9DNCWwndGnkJyaVPToFYH3dkrMQ5g/o69Kak3R+5VRpmR9f4nPWdrhd1Pm?=
 =?us-ascii?Q?HZQu+KHW41Rusl9CJq0a8nVQiXUxdFsgExTus3W+351QDW2VtGC4Dn2thMCm?=
 =?us-ascii?Q?UThxBBobcXWECWQijmpa1gP1nzcTJ2BrhUKkpx21Ycxgk8LU8k0PLA5YIKLc?=
 =?us-ascii?Q?15iEFVzQvm1gHBbEgDx26G906h6I/4muOBBuzaEdrD+0n1cs60yDpNSNc7wk?=
 =?us-ascii?Q?BUrrFqSHKmEOYZes3iNIvNvz1rWDVCFprkubsg/ZzP/rKhDXycW9+T+d/wQV?=
 =?us-ascii?Q?GJX41P3/BnyFaE8gVG5y38FJyzpKdOkcuibvFhxJqf21uV/RYmA+gNSfXN5g?=
 =?us-ascii?Q?EJ41sCf48DylPLgI46etACvJo/OplrEQ+Q4ehZqle4TS39tA/6pXG/icMq3V?=
 =?us-ascii?Q?m0AKHQkZDHJ6XE2hJFQ9UxsBVV8TkC/EbuxJgiYtTWeef3Dkqxyqto7OhDUh?=
 =?us-ascii?Q?iDzcJU8L1CZur1aaoDSzVO+pK9PT1Wi9W2K8Tn7L894ScDxldH0R+rzAoO/0?=
 =?us-ascii?Q?oPqm5JHbBjFziL4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:45:06.9220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5dedafd-53de-4e20-81c4-08dd5cce4075
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966

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

 * Patches 4, 5: Adding and modifying helper functions.

 * Patches 6-10: Refactoring of endpoint decoder setup.

 * Patches 11-14: Adding and modifying debug messages.

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
  cxl/region: Rename function to cxl_find_decoder_early()
  cxl/region: Avoid duplicate call of cxl_find_decoder_early()
  cxl/region: Move find_cxl_root() to cxl_add_to_region()
  cxl/region: Factor out code to find the root decoder
  cxl/region: Factor out code to find a root decoder's region
  cxl/region: Add function to find a port's switch decoder by range
  cxl/region: Add a dev_warn() on registration failure
  cxl/region: Add a dev_err() on missing target list entries
  cxl: Add a dev_dbg() when a decoder was added to a port
  cxl/acpi: Unify CFMWS memory log messages with SRAT messages

 drivers/cxl/acpi.c        |  12 ++-
 drivers/cxl/core/cdat.c   |   2 +-
 drivers/cxl/core/hdm.c    |   3 +-
 drivers/cxl/core/pci.c    |  50 +++++++----
 drivers/cxl/core/port.c   |  15 ++--
 drivers/cxl/core/region.c | 170 +++++++++++++++++++++++++-------------
 drivers/cxl/cxl.h         |   7 +-
 drivers/cxl/port.c        |  15 +---
 8 files changed, 172 insertions(+), 102 deletions(-)


base-commit: 0a14566be090ca51a32ebdd8a8e21678062dac08
-- 
2.39.5

