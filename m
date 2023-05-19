Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94916C7EE33
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 17:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjESRJe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 13:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjESRJZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 13:09:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6339E49
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 10:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684516146; x=1716052146;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TpcyBClL2xkW6mFLLKXtc8VKmjh6vSpL8VUbBIor44Y=;
  b=V43vnsahUFLtiMFMTETUj7mEr2RFKSaLdH2Vp9jZTb4rpvUhZYXwKOPE
   IV5ENKjHjTyRUJfqiE37m4vVTMjWCi5cv0PIFLBWuDRLt0FNyV37rkvYG
   2vZW1d3dZ4eip+U+7klWdOyW9wioAUOSxYYk/8iujLqx64OsgeoeXohCM
   skT5YmqKgYWAHyuUcvClxT9fLFquN4ZbmaIEPDkhCc5grA5h8pntrqU8q
   6H4MWNW+ZBGShEw5pyLTedpo07aFDfraNTESQnl2EK8Qffz/tt4PBMgEj
   HaAtMjtU6Yvb4Vujb1n1GonTmckBnxTL32D6IZrvnundk2Z05ywMa3T9P
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="337018639"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="337018639"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 10:07:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="846951250"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="846951250"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.29.189])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 10:07:40 -0700
Subject: [PATCH v6 11/11] cxl/mem: Add debugfs output for QTG related data
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Fri, 19 May 2023 10:07:40 -0700
Message-ID: <168451606013.3470703.17517034050660255743.stgit@djiang5-mobl3>
In-Reply-To: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
References: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
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
index e0ad886d3163..0437b07df026 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5188,6 +5188,7 @@ M:	Ben Widawsky <bwidawsk@kernel.org>
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


