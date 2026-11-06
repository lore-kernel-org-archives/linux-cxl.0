Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793937629;
	b=VMUp/sgQJdYpgjfPC2JFuBPIK+njcHXhVrFTZ3nOG97FcpKftuwZi/kvC1odOi+ewB38
	 xrr9KdNCEAjfD2UxGHQL+R0xpjlnGjk+M7USkysVGq05Xa/k4AB576hHOnn8oQs6QE4mD
	 RaKqwlL69M13ZHkt9QhWcFGrmxZPg6bvF0CNyOTzDAD/tXF5UMj6ufLgLmVo0vq0knG+2
	 DUn8L1tg1YfBEzjJYyx6/Ew7convlxiaiifQpaJSgOj/0gCCpLkzypImIaqXv2Y4Bm+dA
	 sqL2wO4vmQSvLIkIA/cOLPkurpyueFRVrcCVQOpAxRrUhT2tzOnhfQKPEu6uTMxjDeg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937629;
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
	bh=kHGAlwsNGzDvnFkZXyvjcpkt5MztooolAjgH4JdEIo8=;
	b=Skupl+CCnGZcxlUSw8sw4REjc96BMtR8x3DX812YguhQycx9QNLekN6eR28EDu6v1M4P
	 9/Info5rRI7pyfW/Owi40xh1KKAakngo1tbrI61q7ZgyxvXf6KoR5eA2EAAZHVA5X3F2i
	 d/iuNN8yX+1jB1ny0GZU4DsmDVN9MSyTQnntZheqWgHuOP67Y+dpEUMd+JLaQq0jBZSMx
	 BThuh1QG+HjguBHrIb7q09Z/lZa6XOSo4z5PNi4oWJmQdpDjM6sx/63ewpdqOeDgfBKwT
	 tUdekgujkNdHFXqgNsOfXmwX6Mmf4zwNw2FXHjDncu0j3jsx6mJVm+65aCqWmLth9gw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HL0b7OHa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.50
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA84606A31B
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 04:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABA84606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HL0b7OHa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+NQ+b4qFTNTzL22oAIHE9F/m1n1/KevreZs1rPE+hFuBAnykpgJh0jEJBZxOnk4TdC8YOloLSqPpPoanBTrc+e80CbImtfmuQN4zmL0GBdxRfguQMVrIpdDhLvwmgCD4lvDQZu3yEEhkHDNmvlyl2Iph+TeQCrDkMwx/PIcbYgQW39wVqdkeegjjewrXsXzz9KWfxSrpTGxVgR9eGq55MLHT4vvZtyprNrMFgs8WbMT+cGcqBcCti4A4tII204+Y21ei9GAhvk7RBTpzZ0kp2HVL4TwUt6lxvMiLBfPZJPjnAhr7cyZq2w5kmV7Nktce1tmGxBCaVYzdU9rTc3B5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHGAlwsNGzDvnFkZXyvjcpkt5MztooolAjgH4JdEIo8=;
 b=VCNy/zcYiGdloGswOIdTW62IqqYLLtAzkNAOs5pxCK8YA12UA2ZGUQYuSTA9lZw7Nk/Wv+PTcULVXP+ATrX4BKWf0/e1HRyVhZdvKHA/1ZoBFN7KDbts8DVzDI6OwoAbYZZc/63W5JbymA3WAAcuLfLwaIymdmzkBEcdgjhUoW+utAfbScb/rideNPnPDWe8FOlarE8GC20ai2+DjNJxTtjOdGYF7V+ChOJgWQ1WQNiPLAYAIgnggM/uuucSzQ6xqI9we2Qwj79fQinDkNzeA40bFL3Sj+4up4LnMWJMdJyxFQm2LhhXAfhjDgFHWRf9mpC5Sdawf6CyyuT4hPLhbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHGAlwsNGzDvnFkZXyvjcpkt5MztooolAjgH4JdEIo8=;
 b=HL0b7OHaDvWSsoqzpZVivKHt9ulcbrcGTMfhUUFxMD6vtkwrh4QUhlnXcGWGLCzbBQL8oDc3E6TzCCh5ceojCHy4erLwCMMQKyflj0ZScAHg8AdVTK4jmlXfDusooks/g7cFSXkaXMf+M9z6U79OXBS2QvrY4DlqjlSfl0Enhvw3ZB168qIDwBRhVZTqBXLU17jyz9wfSViHjrsXza/dqhFJqyh/0kCgdNQCHw8cQjGKm3j9y4rLWnQS+g4OZJRgGizZv4h3BeoBnW50IzNEevurRYhHCeT7ZWhpSTzACiHvJ3xjWy6GcKN3ooTghlxHFc4OMmRSslERUAMA3ym74A==
