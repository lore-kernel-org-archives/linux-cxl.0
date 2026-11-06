Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793937689;
	b=psfIjTBZuUPIkqilrKk9Yawvx89HwQGj8MWmiNB8LCRgxPLMkiUnsmYLn8Ll58cJUaGq
	 fg+s43ZGp5EeABZbNNffbk+qQ6u/Km26dGEOASQN48Ah8eThmTcZVVerlX61pCk/FbSQJ
	 dcCFA7G1pna64IQv6K3x0ZA1WV1rOgvYkwG4EmwEe4fGA7b4A3smhWGA9w5dW13aKQwnI
	 WuwBQfOoxxXIwtvmMEaAodmBdDa2g4wZ61826jvuhfpEg4R+Z6wR5wDIFUVgoJ/AGRNhI
	 E4R6azm2I28do/grVIO5WXvSZd+/kCSvrNemr6PCLi04bc7Z+i/57O4t0FM3j1t45aw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937689;
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
	bh=TpHEsPUdhmOc7L/2L2dySMBBNt35VHwSUbiPPvu0Sgo=;
	b=Jcn8SWgVkpCx+jkyOXHzlJEEwZXm0MssLgO+Yc6DWfxkctrXyt+21LDwMoBD3fGRu1DC
	 0dA/3N8XCS3E0+DzBSzT94jm0ZGcVwF6MvpwExKbM/nEW+Ap7VCtlXehwMooluZnLXwO7
	 mlYiD9vYONbuxmuusu7Rn4U7PGOKZURoSTBcGvNnsSiLvWXkVQcYhBlPLiuUyY3EOSynB
	 YKvY8BB7NDXecrH/pYej9RMhI2Jro0foAMb++s2J+gBBXkTfbntc3u+TGyjamUrSqHVaO
	 uNr/h8AzAPNMiELhdhtp/0KorBsygicXBJPSjJTSjf7WZxzRUQtfsg8WWrjb9xcinxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CSk2yWty;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.62
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013062.outbound.protection.outlook.com [40.107.201.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE1606A326
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 04:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15EE1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CSk2yWty
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReMnPO8SrVDjSk8iHl9ea1I6QEpN943sjiukxViKLZiqRvAGbJ3pY7/yX1Vj1W+TGo0r5PmI1s1Mrvg7B/LU+Lb78I3WExgbwzDCdDKBYQkaB3FpHCgwY6MiPv4kdnokIsc0YQIO6tXlnYT/8esD+n0E/TR7xiOweCkhTMJ7z+L2Ul37uTngU1yhimq8W1dAk8hil7F3Dhlpy0JXUXh9nlTmNrI8eff2yeVXL41K6XQEhdj2zXU+lp+hzgiuFzx/6zP5C1jShVtInjtBSOMPloGG98UkkLwjSZoHqBX48+9Gt3Kga9ZxxDbPBK9IRjgHlAJbEYd1X0rO4pJVcDOceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpHEsPUdhmOc7L/2L2dySMBBNt35VHwSUbiPPvu0Sgo=;
 b=uANsDaG3cCwXMSqaGSqj7smkR42Jfdrsy3FK1Iidd9NyHTGAw/68CBzNOyYn7i99GtgV9HGPME6DJnTj/15ocnyyJxwYGb7LoJ4pXrRLApWtzLc0oxkoXD8MwMHn830k7kNKHCsXz4hwa1Wfa69AzkLXxaZYUFIqF+dJ2Lye7KYXX/UeeEI2K4QufBDUVJ30Uu2v+HncieLdyqOGYKVF5DhLEfEzugvie4F7PbT8pTcYfwtCiFxVz+3AF9qrzXJHKYzeQB4t7e1Jl44x9jk5Jo2gZSKm7vSq6JItkTfqXRkKkGTvA44k3etL6739bjjhLGqW9pZYy0iRIHuJ0UqR7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpHEsPUdhmOc7L/2L2dySMBBNt35VHwSUbiPPvu0Sgo=;
 b=CSk2yWtySFMRP3zzmV2co9sof+5UYXM0pBGMDgF+HOUi7UqiYtia3XFYQn7iVRPF4Cg0jT/IrMD7Ym+iDK5OeYZO1j2A5oN+waXUK3GVSjnvF6JyBIFvr6g2nvKQVlqJwWEJvpftdsuf1l/TIGxwn5nV5pXQ7G/G+jZPi9VAqCTA5oiSjfPmjtnhPL61AD3vuBLQoOMUlP0YXbsZzf3/2tww0kYYnmpDvZF4QHszsq73YFyEMr1b989v0aEglpuBw4nIS7pR1EHWhPhULvm8P0LzgkpUFX85EL/csF86W4Htaw2gGfFZz3bWlEchX1Lhzv/rejmw67laIoy+oV9OuA==
Received: from SJ0PR13CA0211.namprd13.prod.outlook.com (2603:10b6:a03:2c1::6)
 by SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:01:22 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::51) by SJ0PR13CA0211.outlook.office365.com
 (2603:10b6:a03:2c1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Fri, 6
 Nov 2026 04:01:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:01:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:01:07 -0800
Received: from cxlgalaxy.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:01:01 -0800
From: <mhonap@nvidia.com>
To: <jic23@kernel.org>, <alwilliamson@nvidia.com>, <clg@redhat.com>,
	<xueshuai@linux.alibaba.com>, <ira.weiny@intel.com>, <zhiw@nvidia.com>,
	<mst@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<junjie.cao@linux.dev>, <anisa.su@samsung.com>, <pbonzini@redhat.com>,
	<ankita@nvidia.com>, <vsethi@nvidia.com>, <skolothumtho@nvidia.com>,
	<mochs@nvidia.com>
CC: <cjia@nvidia.com>, <mhonap@nvidia.com>, <kjaju@nvidia.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: [RFC 17/18] hw/mem: Clear the cxl-type2 volatile memory on a CXL Reset request
Date: Fri, 6 Nov 2026 09:29:10 +0530
Message-ID: <20261106035911.1280066-18-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|SN7PR12MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 589bee07-fd34-4828-31d4-08df3bba9eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|23010399003|1800799024|18002099003|22082099003|10067099003|921020|5023799004|261026140227099003|261026121527099003|11063799006|261102123227099003|261026135527099003|261026130827099003|261028144727099003|261021123027099003|261022115727099003|261021133027099003|261021135927099003|261022113327099003|56012099006|261021130227099003|261022105027099003|261021121427099003|261009223027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	vxDpZL83SwJ90zcjzH5r0bmM9ja//1yT+m5XnbpdzvPzBOY640hVjPzlnMe6tsSBep1RwY9bofAa7SH8YziiRLRc3+idTAt6xCFVR2NtCsK8ZMp+N9IQ3cxolVHF/F1juvwkkU/BrA/iBzo18k8jv/Fxg/DV5lSjG5eLz9N/8XhPcBN9A4ivnGat5Shi7YLlor1zjJhedIiL/CLgqfI7dd5UNQSnIwnspZrffdk8rziplanchKdrGyLupGpZZMJ5S5Ce/ukvobrjsUvnTgisbUf+d1d2LR/v+hg55gGQPo9bIzBh4xaJFPQfFJfPNsy7KkSe5SsPN9PY/8t5pQv/GNJpIOuOsSUdkY6oJJ2M/Iea35xrE/8IWZRZmN7mXhB5fMW2v3BSQMgTvDTpcuCDt5N7jA2pfT2EkCWUoZc9sAK4lqErb2o3pqs6abclQURBJbC+hEJyFm/2FIVwcs20SoxaFf1zmauHiTv36iPcyZ2X8rnAZguZ+/lr8azoH+vK4vccxfl6v3uqKjqNgdTNAiKM3Bw0FK7l/zHYD/0p/5L7W4mME4GioV7THlTUEB9AGY+FUYfRHgoRcSN3TB9lwEH1qrgoSBvqJpUlnmvA9+cCTGWo3cdLFW9BzbHDBEJoSozSLLOYkwG5ty8KC4Ujv7fJsjzyMRyJX42s32VGrMJrpDdZLRlC+LBoFRzCXLto2mAVVqK9RLOvvGqYeS2J/CBofX5TNv8Y49cscKrSHBSsSg6jK7AG6rk4NCx0pf+c
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(921020)(5023799004)(261026140227099003)(261026121527099003)(11063799006)(261102123227099003)(261026135527099003)(261026130827099003)(261028144727099003)(261021123027099003)(261022115727099003)(261021133027099003)(261021135927099003)(261022113327099003)(56012099006)(261021130227099003)(261022105027099003)(261021121427099003)(261009223027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BcZc1SR2xn/u8XRqs9y1tKeLma5ylhZM4UhEy8emKX4EamOtjcFF877xyOmAjmwRa1T3NtapW+EPGB7yFBdXtYmsXnQbEZT24/qclEaMrEUoe61GhBSvqT0C7mXt8DPkcrlo5R7k2ZxJD8HQWlPM5yFfVD420iutvBQpSGhHWjyzXQ13/aZrM/chjPFObQI3UiPEIUPufAsFb0VeZAEqMIpj4tRQE8c0sLMT5TWNIykBRAhYANeljFcu6jeUpJzfuHsY78IOiQZHApo2d71COSo5Nfx+iOb91sZAj/tRqlFa1XST09zMhEy9IZfs59wiiAPiHMj5gvh69upF5Mq9ynbWw+Gz0djTUtkxgqSuAM4GmSyMSIFLy6W+YbixizeNEslLujLSoxO50Sdx7jxzgo4r4XfMwkEOwherGk+3KJIvD7CUzRTr54QfJLBDy8EV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:01:22.1692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 589bee07-fd34-4828-31d4-08df3bba9eac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7833

From: Manish Honap <mhonap@nvidia.com>

Report CXL Reset Mem Clr Capable and zero the volatile backend when
Initiate CXL Reset is set with CXL Reset Mem Clr Enable (CXL r4.0
Section 9.7). A failed clear ends the reset with CXL Reset Error.

AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/mem/cxl_type2.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/hw/mem/cxl_type2.c b/hw/mem/cxl_type2.c
index 137758cfd9..2183b0c326 100644
--- a/hw/mem/cxl_type2.c
+++ b/hw/mem/cxl_type2.c
@@ -18,6 +18,7 @@
 #include "hw/pci/pcie_port.h"
 #include "migration/vmstate.h"
 #include "system/hostmem.h"
+#include "system/ramblock.h"
 
 static void clean_memory(PCIDevice *pci_dev)
 {
@@ -215,7 +216,7 @@ static void update_dvsecs(CXLType2Dev *ct2d)
         .cap = CXL_DVSEC_CAP_CACHE | CXL_DVSEC_CAP_IO | CXL_DVSEC_CAP_MEM |
                CXL_DVSEC_CAP_MEM_HWINIT |
                1 << CXL_DVSEC_CAP_HDM_COUNT_SHIFT | CXL_DVSEC_CAP_CACHE_WBI |
-               CXL_DVSEC_CAP_RST,
+               CXL_DVSEC_CAP_RST | CXL_DVSEC_CAP_RST_MEM_CLR,
         .ctrl = CXL_DVSEC_CTRL_IO_EN,
         .range1_size_hi = size >> 32,
         .range1_size_lo = (2 << 5) | (2 << 2) | 0x3 | (size & 0xF0000000),
@@ -260,7 +261,8 @@ static void build_dvsecs(CXLType2Dev *ct2d)
                  cxl_type2_dvsec(ct2d, offsetof(CXLDVSECDevice, ctrl2)),
                  CXL_DVSEC_CTRL2_DISABLE_CACHING |
                  CXL_DVSEC_CTRL2_INIT_CACHE_WBI |
-                 CXL_DVSEC_CTRL2_INIT_CXL_RST);
+                 CXL_DVSEC_CTRL2_INIT_CXL_RST |
+                 CXL_DVSEC_CTRL2_RST_MEM_CLR_EN);
 
     memcpy(ct2d->dvsec_wmask, PCI_DEVICE(ct2d)->wmask +
            range_lob(&cxl_cstate->dvsecs[PCIE_CXL_DEVICE_DVSEC]),
@@ -293,12 +295,31 @@ static void cxl_type2_update_status2(CXLType2Dev *ct2d, uint16_t clear,
     pci_set_word(reg, (pci_get_word(reg) & ~clear) | set);
 }
 
+/*
+ * A discard would change the file behind a private file mapping and undo
+ * the preallocation of a prealloc backend, so those get zeros written.
+ */
+static bool cxl_type2_clear_memory(CXLType2Dev *ct2d)
+{
+    MemoryRegion *vmr = host_memory_backend_get_memory(ct2d->hostvmem);
+    RAMBlock *rb = vmr->ram_block;
+    uint64_t size = memory_region_size(vmr);
+
+    if (rb && !ct2d->hostvmem->prealloc && !ram_block_discard_is_disabled() &&
+        (qemu_ram_get_fd(rb) < 0 || qemu_ram_is_shared(rb)) &&
+        !ram_block_discard_range(rb, 0, size)) {
+        return true;
+    }
+    return address_space_set(&ct2d->hostvmem_as, 0, 0, size,
+                             MEMTXATTRS_UNSPECIFIED) == MEMTX_OK;
+}
+
 /*
  * CXL r4.0 Section 9.7. Fields locked by CONFIG_LOCK or Lock On Commit keep
  * their values. The CXL.io part of the reset, which has the scope of an FLR,
  * is not emulated.
  */
-static void cxl_type2_cxl_reset(CXLType2Dev *ct2d)
+static void cxl_type2_cxl_reset(CXLType2Dev *ct2d, uint16_t ctrl2)
 {
     static const size_t range_bases[] = {
         offsetof(CXLDVSECDevice, range1_base_hi),
@@ -309,6 +330,7 @@ static void cxl_type2_cxl_reset(CXLType2Dev *ct2d)
     uint8_t *config = PCI_DEVICE(ct2d)->config;
     uint32_t *cache_mem = ct2d->cxl_cstate.crb.cache_mem_registers;
     uint16_t lock = cxl_type2_dvsec(ct2d, offsetof(CXLDVSECDevice, lock));
+    bool cleared = true;
 
     cxl_type2_update_status2(ct2d, CXL_DVSEC_STATUS2_RST_DONE |
                              CXL_DVSEC_STATUS2_RST_ERR, 0);
@@ -328,8 +350,12 @@ static void cxl_type2_cxl_reset(CXLType2Dev *ct2d)
 
     cxl_type2_update_mem_active(ct2d);
 
+    if (ctrl2 & CXL_DVSEC_CTRL2_RST_MEM_CLR_EN) {
+        cleared = cxl_type2_clear_memory(ct2d);
+    }
     cxl_type2_update_status2(ct2d, CXL_DVSEC_STATUS2_CACHE_INV,
-                             CXL_DVSEC_STATUS2_RST_DONE);
+                             cleared ? CXL_DVSEC_STATUS2_RST_DONE :
+                             CXL_DVSEC_STATUS2_RST_ERR);
 }
 
 /*
@@ -355,7 +381,7 @@ static void cxl_type2_ctrl2_write(CXLType2Dev *ct2d)
     }
     /* Initiate CXL Reset reads as 0; the reset clears all of Control2 */
     if (ctrl2 & CXL_DVSEC_CTRL2_INIT_CXL_RST) {
-        cxl_type2_cxl_reset(ct2d);
+        cxl_type2_cxl_reset(ct2d, ctrl2);
     }
 }
 
-- 
2.53.0

