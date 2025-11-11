Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89A1281508
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897243; cv=fail; b=h2IBXWaqEtKARtZEh8dT9ibFIKAX3KA+zUSM+oP+qceM8XKUhXITrNtzwrOWf9Xa3RP4ka8SA/oa7GbtCiRa1Q0BQQ3vl8dDuK1BNfxkbibMq9YhIAuRmXUq4RFxFGHmw15FXFDLJhzPrckh5toEJgFReQbf+waEbIteXGU/pUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897243; c=relaxed/simple;
	bh=5djAxwxzkeQFavqBIC28a3zikLzqf6Lr3XdzgPgH2Z0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iuG+KSHuyc0d3VzbP5QZkMTLnIZdXqiyObPZ4b7f9KG1rezf206KIwuLC+8GuJMdO4ok5e2Xh9zdr9gotG6eJUlNXFJaoYuieNcU2gWgI75qJQbjzggnVIeZejt0Y78L+W7sMGfX4ati/6fefzKaIvzSHyAX36EI1arrpjMQv+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sde2o/4g; arc=fail smtp.client-ip=52.101.56.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sde2o/4g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8m/T1MsjS1s20fKBDr7znjEfikB4AYXv9koNY0YvN67mSptqi9tPeyCiranXSNhljMZS2ZTfgxkv5mrlyP9Tix6vMjOUWjXIWiFcWZt5JL4uEKQMtrF+/RJ1yio9K1DCpyR/Jg0ZwVFhw1B5ZXS/iW+RqN5JeIwmQ05CnJcMu4EnxtBjnjfEQshBGX5o3m+F9OWTVM4jriCsmD46MoVnMmkV4hdQT6Cua2v5i7wbW8Fy4eTviN3tZauuuoWN8NrwxWaTTO89Qu58Eg809WDypcwxVgcvqLTiknjHE0WnJ6Fr13ZIE9wbyXCG7q2iEFhbp9iJS+1n82bUYeFsE9a5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKeqdfGTWi5iWMyu3euGBznc+qMZ8fP7BHjG+Q+oeQs=;
 b=k8lHLAfkophVCo9nyZh2OSVy5Ke6MlWoYubKOYHUSNS8AaH7dFiQ0qObDeOYn9qdgm5Hp4H91lsbxTOTxWbID7G7PJhHYC/nl6qS0MZtUJdowvMArdWzg2M2XAyeWY8sj0wiori1cQXf9rFrzkFBmW5AWvNpp+xh20Ni0XKe+Kkp+egmbt/DU5UBh9mmFSTL41QGM2dHbNGOmO7zUMvh+aPes1TXaQA0QmCuT5yySCUz2ClxlrJhihBDCN+HMx8xs9igDkJPbkZX4UqmynZRrauXzAMxwVWjFyCmP3C7e9GRZlaJ17N1R6PhMa3n55qi4FmwRn2KYpf4hvfhR0P8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKeqdfGTWi5iWMyu3euGBznc+qMZ8fP7BHjG+Q+oeQs=;
 b=sde2o/4gltnAkm+MKjL5hKTTuqly87bQT4/zJZYZgxqbslh4F5KR0p5PmUvRjRMJ44zfO8ycNvYYKa995aPktqHRsF+yoKjxZoWrZL5oTDJRk4OO3KereTWVS0Q/LKsH9NsgodwVVx4FH9rMLwJKMhossq5hxQnyua0vvKXDX/M=
