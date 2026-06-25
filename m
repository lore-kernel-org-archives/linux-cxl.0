Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44051A9F87;
	Thu, 25 Jun 2026 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406564; cv=fail; b=ZLLYYXUqJFviyfRmqXZHiyGRXNqzkI8U5UnoOrK1YnOSoUv+uCVrXBjPnTrTS8Ap7UoOzHKDaVD0MfalRohXwp5kpI9/RQ28DaUh6q/r3qRNYB7KDq/hf8ppR3qWKE0c9ymMj59z7IMDtJBYSFlohifQFfCVQrytNA92Kt83Umw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406564; c=relaxed/simple;
	bh=oR97DVn7U42JSlZ+XLHS0g8aICinyi3GWYtkISnFj4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qq2cm1V4N7Wg/eS62XGR4j2+KgI4KRWQiT9qgs6x21lOS8j01ZnHOHY1mS+L7YSymV/quSaGPNxGXlTABF/mScwJo2X+xKxEFthTKQVB8obRuHqXUFoV/839v5Q9MOO0JhP/EQZXSbcM1AZKrFfAr77toFx5g8eVrYz9gwqCq5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B0yC2X65; arc=fail smtp.client-ip=52.101.52.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B0yC2X65"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udtYMIHdGBSOXFOdU3vRn+krXpUORXjW7G6u9bP6hX6PhaThJ9u0ptLHX5mSVNB8Fas4JAMTuXNIJid5XMK58LM1A7quyn1C/4fjVoad9JWUeUNltPGrtVRnIMsO2IxBz58lzmM/rSsW2WE4UeXYo8GBwcrhnoPQSa/V5KLFjBAp22/Ol+a4wLukpLxBsA/i5mkWdqQDqLSL7Q5x/oo2dPOhW7yGtzNG1xGItYm5cs6mFAKPq0t77/KHe81cyDXd1ML4EP+S2EWfHjU1Bbvi57XIpoH5Oz7XAqqRFY+KZ5M749TV0jcwSOxQ1Te9qRi77mauWDXr7ggWRjLSluslVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dqnF37LcE3I06QrfdHcm3H5m+IRr7arbRywMJT8MqA=;
 b=sTOcle+pbTUJOgDIjBdyMvYlqvAMVMYk/Q6i1osXphAcnI7uJpc2ggTWwwU46er8GtSBQ8sCd542RfkVzQC6h01/mwypSGKw2mLSvoPsbldty/GYW+X+zEDqsqtU9T9rgoWfCa+GZSROXNVvI2fE9rV7FWU5rdUVjTS3s8SmyY4XLNnh30Kn6kPOYQtIxgVbxMQJ4POy+c1q5GUDuDwLb9wxvphT0qPG+j8ZLzZt3ICOxhQH2DU9vPxYglt1lTbtYnP9CGcmTejog1iOedkmpmytc7hhWTuidEjxbsCKA7YrcynLIqvBlWhNAtLWGINi5IS2G6dxPkuBE6lCKzLXfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dqnF37LcE3I06QrfdHcm3H5m+IRr7arbRywMJT8MqA=;
 b=B0yC2X65oAmHkI0wVAFLt64JINp1o3XIdw2vyTFP4XeW8e1Pc/WcuMCp1MLML3yQTtXZqvQTd7wtoPXrNnNDxGmUYJuRCG8Y407n3uKjGGjkFbOJfQwDt/U/XSbTYOdxGWN6tncmvSabf/dRqJ/SDlZz22hxIvfFfKKKx84A0fM9kx+eiazpoFWWlKWnFtzOjUXDHkNVbYzMvml0wL74TWOraO93EU2nqno5OdKLMUeagk7u5Akt1JA3bogpTteSEFEM2pU+ibG7ZrRs1sH/+GnCTp8GjjdqvfrGVAL/DRANc1s5hVCkJg8GnJZeIWLnBSEXvjh1lAFsGHkd8ej+9Q==
Received: from SJ0PR13CA0046.namprd13.prod.outlook.com (2603:10b6:a03:2c2::21)
 by SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Thu, 25 Jun
 2026 16:55:50 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::94) by SJ0PR13CA0046.outlook.office365.com
 (2603:10b6:a03:2c2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.5 via Frontend Transport; Thu, 25
 Jun 2026 16:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 16:55:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:55:31 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 25 Jun 2026 09:55:23 -0700
From: <mhonap@nvidia.com>
To: <djbw@kernel.org>, <alex@shazbot.org>, <jgg@ziepe.ca>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <ankita@nvidia.com>,
	<alejandro.lucero-palau@amd.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <dmatlack@google.com>, <gourry@gourry.net>,
	<ira.weiny@intel.com>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v3 06/11] cxl: Add register-virtualization helpers for vfio Type-2 passthrough