Received: from CH2PR10CA0027.namprd10.prod.outlook.com (2603:10b6:610:4c::37)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:00:21 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:610:4c:cafe::c) by CH2PR10CA0027.outlook.office365.com
 (2603:10b6:610:4c::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 04:00:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:00:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:05 -0800
Received: from cxlgalaxy.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:00 -0800
From: <mhonap@nvidia.com>
To: <jic23@kernel.org>, <alwilliamson@nvidia.com>, <clg@redhat.com>,
	<xueshuai@linux.alibaba.com>, <ira.weiny@intel.com>, <zhiw@nvidia.com>,
	<mst@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<junjie.cao@linux.dev>, <anisa.su@samsung.com>, <pbonzini@redhat.com>,
	<ankita@nvidia.com>, <vsethi@nvidia.com>, <skolothumtho@nvidia.com>,
	<mochs@nvidia.com>
CC: <cjia@nvidia.com>, <mhonap@nvidia.com>, <kjaju@nvidia.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: [RFC 06/18] hw/cxl: Find the memory of a CXL device through one helper
Date: Fri, 6 Nov 2026 09:28:59 +0530
Message-ID: <20261106035911.1280066-7-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e7747ac-0149-484a-e1d4-08df3bba7a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|7416014|22082099003|18002099003|10067099003|921020|56012099006|11063799006|261026121527099003|261028144727099003|261009223027099003|261022075727099003|261102123227099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	XtVsGuKtqAQjeYM65u84DOmKs83LHl8coET7r9Mv39ZJlZr+ZuF+/vGzOCSaDs8nq9XA4eZtxMT9Ccx/LTEr5mE9s6TQA3umqnFvppLj20FPIAIEm7T1oyovjU6305sPYf8E8XNykppKOtnG3i4FqtsorEee/GfKuAvVeghtXjuzPbBIdQAc2jx7d0UCv0LxkwJxe3sT3ZFkQM+/b03qMS9y1yv7/aKfLEAB8wrwFyYjUJxLHjNv5eZYb/Ivey5gttqVmtAPwLceqG1uv4+VwaAMMMREItitRgW5UTS6DegiUD1ifn1CHFNmPBDWF4bbCMDhZhtq4+G1u3uZ83WcMOc+1DD/3zcclF9ifFjuDtjKgmfkXpmTdu/pj9KPBxQtCtbBPx5C3OAukUhB/jGT/ZcT+3sop36V9ip5pFecVvSQwogpMGNXiG+5Mo0xq3tCTzY7BDueICvvQIThW/WTHfA23X10ehx4Ihoq11sEM06Ksgoae4js0+0iKxUThFLSIYdHKdfvOM7D0lTXgNuq2SxhpVDm3UbwghFJq8g4nbsOKNokGwaAM5HElIHGW+zbzJPbWc0uGB7kwT2Z8oM8RGucAYndwm4hu8iXgYgbdOmRFJYcRGEyDgjMerWpOhOpB9YMjqzjYSSSATTZrv0AAV8wU0i1BNdApQGymShzYA6ghex5+v1popVjBFnfdxkW+h+er+1KWG1It4lPL0qjfAslrFD+1Y9Hj2Sqoze8WHQJEGbt8c+11g9D+fGcmoeo
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(7416014)(22082099003)(18002099003)(10067099003)(921020)(56012099006)(11063799006)(261026121527099003)(261028144727099003)(261009223027099003)(261022075727099003)(261102123227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5pd3IsQAx7BCCPqHnbNMqlnnpgBXQ0oe2Y0aaaN/8hH3ZZ2FQRlFLWWKL0gWHevTM3xAwT4nQagKKttEQMfdazRygWZRoHEKXQiiSNntAFB0zpX2lvHEAqrcarltBqA696ztG7Zm2a5srp5wUQZqMTnndr+3sL7jB+V5kT208Bs768sJrk5aMSE0g8q+wb4TNSW5dP+9FJl2uvJy5d1O1ZR1gOFZ3ePEpR13DUaIkoigJmqQtmLNFYYsIoIqsEsVU8ENvHGTYlorM1vEN18sSEkE4RmBtSkfVZIlz/R1Vcjn6T8IlIX8njEJnt1el1s0lTGOxNgEUz/Mt1E4mUBGdF1AMYby5lGBna9ZKFKxjdAWqCroIkPER9pl1Wfu0dza55qNckE6gDKAFlobXYc2WO/Lwp1u/8Cc2NJjazp9mX0g4jh4Sh3wR+rV51068yoN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:00:21.4370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7747ac-0149-484a-e1d4-08df3bba7a8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329

From: Manish Honap <mhonap@nvidia.com>

The direct mapping code takes the memory backends, component registers
and mapping slots from CXLType3Dev. Collect them in a CXLMemDevice
filled by cxl_mem_device(), and add
cxl_fmws_direct_passthrough_remove_all() to drop every mapping of a
device. The CXL Type-2 device added later in this series uses both.

No functional change for cxl-type3.

AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/cxl/cxl-host.c    | 110 +++++++++++++++++++++++++++++++------------
 include/hw/cxl/cxl.h |   1 +
 2 files changed, 82 insertions(+), 29 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 754f708cce..d9c7599679 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -209,6 +209,37 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
     return found;
 }
 
+/* A CXL device with memory that a fixed memory window can map directly */
+typedef struct CXLMemDevice {
+    PCIDevice *pdev;
+    CXLComponentState *cstate;
+    HostMemoryBackend *hostvmem;
+    HostMemoryBackend *hostpmem;
+    MemoryRegion *direct_mr;
+    CXLFixedWindow **direct_mr_fw;
+} CXLMemDevice;
+
+static bool cxl_mem_device(Object *obj, CXLMemDevice *md)
+{
+    CXLType3Dev *ct3d;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        return false;
+    }
+    ct3d = CXL_TYPE3(obj);
+    if (md) {
+        *md = (CXLMemDevice) {
+            .pdev = PCI_DEVICE(ct3d),
+            .cstate = &ct3d->cxl_cstate,
+            .hostvmem = ct3d->hostvmem,
+            .hostpmem = ct3d->hostpmem,
+            .direct_mr = ct3d->direct_mr,
+            .direct_mr_fw = ct3d->direct_mr_fw,
+        };
+    }
+    return true;
+}
+
 static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr,
                                         bool allow_interleave)
 {
@@ -265,7 +296,7 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr,
         return NULL;
     }
 
