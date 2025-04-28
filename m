Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FF820E6EC;
	Mon, 28 Apr 2025 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876620; cv=fail; b=RMnkEpEufnRRRymG08kh2vMO3hrg//h6DDOkYYv7/BpW2SgWQjpcXL8SbcIrxLFrEkayWT2dnhvSbnv2PQvARxX5kcGzea0n02u7Ppf32FJzvtNtLBFHgjhspH4u43/pXy+PqHtlGY9K30xON6SEVTBzoaRbxRX5RPRYDI4kqAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876620; c=relaxed/simple;
	bh=K1h/aiUp5QCpDW4B9cE03j0gcBejGJ4Go0yIK0XPmwQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tg8G9IhBdJhWZdi9EH8llhNPKv7AZNNEeGsdlfSLKm+ilFtXOXL8UDUtdoak9b110sBJ7UnhEgssDFy8T9KHvSTx2qrSHXaxy4mDDkMtezfMIPe5SIvzjkRvmS5OM3E7MZF93UdkOpx+TxGOtSgxZiyo17ZI7uAvJjQZUjVo8xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yAoA0YCH; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yAoA0YCH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dn4RPPJseVaKE12xNZklt0OoBhAJ0Xo3PGukuPLMKgyHrLMNJ2826p85Yo/Xus/S40p1v70BYMVU3jEAPpLFaLtaLuU7Op8nZ1EVwpAECu4W8BNVOM0TXT+wA3ziWGlaJfb5qv9OCoGvnwVqozIvrgR2rpW64FKwUptJWa61LmoxpIhvpUPilLPOFzlWVdVHipaMSm9CW+2Q/navX4jF2VBWL9xKO/7/Yxy/jNxIjgAefjbFxGNnmh6ZGjG3f5kbjiqy+5u1gKBf4g0z8KkQwBc4E5b/14SclrerqyeEeFl2A38lx+/jqJ0yoNXkr8yPCIjsvwPnUWwMQdRkLIyepA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+G27S6yfvXh9WgHOl6w3hWKgq/T/GpFJmmYKx5L5yGU=;
 b=BAahBp+zC9icvlqf9yzdXn2jsQAZJiFq81MOLA5yyCBu390ClZ3xG9mR7hzxkt6ADvp3Vv8o+VAVIhzzivI7Cdf1avPFT399Wo6J9WlcH1NB44M8XcbU74ULlQ1usfLRr5ec+IxdVq5pVln/AlaNYOyZdrS/3DS0xtAgBEWr/Mvj83/xIQSRZRXRRv2JsggmXG/fDqcil1iT5LcuG1TJQk+Jma6gkaA6igm22Ew/wfwfru4x6CNMFT8a4v6nsP7Xc418TRciJnurcH2MnsNXakeflezqAJ7WPvtl9+mdTLNosKEpmd+XRtSN1t/j4VOTv4j5Kzeo19rZnrdbmKQ33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+G27S6yfvXh9WgHOl6w3hWKgq/T/GpFJmmYKx5L5yGU=;
 b=yAoA0YCH+kseDW+lqU/i4KgPSVfOkkzf+Q5xBr11EE/vJHE4BQOgkfs8pH5HKclockdJ+fTDAsoNfnseZoBuGUXRPq4yfR1mITF9h3aKQguLsc0WpLWoL8D5fwg8n7dIY6nGRYFF3sYjJEpOtR1F7wLmHq5jgNeZLfV1nO7qnBg=
Received: from BY3PR10CA0027.namprd10.prod.outlook.com (2603:10b6:a03:255::32)
 by DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 21:43:36 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::1f) by BY3PR10CA0027.outlook.office365.com
 (2603:10b6:a03:255::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Mon,
 28 Apr 2025 21:43:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:43:35 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:43:30 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 00/14] cxl: Address translation support, part 1: Cleanups and refactoring
