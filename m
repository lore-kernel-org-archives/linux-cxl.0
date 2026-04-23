Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010033.outbound.protection.outlook.com [40.93.198.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A889C3770B
	for <linux-cxl@vger.kernel.org>; Thu, 23 Apr 2026 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965131; cv=fail; b=WAxBMKxHGXfMnu4r0dVQSOvFy+oqgkGk+ZKNH6UqGRZcYw2qtwH0cf30ZCMSYFm//rPQTrSXRp0O2oAsBmEG6VPbO31RdQvVbsPkEeJVi6/YbaGvWtIIWfM7hfZHD4kTg5++6u+u9sstVlGidVlabzC2cGBRgJehcqoxudIw4SI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965131; c=relaxed/simple;
	bh=/kS6r+ZTdHc0Vl67UiqmZAgZ1SqBFcGVxkKimJnTHHc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=doQvlXYb/4cxTNA0VSvJ0IYH+MFf/DrSc+z942xNcyL1IBG+skdqdweWXWf/n6cY6ToPUlzOPe8pUQeUkbd+E91ZkhiKOwbjZmizdVQR+KIqBAGKDyMMjwBpySDQXwht7t0hZCYf+tpb7BLL9i+SoP+GQD/ZCl16iCai0NyrenQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kRHOD6GJ; arc=fail smtp.client-ip=40.93.198.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kRHOD6GJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmHXaMtzY29mpniixy2xI81PAxr+FcU/z8Cwb0s+qMleAc4r3j8yyN6LmBZyAzFE5Y3u2051x1mlOb7HlaXqGdo1p42dgtSWhNclu2EV9P7xiQzwqoL74QfBZAxHeOjpgGNvJIuAUHCeck+K1TpuQBFz4pvA1SYV+nyewbGHNm+YxrFhT+H0EY5Bd1gLgfeDMzZWXs5bCZK/BKpFznjIH+UvzF5AptWeGyFRKyO0qb7yKJevxpf5OIgrwbG0tKjACPpt58/t97d1wDCVFaIcp4zBESrMxEl0a5FU2f9dn+WHW3l/GBGNrKTyBVdyXja/RWhhfgSFmP7OtcfLQwpj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0qWyOcRMxuXWgUrnXpgGBz6zLkc1mcNxtDk0OrRv/s=;
 b=uhqsLF/vEh2jkCim+jqAooUcs401JjkMccHViV/7f6GkikoNe/o4ku6mAbcJyM61SuYTOLnUVoYxA86+qreU1i97b0ZqPdHIXeNborFd/xJYixdzwV8JWuOjzbIOGIYvtmIrEuzyvgLHqueAwaZu1QjLcbRg494BjJLfUvVcPg7FUmybpZGLgee/4XADCLbgqooCBv0uMGhBW6FlvFOpkG+C2jZOGJSiR6Vfvkt2LhuHM9q6kQp0vCFY6BvJnkuN+NMhqSsRR+SZbrpblS1CQCp5A2SUYghNTUum0U9+aZ19YY77q8NtYODueV7qyWgEfUffmS+4b/QV+uZZ4cGIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0qWyOcRMxuXWgUrnXpgGBz6zLkc1mcNxtDk0OrRv/s=;
 b=kRHOD6GJmZqyb/YZDWWySLReH+hayrnLSrAHvkya2GLd/HRDnxF5/74KV/vd8YhjztuqaNPevEd2cqOiXK9NVN+nIhJLE1rBQjbgL0eW1Tt+A3Flwchfn7e0yh2Yd9XE2qPgp8y90mvuB9loLL0QM2gwhHYYVLHETApBpixAm08=
Received: from BN9P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::7)
 by CY8PR12MB7729.namprd12.prod.outlook.com (2603:10b6:930:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 17:25:25 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::b2) by BN9P221CA0012.outlook.office365.com
 (2603:10b6:408:10a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Thu,
 23 Apr 2026 17:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 17:25:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Apr
 2026 12:25:24 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 23 Apr 2026 12:25:23 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v26 0/8] Type2 device basic support
