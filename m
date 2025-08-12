Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DDA2D6E4A
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034194; cv=fail; b=UXkBRm6W3SKWjDjYmuEi80yoU0R0Q82kE0d4FVtVRY+DJQkpYVmPo8x24WiIl2c2g6ZmQ4PRcnK9RNtqI+5qVDL1XMFIwmM9/PBD3nDuhJwFqdUsBk7rIsqHWZKtVQ0imOXlQE6x/i8lWOEs9CFj23Coy9XlEk01Ul9dblMqt9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034194; c=relaxed/simple;
	bh=ZvZH2RaNPWMPRuLQNH4vyK8aiK7gQYciFFLxkV0LPsg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FoD0U2FygQlC6q6fkv0M4+759vG2/63wOYlkLopwn52QLPd+2JvibtIpnJNJXst/Xmy4FvMeG4fDnL85uPXQkleqyhMWrN8ARnzfB7cun93Mn9vcH6Lk7SRcehiWhhoNu/B0GQ615CtIWFY5LXaUbLtuJxt5DJapp0J64gfqVGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iViZjDgs; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iViZjDgs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPO5VM3P4MU8B7obYRNjA1ALYfjXE4uxxcj7Vq4FmV//aYqzSIS5ZcxYiAfTwAnWgnYY0OIm2dxFrEl+rxIttASQnQh9sVrrzCWQUlis11aHIDs5an2DwS5hZ8Xkg+m16T2z/fIOzgMZuY7VbSVQRVCGpDmkk8FQPZvaFtUXkCm41cS/R9YcGdE5jsir45QTGKM5hG66Chp6+9hxvVRDiE/Dehg0wKNz4yjmO5+swJzpNvJcGW+KQGEmRcOmykeWbwsHNZ+w2p/dRYz6e2oBtmHZ8pFOW/hOI63adnQaZi5EWTB3C6SIhc570YF2tqrGbkjumk0rCMrKGfXg5x6sjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6camLMFuZL48iku4eWYqPi4RqaBsT1oKX2N1OghH8jY=;
 b=n3w9L/bNevZ9SVV+CkHWJr9rvEvLCcnI9ICz9eVdUw0j8ocazrVxXi89FdS/mbMGlCSQwoxvsW7hcMmyJaQiiVQ0Dhb2RkK0qX23Aeh7evpy5Tww9WeI+2ad9tge0H5cZFcZbzMU1w8YpFEPIoSjxUpDrwQnmIMaqrF10cR4y4LnBiv8YN1laihU91F1hSCJKeG9PrC+whihO7WjWBXMFQl5CHDwyQeQaRElQj1B2KU35WabfavCZ+yBOT7V17GLGesGvhoULZ9b7Qw/00b2y2UyrFjBjPESdBBLxZh5sSMPIPfe3o/5bgnKnXc1JZ519DDaNysIH9A2YE1UXFLq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6camLMFuZL48iku4eWYqPi4RqaBsT1oKX2N1OghH8jY=;
 b=iViZjDgsshWUqg85q0Mx40fx51d0c3k+ZwE1xJCkPTNE/evRhF9kmeL0ygI90N97oJxfYfbuDXpX+mMokCOyQoTIdWY4a5yOya7LslVBCjmlexTpuCQRRkN5WhBJuZavqIaRqwDRkvc+qvlM03/VqpQgW7OffLiKQfu+Km+3SFA=
