Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C5DC433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Jul 2022 17:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiGNRDI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Jul 2022 13:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240107AbiGNRDC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Jul 2022 13:03:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732CE5887E
        for <linux-cxl@vger.kernel.org>; Thu, 14 Jul 2022 10:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657818181; x=1689354181;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8pHDEH3ziJVotJ1oYBiooCwlZBWAUamzVCenaWfGOWU=;
  b=HpsTAeq/H1emT2unVVQ1mq5RqtsU1ZrhGsRX4g3jqzJI7kG7WFd1A4hK
   BxtztTEyv/X6DEjqTX+yVG9m4+kqsRtaToqqQaIEBVSEANqXfNIpOmfmG
   hes61MU2xLGNPFotXBksbNGA92qHaMCcioTwcOyXvGghUFkGSJTPRzVpt
   eShx5ou9pHdSdBpK7tOdYBqONgJatIdx3lgLcq7M0Ga7ACmw1Pb05sEsE
   oJ660p9Km6eCJBNVkKV0PjaUeKEQEPHJ/SCKpcY0a/ZWIg36h9BOVygL5
   jlGza9e/HNuHoYaSaMtMggzQ5FJB4JgwkB4rcmzeZtXt8A8bBRKZ/Kz28
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="371889671"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="371889671"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 10:02:31 -0700
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="842214200"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 10:02:22 -0700
Subject: [ndctl PATCH v2 06/12] cxl/lib: Maintain decoders in id order
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     Davidlohr Bueso <dave@stgolabs.net>, alison.schofield@intel.com,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Date:   Thu, 14 Jul 2022 10:02:21 -0700
Message-ID: <165781814167.1555691.14895625637451030942.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165781810717.1555691.1411727384567016588.stgit@dwillia2-xfh.jf.intel.com>
References: <165781810717.1555691.1411727384567016588.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Given that decoder instance order is fundamental to the DPA translation
sequence for endpoint decoders, enforce that cxl_decoder_for_each() returns
decoders in instance order. Otherwise, they show up in readddir() order
which is not predictable.

Add a list_add_sorted() to generically handle inserting into a sorted list.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/lib/libcxl.c |    8 +++++++-
 util/list.h      |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 util/list.h

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index f36edcfc735a..e4c5d3819e88 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -19,6 +19,7 @@
 #include <ccan/short_types/short_types.h>
 
 #include <util/log.h>
+#include <util/list.h>
 #include <util/size.h>
 #include <util/sysfs.h>
 #include <util/bitmap.h>
@@ -908,6 +909,11 @@ cxl_endpoint_get_memdev(struct cxl_endpoint *endpoint)
 	return NULL;
 }
 
+static int decoder_id_cmp(struct cxl_decoder *d1, struct cxl_decoder *d2)
+{
+	return d1->id - d2->id;
+}
+
 static void *add_cxl_decoder(void *parent, int id, const char *cxldecoder_base)
 {
 	const char *devname = devpath_to_devname(cxldecoder_base);
@@ -1049,7 +1055,7 @@ static void *add_cxl_decoder(void *parent, int id, const char *cxldecoder_base)
 			return decoder_dup;
 		}
 
-	list_add(&port->decoders, &decoder->list);
+	list_add_sorted(&port->decoders, decoder, list, decoder_id_cmp);
 
 	free(path);
 	return decoder;
diff --git a/util/list.h b/util/list.h
new file mode 100644
index 000000000000..cb7727123ea8
--- /dev/null
+++ b/util/list.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2022 Intel Corporation. All rights reserved. */
+#ifndef _NDCTL_LIST_H_
+#define _NDCTL_LIST_H_
+
+#include <ccan/list/list.h>
+
+#define list_add_sorted(head, n, node, cmp)                                    \
+	do {                                                                   \
+		struct list_head *__head = (head);                             \
+		typeof(n) __iter, __next;                                      \
+		typeof(n) __new = (n);                                         \
+                                                                               \
+		if (list_empty(__head)) {                                      \
+			list_add(__head, &__new->node);                        \
+			break;                                                 \
+		}                                                              \
+                                                                               \
+		list_for_each (__head, __iter, node) {                         \
+			if (cmp(__new, __iter) < 0) {                          \
+				list_add_before(__head, &__iter->node,         \
+						&__new->node);                 \
+				break;                                         \
+			}                                                      \
+			__next = list_next(__head, __iter, node);              \
+			if (!__next) {                                         \
+				list_add_after(__head, &__iter->node,          \
+					       &__new->node);                  \
+				break;                                         \
+			}                                                      \
+			if (cmp(__new, __next) < 0) {                          \
+				list_add_before(__head, &__next->node,         \
+						&__new->node);                 \
+				break;                                         \
+			}                                                      \
+		}                                                              \
+	} while (0)
+
+#endif /* _NDCTL_LIST_H_ */

