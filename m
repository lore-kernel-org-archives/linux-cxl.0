Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB704120A
	for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847144; cv=fail; b=eb4sJUVMsvM2X0Iym5JfXs/C+CXeKx8DBDASOcsiNG2e//6U2abnKeu0X0lcYfYGlI9xrHmObgn4yNyUR97LLqMVOpmmkxJc+HPLfgyLZ8478pTi1cScn1o62hnDq+yhBU693xrof39hjLEPEJQylJw5jktWY8nmWh0o0hXMdjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847144; c=relaxed/simple;
	bh=3mim04D8J61wAJIuz7LmH8qoRy3pcLReTPgHsxE78xU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nft10rGL/5ug3/WHbBUuJUB1cXmxtwdn+IOrggbs50c5xPioBU/uABabh9o4ki1Mry/xLJUzqeYB3sj7vFDzNuiu1ZXVeMLZfC7PkgNEUqPEeV5KSJA7QR9aOuNzG5cD+VNpo0EAfZY5+mCVByLX3TlKoD97yIbIv7dp8tDmFj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LdkGEFbI; arc=fail smtp.client-ip=40.107.102.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LdkGEFbI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxQh4y0VEtfDWBNhiMrcf75lZpzffGCsvS5UXQuMHVzTYlt/mSHgmJ6uDs//yPM8a0BoBnL3pHJ09DvBovJomcp13tgs7Q/Yh//NG+VnNKJVibUL1VzA/PoZ8nKD6FRwgzeVCJow5Do61l6pGBYQl0z4VJHbECeYV23x8T0IaBBbFQun6EJ/Hy1xCZ0NT4vJqLhto6B/229Orm8U4E0fagsUOz037+V0Bc899P40Jrr/cobplopW2jUWK1Mw0jyGNorOG7rAdrGaGcg49+tiv2aoHUhrP1eKQuUf8lOvdBjHijAQZGSL998Frym0AqOUW6SwmHYFASodKaVne8rBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBm6icIjGLXybySvS0bpENAs7x9LZfgKA/VsF7quKSg=;
 b=glGbyKN2stZS7YtSD7gCGR8byj35fyFr54PhKg/5dO5Tmikjaa+PXmf6kUbEDJXy6CnvgrneOGhxHaTbqq2dnWNTcDhCe1eCDc00RDImXdL3BpCImrYzOszEMAxhCfmcUcTorWmty8BhiE67cu6btgniMXMNbxIVeTVvqFgV6IqY4IjGwJcfS0L0HKIzlTUvk8Ip+D4sCep3ZZdbW0PV+AeQCophwIPYVw0ntrq9aEFUTqjr4CrgyO4H8H2AP8UF6HseFPS9X9OcQDFzokYnNzzsCkAE8ZpzaD2RQ/wemPFBrB6HG7N58ZmPmJKHwAXIcjLCGqeqFbfJZnjpN3MkHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBm6icIjGLXybySvS0bpENAs7x9LZfgKA/VsF7quKSg=;
 b=LdkGEFbIDjLQe48KWHtaMZ6CFNhd9xVDrR8CITVVWpTuzW6wb6NGtohEGrDoxklVJ7INHCW5eykIZgouNXl5R2OgpIwABy3yQjXdYVOzJxThvOJQolHVZflpbeh8wdIhw96MNkpvXplj9Z64Rot/PVb6Qr6QlZRtVlsIU7IEDrw=
