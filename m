Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E424A7C6
	for <linux-cxl@vger.kernel.org>; Thu, 16 Jan 2025 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737049350; cv=fail; b=PY4QEMX4ub4psfLLdmS6DV8MH5h1zeEtS+Ci2+DOQVjFOovqMD22Q5CRlLcBIUpKWnVn0jgNR8aDj7rG6W7IiujQpq4FuAl0k3Cw7YvOWqBrpZX2DtzPlKhtafHmylshKiNYlMyKeCRoKa87H4I+5CGV91SdgNMUREytYhJ+v90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737049350; c=relaxed/simple;
	bh=DbpOEY8fmkGDsBPrWpgVuqJhfNaseP9PhJwqwRlzc9c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZFC5v0kx1aozgbxy2gPXrnO66p7bCDTEzQAd9mgptfhNBKeJmQ1O4WPQ+4X30BfmOR3A0CAd3PFrhgzCRRnAFEdZaT7QBKgIt/OEJWHt7XfCmW7pGIerkC0vcdfuzrCWwVzfvTM1h8c5lXFO4/WZ+uaQiuiVRUXVbuaEHrqP20c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v9JiLU/4; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v9JiLU/4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4UsKtJWR1OgkkOu0pUvz+znVcEY7fVjrsls+G8CRcUaVaSUCGSbWTiWdCqsYXf2s8Mox/c+MvAqzdCY2i4Y3+9aQb+J9BMaD0p2zNjpYQwcH9+OZum6hqnfTbYUQ9K+kq2lIvRXbH9NXHmiHnESDg4/XxfWL55GZwoJFETYGYS+GGNOV/Pbrkme22DfhOByo7sQDJyY38Bc6FWoklve4M8KbPtbdvZDx6fefzVVOaq676M5o1lXkJ1D2mcO83O8+yYa/ZFpAon04aQlkwO9zUF8hkqv7B0k0rs01UbZKHPPcVKlOnskJJCUpFGZGqqg9faA0COZX/6SQMt7QdIMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e87qt5mvEeC6IcvDEF0PTvVEApLs341171Qddy0VhRY=;
 b=RbNsxPD9qk+h5kiRalDDHa2WstrhVofvF+aamVyM+9oDu0kiHqcw0sI0hzBmtpY84AkR+pKCzVLn20ygObvGSUK4R2ZOETl+a/JEtlKS+7fLrtAfkB0Jw1gmhLgXzAbfjBNr/okj51o4i7Wdo72odQVDeWeeoFau7C0+zTLGBvOU+KsbM45pnlJS4jdxw4Lh8X4kUiQxIdya9U8ebdKieqHovSXat3JLpgZOj8vkomlMZzcYOO0bNh2pjM3QBfP1Ow3li7EpTVNRBZnW0wsfYr8qd39EN4AFmhfiE9ioVwQlkujX16IwYAmXCLmoa43T2BM7g+oxo2Nb1D68un/qxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e87qt5mvEeC6IcvDEF0PTvVEApLs341171Qddy0VhRY=;
 b=v9JiLU/4JHNQ/Frw8DmiOrTtcqenUk7BE63P32EF0SWFcUbYy/nDWnZvYQSGV3Y3jkFmHRPRUndFCpyfa3mb1Tpq8F/ZkhCR1dy2bpTXePJCC+VnkUiqqGTUrr/1dX54V1eG0OyRe3wDm+2QMRawGv7it+Sp2b+aSMvC5TrdZH8=
