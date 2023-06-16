Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCA4EB64D7
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jun 2023 21:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjFPVms (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jun 2023 17:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjFPVmr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Jun 2023 17:42:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B73B35A6
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 14:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686951766; x=1718487766;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wtxAJ7DeuunRr2a7PgsSUIxa0aO9253jY8P22j8GNu4=;
  b=caeg+jY9zm/ZA46BWj9+5WZ1oHwSQCoBv4t+Yd8urJGNUsIRMubljjdr
   ZOBaaLKiUTmd6r5nFixyw/vai6amsnnSUlgkgVxvVledLODfDlQnI8bBw
   MMoVFfs1OzoLHTnvHWl2H7z+ZVY6nAJBBs0LuTLqyLRKdZfgjzsVXEpI5
   U6CN7PVImPQCTqDy1yAY0Pu4giSF2JV9LaXxN+vhNdpDe3QpNHpd81vCj
   RxoRcOY+r80N/k8ntAkhDiqyzCMUJXWebH3n5p5OWBkFCl2scNbxILNhQ
   q8LG2h+7SJZC5ayRf1IMxjWDmWW0U2PGVhguFhQVi1JP7pCU3vax15nH8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="422973297"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="422973297"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:42:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="663327025"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="663327025"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.16.91])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:42:45 -0700
Subject: [PATCH v7 11/11] cxl/mem: Add debugfs output for QTG related data
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Fri, 16 Jun 2023 14:42:44 -0700
Message-ID: <168695176491.3031571.5598696106816884313.stgit@djiang5-mobl3>
In-Reply-To: <168695160531.3031571.4875512229068707023.stgit@djiang5-mobl3>
References: <168695160531.3031571.4875512229068707023.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add debugfs output to /sys/kernel/debug/cxl/memX/qtgmap
The debugfs attribute will dump out all the DSMAS ranges and the associated
QTG ID exported by the CXL device CDAT.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v4:
- Use cxlds->qos_list instead of the stray cxlmd->qos_list
---
 Documentation/ABI/testing/debugfs-cxl |   13 +++++++++++++
 MAINTAINERS                           |    1 +
 drivers/cxl/mem.c                     |   26 ++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
index fe61d372e3fa..e2b5b583c031 100644
--- a/Documentation/ABI/testing/debugfs-cxl
+++ b/Documentation/ABI/testing/debugfs-cxl
@@ -33,3 +33,16 @@ Description:
 		device cannot clear poison from the address, -ENXIO is returned.
 		The clear_poison attribute is only visible for devices
 		supporting the capability.
+
+
+What:		/sys/kernel/debug/cxl/memX/qtg_map
+Date:		Mar, 2023
+KernelVersion:	v6.5
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Entries of all Device Physical Address (DPA) ranges
+		provided by the device Coherent Device Attributes Table (CDAT)
+		Device Scoped Memory Affinity Structure (DSMAS) entries with
+		the matching QoS Throttling Group (QTG) id calculated from the
+		latency and bandwidth of the CXL path from the memory device
+		to the CPU.
diff --git a/MAINTAINERS b/MAINTAINERS
index 2145438e00dc..34dafe98e9bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5192,6 +5192,7 @@ M:	Ben Widawsky <bwidawsk@kernel.org>
 M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/debugfs-cxl
 F:	drivers/cxl/
 F:	include/uapi/linux/cxl_mem.h
 
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 519edd0eb196..99bb68ae21ac 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -45,6 +45,31 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
 	return 0;
 }
 
+static int cxl_mem_qtg_show(struct seq_file *file, void *data)
+{
+	struct device *dev = file->private;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct perf_prop_entry *perf;
+
+	list_for_each_entry(perf, &cxlds->perf_list, list) {
+		struct qos_class *qos_class = &perf->qos_class;
+		int i;
+
+		seq_printf(file, "%08llx-%08llx : QoS Class: ",
+			   perf->dpa_range.start, perf->dpa_range.end);
+		for (i = 0; i < qos_class->nr; i++) {
+			seq_printf(file, "%d", qos_class->entries[i]);
+			if (i + 1 == qos_class->nr)
+				seq_puts(file, "\n");
+			else
+				seq_puts(file, ", ");
+		}
+	}
+
+	return 0;
+}
+
 static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 				 struct cxl_dport *parent_dport)
 {
@@ -140,6 +165,7 @@ static int cxl_mem_probe(struct device *dev)
 
 	dentry = cxl_debugfs_create_dir(dev_name(dev));
 	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
+	debugfs_create_devm_seqfile(dev, "qtgmap", dentry, cxl_mem_qtg_show);
 
 	if (test_bit(CXL_POISON_ENABLED_INJECT, cxlds->poison.enabled_cmds))
 		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,