Received: from BN0PR03CA0043.namprd03.prod.outlook.com (2603:10b6:408:e7::18)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.58; Thu, 16 May
 2024 08:12:18 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::a2) by BN0PR03CA0043.outlook.office365.com
 (2603:10b6:408:e7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 08:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 08:12:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 03:12:15 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 03:12:15 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
CC: Alejandro Lucero <alejandro.lucero-palau@amd.com>
Subject: [RFC PATCH 00/13] RFC: add Type2 device support
Date: Thu, 16 May 2024 09:11:49 +0100
Message-ID: <20240516081202.27023-1-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b381f68-f6da-4e92-1001-08dc757fe712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dm1oVWdCaURkc0p6NmJNamNxd1c3L1ZxRlhFcE9vd3BNQUpsMS9NZU9lZTdE?=
 =?utf-8?B?a3gwMHUzMzZNNXhuTTdZTVpSaHh2RUJpeVRXK25Gd05TQzlsWk9LdGpZaDJD?=
 =?utf-8?B?cnNxTHk0a0hsZ2k3QnRXY1pMYVhGUnkrTkh3dDNYaEZWcFI3VWI3OWtjV2xP?=
 =?utf-8?B?RUlUK0F2V0RqVi9PUjZINTlLajhJK2cvV0RVcjN2RDBrbkt3V2R5RmlScHIw?=
 =?utf-8?B?RS8xTHQ3Z0NNSFhZUWNaOTBkSWlveDI3djNMWlVQaFRhTXAyckFMejIzQ1BQ?=
 =?utf-8?B?OE9qb0xuck1FakNzNkZqM1lLeWhtU2Iza3pKQkx5cVVVdGQ2emk4VlBReTRE?=
 =?utf-8?B?ZU9zSEx3NVlMN2N4QmxPSk5IK2pIMkg3aGxqU3hDa3J2QS9zMW1yaFp4VkNE?=
 =?utf-8?B?bU9sMU5VNmdqS25KclBPSnVpeG5oNlRjbC82ZUNXR3U3aGdVaXJ3c3lETkd2?=
 =?utf-8?B?NGVzeWZJZDY0eUN4d0FVcnNFOVNEVXBzOGR2MVNtTFhUbWMrUEIxaDRwTFFG?=
 =?utf-8?B?Vkpscit6c1ZualBiZE96S2ZPc1kvUlJoaWNHc3hnd2dTdyswa1cxeTEwNEgz?=
 =?utf-8?B?MTdlbm9NYnpHMzNSeEN6YkJmdFZ0MlN6UmRzWmd1OERiWTNGdzNPYyszZG90?=
 =?utf-8?B?UnZRQTdReGZYTkhZOFhnYjBoakdJWmpXNmxLWkZBZi9tUTVHelFGQU5DRVoz?=
 =?utf-8?B?aFRxbDZwVjE2c1VWcFpJU1lvaXpjSlhrWm9HUVIwVURLallSV2xUMVZ5ZEhj?=
 =?utf-8?B?M1JoR3U5c1lDeHpyeEN5VzV6V3hlUStjWnJzOFpvNDB0Q1NsSXorL2MrRXZD?=
 =?utf-8?B?aU9jaU02ZjdEVSt1M1VpWW1TcDVWTnp6T0lIQnFoQnJQUFVDblBOUUxjNUZq?=
 =?utf-8?B?TldiWEhwVC9uLzlEK0xzdlFSZWdxSGJJZzlJaklGNFZZb0hLditzWTFRZTBT?=
 =?utf-8?B?TUFheWVsdWliMFhZTkJwNW5xOGpIZHNnTXJwbmlILzhQWG1OWlo1bUZaWUU0?=
 =?utf-8?B?bDBZQ2IvazBUUm1FQ0pveUZ3S29Xd01nZWVwOFRBbW13YVBxbFZ0WFB1OTVM?=
 =?utf-8?B?cE52Y0RiS3dsYkVvdHpBVURUQWhoT0RwY2tzL1pwa3UzbWwvSlBRUCs4SFB1?=
 =?utf-8?B?WllnUVB3QW1yN2UvbXpEdlVBUGZtWG40UklTVlZLTy9zMEp6WDVtV3BudFZa?=
 =?utf-8?B?ZllLdmVLcVBLZnU1RnZVMWVzZDIrL0RYRGtsOXc2MUxnZmRqZHVRZi8zVlFV?=
 =?utf-8?B?ZEdQRC9pejFmSDFxczRkbEJxekJCYTQ2M2l0cGY0N3FsVWZUVmRHNjl1eks3?=
 =?utf-8?B?RU1uVEI2K2QzdWZnZ0RTVEN5WEgzaHowajdNeVdJT1RBdmt1NTJMTCtEMzJG?=
 =?utf-8?B?dTd6Y0gvSDFPSVluNWJBWGZLOHpCcTMxSlBYVTdISlFmaDFwNmNVc2lVdlkv?=
 =?utf-8?B?LysrMk05QmZjemdJbHN2TDRXOE1vZ0NCRFdiZk5Ma3dSN09zbDg1Z24reE5O?=
 =?utf-8?B?OHBvVnRUdkROeUZVVzVsemtBSGsvb3hRTnF2bzJHdnNVcVVvUjNXdnFxZmpi?=
 =?utf-8?B?Ukk0bUpFU2xYeGE2SnRrWGVscEE5alRBb1FVYklMdERZTTE2R2pZcmZvZG1Z?=
 =?utf-8?B?VzJqRmt0VlAxRDBZMU1TNlQ2emVMWTBGZlFXNEdWVUhxS2ErbW1uL1NXeHJG?=
 =?utf-8?B?T2FvdExtY29EQXJ4S2wrRHJGQ3FMN1ZNU2JTZEtwU3FYRml2Lzc1YW9DQlpv?=
 =?utf-8?Q?fl/mTDPo0dqdw7pygK0KasLu+Vle3dcCRjqOa/1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:12:17.7472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b381f68-f6da-4e92-1001-08dc757fe712
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982

From: Alejandro Lucero <alejandro.lucero-palau@amd.com>

I need to start this RFC explaining not what the patchset does, but what we
expected to obtain and currently is under doubt: to configure a CXL memory
range advertised by our CXL network device and to use it "privately".

The main reason behind that privacy, but not the only one, is to avoid any
arbitrary use by any user-space "client" with enough privileges for using a
public interface to map the device memory and use it as regular memory. The
reason is obvious: the device expects writes to such a memory in a specific
format.

The doubt comes from the fact that after implementing the functionality exposed
in this patchset, we realized the current expectation seems to be a BIOS/UEFI
configuring HDM decoders or HPA ranges and passing memory ranges to the kernel,
and with the kernel having a default action on that memory range based on the
flag EFI_MEMORY_SP being set or not. If it is not set, the memory range will
be part of the kernel memory management, what we do not want for sure. If the
flag is set, a DAX device will be created which allows an user-space client to
map such a memory through the DAX device API, what we also prefer to avoid. I
know this is likely going to face opposition, but we see this RFC as the
opportunity for discussing the matter and, if it turns out to be the case, to be
guided towards the proper solution accepted by the maintainers/community. This
patchset does not tackle this default kernel behaviour although we already have
some ideas and workarounds for the short term. We'll be happy to discuss this
openly.

So, this patchset assumes a BIOS/UEFI not programming the HDM decoder or HPA
ranges for a CXL Type2 device. Although maybe a weird assumption as explained
above, a Type2 device added after boot, that is hotplugged, will likely need the
changes added here. Exporting some of the CXL core for vendor drivers is also
required for avoiding code duplication when reading DVSEC or decoder registers.
Finally if there is no such HPA range assigned, whatever the reason, this patchset
offers some way of obtaining one and/or finding out what is the problem behind the
lack of such HPA range.

Current CXL kernel code is focused on supporting Type3 CXL devices, aka memory
expanders. Type2 CXL devices, aka device accelerators, share some functionalities
but require some special handling.

First of all, Type2 are by definition specific to vendor designs and a specific
vendor driver is expected to work with the CXL specifics. This implies the CXL
setup needs to be done by such a driver instead of by a generic CXL PCI driver
as for memory expanders. Most of such setup needs to use current CXL core code
and therefore needs to be accessible to those vendor drivers. This is
accomplished with the first patch and with extensions to the exported functions
in subsequent patches.

Keeping with kernel rules of having a client using any new functionality added,
a CXL type2 driver is increasingly added. This is not a driver supporting a real
device but an emulated one in QEMU, with the QEMU patch following this patchset.

The reason for adding such a Type2 driver instead of changes to a current kernel
driver or a new driver is threefold:

1) the expected kernel driver to use the functionality added is a netdev one.
   Current internal CXL support is a codesign effort, therefore software and
   hardware evolving in lockstep. Adding changes to a netdev driver requires the
   full functionality and doing things following the netdev standard which is
   not the best option for this development stage.