Date: Thu, 25 Jun 2026 22:24:02 +0530
Message-ID: <20260625165407.1769572-7-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260625165407.1769572-1-mhonap@nvidia.com>
References: <20260625165407.1769572-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|SA0PR12MB4445:EE_
X-MS-Office365-Filtering-Correlation-Id: 798a6b6e-b983-4a3a-c03f-08ded2da9c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|7416014|6133799003|5023799004|56012099006|11063799006|13003099007|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	KQRJxtoBWJPFYLFIn5YLykigEAH+1eVOVRFuZRUk7Hlfj7s76lSjodYN0T9KdOsCH8Fnhj9SnyHFU370Rb43Y7SjDSTRisQE65yBo4k4vb/qkn8kR8/hU2xCWM3B+S+fZnp2brMjIvXjs4nEirGlFjQIv0whrsoeEfOVfel+cxM5gaHge/84gDayd+2PS/98JVtijUjCVfs2oUjwbuxqY3Fa8erDuMmAIIyp6eJOuSWg8pDvW2eVHaJpUrM2OaqkgZ9BwU+8ULLXA6SMGzBYVb0olrzC1WZr0t+yYP54EifyM/zfDvprXJk3F65K9L4pbeaTIuqLyGYaI3vg3F55KPIotlQFZ+PNl2UNaIxY0JTGB/+MjTyE/2ySjILiSPjactJE3dHX5/0DiePqqlS73lA3ZQcZngyxRtfhl7OqV1t44GMti8uX8W1rzHJy3EbD863tCuWdrjzafVKFk48qbv7/DgV3u9erd6xYz6FYIDwg7JEfehQELJzr1e1hy8Ap71kFEI4Z4ki1EwQTahHpMEoH0rvvmFClNH2A9/G85EkgtTU/vqFdGDBlYrx8XM+8e+YJikK7FaTL76KvIkJxkQ2/BI1Rg5DUeIP81iMQk7+xXsz/s9nczR+vHFTxRQrmqN6A5lsFg+33WBGSydq0yH8MsDggzAvYPOm7Pindk8zPlC99WO9qp0blINuPC/zpmnI4Ys5GuUzp0iqetNRrh3rOdFVI13H9Jtr0eJdNoRKYjThjSdEY2+Y05clgyG4r
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(7416014)(6133799003)(5023799004)(56012099006)(11063799006)(13003099007)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vhDS4bBJRzSRTMs7/RiNrNb3+1w6oRUiscGVDx0/w/dKaRqyUTUmvO5/kBpM9goCd63bo2rqUR3vdMU58ddXZkRt87bIDWuHBTLXcV5FNGgGLzr2VRCUGrhEX7aMH753XUOzvVzVC8M5hZ3NnqeuXQUtNLCpRSVH/vqBiAK7496YRVsVSBMKbwXjHq5X3J2zMMUndoOgSEOH8JVBdtQlLowrqidCA8KGdTV6xUC3tNQxDsSyVh5dzDcAx8u+dvfG/nzSB6GUMF4UzS8ZCZ1NFzrakBOmx+8eR18QkZmHulQGzdAtJaRMrH1zHsZw5CFxoCgSmXSEDSJdLyJjou+dTBdURO11D9VjRh60ZFAwMhtEefKsNnBhOmtIQdQ8lJ5iujZidwax7df222lyQaDyZUM9g/qQTSPujEqvIY10UIKuZVedUGU49KTWaZ35pS5Q
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:55:50.2836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 798a6b6e-b983-4a3a-c03f-08ded2da9c7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445

From: Manish Honap <mhonap@nvidia.com>

vfio-pci needs the CXL Device DVSEC body, the HDM Decoder Capability
block, and the CXL.cache/mem cap-array prefix to be virtualized
toward a KVM guest in a CXL-spec-compliant way.

Introduce a narrow helper API owned by cxl-core:

  struct cxl_passthrough *
  devm_cxl_passthrough_create(struct device *dev,
                              struct cxl_dev_state *cxlds);

  int cxl_passthrough_dvsec_rw(struct cxl_passthrough *p, u32 off,
                               u32 *val, size_t sz, bool write);
  int cxl_passthrough_hdm_rw(struct cxl_passthrough *p, u32 off,
                             u32 *val, bool write);
  int cxl_passthrough_cm_rw(struct cxl_passthrough *p, u32 off,
                            u32 *val, bool write);

Each helper takes a per-device mutex covering the DVSEC + HDM shadows
(the CM cap-array snapshot is immutable after create) and dispatches
by offset to a hand-written write handler against CXL r4.0 §8.1.3
(DVSEC: LOCK is RWO, CONTROL/CONTROL2 are RWL gated on CONFIG_LOCK,
STATUS/STATUS2 are RW1C, RANGE1 is HwInit, RANGE2 is RsvdZ) and
§8.2.4.20 (HDM: GLOBAL_CTRL RW, decoder CTRL implements
COMMIT/COMMITTED, decoder BASE/SIZE RWL gated on COMMITTED or
LOCK_ON_COMMIT, cap header HwInit).

Writes to the CM cap-array are silently discarded because the
cap-array headers are RO per CXL r4.0 §8.2.4; the write parameter is
kept on the rw API to make the drop policy explicit at the call site.

The shadows are snapshotted at create time: the DVSEC body from PCI
config space dword-at-a-time, the CM cap-array and HDM block from
the cxl-core MMIO mapping at cxlds->reg_map.base.  This preserves
firmware-committed values so the guest reads what the host BIOS
committed, while writes update the shadow per the per-field write
semantics above.

The file is gated by the hidden Kconfig CXL_VFIO_PASSTHROUGH so the
passthrough code stays out of cxl_core when no vfio consumer is configured.

