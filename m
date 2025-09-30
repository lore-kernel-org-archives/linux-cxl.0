Received: from dragonfly.birch.relay.mailchannels.net (dragonfly.birch.relay.mailchannels.net [23.83.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45668176FB1
	for <linux-cxl@vger.kernel.org>; Tue, 30 Sep 2025 03:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759202565; cv=pass; b=jA0m5xzaMWup49pjX73R6DsQrX8njkofAbR2GJN5ZvX5SgLkdfKj6CNbwAwRJ1AQkwaCf84a6dNN8GEqpamKL1U+P7EpJWtNq322eLn7JyDl3RRzycAvT8SkZsHVOyGZHsOt9ASiSJ96FOLi1HiuLBw1anfgRpJw4odP3ZDF0rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759202565; c=relaxed/simple;
	bh=1VKhX9MkYcPpMh4lQZiAPCgpoE8gnfgTONXKaBjRm/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JSS1FINqwj9K3djDDA7HGJyMWXXA6n9gRcH3RXJmEeFQJx0+U9a/F6Zxqn98BhDPUCeQ7TrTNYMpyxHhg8xv4Nu9R29SnfOZYfQzxUS+EOK+Bijot2vLKv0Bs9g/IC+XQekqWBtL+wdHj0bTDQ+aoZCjon7H4KsisqT8snc6n0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=dpla5LC0; arc=pass smtp.client-ip=23.83.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="dpla5LC0"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 31142940FEA;
	Tue, 30 Sep 2025 03:22:36 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com (100-113-92-161.trex-nlb.outbound.svc.cluster.local [100.113.92.161])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C4BFC9412DC;
	Tue, 30 Sep 2025 03:22:35 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1759202555; a=rsa-sha256;
	cv=none;
	b=ACT5+4dOyEm4fGFF54htTq4NNtrBBN/vEduiTnAn3hRz5B+6PAoeRPMx2i/646i9QyMUUb
	alNtTFw6Skdms/717+ufDntohp1N07irypJOx2pzresdjctVAmtkDY5FLLwXXvcJCvzVwg
	kYJoUq2LffbUinZRcOAxKiEYN+ds3q81W2qqzl+lnfA+Lx67gQhyrRH6nNww8UcSRHjgv/
	ukFt3jIyI6YG950mOiwas4GhtmmyRTcbbmpWnbuiJWAxBwxOK25Too7l/fdBAq5oNYINDB
	m39M3YCuQvN/OlDoE0uWbN3t3DIMbmowksp0cOrx+WrZCbf9KqaymUpMStJYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1759202555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=sOPbGdINPO3dAXnFlk3XQnA53WSdkQhDkbMCNFigUgo=;
	b=DPsXSfeELjnHgLXA+7H7vDQxxgsJPW6Ez+gkYIeGVXZiZYTSMa6EtJI+gEfTXKRFTOttF1
	TdWiD4/JgZyn+HcnbGwWDzG3Wl7eZgSRQ9p2DTsqL5xjbkqdoKFELmn4MRhtyiXI7UR055
	Z9wGnPa5VLIcBsRTrdabm/B893f8pJ0otRjqN7NqXsWDZiOJJcdgMLuBlP8tPfLIgd/rI1
	QeL/vzehgaHNOVLh6N64ianDWbaeXhRtkRa+2T4199JBOWdfyh/BKu75e6w8cgwsyk/YfA
	XVKu3vO4g2N42aNi0kZT2CoCbw+AbGHCiQINMc1T8vPeX1zH5eivH+ayvkRMUA==
ARC-Authentication-Results: i=1;
	rspamd-9695c5dfc-p4zkv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Ruddy-Lettuce: 6a057f151cb1cdfa_1759202556091_2049676043
X-MC-Loop-Signature: 1759202556091:2912115692
X-MC-Ingress-Time: 1759202556091
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.113.92.161 (trex/7.1.3);
	Tue, 30 Sep 2025 03:22:36 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4cbNfL72pbzR4;
	Mon, 29 Sep 2025 20:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1759202555;
	bh=sOPbGdINPO3dAXnFlk3XQnA53WSdkQhDkbMCNFigUgo=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=dpla5LC0sNf8o0g9/ulTQw8Xg1D0w8vwjGdDuDEz1KOEEzZIwTjtktT4YnmnVdE+y
	 iaAbS5X+u/sJxzo/0NE4TvDEwKLTVZu7jKkWb5t857wKl2qg8dqyRlV965rp/nxsKV
	 Fq1XQ3UUK/mlqqquiOjVF+XEfzt0r0K1e6LaWufmb35oebkw7rrftfd95VmT8Uu8QT
	 DcZEn5as1ruuZ6+DA0pqspOHntEYI8eUM1ZWnUhmydLjIasDCtbGmJcxLRCGAHaaHf
	 0r6YI3WDDPdZqCD0zGgCUTHmo3NZDoFG1nl5Hhx60kUCCIiU1Tbk3imxNvJ6UMyGU1
	 9qf1LZFncKTZQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com,
	lucerop@amd.com,
	a.manzanares@samsung.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com,
	armbru@redhat.com,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH 4/5] hw/cxl: Support type3 HDM-DB
Date: Mon, 29 Sep 2025 20:21:52 -0700
Message-Id: <20250930032153.1127773-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250930032153.1127773-1-dave@stgolabs.net>
References: <20250930032153.1127773-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic plumbing for memory expander devices that support Back
Invalidation. This introduces a 'hdm-db=on|off' parameter and
exposes the relevant BI RT/Decoder component cachemem registers.

Some noteworthy properties:
 - Devices require enabling Flit mode.
 - Explicit BI-ID commit is required.
 - HDM decoder support both host and dev coherency models.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 docs/system/devices/cxl.rst         |  23 +++++
 hw/cxl/cxl-component-utils.c        | 147 ++++++++++++++++++++++++++--
 hw/mem/cxl_type3.c                  |   9 +-
 hw/pci-bridge/cxl_downstream.c      |   2 +-
 hw/pci-bridge/cxl_root_port.c       |   3 +-
 hw/pci-bridge/cxl_upstream.c        |   2 +-
 hw/pci-bridge/pci_expander_bridge.c |   2 +-
 include/hw/cxl/cxl_component.h      |  54 +++++++++-
 include/hw/cxl/cxl_device.h         |   3 +
 9 files changed, 228 insertions(+), 17 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index bf7908429af8..9cdf097fc644 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -384,6 +384,29 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
   -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,sn=0x4 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
 
+An example of 4 type3 devices with volatile memory below a switch. Two of the devices
+use HDM-DB for coherence, which requires operating in Flit mode::
+
+  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
+  ...
+  -object memory-backend-ram,id=cxl-mem0,share=on,mem-path=/tmp/cxltest.raw,size=256M \
+  -object memory-backend-ram,id=cxl-mem1,share=on,mem-path=/tmp/cxltest1.raw,size=256M \
+  -object memory-backend-ram,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=256M \
+  -object memory-backend-ram,id=cxl-mem3,share=on,mem-path=/tmp/cxltest3.raw,size=256M \
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
+  -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
+  -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
+  -device cxl-upstream,bus=root_port0,id=us0,x-256b-flit=on \
+  -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
+  -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,id=cxl-mem0,sn=0x1,x-256b-flit=on,hdm-db=on \
+  -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
+  -device cxl-type3,bus=swport1,volatile-memdev=cxl-mem1,id=cxl-mem1,sn=0x2,x-256b-flit=on,hdm-db=on \
+  -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
+  -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,id=cxl-mem2,sn=0x3 \
+  -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
+  -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
+
 A simple arm/virt example featuring a single direct connected CXL Type 3
 Volatile Memory device::
 
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index a43d227336ca..2098e9999a88 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -71,10 +71,40 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
     case 4:
         if (cregs->special_ops && cregs->special_ops->read) {
             return cregs->special_ops->read(cxl_cstate, offset, 4);
-        } else {
-            QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
-            return cregs->cache_mem_registers[offset / 4];
         }
+
+        QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
+
+        if (offset == A_CXL_BI_RT_STATUS ||
+            offset == A_CXL_BI_DECODER_STATUS) {
+            int type;
+            uint64_t started;
+
+            type = (offset == A_CXL_BI_RT_STATUS) ?
+                    CXL_BISTATE_RT : CXL_BISTATE_DECODER;
+            started = cxl_cstate->bi_state[type].last_commit;
+
+            if (started) {
+                uint32_t *cache_mem = cregs->cache_mem_registers;
+                uint32_t val = cache_mem[offset / 4];
+                uint64_t now;
+                int set;
+
+                now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+                /* arbitrary 100 ms to do the commit */
+                set = !!(now >= started + 100);
+
+                if (offset == A_CXL_BI_RT_STATUS) {
+                    val = FIELD_DP32(val, CXL_BI_RT_STATUS, COMMITTED, set);
+                } else {
+                    val = FIELD_DP32(val, CXL_BI_DECODER_STATUS, COMMITTED,
+                                     set);
+                }
+                stl_le_p((uint8_t *)cache_mem + offset, val);
+            }
+        }
+
+        return cregs->cache_mem_registers[offset / 4];
     case 8:
         qemu_log_mask(LOG_UNIMP,
                       "CXL 8 byte cache mem registers not implemented\n");
@@ -123,6 +153,47 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
     }
 }
 
