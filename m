Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308D8C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240675AbiAXAyv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:54:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:17188 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235402AbiAXAyv (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:54:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985691; x=1674521691;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mom4QJ/T0FQt2B0JiML3zf5EjbhEX5NfzRqjfX09kS0=;
  b=fGlZkR9/N/K+SzuJ3pnlPVv//biyOMaT38lEj5Ku4H0yUvLg5D8MQ+jf
   sresHGOnJACoT48A1aNBe9WFuB65V/aCcfxSTJH5OYFIhneMWTea0mCJb
   w13aNZnU+6yp7MyD640QYQYxSMP4CykmwirnSdYwnQA51nHITJi2tNjZy
   UQTNODBp7GEFgjikRKIsTquDFv/9LqJPGz1kj1GZZCbVmU9SxWX5U5i+v
   Lvv8gsRsaTcuChuC0d8QU1Oc9KziXncvGF+/V7HXwmJa+5KEAToCRDYQ3
   LJCDvgXmJXxebhU8tK3QLtKRhrgomRojmtVTgbtvQQCCSSF9jXOdXCy/m
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="306652216"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="306652216"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:54:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="617065202"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:54:50 -0800
Subject: [ndctl PATCH 34/37] cxl/list: Support filtering memdevs by decoders
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:54:50 -0800
Message-ID: <164298569017.3021641.15558596583530530035.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In order to filter memdevs by decoders all the ports in the hierarchy need
to be iterated, so introduce cxl_port_foreach_all() that starts at the bus
and does a depth first iteration of all the descendant ports.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 .clang-format                    |    1 +
 Documentation/cxl/cxl-list.txt   |   13 ++++++++++
 Documentation/cxl/lib/libcxl.txt |   11 +++++++++
 cxl/filter.c                     |   48 ++++++++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.c                 |   13 ++++++++++
 cxl/libcxl.h                     |    6 +++++
 6 files changed, 92 insertions(+)

diff --git a/.clang-format b/.clang-format
index c75348764105..6aabcb68e6a9 100644
--- a/.clang-format
+++ b/.clang-format
@@ -84,6 +84,7 @@ ForEachMacros:
   - 'cxl_target_foreach'
   - 'cxl_dport_foreach'
   - 'cxl_endpoint_foreach'
+  - 'cxl_port_foreach_all'
   - 'daxctl_dev_foreach'
   - 'daxctl_mapping_foreach'
   - 'daxctl_region_foreach'
diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
index e1299d9fbd84..04e831ed3f34 100644
--- a/Documentation/cxl/cxl-list.txt
+++ b/Documentation/cxl/cxl-list.txt
@@ -61,6 +61,19 @@ one or more memdevs. For example:
   }
 ]
 ----
+Additionally, when provisioning new interleave configurations it is
+useful to know which memdevs can be referenced by a given decoder like a
+root decoder:
+----
+# cxl list -Mu -d decoder0.0
+{
+  "memdev":"mem0",
+  "pmem_size":"256.00 MiB (268.44 MB)",
+  "ram_size":0,
+  "serial":"0",
+  "host":"0000:35:00.0"
+}
+----
 
 The --human option in addition to reformatting some fields to more human
 friendly strings also unwraps the array to reduce the number of lines of
diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index 2e8570d18a86..5ad3027acd24 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -219,10 +219,18 @@ struct cxl_port *cxl_port_get_parent(struct cxl_port *port);
 struct cxl_ctx *cxl_port_get_ctx(struct cxl_port *port);
 const char *cxl_port_get_host(struct cxl_port *port);
 struct cxl_port *cxl_decoder_get_port(struct cxl_decoder *decoder);
+struct cxl_port *cxl_port_get_next_all(struct cxl_port *port,
+                                       const struct cxl_port *top);
 
 #define cxl_port_foreach(parent, port)                                      \
        for (port = cxl_port_get_first(parent); port != NULL;                \
             port = cxl_port_get_next(port))
+
+#define cxl_port_foreach_all(top, port)                                        \
+       for (port = cxl_port_get_first(top); port != NULL;                     \
+            port = cxl_port_get_next_all(port, top))
+
+
 ----
 A bus object encapsulates a CXL port object. Use cxl_bus_get_port() to
 use generic port APIs on root objects.
@@ -236,6 +244,9 @@ that hierarchy via cxl_port_get_bus().
 The host of a port is the corresponding device name of the PCIe Root
 Port, or Switch Upstream Port with CXL capabilities.
 
