Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=139.138.61.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008458;
	b=ZHFi/o2N1A/rKUuR786iVRLVwOYYGjicQye/GodtwRIpJkDHSSzfc5cacu+ThMj3fwn3
	 04L63CyCTcOJJxT7Nd5+YmNE1LUwjUy4K1C/W03Hl/Bt4mU012WffB0Ji5j90oi8olAHd
	 lpEztAVEKN4TJjxvSM32Zmb0NHPwwFZrPq4i1NbNGJWBy/jOQW/t4L092bmRXdFPkNzgo
	 pOzPieGe8t2oPlg7ecFdHrbsZuhv7slJkdx4zfDYfwrTxSrexrwjwLBX2NOSGaEexMUhW
	 8Kyasut5+/+AWVIloEuV8qjRdNbAfFzat8/a71wh8v2vxtRdMPFkLTfrI/4o7CbPdOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008458;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5/PjjFpHJMQNFkm0jVvsAlbbMUQRzR9dvMRBcBXQjOw=;
	b=4X5O5Lt1aYKKdKRtW7ub3KtEuquazl5fmESYGlfGPIYiO2RXuQ2RwaYRMiEq6clfNjm5
	 R+2AzA3jvUissfCSoVponpDlhkL0+9o/z+T8FECGxTMLKTpc9LTHk7ozf7nopUGS9YND1
	 XDqEnvwvgsC8iYaaN/kdG1kLRJ8m09E4OaTWE2Ul2gtVRYy8iAH9Jl4dtnp5qCXQ/PQ4q
	 6B7R3SttvAq4WUiLlAcY2+IAx0nE14jgmormvqGlgGiQb79lDZz4SxSLYVDHsUNVMHRnH
	 C3AIQkLYZFWGucehR7GYh8MV8kvGQzbXR5oBQ/ZuHQKoYmazB75zlmSDQ6k7SUCJDJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=WfL1XzR6;
	arc=none smtp.remote-ip=139.138.61.252
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A31606A31F
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82A31606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=WfL1XzR6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1793008457; x=1824544457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zq89hgzs7m9+iM8Br2P62CYeN5DC4Ml4L5UACTlprZ4=;
  b=WfL1XzR6iK86suijatCt9ow5buiq3tXgSvNUbh1cQaV7wvratzy0PLUG
   v51GMiXl65nAONSMtTjOmAcTtmUSaBNEr1ibs3YGSOrB6RJCfxHjru6aq
   29D0+Ucpf9LFlxemBRXiLUCcwirRQ4WfyYFsa55PB15ra63APlJTL1hJW
   czCUfUI4oZhjjf+RxzkmRftMnXOcGnD22MuBSNQB0yUyxMcahgpzWbI05
   6nE5aY9o48HHl9HDKXItZRBnYGFvstDFjqueY83aoVoA7Wxioav1Kc7GP
   yM5JFzfXgAErdOMxqOmXXQu6JBzZsWyIJnXfr86vObayv1reuOm/9hx4b
   w==;
X-CSE-ConnectionGUID: L/GiH4T/RCuEVWtcai2vUA==
X-CSE-MsgGUID: 5TjHIPKNSmipMSk8xoJfzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="238359881"
X-IronPort-AV: E=Sophos;i="6.27,179,1786978800"; 
   d="scan'208";a="238359881"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 18:54:09 +0900
