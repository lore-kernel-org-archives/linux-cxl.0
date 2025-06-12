Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC081BC2A
	for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749735888; cv=none; b=lt1i7Eh/8iLIw7UJfz4/5NiiZOvYO7uiixu9xmxxpcc+ty9vi/8eOrcEx8gbwcOgGrht6BcHhrnDb4oHkqOtVsdtojqYQ4xke7gor8Ztdpsvlptczypx7bfar6KUfCg8m3TfGN1sslA1wnzfDQDAsvS5emCkkPiM8iEg+7uZ+54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749735888; c=relaxed/simple;
	bh=VpdB7v43WADbQl1CXVeL8ixMf9+Nbe554bDmCgZGsvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oY/sIMw2yqmILBnvhB1mIW1PjphUSdN1D+JS4GWYQ4iRi2IXcOvqzwsgJuW8xe9a/b1H/wme3Xk/YH6gW4upH4onHhuUX6mRNXWAaLQSJXuH9/L5ZCN3o+iUM/zJJgtNha6kTPU28nwR4NtsiI/7ohjut4uJ9FSC51dotfxe4Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ3cl1kRrz6K98L;
	Thu, 12 Jun 2025 21:42:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BF6121402CB;
	Thu, 12 Jun 2025 21:44:42 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Jun 2025 15:44:42 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
	<peter.maydell@linaro.org>, <mst@redhat.com>, Zhijian Li
	<lizhijian@fujitsu.com>, Itaru Kitayama <itaru.kitayama@linux.dev>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Alireza Sanaee
	<alireza.sanaee@huawei.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
	<alex.bennee@linaro.org>
Subject: [PATCH v15 2/4] hw/cxl: Make the CXL fixed memory windows devices.
Date: Thu, 12 Jun 2025 14:43:36 +0100
Message-ID: <20250612134338.1871023-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

Previously these somewhat device like structures were tracked using a list
in the CXLState in each machine. This is proving restrictive in a few
cases where we need to iterate through these without being aware of the
machine type. Just make them sysbus devices.

Restrict them to not user created as they need to be visible to early
stages of machine init given effects on the memory map.

This change both simplifies state tracking and enables features needed
for performance optimization and hotness tracking by making it possible
to retrieve the fixed memory window on actions elsewhere in the topology.

In some cases the ordering of the Fixed Memory Windows matters.
For those utility functions provide a GSList sorted by the window index.
This ensures that we get consistency across:
- ordering in the command line
- ordering of the host PA ranges
- ordering of ACPI CEDT structures describing the CFMWS.

Other aspects don't have this constraint. For those direct iteration
of the underlying hash structures is fine.

In the setup path for the memory map in pc_memory_init() split the
operations into two calls. The first, cxl_fmws_set_mmemap(), loops over
fixed memory windows in order and assigns their addresses.  The second,
cxl_fmws_update_mmio() actually sets up the mmio for each window.
This is obviously less efficient than a single loop but this split design
is needed to put the logic in two different places in the arm64 support
and it is not a hot enough path to justify an x86 only implementation.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v15: Drop the left over GList *fixed_windows from CXLState.
     Spit cxl_fmws_set_memmap_and_update_mmio() in to remove
     need to do this in next patch. Patch description now has a
     paragraph justifying this design decision. (thanks Zhijian Li
     for suggesting it).
     Dropped tags as this is a non trivial change.

I think Peter Maydell suggested this a long time back when
the original CXL support series was under review but not 100% sure.
---
 include/hw/cxl/cxl.h      |   4 +-
 include/hw/cxl/cxl_host.h |   5 +-
 hw/acpi/cxl.c             |  76 +++++++++---------
 hw/cxl/cxl-host-stubs.c   |   7 +-
 hw/cxl/cxl-host.c         | 163 +++++++++++++++++++++++++++++++-------
 hw/i386/pc.c              |  50 +++++-------
 6 files changed, 210 insertions(+), 95 deletions(-)

diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index b2bcce7ed6..de66ab8c35 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -27,6 +27,7 @@
 typedef struct PXBCXLDev PXBCXLDev;
 
 typedef struct CXLFixedWindow {
+    SysBusDevice parent_obj;
     int index;
     uint64_t size;
     char **targets;
@@ -38,12 +39,13 @@ typedef struct CXLFixedWindow {
     MemoryRegion mr;
     hwaddr base;
 } CXLFixedWindow;
+#define TYPE_CXL_FMW "cxl-fmw"
+OBJECT_DECLARE_SIMPLE_TYPE(CXLFixedWindow, CXL_FMW)
 
 typedef struct CXLState {
     bool is_enabled;
     MemoryRegion host_mr;
     unsigned int next_mr_idx;
-    GList *fixed_windows;
     CXLFixedMemoryWindowOptionsList *cfmw_list;
 } CXLState;
 
diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
index c9bc9c7c50..cd3c368c86 100644
--- a/include/hw/cxl/cxl_host.h
+++ b/include/hw/cxl/cxl_host.h
@@ -14,8 +14,11 @@
 #define CXL_HOST_H
 
 void cxl_machine_init(Object *obj, CXLState *state);
-void cxl_fmws_link_targets(CXLState *stat, Error **errp);
+void cxl_fmws_link_targets(Error **errp);
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
+hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr);
+void cxl_fmws_update_mmio(void);
+GSList *cxl_fmws_get_all_sorted(void);
 
 extern const MemoryRegionOps cfmws_ops;
 
diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 9cd7905ea2..75d5b30bb8 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -22,6 +22,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
 #include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_host.h"
 #include "hw/mem/memory-device.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
@@ -135,55 +136,52 @@ static void cedt_build_chbs(GArray *table_data, PXBCXLDev *cxl)
  * Interleave ways encoding in CXL 2.0 ECN: 3, 6, 12 and 16-way memory
  * interleaving.
  */
