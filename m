Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BA6C433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbiAXAxE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:53:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:61596 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240656AbiAXAxD (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985583; x=1674521583;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JnHduQG5BOLWR0yGJscT3N4kg/GA5bSN96rM5mcMzQU=;
  b=Cy7HqlMQSEKvyG3WTa84d07PV8wZaWd04SwuwfhdieQWC2a6KvnstTo3
   sQp6iXagwdpG4VV9bu4jPPd1ZgFzX93BkALqlT2hxmqq5Zx3fIdbKznoJ
   cMq/Qjgu81Hua1aQ8ShB5erKHzqYShXyVLB6SnOA3xDzHzQ4ePeFJco9Z
   uA24NLBU7lqOyQqwBk4kOMMYgnnFHzQekjVdELWTIk5LcrBLH69zXTwJD
   DLH7t+mnduJfJQ0lCnXcu6IhrpSTd8TQvuCWyClvth5rTUXrqIF4lHRUs
   GKlvMvwIlEGJy8QoUUkm8AOUegLyT/0z1I0KNLoLr/eoPE2rTZMo8a+D0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="233293964"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="233293964"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:53:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="673456418"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:53:02 -0800
Subject: [ndctl PATCH 14/37] cxl/list: Add bus objects
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:53:02 -0800
Message-ID: <164298558278.3021641.16323855851736615358.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A 'struct cxl_bus' represents a CXL.mem domain. It is the root of a
Host-managed Device Memory (HDM) hierarchy. When memory devices are enabled
for CXL operation they appear underneath a bus in a 'cxl list -BM' listing,
otherwise they display as disconnected.

A 'bus' is identical to the kernel's CXL root port object, but given the
confusion between CXL root ports, and PCIe root ports, the 'bus' name is
less ambiguous. It also serves a similar role in the object hierarchy as a
'struct ndctl_bus' object. It is also the case that the "root" name will
appear as the kernel device-name, so the association will be clear.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 .clang-format                    |    1 
 Documentation/cxl/cxl-list.txt   |   88 ++++++++++++++++++++----
 Documentation/cxl/lib/libcxl.txt |   30 ++++++++
 cxl/filter.c                     |  117 +++++++++++++++++++++++++++++++
 cxl/filter.h                     |    2 +
 cxl/json.c                       |   21 ++++++
 cxl/json.h                       |    5 +
 cxl/lib/libcxl.c                 |  142 ++++++++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym               |    5 +
 cxl/lib/private.h                |   14 ++++
 cxl/libcxl.h                     |   11 +++
 cxl/list.c                       |   19 +++--
 12 files changed, 431 insertions(+), 24 deletions(-)

diff --git a/.clang-format b/.clang-format
index d2e77d0e0b4b..1154c76b1399 100644
--- a/.clang-format
+++ b/.clang-format
@@ -78,6 +78,7 @@ ExperimentalAutoDetectBinPacking: false
 # 	| sort -u)
 ForEachMacros:
   - 'cxl_memdev_foreach'
+  - 'cxl_bus_foreach'
   - 'daxctl_dev_foreach'
   - 'daxctl_mapping_foreach'
   - 'daxctl_region_foreach'
diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
index 224c972498ea..be131ae7b02a 100644
--- a/Documentation/cxl/cxl-list.txt
+++ b/Documentation/cxl/cxl-list.txt
@@ -15,17 +15,60 @@ SYNOPSIS
 Walk the CXL capable device hierarchy in the system and list all device
 instances along with some of their major attributes.
 
-Options can be specified to limit the output to specific objects.
+Options can be specified to limit the output to specific objects. When a
+single object type is specified the return json object is an array of
+just those objects, when multiple objects types are specified the
+returned the returned object may be an array of arrays with the inner
+array named for the given object type.
+
+Filters can by specifed as either a single identidier, a space separated
+quoted string, or a comma separated list. When multiple filter
+identifiers are specified within a filter string, like "-m
+mem0,mem1,mem2", they are combined as an 'OR' filter.  When multiple
+filter string types are specified, like "-m mem0,mem1,mem2 -p port10",
+they are combined as an 'AND' filter. So, "-m mem0,mem1,mem2 -p port10"
+would only list objects that are beneath port10 AND map mem0, mem1, OR
+mem2.
+
+The --human option in addition to reformatting some fields to more human
+friendly strings also unwraps the array to reduce the number of lines of
+output.
 
 EXAMPLE
 -------
 ----
 # cxl list --memdevs
-{
-  "memdev":"mem0",
-  "pmem_size":268435456,
-  "ram_size":0,
-}
+[
+  {
+    "memdev":"mem0",
+    "pmem_size":268435456,
+    "ram_size":0,
+    "serial":0
+  }
+]
+
+# cxl list -BMu
+[
+  {
+    "anon memdevs":[
+      {
+        "memdev":"mem0",
+        "pmem_size":"256.00 MiB (268.44 MB)",
+        "ram_size":0,
+        "serial":"0"
+      }
+    ]
+  },
+  {
+    "buses":[
+      {
+        "bus":"root0",
+        "provider":"ACPI.CXL"
+      }
+    ]
+  }
+]
+
 ----
 
 OPTIONS
@@ -34,13 +77,6 @@ OPTIONS
 --memdev=::
 	Specify CXL memory device name(s), or device id(s), to filter the listing. For example:
 ----
-# cxl list --memdev=mem0
-{
-  "memdev":"mem0",
-  "pmem_size":268435456,
-  "ram_size":0,
-}
-
 # cxl list -M --memdev="0 mem3 5"
 [
   {
@@ -114,6 +150,32 @@ OPTIONS
 ]
 ----
 
+-B::
+--buses::
+	Include 'bus' / CXL root object(s) in the listing. Typically, on ACPI
+	systems the bus object is a singleton associated with the ACPI0017
+	device, but there are test scenerios where there may be multiple CXL
+	memory hierarchies.
+----
+# cxl list -B
+[
+  {
+    "bus":"root3",
+    "provider":"cxl_test"
+  },
+  {
+    "bus":"root0",
+    "provider":"ACPI.CXL"
+  }
+]
+----
+
+-b::
+--bus=::
+	Specify CXL root device name(s), device id(s), and / or CXL bus provider
+	names to filter the listing. The supported provider names are "ACPI.CXL"
+	and "cxl_test".
+
 include::human-option.txt[]
 
 include::verbose-option.txt[]
diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index c127326a2840..84af66a3a7bd 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -134,6 +134,36 @@ cxl_memdev{read,write,zero}_label() are helpers for marshaling multiple
 label access commands over an arbitrary extent of the device's label
 area.
 
+BUSES
+-----
+The CXL Memory space is CPU and Device coherent. The address ranges that
+support coherent access are described by platform firmware and
+communicated to the operating system via a CXL root object 'struct
+cxl_bus'.
+
+=== BUS: Enumeration
+----
+struct cxl_bus *cxl_bus_get_first(struct cxl_ctx *ctx);
+struct cxl_bus *cxl_bus_get_next(struct cxl_bus *bus);
+
+#define cxl_bus_foreach(ctx, bus)                                           \
+       for (bus = cxl_bus_get_first(ctx); bus != NULL;                      \
+            bus = cxl_bus_get_next(bus))
+----
+
+=== BUS: Attributes
+----
+const char *cxl_bus_get_provider(struct cxl_bus *bus);
+const char *cxl_bus_get_devname(struct cxl_bus *bus);
+int cxl_bus_get_id(struct cxl_bus *bus);
+----
+
+The provider name of a bus is a persistent name that is independent of
+discovery order. The possible provider names are 'ACPI.CXL' and
+'cxl_test'. The devname and id attributes, like other objects, are just
+the kernel device names that are subject to change based on discovery
+order.
+
 include::../../copyright.txt[]
 
 SEE ALSO
diff --git a/cxl/filter.c b/cxl/filter.c
index 26efc65f4dd7..5f4844b4cab9 100644
--- a/cxl/filter.c
+++ b/cxl/filter.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
+// Copyright (C) 2015-2022 Intel Corporation. All rights reserved.
 #include <errno.h>
 #include <stdio.h>
 #include <string.h>
@@ -21,6 +21,43 @@ static const char *which_sep(const char *filter)
 	return " ";
 }
 
+static struct cxl_bus *util_cxl_bus_filter(struct cxl_bus *bus,
+					   const char *__ident)
+{
+	char *ident, *save;
+	const char *arg;
+	int bus_id;
+
+	if (!__ident)
+		return bus;
+
+	ident = strdup(__ident);
+	if (!ident)
+		return NULL;
+
+	for (arg = strtok_r(ident, which_sep(__ident), &save); arg;
+	     arg = strtok_r(NULL, which_sep(__ident), &save)) {
+		if (strcmp(arg, "all") == 0)
+			break;
+
+		if ((sscanf(arg, "%d", &bus_id) == 1 ||
+		     sscanf(arg, "root%d", &bus_id) == 1) &&
+		    cxl_bus_get_id(bus) == bus_id)
+			break;
+
+		if (strcmp(arg, cxl_bus_get_devname(bus)) == 0)
+			break;
+
+		if (strcmp(arg, cxl_bus_get_provider(bus)) == 0)
+			break;
+	}
+
+	free(ident);
+	if (arg)
+		return bus;
+	return NULL;
+}
+
 static struct cxl_memdev *
 util_cxl_memdev_serial_filter(struct cxl_memdev *memdev, const char *__serials)
 {
@@ -98,21 +135,67 @@ static unsigned long params_to_flags(struct cxl_filter_params *param)
 	return flags;
 }
 
+static void splice_array(struct cxl_filter_params *p, struct json_object *jobjs,
+			 struct json_object *platform,
+			 const char *container_name, bool do_container)
+{
+	size_t count;
+
+	if (!json_object_array_length(jobjs)) {
+		json_object_put(jobjs);
+		return;
+	}
+
+	if (do_container) {
+		struct json_object *container = json_object_new_object();
+
+		if (!container) {
+			err(p, "failed to list: %s\n", container_name);
+			return;
+		}
+
+		json_object_object_add(container, container_name, jobjs);
+		json_object_array_add(platform, container);
+		return;
+	}
+
+	for (count = json_object_array_length(jobjs); count; count--) {
+		struct json_object *jobj = json_object_array_get_idx(jobjs, 0);
+
+		json_object_get(jobj);
+		json_object_array_del_idx(jobjs, 0, 1);
+		json_object_array_add(platform, jobj);
+	}
+	json_object_put(jobjs);
+}
+
 int cxl_filter_walk(struct cxl_ctx *ctx, struct cxl_filter_params *p)
 {
 	struct json_object *jplatform = json_object_new_array();
+	struct json_object *jdevs = NULL, *jbuses = NULL;
 	unsigned long flags = params_to_flags(p);
 	struct cxl_memdev *memdev;
+	int top_level_objs = 0;
+	struct cxl_bus *bus;
 
 	if (!jplatform) {
 		dbg(p, "platform object allocation failure\n");
 		return -ENOMEM;
 	}
 
+	jdevs = json_object_new_array();
+	if (!jdevs)
+		goto err;
+
+	jbuses = json_object_new_array();
+	if (!jbuses)
+		goto err;
+
 	cxl_memdev_foreach(ctx, memdev) {
 		struct json_object *jdev;
 
-		if (!util_cxl_memdev_filter(memdev, p->memdev_filter, p->serial_filter))
+		if (!util_cxl_memdev_filter(memdev, p->memdev_filter,
+					    p->serial_filter))
 			continue;
 		if (p->memdevs) {
 			jdev = util_cxl_memdev_to_json(memdev, flags);
@@ -120,11 +203,39 @@ int cxl_filter_walk(struct cxl_ctx *ctx, struct cxl_filter_params *p)
 				dbg(p, "memdev object allocation failure\n");
 				continue;
 			}
-			json_object_array_add(jplatform, jdev);
+			json_object_array_add(jdevs, jdev);
+		}
+	}
+
+	cxl_bus_foreach(ctx, bus) {
+		struct json_object *jbus;
+
+		if (!util_cxl_bus_filter(bus, p->bus_filter))
+			continue;
+		if (p->buses) {
+			jbus = util_cxl_bus_to_json(bus, flags);
+			if (!jbus) {
+				dbg(p, "bus object allocation failure\n");
+				continue;
+			}
+			json_object_array_add(jbuses, jbus);
 		}
 	}
 
+	if (json_object_array_length(jdevs))
+		top_level_objs++;
+	if (json_object_array_length(jbuses))
+		top_level_objs++;
+
+	splice_array(p, jdevs, jplatform, "anon memdevs", top_level_objs > 1);
+	splice_array(p, jbuses, jplatform, "buses", top_level_objs > 1);
+
 	util_display_json_array(stdout, jplatform, flags);
 
 	return 0;
+err:
+	json_object_put(jdevs);
+	json_object_put(jbuses);
+	json_object_put(jplatform);
+	return -ENOMEM;
 }
