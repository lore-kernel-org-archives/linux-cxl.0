Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793937685;
	b=GnY/93lKHFLi15yeCGT1qLzvJikdeuzn0NjP02dGdPsPd0Vf1yobQvoGDJzJ+vgPMO/P
	 GW1Z3uttkBU1WdEQFoDG3Mj4JQTohRIEW2wbc8z7uUJoPllYX19uRWGerCdZwphsfXs9i
	 dUkAym1zaCle8OTnqj+v3s/3w0uvtSFBGTU8gUytIlPZcGReP8G24cPSPkG71b2fOUT0i
	 KgMAKH1DI56RoX+aOoUAOJzwX8f6S9vKi/tBn1akG/NmfJHM4Vvnyf/4n4qmtRDE7xLNx
	 e/15k6qpvnamD9PikPCjRlGL4KjTLmOrGsnBbk+yI9OmSuBavb25HgUipuoEt+aw0hg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937685;
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
	bh=aGTerJxbx4tv1G0mC3gGh1WYjaQhPLd5AWcAinalrVA=;
	b=yuMhU4Zydrh0RzDPUi/jnrgRTY8gmGnWPs8I0l55aSw3aOSAfYnckm8pG8Dwu6O1pdx4
	 PbeyYHecrwbNZHcZnEWI0dO3RosKCH6qWKD5DrMN6x9P9w66yh0BNm30fjY7JNPgKuKm2
	 aqjmEjwWBaa7zgv6RhiV7HBqQGLo9g4b7tp+iOm6nMrXKj3fMh6IkF9hU4tOrQhHn/HJ4
	 DW7x+wMyUEkrdNJdzVieo0C21/39fyq5L3oJsaeNSUlD26QyjTunhsaHlm8duTYjnyXkT
	 Qk2fprYvGsCFLRLm9GzmC00sQnY6G/aSQfITohBOBMeztB3FXOWrc+9cg9BUbv06byg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cOjXkl0T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.29
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140D4606A328
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 04:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 140D4606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cOjXkl0T
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piqmr5j/c3tpzArpRPYR6bG7lY1dWEuoWtOMyuYDWSyumiS24uDjR+pudoJDcxn6Wm5DOtTipn0QcAtT2k6/csfWMxrQiYCMQKOjP2JZwSh5bu3BYmdF05eUYnB9jvA385tM6I/C6UqR5d2MEg7iwyJ5RYz7QBPwXgr3JJQ3hdQk1+H5WoFt9J1uKpaGv+S0g2HeVaylVAvkt2QMmuCYQve8+J0bBsG+QeasdAC9yTMEUiZWbmZwKIGPmKybWfAgh7I1Ptt8aupoPI04JzdeHdyEIya2mjdMj2HiT3z4Ruva29Y8PEOYP7XR6kZrQhJaAoCfSGssFaV+lJC/9icQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGTerJxbx4tv1G0mC3gGh1WYjaQhPLd5AWcAinalrVA=;
 b=eIIg9R9mnuks1i+gwklzm0iE6dhCEf+1VN4s18Olu9vM4tdmqqlpTMmn5Sv/bd0/vRTr/6AhL7G0WCkSyekS+dPvtvc/590FSd97LXlkuZFxzBqQe0u4AarM8cCgq/2ju63qunRb1xA2bo51qWdeEK720PHpvLxRmsrp67H6FsDAcaacgOdJ2m2pvq/aEcAw1c6KA3zbMQlX+IMZqhyOcUosoFG7+hOnI0M/u9OUnbAVhHLTlqlsF568wRVpPlJVdOT7m+KCFi7QahddlJISb+lrbt/ifbYqKfKrsVJTcfR4S06e7+pm9BjEIa3RMt2pxl3dET3kqOjQc2z6pF+EaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGTerJxbx4tv1G0mC3gGh1WYjaQhPLd5AWcAinalrVA=;
 b=cOjXkl0TDBmvjqbt1d8D7CkOZHf1k4eMQo/8LkWJPxYh6vCMhLssidTeNmNQ/02+uYCDuE0zPxivOE2iemI2UOFDUMh9Va57SHAXNTCAO9WSH/Ig9CM3Ns3M+J9aPSvbTFR5pNh0WmSwLM6Z9OvA7UmuCJmGjMr+8mUPWsaMVD8EtNfOVz/uwNxENIdCKh2W8ao9jXISHLQ4LNM4ZM2EkkaotyLCnp9qVJU4HcS2tdXXU17Pd/ooqx0Xn8h6R45AUEZptuoe9uCliJhr0QgXPdr6dgeRYcv/P/2ugVe3o5rjqLgnCii57Dm7zYeHTyoprLWbCY8TJ2QWgkgxYQabdg==