Received: from BYAPR11CA0074.namprd11.prod.outlook.com (2603:10b6:a03:f4::15)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 21:40:38 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::67) by BYAPR11CA0074.outlook.office365.com
 (2603:10b6:a03:f4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 21:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 21:40:38 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 13:40:37 -0800
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>
Subject: [RFC v2 PATCH 00/17] Initial CXL.cache device support
Date: Tue, 11 Nov 2025 15:40:15 -0600
Message-ID: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.51.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d08b2d3-374f-468f-8f05-08de216af4a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FE1/he4unVBN6F+n7UQEcVo/EtR84ewr18lwcLX5z9QIMEdIb20pdEpjsNZ3?=
 =?us-ascii?Q?hcAxe9p6eRC9Q53adycQQ2hqYDoTxarejohjKYsuJsqR+h5ggWFp4oxrUVAr?=
 =?us-ascii?Q?GOuedJalYdDbzBU+BpM1Ss6VdtSaVks96uUyW3WJrGmYMtuQT9mSxtAvYA2Z?=
 =?us-ascii?Q?n6w4J5SO6VIsfaUSf5FRiZhJl1Ol/tkCZCtIFo0/HS5OF3PPJDY4KvToYYih?=
 =?us-ascii?Q?frIoLcbZGFx9CvIL3z2fG1GKDMO3KrzvA/nvBwtcMk+BB+S/2bPsbYAhYvo+?=
 =?us-ascii?Q?Xw66B+jPuuuZTxd1fVxN8T3BQfwvVdR5mxoFJxjLbmEWNqhMmEh2wF3zIpp8?=
 =?us-ascii?Q?KuRqjYC3eFEY54PlCkxXwGXSgC+UePqaeuf1BCimeVk9N+mHEFT1NZFmtRBK?=
 =?us-ascii?Q?Yj/5EgW5cTb3MnYrXzlZHqSWFlGSeSoqZNOxyyFZDEVQNE6rGSA+zTkrBjyr?=
 =?us-ascii?Q?O1UELzxp1THsjq1Ei9qguwpcr+MTQ0+7khKy++Jisk018X4KHmInrs2UhKvL?=
 =?us-ascii?Q?mQAYUs+g78yupOcBgyvVHjj8qdqIHu2EDy/CGdfeDeY7vMEsYedJpzNIeCBK?=
 =?us-ascii?Q?9Otvtwd3Ax3GHoWjJmSBJLqS3H24Urx2prs1SZtIJP1AANBwGLKUC+IyFkmw?=
 =?us-ascii?Q?u3vpmmPTmLd/nt1R78i0zYJf7b6kVWToqVbrA6f0G0oA/APgcGRvtEv9fULI?=
 =?us-ascii?Q?sUkk0LeYrMlNyFMsO7Ua1cmNpCOg9APdMlfbLQMjiD1F3ypa2lAimsHaesEe?=
 =?us-ascii?Q?NKcPhZSBi9aEiAhd5AzHlng7BKGM94hGFa59mijgUd2y7S99bANfiRX9rH/F?=
 =?us-ascii?Q?vs/kYTbnPw+XhHgeTf1TJn/fxgwNa6lfOARr0ML1JzpASAdMYw36WzbTm2Yt?=
 =?us-ascii?Q?6E0T88fNsAM5fucSDWYV+BXXu2+CqXAzQ/l04bYas42qpBoQE5A4HG3QSXYN?=
 =?us-ascii?Q?TYy3QW6Yk1t1GrDIHf5zB6Gv1127bixNdQ9GEVlMQIbl9Ck5Vzc5SqUO774N?=
 =?us-ascii?Q?gAbn6kY2Rpkq8l2khNA8GtrAfmVevk0Lg5G/7BdX+UJwPcCOIms1H4xEcDE0?=
 =?us-ascii?Q?80dzYmLZdMDLblrb/rhMDVyciadIGKBYrbF22nB97Pd3p/RnkhwSaYqr1BUw?=
 =?us-ascii?Q?kMoKKHRYhenNvMg6YetnV/C7gJlT5NcSYRAXz5FhGMt+rw/IkL9cp+5aetYq?=
 =?us-ascii?Q?dgdAm5G4L6jbtY692NoODajOqbTzSU6p4ali0zLi4WeSTXvl8odCAA2PrPy2?=
 =?us-ascii?Q?9KPDbpvVG6ePm22mdm6yqjTzy1n5n4kNYv+yHG0paWu1CYe3Hvj1+WFqAFyV?=
 =?us-ascii?Q?ITXQYGPjBnyHqek/jt7lE1527+V1yhDuQHLXL9Y5UMOBjypt5QT1Ow2yMaYR?=
 =?us-ascii?Q?SRlVLcrAKLcybJQUokjbmeYrGHReKpl6jnSg7tjG0A9Vu23NmaZr2nZoX1nz?=
 =?us-ascii?Q?Pg8q1MWQ0ooRmRTdvwCZCGMzLQacmhUhJkaouWFu2FxMpzLYSUHOSYgGMshK?=
 =?us-ascii?Q?f8URBXy0yJHhZPbkdUP9bnLgYXD0IxSoIAW1jVBbXsXiMTDs5vPdZxZuQVF2?=
 =?us-ascii?Q?44hZ7ss8rANVGtibKOw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:40:38.6456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d08b2d3-374f-468f-8f05-08de216af4a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188

v2 Change log:
 - Reworked cache id patches
 - Reordered several patches for flow
 - Add/delete cxl_cachedev in cxl/core/cachedev.c (Jonathan)
 - Add doc for struct cxl_cachedev (Jonathan)
 - Updated switch port and endpoint port set up to mesh with new delayed
   dport set up
 - Added comment about why cxl_cache probe is synchronous (Jonathan)
 - Bug fixes, cleanups, and renames in snoop filter patch (Jonathan &
   Dave)
 - Removed serial attribute from cxl_cachedev (Jonathan)
 - Added NULLs and removed commas from attribute groups (Jonathan)
 - Bug fixes for cache management attributes (Dave)
 - Added documentation for new cachedev attributes under
   Documentation/ABI (Dave)

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
2) RAS Support
3) Mapping/Reserving host memory used for CXL cache(s)

	I'm thinking the way it will work is the endpoint driver requests a
	DMA region for the cache, but I haven't looked into it. Any
	thoughts/ideas are appreciated!

