Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5560DC3DA7A
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Dec 2022 04:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbiLVEZV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Dec 2022 23:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiLVEY5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Dec 2022 23:24:57 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A2FD57
        for <linux-cxl@vger.kernel.org>; Wed, 21 Dec 2022 20:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671683097; x=1703219097;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=XGNtHbyVzjRM6zP+BrVd5/RaxuH73xazAUYM0GbkcYU=;
  b=PUFRvjbZe3HF23YPu9xCxN+NmUDykeiaJ0hy2w9imfSQem0O1Iqf/JLn
   WNwigXTKvBaeUheJfhZ8bSD9w+uHl7jYDQIGoTxMYN6hxcwmAo9MAsspT
   erCnlv5ZXpLu415v4rmJHck/eJ382JBO7msdgLwO+74TW3y7QtaLGDFmh
   y5/xU1/Xnj9OLbKnhd9Qy+YUOW/P9j4LjgwGIL7BZt9bmbMjFYTMyvX8O
   UkKuAyyps19j9owv7tlqMWGWJC9N3uTwM2V88sNDWhC+UuwMgflFscg4z
   el71DbioGFwkT2Bj3+mM26ILEfCCtGfWsTGzqZTfV3rnZrVePUU9WRNbi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="321957590"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="321957590"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 20:24:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="601733192"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="601733192"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.20.211])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 20:24:56 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 21 Dec 2022 20:24:32 -0800
Subject: [PATCH v2 2/8] qemu/uuid: Add UUID static initializer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221221-ira-cxl-events-2022-11-17-v2-2-2ce2ecc06219@intel.com>
References: <20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com>
In-Reply-To: <20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>
X-Mailer: b4 0.11.0-dev-141d4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671683093; l=1574;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=XGNtHbyVzjRM6zP+BrVd5/RaxuH73xazAUYM0GbkcYU=;
 b=7sLIDzTSr2nn7ij9GENb4v+W0NXmQNOuFcR+/0BAMgslxVcrBtgGkWzFtn3bks+zpTJeF1qtHpFC
 93hb7iYICYn7BTztkIdTd0kEGQ11LwsclTMVy2FXJzTOceov8utU
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

UUID's are defined as network byte order fields.  No static initializer
was available for UUID's in their standard big endian format.

Define a big endian initializer for UUIDs.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/qemu/uuid.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
index 9925febfa54d..dc40ee1fc998 100644
--- a/include/qemu/uuid.h
+++ b/include/qemu/uuid.h
@@ -61,6 +61,18 @@ typedef struct {
     (clock_seq_hi_and_reserved), (clock_seq_low), (node0), (node1), (node2),\
     (node3), (node4), (node5) }
 
+/* Normal (network byte order) UUID */
+#define UUID(time_low, time_mid, time_hi_and_version,                    \
+  clock_seq_hi_and_reserved, clock_seq_low, node0, node1, node2,         \
+  node3, node4, node5)                                                   \
+  { ((time_low) >> 24) & 0xff, ((time_low) >> 16) & 0xff,                \
+    ((time_low) >> 8) & 0xff, (time_low) & 0xff,                         \
+    ((time_mid) >> 8) & 0xff, (time_mid) & 0xff,                         \
+    ((time_hi_and_version) >> 8) & 0xff, (time_hi_and_version) & 0xff,   \
+    (clock_seq_hi_and_reserved), (clock_seq_low),                        \
+    (node0), (node1), (node2), (node3), (node4), (node5)                 \
+  }
+
 #define UUID_FMT "%02hhx%02hhx%02hhx%02hhx-" \
                  "%02hhx%02hhx-%02hhx%02hhx-" \
                  "%02hhx%02hhx-" \

-- 
2.38.1