+static void bi_handler(CXLComponentState *cxl_cstate, hwaddr offset,
+                            uint32_t value)
+{
+    ComponentRegisters *cregs = &cxl_cstate->crb;
+    uint32_t sts, *cache_mem = cregs->cache_mem_registers;
+    bool to_commit = false;
+    int type;
+
+    switch (offset) {
+    case A_CXL_BI_RT_CTRL:
+        to_commit = FIELD_EX32(value, CXL_BI_RT_CTRL, COMMIT);
+        if (to_commit) {
+            sts = cxl_cache_mem_read_reg(cxl_cstate,
+                                         R_CXL_BI_RT_STATUS, 4);
+            sts = FIELD_DP32(sts, CXL_BI_RT_STATUS, COMMITTED, 0);
+            stl_le_p((uint8_t *)cache_mem + R_CXL_BI_RT_STATUS, sts);
+            type = CXL_BISTATE_RT;
+        }
+        break;
+    case A_CXL_BI_DECODER_CTRL:
+        to_commit = FIELD_EX32(value, CXL_BI_DECODER_CTRL, COMMIT);
+        if (to_commit) {
+            sts = cxl_cache_mem_read_reg(cxl_cstate,
+                                         R_CXL_BI_DECODER_STATUS, 4);
+            sts = FIELD_DP32(sts, CXL_BI_DECODER_STATUS, COMMITTED, 0);
+            stl_le_p((uint8_t *)cache_mem + R_CXL_BI_DECODER_STATUS, sts);
+            type = CXL_BISTATE_DECODER;
+        }
+        break;
+    default:
+        break;
+    }
+
+    if (to_commit) {
+        cxl_cstate->bi_state[type].last_commit =
+                qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    }
+
+    stl_le_p((uint8_t *)cache_mem + offset, value);
+}
+
 static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
                                     unsigned size)
 {
@@ -146,6 +217,9 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
         if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
             offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
             dumb_hdm_handler(cxl_cstate, offset, value);
+        } else if (offset == A_CXL_BI_RT_CTRL ||
+                   offset == A_CXL_BI_DECODER_CTRL) {
+            bi_handler(cxl_cstate, offset, value);
         } else {
             cregs->cache_mem_registers[offset / 4] = value;
         }
