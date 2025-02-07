Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D481EEA23;
	Fri,  7 Feb 2025 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942704; cv=fail; b=aQ7pyI/iWnGxjej6RTuza6sVeECQdQJsfpYtoAoKDVO+XJo1zODFbwEvO+w9BpqirxD3UUFtPtI/I+WUWKqOSfIcv1jV5luYtl3/V9QaRNqCmrCbhZcua6jg98eLxI1NS2CdVZhnJCUfekV/+b6a7S4Ro3FJjJ6xbHssteRN6wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942704; c=relaxed/simple;
	bh=5P08ZJXtcQrLPFKBu6u0L/RL+jPUc36xAxSKQWM+Oe0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pD/4Xd/o8dykByFgWUnpbj3GroEpztcRip8Thq0x87KrpCO4lu8kTH2roOK1AYQPh4a1r/jrXAzAmJsUIer4mRh49q8p/194bH7qJLIrByFGcOacXGFOWo1Smxg96u08RyrlDsQaGap4tZZ4leb4eMTC2qWNdiOmS/KeZEpkzUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x9EVM4t/; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x9EVM4t/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8NrAbitIgCbIZmrEYzACBQ2GgBViSr0eenzpYJ8cJt0Dd5A3s7VRM9jm9VoW8KRj/GHzsrqgl7ioEFf5c8Teki6xWs2TlV7DFIHLXcmlbXhk3UeM27FPiy9cS3svFgRRqvf50ecuE0rkVGQccFLbgnEEdzmr7LAMdHv333q98N8vs7NFxTqkbliwStTULJtQ9YpeRy2rzixlwJb25b7UeF5RFRjitrkOitMlgSvO744cRY6AgWK1zjR1wc14ttw9wQl2OA6QvQUvXlsD0/gVNb7WLbrndGInR+F/U0brF+6WKSCBl5WKBRKOE1LAjToL7k32kdY3qZrg4xLZBzJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4Y3jLT3PzCsBd1KOsVhsZQ4N2lXeAGhbmHVmz6Qlb4=;
 b=u4m0UIDXW+vwTqd+XcYgj2xasHPAykwKEL1HB0RJWfatIUQRbbD5jnOy2OT6GjElU0+xNaZeGE8o9IDjPXxI+Ag8H55pj5IkUahVurkm9tdsBNTpe+vQm+i8yTaavJ9f3ZsZ/vD1ZGcrOvJ4hIojFh56VqmTHrKaABnFy0pMmu4Z/YbXvsAio7B/lEJeW0yb/4E/WiEXcLwij8zbBxtbT6j5yPe3MNhYw0Mh6D1HIbH/Hwi/9YlJkRO63gulLky6klEOSVdGVhz/JVSBOx4wwdXUM+WybSWgWKHUZOteXysZIPsgHdlUdYgentrEmwN3iNGYJ3DSX/oSZ5H2kwCZmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4Y3jLT3PzCsBd1KOsVhsZQ4N2lXeAGhbmHVmz6Qlb4=;
 b=x9EVM4t/QNGy5WtvYA7QNvTxguhNydDs3dfbIwRuzsx4PgWelnxc+HyNeN6XiJIztdO4RmwUQ7imLK7LafQ7GK2+LPHKVNFZ1l7WrYxGRDzGpnvoa/V6grLhORCr2Ptp1fomkW7ePhajwqfH+w9iYfonl+2Hys7XyKE6bNoFiC4=
Received: from MW4PR04CA0097.namprd04.prod.outlook.com (2603:10b6:303:83::12)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Fri, 7 Feb
 2025 15:38:17 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::35) by MW4PR04CA0097.outlook.office365.com
 (2603:10b6:303:83::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Fri,
 7 Feb 2025 15:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 15:38:17 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 09:38:13 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 00/18] cxl: Address translation support, part 1: Cleanups and refactoring