Received: from az2uksmgm4.o.css.fujitsu.com (unknown [10.151.22.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id AB0181002B87
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:09 +0000 (UTC)
Received: from m3003.s.css.fujitsu.com (unknown [10.128.233.114])
	by az2uksmgm4.o.css.fujitsu.com (Postfix) with ESMTP id 2571A14003A8
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:09 +0000 (UTC)
Received: from tanjiro.soft.fujitsu.com (unknown [10.118.236.61])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id E8F7A202EBDE;
	Mon, 26 Oct 2026 18:54:07 +0900 (JST)
From: Yukiya Takaki <fj2110jc@fujitsu.com>
To: qemu-devel@nongnu.org
Cc: Yukiya Takaki <fj2110jc@fujitsu.com>,
	Anisa Su <anisa.su@samsung.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Junjie Cao <junjie.cao@intel.com>,
	linux-cxl@vger.kernel.org,
	"Wolski, Tomasz" <tomasz.wolski@fujitsu.com>,
	lizhijian@fujitsu.com,
	y-goto@fujitsu.com,
	yukiya.takaki@gmail.com
Subject: [PATCH RFC 2/7] QEMU/hw/cxl:add HPA offset tracking for CXL Type 3 devices
Date: Mon, 26 Oct 2026 19:03:23 +0900
Message-ID: <6172d168ed84f0b968661e7bf41dad01526d9d0a.1793003983.git.fj2110jc@fujitsu.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1793003983.git.fj2110jc@fujitsu.com>
References: <cover.1793003983.git.fj2110jc@fujitsu.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

E820, SRAT and HDM decoder programming in this series all need per‑device
host physical address (HPA) information for CXL Type 3 memory. Today,
CXLType3Dev does not expose this in a convenient way.

This patch adds minimal state to CXLHost and CXLType3Dev, plus a helper
to walk from a Type 3 device back to its host, so that each CXL Type 3
device can be assigned a stable HPA offset within the CFMW window and an
index that later code can rely on when building firmware tables and
regions.

Co-developed-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Yukiya Takaki <fj2110jc@fujitsu.com>
---
 hw/mem/cxl_type3.c          | 37 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl.h        |  2 ++
 include/hw/cxl/cxl_device.h |  2 ++
 3 files changed, 41 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b65ddd264d..d08a4255c9 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -732,9 +732,39 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
     }
 }
 
+
+static CXLHost *ct3d_to_cxl_pxb(DeviceState *dev)
+{
+    BusState *bus = dev->parent_bus;
+
+    DeviceState *cxl_rp_dev = NULL;
+    if (bus && bus->parent) {
+        cxl_rp_dev = bus->parent;
+    }
+    assert(cxl_rp_dev);
+
+    DeviceState *cxl_host_dev = NULL;
+    if (cxl_rp_dev) {
+        BusState *rp_bus = cxl_rp_dev->parent_bus;
+        if (rp_bus && rp_bus->parent) {
+            cxl_host_dev = rp_bus->parent;
+        }
+    }
+    assert(cxl_host_dev);
+
+    if (cxl_host_dev &&
+        object_dynamic_cast(OBJECT(cxl_host_dev), TYPE_PXB_CXL_HOST)) {
+        CXLHost *host = PXB_CXL_HOST(cxl_host_dev);
+        return host;
+    }
+
+    return NULL;
+}
+
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
+    CXLHost *host = ct3d_to_cxl_pxb(ds);
 
     if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
         && !ct3d->dc.num_regions) {
@@ -816,6 +846,13 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         g_free(p_name);
     }
 
+    if (ct3d->program_hdm_decoder) {
+        ct3d->hpa_offset = host->unused_hpa_offset;
+        ct3d->idx = host->unused_dev_num;
+        host->unused_hpa_offset += ct3d->cxl_dstate.static_mem_size;
+        host->unused_dev_num++;
+    }
+
     ct3d->dc.total_capacity = 0;
     if (ct3d->dc.num_regions > 0) {
         MemoryRegion *dc_mr;
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 7cf3dc622c..b8b3071f81 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -67,6 +67,8 @@ struct CXLHost {
 
     CXLComponentState cxl_cstate;
     bool passthrough;
+    hwaddr unused_hpa_offset;
+    int unused_dev_num;
 };
 
 #define TYPE_PXB_CXL_HOST "pxb-cxl-host"
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a2c830d181..c3a729f8c5 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -778,6 +778,8 @@ struct CXLType3Dev {
     bool hdmdb;
 
     bool program_hdm_decoder;
+    hwaddr hpa_offset;
+    int idx;
 
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
-- 
2.52.0

