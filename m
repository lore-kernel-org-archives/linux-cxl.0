Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ED0C4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Dec 2022 17:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiLPRVv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Dec 2022 12:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiLPRVq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Dec 2022 12:21:46 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9471F60C
        for <linux-cxl@vger.kernel.org>; Fri, 16 Dec 2022 09:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671211305; x=1702747305;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=suKkCRqRWnIoQE67uni3rJ82okyGpsjq1sfKjVsZthY=;
  b=PtunDi4p2c76YHQKx1uG0DUFxNnK9d0+fJFRC49Q5VlqHfAg5EQtZwmT
   PU821BzHjprikc7MbrPEQ8GMvcGaweJ4t9wvxEu7fnkYOkaOGhCTg7MOK
   4zkRmLaC3mjXKeQApb04qaOXH2JL4+OD9o0gTAqobkCdDQln+VGYKlUWT
   tLRZRgka8Dy38WDHBwZi+zsboOZrynRvdD7ZZPFWJgUNMYLDFi0LggJcW
   YJVTee2nAp3ovcDMBpyErIgRR39nrXAHV7+7Tt91zNYetrbb6MSzIUXUw
   a/l6xTLLY+s5RF3/9Z8F59UxNmYyd4nuTbthXoXMCsCzLS3iS2sJxH/g5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="405270597"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="405270597"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 09:21:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="600012880"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="600012880"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 09:21:27 -0800
Subject: [ndctl PATCH v3 1/4] ndctl: add CXL bus detection
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, jmoyer@redhat.com,
        vishal.l.verma@intel.com
Date:   Fri, 16 Dec 2022 10:21:23 -0700
Message-ID: <167121128334.3620577.18417349282991011007.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <639b9f6062c69_b05d12941f@dwillia2-xfh.jf.intel.com.notmuch>
References: <639b9f6062c69_b05d12941f@dwillia2-xfh.jf.intel.com.notmuch>
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
v3:
- Simplify detecting cxl subsystem. (Dan)
v2:
- Improve commit log. (Vishal)
---
 ndctl/lib/libndctl.c   |   30 ++++++++++++++++++++++++++++++
 ndctl/lib/libndctl.sym |    1 +
 ndctl/lib/private.h    |    1 +
 ndctl/libndctl.h       |    1 +
 4 files changed, 33 insertions(+)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index ad54f0626510..9cd5340b5702 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -12,6 +12,7 @@
 #include <ctype.h>
 #include <fcntl.h>
 #include <dirent.h>
+#include <libgen.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/ioctl.h>
@@ -876,6 +877,24 @@ static enum ndctl_fwa_method fwa_method_to_method(const char *fwa_method)
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
@@ -919,6 +938,12 @@ static void *add_bus(void *parent, int id, const char *ctl_base)
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
@@ -1050,6 +1075,11 @@ NDCTL_EXPORT int ndctl_bus_has_of_node(struct ndctl_bus *bus)
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


