Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ABD16E88E;
	Mon,  1 Jul 2024 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856101; cv=fail; b=j1fWpoTt4XVEe5ElPVZsQpr6D2Pc7I09sUEfG57JTT8MTUM83+eK2HI7CFMTqqTOnb7/C7gpvsz8HTuNu7Bc2QMN4oiDZhgH48vIAqAHZpeB+bJ6SIE2upjbMpbbWH+/X1gOcIa51LOAaIeVtVh/1m4DPW91SxQtXi4X83PEAu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856101; c=relaxed/simple;
	bh=9lqicBwBn5yaavz+XmeBH1EuLvW07GF6DaNIMTv2sJk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uf4kHCk4/aB/5XElWcGR3H9L5jg85WADxnA3Y4BwnTQLeXwO4zolkDZWP7sixMUXBzcU/GpxrSJxhR8OnHQ1ivMJCzSn0bniKMwdAVzATqbiNA2zn5RW33nbQdyaKnKVF9E4hbtfMakNdphZG7x7E04UhXmV3agv6P3Xzco+Yxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MoIAxjrP; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MoIAxjrP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NP7E6niP0LHjVoDma7Gio29emcwS/Aj7QDnDrZOtgHGFryftNcexqh2oSncz306StRW/ZCQfJr2yP3OZ7Mzy/IwSAPtb75vpWw2y6R81XWRM1eFSl+eoteSZrpW23JVKF68IlFxiw8dwyAvvKBchhVV+GV6F8vF/DrYRyPpavjGH2t9GfC1S4UeNQTXY7nsvLUHdAUUVoxgUFIN4CygFmCkNrC9jIjb6NdmSJ/tNppOU5IvmzemzSFt1RSyicdvzOoU5fCpiwselWSVsbinHUTHTlE2ntKecC9mK+sVxfBZ6PTsH0hgDprTEzC0hBI++YJMknabEGPiDvfAEkMCC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ie84NQW5PxEGF8XhijxjghJ4NKD8N+jfzaeIilnlnT4=;
 b=DxIVkBI9vzShxciHKMDv2T/gbxiLct6HRMP/4dBWoleLAh2U7EVJO++4kvSAhjsBVPZkolZ8zq00Q7yUJkXTbrdvtmqB3TlXVMCxmrvW6hPaCgqS0Wt5WNWW64kk8p4jK8vGFOQILSjgpxwwfR+zY0mfSIm/tQ/JJTUcU1EArS3qmVNjUxuw706p4xeAZNgUYMtgmkfWPziF7vE42u90MleLoQMxNiV4G4frHoEFHn1hOFrlJSA+9qj1eXHW+w3bWq7m7HfULw7ifY4LV2iUEGk69iFuKRbHQ+Zv+IkuDtSMmGWc7ZDoyEtkQjPLnwgNPNx1upq3NloQSruzv/DITA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ie84NQW5PxEGF8XhijxjghJ4NKD8N+jfzaeIilnlnT4=;
 b=MoIAxjrPjfcs55SDC4sEkytB3BavdiCsU9OWQydw/yLC/NmIYxElAs7uY0KAXkhxMGXXITigPfwnNHNCCOLVzVROSxnMiX+Ff/E5Phgq/wUrmjI7O6RI2U2/fvq0tv7pkULbZvDcrbaTzUaHWQgpXVUEZQ1I172Q9u1Cb1tZRwM=