-static void cedt_build_cfmws(GArray *table_data, CXLState *cxls)
+static void cedt_build_cfmws(CXLFixedWindow *fw, Aml *cedt)
 {
-    GList *it;
+    GArray *table_data = cedt->buf;
+    int i;
 
-    for (it = cxls->fixed_windows; it; it = it->next) {
-        CXLFixedWindow *fw = it->data;
-        int i;
-
-        /* Type */
-        build_append_int_noprefix(table_data, 1, 1);
+    /* Type */
+    build_append_int_noprefix(table_data, 1, 1);
 
-        /* Reserved */
-        build_append_int_noprefix(table_data, 0, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 1);
 
-        /* Record Length */
-        build_append_int_noprefix(table_data, 36 + 4 * fw->num_targets, 2);
+    /* Record Length */
+    build_append_int_noprefix(table_data, 36 + 4 * fw->num_targets, 2);
 
-        /* Reserved */
-        build_append_int_noprefix(table_data, 0, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
 
-        /* Base HPA */
-        build_append_int_noprefix(table_data, fw->mr.addr, 8);
+    /* Base HPA */
+    build_append_int_noprefix(table_data, fw->mr.addr, 8);
 
-        /* Window Size */
-        build_append_int_noprefix(table_data, fw->size, 8);
+    /* Window Size */
+    build_append_int_noprefix(table_data, fw->size, 8);
 
-        /* Host Bridge Interleave Ways */
-        build_append_int_noprefix(table_data, fw->enc_int_ways, 1);
+    /* Host Bridge Interleave Ways */
+    build_append_int_noprefix(table_data, fw->enc_int_ways, 1);
 
-        /* Host Bridge Interleave Arithmetic */
-        build_append_int_noprefix(table_data, 0, 1);
+    /* Host Bridge Interleave Arithmetic */
+    build_append_int_noprefix(table_data, 0, 1);
 
-        /* Reserved */
-        build_append_int_noprefix(table_data, 0, 2);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
 
-        /* Host Bridge Interleave Granularity */
-        build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
+    /* Host Bridge Interleave Granularity */
+    build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
 
-        /* Window Restrictions */
-        build_append_int_noprefix(table_data, 0x0f, 2); /* No restrictions */
+    /* Window Restrictions */
+    build_append_int_noprefix(table_data, 0x0f, 2);
 
-        /* QTG ID */
-        build_append_int_noprefix(table_data, 0, 2);
+    /* QTG ID */
+    build_append_int_noprefix(table_data, 0, 2);
 
-        /* Host Bridge List (list of UIDs - currently bus_nr) */
-        for (i = 0; i < fw->num_targets; i++) {
-            g_assert(fw->target_hbs[i]);
-            build_append_int_noprefix(table_data, PXB_DEV(fw->target_hbs[i])->bus_nr, 4);
-        }
+    /* Host Bridge List (list of UIDs - currently bus_nr) */
+    for (i = 0; i < fw->num_targets; i++) {
+        g_assert(fw->target_hbs[i]);
+        build_append_int_noprefix(table_data,
+                                  PXB_DEV(fw->target_hbs[i])->bus_nr, 4);
     }
 }
 
@@ -202,6 +200,7 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
                     BIOSLinker *linker, const char *oem_id,
                     const char *oem_table_id, CXLState *cxl_state)
 {
+    GSList *cfmws_list, *iter;
     Aml *cedt;
     AcpiTable table = { .sig = "CEDT", .rev = 1, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
@@ -213,7 +212,12 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
     /* reserve space for CEDT header */
 
     object_child_foreach_recursive(object_get_root(), cxl_foreach_pxb_hb, cedt);
-    cedt_build_cfmws(cedt->buf, cxl_state);
+
+    cfmws_list = cxl_fmws_get_all_sorted();
+    for (iter = cfmws_list; iter; iter = iter->next) {
+        cedt_build_cfmws(CXL_FMW(iter->data), cedt);
+    }
+    g_slist_free(cfmws_list);
 
     /* copy AML table into ACPI tables blob and patch header there */
     g_array_append_vals(table_data, cedt->buf->data, cedt->buf->len);
diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
index cae4afcdde..c015baac81 100644
--- a/hw/cxl/cxl-host-stubs.c
+++ b/hw/cxl/cxl-host-stubs.c
@@ -8,8 +8,13 @@
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
 
-void cxl_fmws_link_targets(CXLState *stat, Error **errp) {};
+void cxl_fmws_link_targets(Error **errp) {};
 void cxl_machine_init(Object *obj, CXLState *state) {};
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp) {};
+hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
+{
+    return base;
+};
+void cxl_fmws_update_mmio(void) {};
 
 const MemoryRegionOps cfmws_ops;
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index b7aa429ddf..5239555f6c 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -22,12 +22,12 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/pci-bridge/pci_expander_bridge.h"
 
-static void cxl_fixed_memory_window_config(CXLState *cxl_state,
-                                           CXLFixedMemoryWindowOptions *object,
+static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
                                            int index, Error **errp)
 {
     ERRP_GUARD();
-    g_autofree CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
+    DeviceState *dev = qdev_new(TYPE_CXL_FMW);
+    CXLFixedWindow *fw = CXL_FMW(dev);
     strList *target;
     int i;
 
@@ -67,35 +67,39 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
         fw->targets[i] = g_strdup(target->value);
     }
 
-    cxl_state->fixed_windows = g_list_append(cxl_state->fixed_windows,
-                                             g_steal_pointer(&fw));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp);
 }
 