Date: Fri, 7 Feb 2025 16:37:35 +0100
Message-ID: <20250207153753.418849-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: b40353ca-f872-4087-bafd-08dd478d718e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aKdd39ZuqEJQriuFTme8uFAI+GY1Zi8e/zwcXoURV0IYm/3UzBJ6Bvym4Ctn?=
 =?us-ascii?Q?C/ZxkjuepacoR3ecJv+xcZ57RqLPcuW0f2guxYgZjZWSbgUF/yY7bjboNwDH?=
 =?us-ascii?Q?iQvliEJA/fM+Tf5UHKM4rmnzafSGPzdWgTObXsxyWtA/66W/GUtzlGTDoQoW?=
 =?us-ascii?Q?8QPW+DFogIBBs3SRHZJOahbcc37IGhNKENs4Z2DjjOAzR7uAuScqqBc1woPR?=
 =?us-ascii?Q?+c2vJ9XMnOzD6HvyzDCBmm0BCX4TjOPFRNMNh3Sr+MvVNz+ermA5UAoKeODy?=
 =?us-ascii?Q?nXP8bLXshi/lPAsDb85kka0iG6UVroxNY60rtELUx43t0K24+WGqwuoDJoTL?=
 =?us-ascii?Q?KczIDNMbym14skcdCulwNZ16umlGgQ2n9RwGWETkdX9tdrHbztd3Fr7r1pRp?=
 =?us-ascii?Q?9NO1lswqWOgrlZw+6MG/r0puglxEFuRH5miBGVGUb+a80T6DL+k3/3bkscw7?=
 =?us-ascii?Q?KwUrhMKqCFIBziSAo5U9mSI/eqOYDTM5X95/VJWdLyXmllTIJeGrH6UBkeXK?=
 =?us-ascii?Q?z6l8WpI0T7nLZVLhwoJy0seG1rN2FTwiSX/6Ix3+4YjplkUoHZAUc1Neud/s?=
 =?us-ascii?Q?qXsPzPNTiLuof69NTt/0G8vV5w834geCj22VR0lJqltIdN7fAUTH0/WY86fc?=
 =?us-ascii?Q?2lYCvxO4X+TlNZQCKRPzsYN7m8COxcBWi1cKeZVkgRip/aMLr4eaBlP51Jb9?=
 =?us-ascii?Q?LwgvsXLq5NotsrKI4CyUNpvqWWVaUW47qNuLHHrXkneVwE05m9wbzwoe90cs?=
 =?us-ascii?Q?ygaOE/5t6WVIZQS3TkLB85xFDR6yLk77TtuD2axkSrmyZGiR2Xdd3AiKpVRQ?=
 =?us-ascii?Q?kuPUuh29o9CPseSua9JVr/7JGPiSljybxUiRaIbBkrJWXIBsLBLQt3yT9v+N?=
 =?us-ascii?Q?CncdXC5HbXkhrnlfmlG+SKjj53KT30nadVj0AQ8bhSoW/zyFUlJOuMVpdcSy?=
 =?us-ascii?Q?wP3QRqXP+/v8vMEva4Q9cCIOE0pVU7b02n62Tl125HyzlmPx65wqWFWRQ/ND?=
 =?us-ascii?Q?WLJPt1IIGREqhTMaAITNPi2UkgT6e8vnssPcK1SXIxVGoCClkNJ4UqhHt9iG?=
 =?us-ascii?Q?Szp8hYtc9ygWx0uhhQOPnONhcB4THQDQJphFwkTsQ8uG0X3olbo6uvZu0qc5?=
 =?us-ascii?Q?UsNuFxnKNFKVh/WIF4hCdgfrCjC6ZoZH5/Im+I68y82cOGVkXRuRcCfndoIS?=
 =?us-ascii?Q?z6W9/nI/wYSjHXbc+sNyZD9Af9wvl3kGBDNjB6epcPsh1I4PlnTx2cBu9im3?=
 =?us-ascii?Q?8PR2rUGlEoNtygT+CINWrIRNHoicVfBQ3Ecbe2aVDGuxk59MMNugWWZ44eiO?=
 =?us-ascii?Q?/IFiUBulcJMlVPsuDvd4AQa6OlkwTDfREpaSeZuHDEqGRy9HW8C6A2/dFIlS?=
 =?us-ascii?Q?XYhDrb07dicyQkvduUXQqrpHTTw7trT5Y6veYgYMp2nOa99IrW9WG3I0WDwp?=
 =?us-ascii?Q?tN/SrXoOK2l1DRnPARf+OLDtg8WRM0W8CWy9p9fndPG6M+YnzwH/no+j+6Hn?=
 =?us-ascii?Q?qCwlP6byAGw4ls4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:38:17.5899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b40353ca-f872-4087-bafd-08dd478d718e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291

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

 * Patches 2-4: Cleanups and comments around cxl_hdm_decode_init().

 * Patches 5, 6, 13: Adding and modifying helper functions.

 * Patches 7-12, 14: Refactoring of endpoint decoder setup.

 * Patches 15-18: Adding and modifying debug messages.

Most of the patches were part of my first submission of v1 [1], some
of them were already reviewed.

[1] https://lore.kernel.org/linux-cxl/20250107141015.3367194-1-rrichter@amd.com/

V2:
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

Robert Richter (18):
  cxl: Remove else after return
  cxl/pci: Moving code in cxl_hdm_decode_init()
  cxl/pci: cxl_hdm_decode_init: Move comment
  cxl/pci: Add comments to cxl_hdm_decode_init()
  cxl: Introduce parent_port_of() helper
  cxl/region: Rename function to cxl_find_decoder_early()
  cxl/region: Avoid duplicate call of cxl_find_decoder_early()
  cxl/region: Move find_cxl_root() to cxl_add_to_region()
  cxl/region: Factor out code to find the root decoder
  cxl/region: Factor out code to find a root decoder's region
  cxl/region: Split region registration into an initialization and
    adding part
  cxl/region: Use iterator to find the root port in
    cxl_find_root_decoder()
  cxl/region: Add function to find a port's switch decoder by range
  cxl/region: Unfold cxl_find_root_decoder() into
    cxl_endpoint_decoder_initialize()
  cxl/region: Show message on registration failure
  cxl/region: Show message on broken target list
  cxl: Show message when a decoder was added to a port
  cxl/acpi: Unify CFMWS memory log messages with SRAT messages

 drivers/cxl/acpi.c        |  12 ++-
 drivers/cxl/core/cdat.c   |   2 +-
 drivers/cxl/core/hdm.c    |   3 +-
 drivers/cxl/core/pci.c    |  44 +++++----
 drivers/cxl/core/port.c   |  15 +--
 drivers/cxl/core/region.c | 190 +++++++++++++++++++++++++-------------
 drivers/cxl/cxl.h         |   9 +-
 drivers/cxl/port.c        |  22 ++---
 8 files changed, 187 insertions(+), 110 deletions(-)


base-commit: 5585e342e8d38cc598279bdb87f235f8b954dd5a
-- 
2.39.5

