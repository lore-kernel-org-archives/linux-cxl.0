Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.90.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008459;
	b=vSTwxkK78rOBVjRB+UUaV0a9RWIH+BAhMUzLHdr98/qXS84FoyEpVjd3E7w8ZcoNHwcs
	 MZ1xQHKKEg+6HxC4kMQXQIbZJZzfX+EmS8L64lnMUThY8pIXaDSinV2ypReZuUbO82kob
	 5zRJZTR70ligoLxBdR5N3a1uWwGw5eOaT7jwO/TJR7FLZsOEgt7QZ5i5fJ6BEO1Ll5EtT
	 fRZ35VIymkv/vJWK3VUy0wai4vu+0kFaYutE0nEogakVfpu7a7soidsJPDkkJcwNyZw/m
	 bHShpN0Ykdzf9aTRloLsR3k6t7HAJSAWAd5O103kKf13ws1GAiSk5+GV79WnSfOlp0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008459;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ekbeFNQZH2lTXrOWvMGo8eYksN7lsrG6Xfp33htCj7Q=;
	b=KFNNq3DGX/qR/HOuoBT0JHVhyYBvn/Yk6JwQb/QJmanhYrTIIq3TufcJ5ny2OOOHypPo
	 VEabeQ8/TMeQqzH0hHT2YGLoheaV2kXvy5d4gP8AZKHgfsRrE4B00v62BmhuVf95gzoCo
	 tWp2MhU5Q2a/bqJAAVHb8C+x0JynUAQ+GhAuqJW37G74dI+z75dY4MGotMAqiqXHt4cGA
	 mmIgdUjuhgw+XgcIP2wc4NjWHYG47W6OOMYAWexqBy+I3gQSmujlknRHDBppZqyTJLggx
	 3BXXinHTw/sBxFL1DfS/n0ThtbEgWqh/W7q1I94lojUKO3poikawQjAMm3maIGviytw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=WLIvpVWR;
	arc=none smtp.remote-ip=207.54.90.49
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1622A606A31D
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1622A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=WLIvpVWR
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1793008459; x=1824544459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6z8lEk1AeWECdTspXda6U7FgVtrO8TNGfV5ZPDt7sUE=;
  b=WLIvpVWRoHzVPxS8BcvJ2SScucChBzlOBmGePzZLNzWiHDenJ0Cl1m8Q
   3gCF3LF4eF28b5C6SU0lrgDaXJXeQN4e9Pi5DXukXxnis3BJvQY2z/HuG
   dz8R3Ef35PwsqiK4UtWglZADb86wGaGVMWF5rUCCru78rL+C0Wp41FTFJ
   x8zuRwNKAOlYiYBJtARL9k3UMxAOYDy89h6tUk4e/eREgjB+Latn8DND6
   Noki+MmLpDXllMDH//bhjWu1ATNDJSigQRiP9DOn1Ky+sV7Ivo0E4Yulj
   c+dguuz/cZwZeCdsW84zwiZ797LLYKcxo3cG2qu9RcjAOwTLDHGXlH8nh
   Q==;
X-CSE-ConnectionGUID: HtrGT7kgQcWqu6XwdXWXRw==
X-CSE-MsgGUID: Z8SUpMRlRvW8NI2IXE5x4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="259392325"
X-IronPort-AV: E=Sophos;i="6.27,179,1786978800"; 
   d="scan'208";a="259392325"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 18:54:17 +0900