Date: Thu, 23 Apr 2026 19:05:20 +0100
Message-ID: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|CY8PR12MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d91dd5-b9fc-4989-d91e-08dea15d4e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OdE5g1FwzGv8o7rwVX+c9fPa4Ydl3FuPw6RwkF3yWCm6YW5m/MN5ZAsLHrRaX3ZcnQmbWO5UXdqVOmYXnRDP2B1RZb+xU5C2Z7y/wi15O3HYWITo+isiCzPNs2NGKh270OkDfW/zeDOhMGWUQgAO4e/CPhEfB6J12Vp4IwD+w4LvqKFeuY3jB8kUEVGyvIdd13G3ilZGL+xA4g5T31jqRheBIOY/a0OlR3V9BxzznOGGRas6g5KrC+pz6bT89BozXOs+/aJoXJ1DG4/HdXVu1QEgzO5oR+NVsN/uTSgvvLCUcRCDRFYW+3Ahx1Ko+1A2M6Sx0nhpMt9ZOF68Xv1Ux61JWwErlD1Flp1QRN2lIR3Dh2bCaAUIllnKvrlZPrDdbDeJW+uEt9SOlOxbeBbBQFy+YJyNUcKrepOrzXM0w7FccenegqG8j00qutD5tM7nM7fwI9XHL/RfCFXfwhlrKyKSZGHFZEaho7hAAGugCjmA0Bw/16hOxZaaw+RjvXa0Z9jms7Zwutyub6f++Lppsy//hy4ertyXToLkiVV0J0uiTd8KSa4zryJqBCwF67LDuaA8ONCOyW/Y2doZpZpvjlvFbWlnAWYPCKdt8kaowXP6F99IZckxew+DFXn0MR/l47NTFHsv/xL5iV7KOxOC9KMAgBOO9UScugtezOe6nE3Vea7SMR3kJ0xLOwJFGLk3oRYoU3Sjn+uAAK/m4xEIn7T7J14zTi8UcFjL/bWfgi+131SZLn717kKnkt8KwZMGLHyjlcJ6iB1NzvOEu01G+Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6tL/L2nbIjgRZY4Q6BqNpBM8XBC6gRLocL1crnWxUlvXJZlkCJTcwEOX4o3c++WV4IZjrK2SxgE3rBNd18rrFjUTry2bAzvJlaJdAjAqw71TnfCvH6OtnNUYIRK1kYZ0o8niZuaSii9z/A3B9Z5HjkqknltIQlBsJnBDse3VyalUGcpv+C0SDMvnyJSQFL2Fs1NXZTyqrnI5zenuXlDYO5w+9zpGQ1kZo2af/Zb48FRlt/BULLJS2aaQiGuabb+J3k5CS3HiC3U5LTn8RnoGa45ICOdfJRy+QA++exWDX0NRhxg+M2QSs1x4ZFMNO8lvAlJIv+FRHyqZ7fW3yx14PluBn/ofwExFq/hgVpCCl1HbZ0N6cnfbaIw90j5IuW6lppzTbDLTBM6ud72W+1mhOhNKH/wZq5yXmJpqLghbfWKYwfG6Vu+IKs4wkCi50kQN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 17:25:25.5615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d91dd5-b9fc-4989-d91e-08dea15d4e9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7729

From: Alejandro Lucero <alucerop@amd.com>

I feel this version suits better a RFC based on v25 plus the changes
introduced. It tries to address the problem of user space actions
triggering accelerator region removal, and extending Dan's approach
in here:

https://lore.kernel.org/linux-cxl/20260403210050.1058650-1-dan.j.williams@intel.com/T/#m2d9e5c59ce4873641037f9bcd2f70d5679cda03c

As discussed there, the protection needs to cover the accelerator driver
handling of the region physical range for things like ioremap, and to
offer a way for such driver to undo things or at least stop using that
very same physical range if the region disappears. It ends up merging
several of v25 patches into just one.

Another change is linking the region release to the endpoint device and
keep with Dan's autoremove. This makes unnecessary the previous cxl_exit
and similar actions are now performed inside region detach callback.

I think the outcome is quite promising, lowering the accelerator driver
complexity regarding region handling. The cost is those new callbacks
which I think are totally necessary for doing things safely with the
region by the driver.

I have successfully tested the cases of cxl_acpi removal while sfc
driver remaining, and cxl_mem unbinding sfc cxl memdev.

v26 changes:
 - patch 6: it implements all the new functionlity described above.
 - patch 8: region detach callback invokes a new sfc function for safely
	    stopping cxl-backed piobufs use.

Alejandro Lucero (8):
  sfc: add cxl support
  cxl/sfc: Map cxl regs
  cxl/sfc: Initialize dpa without a mailbox
  cxl: Prepare memdev creation for type2
  sfc: create type2 cxl memdev
  cxl: attach region to an accelerator/type2 memdev
  cxl: Avoid dax creation for accelerators
  sfc: support pio mapping based on cxl

 drivers/cxl/core/core.h               |   2 +
 drivers/cxl/core/mbox.c               |  51 +---------
 drivers/cxl/core/memdev.c             |  81 +++++++++++++++-
 drivers/cxl/core/pci.c                |   1 +
 drivers/cxl/core/port.c               |   1 +
 drivers/cxl/core/region.c             | 125 ++++++++++++++++++++++++-
 drivers/cxl/core/regs.c               |   1 +
 drivers/cxl/cxlmem.h                  |   6 --
 drivers/cxl/cxlpci.h                  |  12 ---
 drivers/cxl/mem.c                     |  45 ++++++---
 drivers/cxl/pci.c                     |   1 +
 drivers/net/ethernet/sfc/Kconfig      |   9 ++
 drivers/net/ethernet/sfc/Makefile     |   1 +
 drivers/net/ethernet/sfc/ef10.c       |  72 +++++++++++++--
 drivers/net/ethernet/sfc/efx.c        |  14 ++-
 drivers/net/ethernet/sfc/efx.h        |   1 +
 drivers/net/ethernet/sfc/efx_cxl.c    | 128 ++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  31 +++++++
 drivers/net/ethernet/sfc/net_driver.h |  12 +++
 drivers/net/ethernet/sfc/nic.h        |   3 +
 include/cxl/cxl.h                     |  25 +++++
 include/cxl/pci.h                     |  22 +++++
 22 files changed, 552 insertions(+), 92 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: 6596a02b207886e9e00bb0161c7fd59fea53c081
-- 
2.34.1

