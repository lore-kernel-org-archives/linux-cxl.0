Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA373B27E2
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184838; cv=fail; b=NdYQ3DI5uIYdAT01ohlif01YV46ysZ8V6HXnZ8UrOuqcKUXIcS24/3AevjrCSU5jHKxboFaFTprJRwv1unZKoLt0DjGOPOY4luYBgVavM9CyQxGG13nOJt3EQNZ7tNOQvNRA//iaAe4wpeXyJkL5f0LarEyt2xeu+givc1KxErM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184838; c=relaxed/simple;
	bh=l/aDsVCGrvcneQZX7GAh762LtaCZJ4P9OxBJrvFfoz8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ERVa04nr9b79LTcKoiiNgWVKvPSz/DgLh/YFXNYC1Bd1nQ0KEEwGjqq7GcIYB3JxcbbOYfw5CBOCUrWT7U8Ujc9DJUZyv5JXszPI0PW4juh61Fn470p6af3GsZ8omNSRzQqcZ8SDSTqZfkrZ+nJyR+ZTBalwCMuqBD/eznkDFgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pDG04mg+; arc=fail smtp.client-ip=52.101.52.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pDG04mg+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEsUUn9taMmPBqnleLqDU+J5gVfleomYBEwJ0R8cYEWtwU8bYSYBsIMj7yMCgtznF9dn0wfWKuyM8kP77RgFgkyKBSnQfoSbEQDV7LH37DEuk8E/TSMBWuerPTXGWCWI1S6gN3MjB0XTtHmmg1M0KnpMP6Oja7+VCMGGXwVCTb2KQ/hwhjleL6dlnxE4NCC7RlTH+EJaXsGaX/KT1oyjg3+3kPyrZ6xqGdpDalkOtb21DYY8TXecIMkr7VBXp3E2oZ+T/smwOoMRcsMO8cUbrmhSYNOI2lS9YltKBzJT68jEhPIKzhCviN6t8q0uaxyuXBbq9MRUtaP7pPu6AJQMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tV6relqKRJaqlPT35yp0JwUAviTd7kWFtvJmh5JQGjQ=;
 b=fIwRmTDy20AS+Zop+mZLRsidEOxpbBuFfip3Jn4ObYaVvJ4L621u+F6x/Lqs8CuZALGgb/eBa/ro75YXVolNKGwwcQ4DjL3FRpOhhdmNWRQAVjospOwv1QmWDyUs/7uV2YEDcoYFthfHah84Nach+/kpxlaa5JAhk9YWgAeNpFaOkSCrxWZ7/e2vYqacKnZ8QOwkk/24P4egADbl80Bc5htArybHJLUA2LLFXE3Kewi8SW8qr78afk3ZPzDw6KlOnYAZoCAg4LxmWHWlcMKAmDafXWwLPPIFlRaNFH11FPclw6lNIYx8uLNwQ2LXUOjCgyGXIclV2vGzefe49N7OfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tV6relqKRJaqlPT35yp0JwUAviTd7kWFtvJmh5JQGjQ=;
 b=pDG04mg+pFJ3ymkFf6H2iZysd2UpiCD6H92fVz2L0NFh4koBcuEnLHRr4Y7Yb9iPI9uLlW21PC6i/fv2G/sJQhsorsAIjojxTIh1JrAul4rkdwLBis6CeiOzGaurEycdOGKo6cjJV9QzYAhD2YMBuAjl7tpCY0WvCkREFUQ4N4g=
