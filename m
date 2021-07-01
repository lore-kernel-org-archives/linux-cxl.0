Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF9CC11F75
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jul 2021 20:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA5126141E
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jul 2021 20:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhGAUM5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Jul 2021 16:12:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:63971 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233930AbhGAUM4 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 1 Jul 2021 16:12:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="208653273"
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="208653273"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 13:10:24 -0700
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="409271416"
Received: from anandvig-mobl.amr.corp.intel.com (HELO vverma7-desk.amr.corp.intel.com) ([10.254.38.85])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 13:10:23 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH v3 17/21] test/libcxl: add a test for cxl_memdev_{get,set}_lsa
Date:   Thu,  1 Jul 2021 14:10:01 -0600
Message-Id: <20210701201005.3065299-18-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210701201005.3065299-1-vishal.l.verma@intel.com>
References: <20210701201005.3065299-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a unit test to test the new get/set LSA APIs in libcxl.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 test/libcxl.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/test/libcxl.c b/test/libcxl.c
index 10f96f2..e3da19c 100644
--- a/test/libcxl.c
+++ b/test/libcxl.c
@@ -454,6 +454,43 @@ out_fail:
 	return rc;
 }
 
+static char *test_lsa_api_data = "LIBCXL_TEST READ/WRITE LSA DATA 2";
+static int test_cxl_read_write_lsa(struct cxl_ctx *ctx)
+{
+	int data_size = strlen(test_lsa_api_data) + 1;
+	struct cxl_memdev *memdev;
+	unsigned char *buf;
+	int rc = 0;
+
+	buf = calloc(1, data_size);
+	if (!buf)
+		return -ENOMEM;
+
+	cxl_memdev_foreach(ctx, memdev) {
+		rc = cxl_memdev_set_lsa(memdev, test_lsa_api_data, data_size, 0);
+		if (rc)
+			goto out_fail;
+
+		rc = cxl_memdev_get_lsa(memdev, buf, data_size, 0);
+		if (rc < 0)
+			goto out_fail;
+
+		if (memcmp(buf, test_lsa_api_data, data_size) != 0) {
+			fprintf(stderr, "%s: LSA data mismatch.\n", __func__);
+			fprintf(stderr, "%s: Get LSA returned:\n", __func__);
+			hex_dump_buf(buf, data_size);
+			fprintf(stderr, "%s: Set LSA had set:\n", __func__);
+			hex_dump_buf((unsigned char *)test_lsa_api_data, data_size);
+			rc = -EIO;
+			goto out_fail;
+		}
+	}
+
+out_fail:
+	free(buf);
+	return rc;
+}
+
 typedef int (*do_test_fn)(struct cxl_ctx *ctx);
 
 static do_test_fn do_test[] = {
@@ -463,6 +500,7 @@ static do_test_fn do_test[] = {
 	test_cxl_cmd_identify,
 	test_cxl_cmd_lsa,
 	test_cxl_cmd_fuzz_sizes,
+	test_cxl_read_write_lsa,
 };
 
 static int test_libcxl(int loglevel, struct test_ctx *test, struct cxl_ctx *ctx)
-- 
2.31.1

