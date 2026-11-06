Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793937654;
	b=xsN4YooZZcCAS13BcDThL3twwCUhko0SKH2BkVJWCT4Vc7JB5Nv0ykGjQGPcvZprlZvB
	 jPeVcJ3KxAU9YLxV1jgyGYkVAXDX5e9pSbFNqWaVhIKGnovWbvKuQhzTk4QgJj6yjB1bV
	 M4NDEbAAH+MwujQwoEeroDPAOcr5Po3+s6pjf44WaXYjKGFsypospXs+XNsQcg2t9Og/7
	 dqxc5ijvKRqUPBuE4qBXaWKUAdPSHiY2O+TTdDMmFjlnYlITSkW5oVYQmdFbO0u/gNr76
	 1s+hCivfgH4t6BCAO58UmFvnFQ0KYxVpEnYdsI4gynzFJulKKAkHamOXSp35IiNDSLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937654;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=t9HEYgG1xSDigxoKpeZ4Cik9UTKklZs9bqevmIavTU0=;
	b=46FE52HZUwWz9WOkUdgG9h8XMkGubBVaPh7hPzoLUAcw5Nf+86d3uU9+63JEQP8L1RFA
	 tnvd1ImLKJCk7jRswfwYLflQjO9CCKaf8ueHoKjmurlZU+f8s1R4+wg2hpe39t6I/lQoH
	 cetoErYcfETvB2GGDrnyniRfdTVICivA3DFOuafz4zq5Yf5VOLVqu6ERnwXO6QZM+4ikN
	 Kjy9A+P+X6mYG0Jvwi/xwuR4FZuI6bFxKsPjH9P2xA6BIRQ/tqWaDTozke9jHVspNG4TN
	 Nqjd9XuJz2s+62P2tNcaXkWcyg3G7W2LmamCM9sZDwTb8wrkjYDCZ/IaGslJj95PguA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="jrn/aKK3";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.30
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B04606A31B
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 04:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4B04606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jrn/aKK3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLha8A1Tc8UlzgeHRVMUMvsRb7n98IcGRJB7DYjFgh6iqjIHWbCsPtLrdECGBymYzIU5F2M72+GuH3C1LZTei0LTXm18WTIcIoGFUvHg2sT5IG5L+/pZC8nSmhl7FXjGcUamVqWsjT22iX1mMj0sDgVFqsf4fOgm4E/SZAyMFw8gNYLmZXw1a6Jg/+bwS7jOLcRavqt9QJvuJjj8bpIlzORfJja7daiok2q0mfx+LPRmyKjr5XB5L7c7yd/1j2dPS0plGklF8nLVOGhIgdMUjW5nIS294jX+TgVXrGN/xsI/Q6GU2r98kmizJfaIZlvrsj2tm+NAA/4PTuvmmFCa9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9HEYgG1xSDigxoKpeZ4Cik9UTKklZs9bqevmIavTU0=;
 b=ItFxia/S5RwoRb34RuA/y9+SpeBlk07zYDVa/ioMll8RIFLatrhI/5cby79JjGCg/UKuuDgLHONR8lFaFwHe2W1eQkWE98AQ+s7CFW1CN6vRk1U4Qf0ZnD/N9FwM+cxRIYatsMwXXmH1W9BzOFiOZiA0uy5/ltP9cwHA9EoKXkrnmtR7h5IDK/kpKsW9/b92LxT9ED9OuYXvf0bLA50DDDxB6KiGHumq2gwbiShwvWzfwWaGCf6cf0dVXQlbpAbbcmygD8CHPxydkdoZGGKb/m2nedK+dHlMXf+ToFqr0gFJpcBS3o6bgypzm5i48gH4S/OTD+jTK4eV/yGM7gqwtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9HEYgG1xSDigxoKpeZ4Cik9UTKklZs9bqevmIavTU0=;
 b=jrn/aKK3vUaz7GHBkMjty4ToeoB4m+akGR7G148WFw5Hq9RT9HANCzJ/FSX2vASRIYPUXgSv5K8QLtYSKeHBCffM0yPSQE0ohWpfkTp4gBRAFub9pla7J9gZQLEHQ5vD5UYJ56ppiucbcw/gJXxE4LUn311YWf8irov8oIzBd4ZuLe2+LKMn+A8t6+/JTPgVoxi64zX+CyAxf2/wxlQScv4ElGbKlYVIXfQu85BCCQ9DvHqAnolUaMHCzAQBkUwFXZFwACrSQjkAiSATcW8JYt18TOikKh+l3ovImxAFFPWwQX3DcNM3QMFqvhu2SN/b296LNJN5BEsyiq1EsmyKmw==
