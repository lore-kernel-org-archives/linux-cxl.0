Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793937666;
	b=lCg3cG3aEgRkeEdGs2GPSvuO581bcr+CyCg28fn1Z7JgG2310Yz6SCboXaLRHVw2rXdv
	 fAW5BKA5h/Prgcx9+5TpSJfXW/W+dW/IImIYWZKG1apRDGjcUuZMISLO87TLSCEjlHOAy
	 +b4HIpJ+u0wsC6IzMdLdmma180uma+K9fExZndyrcKfa43bgdPAuu6GG7frFw9p4MBZ5F
	 eSDmvFLkALg0J1T5RyLw6f2e7Qr+RK0PvTFzExI+aZBCGtedhmOVJao7+evrKIUt/zZpi
	 iWaapX8WpZ0HsRfBBHyU0HeOLcNRwG69+BYRsDoDxRMcLC/4UArmEQV7qflQTz1qj+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937666;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
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
	bh=R3QY/2ANHtc4CyhbWrL6c53DplsZ8DBJ/FY4exSFt54=;
	b=Epwho3Y5InIgmsFWX5Iq/ufROIn3mNA7rpPraGhDf+7cWpns0UIEA1qDLVZ3kHFwGY2Z
	 V7zWEpY/LZ4/zUUJGUB8DtH4gZ801W9l1/yKxJLxBgDJXAn7HOWiqjLL56jZM14SdVeLu
	 dnogDgRsDmi8S806YOCnpE7Yj1un5qVP21BFlPYYRTIvOdldWIf+lp1b5I3ChbkAXtN82
	 hU8Y67BEkseDYDnwLfwbHVzqIkp5HlMgoBtmAYMi6YCTW5caGKnbNcM/bn1LGXcZoN2l6
	 DKhbfbStSO+cD5NKszu8/ehpqj8UvGa7d4uhfi/uUrf5zjFxqeJ64AqQmkzv57LNLEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TWblsBES;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.37
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010037.outbound.protection.outlook.com [52.101.193.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD98C606A326
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 04:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD98C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TWblsBES
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCGOuqn6fbGdhSz4jlIAsj3/hs0q+10t1qwXMlnqXMeOBKg4BDfz5ysnXpU4Edow5MGDZZFIp8QIWDL68cxqJwNOm1/JNL/nNcgat7zp6ogDePmK0zEiw//DBjnijUsSK20Ev06EIzDD/rbvtHK13rm65GBjQ75aLeuON5DT+QoCef+gHqU3+LLp0WOllHP3CKM4Uh8MVzvBESC0Kvn/4WKYysTBAiqexVbIJHbHyiHGP8KTrqgfq+4SS/fTxLb4Wn2tzt+QWzesEtunfAxrVdCse1sK/r0l/zNkLEOvocEbRxjZ97M1Q7fAiPKDcxfZNHKcoU5SJLoxohzx6JynxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3QY/2ANHtc4CyhbWrL6c53DplsZ8DBJ/FY4exSFt54=;
 b=Kab+tuT3NXQiIyd3T9LRDFTv8mNqZVyPCd/PaG2TsYii9fNHqOcrCLESA7iROAh3V/wr8yloDWDcnGP42GfVcXx04Ic63RF+gASBwNjnF4xzhjzjJMPN1u4tj8xrrzA4PnsQPH690Oi2kLrZOrx91KY1XvKy+0GhfrMyHPPPL/RC+UPBV7CtHr3rqnR5bAuu7Qmf06E4p6AvAjUM048d/EqBzVrAtx1V10eHVOZNBWCJsuFU4gaNUyt1GXLGnyRbyexoZYBYxh9EdA0UARn+danO7zfuamQSxcD5aZ0beAJHWXwQG9MmFredj3NKJzDLtly44m+MmAkuKVdw8WQh8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3QY/2ANHtc4CyhbWrL6c53DplsZ8DBJ/FY4exSFt54=;
 b=TWblsBES/J4Rzz9hOby7MUxuA49+nRgqhJ9RmDxuKWUb9MtUiESQKRfuPLnTL4MOvFkkf510DUwtE4MvY683ofJ9fgHYT7SZ3EekLrIkooMXoK9tiRn4MciPIcElFF+HxBNXX5Lf5tBbNH8Xe7LRYO6FE+8Fyva8EkKivHO7930ucgfumgpXHGNINmxYWcOASWTgw/idnrjJmTQlp5eD3kcyxcd6848FKtU2xGm4qyii6WwrBe/6VFC59r+J6hEf3GKpVCl+/YFCRVSRJD/pyicGvaUmHiknwTfGukaGxaXfEuxTf03oVOifAnOGZTbjMXZDNfdEr9RbP5WlDDONyg==
Received: from BY3PR04CA0016.namprd04.prod.outlook.com (2603:10b6:a03:217::21)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:01:00 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::87) by BY3PR04CA0016.outlook.office365.com
 (2603:10b6:a03:217::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 04:01:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:01:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:39 -0800
Received: from cxlgalaxy.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:33 -0800
From: <mhonap@nvidia.com>
To: <jic23@kernel.org>, <alwilliamson@nvidia.com>, <clg@redhat.com>,
	<xueshuai@linux.alibaba.com>, <ira.weiny@intel.com>, <zhiw@nvidia.com>,
	<mst@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<junjie.cao@linux.dev>, <anisa.su@samsung.com>, <pbonzini@redhat.com>,
	<ankita@nvidia.com>, <vsethi@nvidia.com>, <skolothumtho@nvidia.com>,
	<mochs@nvidia.com>
CC: <cjia@nvidia.com>, <mhonap@nvidia.com>, <kjaju@nvidia.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: [RFC 12/18] hw/pci-bridge: Add firmware HDM decoder state to pxb-cxl
Date: Fri, 6 Nov 2026 09:29:05 +0530
Message-ID: <20261106035911.1280066-13-mhonap@nvidia.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a0c226-8896-483b-9bd0-08df3bba91ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|7416014|1800799024|18002099003|22082099003|10067099003|921020|11063799006|261102123227099003|261026140227099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	VK4zDLGq2SPIgowMGqe5R9wSECJL4J28uiTRq5DHmZ99HGap1MdPYs+4OM64GdVasfZba4yQFoG4dB333e1rm4P9PkzjcUa0EFYJ1fX/tsQXhRpQ/zCp2fhMjzcDd24kG/Jw4I3kEGcHtvbyqJmhkppzg1ndyf92VzM3Uelhfdd3jj13jPZmu7aDThl+6hkH+wRymvKfmSOBENFyKsHFmBJCq76zClxjL8kOkzLEIOAEs53ETUXUlivtv0/2ryqhpSPc17ShQ4gR5PIYgdJiQPBlib/6uEbUfPABfOJJoi5u9s8CpICm1n00vHF99pV3HwktV5eOvwM23mVUTWSafNmJ526Fc562CxDCfjwkhs7BNO1OZwsllTAnaM8bKUeyijOkEZWpJTnawa0KSm+J4Sl/BCmBqINTuQlS2hFqtobnQKpTHrjbmZEfkNxzrwsxUE8Khdy2QXy50MunUJdYiQfFmzUiJBGOomez1RWgv55houCpqXueLUIJ+L5c1QcIcX5guvKdVxK8VAOoW4xcvzyY5lKP7ZhNmLAVeIIwrqhdu9tXlK1erHdjFZKL33dGFe2nsDqrkWXRoo2LxtRgmyZaK04G5stMDNyvnHyvZmjDEbRE4YBXY1El4fhj34RX4D57u18ufaH1+ahymPdBw2hRdT+v+SddySlHt5ZTrFceAMsTkxVHdlyoRsdRBl5fn2PxmuFRNNPmZhIDdy27HlFpijlc5M/Ww+mI1o17kXlCiSW9DTI2dwMt7+AM7+yD
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(7416014)(1800799024)(18002099003)(22082099003)(10067099003)(921020)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6umPq8UbsvmULVB7ksAUS9iSmUzPxpikK3qeJ+FoM0lmtW4qfpcpVf8PAxrnzMD5RZZIrkJ+5JKE9FwyJar6KOBEEEmhN/DrmiqbH4pnYYDo+9VCniy/b5+AZSYUOj4D09nUUoZYZhSTRt0TPjuYWny7oo9kQQjjw3wo5AYwf+sJiakE7dEkfcL1IZaxIr0qzzez8qYKzoRImN/ez/6MtCoaz8sIhkBJf39jIKYut5H1SXNvtFirVZKo+JFJ0SBcrfWyscy+y+Vj22ZWAO6nx7HdA6vtmaI7TVPuHEpF9rXW7p3reuJaxNJnTxPb2bg9cjS5ryWxGjsWHM0GnaNK7cKDLWUiv5elvViLAEs8BzM99oTSH+UEJJv6XlkpzVzAhLG1+fQturCUpmpShV6uZlzCaGWGzy9UrRbXA9haCeB4odZaXIs0xtBAflhaQTts
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:01:00.2803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a0c226-8896-483b-9bd0-08df3bba91ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826

From: Manish Honap <mhonap@nvidia.com>

QEMU has no firmware that commits the HDM decoders of a CXL route at
boot, so a guest finds no committed region.

Let a cold-plugged device register one range with its pxb-cxl, which
then commits HDM decoder 0 for it at every reset. A host bridge with a
registered range keeps its decoder instead of passing accesses through.
If the device resets first, pxb-cxl retries the direct mapping after
the commit.

The CXL Type-2 device registers a range later in this series.

AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/cxl/cxl-component-utils.c            | 47 +++++++++++++++++++++++++
 hw/pci-bridge/pci_expander_bridge_cxl.c | 22 ++++++++++--
 include/hw/cxl/cxl_component.h          | 13 +++++++
 include/hw/pci/pci_bridge.h             |  5 +++
 4 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index f9bb1684fa..c61966b202 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/pci/pci.h"
 #include "hw/cxl/cxl.h"
@@ -500,6 +501,52 @@ void cxl_component_register_init_common(uint32_t *reg_state,
                                       CXL_HDM_DECODER_COUNT);
 }
 