Received: from CH0PR03CA0294.namprd03.prod.outlook.com (2603:10b6:610:e6::29)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 17:33:49 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::3f) by CH0PR03CA0294.outlook.office365.com
 (2603:10b6:610:e6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 17:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 17:33:49 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 12:33:48 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>
CC: <linux-iommu@vger.kernel.org>, <benjamin.cheatham@amd.com>,
	<terry.bowman@amd.com>, <robert.richter@amd.com>
Subject: [PATCH 00/15] Add initial CXL.cache support
Date: Wed, 23 Sep 2026 12:33:27 -0500
Message-ID: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: b2467982-b2bb-4c3b-4bb7-08df1998d415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|5023799004|11063799006|10067099003|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	02noxrrOu3zM76UBqccK1KpS2g8pS71+tInhJlOF1f+y/CULQ0s8cCuk7LNXIIbCekBo9XKoE9kRH6pmcWuAb01fRNsuJWONxrdnMEaoTCKv8EMTEScNsTpoPJxb9f/2fdSwYlwecWvdn1qAKmKOYUJXv0ZsLpg/w9cFHsTD9HIVXoBnY4dObBzuIdK0peA1VvOw4E1m3M8FRiX9VO93QHpHm5iF6Wh1jFVMHMXsSnLZfNeqTnY8mgtpXmNzjo+74cc6NFjs0KDuG8W70YKZ83HkdpyKlhRDT3x8rR33hMd20SOCjbdWpEAmcH0kOo9IsOxWK6Chwt9LQprSWG2dlCjDuuMVV4t33zf+d6qgIq2uHkl0ccESkZiMI0mHix3iYZLuaXGcPISY32TZznMy46t5SrsGCDJ4XmhvdwFAuDNLr3GE9SEVBOvwLFgOloCQgq5uEY/bGN11sct3EpV70gUaWLS9WD8TrgbmWMyYgitLp+i4ilo6p9KWeabxJVWI2LwzgM7l6fL/wD3udmNy9dND/NneSUukSCN0NXuF5xUSScPBPurCXRWm57jj94824UIacVTY+ygHqp6COxxnkdaoENqM555yedLL6r/mCZ/s+VgIgL+g+Cn2IIvOGhnB/g3yCNXo46yUY+ImDv2Ed4zIvzu8Tl9OMAc+/JGMQmzIh0QfAQ1GB03WnmUj6kkcOlAEFOiWVUe7M4isfU3x2Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(5023799004)(11063799006)(10067099003)(3023799007)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZYx3+MEJOGNwXqCD2wKxIxAbYlw8XFN9lGEA8OGWCK3elJS9ZP0SQGn6k/oqK/9PT++w4nCXo3H05mXwGYrmwZKVroQxv19+KXJqlJLGZUzyZi8YUNcVpSdkim+yuxFu4GehVlEgR4is48CcJVQKv+1oQ8v6OmH5fsqsq74YAaumEc25QcMDEAD7SoysjPLB6FssE7091HUNToP09dLJPOWNhuWdCzXlUQUVkYVz4HiP+pwZDfzbI3fBpAe1GZyic5AVl+kPnOyVg6Bn6OOaof1JNBpcK5qIeyOWMcZXebv69pYOdLKRUV4vxRZo4lcMtlL/QAHiA+5NJbsgXwNH7BBIly+6TO0HglmwLnZUDHFevp/hfElU+B72Yy5xJ4I8RcA6lSuttnhR1qZ17G98P4fWpTlt4zwDsI+T2VVBJfAqX+bRk1ktgNrsmbnE5jBt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:33:49.3188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2467982-b2bb-4c3b-4bb7-08df1998d415
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613

This series adds support for CXL.cache devices to the CXL subsystem. The
set includes the following:
	- Updates to the existing CXL infrastructure to enable adding
	  CXL.cache devices (struct cxl_cachedev) to the driver
	- Support for cache id and snoop filter capabilities
	- IOMMU updates to allow CXL.cache ATS requests
	- Driver for struct cxl_cachedev devices that calls all of the above

The vast majority of the support is gated behind CONFIG_CXL_CACHE since
CXL.cache devices aren't commonplace. This set is untested since I don't
(currently) have access to a CXL.cache-capable device. Using multiple
devices requires cache id capabilties, which may not be available
depending on the platform (for AMD it's Venice or later).

There is a major missing piece in this set: There's no endpoint driver that
adds a cxl_cachedev device, so this code is currently unused. I was
planning on only sending this out once I had a device, but the plans for
the device I was planning to support fell through and I didn't want to
just sit on this.

Another thing that's missing is mapping host memory for CXL.cache use. I
think the DMA API *should* just work after these changes, but it's not
tested. I originally had the CXL core driver set up the DMA range for
the endpoint driver, but it didn't end up making much sense. So, I've
left the implementation for the (eventual) endpoint driver.

Thanks,
Ben

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935 (v7.3-rc1)

Ben Cheatham (15):
  cxl/core: Add CXL.cache device struct
  cxl/cache: Add cxl_cache driver
  cxl/core: Change cxl_ep_load() to use device pointer parameter
  cxl/core: Update devm_cxl_enumerate_ports() for cxl_cachedevs
  cxl/port: Split endpoint port probe on device type
  cxl/core: Update devm_cxl_add_endpoint() for cxl_cachedevs
  cxl/cache: Verify port hierarchy has CXL.cache enabled
  cxl/core, cache: Add Cache ID register probing and init
  cxl/core: Add Cache ID verification
  cxl/core: Add Cache ID allocation
  cxl/core: Add support for HDM-D cache id programming
  cxl/cache: Add snoop filter creation and set up
  cxl/cache: Add snoop filter allocation
  iommu, cxl: Configure IOMMU for CXL.cache
  cxl/cache: Enable CXL.cache on successful probe

 drivers/cxl/Kconfig                 |  14 +
 drivers/cxl/Makefile                |   6 +-
 drivers/cxl/cache.c                 | 285 ++++++++++
 drivers/cxl/core/Makefile           |   2 +
 drivers/cxl/core/cache.c            | 851 ++++++++++++++++++++++++++++
 drivers/cxl/core/cachedev.c         | 131 +++++
 drivers/cxl/core/core.h             |   7 +
 drivers/cxl/core/memdev.c           |   1 +
 drivers/cxl/core/pci.c              |  78 ++-
 drivers/cxl/core/port.c             | 149 +++--
 drivers/cxl/core/region.c           |  24 +-
 drivers/cxl/core/regs.c             |  30 +
 drivers/cxl/cxl.h                   |  74 ++-
 drivers/cxl/cxlcache.h              |  50 ++
 drivers/cxl/cxlmem.h                |   4 +-
 drivers/cxl/mem.c                   |   4 +-
 drivers/cxl/port.c                  |  97 +++-
 drivers/iommu/amd/amd_iommu_types.h |   4 +
 drivers/iommu/amd/init.c            |  14 +
 drivers/iommu/amd/iommu.c           |  56 +-
 drivers/iommu/iommu.c               |  28 +
 include/cxl/cxl.h                   |  78 ++-
 include/linux/iommu.h               |   8 +
 include/uapi/linux/pci_regs.h       |   8 +
 24 files changed, 1911 insertions(+), 92 deletions(-)
 create mode 100644 drivers/cxl/cache.c
 create mode 100644 drivers/cxl/core/cache.c
 create mode 100644 drivers/cxl/core/cachedev.c
 create mode 100644 drivers/cxl/cxlcache.h

-- 
2.53.0