Received: from DM6PR13CA0010.namprd13.prod.outlook.com (2603:10b6:5:bc::23) by
 DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.13; Tue, 12 Aug 2025 21:29:49 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::4f) by DM6PR13CA0010.outlook.office365.com
 (2603:10b6:5:bc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.12 via Frontend Transport; Tue,
 12 Aug 2025 21:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 21:29:49 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 16:29:48 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [RFC PATCH 00/18] Initial CXL.cache device support
Date: Tue, 12 Aug 2025 16:29:03 -0500
Message-ID: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 227a1f98-5876-434a-266d-08ddd9e75e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?39Iuiohp7N2D1hOZEbAS42LspWF1yLcOw7WnsnqtW+me1/gKDhlf2Hg+G2g0?=
 =?us-ascii?Q?IHvq44rAXWp1lpEjnheloaaIryccNL4Y0p+xIVEuUv8j4rlQUqhdjazbRVn2?=
 =?us-ascii?Q?sY60faxPFiTE+yMKdFAokYHE9zNSuMMSu5R1ck2G719vYZyD4Cb0gVcvoSeK?=
 =?us-ascii?Q?i5eh6K9VaIn80lbdcX7yDCntpG4FOLLy11JLwLqxw2ONT2PE20hs4WfpqYXC?=
 =?us-ascii?Q?0qNKsw4dEdCnoDBWPlDAU+i5zQpWwfxAsB/T3ozvvJZh14gPUej9+l+3qfmz?=
 =?us-ascii?Q?zO9kwwFwWR33If19fmJp006InzsvwT5BIgJ3jsb5keg3hho2xnHZX5Kx47EN?=
 =?us-ascii?Q?drmqp5iMlb0q6GDNqVtGMVLzN4i1Ku0E5jFudnlV2r0EVQG4k9RQ0suYTYzc?=
 =?us-ascii?Q?b4OkbTePnAa6/LV2srA0XjSUje0fvY1KOjfHZa3Q4Y09gXuYqToD5afrN+RC?=
 =?us-ascii?Q?i3v4TNAodt1/BKxzHdgiGSLST5U3PrL/Aq2qJ491e31ubZG9Mlnhfp0Wf/iF?=
 =?us-ascii?Q?+1q++bzTjrUzi/3e5bADnGmgv+hKc02XDDUZu2f4LQiiHlguuCQOoApiwIz4?=
 =?us-ascii?Q?esQY9KaqTEnHEpNzxNMN8IODaeTWdi4HtP2yt21dxdlKxp1MgnYWXUkuEvsX?=
 =?us-ascii?Q?VMiqSohp8WbMc4FqPWSlgW7B5tGJ4xduqHIvVDWQV6QGSJLoseaogYDpHJvw?=
 =?us-ascii?Q?11riI/NsgnbxagRgABpy+5Z6aL6yuzQxW1HWKohUl4umIPW8NigPxmavi9Fl?=
 =?us-ascii?Q?Jiwqc8kk4DXnP2dgTVPxq+or/H68a/cfRtH0cVIrIPsH9xObH0rKYB11gj9x?=
 =?us-ascii?Q?3C6RxGhrsyzdu96GYZ8Lj3tl+QPDDY0XD/kgbV0HSNqZ2R4C4BIPj9+5ylvR?=
 =?us-ascii?Q?HpooPkcoSALfZOAwr/tt+rVEXW7zZmy6C/ucPVRfKk6q6yaLnb52YFQGNAML?=
 =?us-ascii?Q?UICHnlYYrFpD6rHcntWi54i3sHgWMLDaSKQzm02BI1xEqp/CjnoeY4slU+ju?=
 =?us-ascii?Q?08axB/QucoG1VVxP61FxvegaF5ciro1aNHlyZ1jpl0vZIXBluJAJBOFN3r5u?=
 =?us-ascii?Q?7Txgz4iry+nmZLulQsB1IecNPHZEbG5EuoVGEwijI63ka0vs8EnGsKYFXGj9?=
 =?us-ascii?Q?mH0mIDeIGnQTEmi2NDwEWPVSmXfcIyE3qRCsIkSentUPf4KoCwcRZhNMsU5T?=
 =?us-ascii?Q?EPu43wBj2jE/Z9MVuFfEENJ0kv+2pAooVAFt0mba9Fido4xmU5mXog9mXDBc?=
 =?us-ascii?Q?HqR1M93p9NUXxrr+sn39p8bJDjh7oHMiJnnEW5SreegDoivg5v2M7zTsOsLj?=
 =?us-ascii?Q?Ep08HCVioh+9SStfaQxpeFBSmc2Qy43aoT6uwy/HYBb8rtLzhfcv1Vs1cT+9?=
 =?us-ascii?Q?zsiSRsxPE1SdAk4GoGvYLO5apZj2vL2GXfKhSDyLZ7cUkrdP9FFngwqUgGN1?=
 =?us-ascii?Q?J7LAckLhzi6WIx1dlxN+IK05/1c5nfPjDIuYHtIYnpGeoNOf8ZeXBwOB2ByL?=
 =?us-ascii?Q?eWj4NSOF1IhV/by1D0mUpQP25Wfvoo2oGX7q+n/lg1rATyA+mJjkgjyRUQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:29:49.5963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 227a1f98-5876-434a-266d-08ddd9e75e27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348

This patch series adds initial CXL.cache support. What I have here only
allows for adding a cache device to the system, programming/validating
the system configuration with respect to cache devices, and some basic
cache reporting/management.

The general philosophy is to have an endpoint/vendor-specific driver
that runs through the same steps of adding a cxl_memdev, but for the
cache portion of the device (both type 1 & 2). Getting cache support for
a CXL device should be as simple as: get cache information, set up the
memory region (see below), and then calling devm_cxl_add_cachedev().

There's a couple of things missing from this set:

1) Missing an endpoint driver

	I plan on submitting a reference driver (type 1 or 2) with v1, I
	figured I'd send out what I have before going much further.

