Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FA12066CB;
	Wed,  5 Mar 2025 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169074; cv=fail; b=g2hrmmMhtngKTi0WCnm/OdgRtjiluFAwr3DOLmEdHfTY2tNf9Hp51+plsL4GILRe8yL/oZNUBISMkw4AZemU+k8qOJJ2T1f4p8ORcB/x7Jm0K/aiT8kl4KgvYRfnJPy9TGhBfwUOqMxCC2GLPXk3K9wADc1YYlV5Eyktx2doDL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169074; c=relaxed/simple;
	bh=ytKTmbbthJYLorl5CoASnmB3SLBEM3HmcNW4kG6l0i4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hJNyvSV3x3BsR4yqXhSTb7smpiprRkFQJtG8TCJz3X65+zd0gtY4ko9s/40dPk3RWic+n5/suJVnkw/TI9PMHnUcpNFjvxeGMlqk5TWPvUccOtcKC6DP/ZmsGQnarFQMGgZsyG50pSRp4e6ueOSUKXGX0twP9v4pI+QJy7Bqprg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O7F/oCLc; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O7F/oCLc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQfjVOVF/tjRXL9/oF/ZqXD76d7OjaZAcnimNomqIarj1/Q/IBwcySDjMHtMzB3Ta/EyIKDpZrsO06FsaGDUDCGl/EDyqkhKSiN+1/jl21mGdvOEygVd0CSWsNJNiLAOJoBrBL/rV3jdz57ExSHdtr1QR+wa6ELZdLZ7pTLqKpgQ6EYVQlu0976fF85w44CuL662JGAhliqwtZO1jFKt5ASu5V19emT0Q4mOOGrivX/cw3HYyI8VBIqAFUmIdKlQSl9xtPVyXtqSJTVt49gUXoFKkxINyt1ZLCjetqOVPj+pjEVy4Emnm2fsiQtB/k29XBUiZ6y+BlZXaN3I5KJHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjF+htxNyPCGYsSmRvENj+XublfHTJwjZVZVRcR0Mi4=;
 b=na8xCI98727HZiBXygJx151nmd/HXIpejx2wvriu3wNhiMxjCdNN7gfnpC8biR9Ljr08snQiBQfY7wGWAAX0r0Lp1nOWZiqYptyZwK5CeQxv2t273r01wfJQteov6cDq78jDzb4C2vgELqBlq7ZdgmR3XnhSRDoVbYrs2IvSjK9RDqzF2Ywwh30XRHsOMFFrCfSSaxyQ0agLs8slJEruT6JIqXR5rEhc7h+F5skZbBDih/8Rna1m2bMxu+67HTW0x7wrorVbMrRk8nBUGm1ldtw/mYIe8Y6ILXsUIThYVFhJDd4JRmbGCvGhrKDcDtpai3nwM/T7pFKm/Kk0dPW6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjF+htxNyPCGYsSmRvENj+XublfHTJwjZVZVRcR0Mi4=;
 b=O7F/oCLcIHYCQlPhC84iR4asZzVyU7zedq4wtvkI+cYi4gUGh+Q/+GjCUOr8KOuBFQH6GjyFDTZTAiwh4bgG2gsmUn+uHF6qTPkfOik53HjvWazk1HFIsDbVnkUzPJimUltgjauTq/mZtBeRxrYduDkxFVSkFPAKHbblGP93w/8=
