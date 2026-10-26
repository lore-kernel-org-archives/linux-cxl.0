Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.90.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008467;
	b=JObGuqSTxUDdNJRsOkyb6xOW/iugBh4pgmVqGnqqC7saCfYffNGKq2A1C/jlVUrBpNNk
	 M0wtDNLsDAQGa46SaaylG3u+yjwWGP0xYFWn12Z6MhBSqLukOvGFLItpeEkDnoJCgzWkV
	 RJ+nybN0SZxHuSYFoc4xjLS3kSn9HuFfdBk99xtEO7i4++zfYH0hGvzq4FyaENwGMKvzw
	 WhQlA9NBVMyRB6g/W8ws2tUdpnTDvrZurq4lEFgeSywFc73rtuLL6GEdrJYR0SIBPYq3/
	 CCPMRUH+SmO4ufayTMNkogeqrUJbyJJ6AV5a3hpGoATEfuCYE5OMOGiBlHXE5KC8KKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008467;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lmVQfXYIzgB6L0ACcyKETNWaJF23xJdhHwPP0NjJAVw=;
	b=GjD7uFLxEQ1kbqwiU4x+W/iicyB+XrzBOynO51EoqtSRWszXGOEaEBv3+85+jTn60v3G
	 vrfZ5FZcbtaQrXyXZkOP2KHgEhV6fF00jIUHaC7dn1reSFPIMwxc7YCSf2V9+29n5PF1j
	 KMd86pdZGMDsIREQFrQXh5aAoDXYeIUKlRId/N5xNxIqpEOQVyupRHRknRp+zeppzO5zS
	 X1Z10IeOnQ/DrlewZaJNwBrwDMiOdbCbT8hAtZM//3zlyc07mZFKUOc4vQ4pkJrlBSeqF
	 8wehvy63V3HC1oEBwNhDYZ6XbYLBbL4+OF4DKGf/wQXNcoie/XXGm5Dgv2AaEZWasOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=cwMoebts;
	arc=none smtp.remote-ip=207.54.90.47
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABE0606A32E
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ABE0606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=cwMoebts
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1793008466; x=1824544466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zik1LQCP4muzbLl4LIyGNKML35lWt8i7n3q+ukChy+c=;
  b=cwMoebtsP3dPuDPUp5fc5NSEz8LU4uUBHRUYTgd/eb2lM2YSV7EOIIXK
   Ag5wO00NbW+EwYWC6IoAbJ3CWzn93hgWsSmfBUCfOj+KsD9/CxszOgjx/
   P4fhni4d5tXyHnpwgEpJxFRSyR7b+v+kz4kiCcGEw//mB9FIAVF8uYIuo
   KYIyr9h5bpzqpfbH1o1zIesloYAEScWBgc3rfS/+JuhNVuGrtPkdIqhHB
   NrekuleQ+5MLUORJxs5WF+x3LPYtVa02qt1XaM2jJufS7CygxCtz7oUzJ
   gSYFtHHkWgVumHaeuhNPnQIFiBF8sk8k9Cl/gFvQKuKb4NB+2aGPPqzfv
   w==;
X-CSE-ConnectionGUID: vOH+iPLhSIqh8mVEMrTvIQ==
X-CSE-MsgGUID: oBXWMusvQiCfTAioikbOsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="259465459"
X-IronPort-AV: E=Sophos;i="6.27,179,1786978800"; 
   d="scan'208";a="259465459"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 18:54:18 +0900
