Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70294E542;
	Mon, 17 Jun 2024 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654672; cv=fail; b=cUq8K3cKVUcR2ceeZhb2udrsaV9tDeY3r3YDaJ/oyx/3OByah29St8BIb4pBgBsRoEun7rCsHA8I1Nq8+86/rpyEvo0v8Ib/VjpRIXEWsXMKcfyBfSPlabX/tHvF0rRoeQX5sUFfv5hJtYMH4YUGXI9Evh4QxybB4vmI8qiYJkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654672; c=relaxed/simple;
	bh=XQb46Ix0gGSQX2LzYyDfH1Fs5Su7QEPauicT/EEbws8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JTwFFWQtcp8RowdwFBptDcEJa/13AQ79VAKdOwOVHFOEbZyv1aBrcK+u7+dkwqS6aYvC3enmTw75V233uVK4QL5WiznyIJ51y7S6KZtvb0HzENqp5giQYWnmxPI42QWYSf+HC27XnC4GdvjUyaCeK0j4aSn60JnryOTair8UWrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NL3iuQVd; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NL3iuQVd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTx9AOSJXOgjGIDsYfOq3p362vT/DjOg31KOegaH6ayPEoOUySQlAw1RsdKO8Ppl9/D0mlvl7igPbnQwVgfMXwFNj6TSX3QEpZTV0KLroYeeE4S0bqxsf5467BTnHv30PWopEHGBb9jD0JV+4uGUqyBvPawNdpeX2+WgJ+1vpBW+vsWs9IaUIjgVPCPzAKUtPnYGYm561WifmRH9hX3BVkKTWxEGjAONuF+PCG7mt88oyg7oCnDK819e9Ojskwafq0TgAM1KpEIwK8lOBZp2frtowhH/5oizkPIPCkFbXCTqDaMsH2mPOqdbdj3+lmkaqQ0widAtpiJGKsGf/v2qTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUSvfOMDeXE3IfIsty1uipApshKFeTCggpkkRuuM7Yc=;
 b=B+Dv9LEw94vhbzXVbvjefoQ4u9m8lKuO0qoOKoQJEo+8lxR7dujajFlnu3+YY3E96rvld55/XeKtCAmQCrUIRDekJGQBQzRCvt5bZ6sbnNnAUrTL4gLSY+22tx52Kyg1yGiyKrdHO/W0UAM315zU2BteTM7MXyrkh+u4/vS2TxHZMWsEX+D1WHFUSsuJJs0zyIOwfWz3rKaEm4RwkoRb70DrnOi3VCtzo1cjgRuYV9SwgSOMdGG+QsKFHQOwjUVDWlNgGTKGsBF85bwiFEX3BsURJto4n/MWClWrpG4jOhKZDXzTDRYr6qdhrE8T1OYHL9GTGym5CqZsHp8egAZiEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUSvfOMDeXE3IfIsty1uipApshKFeTCggpkkRuuM7Yc=;
 b=NL3iuQVdInrgFukRZKqTBOVXm2rl2escrw6krzIBPG0QhX39C7YXGzO70yV1LnuaJPAwvmN+pWGgIfl+1hi8XCV4dGPF+3r/LL/dRok36g7VH4m7qbZxlxXBiuKp9fr7fHedI6Yn8CpUoIEy3jl9lyevguV/KHwhB3o3JtjOMFQ=
