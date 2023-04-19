Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53CFC77B78
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Apr 2023 03:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjDSD0t (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 23:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjDSD0s (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 23:26:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD52102
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 20:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681874806; x=1713410806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VHPdcWOGsIdRnJY+Ke7KRUPAqpll05ISbPsQ0GfrK8M=;
  b=E08UEX9KsOqSY0JWN5on8VQqGYip2iZjaDQALzyLkqOp5iNeMgR2QKxJ
   pnGnVIB4Eo778lmqMnboQhv4JvmlOCvjtce0GRd8lknFBSt3DAuYyPt6S
   +/9cr3jfrLNAvZ0d/UIdGZJcmuwM1yJzlSGCWeemQ9PbEFLxK/bskTA7E
   YYPj5EoGy3d+lfSORoa8QYkSYsxdtIbPXmUnaWo4b7OOhk9BDONs+vszk
   xZTmT585c/bOao182meJn2Y9az2J1IB//0yM1n4dUcEcapyPt4wfQCE11
   fo1JvkHvnGbyZ7cBrfnlJ/Z1BvctbRe4gCAkMIQXEP38wuvEO4gwHJ4xQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="431621721"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="431621721"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="780711117"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="780711117"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.152.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:26:46 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 05/10] cxl/mem: Add debugfs attributes for poison inject and clear
Date:   Tue, 18 Apr 2023 20:26:29 -0700
Message-Id: <0c9ea8e671b8e58465d18722788b60d325c675c7.1681874357.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1681874357.git.alison.schofield@intel.com>
References: <cover.1681874357.git.alison.schofield@intel.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/ABI/testing/debugfs-cxl | 35 +++++++++++++++++++++++++++
 drivers/cxl/mem.c                     | 28 +++++++++++++++++++++
 2 files changed, 63 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-cxl

diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
new file mode 100644
index 000000000000..fe61d372e3fa
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-cxl
@@ -0,0 +1,35 @@
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
+		poison from an address that does not have poison set. If the
+		device cannot clear poison from the address, -ENXIO is returned.
+		The clear_poison attribute is only visible for devices
+		supporting the capability.
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index b6a413facbd7..10caf180b3fa 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -94,6 +94,26 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	return 0;
 }
 
+static int cxl_debugfs_poison_inject(void *data, u64 dpa)
+{
+	struct cxl_memdev *cxlmd = data;
+
+	return cxl_inject_poison(cxlmd, dpa);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
+			 cxl_debugfs_poison_inject, "%llx\n");
+
+static int cxl_debugfs_poison_clear(void *data, u64 dpa)
+{
+	struct cxl_memdev *cxlmd = data;
+
+	return cxl_clear_poison(cxlmd, dpa);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
+			 cxl_debugfs_poison_clear, "%llx\n");
+
 static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
@@ -117,6 +137,14 @@ static int cxl_mem_probe(struct device *dev)
 
 	dentry = cxl_debugfs_create_dir(dev_name(dev));
 	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
+
+	if (test_bit(CXL_POISON_ENABLED_INJECT, cxlds->poison.enabled_cmds))
+		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
+				    &cxl_poison_inject_fops);
+	if (test_bit(CXL_POISON_ENABLED_CLEAR, cxlds->poison.enabled_cmds))
+		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
+				    &cxl_poison_clear_fops);
+
 	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
 	if (rc)
 		return rc;
-- 
2.37.3