-void cxl_fmws_link_targets(CXLState *cxl_state, Error **errp)
+static int cxl_fmws_link(Object *obj, void *opaque)
 {
-    if (cxl_state && cxl_state->fixed_windows) {
-        GList *it;
-
-        for (it = cxl_state->fixed_windows; it; it = it->next) {
-            CXLFixedWindow *fw = it->data;
-            int i;
-
-            for (i = 0; i < fw->num_targets; i++) {
-                Object *o;
-                bool ambig;
-
-                o = object_resolve_path_type(fw->targets[i],
-                                             TYPE_PXB_CXL_DEV,
-                                             &ambig);
-                if (!o) {
-                    error_setg(errp, "Could not resolve CXLFM target %s",
-                               fw->targets[i]);
-                    return;
-                }
-                fw->target_hbs[i] = PXB_CXL_DEV(o);
-            }
+    struct CXLFixedWindow *fw;
+    int i;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
+        return 0;
+    }
+    fw = CXL_FMW(obj);
+
+    for (i = 0; i < fw->num_targets; i++) {
+        Object *o;
+        bool ambig;
+
+        o = object_resolve_path_type(fw->targets[i], TYPE_PXB_CXL_DEV,
+                                     &ambig);
+        if (!o) {
+            error_setg(&error_fatal, "Could not resolve CXLFM target %s",
+                       fw->targets[i]);
+            return 1;
         }
+        fw->target_hbs[i] = PXB_CXL_DEV(o);
     }
+    return 0;
+}
+
+void cxl_fmws_link_targets(Error **errp)
+{
+    /* Order doesn't matter for this, so no need to build list */
+    object_child_foreach_recursive(object_get_root(), cxl_fmws_link, NULL);
 }
 
 static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
@@ -335,7 +339,7 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
     }
 
     for (it = cfmw_list, index = 0; it; it = it->next, index++) {
-        cxl_fixed_memory_window_config(state, it->value, index, errp);
+        cxl_fixed_memory_window_config(it->value, index, errp);
     }
     state->cfmw_list = cfmw_list;
 }
@@ -373,3 +377,106 @@ void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp)
         }
     }
 }
+
+static int cxl_fmws_find(Object *obj, void *opaque)
+{
+    GSList **list = opaque;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
+        return 0;
+    }
+    *list = g_slist_prepend(*list, obj);
+
+    return 0;
+}
+
+static GSList *cxl_fmws_get_all(void)
+{
+    GSList *list = NULL;
+
+    object_child_foreach_recursive(object_get_root(), cxl_fmws_find, &list);
+
+    return list;
+}
+
+static gint cfmws_cmp(gconstpointer a, gconstpointer b, gpointer d)
+{
+    const struct CXLFixedWindow *ap = a;
+    const struct CXLFixedWindow *bp = b;
+
+    return ap->index > bp->index;
+}
+
+GSList *cxl_fmws_get_all_sorted(void)
+{
+    return g_slist_sort_with_data(cxl_fmws_get_all(), cfmws_cmp, NULL);
+}
+
+static int cxl_fmws_mmio_map(Object *obj, void *opaque)
+{
+    struct CXLFixedWindow *fw;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
+        return 0;
+    }
+    fw = CXL_FMW(obj);
+    sysbus_mmio_map(SYS_BUS_DEVICE(fw), 0, fw->base);
+
+    return 0;
+}
+
+void cxl_fmws_update_mmio(void)
+{
+    /* Ordering is not required for this */
+    object_child_foreach_recursive(object_get_root(), cxl_fmws_mmio_map, NULL);
+}
+
+hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
+{
+    GSList *cfmws_list, *iter;
+    CXLFixedWindow *fw;
+
+    cfmws_list = cxl_fmws_get_all_sorted();
+    for (iter = cfmws_list; iter; iter = iter->next) {
+        fw = CXL_FMW(iter->data);
+        if (base + fw->size <= max_addr) {
+            fw->base = base;
+            base += fw->size;
+        }
+    }
+    g_slist_free(cfmws_list);
+
+    return base;
+}
+
+static void cxl_fmw_realize(DeviceState *dev, Error **errp)
+{
+    CXLFixedWindow *fw = CXL_FMW(dev);
+
+    memory_region_init_io(&fw->mr, OBJECT(dev), &cfmws_ops, fw,
+                          "cxl-fixed-memory-region", fw->size);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &fw->mr);
+}
+
+static void cxl_fmw_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "CXL Fixed Memory Window";
+    dc->realize = cxl_fmw_realize;
+    /* Reason - created by machines as tightly coupled to machine memory map */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo cxl_fmw_info = {
+    .name = TYPE_CXL_FMW,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(CXLFixedWindow),
+    .class_init = cxl_fmw_class_init,
+};
+
+static void cxl_host_register_types(void)
+{
+    type_register_static(&cxl_fmw_info);
+}
+type_init(cxl_host_register_types)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b211633575..860346d6b7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -609,7 +609,7 @@ void pc_machine_done(Notifier *notifier, void *data)
                               &error_fatal);
 
     if (pcms->cxl_devices_state.is_enabled) {
-        cxl_fmws_link_targets(&pcms->cxl_devices_state, &error_fatal);
+        cxl_fmws_link_targets(&error_fatal);
     }
 
     /* set the number of CPUs */