2) Mapping/Reserving host memory used for CXL cache(s)

	I'm thinking this will be handled by the endpoint driver, but I'm
	not sure what mechanism would be used and whether to integrate it
	with the cxl_cache/core. Any thoughts/ideas here are appreciated!

3) RAS Support

	Same situation as 1) above.

Some quick notes: The actual cache parts of this set are untested due
to problems with my set up, but I did make sure nothing here breaks type
3 support. I'll have this fixed before sending out a v1. This series is
based on the for-6.18/cxl-probe-order (commit 5e29cbd1077b) branch in
the CXL repo, with v7 of Dave's deferred dport probe set on top [1]. I
added Dave's set to help with getting around constraints with HDM
decoders in CXL.cache device only configurations (see 08/18 for more).

Patch Breakdown:
	- 1 & 2: Preliminary changes for struct cxl_cachedev
	- 3: Add struct cxl_cachedev
	- 4-8: Preliminary changes for adding cache devices to port
	  hierarchy
	- 9: Function for getting CXL cache info
	- 10: cxl_cache driver (mirrors cxl_mem)
	- 11-16: Checking CXL.cache capabilities for system configuration
	  validity
	- 17-18: Cache device attributes

[1]:
Link: https://lore.kernel.org/linux-cxl/20250714223527.461147-1-dave.jiang@intel.com/

Ben Cheatham (18):
  cxl/mem: Change cxl_memdev_ops to cxl_dev_ops
  cxl: Move struct cxl_dev_state definition
  cxl/core: Add CXL.cache device struct
  cxl: Replace cxl_mem_find_port() with cxl_dev_find_port()
  cxl: Change cxl_ep_load() to use struct device * parameter
  cxl/port, mem: Make adding an endpoint device type agnostic
  cxl/port: Split endpoint port probe on device type
  cxl/port: Update switch_port_probe() for CXL cache devices
  cxl/core: Add function for getting CXL cache info
  cxl/cache: Add cxl_cache driver
  cxl/core: Add CXL snoop filter setup and checking
  cxl/cache: Add CXL Cache ID Route Table mapping
  cxl/cache: Implement Cache ID Route Table programming
  cxl/cache: Add Cache ID Decoder capability mapping
  cxl/cache: Implement Cache ID Decoder programming
  cxl/cache: Add cache device counting for CXL ports
  cxl/core: Add cache device attributes
  cxl/core: Add cache device cache management attributes

 drivers/cxl/Kconfig         |  14 +
 drivers/cxl/Makefile        |   2 +
 drivers/cxl/cache.c         | 276 +++++++++++++++++++
 drivers/cxl/core/Makefile   |   1 +
 drivers/cxl/core/cachedev.c | 292 ++++++++++++++++++++
 drivers/cxl/core/hdm.c      |  31 +++
 drivers/cxl/core/memdev.c   |   2 +-
 drivers/cxl/core/pci.c      | 134 ++++++++++
 drivers/cxl/core/port.c     | 518 +++++++++++++++++++++++++++++++++---
 drivers/cxl/core/region.c   |  25 +-
 drivers/cxl/core/regs.c     |  28 ++
 drivers/cxl/cxl.h           | 193 +++++++++++++-
 drivers/cxl/cxlcache.h      |  42 +++
 drivers/cxl/cxlmem.h        | 121 +--------
 drivers/cxl/cxlpci.h        |  10 +
 drivers/cxl/mem.c           |  14 +-
 drivers/cxl/pci.c           |   2 +-
 drivers/cxl/port.c          |  54 ++--
 drivers/cxl/private.h       |   8 +-
 19 files changed, 1569 insertions(+), 198 deletions(-)
 create mode 100644 drivers/cxl/cache.c
 create mode 100644 drivers/cxl/core/cachedev.c
 create mode 100644 drivers/cxl/cxlcache.h

-- 
2.34.1

