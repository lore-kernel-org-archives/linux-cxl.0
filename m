Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012054.outbound.protection.outlook.com [40.107.200.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D385B2DAFB9;
	Thu, 13 Nov 2025 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032550; cv=fail; b=B2+KmeTUf32/UGNiMab/XIkCLfuJ69TtH0DA7vCKOPdXl/mhDXpdDRRwGkANnmWG63P5mK3asKMYYpB91ReGhUvmfzWgQjG/Bjs2PkNqlfORDmczXj6cnSX2AegDQYgQBOJGfKhBTLLv/x3QUdd8W/RJD8mSRHTNu8Wd9qXqXzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032550; c=relaxed/simple;
	bh=5VEIdivMQ+hXWrISndlrMsYMPrFeYTBDqw6DDHg4YVE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MXLLAnRF6C2ATvIvWfip1MFMmOT8lt7M6+VcW66Wl49lqyK+2wjvS/DulokJ5viNSJXP+lY5IWwQfsjyftWaDw04TwfPzJYNVJAZwJbdg222zzjpLuNbkITV9/3NVZxYvdgivlkUJ7SAY+9liKLsGxoMay1Lcdiz2QzRHikEZnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w9uR2d7p; arc=fail smtp.client-ip=40.107.200.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w9uR2d7p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4JRd75IoFozQHWzh00YuXodhydzz+Uo32smpCOgxP8odeYRi5aC/2Vl+61ElQZKZ2S9Zoycs+6GCWMG/KVM/MuU5r7wkVXHrKZiioTPkbX+93D039I0AyA3hMuTL6/atUhTV7oQ+0VGnk4lRqX8hqdDRSzSFktd9NIq6GqpVXztbnSPDs/YM7BtprWPL5MN0oLIX0CjAA22YUGF2f0uWor0FiuGvYoQDafVsbfQCy20I90qp7i475E4xAsGR1ldRKnIeUmogY6YvbD33PI+F6NARBUNIl2Do19BRESNq2oHfqtpj/XxgpCJwFg0MqX+1n5C738HUssQMuaaKbtogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3YViuoUUGhh6jG91NAvb5oxNnRmg5VD2yC3Jr2e8Uw=;
 b=ygWoNbusoqHZimSq/T4kZc+2zEp5hcFI9zEXRjoQwu9L8VEyWXg6KLQHAAivY9g8tI1vxOB+rxUMKUQ1Wn5Yfsmcg+BpGyWQ9w8dAazrkFDzphKhYTKciYl68rbLMD621i3UP9PNBZT+AxGJFm8H7uGgClUAU0qdbCOEwBY8GSYHLB/E/r8P5/fCr9+wc3e7SLhKy2WXo8lCleIsWIWl33MTrULcUg5/3I7a3rPrFZUV7vdgUdQh/1YTGfrK5zCGIl1FDND3OX3Ujmhok50gQO8YvG2c2aTP5i9Q3ZkXBxY+D/wqCWvlzQgpbUY5ux822FTmtK8hqlTD14p+pCdXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3YViuoUUGhh6jG91NAvb5oxNnRmg5VD2yC3Jr2e8Uw=;
 b=w9uR2d7pVlfMLhtsIkSv37zJc8PCNegHItbvMT12SblYJYqClwAErmwsu5Genqyr4tcgN8usc6GsRrZLdnCV40nCUq6EUJ6e3v6QXKmu5nHoy/33FK5uTDHi5OfiuhUKKhD3toUzkPHs7wTaPzM+Dc+rAoUMeOgXK1y12j7kZcw=
Received: from PH7P220CA0149.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::19)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 11:15:44 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::12) by PH7P220CA0149.outlook.office365.com
 (2603:10b6:510:327::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 11:15:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 11:15:44 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 03:15:41 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 0/3] CXL updates for v6.19