Received: from BLAPR03CA0078.namprd03.prod.outlook.com (2603:10b6:208:329::23)
 by SJ2PR12MB8134.namprd12.prod.outlook.com (2603:10b6:a03:4fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Thu, 16 Jan
 2025 17:42:24 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::96) by BLAPR03CA0078.outlook.office365.com
 (2603:10b6:208:329::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Thu,
 16 Jan 2025 17:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 17:42:23 +0000
Received: from AUSNAFONTEN1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 16 Jan
 2025 11:42:22 -0600
From: Nathan Fontenot <nathan.fontenot@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <alison.schofield@intel.com>,
	<linux-mm@kvack.org>, <gourry@gourry.net>
Subject: [PATCH v2 0/4] Add managed SOFT RESERVE resource handling
Date: Thu, 16 Jan 2025 11:42:04 -0600
Message-ID: <cover.1737046620.git.nathan.fontenot@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SJ2PR12MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee84a66-3546-4d7e-c542-08dd36552289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h7+cPoBTlKF8sZVJgnNsowQEIfQoW0s6P7+K85XlOqeOPXhaI8HTDgkyCzRm?=
 =?us-ascii?Q?FBLHpbXqJVhTmt9W0FsSqZ3y3WYBmUnYQICoVKglHzUAfNSlAjHsm5xot0NK?=
 =?us-ascii?Q?D7fp7W5aQ+CDhh3XUlsCmL+8OaFihFMkuyoZdC0wF/9TQEzc50IqlRGpRNvD?=
 =?us-ascii?Q?itUTyZ/0pLuUa4kZAwkkgZ2tplmwyr43+d5a6A5vLMMS/RGV3FMtgnCEbsrW?=
 =?us-ascii?Q?yL8EPetbVq3UxNBpDi/o/3s9l0vn5XgfeGWIO7kqH/OSbxltKNLNf5uK1flL?=
 =?us-ascii?Q?YAYSPg+/SsDhYSkMwBDwFDtrpyi+Z/q2LVMwIvegTI87FmiZ7S7IRU8nPUGj?=
 =?us-ascii?Q?mASf00NNMfQp4SbRqD/urqk7JvudRcLPM51RgVFJBXTxkfmCW9gJp25uF3AI?=
 =?us-ascii?Q?bYrEVqb/G1bCdgXqLhDAQzcPFQEfWwqgifrfQ2+EgYLChV+g0GyHKY/D1FBu?=
 =?us-ascii?Q?txM6IMWV5MPNeh3zoaAeP50Gcuwv/cHezPPgmK7QyUjMvVcdfj6G8h/kMNXv?=
 =?us-ascii?Q?nGA070kyOSdTLx4/VK3KhK8z6dqdvs0efydqpQ3kxft0kdMZRZjdOiwb5MSu?=
 =?us-ascii?Q?GkWyOem4ip2WoA8oBkfHoOBk08S/Z0Z+I5PFMFuYcoMh+Jzt/vDY2P1/oU8T?=
 =?us-ascii?Q?bcrmJswdf+8WEO4gs0MWPVRalAhrUYd52kWEs6FKi0oVcxYae0BzSy3CFt4f?=
 =?us-ascii?Q?V0JdMIaKZjiDvZpYOIcoqRC4rXbDUfkoj6+B1mRe18JlYe9rV8KojyHgUMsV?=
 =?us-ascii?Q?oicr+B0lNymlzfW3pgVHkS9Va3G8dCbGO4HyYQsovM0GzhuJ8Us6gbRgz3Q5?=
 =?us-ascii?Q?ywLpl0O5wJAd5bRD6wfQ96Qa6E0m75jm8MlWHGQ7S6HXX7ylhS9LeCor3O/k?=
 =?us-ascii?Q?i1nAiSgktRIyfxtCbRkxuWAsThL8JPtoOvo/etHLu1Xa0ht/ReJGGb0CDEgM?=
 =?us-ascii?Q?GmXJudR7f+qUYo7IQ83+gUag7V8K1hAHLS0blg6YeYv5+Kf5YKXXBnN3V9yf?=
 =?us-ascii?Q?DeeeP+JW1Kqyz5l3EUbwZxkAupMQNG9DUFefjIU9RSazAvdyQCzXcCKVREhz?=
 =?us-ascii?Q?Y46wQx/V1bIw4g6MK7UgjMqHxLoc526nKgTvLMcEL5hQW4FLTQPOOCZyrnr3?=
 =?us-ascii?Q?xn935GwAluMG4KfjIvHpB4I8ErZgPI6KPINdszNYIgJsciKBVWtpGNsvO0b7?=
 =?us-ascii?Q?/s2g2rYqXmFnensnG15Wl0rvsWhFyhOoC1OFNg0O6yI5bPYqC5Vw/kJ8Gv17?=
 =?us-ascii?Q?N0kAVt9z12DoPraKHDGh7JZe3lIhUHWrsblMZxAcRWvjJOlJ5zfXMzS94VlO?=
 =?us-ascii?Q?XNlGJZftRtGq+yQ7b6YnIhQUyzMj8FBxHXjUHbKOhsnbD7FBpxjzEjLjzYz1?=
 =?us-ascii?Q?QYR6fGnQE7rK8YhV6tF5zmTway4VqMYIzkTcDhjGvtB5hCevRMzgR1iyokNY?=
 =?us-ascii?Q?Q/Xzv1idgjqvpvbe6D1eXK3lFt2tW9AeqqobtMhsXbn+/n3clxhT+VoHaNEX?=
 =?us-ascii?Q?Is6GS7hbBs89/mU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 17:42:23.5271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee84a66-3546-4d7e-c542-08dd36552289
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8134

Add the ability to manage SOFT RESERVE iomem resources prior to them
being added to the iomem resource tree. This allows drivers, such as
CXL, to remove any pieces of the SOFT RESERVE resource that intersect
with created CXL regions.

The current approac of leaving the SOFT RESERVE resources as is can
cause failures during hotplug of devices, such as CXL, because the
resource is not available for reuse after teardown of the device.

The approach is to add SOFT RESERVE resources to a separate tree
during boot. This allows any drivers to update the SOFT RESERVE
resources before they are merged into the iomem resource tree. In
addition a notifier chain is added so that drivers can be notified
when these SOFT RESERVE resources are added to the ioeme resource
tree.

The CXL driver is modified to use a worker thread that waits for
the CXL PCI and CXL mem drivers to be loaded and for their probe
routine to complete. Then walks through any created CXL regions to
remove pieces that intersect with SOFT RESERVE resources from the
SOFT RESERVES before adding the SOFT RESERVES to the iomem tree.

The dax driver uses the new soft reserve notifier chain so it can
consume any remaining SOFT RESERVES once they're added to the
iomem tree.

v2 updates:
- Add config option SOFT_RESERVE_MANAGED to control use of the
separate srmem resource tree at boot.
- Only add SOFT RESERVE resources to the soft reserve tree during
boot, they go to the iomem resource tree after boot.
- Remove the resource trimming code in the previous patch to re-use
the existing code in kernel/resource.c
-Add functionality for the cxl acpi driver to wait for the cxl PCI
and me drivers to load.

Nathan Fontenot (4):
  kernel/resource: Introduce managed SOFT RESERVED resources
  cxl: Update Soft Reserve resources upon region creation
  dax: Update hmem resource/device registration
  Add SOFT RESERVE resource notification chain

 drivers/acpi/numa/hmat.c   |   7 +--
 drivers/cxl/Kconfig        |   1 +
 drivers/cxl/acpi.c         |  26 ++++++++++
 drivers/cxl/core/Makefile  |   2 +-
 drivers/cxl/core/region.c  |  25 +++++++++-
 drivers/cxl/core/suspend.c |  41 +++++++++++++++
 drivers/cxl/cxl.h          |   3 ++
 drivers/cxl/cxlmem.h       |   9 ----
 drivers/cxl/cxlpci.h       |   2 +
 drivers/cxl/pci.c          |   1 +
 drivers/dax/hmem/device.c  |  14 +++---
 drivers/dax/hmem/hmem.c    |  34 +++++++++++--
 include/linux/dax.h        |   9 ++--
 include/linux/ioport.h     |  20 ++++++++
 kernel/resource.c          | 100 +++++++++++++++++++++++++++++++++++--
 lib/Kconfig                |   4 ++
 16 files changed, 260 insertions(+), 38 deletions(-)

-- 
2.43.0

