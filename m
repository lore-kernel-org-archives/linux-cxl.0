Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794011B7910;
	Thu,  1 Oct 2026 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856097; cv=fail; b=RjRti6FlVOZc7MMh5qsdCMHi3RHNS/+emsOF0Fyqo4N4p0rXoeVDSYbIIdAX8IpCCfy2kohLDpajHMjjZG4PP4EZKh5MSxgdvsWB5MQJ3JVwyOMKd4+sRlD6fmnOYZ3UnGg66VN+xo8X+qr08qF/lpdisiTFygDUN2SYEoj+DsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856097; c=relaxed/simple;
	bh=s56jC8lLzTWrtWxR2zaZiv/EvgX2TBjL8ljb7+I6IBw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VcppOzoc1h7q7mvoroOC1DtY3UynitZW8aGWeT0epEAk/ICuw9i2pbZK/SyT39TxECwmOwSwQ2hm4xnhykqKS3AJU3g4dXPedBw4oPTr2cMEPjSTdR7OiiGBu2YnRtAwkJpyuNg+Y81ARkSGjgl6UTBwCigtUI5B4sH4zGkSulI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zYIMHX6+; arc=fail smtp.client-ip=52.101.61.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zYIMHX6+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLbVNDikPllqNhq3Gal7ryTkuJGOiZeu62TjBq8+g1ER/1KJLaZdgBnvKX9alF18J0V557MseBS+tKA7VpHjIONAEVJN0dWiH7LwvW4jMdy5nz2o2JiJCKcH9wLcvP7tFT0PBorClDtGAsgmpmFqmYZqiaZoBMXdqJsJTJ7BHwn2kgAVZ4Vnsclv7BC35wy2nuJIkQQDq9/OW+yCd2TBnyx4/3qoh7oU2bdfoz2sRxkcknygTAMj+iJZqEmyezShI98YpP1LHJaouiuIZBWfUH/TiOIsqqb1+nG56BxPSA5gqy5MLNe7OaUVe+/r5nN1sj06QOt/fHDgSf+r+UBxKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qV+nEZVprIjxd/bVLn3LYT2VzRS94Z1a7ag1PkbOmVg=;
 b=FCzeC/QUut0y17HAV8/zA/HXXg9SPe0dHaXaRAdnA9oy3bg2fKIFP1tAuy66yRFpcAVeoJqV/22X6VAmKjh7Y2lVb3LMlCNMtCd9nmEuvUbRztbkSjE1JvCiP3YM2kVc+s6cgRCaqof0NJ/bvWUWMpWGSA7NnreOJTAib+Yv+CBMVKIrwCYLTXBVS0iROziaXG+ZAlZvbxzTkzPutDb1UeauVP/7bJwfoRK+yBtt/tZiWVg94agoQP8QsYl5EmnaPGktJon9Ecmv6ygx3IH9YJVWxcpURqbkU2m4mvJZmIu7wvKwh5JnfGMR1virgLU8FVwRZDjz5AwdZyjvmCSQCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV+nEZVprIjxd/bVLn3LYT2VzRS94Z1a7ag1PkbOmVg=;
 b=zYIMHX6+XmQ5vfzFF7NPkIcE+LD/V7vcgWSxtB2kAtSns/IpJ+QdOc/TbiLFMUNreNVbMJSo/D7cOmekOW6QmXnqX8t8aTG2gjXbI7z4eY4ANmShLotVtYodjgmErZgUhkqcDk4Iu7mHmX5ZF9N/qomuTlxBDT+8lgjnOPbq6BU=
Received: from SJ0PR03CA0059.namprd03.prod.outlook.com (2603:10b6:a03:33e::34)
 by SJ5PPF4C71815F9.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::992) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 12:01:19 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::7c) by SJ0PR03CA0059.outlook.office365.com
 (2603:10b6:a03:33e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 12:01:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 12:01:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 07:01:18 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 07:01:17 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <icheng@nvidia.com>,
	<rafael@kernel.org>, Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 0/4] Type2 multipf support
