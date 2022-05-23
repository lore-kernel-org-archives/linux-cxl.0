Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B063CC433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 23 May 2022 15:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbiEWPPR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 May 2022 11:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbiEWPPO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 May 2022 11:15:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF465C358
        for <linux-cxl@vger.kernel.org>; Mon, 23 May 2022 08:15:12 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L6LQm3hjtz67qQW;
        Mon, 23 May 2022 23:12:00 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 17:15:10 +0200
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 16:15:09 +0100
Date:   Mon, 23 May 2022 16:15:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>, <linux-cxl@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>, <k.jensen@samsung.com>,
        <dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH v10 27/45] hw/cxl/host: Add support for CXL Fixed Memory
 Windows.
Message-ID: <20220523161507.00006a3a@huawei.com>
In-Reply-To: <0c0055ac-8d94-37d9-62c2-58c3da5461d3@redhat.com>
References: <20220429144110.25167-1-Jonathan.Cameron@huawei.com>
 <20220429144110.25167-28-Jonathan.Cameron@huawei.com>
 <0c0055ac-8d94-37d9-62c2-58c3da5461d3@redhat.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, 21 May 2022 11:07:13 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 4/29/22 16:40, Jonathan Cameron via wrote:
> > From: Jonathan Cameron <jonathan.cameron@huawei.com>
> > 
> > The concept of these is introduced in [1] in terms of the
> > description the CEDT ACPI table. The principal is more general.
> > Unlike once traffic hits the CXL root bridges, the host system
> > memory address routing is implementation defined and effectively
> > static once observable by standard / generic system software.
> > Each CXL Fixed Memory Windows (CFMW) is a region of PA space
> > which has fixed system dependent routing configured so that
> > accesses can be routed to the CXL devices below a set of target
> > root bridges. The accesses may be interleaved across multiple
> > root bridges.
> > 
> > For QEMU we could have fully specified these regions in terms
> > of a base PA + size, but as the absolute address does not matter
> > it is simpler to let individual platforms place the memory regions.
> > 
> > ExampleS:
> > -cxl-fixed-memory-window targets.0=cxl.0,size=128G
> > -cxl-fixed-memory-window targets.0=cxl.1,size=128G
> > -cxl-fixed-memory-window targets.0=cxl0,targets.1=cxl.1,size=256G,interleave-granularity=2k  
> 


> Sorry for the late review, but: no more command line options should
> be added to QEMU.  This should be:
> 
> -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=128G \
> -M cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=128G \
> -M cxl-fmw.2.targets.0=cxl.0,cxl-fmw.2.targets.1=cxl.1,cxl-fmw.2.size=128G,cxl-fmw.2.interleave-granularity=2k
>

Hi Paolo,

I thought I had this working but have run into an issue where the parser
seems not to like multiple parts of cxl-fmw as below being in different
-M entries.  I get

qemu-system-aarch64: -M cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=4G,cxl-fmw.1.interleave-granularity=8k: Parameters 'cxl-fmw.*' used inconsistently

Seems it doesn't let me have multiple elements of a list in different -M entries.

Not a disaster but it's going to lead to some unreadable command lines.

Very lightly tested patch below.  I've not yet looked at movingstuff
to machine specific callbacks as per your other comment.  I recall that wasn't
easy to do with an earlier version of the series, but given a lot has changed
since then it might now easier to accomplish.

Thanks,

Jonathan

> I'm not against adding a shortcut as above, but the implementation should
> be entirely in MachineState using a QOM property.
> 
> The reason for this is that we're looking into doing machine setup entirely
> via RPC, and any extra option is a new command to be implemented.
> 
> Would you be able to do the change?  Since you are already using QAPI to
> deserialize the option it should not be hard.  I can promise a quick review,
> and I can also provide with an example conversion for -boot at
> https://lore.kernel.org/r/20220414165300.555321-3-pbonzini@redhat.com/.

From d856959a08513b098fda22472f0b870750910543 Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 23 May 2022 16:07:45 +0100
Subject: [PATCH] hw/cxl: Make the CXL fixed memory window setup a machine
 parameter.

Paolo Bonzini requested this change to simplify the ongoing
effort to allow machine setup entirely via RPC.

Includes shortening the command line form cxl-fixed-memory-window
to cxl-fmw as the command lines are extremely long even with this
change.

The json change is needed to ensure that there is
a CXLFixedMemoryWindowOptionsList even though the actual
element in the json is never used.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/core/machine.c   | 33 +++++++++++++++++++++++++++++++
 include/hw/boards.h |  1 +
 qapi/machine.json   | 13 +++++++++++++
 softmmu/vl.c        | 47 ++++-----------------------------------------
 4 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index bb0dc8f6a9..93b3b8d34a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -920,6 +920,33 @@ out_free:
     qapi_free_BootConfiguration(config);
 }
 
+static void machine_get_cfmw(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+    CXLFixedMemoryWindowOptionsList *list = ms->cfmws_list;
+
+    visit_type_CXLFixedMemoryWindowOptionsList(v, name, &list, errp);
+}
+
+static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+    CXLFixedMemoryWindowOptionsList *cfmw_list = NULL;
+    CXLFixedMemoryWindowOptionsList *it;
+
+    visit_type_CXLFixedMemoryWindowOptionsList(v, name, &cfmw_list, errp);
+    if (!cfmw_list) {
+        return;
+    }
+
+    for (it = cfmw_list; it; it = it->next) {
+        cxl_fixed_memory_window_config(current_machine, it->value, errp);
+    }
+    ms->cfmws_list = cfmw_list;
+}
+
 static void machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -966,6 +993,12 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "boot",
         "Boot configuration");
 