+/* One range per host bridge; registering the same range again succeeds */
+bool cxl_firmware_hdm_set(CXLFirmwareHDM *fw, const char *owner,
+                          uint64_t base, uint64_t size, uint8_t target,
+                          Error **errp)
+{
+    if (!size || !QEMU_IS_ALIGNED(base, 256 * MiB) ||
+        !QEMU_IS_ALIGNED(size, 256 * MiB)) {
+        error_setg(errp, "firmware HDM range must be 256 MiB aligned");
+        return false;
+    }
+
+    if (fw->valid) {
+        if (fw->base == base && fw->size == size && fw->target == target) {
+            return true;
+        }
+        error_setg(errp, "%s supports one firmware HDM range", owner);
+        return false;
+    }
+
+    *fw = (CXLFirmwareHDM) {
+        .valid = true,
+        .base = base,
+        .size = size,
+        .target = target,
+    };
+    return true;
+}
+
+/*
+ * The caller sets HDM Decoder Enable where it applies. It reads as 0 on host
+ * bridges (CXL r4.0 Section 8.2.4.20.2).
+ */
+void cxl_firmware_hdm_program(const CXLFirmwareHDM *fw, uint32_t *cache_mem)
+{
+    uint32_t ctrl = 0;
+
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO, fw->base & 0xf0000000);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI, fw->base >> 32);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO, fw->size & 0xf0000000);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI, fw->size >> 32);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_TARGET_LIST_LO, fw->target);
+    ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMIT, 1);
+    ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL, ctrl);
+}
+
 /*
  * Helper to creates a DVSEC header for a CXL entity. The caller is responsible
  * for tracking the valid offset.
diff --git a/hw/pci-bridge/pci_expander_bridge_cxl.c b/hw/pci-bridge/pci_expander_bridge_cxl.c
index ceb8928f8f..01fd479a9e 100644
--- a/hw/pci-bridge/pci_expander_bridge_cxl.c
+++ b/hw/pci-bridge/pci_expander_bridge_cxl.c
@@ -111,9 +111,18 @@ static const TypeInfo cxl_host_info = {
     .class_init    = pxb_cxl_host_class_init,
 };
 
+bool pxb_cxl_register_firmware_hdm(PXBCXLDev *pxb, uint64_t base,
+                                   uint64_t size, uint8_t target,
+                                   Error **errp)
+{
+    return cxl_firmware_hdm_set(&pxb->firmware_hdm, "pxb-cxl", base, size,
+                                target, errp);
+}
+
 static void pxb_cxl_dev_reset(DeviceState *dev)
 {
-    CXLHost *cxl = PXB_CXL_DEV(dev)->cxl_host_bridge;
+    PXBCXLDev *pxb = PXB_CXL_DEV(dev);
+    CXLHost *cxl = pxb->cxl_host_bridge;
     CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
     PCIHostState *hb = PCI_HOST_BRIDGE(cxl);
     uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
@@ -121,11 +130,12 @@ static void pxb_cxl_dev_reset(DeviceState *dev)
     int dsp_count = 0;
 
     cxl_component_register_init_common(reg_state, write_msk, CXL2_RC, false);
+    cxl->passthrough = false;
     /*
      * The CXL specification allows for host bridges with no HDM decoders
      * if they only have a single root port.
      */