Date: Thu, 13 Nov 2025 12:15:20 +0100
Message-ID: <20251113111525.1291608-1-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 66833cf4-f327-45e7-0962-08de22a5fce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IuIN1Anyen/VMUUcvS+aTTDXOwqR9Pw/Gd57vrFhLvgits2zjpo8TenKZFZ5?=
 =?us-ascii?Q?4WCgHTIXQZ62wBi1QiLA1pocg3lojxRadPucg59XKTaUJaAqvVFoFQ6AUvdK?=
 =?us-ascii?Q?xt3c1b9S/NAy5VjV1RlQsQFytEi+hw/5rYCY3OkLlozBQApCS4XCEw4QJulT?=
 =?us-ascii?Q?AvBzuOYnP8gjcV+Xs6aTXrG8DjLhyNWJlP+zpUWgYTbjitCVwqIJAs1psnFb?=
 =?us-ascii?Q?dridTYaRl2+081UtcZTX2fky9ghMfE5u5LWwIQPQHkB0nQ9X87dFcYqkErs6?=
 =?us-ascii?Q?zXFcXdy8Z8UXl8CA1LDozHwi9medN8kfhRTjX2nkqCwS3V/5P6MOIUrZup/3?=
 =?us-ascii?Q?xPgDv5ZNi6KZZ8IQ6+N5/COIT0FVb1dgojS29xZzTngzN5zi0vTlYUSgkm3K?=
 =?us-ascii?Q?Wwv9MjoO0FBCEpTLydi0IGRAloujb3htIi4mfqG7wpD82qOpwcSkje1DSchf?=
 =?us-ascii?Q?zcPCc4InAiLgfNY4Nw3V165MHprB6j/yB+nMPQnEVjOamgGxznWglka3lmYe?=
 =?us-ascii?Q?dMKBLgvGoDw8d4vCr35ukJAtkuREodJ0CrwCuZkQvOprvuD2U5OYk1dS8o7q?=
 =?us-ascii?Q?HXl2uB0aIFYsTEGDo0z8auADZ5DEzLrG2Aij5poE6tXBQaG1Cnt7JYdPhU8b?=
 =?us-ascii?Q?hx4+nUCipO6YC4tdhftAeXk/X7kILeZGR1KymN1j7dzpDOEulLHlQljJjnu6?=
 =?us-ascii?Q?92Aqo/yCdawR2g0ZbGVE9i2EgtFSTwzWvYmxht5wgJg9Sz0Tt9LG1SiWAljo?=
 =?us-ascii?Q?sA9ym33v/IL1D7ccnIj2RckCwPgjOUYu1eQhVbSrUXK8IORzq94Xmcn2ir8Y?=
 =?us-ascii?Q?bLW6H7S6mzbIjxBy8xAuVE4r5cl9djYtpjXF9p1J2Z3QuipJOACUNT2NIMFR?=
 =?us-ascii?Q?R9j8WfrkwEXQVd+id4OXtF8466dqfnQylsbt4DwaomNH7gyJ7aCx/Y5YWiSd?=
 =?us-ascii?Q?W+CzfxdXSNxXDOWf4XlNRKV0FZnQL8FqVguV+uQNrldJg4Bh/OPeoQhQqGdb?=
 =?us-ascii?Q?CkhN2JqBEOpXq9XKhWnBxQ2lsm3B/xaLziwKS4gLtpmZfnvK9WdfL0WuAu+R?=
 =?us-ascii?Q?puqpIaRZpNakV/zxFBAgxVXbTCezImbtTZGeD5p3yluQybqffpqZwCSs4Smq?=
 =?us-ascii?Q?pmWd8U9OKtKD9OHyR3uHWmuXTQX9L4uMrVuezDQ+3aEwVHh4m2RRVJc/kcdP?=
 =?us-ascii?Q?LV2Wk6rZPqIwzcKEL7Ru18zUb3leUwgQHuM9Jbg+1Nkv31e4qEEVUi4GJmrD?=
 =?us-ascii?Q?srM4xad8jpYIqylyhGII57Ynz+7b+P1/Uk3KKB08k+xvizERbfs0+mqQv3Lz?=
 =?us-ascii?Q?N4i0djkutU51LDIARiQRqy+jJUh/DiMISxvAdKhPttR9VsQk0MKa7FPbgsNz?=
 =?us-ascii?Q?oXTihETCPpObislBpph17nX6racpyZldQ//fHfKowtuhtSJtu6JrMq6ocgkj?=
 =?us-ascii?Q?e18REKErzxoL1e5wDGHPPQn2+c/nuvlpeNdpDsW0dwFOrVly+fUz872kvwvr?=
 =?us-ascii?Q?afGlqV5p/HinHUOpbQxGaUtJYcP0oJfUNLW1GCQOShnMgw/TMuVDnecVFc7L?=
 =?us-ascii?Q?iLVmDRARN0BT8HTuYhY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:15:44.0216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66833cf4-f327-45e7-0962-08de22a5fce3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461

Sending optional and rather independent patches from v5 of the CXL
address translation series [1] separately in this series. The patches
could be applied together with early pick up candidates from the
address translation series (namely patch #1 to #4 or #5).

[1] https://patchwork.kernel.org/project/cxl/cover/20251112203143.1269944-1-rrichter@amd.com/

V2:
 * updated sob-chain,
 * spell fixes in description of patch #1,

Robert Richter (3):
  cxl: Simplify cxl_rd_ops allocation and handling
  cxl/acpi: Group xor arithmetric setup code in a single block
  cxl/region: Remove local variable @inc in cxl_port_setup_targets()

 drivers/cxl/acpi.c        | 15 ++++-----------
 drivers/cxl/core/region.c | 25 +++++++------------------
 drivers/cxl/cxl.h         |  2 +-
 3 files changed, 12 insertions(+), 30 deletions(-)

-- 
2.47.3

