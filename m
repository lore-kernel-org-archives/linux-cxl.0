Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC42C00140
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Aug 2022 20:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbiHEUiX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 Aug 2022 16:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbiHEUiV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 Aug 2022 16:38:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699BCDFA
        for <linux-cxl@vger.kernel.org>; Fri,  5 Aug 2022 13:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659731901; x=1691267901;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fTkPZf5LUDV9uSdQ8Nq40J4VCpvD6Kql8fzcFn4kgVc=;
  b=b+xaWp3MU9n99c3O5+Ck7mXRO1dvR3LWbnLNaQ/rUwVhn8fa0Rg6WWqd
   zNDfKC2pXJOw78IixbgWtI7kz0uPSUixEsD065B2li1bs33vFcLMTZeVl
   /mhFnP+PfOKtHxbTO+03fdbgHQGIWOpA5WIRMxSp5SiKEbqxJXF4qLG4X
   k+D4D9YGvw1HkYiIVm2Vr1+diiFffWwB9uu7JxRCBb4E2KHEtB7xOHlxZ
   qRjzlk5Ng18xZMP3en6+tfL8KtIvZeWCCIB/SXh/CRFQe6wuy+Ym2WEOU
   G5wwZmwpwrH7zPuLUfThJVLck8CDQysAwgMg8I8vkZ0l8xCPQtZwtwGN/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="290293762"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="290293762"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:38:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="693118037"
Received: from jivaldiv-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.255.228.201])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:38:20 -0700
Subject: [ndctl PATCH 5/6] cxl/list: Add 'depth' to port listings
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com
Date:   Fri, 05 Aug 2022 13:38:20 -0700
Message-ID: <165973190022.1528532.6351628365510289908.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165973187080.1528532.8097010788284626448.stgit@dwillia2-xfh.jf.intel.com>
References: <165973187080.1528532.8097010788284626448.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Simplify the task of determining how deep a port is in the hierarchy by
just emitting what libcxl already counted. This is useful for validating
interleave math.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/cxl/lib/libcxl.txt |    1 +
 cxl/json.c                       |    4 ++++
 cxl/lib/libcxl.c                 |    5 +++++
 cxl/lib/libcxl.sym               |    1 +
 cxl/libcxl.h                     |    1 +
 5 files changed, 12 insertions(+)

diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index 72641699633b..5efa60124111 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -290,6 +290,7 @@ int cxl_port_is_enabled(struct cxl_port *port);
 bool cxl_port_is_root(struct cxl_port *port);
 bool cxl_port_is_switch(struct cxl_port *port);
 bool cxl_port_is_endpoint(struct cxl_port *port);
+int cxl_port_get_depth(struct cxl_port *port);
 bool cxl_port_hosts_memdev(struct cxl_port *port, struct cxl_memdev *memdev);
 int cxl_port_get_nr_dports(struct cxl_port *port);
 ----
diff --git a/cxl/json.c b/cxl/json.c
index 82e3c552cdb1..7aefcadb0795 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -761,6 +761,10 @@ static struct json_object *__util_cxl_port_to_json(struct cxl_port *port,
 	if (jobj)
 		json_object_object_add(jport, "host", jobj);
 
+	jobj = json_object_new_int(cxl_port_get_depth(port));
+	if (jobj)
+		json_object_object_add(jport, "depth", jobj);
+
 	if (!cxl_port_is_enabled(port)) {
 		jobj = json_object_new_string("disabled");
 		if (jobj)
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index aec3671b1625..4b78ecc1d115 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -2309,6 +2309,11 @@ CXL_EXPORT bool cxl_port_is_endpoint(struct cxl_port *port)
 	return port->type == CXL_PORT_ENDPOINT;
 }
 
+CXL_EXPORT int cxl_port_get_depth(struct cxl_port *port)
+{
+	return port->depth;
+}
+
 CXL_EXPORT struct cxl_bus *cxl_port_get_bus(struct cxl_port *port)
 {
 	struct cxl_bus *bus;
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 573fcdf532d6..7dc3eee8a63c 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -96,6 +96,7 @@ global:
 	cxl_port_get_parent;
 	cxl_port_is_root;
 	cxl_port_is_switch;
+	cxl_port_get_depth;
 	cxl_port_to_bus;
 	cxl_port_is_endpoint;
 	cxl_port_to_endpoint;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 4b5490986a2a..aa0a89d91b30 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -89,6 +89,7 @@ int cxl_port_is_enabled(struct cxl_port *port);
 struct cxl_port *cxl_port_get_parent(struct cxl_port *port);
 bool cxl_port_is_root(struct cxl_port *port);
 bool cxl_port_is_switch(struct cxl_port *port);
+int cxl_port_get_depth(struct cxl_port *port);
 struct cxl_bus *cxl_port_to_bus(struct cxl_port *port);
 bool cxl_port_is_endpoint(struct cxl_port *port);
 struct cxl_endpoint *cxl_port_to_endpoint(struct cxl_port *port);