diff --git a/cxl/filter.h b/cxl/filter.h
index 12d934474554..d41e757cf51d 100644
--- a/cxl/filter.h
+++ b/cxl/filter.h
@@ -9,7 +9,9 @@
 struct cxl_filter_params {
 	const char *memdev_filter;
 	const char *serial_filter;
+	const char *bus_filter;
 	bool memdevs;
+	bool buses;
 	bool idle;
 	bool human;
 	bool health;
diff --git a/cxl/json.c b/cxl/json.c
index d8e65df241a1..a58459482360 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -221,3 +221,24 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 	}
 	return jdev;
 }
+
+struct json_object *util_cxl_bus_to_json(struct cxl_bus *bus,
+					 unsigned long flags)
+{
+	const char *devname = cxl_bus_get_devname(bus);
+	struct json_object *jbus, *jobj;
+
+	jbus = json_object_new_object();
+	if (!jbus)
+		return NULL;
+
+	jobj = json_object_new_string(devname);
+	if (jobj)
+		json_object_object_add(jbus, "bus", jobj);
+
+	jobj = json_object_new_string(cxl_bus_get_provider(bus));
+	if (jobj)
+		json_object_object_add(jbus, "provider", jobj);
+
+	return jbus;
+}
diff --git a/cxl/json.h b/cxl/json.h
index 3abcfe6661bf..4abf6e500f0b 100644
--- a/cxl/json.h
+++ b/cxl/json.h
@@ -1,8 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2015-2020 Intel Corporation. All rights reserved. */
+/* Copyright (C) 2015-2022 Intel Corporation. All rights reserved. */
 #ifndef __CXL_UTIL_JSON_H__
 #define __CXL_UTIL_JSON_H__
 struct cxl_memdev;
 struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 		unsigned long flags);
