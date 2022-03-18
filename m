Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6713C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Mar 2022 15:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbiCRPVk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Mar 2022 11:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237524AbiCRPVk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Mar 2022 11:21:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DE6200340
        for <linux-cxl@vger.kernel.org>; Fri, 18 Mar 2022 08:20:19 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KKnjm1z6Wz67yS4;
        Fri, 18 Mar 2022 23:19:24 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 18 Mar 2022 16:20:17 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 15:20:16 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v8 27/46] hw/cxl/host: Add support for CXL Fixed Memory Windows.
Date:   Fri, 18 Mar 2022 15:06:16 +0000
Message-ID: <20220318150635.24600-28-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
References: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Jonathan Cameron <jonathan.cameron@huawei.com>

The concept of these is introduced in [1] in terms of the
description the CEDT ACPI table. The principal is more general.
Unlike once traffic hits the CXL root bridges, the host system
memory address routing is implementation defined and effectively
static once observable by standard / generic system software.
Each CXL Fixed Memory Windows (CFMW) is a region of PA space
which has fixed system dependent routing configured so that
accesses can be routed to the CXL devices below a set of target
root bridges. The accesses may be interleaved across multiple
root bridges.

For QEMU we could have fully specified these regions in terms
of a base PA + size, but as the absolute address does not matter
it is simpler to let individual platforms place the memory regions.

ExampleS:
-cxl-fixed-memory-window targets.0=cxl.0,size=128G
-cxl-fixed-memory-window targets.0=cxl.1,size=128G
-cxl-fixed-memory-window targets.0=cxl0,targets.1=cxl.1,size=256G,interleave-granularity=2k

Specifies
* 2x 128G regions not interleaved across root bridges, one for each of
  the root bridges with ids cxl.0 and cxl.1
* 256G region interleaved across root bridges with ids cxl.0 and cxl.1
with a 2k interleave granularity.

When system software enumerates the devices below a given root bridge
it can then decide which CFMW to use. If non interleave is desired
(or possible) it can use the appropriate CFMW for the root bridge in
question.  If there are suitable devices to interleave across the
two root bridges then it may use the 3rd CFMS.

A number of other designs were considered but the following constraints
made it hard to adapt existing QEMU approaches to this particular problem.
1) The size must be known before a specific architecture / board brings
   up it's PA memory map.  We need to set up an appropriate region.
2) Using links to the host bridges provides a clean command line interface
   but these links cannot be established until command line devices have
   been added.

Hence the two step process used here of first establishing the size,
interleave-ways and granularity + caching the ids of the host bridges
and then, once available finding the actual host bridges so they can
be used later to support interleave decoding.

[1] CXL 2.0 ECN: CEDT CFMWS & QTG DSM (computeexpresslink.org / specifications)

Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/cxl/cxl-host-stubs.c | 14 ++++++
 hw/cxl/cxl-host.c       | 94 +++++++++++++++++++++++++++++++++++++++++
 hw/cxl/meson.build      |  6 +++
 include/hw/cxl/cxl.h    | 20 +++++++++
 qapi/machine.json       | 18 ++++++++
 qemu-options.hx         | 38 +++++++++++++++++
 softmmu/vl.c            | 44 +++++++++++++++++++
 7 files changed, 234 insertions(+)

diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
new file mode 100644
index 0000000000..d24282ec1c
--- /dev/null
+++ b/hw/cxl/cxl-host-stubs.c
@@ -0,0 +1,14 @@
+/*
+ * CXL host parameter parsing routine stubs
+ *
+ * Copyright (c) 2022 Huawei
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/cxl/cxl.h"
+
+void cxl_fixed_memory_window_options_set(MachineState *ms,
+                                         CXLFixedMemoryWindowOptions *object,
+                                         Error **errp) {};
+
+void cxl_fixed_memory_window_link_targets(Error **errp) {};
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
new file mode 100644
index 0000000000..f25713236d
--- /dev/null
+++ b/hw/cxl/cxl-host.c
@@ -0,0 +1,94 @@
+/*
+ * CXL host parameter parsing routines
+ *
+ * Copyright (c) 2022 Huawei
+ * Modeled loosely on the NUMA options handling in hw/core/numa.c
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/bitmap.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "sysemu/qtest.h"
+#include "hw/boards.h"
+
+#include "qapi/qapi-visit-machine.h"
+#include "hw/cxl/cxl.h"
+
+void cxl_fixed_memory_window_options_set(MachineState *ms,
+                                         CXLFixedMemoryWindowOptions *object,
+                                         Error **errp)
+{
+    CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
+    strList *target;
+    int i;
+
+    for (target = object->targets; target; target = target->next) {
+        fw->num_targets++;
+    }
+
+    fw->enc_int_ways = cxl_interleave_ways_enc(fw->num_targets, errp);
+    if (*errp) {
+        return;
+    }
+
+    fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
+    for (i = 0, target = object->targets; target; i++, target = target->next) {
+        /* This link cannot be resolved yet, so stash the name for now */
+        fw->targets[i] = g_strdup(target->value);
+    }
+
+    if (object->size % (256 * MiB)) {
+        error_setg(errp,
+                   "Size of a CXL fixed memory window must my a multiple of 256MiB");
+        return;
+    }
+    fw->size = object->size;
+
+    if (object->has_interleave_granularity) {
+        fw->enc_int_gran =
+            cxl_interleave_granularity_enc(object->interleave_granularity,
+                                           errp);
+        if (*errp) {
+            return;
+        }
+    } else {
+        /* Default to 256 byte interleave */
+        fw->enc_int_gran = 0;
+    }
+
+    ms->cxl_devices_state->fixed_windows =
+        g_list_append(ms->cxl_devices_state->fixed_windows, fw);
+
+    return;
+}
+
+void cxl_fixed_memory_window_link_targets(Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+
+    if (ms->cxl_devices_state && ms->cxl_devices_state->fixed_windows) {
+        GList *it;
+
+        for (it = ms->cxl_devices_state->fixed_windows; it; it = it->next) {
+            CXLFixedWindow *fw = it->data;
+            int i;
+
+            for (i = 0; i < fw->num_targets; i++) {
+                Object *o;
+                bool ambig;
+
+                o = object_resolve_path_type(fw->targets[i],
+                                             TYPE_PXB_CXL_DEVICE,
+                                             &ambig);
+                if (!o) {
+                    error_setg(errp, "Could not resolve CXLFM target %s",
+                               fw->targets[i]);
+                    return;
+                }
+                fw->target_hbs[i] = PXB_CXL_DEV(o);
+            }
+        }
+    }
+}
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index e68eea2358..f117b99949 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -3,4 +3,10 @@ softmmu_ss.add(when: 'CONFIG_CXL',
                    'cxl-component-utils.c',
                    'cxl-device-utils.c',
                    'cxl-mailbox-utils.c',
+                   'cxl-host.c',
+               ),
+               if_false: files(
+                   'cxl-host-stubs.c',
                ))
+
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('cxl-host-stubs.c'))
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 75e5bf71e1..5abc307ef4 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -10,6 +10,8 @@
 #ifndef CXL_H
 #define CXL_H
 
+#include "qapi/qapi-types-machine.h"
+#include "hw/pci/pci_bridge.h"
 #include "cxl_pci.h"
 #include "cxl_component.h"
 #include "cxl_device.h"
@@ -19,10 +21,28 @@
 
 #define CXL_WINDOW_MAX 10
 
+typedef struct CXLFixedWindow {
+    uint64_t size;
+    char **targets;
+    struct PXBDev *target_hbs[8];
+    uint8_t num_targets;
+    uint8_t enc_int_ways;
+    uint8_t enc_int_gran;
+    /* Todo: XOR based interleaving */
+    MemoryRegion mr;
+    hwaddr base;
+} CXLFixedWindow;
+
 typedef struct CXLState {
     bool is_enabled;
     MemoryRegion host_mr;
     unsigned int next_mr_idx;
+    GList *fixed_windows;
 } CXLState;
 