+The cxl_port_foreach_all() helper does a depth first iteration of all
+ports beneath the 'top' port argument.
+
 === PORT: Attributes
 ----
 const char *cxl_port_get_devname(struct cxl_port *port);
diff --git a/cxl/filter.c b/cxl/filter.c
index 05ede9116559..c972545eb0de 100644
--- a/cxl/filter.c
+++ b/cxl/filter.c
@@ -441,6 +441,51 @@ util_cxl_decoder_filter_by_memdev(struct cxl_decoder *decoder,
 	return NULL;
 }
 
+static bool __memdev_filter_by_decoder(struct cxl_memdev *memdev,
+				       struct cxl_port *port, const char *ident)
+{
+	struct cxl_decoder *decoder;
+	struct cxl_endpoint *endpoint;
+
+	cxl_decoder_foreach(port, decoder) {
+		if (!util_cxl_decoder_filter(decoder, ident))
+			continue;
+		if (cxl_decoder_get_target_by_memdev(decoder, memdev))
+			return true;
+	}
+
+	cxl_endpoint_foreach(port, endpoint)
+		if (__memdev_filter_by_decoder(
+			    memdev, cxl_endpoint_get_port(endpoint), ident))
+			return true;
+	return false;
+}
+
+static struct cxl_memdev *
+util_cxl_memdev_filter_by_decoder(struct cxl_memdev *memdev, const char *ident)
+{
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	struct cxl_bus *bus;
+
+	if (!ident)
+		return memdev;
+
+	cxl_bus_foreach(ctx, bus) {
+		struct cxl_port *port, *top;
+
+		port = cxl_bus_get_port(bus);
+		if (__memdev_filter_by_decoder(memdev, port, ident))
+			return memdev;
+
+		top = port;
+		cxl_port_foreach_all(top, port)
+			if (__memdev_filter_by_decoder(memdev, port, ident))
+				return memdev;
+	}
+
+	return NULL;
+}
+
 static unsigned long params_to_flags(struct cxl_filter_params *param)
 {
 	unsigned long flags = 0;
@@ -599,6 +644,9 @@ static void walk_endpoints(struct cxl_port *port, struct cxl_filter_params *p,
 			if (!util_cxl_memdev_filter(memdev, p->memdev_filter,
 						    p->serial_filter))
 				continue;
+			if (!util_cxl_memdev_filter_by_decoder(
+				    memdev, p->decoder_filter))
+				continue;
 			if (!p->idle && !cxl_memdev_is_enabled(memdev))
 				continue;
 			jobj = util_cxl_memdev_to_json(memdev, flags);
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index d7a3f1084465..4ebb8b9a5e7f 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1257,6 +1257,19 @@ CXL_EXPORT struct cxl_port *cxl_port_get_next(struct cxl_port *port)
 	return list_next(&parent_port->child_ports, port, list);
 }
 
+CXL_EXPORT struct cxl_port *cxl_port_get_next_all(struct cxl_port *port,
+						  const struct cxl_port *top)
+{
+	struct cxl_port *child, *iter = port;
+
+	child = cxl_port_get_first(iter);
+	if (child)
+		return child;
+	while (!cxl_port_get_next(iter) && iter->parent && iter->parent != top)
+		iter = iter->parent;
+	return cxl_port_get_next(iter);
+}
+
 CXL_EXPORT const char *cxl_port_get_devname(struct cxl_port *port)
 {
 	return devpath_to_devname(port->dev_path);
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 07f4a311d29d..874c38188a2c 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -94,11 +94,17 @@ struct cxl_bus *cxl_port_get_bus(struct cxl_port *port);
 const char *cxl_port_get_host(struct cxl_port *port);
 bool cxl_port_hosts_memdev(struct cxl_port *port, struct cxl_memdev *memdev);
 int cxl_port_get_nr_dports(struct cxl_port *port);
+struct cxl_port *cxl_port_get_next_all(struct cxl_port *port,
+				       const struct cxl_port *top);
 
 #define cxl_port_foreach(parent, port)                                         \
 	for (port = cxl_port_get_first(parent); port != NULL;                  \
 	     port = cxl_port_get_next(port))
 
+#define cxl_port_foreach_all(top, port)                                        \
+	for (port = cxl_port_get_first(top); port != NULL;                     \
+	     port = cxl_port_get_next_all(port, top))
+
 struct cxl_dport;
 struct cxl_dport *cxl_dport_get_first(struct cxl_port *port);
 struct cxl_dport *cxl_dport_get_next(struct cxl_dport *dport);