Received: from PH7P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::27)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 04:01:18 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:510:338:cafe::99) by PH7P223CA0006.outlook.office365.com
 (2603:10b6:510:338::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 04:01:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:01:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:01:01 -0800
Received: from cxlgalaxy.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:55 -0800
From: <mhonap@nvidia.com>
To: <jic23@kernel.org>, <alwilliamson@nvidia.com>, <clg@redhat.com>,
	<xueshuai@linux.alibaba.com>, <ira.weiny@intel.com>, <zhiw@nvidia.com>,
	<mst@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<junjie.cao@linux.dev>, <anisa.su@samsung.com>, <pbonzini@redhat.com>,
	<ankita@nvidia.com>, <vsethi@nvidia.com>, <skolothumtho@nvidia.com>,
	<mochs@nvidia.com>
CC: <cjia@nvidia.com>, <mhonap@nvidia.com>, <kjaju@nvidia.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: [RFC 16/18] hw/mem: Implement CXL Reset for cxl-type2
Date: Fri, 6 Nov 2026 09:29:09 +0530
Message-ID: <20261106035911.1280066-17-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: cd59aae4-964d-4c9c-6437-08df3bba9b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|36860700016|82310400026|921020|261026135527099003|261026140227099003|261021133027099003|261021130227099003|261021135927099003|11063799006|5023799004|261022105027099003|261009223027099003|261022115727099003|261026121527099003|261021121427099003|261026130827099003|56012099006|261021123027099003|261028144727099003|261022075727099003|261022113327099003|10067099003|18002099003|261102123227099003|22082099003|261102130727099003;
X-Microsoft-Antispam-Message-Info:
	304uWsb7hbV3vN/OnyQG91+QNHKL/sZW92zZcpILmq3Y1Fmqca0xNaO3Mq8GaO5UQT1gj3lw1vWhXRWoeujbRJTCFaR6bFGMhxCYzBhPuNEEhyDUkQDUC5nQSxU/Cuf/AsnT30rnBZwkDd0eov8dZG4CtmFXbUJZZkfVHpTsWKLY2FXTy9GTLU+WdzO+r9tBKF0tUrU6BPIe8MFV7Vxhr9QPTJ3jAFNHLLZWvUi0CuGmVJb/KdcVmf3aaUxONoqRGHqhdo2a4mmUBq84Y3hRPytLa4LePUcL40gzFmBPvwnulH3exN6MOEue4uc0wjzx/VI1vYJ6Xs/Z49Q8oERvAwIYLij/wCLO75ubOpXJiTZ9cJ7Sbrp/O8jIZhhb70nujcRMyxuZ9uSyZNVsfHltbhNv5cux/v0KekvAhLujwcR6v/BU7tEN6oc8ibnrd3m/vNuwoJu3YI0c6rGspb7aBNYIh80scn67gLX1mn0MfgbKdoxyUP5fnr7iy4lcRz449y8ueEeIlKZIg1NroGJJwCGlIYHxSFHHon+PcZES7th/zk2cvW7QBH2fd7mS+5dOvTSwDi9i/aBrhcQwKqsWJvs2Y5810ZG0O/bAquEVZsPMrff8QLwV6GfQNWnToRs8M/S2yRdk9N5kHsAszN98cg9aHKQQOPvZvCVwn4orCmpkSxZmqzBp3vbFC2zae/luT/OKaJwS8U8HYG9dtKgajtu63zKh+oopv3vEfaG9fuxlIq0v/OFxwIn/Lr59D4rK
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(921020)(261026135527099003)(261026140227099003)(261021133027099003)(261021130227099003)(261021135927099003)(11063799006)(5023799004)(261022105027099003)(261009223027099003)(261022115727099003)(261026121527099003)(261021121427099003)(261026130827099003)(56012099006)(261021123027099003)(261028144727099003)(261022075727099003)(261022113327099003)(10067099003)(18002099003)(261102123227099003)(22082099003)(261102130727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Qd7BDHVafgkxpdGoWaLscU7l9V8TFRCGMJyFwJifhRMFsWZp673iKOG5yGNq/Go/layN8eYZbrGeQzZ+3avPdicZte+eP6NmgMgZDRERvOQxe57dM9ZkL1kTPKbmq7DOCUFbIOQz8i3vFdfO58X8QUARVk7FXy+G8vqjmeJGWP8VGcFoCn4577lpP8PnQvBfzvmaWmAhG9b2Mrv7DQIckMBJTH/iU7pQ7RqxVqV8+4bmvdJu6v1mG7G9pg2/dRc1YGd8q8KGyzxcxaDjl1X2b5Rxp5he0EiSQpywuHfgn2x8sk0O2bl7OqcXwtPXYsNQTPBspukxqutYAsJk5iIb+E1Ox/iQVsINZWURajXsVmwe6VvGH2Anuu0mpE/4BzDNVenAnUgRc4VvtoEfgd9hf2+V6Fzzege4CJDFBgpYyWQBhR0VeKWEZMj7qOPCZAmt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:01:16.3419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd59aae4-964d-4c9c-6437-08df3bba9b34
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543

From: Manish Honap <mhonap@nvidia.com>

Report CXL Reset Capable and run a CXL Reset when Initiate CXL Reset is
set in DVSEC Control2 (CXL r4.0 Section 9.7).

- The locked decoder stays committed, as RWL fields are not affected by
  CXL Reset once locked (CXL r4.0 Table 8-1).
- Mem_Enable and HDM Decoder Enable return to 0, and while either is 0 the
  device drops CXL.mem. The direct mapping is disabled and accesses
  through the window fail until software sets both bits again, which it
  does when it re-initializes the device after the reset. The bits are
  also rechecked on every write to DVSEC Control and HDM Decoder Global
  Control.
- For Global control, default cache_mem write handling is exported as
  cxl_cache_mem_write_common() and called from a special_ops hook.

The CXL.io part of the reset, which has the scope of an FLR, is not
emulated. QEMU runs the whole device reset for an FLR, which would
repeat the firmware decoder setup.

AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/cxl/cxl-component-utils.c   |  25 +++++---
 hw/mem/cxl_type2.c             | 111 ++++++++++++++++++++++++++++++---
 include/hw/cxl/cxl_component.h |   2 +
 3 files changed, 120 insertions(+), 18 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index c61966b202..4886b26c7d 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -193,6 +193,21 @@ static void bi_handler(CXLComponentState *cxl_cstate, hwaddr offset,
     stl_le_p((uint8_t *)cache_mem + offset, value);
 }
 
+/* @value has the write mask applied */
+void cxl_cache_mem_write_common(CXLComponentState *cxl_cstate, hwaddr offset,
+                                uint32_t value)
+{
+    if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
+        offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
+        dumb_hdm_handler(cxl_cstate, offset, value);
+    } else if (offset == A_CXL_BI_RT_CTRL ||
+               offset == A_CXL_BI_DECODER_CTRL) {
+        bi_handler(cxl_cstate, offset, value);
+    } else {
+        cxl_cstate->crb.cache_mem_registers[offset / 4] = value;
+    }
+}
+
 static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
                                     unsigned size)
 {
@@ -213,15 +228,7 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
             return;
         }
 
