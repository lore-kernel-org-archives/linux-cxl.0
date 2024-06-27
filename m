Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C9266D4;
	Thu, 27 Jun 2024 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719528412; cv=fail; b=HT8p2hgXyJl82wkUfroZ4oDl2XFmWv2jYzVvzp7aLSjb9KvgjRcQYGs+2pWCWppItamCAhOD+SNxNs5N4YuCU/hNAV/FunXHnfUF3Jyj5Uj2R61Xn3W0BDoteJKVpJ/fIyMF119d7ehcZ79ta3en2mFHH0x4Wu0Bgwnr9OtvPBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719528412; c=relaxed/simple;
	bh=Xk/U/COJhE9KQ8F3vHYU89biH/MAN18+WnuE7KJ8zV8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gMLGsTejEYjx1RIn1B5+GhylKL+reWg63zjEVD8Nre+Aub6+Tx3cetTqkr1JQdLuiLPHDsDISRKBuT4hOVfJPtKjezkrKyt6F7pD29imwfuRu/Yabe7CwZEUKY4AIPnd1Sh9lDf5naho/YON0jt+4KUA1H63waE0kQEnSVjFmXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nFNTT1xm; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nFNTT1xm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0c0dkuClZu9+hZLoNdJUEBd1DJIickn7WW8rE0N+Hr++L0MFjq/8ZFUxwsgON56Z+7Xfx36bSK6PkO7bfhhJZY+JpmsHym4s8Pc1+aedf+ORAgxZiVrsPedZS1frqOfdRGxycLAJcKzHErfbEnv77HjzxHPBSpX1FLKUu3ugGQIn7Xm1pwF+H7DkSxO1yBjdXjwaDFiB+MIYY5cG8CVb+zlGPlgudM94n94jusHx7kCLHJ1iwPgnjHloEdvWzGMuARmvkxqAckD3GvNLRly1UYYntVbHCq2IqsfSrgw0x9mIMwhBVPSXyeL3sK3+7caPuPeqOPG/DxUojFf60km3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvzG004Bs3u6FDd5r8RPyGB8JMXt5AqgJZax6DeWGU8=;
 b=KLLHQqv1IXK/1Xrq9Er8cmausL2n9CuE41dbFlO8YpUZMf9jCkHNgKn7pBFHzGu8UQaDWU7qQpwl8op23/5kWB9QU62qAByhSoqd/J1ThaZ56OCKNUJtSGYP2qFd3OlUt87TWXRS1ankLixWUxJDVGPzTxgpYVQhBFVX6zx06sCcFM5FEG6Hx1hLThkJKl1Bjo71g5UZeNypCHh+G3Nc6A874uWoJGXDvhd9LuWuU9+3h9zVkYnYJS3H95jV7bCtyHFeklsoZika2y2CVoQ+BH4pMPlc0f4isGubxltPFXI9jw1NHrhOg5Vx6TO8/4XYhcwRAAhvooGFCaQI+lS2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvzG004Bs3u6FDd5r8RPyGB8JMXt5AqgJZax6DeWGU8=;
 b=nFNTT1xmQBJn84ODjCQv7BL7W9UmdeFqERMGm6zHX9ZlNxWEXLfsuArayIyMOY6pkvFihznq12l8SgyVUlMZ0899yEvJ786zIz4tbKiU1S5v1DO06i8jHaevwHQDr6Miy38NixyAdWceIfbACB/EJTY3MsZxP0zeLZMmtNOIX+8=