+void cxl_fixed_memory_window_options_set(MachineState *ms,
+                                         CXLFixedMemoryWindowOptions *object,
+                                         Error **errp);
+void cxl_fixed_memory_window_link_targets(Error **errp);
+
 #endif
diff --git a/qapi/machine.json b/qapi/machine.json
index 42fc68403d..e4e64096ca 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -504,6 +504,24 @@
    'dst': 'uint16',
    'val': 'uint8' }}
 
+##
+# @CXLFixedMemoryWindowOptions:
+#
+# Create a CXL Fixed Memory Window (for OptsVisitor)
+#
+# @size: Size in bytes of the Fixed Memory Window
+# @interleave-granularity: Number of contiguous bytes for which
+#                          accesses will go to a given interleave target.
+# @targets: Target root bridge IDs
+#
+# Since 6.3
+##
+{ 'struct': 'CXLFixedMemoryWindowOptions',
+  'data': {
+      'size': 'size',
+      '*interleave-granularity': 'size',
+      'targets': ['str'] }}
+
 ##
 # @X86CPURegister32:
 #
diff --git a/qemu-options.hx b/qemu-options.hx
index 58f2f76775..764f57606d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -467,6 +467,44 @@ SRST
         -numa hmat-cache,node-id=1,size=10K,level=1,associativity=direct,policy=write-back,line=8
 ERST
 
+DEF("cxl-fixed-memory-window", HAS_ARG, QEMU_OPTION_cxl_fixed_memory_window,
+    "-cxl-fixed-memory-window targets.0=firsttarget,targets.1=secondtarget,size=size[,interleave-granularity=granularity]\n",
+    QEMU_ARCH_ALL)
+SRST
+``-cxl-fixed-memory-window targets.0=firsttarget,targets.1=secondtarget,size=size[,interleave-granularity=granularity]``
+    Define a CXL Fixed Memory Window (CFMW).
+
+    Described in the CXL 2.0 ECN: CEDT CFMWS & QTG _DSM.
+
+    They are regions of Host Physical Addresses (HPA) on a system which
+    may be interleaved across one or more CXL host bridges.  The system
+    software will assign particular devices into these windows and
+    configure the downstream Host-managed Device Memory (HDM) decoders
+    in root ports, switch ports and devices appropriately to meet the
+    interleave requirements before enabling the memory devices.
+
+    ``targets.X=firsttarget`` provides the mapping to CXL host bridges
+    which may be identified by the id provied in the -device entry.
+    Multiple entries are needed to specify all the targets when
+    the fixed memory window represents interleaved memory. X is the
+    target index from 0.
+
+    ``size=size`` sets the size of the CFMW. This must be a multiple of
+    256MiB. The region will be aligned to 256MiB but the location is
+    platform and configuration dependent.
+
+    ``interleave-granularity=granularity`` sets the granularity of
+    interleave. Default 256KiB. Only 256KiB, 512KiB, 1024KiB, 2048KiB
+    4096KiB, 8192KiB and 16384KiB granularities supported.
+
+    Example:
+
+    ::
+
+        -cxl-fixed-memory-window -targets.0=cxl.0,-targets.1=cxl.1,size=128G,interleave-granularity=512k
+
+ERST
+
 DEF("add-fd", HAS_ARG, QEMU_OPTION_add_fd,
     "-add-fd fd=fd,set=set[,opaque=opaque]\n"
     "                Add 'fd' to fd 'set'\n", QEMU_ARCH_ALL)
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 0b81f61535..dab1eb3380 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -92,6 +92,7 @@
 #include "qemu/config-file.h"
 #include "qemu/qemu-options.h"
 #include "qemu/main-loop.h"
+#include "hw/cxl/cxl.h"
 #ifdef CONFIG_VIRTFS
 #include "fsdev/qemu-fsdev.h"
 #endif