+struct cxl_bus;
+struct json_object *util_cxl_bus_to_json(struct cxl_bus *bus,
+					 unsigned long flags);
 #endif /* __CXL_UTIL_JSON_H__ */
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 9839f26f9507..8548a458b131 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -40,7 +40,9 @@ struct cxl_ctx {
 	int refcount;
 	void *userdata;
 	int memdevs_init;
+	int buses_init;
 	struct list_head memdevs;
+	struct list_head buses;
 	struct kmod_ctx *kmod_ctx;
 	void *private_data;
 };
@@ -64,6 +66,21 @@ static void free_memdev(struct cxl_memdev *memdev, struct list_head *head)
 	free(memdev);
 }
 
+static void __free_port(struct cxl_port *port, struct list_head *head)
+{
+	if (head)
+		list_del_from(head, &port->list);
+	free(port->dev_buf);
+	free(port->dev_path);
+	free(port->uport);
+}
+
+static void free_bus(struct cxl_bus *bus, struct list_head *head)
+{
+	__free_port(&bus->port, head);
+	free(bus);
+}
+
 /**
  * cxl_get_userdata - retrieve stored data pointer from library context
  * @ctx: cxl library context
@@ -130,6 +147,7 @@ CXL_EXPORT int cxl_new(struct cxl_ctx **ctx)
 	dbg(c, "log_priority=%d\n", c->ctx.log_priority);
 	*ctx = c;
 	list_head_init(&c->memdevs);
+	list_head_init(&c->buses);
 	c->kmod_ctx = kmod_ctx;
 
 	return 0;
@@ -160,6 +178,7 @@ CXL_EXPORT struct cxl_ctx *cxl_ref(struct cxl_ctx *ctx)
 CXL_EXPORT void cxl_unref(struct cxl_ctx *ctx)
 {
 	struct cxl_memdev *memdev, *_d;
+	struct cxl_bus *bus, *_b;
 
 	if (ctx == NULL)
 		return;
@@ -170,6 +189,9 @@ CXL_EXPORT void cxl_unref(struct cxl_ctx *ctx)
 	list_for_each_safe(&ctx->memdevs, memdev, _d, list)
 		free_memdev(memdev, &ctx->memdevs);
 
+	list_for_each_safe(&ctx->buses, bus, _b, port.list)
+		free_bus(bus, &ctx->buses);
+
 	kmod_unref(ctx->kmod_ctx);
 	info(ctx, "context %p released\n", ctx);
 	free(ctx);
@@ -449,6 +471,126 @@ CXL_EXPORT int cxl_memdev_nvdimm_bridge_active(struct cxl_memdev *memdev)
 	return is_enabled(path);
 }
 
+static int cxl_port_init(struct cxl_port *port, struct cxl_ctx *ctx, int id,
+			 const char *cxlport_base)
+{
+	char *path = calloc(1, strlen(cxlport_base) + 100);
+	size_t rc;
+
+	if (!path)
+		return -ENOMEM;
+
+	port->id = id;
+	port->ctx = ctx;
+
+	port->dev_path = strdup(cxlport_base);
+	if (!port->dev_path)
+		goto err;
+
+	port->dev_buf = calloc(1, strlen(cxlport_base) + 50);
+	if (!port->dev_buf)
+		goto err;
+	port->buf_len = strlen(cxlport_base) + 50;
+
+	rc = snprintf(port->dev_buf, port->buf_len, "%s/uport", cxlport_base);
+	if (rc >= port->buf_len)
+		goto err;
+	port->uport = realpath(port->dev_buf, NULL);
+	if (!port->uport)
+		goto err;
+
+	return 0;
+err:
+	free(port->dev_path);
+	free(port->dev_buf);
+	free(path);
+	return -ENOMEM;
+}
+
+static void *add_cxl_bus(void *parent, int id, const char *cxlbus_base)
+{
+	const char *devname = devpath_to_devname(cxlbus_base);
+	struct cxl_bus *bus, *bus_dup;
+	struct cxl_ctx *ctx = parent;
+	struct cxl_port *port;
+	int rc;
+
+	dbg(ctx, "%s: base: \'%s\'\n", devname, cxlbus_base);
+
+	bus = calloc(1, sizeof(*bus));
+	if (!bus)
+		return NULL;
+
+	port = &bus->port;
+	rc = cxl_port_init(port, ctx, id, cxlbus_base);
+	if (rc)
+		goto err;
+
+	cxl_bus_foreach(ctx, bus_dup)
+		if (bus_dup->port.id == bus->port.id) {
+			free_bus(bus, NULL);
+			return bus_dup;
+		}
+
+	list_add(&ctx->buses, &port->list);
+	return bus;
+
+err:
+	free(bus);
+	return NULL;
+}
+
+static void cxl_buses_init(struct cxl_ctx *ctx)
+{
+	if (ctx->buses_init)
+		return;
+
+	ctx->buses_init = 1;
+
+	sysfs_device_parse(ctx, "/sys/bus/cxl/devices", "root", ctx,
+			   add_cxl_bus);
+}
+
+CXL_EXPORT struct cxl_bus *cxl_bus_get_first(struct cxl_ctx *ctx)
+{
+	cxl_buses_init(ctx);
+
+	return list_top(&ctx->buses, struct cxl_bus, port.list);
+}
+
+CXL_EXPORT struct cxl_bus *cxl_bus_get_next(struct cxl_bus *bus)
+{
+	struct cxl_ctx *ctx = bus->port.ctx;
+
+	return list_next(&ctx->buses, bus, port.list);
+}
+
+CXL_EXPORT const char *cxl_bus_get_devname(struct cxl_bus *bus)
+{
+	struct cxl_port *port = &bus->port;
+
+	return devpath_to_devname(port->dev_path);
+}
+
+CXL_EXPORT int cxl_bus_get_id(struct cxl_bus *bus)
+{
+	struct cxl_port *port = &bus->port;
+
+	return port->id;
+}
+
+CXL_EXPORT const char *cxl_bus_get_provider(struct cxl_bus *bus)
+{
+	struct cxl_port *port = &bus->port;
+	const char *devname = devpath_to_devname(port->uport);
+
+	if (strcmp(devname, "ACPI0017:00") == 0)
+		return "ACPI.CXL";
+	if (strcmp(devname, "cxl_acpi.0") == 0)
+		return "cxl_test";
+	return devname;
+}
+
 CXL_EXPORT void cxl_cmd_unref(struct cxl_cmd *cmd)
 {
 	if (!cmd)
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 4411035f962a..781ff996af73 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -77,4 +77,9 @@ local:
 LIBCXL_2 {
 global:
 	cxl_memdev_get_serial;
+	cxl_bus_get_first;
+	cxl_bus_get_next;
+	cxl_bus_get_provider;
+	cxl_bus_get_devname;
+	cxl_bus_get_id;
 } LIBCXL_1;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index 7c81e24a6f79..0758d0578acf 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -34,6 +34,20 @@ struct cxl_memdev {
 	unsigned long long serial;
 };
 
+struct cxl_port {
+	int id;
+	void *dev_buf;
+	size_t buf_len;
+	char *dev_path;
+	char *uport;
+	struct cxl_ctx *ctx;
+	struct list_node list;
+};
+
+struct cxl_bus {
+	struct cxl_port port;
+};
+
 enum cxl_cmd_query_status {
 	CXL_CMD_QUERY_NOT_RUN = 0,
 	CXL_CMD_QUERY_OK,
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index bcdede8f12e8..da66eb298ab8 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -57,6 +57,17 @@ int cxl_memdev_write_label(struct cxl_memdev *memdev, void *buf, size_t length,
              memdev != NULL; \
              memdev = cxl_memdev_get_next(memdev))
 
+struct cxl_bus;
+struct cxl_bus *cxl_bus_get_first(struct cxl_ctx *ctx);
+struct cxl_bus *cxl_bus_get_next(struct cxl_bus *bus);
+const char *cxl_bus_get_provider(struct cxl_bus *bus);
+const char *cxl_bus_get_devname(struct cxl_bus *bus);
+int cxl_bus_get_id(struct cxl_bus *bus);
+
+#define cxl_bus_foreach(ctx, bus)                                              \
+	for (bus = cxl_bus_get_first(ctx); bus != NULL;                        \
+	     bus = cxl_bus_get_next(bus))
+
 struct cxl_cmd;
 const char *cxl_cmd_get_devname(struct cxl_cmd *cmd);
 struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev, int opcode);
diff --git a/cxl/list.c b/cxl/list.c
index 7e2744dd8b19..9500e610e0ca 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2020-2021 Intel Corporation. All rights reserved. */
+/* Copyright (C) 2020-2022 Intel Corporation. All rights reserved. */
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
@@ -14,11 +14,6 @@
 
 static struct cxl_filter_params param;
 
