Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC57C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Feb 2022 00:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiBQAZ2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 16 Feb 2022 19:25:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiBQAZZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 16 Feb 2022 19:25:25 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17E22A97EC
        for <linux-cxl@vger.kernel.org>; Wed, 16 Feb 2022 16:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645057512; x=1676593512;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JDhTIuqZPzLHPjbXHtTs7+FVrfLcSIbJFyebZ0U8+4o=;
  b=SyngWuEygpJsv+rFJxS6YHRr+QtOBId/W19khtpWJOerSSvexWOp50QY
   hw65DPB86rBiMsBfR1HeAEpEcoNyIBHdIYoqZBLD5VMYs5uO69Zc44ZNM
   9iL2J82k315vcoNUPvSFQSdOU03v66CUAOofY0dIXm+S2+dPd485rYUXN
   1GZBzYo903v3CatIGP63jRlv+MWmip7dPtV7ausPcqQbRjQ4LqhAMh5TA
   lmjTAlNYbS9hMga3Vt4yhD/Zj5hoByRSnMxXnSzZa3RgZhUsTy48iRiXq
   7sHNGK3n8LuyGLOwrpoprVfILiW5NPq4sGauVm/27i4AS7NPalFa9Kz/V
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="337198244"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="337198244"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 16:25:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="540491622"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 16:25:12 -0800
Subject: [PATCH] cxl/port: Hold port reference until decoder release
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>
Date:   Wed, 16 Feb 2022 16:25:11 -0800
Message-ID: <164505751190.4175768.13324905271463416712.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

KASAN + DEBUG_KOBJECT_RELEASE reports a potential use-after-free in
cxl_decoder_release() where it goes to reference its parent, a cxl_port,
to free its id back to port->decoder_ida.

 BUG: KASAN: use-after-free in to_cxl_port+0x18/0x90 [cxl_core]
 Read of size 8 at addr ffff888119270908 by task kworker/35:2/379

 CPU: 35 PID: 379 Comm: kworker/35:2 Tainted: G           OE     5.17.0-rc2+ #198
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 Workqueue: events kobject_delayed_cleanup
 Call Trace:
  <TASK>
  dump_stack_lvl+0x59/0x73
  print_address_description.constprop.0+0x1f/0x150
  ? to_cxl_port+0x18/0x90 [cxl_core]
  kasan_report.cold+0x83/0xdf
  ? to_cxl_port+0x18/0x90 [cxl_core]
  to_cxl_port+0x18/0x90 [cxl_core]
  cxl_decoder_release+0x2a/0x60 [cxl_core]
  device_release+0x5f/0x100
  kobject_cleanup+0x80/0x1c0

The device core only guarantees parent lifetime until all children are
unregistered. If a child needs a parent to complete its ->release()
callback that child needs to hold a reference to extend the lifetime of
the parent.

Fixes: 40ba17afdfab ("cxl/acpi: Introduce cxl_decoder objects")
Reported-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0fc1441be014..c1681248f322 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -251,6 +251,7 @@ static void cxl_decoder_release(struct device *dev)
 
 	ida_free(&port->decoder_ida, cxld->id);
 	kfree(cxld);
+	put_device(&port->dev);
 }
 
 static const struct device_type cxl_decoder_endpoint_type = {
@@ -1202,7 +1203,10 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 	if (rc < 0)
 		goto err;
 
+	/* need parent to stick around to release the id */
+	get_device(&port->dev);
 	cxld->id = rc;
+
 	cxld->nr_targets = nr_targets;
 	seqlock_init(&cxld->target_lock);
 	dev = &cxld->dev;