Received: from az2nlsmgm1.o.css.fujitsu.com (unknown [10.150.26.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 4641842A325
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:16 +0000 (UTC)
Received: from m3003.s.css.fujitsu.com (unknown [10.128.233.114])
	by az2nlsmgm1.o.css.fujitsu.com (Postfix) with ESMTP id B23B8C013C4
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:15 +0000 (UTC)
Received: from tanjiro.soft.fujitsu.com (unknown [10.118.236.61])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 61058202EBDE;
	Mon, 26 Oct 2026 18:54:14 +0900 (JST)
From: Yukiya Takaki <fj2110jc@fujitsu.com>
To: qemu-devel@nongnu.org
Cc: Yukiya Takaki <fj2110jc@fujitsu.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Anisa Su <anisa.su@samsung.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Junjie Cao <junjie.cao@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	linux-cxl@vger.kernel.org,
	qemu-arm@nongnu.org,
	"Wolski, Tomasz" <tomasz.wolski@fujitsu.com>,
	lizhijian@fujitsu.com,
	y-goto@fujitsu.com,
	yukiya.takaki@gmail.com
Subject: [PATCH RFC 5/7] QEMU/hw/cxl: expose CXL Type 3 ranges as E820_SOFT_RESERVED on x86
Date: Mon, 26 Oct 2026 19:03:26 +0900
Message-ID: <06c1447e554c2b353c029d0e0c0ef6dd38c46e41.1793003983.git.fj2110jc@fujitsu.com>
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

On real systems, CXL Type 3 memory is exposed to the OS via the E820
table as E820_SOFT_RESERVED, so the kernel can treat it as a dedicated
reserved range rather than normal RAM.

This patch adds a small helper and a recursive walker so that, on x86,
the HPA ranges assigned to CXL Type 3 devices are added to the E820 table
as E820_SOFT_RESERVED when `program_hdm_decoder` is enabled. An ARM stub
is also added as a placeholder for future support.

Signed-off-by: Yukiya Takaki <fj2110jc@fujitsu.com>
---
 hw/arm/cxl.c              | 10 ++++++++++
 hw/arm/meson.build        |  2 ++
 hw/cxl/cxl-host.c         | 25 +++++++++++++++++++++++++
 hw/i386/cxl.c             | 11 +++++++++++
 hw/i386/meson.build       |  1 +
 hw/i386/pc.c              |  1 +
 include/hw/cxl/cxl_host.h |  2 ++
 7 files changed, 52 insertions(+)
 create mode 100644 hw/arm/cxl.c
 create mode 100644 hw/i386/cxl.c

diff --git a/hw/arm/cxl.c b/hw/arm/cxl.c
new file mode 100644
index 0000000000..1cbcf2d8e5
--- /dev/null
+++ b/hw/arm/cxl.c
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "exec/hwaddr.h"
+#include "hw/cxl/cxl_host.h"
+
+void cxl_c3_add_memory_map(hwaddr base, hwaddr size)
+{
+    /* TODO: Implement memory map addition for CXL Type 3 on ARM */
+}
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index bcc068de04..2a4f09fbef 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -116,6 +116,8 @@ arm_common_ss.add(when: ['CONFIG_AXIADO_EVK', 'TARGET_AARCH64'], if_true: files(
   'ax3000-boards.c',
   'ax3000-evk.c'))
 
+arm_common_ss.add(when: 'CONFIG_CXL', if_true: files('cxl.c'))
+
 arm_common_ss.add(files('boot.c'))
 
 hw_common_arch += {'arm': arm_common_ss}
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index e279ce5fe3..1967c9a9c3 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -689,12 +689,37 @@ static int cxl_fmws_mmio_map(Object *obj, void *opaque)
     return 0;
 }
 
+static int cxl_c3_mmio_map(Object *obj, void *opaque)
+{
+    uint64_t base, size;
+    CXLType3Dev *c3d;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        return 0;
+    }
+    c3d = CXL_TYPE3(obj);
+
+    if (!c3d->program_hdm_decoder) {
+        return 0;
+    }
+
+    ct3_type3_get_hpm_range(c3d, &base, &size);
+    cxl_c3_add_memory_map(base, size);
+
+    return 0;
+}
+
 void cxl_fmws_update_mmio(void)
 {
     /* Ordering is not required for this */
     object_child_foreach_recursive(object_get_root(), cxl_fmws_mmio_map, NULL);
 }
 
+void cxl_c3_update_mmio(void)
+{
+    object_child_foreach_recursive(object_get_root(), cxl_c3_mmio_map, NULL);
+}
+
 hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
 {
     GSList *cfmws_list, *iter;
diff --git a/hw/i386/cxl.c b/hw/i386/cxl.c
new file mode 100644
index 0000000000..02dbe4d3f0
--- /dev/null
+++ b/hw/i386/cxl.c
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "exec/hwaddr.h"
+#include "hw/cxl/cxl_host.h"
+#include "hw/i386/e820_memory_layout.h"
+
+void cxl_c3_add_memory_map(hwaddr base, hwaddr size)
+{
+    e820_add_entry(base, size, E820_SOFT_RESERVED);
+}
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index e16930c431..b212b3f6fa 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -24,6 +24,7 @@ i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
 i386_ss.add(when: 'CONFIG_VTD_ACCEL', if_true: files('intel_iommu_accel.c'))
 i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
                                 if_false: files('sgx-stub.c'))
+i386_ss.add(when: 'CONFIG_CXL', if_true: files('cxl.c'))
 if have_hmp
   stub_ss.add(files('sgx-hmp-stub.c'))
 endif
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2d8c87b0e3..f843629543 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -534,6 +534,7 @@ void pc_machine_done(Notifier *notifier, void *data)
 
     if (pcms->cxl_devices_state.is_enabled) {
         cxl_fmws_link_targets(&error_fatal);
+        cxl_c3_update_mmio();
     }
 
     /* set the number of CPUs */
diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
index 21619bb748..6c142a5b89 100644
--- a/include/hw/cxl/cxl_host.h
+++ b/include/hw/cxl/cxl_host.h
@@ -18,6 +18,8 @@ void cxl_fmws_link_targets(Error **errp);
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
 hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr);
 void cxl_fmws_update_mmio(void);
+void cxl_c3_update_mmio(void);
+void cxl_c3_add_memory_map(hwaddr base, hwaddr size);
 GSList *cxl_fmws_get_all_sorted(void);
 
 extern const MemoryRegionOps cfmws_ops;
-- 
2.52.0