Date: Thu, 1 Oct 2026 14:20:19 +0100
Message-ID: <20261001132023.17032-1-alucerop@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|SJ5PPF4C71815F9:EE_
X-MS-Office365-Filtering-Correlation-Id: 2320b86b-2daf-40b0-6c88-08df1fb3b454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|6133799003|10067099003|5023799004|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	WHBChCPVNTE/zK/Fe5UHklJoHay5jbGqiqmUeFFuHi6XNjWIG3wxbxU96G17Eet2ZBeu10Rlb7uRTd0Rk0IXtPvqLMFHZ8MUHwSKJSImYuIzhSN3AFulZYtBJLuwThBrAxaW22dOiVe7NfDPLaCafsSn/V9KjIVm1mraI9svcpis/3/0skeSEMK0M6KwC2fHmHHSTvoSVITNOsVSWjcsfSgUaQ87Fh/pom//NCvlqU7GpmCuLVJvUmX8Una6EHoNIFxfDeaS4WYJRCWiE5dflLYaJb4ZawQtqmLOA050IDLHm1ZYVmJvrnU8rCoRMkj0pQCLBXAyGHQCT3zpTD3BxE8/4WjXlROM6GQ26EW2wNpm48UJJRvCoZI/crRPgD4RzCg6VsU2WRuiQZBf2J+UbiUbf/kTRhADK9keNTlx6A2loB2lasfluLdccFaQKSDTOscSz+SeXOfyFMDyf0qy0/toTDuMzmcmLs/FVYV5WT6yZnn7whUcde7zdfHtRcMiJ7w0KIuCoYrnRCZHVOFHWdRCLoKIoflefDEPDbUGi3z4GWzz9hJjHg5k2fkBjFBk4BrDKNU4FV2/7aFaYsRsDPs1e+N1CQzS4F9GkQL/RXNM0n/V+894B0Qxh+wtiSkFD4pKLXGhjec7x3F/lSjtNNWFJcHqCGxOy9nvMi8wki95juWfzNgf352gX/hsUfrsv1V+lM736yt5pFTevwXY3Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(6133799003)(10067099003)(5023799004)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1nIKJNY/3uBpPWdMdMi82FrVugKJ+l57JNBoCKmIptEqfUF0lHg5z8FxVku84EG8NPUtgFfXtmq/WlQr7aZ+f7CMRPCYqGJQaAhuwIHVev/NqwaqH2tGyM2rg+jKJEJvo00xoTctFzICA8r1x+9WppXWuxLhwoZwO9bzU6ITlmr2C4Ju19LrpR8NnYZqkWsElN7P6/uKmuu8XqOigCwKv/e3X7jLj4FQngXnNoIpI5z1Mbr3BN0oLxeLR5xeKe8tjD865b+UspAKxQekBtRPTb2glKBUqpwG3D5fKicFwMRgO07WZgjygX2Gu9FIjhN6LU8jcY6AjbZ6lCDO1vucAh3CmhsKODbVYvKwGNOhgfhXpStx5o4NbM5FKsI6lnXKJmKGBpGSuUseSR8wcpaLxZpW0dtuVJHkJZsT3jgq+2vQCS5JRlyiSADCfEuibehK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 12:01:19.4188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2320b86b-2daf-40b0-6c88-08df1fb3b454
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C71815F9

From: Alejandro Lucero <alucerop@amd.com>

Changes since v1:
 
 - Simplify drivers core required change
 - Change name in the new accelerator API function (Dave)
 - Do not return cxl memdev but int (Dave)
 - Refactor sfc cxl initialization for the two cases (Jonathan)
 - Restrict sfc_cxl_map to only mapping (Jonathan)
 - Addressing some sashiko reports

A PCI device can present multiple Physical Functions(PFs) but the CXL
specs restrict to the first one, PF0, the discovery and management of
CXL capabilities accessed through a PF0 BAR. Other non-PF0 PFs need to
obtain the CXL.mem range to work with somehow.

This patchset adds support for getting the CXL HPA range other non-PF0s
can use based on what PF0 did initialize. This implies CXL for those PFs
can only be used if PF0 is bound and successfully initialised CXL. This
needs to cover the potential race between PFs probing where non-PF0s
will be deferred if the expected CXL is not ready yet. Moreover, those
PFs can not keep using such CXL memory if PF0 is unbound what can
happen in different scenarios.

This first version after the RFC uses device links as proposed by
Richard Cheng which simplifies the support avoiding specific handling of
CXL memdev siblings as the RFC did. Using device links needs a change to
this core kernel functionality for allowing suppliers without power
management initialised covered in patch 1. The second patch adds a new
field to cxl_attach_region struct for facilitating the device link using
the cxl region device where the Type2 memdev is attached to.

As stated with the RFC:

the final Type2 basic support was possible once Dan Williams and
I reached an agreement on how to solve the potential unwinding spenarios
linked to a cxl memdev object. The actions triggering this unwinding are:

 - User space unbinding the cxl mem device from the cxl mem driver.
 - User space removing cxl_acpi module.
 - User space unbinding Type2/accelerator pci device from its driver.
 - User space removing Type2/accelerator driver.

The last two trigger the unwinding from the Type2/accelerator driver
exit path, while the first two start the unwinding which in turn invoke
the Type2 driver release from its pci device.

In any case, the decission was to release the Type2 driver always
instead of a degraded functionality if CXL.mem is only part of the full
functionality. This needs to be extended to other non-PF0 PFs, so all
the scenarios listed above ending up releasing those other PFs as well
from their drivers.

I have tested this patchset  with real hardware advertising two PFs and
under all the scenarios listed, but stressing this requires another
framework, likely under qemu or adding a new cxl test set.

The base is vanilla 7.3-rc4.

Alejandro Lucero (4):
  driver core: Check for supplier requiring PM at link creation
  cxl/region: Add region reference in memdev attach
  cxl/memdev: Add support for multi PF devices
  sfc: add multipf support

 drivers/base/core.c                |   2 +-
 drivers/cxl/core/memdev.c          |  92 ++++++++++++++++++++++++++
 drivers/cxl/core/region.c          |   1 +
 drivers/cxl/cxlmem.h               |   2 +
 drivers/net/ethernet/sfc/efx_cxl.c | 100 ++++++++++++++++++++++++++---
 include/cxl/cxl.h                  |   2 +
 6 files changed, 189 insertions(+), 10 deletions(-)


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.34.1

