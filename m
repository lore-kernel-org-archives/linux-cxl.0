Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFE7C27C76
	for <linux-cxl@archiver.kernel.org>; Wed, 25 Jan 2023 22:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjAYWLU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 25 Jan 2023 17:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjAYWLT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 25 Jan 2023 17:11:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23FF272E
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jan 2023 14:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674684678; x=1706220678;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qxH/kyIMcKKJjiTaMXm/9AdabYoE7H7mMMcZB+Cd4wY=;
  b=CXFVkJ19gzcKKyhhEKSt45m7K+CvJ1gXv8DZzCdNF1SDheYDBFmc0SkR
   8t5pZLXSTB1xHbcLEo+/BnkqJN58XkpM4ivp7NJ6omJV7d3CyMheOI0mQ
   eqFB1sgDkUxctpxyKRE+VPGOlikfnPvm7tT2kaniKhIPBugKmpov6HZle
   +6Cry07VP65rGcSelyr6EBK3CUdAMh+YJcXwG1xx2eOtBEmT1xDiaWGI1
   DtOwbe/VO5HphPtcIGCaJjsdMyKLyQtjn00a2ZZpwsQOiBCTm89Lk7afN
   2lTH7KlXRW5EW7sNgvqIL9E1HFoY8SPsCFsVeG/Iws0l5XhMQykVjOZAr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="326721504"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="326721504"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 14:11:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="693124684"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="693124684"
Received: from lwlu-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.17.213])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 14:11:18 -0800
Subject: [PATCH v2 1/3] cxl/mem: Quiet port walking warnings
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     rrichter@amd.com, Jonathan.Cameron@huawei.com
Date:   Wed, 25 Jan 2023 14:11:17 -0800
Message-ID: <167468465444.586774.9409731200278259584.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <20230113110441.0000657e@Huawei.com>
References: <20230113110441.0000657e@Huawei.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The cxl_mem driver attempts to establish, or revalidate, the cxl_port
hierarcy to attach a cxl_memdev to a CXL platform topology. There is a
natural race (on ACPI platforms) between when the cxl_mem driver
attempts to attach and when the cxl_acpi driver establishes the root of
the topology.

If cxl_mem_probe() runs first it will iterate to the top of the device
topology without finding the CXL platform root. That situation is benign
/ expected, so stop warning about it. The cxl_acpi driver will poke
cxl_mem_probe() to try again once the CXL platform root is established.

Suppress any upper level errors by making it clear that this is merely a
probe deferral event, not a hard error.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v1:
* Use dev_err_probe() (Jonathan)

 drivers/cxl/core/port.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b631a0520456..feb8f84a9281 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1397,9 +1397,10 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 
 		uport_dev = dport_dev->parent;
 		if (!uport_dev) {
-			dev_warn(dev, "at %s no parent for dport: %s\n",
-				 dev_name(iter), dev_name(dport_dev));
-			return -ENXIO;
+			dev_err_probe(dev, -EPROBE_DEFER,
+				      "at %s no parent for dport: %s\n",
+				      dev_name(iter), dev_name(dport_dev));
+			return -EPROBE_DEFER;
 		}
 
 		dev_dbg(dev, "scan: iter: %s dport_dev: %s parent: %s\n",