-    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE3)) {
+    if (cxl_mem_device(OBJECT(d), NULL)) {
         return d;
     }
 
@@ -304,7 +335,7 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr,
         return NULL;
     }
 
-    if (!object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE3)) {
+    if (!cxl_mem_device(OBJECT(d), NULL)) {
         return NULL;
     }
 
@@ -312,7 +343,7 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr,
 }
 
 typedef struct CXLDirectPTState {
-    CXLType3Dev *ct3d;
+    CXLMemDevice md;
     hwaddr decoder_base;
     hwaddr decoder_size;
     hwaddr dpa_base;
@@ -322,15 +353,15 @@ typedef struct CXLDirectPTState {
 static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
                                               CXLFixedWindow *fw)
 {
-    CXLType3Dev *ct3d = state->ct3d;
+    CXLMemDevice *md = &state->md;
     MemoryRegion *mr = NULL;
     uint64_t vmr_size = 0, pmr_size = 0, offset = 0;
     MemoryRegion *direct_mr;
     g_autofree char *direct_mr_name = NULL;
     unsigned int idx = state->hdm_decoder_idx;
 
-    if (ct3d->hostvmem) {
-        MemoryRegion *vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+    if (md->hostvmem) {
+        MemoryRegion *vmr = host_memory_backend_get_memory(md->hostvmem);
 
         vmr_size = memory_region_size(vmr);
         if (state->dpa_base < vmr_size) {
@@ -338,8 +369,8 @@ static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
             offset = state->dpa_base;
         }
     }
-    if (!mr && ct3d->hostpmem) {
-        MemoryRegion *pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+    if (!mr && md->hostpmem) {
+        MemoryRegion *pmr = host_memory_backend_get_memory(md->hostpmem);
 
         pmr_size = memory_region_size(pmr);
         if (state->dpa_base - vmr_size < pmr_size) {
@@ -351,37 +382,49 @@ static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
         return;
     }
 
-    if (ct3d->direct_mr_fw[idx]) {
+    if (md->direct_mr_fw[idx]) {
         return;
     }
 
-    direct_mr = &ct3d->direct_mr[idx];
+    direct_mr = &md->direct_mr[idx];
     direct_mr_name = g_strdup_printf("cxl-direct-mapping-alias-%u", idx);
     if (!direct_mr_name) {
         return;
     }
 
-    memory_region_init_alias(direct_mr, OBJECT(ct3d), direct_mr_name, mr,
+    memory_region_init_alias(direct_mr, OBJECT(md->pdev), direct_mr_name, mr,
                              offset, state->decoder_size);
     memory_region_transaction_begin();
     memory_region_add_subregion(&fw->mr,
                                 state->decoder_base - fw->base, direct_mr);
     memory_region_transaction_commit();
-    ct3d->direct_mr_fw[idx] = fw;
+    md->direct_mr_fw[idx] = fw;
+}
+
+static void cxl_fmws_direct_passthrough_unmap(CXLMemDevice *md,
+                                              unsigned int idx)
+{
+    CXLFixedWindow *owner_fw = md->direct_mr_fw[idx];
+    MemoryRegion *direct_mr = &md->direct_mr[idx];
+
+    memory_region_transaction_begin();
+    memory_region_del_subregion(&owner_fw->mr, direct_mr);
+    object_unparent(OBJECT(direct_mr));
+    memory_region_transaction_commit();
+    md->direct_mr_fw[idx] = NULL;
 }
 
-static void cxl_fmws_direct_passthrough_remove(CXLType3Dev *ct3d,
+static void cxl_fmws_direct_passthrough_remove(CXLMemDevice *md,
                                                uint64_t decoder_base,
                                                unsigned int idx)
 {
-    CXLFixedWindow *owner_fw = ct3d->direct_mr_fw[idx];
-    MemoryRegion *direct_mr = &ct3d->direct_mr[idx];
+    CXLFixedWindow *owner_fw = md->direct_mr_fw[idx];
 
     if (!owner_fw) {
         return;
     }
 
-    if (!memory_region_is_mapped(direct_mr)) {
+    if (!memory_region_is_mapped(&md->direct_mr[idx])) {
         return;
     }
 
@@ -389,11 +432,21 @@ static void cxl_fmws_direct_passthrough_remove(CXLType3Dev *ct3d,
         return;
     }
 
-    memory_region_transaction_begin();
-    memory_region_del_subregion(&owner_fw->mr, direct_mr);
-    object_unparent(OBJECT(direct_mr));
-    memory_region_transaction_commit();
-    ct3d->direct_mr_fw[idx] = NULL;
+    cxl_fmws_direct_passthrough_unmap(md, idx);
+}
+
+void cxl_fmws_direct_passthrough_remove_all(PCIDevice *dev)
+{
+    CXLMemDevice md;
+
+    if (!cxl_mem_device(OBJECT(dev), &md)) {
+        return;
+    }
+    for (unsigned int i = 0; i < CXL_HDM_DECODER_COUNT; i++) {
+        if (md.direct_mr_fw[i]) {
+            cxl_fmws_direct_passthrough_unmap(&md, i);
+        }
+    }
 }
 
 static int cxl_fmws_direct_passthrough(Object *obj, void *opaque)
@@ -421,19 +474,18 @@ static int update_non_interleaved(Object *obj, void *opaque)
 {
     const int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     bool commit = *(bool *)opaque;
-    CXLType3Dev *ct3d;
+    CXLMemDevice md;
     uint32_t *cache_mem;
     unsigned int hdm_count, i;
     int interleave_ways_dec;
     uint32_t cap;
     uint64_t dpa_base = 0;
 
-    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+    if (!cxl_mem_device(obj, &md)) {
         return 0;
     }
 
-    ct3d = CXL_TYPE3(obj);
-    cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
+    cache_mem = md.cstate->crb.cache_mem_registers;
     cap = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
     hdm_count = cxl_decoder_count_dec(FIELD_EX32(cap,
                                                  CXL_HDM_DECODER_CAPABILITY,
@@ -447,8 +499,8 @@ static int update_non_interleaved(Object *obj, void *opaque)
         committed = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED);
 
         /*
-         * Optimization: Looking for a fully committed path; if the type 3 HDM
-         * decoder is not commmitted, it cannot lie on such a path.
+         * Optimization: Looking for a fully committed path; if the endpoint
+         * HDM decoder is not committed, it cannot lie on such a path.
          */
         if (commit && !committed) {
             return 0;
@@ -473,10 +525,10 @@ static int update_non_interleaved(Object *obj, void *opaque)
 
         if (iw == 0) {
             if (!commit) {
-                cxl_fmws_direct_passthrough_remove(ct3d, decoder_base, i);
+                cxl_fmws_direct_passthrough_remove(&md, decoder_base, i);
             } else {
                 CXLDirectPTState state = {
-                    .ct3d = ct3d,
+                    .md = md,
                     .decoder_base = decoder_base,
                     .decoder_size = decoder_size,
                     .dpa_base = dpa_base,
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 7cf3dc622c..e3a3a43236 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -84,4 +84,5 @@ typedef struct CXLDownstreamPort CXLDownstreamPort;
 DECLARE_INSTANCE_CHECKER(CXLDownstreamPort, CXL_DSP, TYPE_CXL_DSP)
 
 void cfmws_update_non_interleaved(bool commit);
+void cxl_fmws_direct_passthrough_remove_all(PCIDevice *dev);
 #endif
-- 
2.53.0