@@ -235,7 +309,7 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
 }
 
 static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
-                            enum reg_type type)
+                            enum reg_type type, bool bi)
 {
     int decoder_count = CXL_HDM_DECODER_COUNT;
     int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
@@ -260,7 +334,9 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
                      UIO_DECODER_COUNT, 0);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, MEMDATA_NXM_CAP, 0);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
-                     SUPPORTED_COHERENCY_MODEL, 0); /* Unknown */
+                     SUPPORTED_COHERENCY_MODEL,
+                     /* host+dev or Unknown */
+                     type == CXL2_TYPE3_DEVICE && bi ? 3 : 0);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
                      HDM_DECODER_ENABLE, 0);
     write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
@@ -271,8 +347,7 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
         write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc] = 0xffffffff;
         write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] = 0x13ff;
         if (type == CXL2_DEVICE ||
-            type == CXL2_TYPE3_DEVICE ||
-            type == CXL2_LOGICAL_DEVICE) {
+            type == CXL2_TYPE3_DEVICE || type == CXL2_LOGICAL_DEVICE) {
             write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * hdm_inc] =
                 0xf0000000;
         } else {
@@ -283,9 +358,43 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
     }
 }
 
+static void bi_rt_init_common(uint32_t *reg_state, uint32_t *write_msk)
+{
+    /* switch usp must commit the new BI-ID, timeout of 2secs */
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_CAPABILITY, EXPLICIT_COMMIT, 1);
+
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_CTRL, COMMIT, 0);
+    write_msk[R_CXL_BI_RT_CTRL] = 0x1;
+
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_STATUS, COMMITTED, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_STATUS, ERR_NOT_COMMITTED, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_STATUS, COMMIT_TMO_SCALE, 0x6);
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_STATUS, COMMIT_TMO_BASE, 0x2);
+}
+
+static void bi_decoder_init_common(uint32_t *reg_state, uint32_t *write_msk,
+                                   enum reg_type type)
+{
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_CAPABILITY, HDM_D, 0);
+    /* switch dsp must commit the new BI-ID, timeout of 2secs */
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_CAPABILITY, EXPLICIT_COMMIT,
+                     (type != CXL2_ROOT_PORT && type != CXL2_TYPE3_DEVICE));
+
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_CTRL, BI_FW, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_CTRL, BI_ENABLE, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_CTRL, COMMIT, 0);
+    write_msk[R_CXL_BI_DECODER_CTRL] = 0x7;
+
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_STATUS, COMMITTED, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_STATUS, ERR_NOT_COMMITTED, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_STATUS, COMMIT_TMO_SCALE, 0x6);
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_STATUS, COMMIT_TMO_BASE, 0x2);
+}
+
 void cxl_component_register_init_common(uint32_t *reg_state,
                                         uint32_t *write_msk,
-                                        enum reg_type type)
+                                        enum reg_type type,
+                                        bool bi)
 {
     int caps = 0;
 
@@ -325,7 +434,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
     case CXL2_LOGICAL_DEVICE:
         /* + HDM */
         init_cap_reg(HDM, 5, 1);
-        hdm_init_common(reg_state, write_msk, type);
+        hdm_init_common(reg_state, write_msk, type, bi);
         /* fallthrough */
     case CXL2_DOWNSTREAM_PORT:
     case CXL2_DEVICE:
@@ -340,6 +449,26 @@ void cxl_component_register_init_common(uint32_t *reg_state,
         abort();
     }
 
+    /* back invalidate */
+    switch (type) {
+    case CXL2_UPSTREAM_PORT:
+        init_cap_reg(BI_RT, 11, CXL_BI_RT_CAP_VERSION);
+        bi_rt_init_common(reg_state, write_msk);
+        break;
+    case CXL2_ROOT_PORT:
+    case CXL2_DOWNSTREAM_PORT:
+    case CXL2_TYPE3_DEVICE:
+        if (type == CXL2_TYPE3_DEVICE && !bi)  {
+            break;
+        }
+
+        init_cap_reg(BI_DECODER, 12, CXL_BI_DECODER_CAP_VERSION);
+        bi_decoder_init_common(reg_state, write_msk, type);
+        break;
+    default:
+        break;
+    }
+
     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
 #undef init_cap_reg
 }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 891b75618892..cac69adf6b76 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -969,6 +969,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         return false;
     }
 