2) Waiting for completing the development will delay the required Type2 support,
   and most of the required changes are unrelated to specific CXL usage by any
   vendor driver.

3) Type2 support will need some testing infrastructure, unit tests for ensuring
   Type2 devices are working, and module tests for ensuring CXL core changes do
   not affect Type2 support.

I hope these reasons are convincing enough.

I have decided to follow a gradual approach for adding such a driver using the
exported CXL functions and structs. I think it is easier to review the driver
when the new funcionality is added than to add the driver at the end, but not a
big deal if my approach is not liked.

The patches are based on a patchset sent by Dan Williams [1] which was just
partially integrated, most related to making things ready for Type2 but none
related to specific Type2 support. Those patches based on Dan´s work have Dan´s
signing, so Dan, tell me if you do not want me to add you.

Type2 implies, I think, only the related driver to manage the CXL specifics.
This means no user space intervention and therefore no sysfs files. This makes
easy to avoid the current problem of most of the sysfs related code expecting
Type3 devices. If I´m wrong in this regard, such a code will need further
changes.

A final note about CXL.cache is needed. This patchset does not cover it at all,
although the emulated Type2 device advertises it. From the kernel point of view
supporting CXL.cache will imply to be sure the CXL path supports what the Type2
device needs. A device accelerator will likely be connected to a Root Switch,
but other configurations can not be discarded. Therefore the kernel will need to
check not just HPA, DPA, interleave and granularity, but also the available
CXL.cache support and resources in each switch in the CXL path to the Type2
device. I expect to contribute to this support in the following months, and
it would be good to discuss about it when possible.

