Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6BFC76195
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Mar 2023 05:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjC0FD2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Mar 2023 01:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjC0FDY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Mar 2023 01:03:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A9246AE
        for <linux-cxl@vger.kernel.org>; Sun, 26 Mar 2023 22:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679893404; x=1711429404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CzgST/s0/JhDw8Blhkwfx/FBVhYxo3L1HmhsZIxRHxc=;
  b=M9FP4ohErrAUPTA+1zPwT7c9PaEeTnQa+xv8h1kDoNzWD8LE6ikS4s9Q
   CnalCkXd4Ps7qoLVvk3M6xnS7P0DjhcRF5jLZUKvGJqALl+ZQ7k2aqJjf
   CcvI7AHSRBo7PgJV4xKrTgbNSDb0d6azMaCHvWD8nDibaCHBsWpkw59B1
   iJTvrvU/wCJdt/tUh5bdy3oic/5gZeUuyNyNDQBcZ++D4V0V+Nl9pGUYB
   CQxFbO6QewT1cpGJ4qhODirRzSbAGw56ofudEuZeQ6e7JTpZ2hQjveY5v
   fQ38v6H2hrIXAXgnN2SSMrUZWNGxdmr7FzD08Ta3a1YelLV3gjO1tM7Fh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="367920191"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="367920191"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="633492265"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="633492265"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.227.2])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:23 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v5 05/12] cxl/mem: Add debugfs attributes for poison inject and clear
Date:   Sun, 26 Mar 2023 22:03:11 -0700
Message-Id: <b3844e5e940a100f32363f4a2e722ab6e415a96e.1679892337.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1679892337.git.alison.schofield@intel.com>
References: <cover.1679892337.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Inject and Clear Poison commands are optionally supported by CXL
memdev devices and are intended for use in debug environments only.
Add debugfs attributes for user access.

Documentation/ABI/testing/debugfs-cxl describes the usage.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/ABI/testing/debugfs-cxl | 36 +++++++++++++++++++++++++++
 drivers/cxl/mem.c                     | 26 +++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-cxl

diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
new file mode 100644
index 000000000000..3f1624f95f11
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-cxl
@@ -0,0 +1,36 @@
+What:		/sys/kernel/debug/cxl/memX/inject_poison
+Date:		April, 2023
+KernelVersion:	v6.4
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) When a Device Physical Address (DPA) is written to this
+		attribute, the memdev driver sends an inject poison command to
+		the device for the specified address. The DPA must be 64-byte
+		aligned and the length of the injected poison is 64-bytes. If
+		successful, the device returns poison when the address is
+		accessed through the CXL.mem bus. Injecting poison adds the
+		address to the device's Poison List and the error source is set
+		to Injected. In addition, the device adds a poison creation
+		event to its internal Informational Event log, updates the
+		Event Status register, and if configured, interrupts the host.
+		It is not an error to inject poison into an address that
+		already has poison present and no error is returned. The
+		inject_poison attribute is only visible for devices supporting
+		the capability.
+
+
+What:		/sys/kernel/debug/memX/clear_poison
+Date:		April, 2023
+KernelVersion:	v6.4
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) When a Device Physical Address (DPA) is written to this
+		attribute, the memdev driver sends a clear poison command to
+		the device for the specified address. Clearing poison removes
+		the address from the device's Poison List and writes 0 (zero)
+		for 64 bytes starting at address. It is not an error to clear
+		poison from an address that does not have poison set, and if
+		poison was not set, the address is not overwritten. If the
+		device cannot clear poison from the address, -ENXIO is returned.
+		The clear_poison attribute is only visible for devices
+		supporting the capability.
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 576f5b691589..ff67ecf07001 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -94,6 +94,22 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	return 0;
 }
 
+static int cxl_debugfs_poison_inject(void *data, u64 dpa)
+{
+	return cxl_inject_poison(data, dpa);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
+			 cxl_debugfs_poison_inject, "%llx\n");
+
+static int cxl_debugfs_poison_clear(void *data, u64 dpa)
+{
+	return cxl_clear_poison(data, dpa);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
+			 cxl_debugfs_poison_clear, "%llx\n");
+
 static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
@@ -117,6 +133,16 @@ static int cxl_mem_probe(struct device *dev)
 
 	dentry = cxl_debugfs_create_dir(dev_name(dev));
 	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
+
+	if (test_bit(CXL_MEM_COMMAND_ID_INJECT_POISON,
+		     to_cxl_memdev(dev)->cxlds->enabled_cmds))
+		debugfs_create_file("inject_poison", 0200, dentry, dev,
+				    &cxl_poison_inject_fops);
+	if (test_bit(CXL_MEM_COMMAND_ID_CLEAR_POISON,
+		     to_cxl_memdev(dev)->cxlds->enabled_cmds))
+		debugfs_create_file("clear_poison", 0200, dentry, dev,
+				    &cxl_poison_clear_fops);
+
 	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
 	if (rc)
 		return rc;
-- 
2.37.3