+    if (!ct3d->flitmode && ct3d->hdmdb) {
+        error_setg(errp, "hdm-db requires operating in 256b flit");
+        return false;
+    }
+
     if (ct3d->hostvmem) {
         MemoryRegion *vmr;
         char *v_name;
@@ -1504,7 +1509,8 @@ void ct3d_reset(DeviceState *dev)
 
     pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed,
                               ct3d->flitmode);
-    cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
+    cxl_component_register_init_common(reg_state, write_msk,
+                                       CXL2_TYPE3_DEVICE, ct3d->hdmdb);
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
@@ -1544,6 +1550,7 @@ static const Property ct3_props[] = {
                                 width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_BOOL("x-256b-flit", CXLType3Dev, flitmode, false),
     DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0),
+    DEFINE_PROP_BOOL("hdm-db", CXLType3Dev, hdmdb, false),
 };
 
 static uint64_t get_lsa_size(CXLType3Dev *ct3d)
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index f8d64263ac08..e0593e783803 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -42,7 +42,7 @@ static void latch_registers(CXLDownstreamPort *dsp)
     uint32_t *write_msk = dsp->cxl_cstate.crb.cache_mem_regs_write_mask;
 
     cxl_component_register_init_common(reg_state, write_msk,
-                                       CXL2_DOWNSTREAM_PORT);
+                                       CXL2_DOWNSTREAM_PORT, false);
 }
 
 /* TODO: Look at sharing this code across all CXL port types */
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index f3472f081707..1c0087d3f111 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -106,7 +106,8 @@ static void latch_registers(CXLRootPort *crp)
     uint32_t *reg_state = crp->cxl_cstate.crb.cache_mem_registers;
     uint32_t *write_msk = crp->cxl_cstate.crb.cache_mem_regs_write_mask;
 
