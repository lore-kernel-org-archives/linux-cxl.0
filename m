Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB51C3DA7A
	for <linux-cxl@archiver.kernel.org>; Thu,  5 Jan 2023 21:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjAEVKK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 5 Jan 2023 16:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjAEVKI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 5 Jan 2023 16:10:08 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8CF5DE6E
        for <linux-cxl@vger.kernel.org>; Thu,  5 Jan 2023 13:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672953007; x=1704489007;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=Y/lXmRXpO1u/q8kZq6138i4nDz0mkUWyeX5C9Tp8Olc=;
  b=VYfn2SsryoiJT4VtEUxBqVwU5GrQqgKbbH05O0r5snIjgxI7YBh382MX
   WS8c9CYljRS2+A8dCNFVDNbckDTtAi+YcQOtoyqXdWvk7NEND8LsVAIeQ
   421Orm5gz9OLwG3+SB2Y4v9VaVJqQcOOww53ZQkeG8IO8piVJqShFqxzz
   QkRwSWhnX3Dl4wfB/IyKBEsmw1dzoxa6DPjIanz3Ir4blW6OZ5WWexJD+
   B3it1h1Csf1/7r2OqPCLqqvfHoO3Jm/+OBwu5Otr+xhI4bUJtJfWS6O6w
   YH8nDBdihAKnV+o4whQ68A32tP5qXGepetJRR6oApUcm+ZcVmXGJPiPEj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="324346904"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="324346904"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:10:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="657669836"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="657669836"
Received: from skarkerx-mobl1.amr.corp.intel.com (HELO vverma7-desk1.local) ([10.212.120.111])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:10:05 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Thu, 05 Jan 2023 14:09:49 -0700
Subject: [PATCH ndctl] Revert "cxl/list: Add parent_dport attribute to port listings"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230105-vv-revert-v1-1-45df35ad410b@intel.com>
X-B4-Tracking: v=1; b=H4sIAJ08t2MC/x2NQQqEMAxFryJZG0grijNXERdVUw1IZ0idMiDe3
 eDyPd7nn5BZhTO8qxOUi2T5JANXVzBvIa2MshiDJ9+QoxZLQetYDyRTne/dK0YC66eQGScNad5s
 kX77bvKrHOX/HAzjdd12kQvxcAAAAA==
To:     linux-cxl@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
X-Mailer: b4 0.11.0-dev-7e003
X-Developer-Signature: v=1; a=openpgp-sha256; l=4878;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=Y/lXmRXpO1u/q8kZq6138i4nDz0mkUWyeX5C9Tp8Olc=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDMnbbdYmyR+3WN5yxFRXYeMMXfcl9d3vdStOWC3bz/l+s/OV
 bXvrOkpZGMS4GGTFFFn+7vnIeExuez5PYIIjzBxWJpAhDFycAjCRfm5Ghj2aebM984IlPhpmRNyZk7
 Ltwf/cNuM1Z955qPW8FA73OMfwV3RdvqDUWq2f9gscxXc+v6PpdPvE7u8mnw33VjRvM37Pzg0A
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This reverts commit 6df696a5debfd619ddcd480b51249e3d7a254e7c.

Dan writes[1]:

  I should not have sent this out. It was sitting in my development tree
  for other work, but should have been held back until the kernel support
  landed.

  Drop this for now as the kernel support will not arrive until v6.3:

  http://lore.kernel.org/r/167124082375.1626103.6047000000121298560.stgit@dwillia2-xfh.jf.intel.com

[1]: https://lore.kernel.org/all/639d1d3bc99a_b41e32948@dwillia2-xfh.jf.intel.com.notmuch/

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/lib/private.h  |  2 --
 cxl/lib/libcxl.c   | 38 --------------------------------------
 cxl/libcxl.h       |  1 -
 cxl/json.c         |  8 --------
 cxl/lib/libcxl.sym |  1 -
 5 files changed, 50 deletions(-)

diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index 81d6fac..f8871bd 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -63,8 +63,6 @@ struct cxl_port {
 	size_t buf_len;
 	char *dev_path;
 	char *uport;
-	char *parent_dport_path;
-	struct cxl_dport *parent_dport;
 	int ports_init;
 	int endpoints_init;
 	int decoders_init;
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index abc7344..4205a58 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -165,7 +165,6 @@ static void __free_port(struct cxl_port *port, struct list_head *head)
 	free(port->dev_buf);
 	free(port->dev_path);
 	free(port->uport);
-	free(port->parent_dport_path);
 }
 
 static void free_port(struct cxl_port *port, struct list_head *head)
@@ -1543,20 +1542,6 @@ static int cxl_port_init(struct cxl_port *port, struct cxl_port *parent_port,
 	if (!port->uport)
 		goto err;
 
-	/*
-	 * CXL root devices have no parents and level 1 ports are both
-	 * CXL root targets and hosts of the next level, so:
-	 *     parent_dport == uport
-	 * ...at depth == 1
-	 */
-	if (port->depth > 1) {
-		rc = snprintf(port->dev_buf, port->buf_len, "%s/parent_dport",
-			      cxlport_base);
-		if (rc >= port->buf_len)
-			goto err;
-		port->parent_dport_path = realpath(port->dev_buf, NULL);
-	}
-
 	sprintf(path, "%s/modalias", cxlport_base);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		port->module = util_modalias_to_module(ctx, buf);
@@ -2532,29 +2517,6 @@ CXL_EXPORT const char *cxl_port_get_host(struct cxl_port *port)
 	return devpath_to_devname(port->uport);
 }
 
-CXL_EXPORT struct cxl_dport *cxl_port_get_parent_dport(struct cxl_port *port)
-{
-	struct cxl_port *parent;
-	struct cxl_dport *dport;
-	const char *name;
-
-	if (port->parent_dport)
-		return port->parent_dport;
-
-	if (!port->parent_dport_path)
-		return NULL;
-
-	parent = cxl_port_get_parent(port);
-	name = devpath_to_devname(port->parent_dport_path);
-	cxl_dport_foreach(parent, dport)
-		if (strcmp(cxl_dport_get_devname(dport), name) == 0) {
-			port->parent_dport = dport;
-			return dport;
-		}
-
-	return NULL;
-}
-
 CXL_EXPORT bool cxl_port_hosts_memdev(struct cxl_port *port,
 				      struct cxl_memdev *memdev)
 {
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 499b965..cc1b90c 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -96,7 +96,6 @@ bool cxl_port_is_endpoint(struct cxl_port *port);
 struct cxl_endpoint *cxl_port_to_endpoint(struct cxl_port *port);
 struct cxl_bus *cxl_port_get_bus(struct cxl_port *port);
 const char *cxl_port_get_host(struct cxl_port *port);
-struct cxl_dport *cxl_port_get_parent_dport(struct cxl_port *port);
 bool cxl_port_hosts_memdev(struct cxl_port *port, struct cxl_memdev *memdev);
 int cxl_port_get_nr_dports(struct cxl_port *port);
 int cxl_port_disable_invalidate(struct cxl_port *port);
diff --git a/cxl/json.c b/cxl/json.c
index 0b0bf7c..0fc44e4 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -982,14 +982,6 @@ static struct json_object *__util_cxl_port_to_json(struct cxl_port *port,
 	if (jobj)
 		json_object_object_add(jport, "host", jobj);
 
-	if (cxl_port_get_parent_dport(port)) {
-		struct cxl_dport *dport = cxl_port_get_parent_dport(port);
-
-		jobj = json_object_new_string(cxl_dport_get_devname(dport));
-		if (jobj)
-			json_object_object_add(jport, "parent_dport", jobj);
-	}
-
 	jobj = json_object_new_int(cxl_port_get_depth(port));
 	if (jobj)
 		json_object_object_add(jport, "depth", jobj);
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index c02d0a6..6bc0810 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -241,5 +241,4 @@ global:
 	cxl_cmd_alert_config_get_corrected_pmem_err_prog_warn_threshold;
 	cxl_target_get_firmware_node;
 	cxl_dport_get_firmware_node;
-	cxl_port_get_parent_dport;
 } LIBCXL_3;

---
base-commit: 45b9d1e2256bbcc71b9572e06865a5069ed382fc
change-id: 20230105-vv-revert-002362819ff0

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>
