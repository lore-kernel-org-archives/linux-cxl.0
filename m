Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664801E501B;
	Tue,  7 Jan 2025 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259045; cv=fail; b=ReZZAqBwhe1cuK1aPgogeWvTVVl+hg8Shw9o/E/tBLfkm6e/dhHW1X7UbfBauxW4lNE5iCuLFOD32i2kFSCANRFw2fN6zushbQBwBfyETyJAtkPqhTkGmIOMRuogSE5eSxIaEX/pJzHqGdKNm64wJk7NOA+3hj72wd6aZA4fuvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259045; c=relaxed/simple;
	bh=lcRfzYdDMDLITm+i6VgSRfNCVjO7iaPOZlBn6RfmQo4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YYELBHav7oBjlnnKDZUctLao4NV9CpJObSH/8lI7JAUx+rsn9gHPfBuho2ub1URs+hQ0y5AkXmzkkvICIoWnVz/r+WexZ9fWgGXcwalcjTTA0U4nWDx0UqDz3c/FdC4IB8cn8Wi1IY1WYu1c40UHdrkZBX1mZ6ehO0GH1W6tx58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ph8ZbJMr; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ph8ZbJMr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bI8QSEu4Te7liNMGdUsWZrGDU0QYDV4XUhj2i9sMAEzr6Iqt2rERNa/6Ki5jwZdS72sUz5jhD/EYSe5wc1ciZlh10FNTB7CBH3OOWRpBHsc8VjTMDNlh5IKuVzVzfeWqxicjX/h+f1TQElAAi/iI0UtT4BZi2Cj2YJ+dxA86LQLuPd27nklwI92LfHFchqKgMYJybSGPs6AufeDzbBnE0w5sRxLb0gAH4ZbZUOR+oUYFjPJ5DcTMy9lFKnOLg/3yrARd6VlV0p888hLWQewPwED5an08H2p93ZuBzXT87zS+HunDvWXestiaTNaYo9nXi2NXyyhQUjOZW6MOr+RURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+fv7q6GZZrxxPDgPF+vMfZSa8K7xKqnG2eYdXpeyAw=;
 b=t28Cc25Ei7717JZxv0IQFs9a9JF7BQEAA10Aad/OXcA1zBD8Q6zzL2DUKShk1aMvSRnCBcOgpIFrJcDS0VBBUqtbYsSlHKLfdlZ3moUkc8NMwkuyBFLhGjTmiG6NlE9zeXMbP6+Lat15ooH7H9YtEN34S9MEOx7uFGLQ6Ob8pKRZTapbPcjImGI1DEoHfY3tSRUNOzAY49Tl2Oo5k3QjqnHmN0sui25hxxLPDoKonDQCt+PU3030CPIsF96QqGInNPTBWFLZoiNi6m5BesNeTJa8BYza7I00IZrSE9WD5rZl0GTpXOb8hUnBJ/KJwg0MNcTDk/lyNo6rsWHxiUu/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+fv7q6GZZrxxPDgPF+vMfZSa8K7xKqnG2eYdXpeyAw=;
 b=ph8ZbJMrpXtWvEfSN1KmsxIyLEcUgTZeCuKGZVhG8LLdGZzjaJvnfbY42QYha7ogmsb09J8hmyMAbhQnXJe5h7BEmxMQ2E2vmQlxuIzbUA4n3CQatiXmtVkP/+fYy2xh7BSwDamRBTWrEmzRoAqKWFCB7eBC1A8IQj855NrTEM8=
Received: from BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::8)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 14:10:41 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::2e) by BY1P220CA0018.outlook.office365.com
 (2603:10b6:a03:5c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.19 via Frontend Transport; Tue,
 7 Jan 2025 14:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:10:40 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:10:37 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 00/29] cxl: Add address translation support and enable AMD Zen5 platforms
