Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D77241FF
	for <linux-cxl@vger.kernel.org>; Mon,  6 Nov 2023 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lgrpfw8c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85409D49
	for <linux-cxl@vger.kernel.org>; Mon,  6 Nov 2023 09:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699291607; x=1730827607;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g5X91Hpu2b4cdr+xbaJYpsORPxBTW3jKb1HoRpd9W0w=;
  b=Lgrpfw8cbFF6/ZcLCpiFz3CkhXRb8cZXYay+8YJZa5pga73lgK8RE9bN
   ZJ+7fIN36l3yTo8EE9O7k/X2yQFK9+6aq1nkGlAHR7RVcAJpd8HskP2P9
   WpfEjWW+9T/E3KeYtmlJGMnZqfrgOM12dxcsEhJPm4FiKpMTYLgCASmLr
   GAcyvcPdM+Nk1UCUu7qGX7KQShxK+CWDtFHgnVCyzUXuXYiIdHOks5x93
   yBPY8+NLCAgMGcA4ZpSLoMaYAI9Ea0+qSVG0/id/dsUccpbYzJrhZp7cw
   3RSTpNLs5RCwbfh9h1TDJVH2uQv3JqXQMoWqwNnrNgWTBUq58/BhZQIRe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="2244006"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="2244006"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 09:26:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="738845980"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="738845980"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.27.148])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 09:26:45 -0800
Subject: [PATCH v3] cxl: Add cxl_num_decoders_committed() usage to cxl_test
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>, dan.j.williams@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com
Date: Mon, 06 Nov 2023 10:26:45 -0700
Message-ID: <169929160525.824083.11813222229025394254.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Commit 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper") missed the
conversion for cxl_test. Add usage of cxl_num_decoders_committed() to
replace the open coding.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v3:
- Move export of symbol to cxl_test (Dan)
v2:
- Add missing changes, stg refresh foobar
---
 tools/testing/cxl/Kbuild             |    1 +
 tools/testing/cxl/cxl_core_exports.c |    7 +++++++
 tools/testing/cxl/test/cxl.c         |    5 +++--
 3 files changed, 11 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/cxl/cxl_core_exports.c

diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 90f3c9802ffb..95dc58b94178 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -62,5 +62,6 @@ cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-y += config_check.o
 cxl_core-y += cxl_core_test.o
+cxl_core-y += cxl_core_exports.o
 
 obj-m += test/
diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
new file mode 100644
index 000000000000..077e6883921d
--- /dev/null
+++ b/tools/testing/cxl/cxl_core_exports.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+
+#include "cxl.h"
+
+/* Exporting of cxl_core symbols that are only used by cxl_test */
+EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed, CXL);
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index b88546299902..f4e517a0c774 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -669,10 +669,11 @@ static int mock_decoder_commit(struct cxl_decoder *cxld)
 		return 0;
 
 	dev_dbg(&port->dev, "%s commit\n", dev_name(&cxld->dev));
-	if (port->commit_end + 1 != id) {
+	if (cxl_num_decoders_committed(port) != id) {
 		dev_dbg(&port->dev,
 			"%s: out of order commit, expected decoder%d.%d\n",
-			dev_name(&cxld->dev), port->id, port->commit_end + 1);
+			dev_name(&cxld->dev), port->id,
+			cxl_num_decoders_committed(port));
 		return -EBUSY;
 	}
 