Scope: firmware-committed, single-decoder, no-interleave Type-2
passthrough.  Multi-decoder, interleave, and hotplug are
out-of-scope and rejected at create time (-EOPNOTSUPP for
hdm_count != 1).

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/Kconfig            |   7 +
 drivers/cxl/core/Makefile      |   1 +
 drivers/cxl/core/passthrough.c | 590 +++++++++++++++++++++++++++++++++
 include/cxl/passthrough.h      | 121 +++++++
 4 files changed, 719 insertions(+)
 create mode 100644 drivers/cxl/core/passthrough.c
 create mode 100644 include/cxl/passthrough.h

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 80aeb0d556bd..7c874d486a9c 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -19,6 +19,13 @@ menuconfig CXL_BUS
 
 if CXL_BUS
 
+config CXL_VFIO_PASSTHROUGH
+	bool
+	# Hidden symbol selected by VFIO_PCI_CXL to pull
+	# drivers/cxl/core/passthrough.c into cxl_core when a vfio
+	# Type-2 passthrough consumer is configured.  Keep silent: no
+	# help text, no default, no user-visible prompt.
+
 config CXL_PCI
 	tristate "PCI manageability"
 	default CXL_BUS
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index ce7213818d3c..0cc80bd35a88 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -22,3 +22,4 @@ cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
 cxl_core-$(CONFIG_CXL_RAS) += ras.o
 cxl_core-$(CONFIG_CXL_RAS) += ras_rch.o
 cxl_core-$(CONFIG_CXL_ATL) += atl.o
