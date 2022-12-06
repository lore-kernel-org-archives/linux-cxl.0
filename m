Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2305BC3A5A7
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 04:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiLFE2h (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Dec 2022 23:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLFE2g (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Dec 2022 23:28:36 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE1FDED
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 20:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670300915; x=1701836915;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gKuiejftp69CnAOqkD8ogn8wDc3jkatpT6H8j++RQms=;
  b=GN2qP3GyEIAfpJt7KEm28Xv+rzJqb358LDStb9pnMU/hCz5QNsrKimoS
   6/lvqAC7sLPCHYBlTmLVWVcqOXHRk9iAFrTznbrJf/+6ucoJrHxxcR0io
   W9fGb+I31MPGFmYbEjmkbqqhnqQUW/O3qbRIA1Zdf6KUoxOD07t745h+k
   ZSgiXoSnHgjUJE84+g67kykYcTjS2B7tmIRpej0ONrxSMw+mGUYwu9j7E
   Yqqy63H6eHbjSiUJKNOHAhHXN4tPq4b8HV2eviyyoKZbtNX6tgEOYO8e1
   A6AtUyMGpaPkzuGHufgMmf7U+keaw32gdPCTQU+JJEh2KYNdYh8OCEVRq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="304152040"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="304152040"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 20:28:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="770591578"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="770591578"
Received: from bmnebren-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.114.171])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 20:28:35 -0800
Subject: [PATCH] cxl/pci: Add some type-safety to the AER trace points
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>, dave.jiang@intel.com
Date:   Mon, 05 Dec 2022 20:28:34 -0800
Message-ID: <167030091477.4045167.15174636482098463885.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The first argument to the CXL AER trace points is the source device.
Pass a 'const struct device *' rather than a 'const char *' for more
type precision / safety.

Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.c          |    4 ++--
 include/trace/events/cxl.h |   16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6cec9fa9326c..cced4a0df3d1 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -562,7 +562,7 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 	}
 
 	header_log_copy(cxlds, hl);
-	trace_cxl_aer_uncorrectable_error(dev_name(dev), status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -644,7 +644,7 @@ static void cxl_cor_error_detected(struct pci_dev *pdev)
 	status = le32_to_cpu(readl(addr));
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(dev_name(dev), status);
+		trace_cxl_aer_correctable_error(dev, status);
 	}
 }
 
diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
index 72c3e2870a9e..ad085a2534ef 100644
--- a/include/trace/events/cxl.h
+++ b/include/trace/events/cxl.h
@@ -45,16 +45,16 @@
 )
 
 TRACE_EVENT(cxl_aer_uncorrectable_error,
-	TP_PROTO(const char *dev_name, u32 status, u32 fe, u32 *hl),
-	TP_ARGS(dev_name, status, fe, hl),
+	TP_PROTO(const struct device *dev, u32 status, u32 fe, u32 *hl),
+	TP_ARGS(dev, status, fe, hl),
 	TP_STRUCT__entry(
-		__string(dev_name, dev_name)
+		__string(dev_name, dev_name(dev))
 		__field(u32, status)
 		__field(u32, first_error)
 		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
 	),
 	TP_fast_assign(
-		__assign_str(dev_name, dev_name);
+		__assign_str(dev_name, dev_name(dev));
 		__entry->status = status;
 		__entry->first_error = fe;
 		/*
@@ -89,14 +89,14 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 )
 
 TRACE_EVENT(cxl_aer_correctable_error,
-	TP_PROTO(const char *dev_name, u32 status),
-	TP_ARGS(dev_name, status),
+	TP_PROTO(const struct device *dev, u32 status),
+	TP_ARGS(dev, status),
 	TP_STRUCT__entry(
-		__string(dev_name, dev_name)
+		__string(dev_name, dev_name(dev))
 		__field(u32, status)
 	),
 	TP_fast_assign(
-		__assign_str(dev_name, dev_name);
+		__assign_str(dev_name, dev_name(dev));
 		__entry->status = status;
 	),
 	TP_printk("%s: status: '%s'",

