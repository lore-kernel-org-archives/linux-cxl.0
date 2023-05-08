Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD7CC7EE22
	for <linux-cxl@archiver.kernel.org>; Mon,  8 May 2023 20:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjEHUsY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 May 2023 16:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEHUsY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 May 2023 16:48:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2768F5B9F
        for <linux-cxl@vger.kernel.org>; Mon,  8 May 2023 13:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683578903; x=1715114903;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hO89vfS+V/rKPbvFZXHUbz9FU6GF93xdkbPmxFcYC10=;
  b=eyYIxh0wxvS1X/0/nWtf28yVQ4DNYnDNKJS//NEM16oyynJCQ1/+m45s
   WP8h+AcCy10Ktc+sFkMs80dLi6tos1rTZtbImlxHGbipCkMmjRtdZODsV
   EkGuDM9pN3PZ28daku7NjgwRF4SaUWew+3yfceJLBLtGDmIOcNPPoWc+1
   YRpZTc8vjZk09K2GrH2s6/FzQeGqPh7M2vp/fyJqDEPvgbgsI94zOCKaH
   jEt7LAMszqDYP9yDM6rX154qF2RVtGO5ctQ0+TPUKzdwULcvJei+QMtqJ
   UNeoLc/iT8RO//VnvsCfUR79ZkezBIEsVY4p0LsctEDHzGFa34Rtwz8Rq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="349786232"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="349786232"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:48:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="676195192"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="676195192"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.172.228])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:48:17 -0700
Subject: [PATCH v5 14/14] cxl/mem: Add debugfs output for QTG related data
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com
Date:   Mon, 08 May 2023 13:48:16 -0700
Message-ID: <168357889673.2756219.5112791678818283230.stgit@djiang5-mobl3>
In-Reply-To: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
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
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v4:
- Use cxlds->qos_list instead of the stray cxlmd->qos_list
---
 Documentation/ABI/testing/debugfs-cxl |   11 +++++++++++
 MAINTAINERS                           |    1 +
 drivers/cxl/mem.c                     |   17 +++++++++++++++++
 3 files changed, 29 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-cxl

diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
new file mode 100644
index 000000000000..0f36eeb7e59b
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-cxl
@@ -0,0 +1,11 @@
+What:		/sys/kernel/debug/cxl/memX/qtg_map
+Date:		Mar, 2023
+KernelVersion:	v6.4
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Entries of all Device Physical Address (DPA) ranges
+		provided by the device Coherent Device Attributes Table (CDAT)
+		Device Scoped Memory Affinity Structure (DSMAS) entries with
+		the matching QoS Throttling Group (QTG) id calculated from the
+		latency and bandwidth of the CXL path from the memory device
+		to the CPU.
diff --git a/MAINTAINERS b/MAINTAINERS
index fd8c4c560f8d..256e4e57017c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5171,6 +5171,7 @@ M:	Ben Widawsky <bwidawsk@kernel.org>
 M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/debugfs-cxl
 F:	drivers/cxl/
 F:	include/uapi/linux/cxl_mem.h
 
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 39c4b54f0715..587e261a7f76 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -45,6 +45,22 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
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
+		seq_printf(file, "%08llx-%08llx : QoS Class: %u\n",
+			   perf->dpa_range.start, perf->dpa_range.end,
+			   perf->qos_class);
+	}
+
+	return 0;
+}
+
 static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 				 struct cxl_dport *parent_dport)
 {
@@ -117,6 +133,7 @@ static int cxl_mem_probe(struct device *dev)
 
 	dentry = cxl_debugfs_create_dir(dev_name(dev));
 	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
+	debugfs_create_devm_seqfile(dev, "qtgmap", dentry, cxl_mem_qtg_show);
 	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
 	if (rc)
 		return rc;