@@ -718,20 +718,28 @@ static uint64_t pc_get_cxl_range_start(PCMachineState *pcms)
     return cxl_base;
 }
 
-static uint64_t pc_get_cxl_range_end(PCMachineState *pcms)
+static int cxl_get_fmw_end(Object *obj, void *opaque)
 {
-    uint64_t start = pc_get_cxl_range_start(pcms) + MiB;
+    struct CXLFixedWindow *fw;
+    uint64_t *start = opaque;
 
-    if (pcms->cxl_devices_state.fixed_windows) {
-        GList *it;
-
-        start = ROUND_UP(start, 256 * MiB);
-        for (it = pcms->cxl_devices_state.fixed_windows; it; it = it->next) {
-            CXLFixedWindow *fw = it->data;
-            start += fw->size;
-        }
+    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
+        return 0;
     }
+    fw = CXL_FMW(obj);
+
+    *start += fw->size;
 
+    return 0;
+}
+
+static uint64_t pc_get_cxl_range_end(PCMachineState *pcms)
+{
+    uint64_t start = pc_get_cxl_range_start(pcms) + MiB;
+
+    /* Ordering doesn't matter so no need to build a sorted list */
+    object_child_foreach_recursive(object_get_root(), cxl_get_fmw_end,
+                                   &start);
     return start;
 }
 
@@ -933,23 +941,9 @@ void pc_memory_init(PCMachineState *pcms,
         cxl_base = pc_get_cxl_range_start(pcms);
         memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
         memory_region_add_subregion(system_memory, cxl_base, mr);
-        cxl_resv_end = cxl_base + cxl_size;
-        if (pcms->cxl_devices_state.fixed_windows) {
-            hwaddr cxl_fmw_base;
-            GList *it;
-
-            cxl_fmw_base = ROUND_UP(cxl_base + cxl_size, 256 * MiB);
-            for (it = pcms->cxl_devices_state.fixed_windows; it; it = it->next) {
-                CXLFixedWindow *fw = it->data;
-
-                fw->base = cxl_fmw_base;
-                memory_region_init_io(&fw->mr, OBJECT(machine), &cfmws_ops, fw,
-                                      "cxl-fixed-memory-region", fw->size);
-                memory_region_add_subregion(system_memory, fw->base, &fw->mr);
-                cxl_fmw_base += fw->size;
-                cxl_resv_end = cxl_fmw_base;
-            }
-        }
+        cxl_base = ROUND_UP(cxl_base + cxl_size, 256 * MiB);
+        cxl_resv_end = cxl_fmws_set_memmap(cxl_base, maxphysaddr);
+        cxl_fmws_update_mmio();
     }
 
     /* Initialize PC system firmware */
-- 
2.48.1