Alejandro.

[1] https://lore.kernel.org/linux-cxl/98b1f61a-e6c2-71d4-c368-50d958501b0c@intel.com/T/

Alejandro Lucero (13):
  cxl: move header files for absolute references
  cxl: add type2 device basic support
  cxl: export core function for type2 devices
  cxl: allow devices without mailbox capability
  cxl: fix check about pmem resource
  cxl: support type2 memdev creation
  cxl: add functions for exclusive access to endpoint port topology
  cxl: add cxl_get_hpa_freespace
  cxl: add cxl_request_dpa
  cxl: make region type based on endpoint type
  cxl: allow automatic region creation by type2 drivers
  cxl: preclude device memory to be used for dax
  cxl: test type2 private mapping

 drivers/cxl/acpi.c                      |   4 +-
 drivers/cxl/core/cdat.c                 |   9 +-
 drivers/cxl/core/core.h                 |   1 -
 drivers/cxl/core/hdm.c                  | 159 +++++++--
 drivers/cxl/core/mbox.c                 |   6 +-
 drivers/cxl/core/memdev.c               |  75 +++-
 drivers/cxl/core/pci.c                  |   6 +-
 drivers/cxl/core/pmem.c                 |   4 +-
 drivers/cxl/core/pmu.c                  |   4 +-
 drivers/cxl/core/port.c                 |   6 +-
 drivers/cxl/core/region.c               | 446 ++++++++++++++++++++----
 drivers/cxl/core/regs.c                 |   9 +-
 drivers/cxl/core/suspend.c              |   2 +-
 drivers/cxl/core/trace.c                |   2 +-
 drivers/cxl/core/trace.h                |   4 +-
 drivers/cxl/mem.c                       |  23 +-
 drivers/cxl/pci.c                       |   9 +-
 drivers/cxl/pmem.c                      |   4 +-
 drivers/cxl/port.c                      |   4 +-
 drivers/cxl/security.c                  |   4 +-
 drivers/dax/cxl.c                       |   2 +-
 drivers/perf/cxl_pmu.c                  |   4 +-
 {drivers/cxl => include/linux}/cxl.h    |   5 +
 {drivers/cxl => include/linux}/cxlmem.h |  22 +-
 {drivers/cxl => include/linux}/cxlpci.h |   2 +
 tools/testing/cxl/Kbuild                |   1 +
 tools/testing/cxl/cxl_core_exports.c    |   2 +-
 tools/testing/cxl/mock_acpi.c           |   2 +-
 tools/testing/cxl/test/cxl.c            |   2 +-
 tools/testing/cxl/test/mem.c            |   2 +-
 tools/testing/cxl/test/mock.c           |   4 +-
 tools/testing/cxl/test/mock.h           |   2 +-
 tools/testing/cxl/type2/Kbuild          |   7 +
 tools/testing/cxl/type2/pci_type2.c     | 201 +++++++++++
 34 files changed, 886 insertions(+), 153 deletions(-)
 rename {drivers/cxl => include/linux}/cxl.h (99%)
 rename {drivers/cxl => include/linux}/cxlmem.h (97%)
 rename {drivers/cxl => include/linux}/cxlpci.h (97%)
 create mode 100644 tools/testing/cxl/type2/Kbuild
 create mode 100644 tools/testing/cxl/type2/pci_type2.c

-- 
2.17.1