Received: from az2uksmgm4.o.css.fujitsu.com (unknown [10.151.22.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 5412FC00408
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:18 +0000 (UTC)
Received: from m3003.s.css.fujitsu.com (unknown [10.128.233.114])
	by az2uksmgm4.o.css.fujitsu.com (Postfix) with ESMTP id BBA7D14003E1
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:17 +0000 (UTC)
Received: from tanjiro.soft.fujitsu.com (unknown [10.118.236.61])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 78101202EBDE;
	Mon, 26 Oct 2026 18:54:16 +0900 (JST)
From: Yukiya Takaki <fj2110jc@fujitsu.com>
To: qemu-devel@nongnu.org
Cc: Yukiya Takaki <fj2110jc@fujitsu.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Anisa Su <anisa.su@samsung.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Junjie Cao <junjie.cao@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	linux-cxl@vger.kernel.org,
	"Wolski, Tomasz" <tomasz.wolski@fujitsu.com>,
	lizhijian@fujitsu.com,
	y-goto@fujitsu.com,
	yukiya.takaki@gmail.com
Subject: [PATCH RFC 6/7] QEMU/hw/cxl: Create NUMA nodes for CXL Type 3 memory
Date: Mon, 26 Oct 2026 19:03:27 +0900
Message-ID: <a6789d2cbcbc7a4543ee7781173e189171199b91.1793003983.git.fj2110jc@fujitsu.com>
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
Content-Transfer-Encoding: 8bit

On the actual hardware, CXL memory is exposed to the OS as a "Memory Only Node."
This allows the OS to recognize that accessing CXL memory takes time.
As a preliminary step, a function was created to automatically add a NUMA node for each instance of CXL memory.
This function generates one NUMA node per instance of CXL memory.
This function is executed when program_hdm_decoder is set.

Signed-off-by: Yukiya Takaki <fj2110jc@fujitsu.com>
---
 hw/cxl/cxl-host.c           | 38 +++++++++++++++++++++++++++++++++++++
 hw/i386/pc.c                |  1 +
 include/hw/cxl/cxl_device.h |  1 +
 include/hw/cxl/cxl_host.h   |  1 +
 4 files changed, 41 insertions(+)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 1967c9a9c3..ba321841dc 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -720,6 +720,44 @@ void cxl_c3_update_mmio(void)
     object_child_foreach_recursive(object_get_root(), cxl_c3_mmio_map, NULL);
 }
 
+static int setup_cxl_numa_node_inner(Object *obj, void *opaque)
+{
+    MachineState *machine = opaque;
+    DeviceState *dev;
+    CXLType3Dev *c3d;
+    int node_id;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        return 0;
+    }
+
+    dev = DEVICE(obj);
+    c3d = CXL_TYPE3(dev);
+    node_id = machine->numa_state->num_nodes;
+
+    if (!c3d->program_hdm_decoder) {
+        return 0;
+    }
+
+    NumaOptions option = {
+        .type = NUMA_OPTIONS_TYPE_NODE,
+        .u.node = {
+            .has_nodeid = true,
+            .nodeid = node_id,
+        },
+    };
+
+    set_numa_options(machine, &option, &error_fatal);
+    c3d->node = node_id;
+    return 0;
+}
+
+void setup_cxl_numa_node(MachineState *machine)
+{
+    object_child_foreach_recursive(object_get_root(),
+                                   setup_cxl_numa_node_inner, machine);
+}
+
 hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
 {
     GSList *cfmws_list, *iter;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f843629543..b1d1f03468 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -534,6 +534,7 @@ void pc_machine_done(Notifier *notifier, void *data)
 
     if (pcms->cxl_devices_state.is_enabled) {
         cxl_fmws_link_targets(&error_fatal);
+        setup_cxl_numa_node(MACHINE(pcms));
         cxl_c3_update_mmio();
     }
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 07654f4b62..9001aacf0e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -780,6 +780,7 @@ struct CXLType3Dev {
     bool program_hdm_decoder;
     hwaddr hpa_offset;
     int idx;
+    int node;
 
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
index 6c142a5b89..70285328c4 100644
--- a/include/hw/cxl/cxl_host.h
+++ b/include/hw/cxl/cxl_host.h
@@ -19,6 +19,7 @@ void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
 hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr);
 void cxl_fmws_update_mmio(void);
 void cxl_c3_update_mmio(void);
+void setup_cxl_numa_node(MachineState *machine);
 void cxl_c3_add_memory_map(hwaddr base, hwaddr size);
 GSList *cxl_fmws_get_all_sorted(void);
 
-- 
2.52.0