Received: from PH8PR02CA0007.namprd02.prod.outlook.com (2603:10b6:510:2d0::18)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 17:48:17 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::4b) by PH8PR02CA0007.outlook.office365.com
 (2603:10b6:510:2d0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32 via Frontend
 Transport; Mon, 1 Jul 2024 17:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 17:48:16 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 12:48:14 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Robert
 Richter" <rrichter@amd.com>
Subject: [PATCH v2 0/5] Address translation for HDM decoding
Date: Mon, 1 Jul 2024 19:47:48 +0200
Message-ID: <20240701174754.967954-1-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: edb9eab2-9ae6-4bcf-666e-08dc99f5fcf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N454frIMhDGaMVBG4qNijkf17BYqWGpnTt1hFjz5jbVYzpXBjWnnoVEAeXGF?=
 =?us-ascii?Q?Yy4jqZVuXV/jhRHmt+HmbUV19+oe14vmqWl348e76qQq1eghN5jhalUPmTRq?=
 =?us-ascii?Q?7D2dkaKylfxv9Goq7ySzqTgmcEYzyLfCGDIlmQWWAD/nxp6IEQ3w0EAMkDcU?=
 =?us-ascii?Q?hn1TQC/nRLGMJgyvg3UgXmjaYeqiAlS1VgAbznkG98Liv6xKbRb4/Ve/3cnC?=
 =?us-ascii?Q?LxGI+/69mSAvMfLH1R0sjdqYK9ffkkqgrt2QO2qXwXHbCeTeBB87NnmaXw96?=
 =?us-ascii?Q?xUlVKvfrs4c7VcFH5KKR2AN52ZvPOP3PIw2Br1am7Gt3lnxXxj7FUWfK6zEx?=
 =?us-ascii?Q?zLC6n7D+P5iEirbRPEr5Djnsk0CfL5ZcIVyRkatF75I5mEBllrAODCUxgwBX?=
 =?us-ascii?Q?DBlIP2IG+/xJwTZM1jC/UKdDQBVRTohPfo3zgq8LxHQoci5fr91VAr5gYQXl?=
 =?us-ascii?Q?WlQuwPHH31RJ6RWRbF1CSbEYG1heGxtfHHgwu2FsiLtmKEZNCI4t/z5MTEwR?=
 =?us-ascii?Q?ox1X5QVFBvz2azdyb7aWa7yO7DIIADbf+PjF38OBtVJq7qydqkwr9DXchzFc?=
 =?us-ascii?Q?/9lshOSU3jILXCo6v15DvPGeH0pzw2EkkbJJxfkxleBpJZau6pSZn9+aQSfZ?=
 =?us-ascii?Q?d2QbWHQPX7hdT449DvPryfK0592uTPF7sKX8hUP5/Ed7FzkSTZRRgGmni3Yg?=
 =?us-ascii?Q?lx7wFIsLSpRRIH0yKzlCp6ZXre8n861f/Oi3e29tbeAjXWFinA1FdbAOWHhb?=
 =?us-ascii?Q?LfpssMhNXTnIl/h1sXWMYXLsHr3g3G39tGC9Tqn6w9e/dHO/ftHc271yZN9D?=
 =?us-ascii?Q?mEQIz7cd52D+mGe+ynwyre40GJASORXfX/deLVOtU2CjxEhR6nyi3ERtfshL?=
 =?us-ascii?Q?u9K2Q116YcoYDrE+iu2eQzNG3qKUWA4fUA0IiCfVU817q7nCTVfnEyp0g3L6?=
 =?us-ascii?Q?xuqtVXVn8XdQLHBjYwqvoDCkDuhriSuqV67Je8k9faE1epdJt48T4uJpbhDG?=
 =?us-ascii?Q?coyriBss/z5BlR0ra5zMu53CjYrfpL298AfK2/bY75C5wz29rSpa1uk/QwNy?=
 =?us-ascii?Q?7yW5X9Et0e6YMFR8hJlsBzGH+IuF+QfpcnImcPvS6kPQvzla2jV+gYd1nQ2i?=
 =?us-ascii?Q?9QIEr1jj3Ek0PYGEU16L2GD6AcmLtrfgTcUUxji8TB23t7T6bHt7aLb6ffdk?=
 =?us-ascii?Q?099FedIorhu7d3JnfEryPj5SNV71m9CTdPOXwHOQ1lrW5NPQw1JPIUVYuq5W?=
 =?us-ascii?Q?mXumw1rRhXVQGeM16jA68CPmfdppzbV3K6H47oOwojVnsI/pMsvtkKuRpN9t?=
 =?us-ascii?Q?2UpOh9jBBHK4dqZCmZ2Kv+kiSnevfy+HdVq3lj1F8ScWOgwjgXVLu3ZEBJwl?=
 =?us-ascii?Q?I+UQ937XL30jY0tChO/ZPbQgiZb9aZzikvT9fymUYMlVKxrA+Ke7+lpmA8t5?=
 =?us-ascii?Q?G7eCcvgE+NJcoIiguKc8xirPgd7vJBHM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 17:48:16.9095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb9eab2-9ae6-4bcf-666e-08dc99f5fcf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103

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

Changelog:

v2:
 * Fixed build error for other archs [kbot]


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