Date: Tue, 7 Jan 2025 15:09:46 +0100
Message-ID: <20250107141015.3367194-1-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 269a3047-9d9e-4f21-d344-08dd2f25115e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eE4zQVdPWVpjOFVRQVU5aWZwWUcwNmszcjQzZDc5NHluZy9lMVhTV2ZVSjZV?=
 =?utf-8?B?YTczZGYyUEozY2lFaThFRG84L2FHQ0pJc3JVRFVBZ2RwMDIzQzlYRHQzdEly?=
 =?utf-8?B?V1FGUXpYRjhRdkFpTEtsZXBCaGtkam5sc2d4K0h1NFRNMFJyWFZSRHV3cGov?=
 =?utf-8?B?Q29PdE9aejlKQS9DMUhyK1Z5MUJHUFFqamlib0ZSZ3U2UndGcG1ULzlTL0xu?=
 =?utf-8?B?am4wYnFSem1zVGRCaXpvZUcwQTBvaVFIT2lKem9JVHJTTkFjWitqSitTUkEx?=
 =?utf-8?B?NmJQd0wrejg5VmZoV29LYnJDRHIrcUhyQnk5MjZuVmh5OFdNZ2NyUFpmeEd1?=
 =?utf-8?B?NGh2VTNNRnIvRmEvcHlIS1dvaFAwcTM2QzU4LzFTb1dIRUUzNWF6Yi9iZ0po?=
 =?utf-8?B?eUlDejhDYk92ekhKRWVDZkZ5NWdQMWUrQm9vZGlRWTY1LzV1TGgya3cvTXk2?=
 =?utf-8?B?MGRhSThVQ3B1cVVvRk1oVGJsamRXRStMa2JTY2JWZFpvNGZHOVV1emt4TjQw?=
 =?utf-8?B?ZERRN3lUd0ZaRHNYQVlqdXhGNUhTaS9qOXVvSDVoRzNhTWF0VVBDTVB2SmJQ?=
 =?utf-8?B?UXM5M0RpRnVHa2U2Q1BZcXlrZC9PYjUrSTJvMEpnYjJLR3FaQitnQUZpMjhz?=
 =?utf-8?B?QStac2hmMmZaY2lFOUpRZDAyWHFzdTZYQmtwZ0Qzd0pNdkFqck5YRlEvdzBw?=
 =?utf-8?B?UWprOCt4dkRidjZaNmxNaUtydE9OQ20vSHZRL0w2MXo5OEZYOHIxUzdHT3kz?=
 =?utf-8?B?amdSMElOeG01OTlRM1lUNTZxTjZ1M1FISVVaT2hub25ra0c4eGFqSUdYZ0VI?=
 =?utf-8?B?TFJZRnRwQ0VwK3dMTU91U0ZQSTQvcy9CRjZFbE9SZzQ5L3AvcmVxNFpjVUFp?=
 =?utf-8?B?WmpzbG5NbU1IZnUrcE5QS3pIV0ViUGw3OUxaSThIUEd4N2RvbHRXdGlYWVQz?=
 =?utf-8?B?bitYazJRSjBTTGJub2ZxbTZ2a0oxUzV2Mk9OYVljRlJLZ0QwWTlCUjVqNmlI?=
 =?utf-8?B?dlNpR2xxNU9VemlXYWpWMzRLY1FuYlVDeHB1NEZKUnYzRnp4YkRIcGo4bXN5?=
 =?utf-8?B?QW55NC9RQUhnWGIzcVFOM0hGang2S1pTTEdsNktuN3NMdzBYZWVaOTYrWTZh?=
 =?utf-8?B?eEpvdExsYzR5Ui9mVDUxUHVyV2VGSGZBdCtvcERacEVXeVZFbFBZeG5mZWpB?=
 =?utf-8?B?d01LSzc1UjBIYVdNcDZXaGZ1MGhPUmg3dHVRZ1J6MG84MVVkcnhPRFBRTndX?=
 =?utf-8?B?Y3ZPTTBGNjQvMkpmL0I1STNieldZdmNjRy9tUmc4QnM2UGlpVHJURk5BUXkw?=
 =?utf-8?B?OGV4RkgydmdRb2RVdzh1c2FxNEFqODNpdks1Z3ZkWmtqRWRJYkI1S1FmSXY2?=
 =?utf-8?B?Ly94YW84bjZjTktxcFJPUHZMdko4cG9PekFXZUd1ZkpFY2xaclVQbFJ2cDhS?=
 =?utf-8?B?d3RYOWd4d2tVbjBuRWczSE4ydmZ0VTZZSlRUMXorQTRSYWs5clN5L3ExbnBr?=
 =?utf-8?B?b1NjVlk1Y0I0OEFUNzJ6NS9lM0g3cFFkenVXZUZ2ZjFNeGtzQ29RL2tJZEdI?=
 =?utf-8?B?aXllRnJrbXZoVEdTRUFXOUd1bldRaXVVZ2RuTWJ2bUtreDNQRFVnMDNFbnpx?=
 =?utf-8?B?WlFCd2hDbVlKTzJVUnZ3TW5RcjFjZmNuaExvV1JyT3RUK0cwenhNejgyRkZC?=
 =?utf-8?B?ejh1bUJIOEo3T0EyeGtRZHo4ZWVOREJHdzRabmJubHo1QXpEZkdpY3dSNm53?=
 =?utf-8?B?SW40SDF4TE1ZdXlKdG11Wm4zc01BV3c5dE5OK0lkbFFXd1N0a0FxRWdIN1VW?=
 =?utf-8?B?bXhlR0tydXh4ZkIyalZ6eEk3VnNoYjNCOTlwUVBPTHNQKzlZRk00WS9RV1Vy?=
 =?utf-8?B?d3M5a3A1RG5nWnIvd0ZYejVZbEVseGdsM2lxdzdFQmVnTWhNLzBzOVhJYXU1?=
 =?utf-8?B?c25wczdoZHZBdzBGdkdOQWhKKzJKczQ0bnFiYnoweERxRUZiUWNSSHpTVjBj?=
 =?utf-8?Q?ZNabryUlMTfA75pZU8Gu3KD+8DbzAg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:10:40.6638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 269a3047-9d9e-4f21-d344-08dd2f25115e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574

