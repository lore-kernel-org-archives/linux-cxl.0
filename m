Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E377C4708D
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Jan 2023 20:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbjADUa6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Jan 2023 15:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240281AbjADUa6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Jan 2023 15:30:58 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36F0C52
        for <linux-cxl@vger.kernel.org>; Wed,  4 Jan 2023 12:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672864256; x=1704400256;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hd1ntTn2RqxxgOwywG/94b66ZkO5bd1rgc7M4D/4KnU=;
  b=hE8aRnRlQwiMVPsAt0J2RNSg0Emg/OA2ypGh6S1GTXG0dwfoGVHsTf8u
   hM4LkevKFT93ELdsBGOxeIOU0pOsOgmtYF6MCAvdCMzb0kO/MOHrktwYV
   HsQ1fmkl0dZjECPLjgLdqAkWs5WjFfWmV6eJkIkKC7L2HtdCwM0E9aNxL
   NvWjdDMJKypDWs/PbzWCuh2VS14MH7n02XhxCyrpYVN8bKztXPks92acw
   JnTWCdJFNZGN6p4NdRJiwETNRiLVoAjbbzrHQYLBseM3/Iw8WqDRMOzi8
   PjLaTrPcj7UlShFwkkVaNJ/W2O21+N9o+HmyPWVMhR5hRiSm16kQi8qQp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="324038124"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="324038124"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 12:30:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="632912046"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="632912046"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 12:30:55 -0800
Subject: [ndctl PATCH v4 1/4] ndctl: add CXL bus detection
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     vishal.l.verma@intel.com
Date:   Wed, 04 Jan 2023 13:30:55 -0700
Message-ID: <167286425552.57859.1567921582050695532.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <f804d081-abb9-cb46-e14f-a37f3ac63f21@intel.com>
References: <f804d081-abb9-cb46-e14f-a37f3ac63f21@intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a CXL bus type, and detect whether a 'dimm' is backed by the CXL
subsystem.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v4:
- Remove libgen.h include
v3:
- Simplify detecting cxl subsystem. (Dan)
v2:
- Improve commit log. (Vishal)
---
 ndctl/lib/libndctl.c   |   29 +++++++++++++++++++++++++++++
 ndctl/lib/libndctl.sym |    1 +
 ndctl/lib/private.h    |    1 +
 ndctl/libndctl.h       |    1 +
 4 files changed, 32 insertions(+)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index ad54f0626510..2b06dc8be81a 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -876,6 +876,24 @@ static enum ndctl_fwa_method fwa_method_to_method(const char *fwa_method)
 	return NDCTL_FWA_METHOD_RESET;
 }
 
+static int is_subsys_cxl(const char *subsys)
+{
+	char *path;
+	int rc;
+
+	path = realpath(subsys, NULL);
+	if (!path)
+		return -errno;
+
+	if (!strcmp(subsys, "/sys/bus/cxl"))
+		rc = 1;
+	else
+		rc = 0;
+
+	free(path);
+	return rc;
+}
+
 static void *add_bus(void *parent, int id, const char *ctl_base)
 {
 	char buf[SYSFS_ATTR_SIZE];
@@ -919,6 +937,12 @@ static void *add_bus(void *parent, int id, const char *ctl_base)
 	else
 		bus->has_of_node = 1;
 
+	sprintf(path, "%s/device/../subsys", ctl_base);
+	if (is_subsys_cxl(path))
+		bus->has_cxl = 1;
+	else
+		bus->has_cxl = 0;
+
 	sprintf(path, "%s/device/nfit/dsm_mask", ctl_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
 		bus->nfit_dsm_mask = 0;
@@ -1050,6 +1074,11 @@ NDCTL_EXPORT int ndctl_bus_has_of_node(struct ndctl_bus *bus)
 	return bus->has_of_node;
 }
 
+NDCTL_EXPORT int ndctl_bus_has_cxl(struct ndctl_bus *bus)
+{
+	return bus->has_cxl;
+}
+
 NDCTL_EXPORT int ndctl_bus_is_papr_scm(struct ndctl_bus *bus)
 {
 	char buf[SYSFS_ATTR_SIZE];
diff --git a/ndctl/lib/libndctl.sym b/ndctl/lib/libndctl.sym
index 75c32b9d4967..2892544d1985 100644
--- a/ndctl/lib/libndctl.sym
+++ b/ndctl/lib/libndctl.sym
@@ -464,4 +464,5 @@ LIBNDCTL_27 {
 } LIBNDCTL_26;
 LIBNDCTL_28 {
 	ndctl_dimm_disable_master_passphrase;
+	ndctl_bus_has_cxl;
 } LIBNDCTL_27;
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index e5c56295556d..46bc8908bd90 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -163,6 +163,7 @@ struct ndctl_bus {
 	int regions_init;
 	int has_nfit;
 	int has_of_node;
+	int has_cxl;
 	char *bus_path;
 	char *bus_buf;
 	size_t buf_len;
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index c52e82a6f826..91ef0f42f654 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -133,6 +133,7 @@ struct ndctl_bus *ndctl_bus_get_next(struct ndctl_bus *bus);
 struct ndctl_ctx *ndctl_bus_get_ctx(struct ndctl_bus *bus);
 int ndctl_bus_has_nfit(struct ndctl_bus *bus);
 int ndctl_bus_has_of_node(struct ndctl_bus *bus);
+int ndctl_bus_has_cxl(struct ndctl_bus *bus);
 int ndctl_bus_is_papr_scm(struct ndctl_bus *bus);
 unsigned int ndctl_bus_get_major(struct ndctl_bus *bus);
 unsigned int ndctl_bus_get_minor(struct ndctl_bus *bus);


