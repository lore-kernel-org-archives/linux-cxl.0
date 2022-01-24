Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F5EC433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240676AbiAXAy5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:54:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:25351 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231628AbiAXAy4 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985696; x=1674521696;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FJcfpXnGz+jKXO1P3sWn4Vu3HfzGvee4hTeCss78DO8=;
  b=aE8WByyEJbhgU8KQfjxJ7IC1FwDUS7MKvcW6+UT4873qCaqvydVUssZN
   wclyNX4VGRjxlXcO/Wp/t1hq5abIJ+h9c2QFCI2kuYEKCN3AdDO43pfqK
   0SHF61cUevl3jGUBvFZ9B7A0vwHTCfTdPA/pzo0pzFQDPgGWoA0YZ9KW7
   NkPDlq9/K0PjKV7z6EAjowCYiM6R/dPsBuZRHt+IvK9j0Y5CqcQPXoz08
   Xul7sexVWPmMJ5sOFSJXQ7Hb7JbKfpBF29CxIb8PfWu17c62FalxRIv93
   Y38z0JIauMa0aWzYD9xKGd/LCVqxaq1snf1ucPvUuezDqs+WVANfu6nGW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226609738"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226609738"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:54:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="596630878"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:54:56 -0800
Subject: [ndctl PATCH 35/37] cxl/list: Support filtering memdevs by ports
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:54:55 -0800
Message-ID: <164298569568.3021641.888802471376117408.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The ability to filter memdevs by decoders falls short when the decoder does
not have its target list programmed. So, introduce a by port filter to show
the potential memdevs that can be targeted by the decoder.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/cxl/cxl-list.txt   |    3 ++
 Documentation/cxl/lib/libcxl.txt |    7 +++++
 cxl/filter.c                     |   50 ++++++++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.c                 |   23 +++++++++++++++++
 cxl/lib/libcxl.sym               |    2 ++
 cxl/libcxl.h                     |    3 ++
 6 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
index 04e831ed3f34..90e6d9f9658b 100644
--- a/Documentation/cxl/cxl-list.txt
+++ b/Documentation/cxl/cxl-list.txt
@@ -63,7 +63,8 @@ one or more memdevs. For example:
 ----
 Additionally, when provisioning new interleave configurations it is
 useful to know which memdevs can be referenced by a given decoder like a
-root decoder:
+root decoder, or mapped by a given port if the decoders are not
+configured.
 ----
 # cxl list -Mu -d decoder0.0
 {
diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index 5ad3027acd24..a0fcee987b03 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -276,11 +276,12 @@ CXL / PCIe host bridge.
 ----
 struct cxl_dport *cxl_dport_get_first(struct cxl_port *port);
 struct cxl_dport *cxl_dport_get_next(struct cxl_dport *dport);
+struct cxl_dport *cxl_port_get_dport_by_memdev(struct cxl_port *port,
+                                               struct cxl_memdev *memdev);
 
 #define cxl_dport_foreach(port, dport)                                     \
        for (dport = cxl_dport_get_first(port); dport != NULL;              \
             dport = cxl_dport_get_next(dport))
-
 ----
 
 ===== DPORT: Attributes
@@ -288,12 +289,16 @@ struct cxl_dport *cxl_dport_get_next(struct cxl_dport *dport);
 const char *cxl_dport_get_devname(struct cxl_dport *dport);
 const char *cxl_dport_get_physical_node(struct cxl_dport *dport);
 int cxl_dport_get_id(struct cxl_dport *dport);
+bool cxl_dport_maps_memdev(struct cxl_dport *dport, struct cxl_memdev *memdev);
 ----
 The id of a dport is the hardware idenfifier used by an upstream port to
 reference a downstream port. The physical node of a dport is only
 available for platform firmware defined downstream ports and alias the
 companion object, like a PCI host bridge, in the PCI device hierarchy.
 
+The cxl_dport_maps_memdev() helper checks if a dport is an ancestor of a
+given memdev.
+
 ENDPOINTS
 ---------
 CXL endpoint objects encapsulate the set of host-managed device-memory
diff --git a/cxl/filter.c b/cxl/filter.c
index c972545eb0de..c691edf9501e 100644
--- a/cxl/filter.c
+++ b/cxl/filter.c
@@ -486,6 +486,53 @@ util_cxl_memdev_filter_by_decoder(struct cxl_memdev *memdev, const char *ident)
 	return NULL;
 }
 