-    if (!PXB_CXL_DEV(dev)->hdm_for_passthrough) {
+    if (!pxb->hdm_for_passthrough && !pxb->firmware_hdm.valid) {
         dsp_count = pcie_count_ds_ports(hb->bus);
     }
     /* Initial reset will have 0 dsp so wait until > 0 */
@@ -136,6 +146,14 @@ static void pxb_cxl_dev_reset(DeviceState *dev)
     } else {
         ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT,
                          8);
+        if (pxb->firmware_hdm.valid) {
+            cxl_firmware_hdm_program(&pxb->firmware_hdm, reg_state);
+            /*
+             * An endpoint that committed before this reset could not map
+             * its memory directly, as this decoder was not committed yet.
+             */
+            cfmws_update_non_interleaved(true);
+        }
     }
 }
 
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index b38e81d129..eb71f1c80a 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -328,6 +328,19 @@ void cxl_component_create_dvsec(CXLComponentState *cxl_cstate,
 void cxl_component_update_dvsec(CXLComponentState *cxl, uint16_t length,
                                 uint16_t type, uint8_t *body);
 
+/* The range that firmware routes through HDM decoder 0 to one port */
+typedef struct CXLFirmwareHDM {
+    bool valid;
+    uint64_t base;
+    uint64_t size;
+    uint8_t target;
+} CXLFirmwareHDM;
+
+bool cxl_firmware_hdm_set(CXLFirmwareHDM *fw, const char *owner,
+                          uint64_t base, uint64_t size, uint8_t target,
+                          Error **errp);
+void cxl_firmware_hdm_program(const CXLFirmwareHDM *fw, uint32_t *cache_mem);
+
 int cxl_decoder_count_enc(int count);
 int cxl_decoder_count_dec(int enc_cnt);
 
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index f114f0a651..d0227a4c38 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -117,11 +117,16 @@ typedef struct PXBCXLDev {
 
     bool hdm_for_passthrough;
     CXLHost *cxl_host_bridge; /* Pointer to a CXLHost */
+    CXLFirmwareHDM firmware_hdm;
 } PXBCXLDev;
 
 #define TYPE_PXB_CXL_DEV "pxb-cxl"
 OBJECT_DECLARE_SIMPLE_TYPE(PXBCXLDev, PXB_CXL_DEV)
 
+bool pxb_cxl_register_firmware_hdm(PXBCXLDev *pxb, uint64_t base,
+                                   uint64_t size, uint8_t target,
+                                   Error **errp);
+
 int pci_bridge_ssvid_init(PCIDevice *dev, uint8_t offset,
                           uint16_t svid, uint16_t ssid,
                           Error **errp);
-- 
2.53.0