-static int num_list_flags(void)
-{
-	return param.memdevs;
-}
-
 static const struct option options[] = {
 	OPT_STRING('m', "memdev", &param.memdev_filter, "memory device name(s)",
 		   "filter by CXL memory device name(s)"),
@@ -27,6 +22,9 @@ static const struct option options[] = {
 		   "filter by CXL memory device serial number(s)"),
 	OPT_BOOLEAN('M', "memdevs", &param.memdevs,
 		    "include CXL memory device info"),
+	OPT_STRING('b', "bus", &param.bus_filter, "bus device name",
+		   "filter by CXL bus device name(s)"),
+	OPT_BOOLEAN('B', "buses", &param.buses, "include CXL bus info"),
 	OPT_BOOLEAN('i', "idle", &param.idle, "include disabled devices"),
 	OPT_BOOLEAN('u', "human", &param.human,
 		    "use human friendly number formats "),
@@ -35,6 +33,11 @@ static const struct option options[] = {
 	OPT_END(),
 };
 
+static int num_list_flags(void)
+{
+       return !!param.memdevs + !!param.buses;
+}
+
 int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 {
 	const char * const u[] = {
@@ -53,7 +56,9 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 	if (num_list_flags() == 0) {
 		if (param.memdev_filter || param.serial_filter)
 			param.memdevs = true;
-		else {
+		if (param.bus_filter)
+			param.buses = true;
+		if (num_list_flags() == 0) {
 			/*
 			 * TODO: We likely want to list regions by default if
 			 * nothing was explicitly asked for. But until we have