+    object_class_property_add(oc, "cxl-fmw", "CXLFixedMemoryWindow",
+        machine_get_cfmw, machine_set_cfmw,
+        NULL, NULL);
+    object_class_property_set_description(oc, "cxl-fmw",
+        "CXL Fixed Memory Window");
+
     object_class_property_add(oc, "smp", "SMPConfiguration",
         machine_get_smp, machine_set_smp,
         NULL, NULL);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index fa57bac4fb..dd9fc56df2 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -362,6 +362,7 @@ struct MachineState {
     struct NVDIMMState *nvdimms_state;
     struct CXLState *cxl_devices_state;
     struct NumaState *numa_state;
+    CXLFixedMemoryWindowOptionsList *cfmws_list;
 };
 
 #define DEFINE_MACHINE(namestr, machine_initfn) \
diff --git a/qapi/machine.json b/qapi/machine.json
index 883ce3f9ea..b17ac79494 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -523,6 +523,19 @@
       '*interleave-granularity': 'size',
       'targets': ['str'] }}
 
+##
+# @CXLFMWProperties:
+#
+# List of CXL Fixed Memory Windows.
+#
+# @cxl-fmw: List of CXLFixedMemoryWindowOptions
+#
+# Since 7.1
+##
+{ 'struct' : 'CXLFMWProperties',
+  'data': { 'cxl-fmw': ['CXLFixedMemoryWindowOptions'] }
+}
+
 ##
 # @X86CPURegister32:
 #
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 84a31eba76..01997968f5 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -147,11 +147,6 @@ typedef struct BlockdevOptionsQueueEntry {
 
 typedef QSIMPLEQ_HEAD(, BlockdevOptionsQueueEntry) BlockdevOptionsQueue;
 
-typedef struct CXLFMWOptionQueueEntry {
-    CXLFixedMemoryWindowOptions *opts;
-    Location loc;
-    QSIMPLEQ_ENTRY(CXLFMWOptionQueueEntry) entry;
-} CXLFMWOptionQueueEntry;
 
 typedef struct ObjectOption {
     ObjectOptions *opts;
@@ -179,8 +174,7 @@ static int snapshot;
 static bool preconfig_requested;
 static QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
 static BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
-static QSIMPLEQ_HEAD(, CXLFMWOptionQueueEntry) CXLFMW_opts =
-    QSIMPLEQ_HEAD_INITIALIZER(CXLFMW_opts);
+
 static bool nographic = false;
 static int mem_prealloc; /* force preallocation of physical target memory */
 static const char *vga_model = NULL;
@@ -1165,24 +1159,6 @@ static void parse_display(const char *p)
     }
 }
 
-static void parse_cxl_fixed_memory_window(const char *optarg)
-{
-    CXLFMWOptionQueueEntry *cfmws_entry;
-    Visitor *v;
-
-    v = qobject_input_visitor_new_str(optarg, "cxl-fixed-memory-window",
-                                      &error_fatal);
-    cfmws_entry = g_new(CXLFMWOptionQueueEntry, 1);
-    visit_type_CXLFixedMemoryWindowOptions(v, NULL, &cfmws_entry->opts,
-                                           &error_fatal);
-    if (!cfmws_entry->opts) {
-        exit(1);
-    }
-    visit_free(v);
-    loc_save(&cfmws_entry->loc);
-    QSIMPLEQ_INSERT_TAIL(&CXLFMW_opts, cfmws_entry, entry);
-}
-
 static inline bool nonempty_str(const char *str)
 {
     return str && *str;
@@ -2045,20 +2021,6 @@ static void qemu_create_late_backends(void)
     qemu_semihosting_console_init();
 }
 
-static void cxl_set_opts(void)
-{
-    while (!QSIMPLEQ_EMPTY(&CXLFMW_opts)) {
-        CXLFMWOptionQueueEntry *cfmws_entry = QSIMPLEQ_FIRST(&CXLFMW_opts);
-
-        loc_restore(&cfmws_entry->loc);
-        QSIMPLEQ_REMOVE_HEAD(&CXLFMW_opts, entry);
-        cxl_fixed_memory_window_config(current_machine, cfmws_entry->opts,
-                                       &error_fatal);
-        qapi_free_CXLFixedMemoryWindowOptions(cfmws_entry->opts);
-        g_free(cfmws_entry);
-    }
-}
-
 static void qemu_resolve_machine_memdev(void)
 {
     if (ram_memdev_id) {
@@ -2187,6 +2149,7 @@ static bool is_qemuopts_group(const char *group)
         g_str_equal(group, "machine") ||
         g_str_equal(group, "smp-opts") ||
         g_str_equal(group, "boot-opts") ||
+        g_str_equal(group, "cxl-fmw") ||
         g_str_equal(group, "memory")) {
         return false;
     }
@@ -2213,6 +2176,8 @@ static void qemu_record_config_group(const char *group, QDict *dict,
         machine_merge_property("boot", dict, &error_fatal);
     } else if (g_str_equal(group, "memory")) {
         machine_merge_property("memory", dict, &error_fatal);
+    } else if (g_str_equal(group, "cxl-fmw")) {
+        machine_merge_property("cxl-fmw", dict, &error_fatal);
     } else {
         abort();
     }
@@ -2886,9 +2851,6 @@ void qemu_init(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_cxl_fixed_memory_window:
-                parse_cxl_fixed_memory_window(optarg);
-                break;
             case QEMU_OPTION_display:
                 parse_display(optarg);
                 break;
@@ -3724,7 +3686,6 @@ void qemu_init(int argc, char **argv, char **envp)
 
     qemu_resolve_machine_memdev();
     parse_numa_opts(current_machine);
-    cxl_set_opts();
 
     if (vmstate_dump_file) {
         /* dump and exit */
-- 
2.32.0