+static bool __memdev_filter_by_port(struct cxl_memdev *memdev,
+				    struct cxl_port *port,
+				    const char *port_ident)
+{
+	struct cxl_endpoint *endpoint;
+
+	if (util_cxl_port_filter(port, port_ident, CXL_PF_SINGLE) &&
+	    cxl_port_get_dport_by_memdev(port, memdev))
+		return true;
+
+	cxl_endpoint_foreach(port, endpoint)
+		if (__memdev_filter_by_port(memdev,
+					    cxl_endpoint_get_port(endpoint),
+					    port_ident))
+			return true;
+	return false;
+}
+
+static struct cxl_memdev *
+util_cxl_memdev_filter_by_port(struct cxl_memdev *memdev, const char *bus_ident,
+			       const char *port_ident)
+{
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	struct cxl_bus *bus;
+
+	if (!bus_ident && !port_ident)
+		return memdev;
+
+	cxl_bus_foreach(ctx, bus) {
+		struct cxl_port *port, *top;
+
+		port = cxl_bus_get_port(bus);
+		if (util_cxl_bus_filter(bus, bus_ident))
+			if (__memdev_filter_by_port(memdev, port,
+						    cxl_bus_get_devname(bus)))
+				return memdev;
+		if (__memdev_filter_by_port(memdev, port, port_ident))
+				return memdev;
+		top = port;
+		cxl_port_foreach_all(top, port)
+			if (__memdev_filter_by_port(memdev, port, port_ident))
+				return memdev;
+	}
+
+	return NULL;
+}
+
 static unsigned long params_to_flags(struct cxl_filter_params *param)
 {
 	unsigned long flags = 0;
@@ -647,6 +694,9 @@ static void walk_endpoints(struct cxl_port *port, struct cxl_filter_params *p,
 			if (!util_cxl_memdev_filter_by_decoder(
 				    memdev, p->decoder_filter))
 				continue;
+			if (!util_cxl_memdev_filter_by_port(
+				    memdev, p->bus_filter, p->port_filter))
+				continue;
 			if (!p->idle && !cxl_memdev_is_enabled(memdev))
 				continue;
 			jobj = util_cxl_memdev_to_json(memdev, flags);
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 4ebb8b9a5e7f..dcfc82689ca9 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1452,6 +1452,29 @@ CXL_EXPORT int cxl_dport_get_id(struct cxl_dport *dport)
 	return dport->id;
 }
 
+CXL_EXPORT bool cxl_dport_maps_memdev(struct cxl_dport *dport,
+				      struct cxl_memdev *memdev)
+{
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+
+	dbg(ctx, "memdev: %s dport: %s\n", memdev->host_path, dport->dev_path);
+
+	if (dport->phys_path)
+		return !!strstr(memdev->host_path, dport->phys_path);
+	return !!strstr(memdev->host_path, dport->dev_path);
+}
+
+CXL_EXPORT struct cxl_dport *
+cxl_port_get_dport_by_memdev(struct cxl_port *port, struct cxl_memdev *memdev)
+{
+	struct cxl_dport *dport;
+
+	cxl_dport_foreach(port, dport)
+		if (cxl_dport_maps_memdev(dport, memdev))
+			return dport;
+	return NULL;
+}
+
 static void *add_cxl_bus(void *parent, int id, const char *cxlbus_base)
 {
 	const char *devname = devpath_to_devname(cxlbus_base);
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 0190b132d3d6..2c8358e1683e 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -149,4 +149,6 @@ global:
 	cxl_dport_get_devname;
 	cxl_dport_get_physical_node;
 	cxl_dport_get_id;
+	cxl_port_get_dport_by_memdev;
+	cxl_dport_maps_memdev;
 } LIBCXL_1;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 874c38188a2c..c8d07bb4efc4 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -111,6 +111,9 @@ struct cxl_dport *cxl_dport_get_next(struct cxl_dport *dport);
 const char *cxl_dport_get_devname(struct cxl_dport *dport);
 const char *cxl_dport_get_physical_node(struct cxl_dport *dport);
 int cxl_dport_get_id(struct cxl_dport *dport);
+bool cxl_dport_maps_memdev(struct cxl_dport *dport, struct cxl_memdev *memdev);
+struct cxl_dport *cxl_port_get_dport_by_memdev(struct cxl_port *port,
+					       struct cxl_memdev *memdev);
 
 #define cxl_dport_foreach(port, dport)                                         \
 	for (dport = cxl_dport_get_first(port); dport != NULL;                 \