This patch set adds support of address translation and enables this
for AMD Zen5 platforms. This is a new appoach in response to an
earlier attempt to implement CXL address translation [1] and the
comments on it, esp. Dan's [2]. Dan suggested to solve this by walking
the port hierarchy from the host port to the host bridge. When
crossing memory domains from one port to the other, HPA translations
are applied using a callback function to handle platform specifics.

The CXL driver currently does not implement address translation which
assumes the host physical addresses (HPA) and system physical
addresses (SPA) are equal.

Systems with different HPA and SPA addresses need address translation.
If this is the case, the hardware addresses esp. used in the HDM
decoder configurations are different to the system's or parent port
address ranges. E.g. AMD Zen5 systems may be configured to use
'Normalized addresses'. Then, CXL endpoints have their own physical
address base which is not the same as the SPA used by the CXL host
bridge. Thus, addresses need to be translated from the endpoint's to
its CXL host bridge's address range.

To enable address translation, the endpoint's HPA range must be
translated to each of the parent port's address ranges up to the root
decoder. This is implemented by traversing the decoder and port
hierarchy from the endpoint up to the root port and applying platform
specific translation functions to determine the next HPA range of the
parent port where needed:

  if (cxl_port->to_hpa)
    hpa = cxl_port->to_hpa(cxl_decoder, hpa)

A callback is introduced to translate an HPA range from a port to its
parent.

The root port's HPA range is equivalent to the system's SPA range and
can then be used to find an endpoint's root port and region.  

Also, translated HPA ranges must be used to calculate the endpoint
position in the region.