+cxl_core-$(CONFIG_CXL_VFIO_PASSTHROUGH) += passthrough.o
diff --git a/drivers/cxl/core/passthrough.c b/drivers/cxl/core/passthrough.c
new file mode 100644
index 000000000000..b89829586024
--- /dev/null
+++ b/drivers/cxl/core/passthrough.c
@@ -0,0 +1,590 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2026 NVIDIA Corporation. All rights reserved.
+ *
+ * vfio-pci Type-2 device passthrough — CXL register virtualization.
+ *
+ * Owns the CXL spec-defined virtualization semantics for the
+ *   - CXL Device DVSEC capability body  (CXL r4.0 §8.1.3)
+ *   - HDM Decoder Capability block      (CXL r4.0 §8.2.4.20)
+ *   - CXL.cache/mem (CM) cap-array      (CXL r4.0 §8.2.4)
+ *
+ * vfio-pci is the only caller.  This file is NOT a generic emulation
+ * framework: every register the guest may touch has a hand-written
+ * write handler against the spec.  Reads serve from a shadow
+ * snapshotted at create time; writes update the shadow per the spec
+ * attribute mode for that field.
+ *
+ * Scope: firmware-committed, single-decoder, no-interleave Type-2
+ * passthrough.  Multi-decoder, interleave, and hotplug are
+ * out-of-scope and rejected at create time.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+#include <linux/pci_regs.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#include <uapi/cxl/cxl_regs.h>
+
+#include <cxlpci.h>
+#include <cxlmem.h>
+#include <cxl/cxl.h>
+#include <cxl/passthrough.h>
+
+#include "core.h"
+
+/* DVSEC CXL Device body offsets — relative to DVSEC capability start.
+ * Body begins at PCI_DVSEC_CXL_CAP (0x0a); preceding bytes are the PCI
+ * ext-cap header and DVSEC headers handled by the generic vfio
+ * perm-bits path.
+ */
+#define DVSEC_OFF_CAPABILITY		PCI_DVSEC_CXL_CAP	/* 0x0a, u16 */
+#define DVSEC_OFF_CONTROL		PCI_DVSEC_CXL_CTRL	/* 0x0c, u16 */
+#define DVSEC_OFF_STATUS		0x0e			/* u16 */
+#define DVSEC_OFF_CONTROL2		0x10			/* u16 */
+#define DVSEC_OFF_STATUS2		0x12			/* u16 */
+#define DVSEC_OFF_LOCK			0x14			/* u16 */
+#define DVSEC_OFF_RANGE1_SIZE_HI	0x18			/* u32 */
+#define DVSEC_OFF_RANGE1_SIZE_LO	0x1c
+#define DVSEC_OFF_RANGE1_BASE_HI	0x20
+#define DVSEC_OFF_RANGE1_BASE_LO	0x24
+#define DVSEC_OFF_RANGE2_SIZE_HI	0x28
+#define DVSEC_OFF_RANGE2_SIZE_LO	0x2c
+#define DVSEC_OFF_RANGE2_BASE_HI	0x30
+#define DVSEC_OFF_RANGE2_BASE_LO	0x34
+#define DVSEC_BODY_END			0x38
+
+#define DVSEC_LOCK_CONFIG_LOCK		BIT(0)
+
+/* HDM Decoder Capability block offsets — relative to HDM block base.
+ * Decoder N register set starts at 0x10 + N * 0x20.
+ */
+#define HDM_OFF_CAP_HEADER		0x00
+#define HDM_OFF_GLOBAL_CTRL		0x04
+#define HDM_DEC_BASE			0x10
+#define HDM_DEC_STRIDE			0x20
+#define HDM_DEC_OFF_BASE_LO(n)		(HDM_DEC_BASE + (n) * HDM_DEC_STRIDE + 0x00)
+#define HDM_DEC_OFF_BASE_HI(n)		(HDM_DEC_BASE + (n) * HDM_DEC_STRIDE + 0x04)
+#define HDM_DEC_OFF_SIZE_LO(n)		(HDM_DEC_BASE + (n) * HDM_DEC_STRIDE + 0x08)
+#define HDM_DEC_OFF_SIZE_HI(n)		(HDM_DEC_BASE + (n) * HDM_DEC_STRIDE + 0x0c)
+#define HDM_DEC_OFF_CTRL(n)		(HDM_DEC_BASE + (n) * HDM_DEC_STRIDE + 0x10)
+
+/* HDM Decoder CTRL bits per CXL r4.0 §8.2.4.20.5. */
+#define HDM_CTRL_LOCK_ON_COMMIT		BIT(8)
+#define HDM_CTRL_COMMIT			BIT(9)
+#define HDM_CTRL_COMMITTED		BIT(10)
+#define HDM_CTRL_ERR_NOT_COMMITTED	BIT(11)
+
+struct cxl_passthrough {
+	struct cxl_dev_state *cxlds;
+
+	/* DVSEC body shadow.  Byte-indexed by (off - PCI_DVSEC_CXL_CAP).
+	 * Allocated rounded up to a dword so dword reads at the tail
+	 * never overrun.
+	 */
+	u8 *dvsec_shadow;
+	u16 dvsec_size;			/* full DVSEC cap length, incl. headers */
+	bool dvsec_config_locked;
+
+	/* HDM block shadow.  Byte-indexed; size = hdm_reg_size. */
+	u8 *hdm_shadow;
+	resource_size_t hdm_reg_size;
+
+	/* CM cap-array snapshot.  Dword-indexed by (off / 4) where off
+	 * is the byte offset from CXL_CM_OFFSET.  Read-only after create.
+	 */
+	__le32 *cm_snapshot;
+	size_t cm_snapshot_dwords;
+
+	/* Covers dvsec_shadow + dvsec_config_locked + hdm_shadow.
+	 * cm_snapshot is immutable after create; no lock needed.  Leaf-
+	 * level: no entry point holding this mutex calls into cxl-bus or
+	 * vfio.
+	 */
+	struct mutex lock;
+};
+
+/* ------------------------------------------------------------------ */
+/* Snapshot helpers                                                    */
+/* ------------------------------------------------------------------ */
+
+/* Read the DVSEC body bytes [PCI_DVSEC_CXL_CAP, dvsec_size) from PCI
+ * config space into the shadow.
+ *
+ * The body starts at PCI_DVSEC_CXL_CAP (0x0a), which is word-aligned but
+ * NOT dword-aligned, and CXL r4.0 §8.1.3 places six 16-bit descriptors
+ * (CAPABILITY through LOCK) at offsets 0x0a..0x14 before any 32-bit
+ * field.  Strict-alignment PCIe host bridges (e.g. ARM64 ECAM) reject
+ * misaligned dword config accesses with PCIBIOS_BAD_REGISTER_NUMBER;
+ * snapshot at the natural granularity of the body's 16-bit descriptors
+ * (2-byte stride) so every offset in the range is naturally aligned.
+ */
+static int snapshot_dvsec_body(struct cxl_passthrough *p)
+{
+	struct pci_dev *pdev = to_pci_dev(p->cxlds->dev);
+	u16 dvsec = p->cxlds->cxl_dvsec;
+	u16 off;
+	u16 word;
+	int rc;
+
+	for (off = PCI_DVSEC_CXL_CAP; off < p->dvsec_size; off += 2) {
+		rc = pci_read_config_word(pdev, dvsec + off, &word);
+		if (rc)
+			return -EIO;
+		put_unaligned_le16(word, p->dvsec_shadow +
+				   (off - PCI_DVSEC_CXL_CAP));
+	}
+	return 0;
+}
+
+/* Read the CM cap-array prefix [CXL_CM_OFFSET, hdm_reg_offset) from
+ * MMIO into cm_snapshot, and the HDM block [hdm_reg_offset,
+ * hdm_reg_offset + hdm_reg_size) into hdm_shadow.
+ *
+ * @base is a short-lived kva for the component register block,
+ * established by the caller via ioremap() against cxlds->reg_map.resource.
+ * cxl_setup_regs() drops its own ioremap (clears reg_map.base) after the
+ * cap-array probe completes, so this function cannot rely on
+ * cxlds->reg_map.base being valid; the caller passes a fresh mapping
+ * here and releases it once snapshot data has been copied into the
+ * in-memory shadows.
+ */
+static void snapshot_cm_and_hdm(struct cxl_passthrough *p,
+				void __iomem *base,
+				resource_size_t hdm_off)
+{
+	size_t i;
+
+	for (i = 0; i < p->cm_snapshot_dwords; i++)
+		p->cm_snapshot[i] = cpu_to_le32(readl(base + CXL_CM_OFFSET +
+						      i * 4));
+
+	for (i = 0; i < p->hdm_reg_size / 4; i++)
+		put_unaligned_le32(readl(base + hdm_off + i * 4),
+				   p->hdm_shadow + i * 4);
+}
+
+/* ------------------------------------------------------------------ */
+/* devres                                                              */
+/* ------------------------------------------------------------------ */
+
+static void cxl_passthrough_release(struct device *dev, void *res)
+{
+	struct cxl_passthrough *p = *(struct cxl_passthrough **)res;
+
+	kfree(p->dvsec_shadow);
+	kfree(p->hdm_shadow);
+	kfree(p->cm_snapshot);
+	mutex_destroy(&p->lock);
+	kfree(p);
+}
+
+struct cxl_passthrough *
+devm_cxl_passthrough_create(struct device *dev, struct cxl_dev_state *cxlds)
+{
+	struct cxl_passthrough **dres;
+	struct cxl_passthrough *p;
+	struct pci_dev *pdev;
+	resource_size_t hdm_off, hdm_size;
+	size_t dvsec_shadow_size;
+	u8 hdm_count;
+	u32 hdr;
+	int rc;
+
+	/*
+	 * cxl_setup_regs() releases its short-lived ioremap before returning,
+	 * so reg_map.base is NULL by the time we run.  Validate the persistent
+	 * fields (resource address and size) instead; the local ioremap
+	 * established further below covers the snapshot reads.
+	 */
+	if (!dev || !cxlds || !cxlds->dev || !cxlds->cxl_dvsec ||
+	    !cxlds->reg_map.resource || !cxlds->reg_map.max_size)
+		return ERR_PTR(-EINVAL);
+
+	pdev = to_pci_dev(cxlds->dev);
+
+	rc = cxl_get_hdm_info(cxlds, &hdm_count, &hdm_off, &hdm_size);
+	if (rc)
+		return ERR_PTR(rc);
+	if (hdm_count != 1 || !hdm_size || hdm_off <= CXL_CM_OFFSET ||
+	    !IS_ALIGNED(hdm_size, 4))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	p = kzalloc_obj(*p, GFP_KERNEL);
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&p->lock);
+	p->cxlds = cxlds;
+	p->hdm_reg_size = hdm_size;
+
+	/* DVSEC body length from PCI ext-cap header. */
+	rc = pci_read_config_dword(pdev, cxlds->cxl_dvsec + PCI_DVSEC_HEADER1,
+				   &hdr);
+	if (rc) {
+		rc = -EIO;
+		goto err;
+	}
+	p->dvsec_size = PCI_DVSEC_HEADER1_LEN(hdr);
+	if (p->dvsec_size < DVSEC_BODY_END) {
+		rc = -EINVAL;
+		goto err;
+	}
+
+	dvsec_shadow_size = round_up(p->dvsec_size - PCI_DVSEC_CXL_CAP, 4);
+	p->dvsec_shadow = kzalloc(dvsec_shadow_size, GFP_KERNEL);
+	if (!p->dvsec_shadow) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	p->cm_snapshot_dwords = (hdm_off - CXL_CM_OFFSET) / 4;
+	p->cm_snapshot = kcalloc(p->cm_snapshot_dwords, sizeof(__le32),
+				 GFP_KERNEL);
+	if (!p->cm_snapshot) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	p->hdm_shadow = kzalloc(hdm_size, GFP_KERNEL);
+	if (!p->hdm_shadow) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	rc = snapshot_dvsec_body(p);
+	if (rc)
+		goto err;
+
+	{
+		void __iomem *base;
+
+		/*
+		 * Bind-time-only ioremap.  cxl_setup_regs() has already
+		 * released the cxl-core ioremap (see comment on the entry
+		 * gate).  Take a fresh, short-lived mapping for the
+		 * snapshot, then release it; all subsequent reads serve
+		 * from the in-memory shadows.
+		 */
+		base = ioremap(cxlds->reg_map.resource,
+			       cxlds->reg_map.max_size);
+		if (!base) {
+			rc = -ENOMEM;
+			goto err;
+		}
+		snapshot_cm_and_hdm(p, base, hdm_off);
+		iounmap(base);
+	}
+
+	dres = devres_alloc(cxl_passthrough_release, sizeof(*dres),
+			    GFP_KERNEL);
+	if (!dres) {
+		rc = -ENOMEM;
+		goto err;
+	}
+	*dres = p;
+	devres_add(dev, dres);
+	return p;
+
+err:
+	kfree(p->dvsec_shadow);
+	kfree(p->cm_snapshot);
+	kfree(p->hdm_shadow);
+	mutex_destroy(&p->lock);
+	kfree(p);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_passthrough_create, "CXL");
+
+/* ------------------------------------------------------------------ */
+/* DVSEC write semantics                                               */
+/* ------------------------------------------------------------------ */
+
+static u16 dvsec_shadow_get_u16(struct cxl_passthrough *p, u16 off)
+{
+	return get_unaligned_le16(p->dvsec_shadow + (off - PCI_DVSEC_CXL_CAP));
+}
+
+static void dvsec_shadow_set_u16(struct cxl_passthrough *p, u16 off, u16 val)
+{
+	put_unaligned_le16(val, p->dvsec_shadow + (off - PCI_DVSEC_CXL_CAP));
+}
+
+/* Apply a write to a single DVSEC field at @off, with the field's
+ * native width (2 for descriptors, 4 for RANGE entries).  @width is
+ * the field's spec width; @new is the merged value to apply.  Caller
+ * holds p->lock.
+ */
+static void dvsec_apply_write(struct cxl_passthrough *p, u16 off, size_t width,
+			      u32 new)
+{
+	u16 cur16;
+
+	switch (off) {
+	case DVSEC_OFF_CAPABILITY:
+		/* HwInit — drop. */
+		return;
+	case DVSEC_OFF_CONTROL:
+	case DVSEC_OFF_CONTROL2:
+		/* RWL — gated on CONFIG_LOCK. */
+		if (p->dvsec_config_locked)
+			return;
+		dvsec_shadow_set_u16(p, off, (u16)new);
+		return;
+	case DVSEC_OFF_STATUS:
+	case DVSEC_OFF_STATUS2:
+		/* RW1C — clear bits where the guest wrote 1. */
+		cur16 = dvsec_shadow_get_u16(p, off);
+		dvsec_shadow_set_u16(p, off, cur16 & ~(u16)new);
+		return;
+	case DVSEC_OFF_LOCK:
+		/* RWO — first 1-write latches CONFIG_LOCK; subsequent
+		 * writes are ignored.
+		 */
+		cur16 = dvsec_shadow_get_u16(p, off);
+		if (cur16 & DVSEC_LOCK_CONFIG_LOCK)
+			return;
+		if (new & DVSEC_LOCK_CONFIG_LOCK) {
+			dvsec_shadow_set_u16(p, off,
+					     cur16 | DVSEC_LOCK_CONFIG_LOCK);
+			p->dvsec_config_locked = true;
+		}
+		return;
+	case DVSEC_OFF_RANGE1_SIZE_HI:
+	case DVSEC_OFF_RANGE1_SIZE_LO:
+	case DVSEC_OFF_RANGE1_BASE_HI:
+	case DVSEC_OFF_RANGE1_BASE_LO:
+		/* HwInit — drop. */
+		return;
+	case DVSEC_OFF_RANGE2_SIZE_HI:
+	case DVSEC_OFF_RANGE2_SIZE_LO:
+	case DVSEC_OFF_RANGE2_BASE_HI:
+	case DVSEC_OFF_RANGE2_BASE_LO:
+		/* RsvdZ — drop. */
+		return;
+	default:
+		/* Reserved offsets inside the modelled body: drop. */
+		(void)width;
+		return;
+	}
+}
+
+/* Map a byte offset @off inside the DVSEC body to the natural-width
+ * field that contains it: returns the field's base offset (16-bit
+ * aligned for descriptors, 32-bit aligned for RANGE entries) and width.
+ * Returns false if @off lies outside any modelled field.
+ */
+static bool dvsec_field_at(u16 off, u16 *field_off, size_t *width)
+{
+	if (off >= DVSEC_OFF_CAPABILITY && off < DVSEC_OFF_RANGE1_SIZE_HI) {
+		*field_off = ALIGN_DOWN(off, 2);
+		*width = 2;
+		return true;
+	}
+	if (off >= DVSEC_OFF_RANGE1_SIZE_HI && off < DVSEC_BODY_END) {
+		*field_off = ALIGN_DOWN(off, 4);
+		*width = 4;
+		return true;
+	}
+	return false;
+}
+
+int cxl_passthrough_dvsec_rw(struct cxl_passthrough *p, u32 off, u32 *val,
+			     size_t sz, bool write)
+{
+	u8 *shadow;
+	u16 field_off;
+	size_t field_width;
+	u32 cur, merged;
+	u32 sub_shift;
+	u32 width_mask;
+
+	if (!p || !val)
+		return -EINVAL;
+	if (sz != 1 && sz != 2 && sz != 4)
+		return -EINVAL;
+	if (off < PCI_DVSEC_CXL_CAP || off + sz > p->dvsec_size)
+		return -EINVAL;
+
+	guard(mutex)(&p->lock);
+
+	shadow = p->dvsec_shadow + (off - PCI_DVSEC_CXL_CAP);
+
+	if (!write) {
+		switch (sz) {
+		case 1:
+			*val = *shadow;
+			break;
+		case 2:
+			*val = get_unaligned_le16(shadow);
+			break;
+		case 4:
+			*val = get_unaligned_le32(shadow);
+			break;
+		}
+		return 0;
+	}
+
+	if (!dvsec_field_at(off, &field_off, &field_width))
+		return 0;	/* outside any modelled field: drop */
+
+	/* Read-modify-merge the field at its natural width. */
+	if (field_width == 2)
+		cur = dvsec_shadow_get_u16(p, field_off);
+	else
+		cur = get_unaligned_le32(p->dvsec_shadow +
+					 (field_off - PCI_DVSEC_CXL_CAP));
+
+	width_mask = (sz == 4) ? 0xffffffff : (sz == 2 ? 0xffff : 0xff);
+	sub_shift = (off - field_off) * 8;
+	merged = cur & ~(width_mask << sub_shift);
+	merged |= (*val & width_mask) << sub_shift;
+
+	dvsec_apply_write(p, field_off, field_width, merged);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_passthrough_dvsec_rw, "CXL");
+
+/* ------------------------------------------------------------------ */
+/* HDM write semantics                                                 */
+/* ------------------------------------------------------------------ */
+
+static u32 hdm_shadow_get(struct cxl_passthrough *p, u32 off)
+{
+	return get_unaligned_le32(p->hdm_shadow + off);
+}
+
+static void hdm_shadow_set(struct cxl_passthrough *p, u32 off, u32 val)
+{
+	put_unaligned_le32(val, p->hdm_shadow + off);
+}
+
+/* Decoder index for a per-decoder register offset. */
+static u32 hdm_decoder_of(u32 off)
+{
+	return (off - HDM_DEC_BASE) / HDM_DEC_STRIDE;
+}
+
+static u32 hdm_decoder_field(u32 off)
+{
+	return (off - HDM_DEC_BASE) % HDM_DEC_STRIDE;
+}
+
+static void hdm_decoder_ctrl_write(struct cxl_passthrough *p, u32 off, u32 val)
+{
+	u32 cur = hdm_shadow_get(p, off);
+	u32 next;
+
+	/* Once COMMITTED, only the COMMIT toggle is honoured.  Releasing
+	 * COMMIT clears COMMITTED and Lock-on-Commit per CXL r4.0
+	 * §8.2.4.20.5.
+	 */
+	if (cur & HDM_CTRL_COMMITTED) {
+		next = (cur & ~HDM_CTRL_COMMIT) | (val & HDM_CTRL_COMMIT);
+		if (!(val & HDM_CTRL_COMMIT)) {
+			next &= ~HDM_CTRL_COMMITTED;
+			next &= ~HDM_CTRL_LOCK_ON_COMMIT;
+		}
+		hdm_shadow_set(p, off, next);
+		return;
+	}
+
+	next = val & ~(HDM_CTRL_COMMITTED | HDM_CTRL_ERR_NOT_COMMITTED);
+	if (val & HDM_CTRL_COMMIT)
+		next |= HDM_CTRL_COMMITTED;
+	hdm_shadow_set(p, off, next);
+}
+
+static void hdm_decoder_basesize_write(struct cxl_passthrough *p, u32 off,
+				       u32 val)
+{
+	u32 n = hdm_decoder_of(off);
+	u32 ctrl = hdm_shadow_get(p, HDM_DEC_OFF_CTRL(n));
+
+	/* RWL — BASE/SIZE locked when the decoder is committed or
+	 * lock-on-commit has been latched.
+	 */
+	if (ctrl & (HDM_CTRL_COMMITTED | HDM_CTRL_LOCK_ON_COMMIT))
+		return;
+	hdm_shadow_set(p, off, val);
+}
+
+int cxl_passthrough_hdm_rw(struct cxl_passthrough *p, u32 off, u32 *val,
+			   bool write)
+{
+	u32 field;
+
+	if (!p || !val)
+		return -EINVAL;
+	if (!IS_ALIGNED(off, 4) || off + 4 > p->hdm_reg_size)
+		return -EINVAL;
+
+	guard(mutex)(&p->lock);
+
+	if (!write) {
+		*val = hdm_shadow_get(p, off);
+		return 0;
+	}
+
+	switch (off) {
+	case HDM_OFF_CAP_HEADER:
+		/* HwInit — drop. */
+		return 0;
+	case HDM_OFF_GLOBAL_CTRL:
+		/* RW — shadow. */
+		hdm_shadow_set(p, off, *val);
+		return 0;
+	}
+
+	if (off < HDM_DEC_BASE)
+		return 0;	/* gap before per-decoder regs: drop */
+
+	field = hdm_decoder_field(off);
+	switch (field) {
+	case 0x00: case 0x04:	/* BASE_LO / BASE_HI */
+	case 0x08: case 0x0c:	/* SIZE_LO / SIZE_HI */
+		hdm_decoder_basesize_write(p, off, *val);
+		return 0;
+	case 0x10:		/* CTRL */
+		hdm_decoder_ctrl_write(p, off, *val);
+		return 0;
+	default:
+		/* TARGET_LIST_{LO,HI} and other per-decoder bytes are
+		 * accepted as plain RW shadow for the firmware-committed
+		 * scope; multi-decoder / interleave behaviour is
+		 * out-of-scope.
+		 */
+		hdm_shadow_set(p, off, *val);
+		return 0;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_passthrough_hdm_rw, "CXL");
+
+/* ------------------------------------------------------------------ */
+/* CM cap-array snapshot                                               */
+/* ------------------------------------------------------------------ */
+
+int cxl_passthrough_cm_rw(struct cxl_passthrough *p, u32 off, u32 *val,
+			  bool write)
+{
+	if (!p || !val)
+		return -EINVAL;
+	if (!IS_ALIGNED(off, 4) || off / 4 >= p->cm_snapshot_dwords)
+		return -EINVAL;
+
+	if (write)
+		return 0;	/* cap-array headers are RO; drop. */
+
+	*val = le32_to_cpu(p->cm_snapshot[off / 4]);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_passthrough_cm_rw, "CXL");
diff --git a/include/cxl/passthrough.h b/include/cxl/passthrough.h
new file mode 100644
index 000000000000..43214b0d34f6
--- /dev/null
+++ b/include/cxl/passthrough.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2026 NVIDIA Corporation. All rights reserved.
+ *
+ * CXL register virtualization helpers for vfio-pci Type-2 passthrough.
+ *
+ * See Documentation/driver-api/vfio-pci-cxl.rst for the ownership
+ * contract.  In short: cxl-core owns the per-device DVSEC body, HDM
+ * Decoder block, and CM cap-array shadows; vfio-pci is a transport
+ * that forwards guest reads and writes through the helpers below.
+ *
+ * The helpers are not a generic emulation framework.  Each register
+ * is hand-coded against CXL r4.0 §8.1.3 and §8.2.4.20.  Adding a new
+ * field is "add a case", not "add a mode".
+ */
+#ifndef __CXL_PASSTHROUGH_H__
+#define __CXL_PASSTHROUGH_H__
+
+#include <linux/types.h>
+
+struct cxl_dev_state;
+struct cxl_passthrough;
+struct device;
+
+/**
+ * devm_cxl_passthrough_create - snapshot a Type-2 device's DVSEC + HDM +
+ * CM cap-array shadows and return the opaque handle the rw helpers
+ * operate on.
+ *
+ * @dev: device whose devres lifetime bounds the returned handle.
+ * @cxlds: CXL device state with cxlds->cxl_dvsec populated and
+ *	   cxlds->reg_map.resource and cxlds->reg_map.max_size describing
+ *	   the component register block.  cxlds->reg_map.base is NOT
+ *	   required; cxl_pci_setup_regs() releases its short-lived
+ *	   ioremap before returning, so this helper takes a local
+ *	   bind-time ioremap against cxlds->reg_map.resource for the
+ *	   duration of the snapshot.
+ *
+ * On success the returned handle is bound to @dev's devres so unwind
+ * happens automatically when @dev is unbound.  The handle must not be
+ * freed by the caller.
+ *
+ * Return: a valid &struct cxl_passthrough on success, ERR_PTR(-errno)
+ * on failure.
+ */
+struct cxl_passthrough *
+devm_cxl_passthrough_create(struct device *dev, struct cxl_dev_state *cxlds);
+
+/**
+ * cxl_passthrough_dvsec_rw - read or write the CXL Device DVSEC body shadow.
+ *
+ * @p: handle from devm_cxl_passthrough_create().
+ * @off: byte offset from the start of the DVSEC capability.  Must be
+ *	 >= PCI_DVSEC_CXL_CAP and (off + sz) must lie inside the DVSEC.
+ *	 Accesses to the PCI ext-cap header bytes (off < PCI_DVSEC_CXL_CAP)
+ *	 are the caller's responsibility; they belong on the generic
+ *	 perm-bits path, not here.
+ * @val: pointer to a u32 holding the read result or the write value.
+ *	 The low @sz bytes of *val are the payload; upper bytes ignored
+ *	 for writes and zero for reads.
+ * @sz: 1, 2, or 4.  Other values return -EINVAL.
+ * @write: false for read, true for write.
+ *
+ * Reads serve from the shadow.  Writes update the shadow per the spec
+ * attribute mode for the addressed field (LOCK is RWO, CONTROL/CONTROL2
+ * are RWL gated on CONFIG_LOCK, STATUS/STATUS2 are RW1C, RANGE1/2 are
+ * HwInit, Reserved/RsvdZ silently consumed).
+ *
+ * Known limitation: a 4-byte write whose @off straddles a 16-bit DVSEC
+ * field boundary (CONTROL/STATUS at 0x0c/0x0e, CONTROL2/STATUS2 at
+ * 0x10/0x12) applies only the field containing the first byte of the
+ * access; the adjacent 16-bit field is not updated by the same write.
+ * Standard CXL register-access patterns issue separate 2-byte accesses
+ * to CONTROL, STATUS, CONTROL2 and STATUS2, so this corner case is
+ * documented rather than handled.
+ *
+ * Return: 0 on success; -EINVAL on out-of-range or bad size.
+ */
+int cxl_passthrough_dvsec_rw(struct cxl_passthrough *p, u32 off, u32 *val,
+			     size_t sz, bool write);
+
+/**
+ * cxl_passthrough_hdm_rw - read or write the HDM Decoder block shadow.
+ *
+ * @p: handle from devm_cxl_passthrough_create().
+ * @off: byte offset from the HDM block base; must be 4-byte aligned and
+ *	 (off + 4) <= hdm_reg_size.  Sub-dword access is not supported on
+ *	 HDM registers per CXL r4.0 §8.2.4.
+ * @val: pointer to a u32 holding the read result or the write value.
+ * @write: false for read, true for write.
+ *
+ * Reads serve from the shadow.  Writes implement the per-decoder
+ * COMMIT/COMMITTED handshake (CTRL) and the RWL gating on BASE/SIZE
+ * imposed by COMMITTED|LOCK_ON_COMMIT.  GLOBAL_CTRL is RW; the cap
+ * header is HwInit (writes dropped); other offsets in the per-decoder
+ * stride are RW shadow.
+ *
+ * Return: 0 on success; -EINVAL on misalignment or out-of-range.
+ */
+int cxl_passthrough_hdm_rw(struct cxl_passthrough *p, u32 off, u32 *val,
+			   bool write);
+
+/**
+ * cxl_passthrough_cm_rw - read or write the CXL.cache/mem cap-array snapshot.
+ *
+ * @p: handle from devm_cxl_passthrough_create().
+ * @off: byte offset from CXL_CM_OFFSET (the start of the CM cap-array
+ *	 header in the component register block); must be 4-byte aligned
+ *	 and (off + 4) <= cm_snapshot_size.
+ * @val: pointer to a u32 holding the read result; ignored on write.
+ * @write: false for read.  Writes to the cap-array are silently dropped
+ *	   (the array headers are RO per CXL r4.0 §8.2.4); the @write
+ *	   parameter is present only to keep the API symmetric with the
+ *	   other rw helpers and to make the drop policy explicit at the
+ *	   call site.
+ *
+ * Return: 0 on success; -EINVAL on misalignment or out-of-range.
+ */
+int cxl_passthrough_cm_rw(struct cxl_passthrough *p, u32 off, u32 *val,
+			  bool write);
+
+#endif /* __CXL_PASSTHROUGH_H__ */
-- 
2.25.1