-        if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
-            offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
-            dumb_hdm_handler(cxl_cstate, offset, value);
-        } else if (offset == A_CXL_BI_RT_CTRL ||
-                   offset == A_CXL_BI_DECODER_CTRL) {
-            bi_handler(cxl_cstate, offset, value);
-        } else {
-            cregs->cache_mem_registers[offset / 4] = value;
-        }
+        cxl_cache_mem_write_common(cxl_cstate, offset, value);
         return;
     }
     case 8:
diff --git a/hw/mem/cxl_type2.c b/hw/mem/cxl_type2.c
index 54d1b34a4c..137758cfd9 100644
--- a/hw/mem/cxl_type2.c
+++ b/hw/mem/cxl_type2.c
@@ -133,12 +133,45 @@ static bool setup_memory(PCIDevice *pci_dev, Error **errp)
     return true;
 }
 
+static uint16_t cxl_type2_dvsec(CXLType2Dev *ct2d, size_t reg)
+{
+    return range_lob(&ct2d->cxl_cstate.dvsecs[PCIE_CXL_DEVICE_DVSEC]) + reg;
+}
+
+/*
+ * CXL.mem needs Mem_Enable (CXL r4.0 Table 8-6) and HDM Decoder Enable
+ * (Table 8-118); the device does not decode through the DVSEC ranges.
+ */
+static bool cxl_type2_mem_active(CXLType2Dev *ct2d)
+{
+    uint16_t ctrl = pci_get_word(PCI_DEVICE(ct2d)->config +
+                                 cxl_type2_dvsec(ct2d, offsetof(CXLDVSECDevice,
+                                                                ctrl)));
+
+    return (ctrl & CXL_DVSEC_CTRL_MEM_EN) &&
+           ARRAY_FIELD_EX32(ct2d->cxl_cstate.crb.cache_mem_registers,
+                            CXL_HDM_DECODER_GLOBAL_CONTROL,
+                            HDM_DECODER_ENABLE);
+}
+
+static void cxl_type2_update_mem_active(CXLType2Dev *ct2d)
+{
+    bool active = cxl_type2_mem_active(ct2d);
+
+    for (int i = 0; i < CXL_HDM_DECODER_COUNT; i++) {
+        if (ct2d->direct_mr_fw[i]) {
+            memory_region_set_enabled(&ct2d->direct_mr[i], active);
+        }
+    }
+}
+
 static int cxl_type2_hpa_to_as_and_dpa(CXLType2Dev *ct2d, hwaddr host_addr,
                                        AddressSpace **as, uint64_t *dpa)
 {
     MemoryRegion *vmr = host_memory_backend_get_memory(ct2d->hostvmem);
 
-    if (!cxl_host_addr_to_dpa(&ct2d->cxl_cstate, host_addr, dpa) ||
+    if (!cxl_type2_mem_active(ct2d) ||
+        !cxl_host_addr_to_dpa(&ct2d->cxl_cstate, host_addr, dpa) ||
         *dpa >= memory_region_size(vmr)) {
         return -EINVAL;
     }
@@ -153,6 +186,7 @@ MemTxResult cxl_type2_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
     uint64_t dpa;
 
     if (cxl_type2_hpa_to_as_and_dpa(CXL_TYPE2(d), host_addr, &as, &dpa)) {
+        *data = 0;
         return MEMTX_ERROR;
     }
     return address_space_read(as, dpa, attrs, data, size);
@@ -170,11 +204,6 @@ MemTxResult cxl_type2_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     return address_space_write(as, dpa, attrs, &data, size);
 }
 
-static uint16_t cxl_type2_dvsec(CXLType2Dev *ct2d, size_t reg)
-{
-    return range_lob(&ct2d->cxl_cstate.dvsecs[PCIE_CXL_DEVICE_DVSEC]) + reg;
-}
-
 static void update_dvsecs(CXLType2Dev *ct2d)
 {
     CXLComponentState *cxl_cstate = &ct2d->cxl_cstate;
@@ -185,7 +214,8 @@ static void update_dvsecs(CXLType2Dev *ct2d)
     dvsec = (uint8_t *)&(CXLDVSECDevice){
         .cap = CXL_DVSEC_CAP_CACHE | CXL_DVSEC_CAP_IO | CXL_DVSEC_CAP_MEM |
                CXL_DVSEC_CAP_MEM_HWINIT |
-               1 << CXL_DVSEC_CAP_HDM_COUNT_SHIFT | CXL_DVSEC_CAP_CACHE_WBI,
+               1 << CXL_DVSEC_CAP_HDM_COUNT_SHIFT | CXL_DVSEC_CAP_CACHE_WBI |
+               CXL_DVSEC_CAP_RST,
         .ctrl = CXL_DVSEC_CTRL_IO_EN,
         .range1_size_hi = size >> 32,
         .range1_size_lo = (2 << 5) | (2 << 2) | 0x3 | (size & 0xF0000000),
@@ -226,11 +256,11 @@ static void build_dvsecs(CXLType2Dev *ct2d)
                                PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID, NULL);
     update_dvsecs(ct2d);
 
-    /* Disable Caching and Initiate Cache Write Back and Invalidation */
     pci_set_word(PCI_DEVICE(ct2d)->wmask +
                  cxl_type2_dvsec(ct2d, offsetof(CXLDVSECDevice, ctrl2)),
                  CXL_DVSEC_CTRL2_DISABLE_CACHING |
-                 CXL_DVSEC_CTRL2_INIT_CACHE_WBI);
+                 CXL_DVSEC_CTRL2_INIT_CACHE_WBI |
+                 CXL_DVSEC_CTRL2_INIT_CXL_RST);
 
     memcpy(ct2d->dvsec_wmask, PCI_DEVICE(ct2d)->wmask +
            range_lob(&cxl_cstate->dvsecs[PCIE_CXL_DEVICE_DVSEC]),
@@ -263,6 +293,45 @@ static void cxl_type2_update_status2(CXLType2Dev *ct2d, uint16_t clear,
     pci_set_word(reg, (pci_get_word(reg) & ~clear) | set);
 }
 
+/*
+ * CXL r4.0 Section 9.7. Fields locked by CONFIG_LOCK or Lock On Commit keep
+ * their values. The CXL.io part of the reset, which has the scope of an FLR,
+ * is not emulated.
+ */
+static void cxl_type2_cxl_reset(CXLType2Dev *ct2d)
+{
+    static const size_t range_bases[] = {
+        offsetof(CXLDVSECDevice, range1_base_hi),
+        offsetof(CXLDVSECDevice, range1_base_lo),
+        offsetof(CXLDVSECDevice, range2_base_hi),
+        offsetof(CXLDVSECDevice, range2_base_lo),
+    };
+    uint8_t *config = PCI_DEVICE(ct2d)->config;
+    uint32_t *cache_mem = ct2d->cxl_cstate.crb.cache_mem_registers;
+    uint16_t lock = cxl_type2_dvsec(ct2d, offsetof(CXLDVSECDevice, lock));
+
+    cxl_type2_update_status2(ct2d, CXL_DVSEC_STATUS2_RST_DONE |
+                             CXL_DVSEC_STATUS2_RST_ERR, 0);
+
+    cache_mem[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0;
+
+    if (!(pci_get_word(config + lock) & CXL_DVSEC_LOCK_CONFIG_LOCK)) {
+        pci_set_word(config + cxl_type2_dvsec(ct2d, offsetof(CXLDVSECDevice,
+                                                             ctrl)),
+                     CXL_DVSEC_CTRL_IO_EN);
+        for (int i = 0; i < ARRAY_SIZE(range_bases); i++) {
+            pci_set_long(config + cxl_type2_dvsec(ct2d, range_bases[i]), 0);
+        }
+    }
+    pci_set_word(config + cxl_type2_dvsec(ct2d, offsetof(CXLDVSECDevice,
+                                                         ctrl2)), 0);
+
+    cxl_type2_update_mem_active(ct2d);
+
+    cxl_type2_update_status2(ct2d, CXL_DVSEC_STATUS2_CACHE_INV,
+                             CXL_DVSEC_STATUS2_RST_DONE);
+}
+
 /*
  * CXL r4.0 Section 8.1.3.4: the device holds no modified cache lines, so a
  * write back and invalidate completes at once.
@@ -284,21 +353,41 @@ static void cxl_type2_ctrl2_write(CXLType2Dev *ct2d)
             cxl_type2_update_status2(ct2d, 0, CXL_DVSEC_STATUS2_CACHE_INV);
         }
     }
+    /* Initiate CXL Reset reads as 0; the reset clears all of Control2 */
+    if (ctrl2 & CXL_DVSEC_CTRL2_INIT_CXL_RST) {
+        cxl_type2_cxl_reset(ct2d);
+    }
 }
 
 static void cxl_type2_config_write(PCIDevice *pci_dev, uint32_t addr,
                                    uint32_t val, int len)
 {
     CXLType2Dev *ct2d = CXL_TYPE2(pci_dev);
+    uint16_t ctrl = cxl_type2_dvsec(ct2d, offsetof(CXLDVSECDevice, ctrl));
     uint16_t ctrl2 = cxl_type2_dvsec(ct2d, offsetof(CXLDVSECDevice, ctrl2));
 
     pci_default_write_config(pci_dev, addr, val, len);
     cxl_type2_dvsec_lock(ct2d);
+    if (ranges_overlap(addr, len, ctrl, sizeof(uint16_t))) {
+        cxl_type2_update_mem_active(ct2d);
+    }
     if (ranges_overlap(addr, len, ctrl2, sizeof(uint16_t))) {
         cxl_type2_ctrl2_write(ct2d);
     }
 }
 
+static void cxl_type2_reg_write(void *opaque, hwaddr offset, uint64_t value,
+                                unsigned size)
+{
+    CXLComponentState *cxl_cstate = opaque;
+
+    cxl_cache_mem_write_common(cxl_cstate, offset, value);
+    if (offset == A_CXL_HDM_DECODER_GLOBAL_CONTROL) {
+        cxl_type2_update_mem_active(container_of(cxl_cstate, CXLType2Dev,
+                                                 cxl_cstate));
+    }
+}
+
 static void setup_cxl_regs(PCIDevice *pci_dev)
 {
     CXLType2Dev *ct2d = CXL_TYPE2(pci_dev);
@@ -309,6 +398,8 @@ static void setup_cxl_regs(PCIDevice *pci_dev)
 
     build_dvsecs(ct2d);
 
+    cxl_cstate->crb.special_ops = g_new0(MemoryRegionOps, 1);
+    cxl_cstate->crb.special_ops->write = cxl_type2_reg_write;
     cxl_component_register_block_init(OBJECT(pci_dev), cxl_cstate,
                                       TYPE_CXL_TYPE2);
     pci_register_bar(pci_dev, CXL_COMPONENT_REG_BAR_IDX,
@@ -338,6 +429,7 @@ static void cxl_type2_realize(PCIDevice *pci_dev, Error **errp)
 
     if (!pxb_cxl_register_firmware_hdm(ct2d->pxb, ct2d->fmw->base, size,
                                        ct2d->root_port, errp)) {
+        g_free(ct2d->cxl_cstate.crb.special_ops);
         clean_memory(pci_dev);
     }
 }
@@ -348,6 +440,7 @@ static void cxl_type2_exit(PCIDevice *pci_dev)
 
     pxb_cxl_unregister_firmware_hdm(ct2d->pxb);
     cxl_fmws_direct_passthrough_remove_all(pci_dev);
+    g_free(ct2d->cxl_cstate.crb.special_ops);
     clean_memory(pci_dev);
 }
 
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index eb71f1c80a..725dc7388d 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -313,6 +313,8 @@ typedef struct cxl_component {
 void cxl_component_register_block_init(Object *obj,
                                        CXLComponentState *cxl_cstate,
                                        const char *type);
+void cxl_cache_mem_write_common(CXLComponentState *cxl_cstate, hwaddr offset,
+                                uint32_t value);
 void cxl_component_register_init_count(uint32_t *reg_state,
                                        uint32_t *write_msk,
                                        enum reg_type type, bool bi,
-- 
2.53.0