Once the region was found, the decoders of all ports between the
endpoint and the root port need to be found based on the translated
HPA. Configuration checks and interleaving setup must be modified as
necessary to support address translation.

Note that only auto-discovery of decoders is supported. Thus, decoders
are locked and cannot be configured manually.

Finally, Zen5 address translation is enabled using ACPI PRMT.

Purpose of patches:

 * Patches #1-#4: Minor cleanups and updates separated from the actual
   implementation

 * Patches #5-#12, #14, #17, #18: Code rework and refactoring.

 * Patches #13, #15, #16, #19-#24: Functional changes for address
   translation (common code).

 * Patch #25, #26: AMD Zen5 address translation.

 * Patch #27-#29: Changes to improve debug messages for better debugging.

[1] https://lore.kernel.org/linux-cxl/20240701174754.967954-1-rrichter@amd.com/
[2] https://lore.kernel.org/linux-cxl/669086821f136_5fffa29473@dwillia2-xfh.jf.intel.com.notmuch/


Robert Richter (29):
  cxl: Remove else after return
  cxl/pci: Moving code in cxl_hdm_decode_init()
  cxl/pci: cxl_hdm_decode_init: Move comment
  cxl/pci: Add comments to cxl_hdm_decode_init()
  cxl/region: Move find_cxl_root() to cxl_add_to_region()
  cxl/region: Factor out code to find the root decoder
  cxl/region: Factor out code to find a root decoder's region
  cxl/region: Split region registration into an initialization and
    adding part
  cxl/region: Use iterator to find the root port in
    cxl_find_root_decoder()
  cxl/region: Add function to find a port's switch decoder by range
  cxl/region: Unfold cxl_find_root_decoder() into
    cxl_endpoint_initialize()
  cxl: Modify address translation callback for generic use
  cxl: Introduce callback to translate an HPA range from a port to its
    parent
  cxl: Introduce parent_port_of() helper
  cxl/region: Use an endpoint's SPA range to find a region
  cxl/region: Use translated HPA ranges to calculate the endpoint
    position
  cxl/region: Rename function to cxl_find_decoder_early()
  cxl/region: Avoid duplicate call of cxl_find_decoder_early()
  cxl/region: Use endpoint's HPA range to find the port's decoder
  cxl/region: Use translated HPA ranges to find the port's decoder
  cxl/region: Lock decoders that need address translation
  cxl/region: Use translated HPA ranges to create a region
  cxl/region: Use root decoders interleaving parameters to create a
    region
  cxl/region: Use endpoint's SPA range to check a region
  cxl/amd: Enable Zen5 address translation using ACPI PRMT
  MAINTAINERS: CXL: Add entry for AMD platform support (CXL_AMD)
  cxl/region: Show message on registration failure
  cxl/region: Show message on broken target list
  cxl: Show message when a decoder was added to a port

 MAINTAINERS               |   7 +
 drivers/cxl/Kconfig       |   4 +
 drivers/cxl/acpi.c        |  14 +-
 drivers/cxl/core/Makefile |   1 +
 drivers/cxl/core/amd.c    | 227 +++++++++++++++++++++
 drivers/cxl/core/cdat.c   |   2 +-
 drivers/cxl/core/core.h   |   6 +
 drivers/cxl/core/hdm.c    |   3 +-
 drivers/cxl/core/pci.c    |  44 +++--
 drivers/cxl/core/port.c   |  22 ++-
 drivers/cxl/core/region.c | 407 ++++++++++++++++++++++++++++----------
 drivers/cxl/cxl.h         |  16 +-
 drivers/cxl/port.c        |  22 +--
 13 files changed, 623 insertions(+), 152 deletions(-)
 create mode 100644 drivers/cxl/core/amd.c


base-commit: 2f84d072bdcb7d6ec66cc4d0de9f37a3dc394cd2
-- 
2.39.5