-    cxl_component_register_init_common(reg_state, write_msk, CXL2_ROOT_PORT);
+    cxl_component_register_init_common(reg_state, write_msk,
+                                       CXL2_ROOT_PORT, false);
 }
 
 static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index e5a0d1fb308c..4bc185df8c87 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -136,7 +136,7 @@ static void latch_registers(CXLUpstreamPort *usp)
     uint32_t *write_msk = usp->cxl_cstate.crb.cache_mem_regs_write_mask;
 
     cxl_component_register_init_common(reg_state, write_msk,
-                                       CXL2_UPSTREAM_PORT);
+                                       CXL2_UPSTREAM_PORT, false);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT, 8);
 }
 
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 3a29dfefc2c3..a8f7bf68f1d2 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -302,7 +302,7 @@ static void pxb_cxl_dev_reset(DeviceState *dev)
     uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
     int dsp_count = 0;
 
-    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC);
+    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC, false);
     /*
      * The CXL specification allows for host bridges with no HDM decoders
      * if they only have a single root port.
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index cd92cb02532a..0ff9f5b0fddf 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -67,6 +67,8 @@ CXLx_CAPABILITY_HEADER(LINK, 2)
 CXLx_CAPABILITY_HEADER(HDM, 3)
 CXLx_CAPABILITY_HEADER(EXTSEC, 4)
 CXLx_CAPABILITY_HEADER(SNOOP, 5)
+CXLx_CAPABILITY_HEADER(BI_RT, 6)
+CXLx_CAPABILITY_HEADER(BI_DECODER, 7)
 
 /*
  * Capability structures contain the actual registers that the CXL component
@@ -211,10 +213,55 @@ HDM_DECODER_INIT(3);
     (CXL_IDE_REGISTERS_OFFSET + CXL_IDE_REGISTERS_SIZE)
 #define CXL_SNOOP_REGISTERS_SIZE   0x8
 
-QEMU_BUILD_BUG_MSG((CXL_SNOOP_REGISTERS_OFFSET +
-                    CXL_SNOOP_REGISTERS_SIZE) >= 0x1000,
+#define CXL_BI_RT_CAP_VERSION 1
+#define CXL_BI_RT_REGISTERS_OFFSET \
+    (CXL_SNOOP_REGISTERS_OFFSET + CXL_SNOOP_REGISTERS_SIZE)
+#define CXL_BI_RT_REGISTERS_SIZE   0xC
+
+REG32(CXL_BI_RT_CAPABILITY, CXL_BI_RT_REGISTERS_OFFSET)
+    FIELD(CXL_BI_RT_CAPABILITY, EXPLICIT_COMMIT, 0, 1)
+REG32(CXL_BI_RT_CTRL, CXL_BI_RT_REGISTERS_OFFSET + 0x4)
+    FIELD(CXL_BI_RT_CTRL, COMMIT, 0, 1)
+REG32(CXL_BI_RT_STATUS, CXL_BI_RT_REGISTERS_OFFSET + 0x8)
+    FIELD(CXL_BI_RT_STATUS, COMMITTED, 0, 1)
+    FIELD(CXL_BI_RT_STATUS, ERR_NOT_COMMITTED, 1, 1)
+    FIELD(CXL_BI_RT_STATUS, COMMIT_TMO_SCALE, 8, 4)
+    FIELD(CXL_BI_RT_STATUS, COMMIT_TMO_BASE, 12, 4)
+
+/* CXL r3.2 8.2.4.27 - CXL BI Decoder Capability Structure */
+#define CXL_BI_DECODER_CAP_VERSION 1
+#define CXL_BI_DECODER_REGISTERS_OFFSET \
+    (CXL_BI_RT_REGISTERS_OFFSET + CXL_BI_RT_REGISTERS_SIZE)
+#define CXL_BI_DECODER_REGISTERS_SIZE   0xC
+
+REG32(CXL_BI_DECODER_CAPABILITY, CXL_BI_DECODER_REGISTERS_OFFSET)
+    FIELD(CXL_BI_DECODER_CAPABILITY, HDM_D, 0, 1)
+    FIELD(CXL_BI_DECODER_CAPABILITY, EXPLICIT_COMMIT, 1, 1)
+REG32(CXL_BI_DECODER_CTRL, CXL_BI_DECODER_REGISTERS_OFFSET + 0x4)
+    FIELD(CXL_BI_DECODER_CTRL, BI_FW, 0, 1)
+    FIELD(CXL_BI_DECODER_CTRL, BI_ENABLE, 1, 1)
+    FIELD(CXL_BI_DECODER_CTRL, COMMIT, 2, 1)
+REG32(CXL_BI_DECODER_STATUS, CXL_BI_DECODER_REGISTERS_OFFSET + 0x8)
+    FIELD(CXL_BI_DECODER_STATUS, COMMITTED, 0, 1)
+    FIELD(CXL_BI_DECODER_STATUS, ERR_NOT_COMMITTED, 1, 1)
+    FIELD(CXL_BI_DECODER_STATUS, COMMIT_TMO_SCALE, 8, 4)
+    FIELD(CXL_BI_DECODER_STATUS, COMMIT_TMO_BASE, 12, 4)
+
+QEMU_BUILD_BUG_MSG((CXL_BI_DECODER_REGISTERS_OFFSET +
+                    CXL_BI_DECODER_REGISTERS_SIZE) >= 0x1000,
                    "No space for registers");
 