@@ -117,6 +118,7 @@
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qapi-visit-compat.h"
+#include "qapi/qapi-visit-machine.h"
 #include "qapi/qapi-visit-ui.h"
 #include "qapi/qapi-commands-block-core.h"
 #include "qapi/qapi-commands-migration.h"
@@ -140,6 +142,11 @@ typedef struct BlockdevOptionsQueueEntry {
 
 typedef QSIMPLEQ_HEAD(, BlockdevOptionsQueueEntry) BlockdevOptionsQueue;
 
+typedef struct CXLFMWOptionQueueEntry {
+    CXLFixedMemoryWindowOptions *opts;
+    QSIMPLEQ_ENTRY(CXLFMWOptionQueueEntry) entry;
+} CXLFMWOptionQueueEntry;
+
 typedef struct ObjectOption {
     ObjectOptions *opts;
     QTAILQ_ENTRY(ObjectOption) next;
@@ -166,6 +173,8 @@ static int snapshot;
 static bool preconfig_requested;
 static QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
 static BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
+static QSIMPLEQ_HEAD(, CXLFMWOptionQueueEntry) CXLFMW_opts =
+    QSIMPLEQ_HEAD_INITIALIZER(CXLFMW_opts);
 static bool nographic = false;
 static int mem_prealloc; /* force preallocation of physical target memory */
 static ram_addr_t ram_size;
@@ -1149,6 +1158,23 @@ static void parse_display(const char *p)
     }
 }
 
+static void parse_cxl_fixed_memory_window(const char *optarg)
+{
+    CXLFMWOptionQueueEntry *cfmws_entry;
+    Visitor *v;
+
+    v = qobject_input_visitor_new_str(optarg, "cxl-fixed-memory-window",
+                                      &error_fatal);
+    cfmws_entry = g_new(CXLFMWOptionQueueEntry, 1);
+    visit_type_CXLFixedMemoryWindowOptions(v, NULL, &cfmws_entry->opts,
+                                           &error_fatal);
+    if (!cfmws_entry->opts) {
+        exit(1);
+    }
+    visit_free(v);
+    QSIMPLEQ_INSERT_TAIL(&CXLFMW_opts, cfmws_entry, entry);
+}
+
 static inline bool nonempty_str(const char *str)
 {
     return str && *str;
@@ -2020,6 +2046,19 @@ static void qemu_create_late_backends(void)
     qemu_semihosting_console_init();
 }
 
+static void cxl_set_opts(void)
+{
+    while (!QSIMPLEQ_EMPTY(&CXLFMW_opts)) {
+        CXLFMWOptionQueueEntry *cfmws_entry = QSIMPLEQ_FIRST(&CXLFMW_opts);
+
+        QSIMPLEQ_REMOVE_HEAD(&CXLFMW_opts, entry);
+        cxl_fixed_memory_window_options_set(current_machine, cfmws_entry->opts,
+                                            &error_fatal);
+        qapi_free_CXLFixedMemoryWindowOptions(cfmws_entry->opts);
+        g_free(cfmws_entry);
+    }
+}
+
 static bool have_custom_ram_size(void)
 {
     QemuOpts *opts = qemu_find_opts_singleton("memory");
@@ -2745,6 +2784,7 @@ void qmp_x_exit_preconfig(Error **errp)
 
     qemu_init_board();
     qemu_create_cli_devices();
+    cxl_fixed_memory_window_link_targets(errp);
     qemu_machine_creation_done();
 
     if (loadvm) {
@@ -2925,6 +2965,9 @@ void qemu_init(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
+            case QEMU_OPTION_cxl_fixed_memory_window:
+                parse_cxl_fixed_memory_window(optarg);
+                break;
             case QEMU_OPTION_display:
                 parse_display(optarg);
                 break;
@@ -3762,6 +3805,7 @@ void qemu_init(int argc, char **argv, char **envp)
 
     qemu_resolve_machine_memdev();
     parse_numa_opts(current_machine);
+    cxl_set_opts();
 
     if (vmstate_dump_file) {
         /* dump and exit */
-- 
2.32.0