*Important Note*: The first patch is only there for context. It's
required for the set to work, but it should be picked up as part of
Smita's soft reserved set.

Ben Cheatham (16):
  cxl: Move struct cxl_dev_state definition
  cxl/core: Add function for getting CXL cache info
  cxl/core: Add CXL.cache device struct
  cxl/cache: Add cxl_cache driver
  cxl: Replace cxl_mem_find_port() with cxl_dev_find_port()
  cxl: Change cxl_ep_load() to use struct device * parameter
  cxl/core: Update devm_cxl_enumerate_ports()
  cxl/port: Split endpoint port probe on device type
  cxl/cache, mem: Prevent RAS register mapping race
  cxl/core, port: Update devm_cxl_add_endpoint()
  cxl/core: Add CXL snoop filter setup and allocation
  cxl/core: Add cache id verification
  cxl/port: Add cache id programming
  cxl/port: Bypass cache id for singleton cache devices
  cxl/core: Add cache device attributes
  cxl/core: Add cache device cache management attributes

Dan Williams (1):
  cxl/port: Arrange for always synchronous endpoint attach

 Documentation/ABI/testing/sysfs-bus-cxl |  31 +
 drivers/cxl/Kconfig                     |  14 +
 drivers/cxl/Makefile                    |   2 +
 drivers/cxl/cache.c                     | 152 +++++
 drivers/cxl/core/Makefile               |   1 +
 drivers/cxl/core/cachedev.c             | 289 ++++++++
 drivers/cxl/core/pci.c                  | 140 ++++
 drivers/cxl/core/port.c                 | 842 ++++++++++++++++++++++--
 drivers/cxl/core/region.c               |  25 +-
 drivers/cxl/core/regs.c                 |  27 +
 drivers/cxl/cxl.h                       | 204 +++++-
 drivers/cxl/cxlcache.h                  |  48 ++
 drivers/cxl/cxlmem.h                    | 113 +---
 drivers/cxl/cxlpci.h                    |  10 +
 drivers/cxl/mem.c                       |  55 +-
 drivers/cxl/pci.c                       |   2 +-
 drivers/cxl/port.c                      | 129 +++-
 drivers/cxl/private.h                   |  19 +
 18 files changed, 1877 insertions(+), 226 deletions(-)
 create mode 100644 drivers/cxl/cache.c
 create mode 100644 drivers/cxl/core/cachedev.c
 create mode 100644 drivers/cxl/cxlcache.h
 create mode 100644 drivers/cxl/private.h

-- 
2.51.1

