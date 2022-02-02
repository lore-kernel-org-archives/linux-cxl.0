Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2960C433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Feb 2022 14:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344903AbiBBOZ3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Feb 2022 09:25:29 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4646 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiBBOZ2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Feb 2022 09:25:28 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JpkVP6mqbz67y6K;
        Wed,  2 Feb 2022 22:20:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 15:25:26 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 14:25:26 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>, <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v5 29/43] hw/cxl/host: Add support for CXL Fixed Memory Windows.
Date:   Wed, 2 Feb 2022 14:10:23 +0000
Message-ID: <20220202141037.17352-30-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220202141037.17352-1-Jonathan.Cameron@huawei.com>
References: <20220202141037.17352-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
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
-cxl-fixed-memory-window targets=cxl.0,size=128G
-cxl-fixed-memory-window targets=cxl.1,size=128G
-cxl-fixed-memory-window targets=cxl0,targets=cxl.1,size=256G,interleave-granularity=2k

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
v5:
Build fix as suggested by Alex to move this from specific_ss to softmmu_ss.

 hw/cxl/cxl-host-stubs.c |  22 +++++++
 hw/cxl/cxl-host.c       | 138 ++++++++++++++++++++++++++++++++++++++++
 hw/cxl/meson.build      |   6 ++
 include/hw/cxl/cxl.h    |  20 ++++++
 qapi/machine.json       |  15 +++++
 qemu-options.hx         |  37 +++++++++++
 softmmu/vl.c            |  11 ++++
 7 files changed, 249 insertions(+)
 create mode 100644 hw/cxl/cxl-host-stubs.c
 create mode 100644 hw/cxl/cxl-host.c

diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
new file mode 100644
index 0000000000..f942dda41b
--- /dev/null
+++ b/hw/cxl/cxl-host-stubs.c
@@ -0,0 +1,22 @@
+/*
+ * CXL host parameter parsing routine stubs
+ *
+ * Copyright (c) 2022 Huawei
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/option.h"
+#include "hw/cxl/cxl.h"
+
+QemuOptsList qemu_cxl_fixed_window_opts = {
+    .name = "cxl-fixed-memory-window",
+    .implied_opt_name = "type",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_cxl_fixed_window_opts.head),
+    .desc = { { 0 } }
+};
+
+void parse_cxl_fixed_memory_window_opts(MachineState *ms) {};
+
+void cxl_fixed_memory_window_link_targets(Error **errp) {};
+
+const MemoryRegionOps cfmws_ops;
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
new file mode 100644
index 0000000000..9f303e6d8e
--- /dev/null
+++ b/hw/cxl/cxl-host.c
@@ -0,0 +1,138 @@
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
+#include "qapi/opts-visitor.h"
+#include "qapi/qapi-visit-machine.h"
+#include "qemu/option.h"
+#include "hw/cxl/cxl.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_host.h"
+#include "hw/pci/pcie_port.h"
+
+QemuOptsList qemu_cxl_fixed_window_opts = {
+    .name = "cxl-fixed-memory-window",
+    .implied_opt_name = "type",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_cxl_fixed_window_opts.head),
+    .desc = { { 0 } }
+};
+
+static void set_cxl_fixed_memory_window_options(MachineState *ms,
+                                                CXLFixedMemoryWindowOptions *object,
+                                                Error **errp)
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
+static int parse_cxl_fixed_memory_window(void *opaque, QemuOpts *opts,
+                                         Error **errp)
+{
+    CXLFixedMemoryWindowOptions *object = NULL;
+    MachineState *ms = MACHINE(opaque);
+    Error *err = NULL;
+    Visitor *v = opts_visitor_new(opts);
+
+    visit_type_CXLFixedMemoryWindowOptions(v, NULL, &object, errp);
+    visit_free(v);
+    if (!object) {
+        return -1;
+    }
+
+    set_cxl_fixed_memory_window_options(ms, object, &err);
+
+    qapi_free_CXLFixedMemoryWindowOptions(object);
+    if (err) {
+        error_propagate(errp, err);
+        return -1;
+    }
+
+    return 0;
+}
+
+void parse_cxl_fixed_memory_window_opts(MachineState *ms)
+{
+    qemu_opts_foreach(qemu_find_opts("cxl-fixed-memory-window"),
+                      parse_cxl_fixed_memory_window, ms, &error_fatal);
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
index 6889362230..1b72c0b7b7 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -10,6 +10,9 @@
 #ifndef CXL_H
 #define CXL_H
 
+#include "qapi/qapi-types-machine.h"
+#include "qemu/option.h"
+#include "hw/pci/pci_bridge.h"
 #include "cxl_pci.h"
 #include "cxl_component.h"
 #include "cxl_device.h"
@@ -20,10 +23,27 @@
 #define TYPE_CXL_TYPE3_DEV "cxl-type3"
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
 
+extern QemuOptsList qemu_cxl_fixed_window_opts;
+void parse_cxl_fixed_memory_window_opts(MachineState *ms);
+void cxl_fixed_memory_window_link_targets(Error **errp);
+
 #endif
diff --git a/qapi/machine.json b/qapi/machine.json
index 42fc68403d..0998a9128d 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -504,6 +504,21 @@
    'dst': 'uint16',
    'val': 'uint8' }}
 
+##
+# @CXLFixedMemoryWindowOptions:
+#
+# Create a CXL Fixed Memory Window (for OptsVisitor)
+#
+# @targets: Target root bridge IDs
+#
+# Since X.X //fixme
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
index ba3ae6a42a..b4d2cc6f48 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -467,6 +467,43 @@ SRST
         -numa hmat-cache,node-id=1,size=10K,level=1,associativity=direct,policy=write-back,line=8
 ERST
 
+DEF("cxl-fixed-memory-window", HAS_ARG, QEMU_OPTION_cxl_fixed_memory_window,
+    "-cxl-fixed-memory-window targets=firsttarget,targets=secondtarget,size=size[,interleave-granularity=granularity]\n",
+    QEMU_ARCH_ALL)
+SRST
+``-cxl-fixed-memory-window targets=firsttarget,targets=secondtarget,size=size[,interleave-granularity=granularity]``
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
+    ``targets=firsttarget`` provides the mapping to CXL host bridges
+    which may be identified by the id provied in the -device entry.
+    Multiple entries are needed to specify all the targets when
+    the fixed memory window represents interleaved memory.
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
+        -cxl-fixed-memory-window -targets=cxl.0,-targets=cxl.1,size=128G,interleave-granularity=512k
+
+ERST
+
 DEF("add-fd", HAS_ARG, QEMU_OPTION_add_fd,
     "-add-fd fd=fd,set=set[,opaque=opaque]\n"
     "                Add 'fd' to fd 'set'\n", QEMU_ARCH_ALL)
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 5e1b35ba48..f83f158fff 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -91,6 +91,7 @@
 #include "qemu/config-file.h"
 #include "qemu/qemu-options.h"
 #include "qemu/main-loop.h"
+#include "hw/cxl/cxl.h"
 #ifdef CONFIG_VIRTFS
 #include "fsdev/qemu-fsdev.h"
 #endif
@@ -2744,6 +2745,7 @@ void qmp_x_exit_preconfig(Error **errp)
 
     qemu_init_board();
     qemu_create_cli_devices();
+    cxl_fixed_memory_window_link_targets(errp);
     qemu_machine_creation_done();
 
     if (loadvm) {
@@ -2805,6 +2807,7 @@ void qemu_init(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_msg_opts);
     qemu_add_opts(&qemu_name_opts);
     qemu_add_opts(&qemu_numa_opts);
+    qemu_add_opts(&qemu_cxl_fixed_window_opts);
     qemu_add_opts(&qemu_icount_opts);
     qemu_add_opts(&qemu_semihosting_config_opts);
     qemu_add_opts(&qemu_fw_cfg_opts);
@@ -2927,6 +2930,13 @@ void qemu_init(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
+            case QEMU_OPTION_cxl_fixed_memory_window:
+                opts = qemu_opts_parse_noisily(qemu_find_opts("cxl-fixed-memory-window"),
+                                               optarg, true);
+                if (!opts) {
+                    exit(1);
+                }
+                break;
             case QEMU_OPTION_display:
                 parse_display(optarg);
                 break;
@@ -3764,6 +3774,7 @@ void qemu_init(int argc, char **argv, char **envp)
 
     qemu_resolve_machine_memdev();
     parse_numa_opts(current_machine);
+    parse_cxl_fixed_memory_window_opts(current_machine);
 
     if (vmstate_dump_file) {
         /* dump and exit */
-- 
2.32.0