Received: from SJ0PR03CA0088.namprd03.prod.outlook.com (2603:10b6:a03:331::33)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:04:25 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::c2) by SJ0PR03CA0088.outlook.office365.com
 (2603:10b6:a03:331::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 20:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 20:04:24 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 15:04:23 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <terry.bowman@amd.com>,
	<Yazen.Ghannam@amd.com>, <Robert.Richter@amd.com>
Subject: [RFC PATCH 0/9] Add RAS support for CXL root ports, CXL downstream switch ports, and CXL upstream switch ports
Date: Mon, 17 Jun 2024 15:04:02 -0500
Message-ID: <20240617200411.1426554-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: f45d355d-05cb-4df6-9734-08dc8f08afb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|82310400023|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GvTv9XudbpTeSJ8JDWGAaRs63XqOYQGD+nLiFPdCdPJf/Py38h2VzY9MbSqN?=
 =?us-ascii?Q?acstaix3j71GJgMlApZzRnC7RnPVGSgTdtG7NIC5jGnxbzs8uqGa42eVUsZ8?=
 =?us-ascii?Q?K3oGMENZdvM1JQSjk30ubj+51csOLlqEC/epUNWHH3RcZ1MGDhzDcl0hY7dp?=
 =?us-ascii?Q?zkLf67JgfRH1qESrHElWxDa+jog9WO2gA3gkNGiGjTopSq8Q+qfXHHgakbpd?=
 =?us-ascii?Q?oW4C2VhCra/Bb2xfBw3RDEY4zlVIgkOU9Zjsl7isQzTE3ngsbo0erqFFx9+A?=
 =?us-ascii?Q?6e9UELyi6jtFMnWKoQpLwGQLC0L+wWYlJMwJ9A3hKmeJWWkaY/pGHnbYrIGt?=
 =?us-ascii?Q?ifi3MNjv+Epg/AMEmNghZKXb2jMOj4Gk6NyfLUJvRCM41+bLcvdBiLPfdpTx?=
 =?us-ascii?Q?yOMRRdbFkSUdmcHt2W8An5eqkDX26pjcldMHeNuPnShj8N66PfjahHF2lTtB?=
 =?us-ascii?Q?MN/5vt4OVfL0Y9fjSyGlIlj+9Wf70X55HSHXP3gs//6KBqLI9kwQSeOo9+y4?=
 =?us-ascii?Q?Rx15SEKsyC1CSi04oo6gAvixcC9HpbZd1rzFuHBQPaQUw5Vcr2bgMhkZy87O?=
 =?us-ascii?Q?bFpyKvFAQUO/oVxevDhG+d0bEC7Gt2S+6AJyjr0lM3G7tQDGwjqYY3fGIHEL?=
 =?us-ascii?Q?+rGNd2nIaFq8dEWkYcoA8TQU3pS1+f2Fp2PcVyU89Qs/vqMpQ/kFysl0PxRG?=
 =?us-ascii?Q?D/TXG+WwXWsWVWzznrsmRcVJMrIfrh61ySUK92hi2sFaPQUgeN8wBAz3kOK3?=
 =?us-ascii?Q?kxvi6mHLL34j7oO1ATbCG+W6THpwbrFBjn6ZSC4LV6Q9N2qgTqvdVSGyplYy?=
 =?us-ascii?Q?NUWIE1NZj0kegCf/1bN/Y6nMUgSiuKEBCmFkwx2iS6V2P217BlIBuSC18+/n?=
 =?us-ascii?Q?2PbXm/twcjfLX1263pS9LgMq8gplRfIYSDVYnmkXA0np/bXbSoDdEblwEWmf?=
 =?us-ascii?Q?KW8OutN8+0utc4bezp1VcWdSPhtKFAop3/XwPIl02UZOZT2XGOTrdjFu3rQb?=
 =?us-ascii?Q?pFs11lyh0egEP/zseoRx/KJLs7Uyxl5okVY7+xKwn4q7P3WQaLvniLpnU6CX?=
 =?us-ascii?Q?GfljanTV+gwsj4gGNf0pJXD1WNi0Jy9cQLHqQECzzZ6Wo7EvEiY/tq92abQD?=
 =?us-ascii?Q?6ke3CsPlojtDP4IY4BwCg2yWkQLmga/kaxRxoH4nTdwvO2IMy9g2kZ/PlpYn?=
 =?us-ascii?Q?cwuzSXSHDqhQuLr61DzcD0/1h55g4tjksZKgiX314DQ/mY170iuGwiDE7EDh?=
 =?us-ascii?Q?Mawp5UvTmthA2y35UVJB5sKhnZOqQy24s1ClihrOQ5UtMsfGi7Lgqk6OZkm5?=
 =?us-ascii?Q?LOtw7nLbexXjAgYzlJ2n/PJVtZDw4J3hxVi9rapvBXiSRoXp/GWhWStNHRv8?=
 =?us-ascii?Q?g809uDUOmXOotMQ088FpHym1aq4k?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(82310400023)(1800799021)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:04:24.8367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f45d355d-05cb-4df6-9734-08dc8f08afb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063

This patchset provides RAS logging for CXL root ports, CXL downstream
switch ports, and CXL upstream switch ports. This includes changes to
use a portdrv notifier chain to communicate CXL AER/RAS errors to a
cxl_pci callback.

The first 3 patches prepare for and add an atomic notifier chain to the
portdrv driver. The portdrv's notifier chain reports the port device's
AER internal errors to the registered callback(s). The preparation changes
include a portdrv update to call the uncorrectable handler for PCIe root
ports and PCIe downstream switch ports. Also, the AER correctable error
(CE) status is made available to the AER CE handler.

The next 4 patches are in preparation for adding an atomic notification
callback in the cxl_pci driver. This is for receiving AER internal error
events from the portdrv notifier chain. Preparation includes adding RAS
register block mapping, adding trace functions for logging, and
refactoring cxl_pci RAS functions for reuse.

The final 2 patches enable the AER internal error interrupts.

Testing RAS CE/UCE:
  QEMU was used for testing CXL root port, CXL downstream switch port, and
  CXL upstream switch port. The aer-inject tool was used to inject AER and
  a test patch was used to set the AER CIE/UIE and RAS CE/UCE status during
  testing. Testing passed with no issues.
 
  An AMD platform with the AMD RAS error injection tool was used for
  testing CXL root port injection. Testing passed with no issues.

  TODO - regression test CXL1.1 RCH handling.

Solutions Considered (1-4):
  Below are solutions that were considered. Solution #4 is
  implemented in this patchset. 

  1.) Reassigning portdrv error handler for CXL port devices
  
  This solution was based on reassigning the portdrv's CE/UCE err_handler
  to be CXL cxl_pci driver functions.
  
  I started with this solution and once the flow was working I realized
  the endpoint removal would have to be addressed as well. While this
  could be resolved it does highlight the odd coupling and dependency
  between the CXL port devices error handling with cxl_pci endpoint's
  handlers. Also, the err_handler re-assignment at runtime required
  ignoring the 'const' definition. I don't believe this should be
  considered as a possible solution.
  
  2.) Update the AER driver to call cxl_pci driver's error handler before
  calling pci_aer_handle_error()

  This is similar to the existing RCH port error approach in aer.c.
  In this solution the AER driver searches for a downstream CXL endpoint
  to 'handle' detected CXL port protocol errors.

  This is a good solution to consider if the one presented in this patchset
  is not acceptable. I was initially reluctant to this approach because it
  adds more CXL coupling to the AER driver. But, I think this solution
  would technically work. I believe Ming was working towards this
  solution.

  3.) Refactor portdrv
  The portdrv refactoring solution is to change the portdrv service drivers
  into PCIe auxiliary drivers. With this change the facility drivers can be
  associated with a PCIe driver instead fixed bound to the portdrv driver.

  In this case the CXL port functionality would be added either as a CXL
  auxiliary driver or as a CXL specific port driver
  (PCI_CLASS_BRIDGE_PCI_NORMAL).

  This solution has challenges in the interrupt allocation by separate
  auxiliary drivers and in binding of a specific driver. Binding is
  currently based on PCIe class and would require extending the binding
  logic to support multiple drivers for the same class.

  Jonathan Cameron is working towards this solution by initially solving
  for the PMU service driver.[1] It is using the auxiliary bus to associate
  what were service drivers with the portdrv driver. Using a CXL auxiliary
  for handling CXL port RAS errors would result in RAS logic called from
  the cxl_pci and CXL auxiliary drivers. This may need a library driver.

  4.) Using a portdrv notifier chain/callback for CIE/UIE
  (Implemented in this patchset)

  This solution uses a portdrv atomic chain notifier and a cxl_pci
  callback to handle and log CXL port RAS errors.
  
  I chose this after trying solution#1 above. I see a couple advantages to
  this solution are:
  - Is general port implementation for CIE/UIE specific handling mentioned
  in the PCIe spec.[2]
  - Notifier is used in RAS MCE driver as an existing example.
  - Does not introduce further CXL dependencies into the AER driver.
  - The notifier chain provides registration/unregistration and
  synchronization.

  A disadvantage of this approach is coupling still exists between the CXL
  port's driver (portdrv) and the cxl_pci driver. The CXL port device's RAS
  is handled by a notifier callback in the cxl_pci endpoint driver.

  Most of the patches in this patchset could be reused to work with
  solution#3 or solution#2. The atomic notifier could be dropped and
  instead use an auxiliary device or AER driver awareness. The other
  changes in this patchset could possibly be reused.

  [1] Kernel.org -
  https://lore.kernel.org/all/f4b23710-059a-51b7-9d27-b62e8b358b54@linux.intel.com
  [2] PCI6.0 - 6.2.10 Internal errors

 drivers/cxl/core/core.h    |   4 +
 drivers/cxl/core/pci.c     | 153 ++++++++++++++++++++++++++++++++-----
 drivers/cxl/core/port.c    |   6 +-
 drivers/cxl/core/trace.h   |  34 +++++++++
 drivers/cxl/cxl.h          |  10 +++
 drivers/cxl/cxlpci.h       |   2 +
 drivers/cxl/mem.c          |  32 +++++++-
 drivers/cxl/pci.c          |  19 ++++-
 drivers/pci/pcie/aer.c     |  10 ++-
 drivers/pci/pcie/err.c     |  20 +++++
 drivers/pci/pcie/portdrv.c |  32 ++++++++
 drivers/pci/pcie/portdrv.h |   2 +
 include/linux/aer.h        |   6 ++
 13 files changed, 303 insertions(+), 27 deletions(-)


base-commit: ca3d4767c8054447ac2a58356080e299a59e05b8
-- 
2.34.1

