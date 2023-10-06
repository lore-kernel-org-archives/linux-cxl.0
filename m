Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E94663DB
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 07:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUe8VaNN"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB693E9
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 00:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696577177; x=1728113177;
  h=subject:from:to:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Zr+JwxZCArcqLL0dP/lorSnIlxk60mkDmj3jKpQIRcE=;
  b=FUe8VaNNZhLz1Uigo030Bo7APQohGngTiSLGPfCpu2ULotGkMMtCdsQg
   GUTuZ+6Qjjwm+oYxyV+FYY2440ctQ82KOgUcfwkwuZATyGWegxRTEOJHi
   S74dKfEdc4IIPhdS9fvtPXuq0d8CAi4RRQCwXq7LeiMS4zAj9O3CuAXaY
   XYUOxW5f5jAblpnD+nLXje2YX37drUw0Ia1vEiaQqTGDdiJ+NFwwVcB3p
   jMjea+BE+JwziADknqqfMWhOYvc0FeAE+nMZ73PgzmuH7N6rOxxdC3X9d
   n+eZYSEAiSsFiz1fn6DU+YEZhLF8+7IWy47u+pKdDBWTSOVjwebiUihps
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="450192221"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="450192221"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:26:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="817923196"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="817923196"
Received: from wbleichn-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.147.24])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:26:16 -0700
Subject: [PATCH v3 03/10] cxl/pci: Remove hardirq handler for
 cxl_request_irq()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Date: Fri, 06 Oct 2023 00:26:16 -0700
Message-ID: <169657717635.1491153.10040969889268437662.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now that all callers of cxl_request_irq() are using threaded irqs, drop
the hardirq handler option.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 49d9b2ef5c5c..dc665b12be8f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -90,7 +90,7 @@ struct cxl_dev_id {
 };
 
 static int cxl_request_irq(struct cxl_dev_state *cxlds, int irq,
-			   irq_handler_t handler, irq_handler_t thread_fn)
+			   irq_handler_t thread_fn)
 {
 	struct device *dev = cxlds->dev;
 	struct cxl_dev_id *dev_id;
@@ -101,9 +101,9 @@ static int cxl_request_irq(struct cxl_dev_state *cxlds, int irq,
 		return -ENOMEM;
 	dev_id->cxlds = cxlds;
 
-	return devm_request_threaded_irq(dev, irq, handler, thread_fn,
-					 IRQF_SHARED | IRQF_ONESHOT,
-					 NULL, dev_id);
+	return devm_request_threaded_irq(dev, irq, NULL, thread_fn,
+					 IRQF_SHARED | IRQF_ONESHOT, NULL,
+					 dev_id);
 }
 
 static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
@@ -440,7 +440,7 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
 	if (irq < 0)
 		return 0;
 
-	if (cxl_request_irq(cxlds, irq, NULL, cxl_pci_mbox_irq))
+	if (cxl_request_irq(cxlds, irq, cxl_pci_mbox_irq))
 		return 0;
 
 	dev_dbg(cxlds->dev, "Mailbox interrupts enabled\n");
@@ -638,7 +638,7 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
 	if (irq < 0)
 		return irq;
 
-	return cxl_request_irq(cxlds, irq, NULL, cxl_event_thread);
+	return cxl_request_irq(cxlds, irq, cxl_event_thread);
 }
 
 static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,