Received: from DS7PR03CA0290.namprd03.prod.outlook.com (2603:10b6:5:3ad::25)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 22:46:47 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:5:3ad:cafe::2c) by DS7PR03CA0290.outlook.office365.com
 (2603:10b6:5:3ad::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25 via Frontend
 Transport; Thu, 27 Jun 2024 22:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 22:46:47 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 17:46:44 -0500
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Alison Schofield <alison.schofield@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Robert Richter
	<rrichter@amd.com>
Subject: [PATCH 0/5] cxl: Address translation for HDM decoding
Date: Fri, 28 Jun 2024 00:46:09 +0200
Message-ID: <20240627224615.854162-1-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|MW3PR12MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1205ec-81dd-4aef-4b56-08dc96fb069a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SPANVFQSluY8PPs2GSQ3TOGJ6RvrZsp2aKpFNjrHaKAEqh+ily9IK9+G17+k?=
 =?us-ascii?Q?cUymrHdSSi1sAlmFsEtqfBNOzYwEgBPjIM1e4ZCG3nQKbEnOu7MQ6vDl7+71?=
 =?us-ascii?Q?QpaHOx8XpCMXvQkkBq1Zb2ugHKVlHGNJKv2YuCfv1FMf+hjjvkssSqjBxKBC?=
 =?us-ascii?Q?mbXN02UFzil8JMjnuZNcqiz3subvDw4t4KRVe2iMYAWcK8AIft/uVFZ+8zan?=
 =?us-ascii?Q?ALcWhu3QXwUbb/Mvx+dCOV//TYA3zocdiIr11vee7hHzm0C+a2QQfQWDdYVa?=
 =?us-ascii?Q?vuVfWXSXKMhTbr7qOh6E6TMOrkc9UiyokE85gY1CML73uwlxKTlm9AqLelKR?=
 =?us-ascii?Q?NFOIAceBFsHGo38MyxNP5DA7koIxACPynzi07dRz38ZZf9Cirq6g9N9IBUbU?=
 =?us-ascii?Q?6DcFGhJICWC6jc9oHksDt6IolsPOa2qIcuujZ+leY+KKuCTS5RMrh9Ty9rAd?=
 =?us-ascii?Q?lscPByp5LbDDYmY0SMBhuftkXx5iXv9OE5mCyZnqHMqFwPzsC919/NAptog+?=
 =?us-ascii?Q?CvtuThxxQ4TL3Hd1yE2ly8USVdA2n1DiJU1Gv4kneUCnUVDA8s/bKwKd6/x4?=
 =?us-ascii?Q?cGzXjorQybZS8na5aemkjah5MCJr2zyKJor6X0GgH+TtlbccqFJ0U1Nyc8Wr?=
 =?us-ascii?Q?QgTeywDU7aqj9XsKOZJimCR2j6NoGXJIkg0pMh4VJNtBleom3D2SoVVfOysg?=
 =?us-ascii?Q?gPsPiKvEhlghPSWf6jAXR+3WAh1xGGlApiN5gcVSye69jH2ZL27vdn0wa9AD?=
 =?us-ascii?Q?dxZOn8dcG4N+p0SSjw3kgiSchYPU6BBvkd5SMZ9Nk76hFQUaxkGVCh/MSqA0?=
 =?us-ascii?Q?scLhmqkmScJyawjYk3h1n3hGa20GtTr4InFYTKcWZjVvhqaCpdWoj4+PP2oW?=
 =?us-ascii?Q?FdEJuOS7uPXx7zn7yAdDxySlaM66NwbDzIMGQR4x5KKLdNjLQd8/Pw6ALpNt?=
 =?us-ascii?Q?12aQrXj0Xr0DbH0ltrC4nxeBNsEOppdMOwpiRnMAE51j2ptoQkWVafbN2twk?=
 =?us-ascii?Q?KcBtt6yyInJ+slzMWpdbGoc+HW1zv46g9YzPInedS2nWgTWkhfOtlVaYEzmE?=
 =?us-ascii?Q?SM+vozVwf/Q2aye2JA7Bi6JnoAGSycue0ca0cK/SB+ru3nK53IHFI5eW9Pwe?=
 =?us-ascii?Q?yNhiox2SRZpUyJ/ujG6H3RBtyQtSWIHf12lf/pN49N5/tpl4PutMKWvxHwST?=
 =?us-ascii?Q?R4XJFS3DJJTGHbNv6B2dcwOh8KFKKokJkp6SfiWfxk9y6/tm4tcshWK0VwQL?=
 =?us-ascii?Q?b66FTbG8vX0nUNIE6Akef7UpOPB5T07/kbvmkM4BLVtB0L2Xo3pglBShLzJR?=
 =?us-ascii?Q?8KpGH0/mX0iH6wA5ccEX+kJkX6u8vJg0OWVQt95TcW3xmvpQQqKecfYFtuv2?=
 =?us-ascii?Q?Jpc8cq1xqokjyfpmnQ8YAsh8ifcT4NPE9p87KrjPSBw3OFJ1seDOmyyb+m5o?=
 =?us-ascii?Q?s9HAVux0hbAXHDRTstXnX5mFS59g4Olw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 22:46:47.0406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1205ec-81dd-4aef-4b56-08dc96fb069a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395

Default expectation of Linux is that HPA == SPA, which means that
hardware addresses in the decoders are the same as the kernel sees
them. However, there are platforms where this is not the case and an
address translation between decoder's (HPA) and the system's physical
addresses (SPA) is needed.

This series implements address translation for HDM decoding. The
implementation follows the rule that the representation of hardware
address ranges in the kernel are all SPA. If decoder registers (HDM
decoder cap or register range) are not SPA, a base offset must be
applied. Translation happens when accessing the registers back and
forth. After a read access an address will be converted to SPA and
before a write access the programmed address is translated from an
SPA. The decoder register access can be easily encapsulated by address
translation and thus there are only a few places where translation is
needed and the code must be changed. This is implemented in patch #2,
patch #1 is a prerequisite.

Address translation is restricted to platforms that need it. As such a
platform check is needed and a flag is introduced for this (patch #3).

For address translation the base offset must be determined for the
memory domain. Depending on the platform there are various options for
this. The address range in the CEDT's CFWMS entry of the CXL host
bridge can be used to determine the decoder's base address (patch
#4). This is enabled for AMD Zen4 platforms (patch #5).

Robert Richter (5):
  cxl/hdm: Moving HDM specific code to core/hdm.c.
  cxl/hdm: Implement address translation for HDM decoding
  cxl/acpi: Add platform flag for HPA address translation
  cxl/hdm: Setup HPA base for address translation using the HPA window
    in CFMWS
  cxl/acpi: Enable address translation for Zen4 platforms

 drivers/cxl/acpi.c      |  16 +++
 drivers/cxl/core/core.h |   2 +
 drivers/cxl/core/hdm.c  | 245 ++++++++++++++++++++++++++++++++++++++--
 drivers/cxl/core/pci.c  | 119 +------------------
 drivers/cxl/cxl.h       |   2 +
 drivers/cxl/cxlmem.h    |   4 +
 drivers/cxl/cxlpci.h    |   3 -
 7 files changed, 262 insertions(+), 129 deletions(-)


base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.39.2