+/* track BI explicit commit handling for route table and decoder */
+enum {
+    CXL_BISTATE_RT = 0,
+    CXL_BISTATE_DECODER,
+    CXL_BISTATE_MAX
+};
+
+typedef struct bi_state {
+    uint64_t last_commit;  /* last 0->1 transition */
+} BIState;
+
 typedef struct component_registers {
     /*
      * Main memory region to be registered with QEMU core.
@@ -260,6 +307,7 @@ typedef struct cxl_component {
 
     CDATObject cdat;
     CXLCompObject compliance;
+    BIState bi_state[CXL_BISTATE_MAX];
 } CXLComponentState;
 
 void cxl_component_register_block_init(Object *obj,
@@ -267,7 +315,7 @@ void cxl_component_register_block_init(Object *obj,
                                        const char *type);
 void cxl_component_register_init_common(uint32_t *reg_state,
                                         uint32_t *write_msk,
-                                        enum reg_type type);
+                                        enum reg_type type, bool bi);
 
 void cxl_component_create_dvsec(CXLComponentState *cxl_cstate,
                                 enum reg_type cxl_dev_type, uint16_t length,
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 0abfd678b875..75603b8180b5 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -841,6 +841,9 @@ struct CXLType3Dev {
     CXLMemSparingReadAttrs rank_sparing_attrs;
     CXLMemSparingWriteAttrs rank_sparing_wr_attrs;
 
+    /* BI flows */
+    bool hdmdb;
+
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
         AddressSpace host_dc_as;
-- 
2.39.5