Received: from SJ0PR03CA0068.namprd03.prod.outlook.com (2603:10b6:a03:331::13)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:00:38 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::ac) by SJ0PR03CA0068.outlook.office365.com
 (2603:10b6:a03:331::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri, 6
 Nov 2026 04:00:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:00:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:16 -0800
Received: from cxlgalaxy.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:11 -0800
From: <mhonap@nvidia.com>
To: <jic23@kernel.org>, <alwilliamson@nvidia.com>, <clg@redhat.com>,
	<xueshuai@linux.alibaba.com>, <ira.weiny@intel.com>, <zhiw@nvidia.com>,
	<mst@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<junjie.cao@linux.dev>, <anisa.su@samsung.com>, <pbonzini@redhat.com>,
	<ankita@nvidia.com>, <vsethi@nvidia.com>, <skolothumtho@nvidia.com>,
	<mochs@nvidia.com>
CC: <cjia@nvidia.com>, <mhonap@nvidia.com>, <kjaju@nvidia.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Zhi Wang
	<zhiwang@kernel.org>
Subject: [RFC 08/18] hw/cxl: Introduce CXL type-2 device emulation
Date: Fri, 6 Nov 2026 09:29:01 +0530
Message-ID: <20261106035911.1280066-9-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106035911.1280066-1-mhonap@nvidia.com>
References: <20261106035911.1280066-1-mhonap@nvidia.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: a589f8cd-cb97-4017-4086-08df3bba848c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|23010399003|22082099003|18002099003|921020|56012099006|261028144727099003|5023799004|261022113327099003|261022105027099003|10067099003|261021135927099003|261009223027099003|261026121527099003|261102123227099003|11063799006|261021121427099003|261026140227099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	IXbtNh8luV+jLYH1VInmskKkq1N17X7Jj6ufhB35lhRp19L/Kc4PgCKQCZaytU15mRUzdQVAvBZ/6NFzbAJIlyrvTyQO5XK7DpBv2GfvcQjhIWid4K3eKgzI1D2PEbVvHi3F6Ei30xUsnu+3uYDU3VlvPZhSKkCTBJwbJ7zl424cPBKsYEaOhh+QtyWIAd2N8e1xXihh3kE/MBsNPZ8rDizyczzmjW56MY02Fniikr15yCk2c2JwgVFF4CqZWDwCkDPQm7Xr2Trz/qTro7tGY2iy+KGBD6n9Q4LrouyBzU8nkUNeREpb9Cdnj+qTStfooVGl9iQhwlf0hz3TenttaeywYFxiJvAha8btOBcLJp6uFu08NCvJqoc6p/MHSiq+91Ivz1grHGiGxl5HE2O94vYvByP5+RU+vPIamR2KH5T6pDSV5D81z9vD6p9DVJcjuZcnSbUR9mHCR6dPytotSK/+2tWT/LKeCXYz84lZby3i1C1VA1XtdOEcdcYF8zvJEYymtz8eULaQ/X25YQ9SDH+1hOEvsD2xFkEw0ZW2G9ngqGJO6O/LNyWeOyHL1vqo0u5H6WrUxQf+TXF6ko19m2ydspo6BL5fkIoqvy1MTQamWfE4aLNsdjMzQ8OYmU01hkYN/2C6oNfNlAtjnBIzm+MC7FvQ8iU8B9M5p7nKxiUcAacBP4sloBopGiey71V/gAk4PzvNKZOHhVsbqYsLL01wy3j/9AGrUED6kVBL0avEjmL+n8dNQSfMgyft9AWO
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(921020)(56012099006)(261028144727099003)(5023799004)(261022113327099003)(261022105027099003)(10067099003)(261021135927099003)(261009223027099003)(261026121527099003)(261102123227099003)(11063799006)(261021121427099003)(261026140227099003)(260925021311599003)(260925021911599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tPGFFLmeY+7neaTKmpZUJ4rJc1KO64F4kcnb04c5e9wm6Te9EFUvVu5tbrfbRYMSlCWmRzJAeBokgSIptWD19/E8031Kpoy/VMswZm+4amqrE/lwibnchv8jAUqKAEnuSCt6kpyGaS9d2cQEduxJLJ+RV+7E/Q+CI5LMaGOXi+zt6P/huq3TUkR4eATOp1kOIG9x9+9eeyBnq7VUm18mYkCkQ0eqqdGxeU6U36qL82gt6kil+jZNkjPOUTDgk2/y6/CK/5hQ/9soQGcllGuSvmqGI7BP7xHY2Tm0d0+JpB7PHkc8HPx6g2NUC9WWj3w5CPgBWeYDv1Ud9QtjHFKCSIIxCJIlUjAi8KoxiFJqStT0X2lsrUwcRntldPlFNLoBNdkyicBawSYcKgvN6Jg0gVkggqNfJGiAkIZd3x3+IfUbkAZIGTjdWNXbo1fzu/bc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:00:38.2723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a589f8cd-cb97-4017-4086-08df3bba848c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420

From: Zhi Wang <zhiwang@kernel.org>

Add cxl-type2, a minimal CXL Type-2 device for testing the Linux CXL
core Type-2 support and CXL Type-2 passthrough. It does not reuse
cxl-type3, as most Type-3 features do not apply to a Type-2 device.

This patch adds the device and its volatile memory backend. The next
two add the component registers and guest access to the memory through
the fixed memory windows.

Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Zhi Wang <zhiwang@kernel.org>
[ clg: - use PCI_CLASS_MEMORY_CXL instead of PCI_CLASS_CXL_QEMU_ACCEL
         to match cxl_pci driver expectations
       - rebased on upstream ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
[ mhonap: - split the original patch in three patches
          - rename cxl-accel to cxl-type2
          - use the Red Hat ID 1b36:0017 and the processing accelerator
            class 0x1200, so that cxl_pci does not bind to the device
          - require volatile-memdev
          - release the memory backend on exit
          - refuse migration, the device state is not migrated yet
          - drop MSI-X, nothing uses it yet
          - license GPL-2.0-or-later
          - reword the commit message ]
AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 MAINTAINERS                 |   1 +
 hw/mem/Kconfig              |   5 ++
 hw/mem/cxl_type2.c          | 111 ++++++++++++++++++++++++++++++++++++
 hw/mem/meson.build          |   1 +
 include/hw/cxl/cxl_device.h |  14 +++++
 5 files changed, 132 insertions(+)
 create mode 100644 hw/mem/cxl_type2.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 55463103ff..57a78bc6a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3399,6 +3399,7 @@ R: Anisa Su <anisa.su@samsung.com>
 L: linux-cxl@vger.kernel.org
 S: Supported
 F: hw/cxl/
+F: hw/mem/cxl_type2.c
 F: hw/mem/cxl_type3.c
 F: include/hw/cxl/
 F: qapi/cxl.json
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
index 39ddb36710..6a5cd2be61 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -17,6 +17,11 @@ config CXL_MEM_DEVICE
     default y if CXL
     select MEM_DEVICE
 
+config CXL_TYPE2_DEVICE
+    bool
+    default y if CXL
+    select MEM_DEVICE
+
 config SP_MEM
     bool
     select MEM_DEVICE
diff --git a/hw/mem/cxl_type2.c b/hw/mem/cxl_type2.c
new file mode 100644
index 0000000000..4769793e06
--- /dev/null
+++ b/hw/mem/cxl_type2.c
@@ -0,0 +1,111 @@
+/*
+ * CXL Type-2 device
+ *
+ * Copyright(C) 2024 NVIDIA Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/cxl/cxl.h"
+#include "hw/pci/pci.h"
+#include "migration/vmstate.h"
+#include "system/hostmem.h"
+
+static void clean_memory(PCIDevice *pci_dev)
+{
+    CXLType2Dev *ct2d = CXL_TYPE2(pci_dev);
+
+    address_space_destroy(&ct2d->hostvmem_as);
+    host_memory_backend_set_mapped(ct2d->hostvmem, false);
+}
+
+static bool setup_memory(PCIDevice *pci_dev, Error **errp)
+{
+    CXLType2Dev *ct2d = CXL_TYPE2(pci_dev);
+    MemoryRegion *vmr;
+
+    if (!ct2d->hostvmem) {
+        error_setg(errp, "volatile-memdev property must be set");
+        return false;
+    }
+    vmr = host_memory_backend_get_memory(ct2d->hostvmem);
+    if (!vmr) {
+        error_setg(errp, "volatile memdev must have backing device");
+        return false;
+    }
+    if (host_memory_backend_is_mapped(ct2d->hostvmem)) {
+        error_setg(errp, "memory backend %s can't be used multiple times.",
+                   object_get_canonical_path_component(OBJECT(ct2d->hostvmem)));
+        return false;
+    }
+    memory_region_set_nonvolatile(vmr, false);
+    memory_region_set_enabled(vmr, true);
+    host_memory_backend_set_mapped(ct2d->hostvmem, true);
+    address_space_init(&ct2d->hostvmem_as, vmr, "cxl-type2-dpa-vmem-space");
+    return true;
+}
+
+static void cxl_type2_realize(PCIDevice *pci_dev, Error **errp)
+{
+    if (!setup_memory(pci_dev, errp)) {
+        return;
+    }
+
+    pcie_endpoint_cap_init(pci_dev, 0x80);
+}
+
+static void cxl_type2_exit(PCIDevice *pci_dev)
+{
+    clean_memory(pci_dev);
+}
+
+static const Property cxl_type2_props[] = {
+    DEFINE_PROP_LINK("volatile-memdev", CXLType2Dev, hostvmem,
+                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
+};
+
+static const VMStateDescription cxl_type2_vmsd = {
+    .name = TYPE_CXL_TYPE2,
+    .unmigratable = 1,
+};
+
+static void cxl_type2_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
+
+    pc->realize = cxl_type2_realize;
+    pc->exit = cxl_type2_exit;
+
+    pc->class_id = PCI_CLASS_ACCELERATOR_PROCESSING;
+    pc->vendor_id = PCI_VENDOR_ID_REDHAT;
+    pc->device_id = PCI_DEVICE_ID_REDHAT_CXL_TYPE2;
+    pc->revision = 1;
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "CXL Type-2 device";
+    dc->vmsd = &cxl_type2_vmsd;
+    device_class_set_props(dc, cxl_type2_props);
+}
+
+static const TypeInfo cxl_type2_dev_info = {
+    .name = TYPE_CXL_TYPE2,
+    .parent = TYPE_PCI_DEVICE,
+    .class_init = cxl_type2_class_init,
+    .instance_size = sizeof(CXLType2Dev),
+    .interfaces = (const InterfaceInfo[]) {
+        { INTERFACE_CXL_DEVICE },
+        { INTERFACE_PCIE_DEVICE },
+        {}
+    },
+};
+
+static void cxl_type2_dev_registers(void)
+{
+    type_register_static(&cxl_type2_dev_info);
+}
+
+type_init(cxl_type2_dev_registers);
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
index f410d75475..0b2c193a78 100644
--- a/hw/mem/meson.build
+++ b/hw/mem/meson.build
@@ -4,6 +4,7 @@ mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
 mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
 mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
 mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
+mem_ss.add(when: 'CONFIG_CXL_TYPE2_DEVICE', if_true: files('cxl_type2.c'))
 mem_ss.add(when: 'CONFIG_SP_MEM', if_true: files('sp-mem.c'))
 stub_ss.add(files('cxl_type3_stubs.c'))
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 608d05165a..aeccf42855 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -830,6 +830,20 @@ struct CSWMBCCIDev {
 #define TYPE_CXL_SWITCH_MAILBOX_CCI "cxl-switch-mailbox-cci"
 OBJECT_DECLARE_TYPE(CSWMBCCIDev, CSWMBCCIClass, CXL_SWITCH_MAILBOX_CCI)
 
+struct CXLType2Dev {
+    /* Private */
+    PCIDevice parent_obj;
+
+    /* Properties */
+    HostMemoryBackend *hostvmem;
+
+    /* State */
+    AddressSpace hostvmem_as;
+};
+
+#define TYPE_CXL_TYPE2 "cxl-type2"
+OBJECT_DECLARE_SIMPLE_TYPE(CXLType2Dev, CXL_TYPE2)
+
 MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
                            unsigned size, MemTxAttrs attrs);
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
-- 
2.53.0