Received: from BLAPR03CA0100.namprd03.prod.outlook.com (2603:10b6:208:32a::15)
 by PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 10:04:28 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:32a:cafe::5b) by BLAPR03CA0100.outlook.office365.com
 (2603:10b6:208:32a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 10:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.4 via Frontend Transport; Wed, 5 Mar 2025 10:04:27 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 04:02:03 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, Terry Bowman <terry.bowman@amd.com>, Robert Richter
	<rrichter@amd.com>
Subject: [PATCH 0/2] cxl/pci: Inactive downstream port handling
Date: Wed, 5 Mar 2025 11:01:21 +0100
Message-ID: <20250305100123.3077031-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|PH7PR12MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d732f4d-1c69-4419-3faf-08dd5bcd1d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q0nGmO00CfdJc/8dGCLDOte6KYYwrKCBPB2r8u8ONtKSmveiqpPUuGad43br?=
 =?us-ascii?Q?rhRywhgPoOe4FiDMcvH3e3UfTL9yIo4oKbY9/Mzo+CfzdRLTkQaBPAMDv1Ap?=
 =?us-ascii?Q?ivIJ3ambVTMcUsiT5xHpUnIx2yPKfj/RHG/UGYhdaxZOb0XcoOaaaoBy8+Tp?=
 =?us-ascii?Q?PV7APoqf+HGxFgtH9X2OLAY6QRgByZg4E+I5IkofeSpcbXf/YYUaU/5DetV4?=
 =?us-ascii?Q?xlS4uA28VEFkIOi4SBgs4W9nQkOq9bX0FwSOU/+8oMkWIa1kEuHaDhQ4Qjww?=
 =?us-ascii?Q?xTj69NeNqeomeksDqfXqSKqCo2AYTamVOqHv2I0yscnDi6YkbFh4cr4FFOBa?=
 =?us-ascii?Q?Datmr96mBV8zm8andPz3nGdvMcUJsxQPtHYuTPu1yaN1CXQcIXgVyCbpjlLi?=
 =?us-ascii?Q?L+h1hEui4d1EeCxnlW6wuHBI7PcUk1xWM7jMRZeF0RKOGqgXzP0IzzvJnMK8?=
 =?us-ascii?Q?82+BJ8XD8xexACUofkkYfcjpweGHZRUYksQ0DsIzCw9itB6LEG8mt7Esyf3n?=
 =?us-ascii?Q?yEOAhh7ZXVcsSqD8IroRlHqP5gUXZ3RWivv7nwuSZU2ze5aX7bMbr686/IgX?=
 =?us-ascii?Q?mHvjD02PSnNkF4fqPhwU5sUwc+DJg90FqSjHkI6d7cNvsHLS7TSl5MkRG8BR?=
 =?us-ascii?Q?3TChb4barIIlU/Ed4vPPdtjhXoR5p4mFWoEAMSLTJehH4fR65BPfQOdhUjvP?=
 =?us-ascii?Q?RBQd7SXMd0J9KQnX/Xu97a4u9FGgBi4064l2zkzYNkquCLIjb418pGgnpY4y?=
 =?us-ascii?Q?YbZjhGWiNWJPPipbxJAHVZm2NsWWEkeh6DaeysUU6wllUf1ZPD0n/T0NWBDG?=
 =?us-ascii?Q?CQnN7mw4WnmH0A+ldgAIz/BVW9zUPiGlqXDq+RHM4qAJF9j0LVOtxdtZTW4K?=
 =?us-ascii?Q?ZEVTUKrxGw67mh//3FUNZJ4MfFaGSoHO86lQCUkAkbMO6VKKGfWTGKlSTf5u?=
 =?us-ascii?Q?clNtBYmQETATQxteG6/tJ+OV+VZci7hWHwzn2Tr1GMxxylA77H6ijvPcMpma?=
 =?us-ascii?Q?GvZC+RwJkeplMKaMZIQgltLNYbo/MXLeKHPmH+ftE1UpLdHwFYPEh9d5IL+q?=
 =?us-ascii?Q?8PnubNB6VEh27Z66mmUzUWu9k99D+QSY/VD+4OaPSX8pYUad9Y8MFZsY5O4K?=
 =?us-ascii?Q?RbVWE53mYLcMbuDMJQUbk0Cu4jdXR+5cr+gmfygrF4TmiOo6Fq2S3jDdTbLq?=
 =?us-ascii?Q?Igr01Ph3ND4S7gAtBQJvUQJX5SpIRFnF93bpUj0+9DixC3K9aedaZiZDpbxT?=
 =?us-ascii?Q?HstxAUE7WxVm6fl1cTb3SFiq//quhvNGgu/oWTkJo6JXzH52olwyPp3H+ruR?=
 =?us-ascii?Q?1gfLuK2Ww38vtoFP7zMt64Mp0f+xb9Lv+kcdxoF7sjfeQ8KnQfKsybqqEn88?=
 =?us-ascii?Q?9Wl4hmVSy7sPpOfR290sNcF4VSeOk1aYQvMQ6v0Mg6zMmPWy3ZGCT97Q96nK?=
 =?us-ascii?Q?VgNnwzO239H5mR3rX9p2AGfMJFTy6Yq43a4Av6jq3CdbaF0UjweMkfJnGE2H?=
 =?us-ascii?Q?imYHCC/P75lh7xk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 10:04:27.7049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d732f4d-1c69-4419-3faf-08dd5bcd1d7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5902

A small series with individual patches to handle inactive downstream
ports during enumeration. First patch changes downstream port
enumeration to ignore those with duplicate port IDs. Second patch only
enables active downstream ports with the link status up.

Patches are independent each and can be applied individually.

Robert Richter (2):
  cxl/pci: Ignore downstream ports with duplicate port IDs
  cxl/pci: Check link status and only enable active dports

 drivers/cxl/core/pci.c  | 40 ++++++++++++++++++++++++++++++++++------
 drivers/cxl/core/port.c |  2 +-
 2 files changed, 35 insertions(+), 7 deletions(-)


-- 
2.39.5

