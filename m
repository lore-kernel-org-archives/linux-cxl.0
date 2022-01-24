Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5AFC433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbiAXAxf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:53:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:11570 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240660AbiAXAxf (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985615; x=1674521615;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nlNfJkKl8APMxEXgALkB1i3Sa/zDe5+OYQ/NpI1ky10=;
  b=dr690TEe/CTCcJvbgdlNmMtIC9hqmPd0Agws2OvQPWb3vyAFlCr+773s
   t7GlhWu4qC4On2haMeE4Dqsfp3bqQJaTQ+4AoItcnWCUQ/Rs3yX1lA4Ne
   oYK5/CF/iSCFIq89M3gB1ZGmw2mHOREkFbmgtwWsttyoj1lqJUrxmVmFZ
   Uwsj+8LXpZ+p85IPvgw/uf3GHSok6fVWZ8x1i7cSlkeImg4l05HnZ/s5P
   Yz0/YGw3UUD/vu8wxavXZTK4WQ3BXz7WVV3BfWr1YWJK/AruOiStOqa8S
   nKVeZ3Z8dh9caLSNNxTCmvRqoUm+iATh3AqNcEqSxHhhJDtIvjXGQzGho
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245716883"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245716883"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:53:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="695243471"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:53:34 -0800
Subject: [ndctl PATCH 20/37] cxl/list: Add 'host' entries for port-like
 objects
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:53:34 -0800
Message-ID: <164298561473.3021641.16508989603599026269.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add the device name of the "host" device for a given CXL port object. The
kernel calls this the 'uport' attribute.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/cxl/cxl-list.txt   |    9 +++++++++
 Documentation/cxl/lib/libcxl.txt |    5 +++++
 cxl/json.c                       |    4 ++++
 cxl/lib/libcxl.c                 |   10 ++++++++++
 cxl/lib/libcxl.sym               |    2 ++
 cxl/libcxl.h                     |    2 ++
 6 files changed, 32 insertions(+)

diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
index d342da27d3da..30b61615644b 100644
--- a/Documentation/cxl/cxl-list.txt
+++ b/Documentation/cxl/cxl-list.txt
@@ -210,6 +210,15 @@ OPTIONS
 --endpoints::
 	Include endpoint objects (CXL Memory Device decoders) in the
 	listing.
+----
+# cxl list -E
+[
+  {
+    "endpoint":"endpoint2",
+    "host":"mem0"
+  }
+]
+----
 
 -e::
 --endpoint::
diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index eebab37acb3d..e4b372d781ec 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -178,6 +178,7 @@ struct cxl_port *cxl_port_get_next(struct cxl_port *port);
 struct cxl_port *cxl_port_get_parent(struct cxl_port *port);
 struct cxl_bus *cxl_port_get_bus(struct cxl_port *port);
 struct cxl_ctx *cxl_port_get_ctx(struct cxl_port *port);
+const char *cxl_port_get_host(struct cxl_port *port);
 
 #define cxl_port_foreach(parent, port)                                      \
        for (port = cxl_port_get_first(parent); port != NULL;                \
@@ -192,6 +193,9 @@ as a parent object retrievable via cxl_port_get_parent().
 The root port of a hiearchy can be retrieved via any port instance in
 that hierarchy via cxl_port_get_bus().
 
+The host of a port is the corresponding device name of the PCIe Root
+Port, or Switch Upstream Port with CXL capabilities.
+
 === PORT: Attributes
 ----
 const char *cxl_port_get_devname(struct cxl_port *port);
@@ -222,6 +226,7 @@ struct cxl_endpoint *cxl_endpoint_get_next(struct cxl_endpoint *endpoint);
 struct cxl_ctx *cxl_endpoint_get_ctx(struct cxl_endpoint *endpoint);
 struct cxl_port *cxl_endpoint_get_parent(struct cxl_endpoint *endpoint);
 struct cxl_port *cxl_endpoint_get_port(struct cxl_endpoint *endpoint);
+const char *cxl_endpoint_get_host(struct cxl_endpoint *endpoint);
 
 #define cxl_endpoint_foreach(port, endpoint)                                 \
        for (endpoint = cxl_endpoint_get_first(port); endpoint != NULL;       \
diff --git a/cxl/json.c b/cxl/json.c
index 08f6192fe121..af3b4fe6a0eb 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -258,6 +258,10 @@ static struct json_object *__util_cxl_port_to_json(struct cxl_port *port,
 	if (jobj)
 		json_object_object_add(jport, name_key, jobj);
 
+	jobj = json_object_new_string(cxl_port_get_host(port));
+	if (jobj)
+		json_object_object_add(jport, "host", jobj);
+
 	if (!cxl_port_is_enabled(port)) {
 		jobj = json_object_new_string("disabled");
 		if (jobj)
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index a25e7152af2a..5f48202d7b93 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -626,6 +626,11 @@ CXL_EXPORT struct cxl_port *cxl_endpoint_get_port(struct cxl_endpoint *endpoint)
 	return &endpoint->port;
 }
 
+CXL_EXPORT const char *cxl_endpoint_get_host(struct cxl_endpoint *endpoint)
+{
+	return cxl_port_get_host(&endpoint->port);
+}
+
 CXL_EXPORT int cxl_endpoint_is_enabled(struct cxl_endpoint *endpoint)
 {
 	return cxl_port_is_enabled(&endpoint->port);
@@ -744,6 +749,11 @@ CXL_EXPORT struct cxl_bus *cxl_port_get_bus(struct cxl_port *port)
 	return bus;
 }
 
+CXL_EXPORT const char *cxl_port_get_host(struct cxl_port *port)
+{
+	return devpath_to_devname(port->uport);
+}
+
 CXL_EXPORT int cxl_port_is_enabled(struct cxl_port *port)
 {
 	struct cxl_ctx *ctx = cxl_port_get_ctx(port);
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 7a51a0c42069..dc2863e150cf 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -95,6 +95,7 @@ global:
 	cxl_port_to_bus;
 	cxl_port_is_endpoint;
 	cxl_port_get_bus;
+	cxl_port_get_host;
 	cxl_endpoint_get_first;
 	cxl_endpoint_get_next;
 	cxl_endpoint_get_devname;
@@ -103,4 +104,5 @@ global:
 	cxl_endpoint_is_enabled;
 	cxl_endpoint_get_parent;
 	cxl_endpoint_get_port;
+	cxl_endpoint_get_host;
 } LIBCXL_1;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index f6ba9a105168..a60777ed0c7a 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -83,6 +83,7 @@ bool cxl_port_is_switch(struct cxl_port *port);
 struct cxl_bus *cxl_port_to_bus(struct cxl_port *port);
 bool cxl_port_is_endpoint(struct cxl_port *port);
 struct cxl_bus *cxl_port_get_bus(struct cxl_port *port);
+const char *cxl_port_get_host(struct cxl_port *port);
 
 #define cxl_port_foreach(parent, port)                                         \
 	for (port = cxl_port_get_first(parent); port != NULL;                  \
@@ -97,6 +98,7 @@ struct cxl_ctx *cxl_endpoint_get_ctx(struct cxl_endpoint *endpoint);
 int cxl_endpoint_is_enabled(struct cxl_endpoint *endpoint);
 struct cxl_port *cxl_endpoint_get_parent(struct cxl_endpoint *endpoint);
 struct cxl_port *cxl_endpoint_get_port(struct cxl_endpoint *endpoint);
+const char *cxl_endpoint_get_host(struct cxl_endpoint *endpoint);
 
 #define cxl_endpoint_foreach(port, endpoint)                                   \
 	for (endpoint = cxl_endpoint_get_first(port); endpoint != NULL;        \