Date: Mon, 28 Apr 2025 23:43:03 +0200
Message-ID: <20250428214318.1682212-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|DM4PR12MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: b265da50-982b-4e93-3f7b-08dd869dbab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BzBpTThgJt/boN37zjzkvnTjiHumwn74OWaHsrcVbAOPGD2xu5OVhHUFZagt?=
 =?us-ascii?Q?vmeDX052ZZYlaVbQ88rlShudTn3qBsO8iuNDsghuP/yIXq6bgDEVXs2/4J9w?=
 =?us-ascii?Q?WvcBPpfjcWTPo6jS+GtslsNvifrLBo2V1b7T082OJi5KuLW5elS+lwMG6k6o?=
 =?us-ascii?Q?lthrRf5BhNOnKLgOztpD7R5e4WFDtHUpOib2InYwCmekQrFLYEOCgL3ml/FH?=
 =?us-ascii?Q?tzTfwn+O+B5D9nLWDaXH2JP3Ufg4PAwLqyAsGyxW1XGBCuj+p8/vkabR5Ghs?=
 =?us-ascii?Q?2U1XOtlJFqazXgxyDCCySJHN5ZijlIJmYo5ETdIv0UR8MwbpeJ55uM6nXWPZ?=
 =?us-ascii?Q?IQrtR9k3p2PH6Hx/tm8vsVEpzhtHeFuIYZHDkVBVlk43J9NlI1U2IgjQnNzK?=
 =?us-ascii?Q?NF+IJhUwBCZpKfgEKGJdP16idHRNhbsFwoMcUjptFHh+CD2RIwjFJJ4v016V?=
 =?us-ascii?Q?G59A1V1tFrIsN7QMmuqMfrlr/IL8qbyd3k9Iag5Y7x1vi1OZsVR6xbOHOFrn?=
 =?us-ascii?Q?JVWHMU2KbH5A1/18EpyVM8n83ze7vA4L1AvzUq4YXf6FAEStNHBBZBTnVaG3?=
 =?us-ascii?Q?v1x0rxfPJ6VEN7mZX/HoEp0FFPZL9/bScxrpy1Im2lgHFDsDldmsPMFJEQbt?=
 =?us-ascii?Q?D57pxT/oiZuVTgB/ce2gvtpjGuhVZkUTt2j8ZjTEo5CH6nkgI6XZYP5CfI6L?=
 =?us-ascii?Q?udhmgd4XkQ5lRtFzA0D7FWRBdK9k7bhzohhULGc0l4MiUFcSsQXT5Cd/Ons9?=
 =?us-ascii?Q?VLFD3cwiiEJQPZKXw+e4fNYvV+/a6XIuRSQN9BAZulceVUNl0sNhAZinnl2h?=
 =?us-ascii?Q?N1R+4riMaTWqhlwZhaPNxL4eb6Gm4vxDJu4RsJNRP5GFt2HLd37bNE3xOPas?=
 =?us-ascii?Q?DQvtHaFV3bNx2ketCf0/ruowLhFGUvdxxdhHeIt+EKh4uUIeCSbWgoPnB7H8?=
 =?us-ascii?Q?6x02shj5xdYQZ1KzEtTCG8gWT8+80rMIaBkjJhjr7WgDBHdfGlR3PvbuhiPx?=
 =?us-ascii?Q?jY2hu+iCsscxxY2fw7WENpIsNkxSSncqdrqz6ncwGPEwRvbPC1HjHKA2Y0+C?=
 =?us-ascii?Q?aObMm2I2sfvqgZ+RW6wxX1+VvqRDXXMkOTvaSuvkx26JTpKTwQ3HBhqBV65U?=
 =?us-ascii?Q?tVnDzlmhmqZFbzwuXnOJLYfmcVEiKliFn/S2LzN/AdywsP1gje7mvBZ1fBoU?=
 =?us-ascii?Q?HF+Cw9o7Xpdjd1rk5zPA4DAZw9z1NGt2czV5iBjl9Q8OTdmNfjLawZP0qUXP?=
 =?us-ascii?Q?FVxHgFFeU2LOgPhLPeMwppeoh4nLMrhYHxtFx3z6o9BCFnn3GINwhuKglzFt?=
 =?us-ascii?Q?AqsVI/S7Ks+zCdQhv8zyOj4lC7oDaYQY/OLFK8pnCjJJYm9OnOeAjl4+jJ6R?=
 =?us-ascii?Q?4vQwNTS0anJgjCZwvZWe2EbVC5OIZxvNBf34CXZ3i07YD2cWM475A4j/oSAi?=
 =?us-ascii?Q?aUDxKYmOqsNnqQO8vdRXKlb4NlUyK2L8OBdQ78y7rG1J8gbQ1c8rXgiDF4ry?=
 =?us-ascii?Q?RmhHKTvrdsOluPHXWD4KAnRAJQ4TGdvvQgbj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:43:35.5474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b265da50-982b-4e93-3f7b-08dd869dbab7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375

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
 drivers/cxl/core/pci.c    |  48 +++++++----
 drivers/cxl/core/port.c   |  23 ++---
 drivers/cxl/core/region.c | 172 ++++++++++++++++++++++++--------------
 drivers/cxl/cxl.h         |  13 +--
 drivers/cxl/port.c        |  15 +---
 8 files changed, 170 insertions(+), 116 deletions(-)

-- 
2.39.5

