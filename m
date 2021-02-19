Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D071C433E6
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Feb 2021 02:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD8764ED7
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Feb 2021 02:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbhBSCFg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 Feb 2021 21:05:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:50640 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhBSCFf (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 18 Feb 2021 21:05:35 -0500
IronPort-SDR: h+Uy8wltmWJO9++D/nZCfC2MtfEqiryaTbnReHUQCy3SVd4IwKxRWfFx3UdGzQINq4airp2v2n
 J5pPeS8Bwf9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="162854729"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="162854729"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:56 -0800
IronPort-SDR: GDo/Lx3087n09v8JUHr7Uq+iVJYdHjkn5E9SJCY4BSfaDrVZ0LNIlGn/5yddP+DW13WspLCjTl
 VidP7VO+NcwQ==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="513509691"
Received: from jnavar1-mobl4.amr.corp.intel.com (HELO omniknight.intel.com) ([10.213.167.18])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:56 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <linux-nvdimm@lists.01.org>, Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH v2 13/13] test/libcxl: introduce a command size fuzzing test
Date:   Thu, 18 Feb 2021 19:03:31 -0700
Message-Id: <20210219020331.725687-14-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210219020331.725687-1-vishal.l.verma@intel.com>
References: <20210219020331.725687-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a new test within test/libcxl which tries different combinations of
valid and invalid payload sizes, and ensures that the kernel responds as
expected by either succeeding, erroring out the ioctl, adjusting the
out.size in the response etc.

The fuzz set is a statically defined array which contains the different
combinations to test. Adding a new combination onle needs appending to
this array.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 test/libcxl.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/test/libcxl.c b/test/libcxl.c
index 1cff32c..f7233b2 100644
--- a/test/libcxl.c
+++ b/test/libcxl.c
@@ -210,6 +210,117 @@ out_fail:
 	return rc;
 }
 
+struct cmd_fuzzer {
+	struct cxl_cmd *(*new_fn)(struct cxl_memdev *memdev);
+	int in;		/* in size to set in cmd (INT_MAX = don't change) */
+	int out;	/* out size to set in cmd (INT_MAX = don't change) */
+	int e_out;	/* expected out size returned (INT_MAX = don't check) */
+	int e_rc;	/* expected ioctl return (INT_MAX = don't check) */
+	int e_hwrc;	/* expected 'mbox_status' (INT_MAX = don't check) */
+} fuzz_set[] = {
+	{ cxl_cmd_new_identify, INT_MAX, INT_MAX, 67, 0, 0 },
+	{ cxl_cmd_new_identify, 64, INT_MAX, INT_MAX, -ENOMEM, INT_MAX },
+	{ cxl_cmd_new_identify, INT_MAX, 1024, 67, 0, INT_MAX },
+	{ cxl_cmd_new_identify, INT_MAX, 16, INT_MAX, -ENOMEM, INT_MAX },
+};
+
+static int do_one_cmd_size_test(struct cxl_memdev *memdev,
+		struct cmd_fuzzer *test)
+{
+	const char *devname = cxl_memdev_get_devname(memdev);
+	struct cxl_cmd *cmd;
+	int rc;
+
+	cmd = test->new_fn(memdev);
+	if (!cmd)
+		return -ENOMEM;
+
+	if (test->in != INT_MAX) {
+		rc = cxl_cmd_set_input_payload(cmd, NULL, test->in);
+		if (rc) {
+			fprintf(stderr,
+				"%s: %s: failed to set in.size (%d): %s\n",
+				__func__, devname, test->in, strerror(-rc));
+			goto out_fail;
+		}
+	}
+	if (test->out != INT_MAX) {
+		rc = cxl_cmd_set_output_payload(cmd, NULL, test->out);
+		if (rc) {
+			fprintf(stderr,
+				"%s: %s: failed to set out.size (%d): %s\n",
+				__func__, devname, test->out, strerror(-rc));
+			goto out_fail;
+		}
+	}
+
+	rc = cxl_cmd_submit(cmd);
+	if (test->e_rc != INT_MAX && rc != test->e_rc) {
+		fprintf(stderr, "%s: %s: expected cmd rc %d, got %d\n",
+			__func__, devname, test->e_rc, rc);
+		rc = -ENXIO;
+		goto out_fail;
+	}
+
+	rc = cxl_cmd_get_out_size(cmd);
+	if (test->e_out != INT_MAX && rc != test->e_out) {
+		fprintf(stderr, "%s: %s: expected response out.size %d, got %d\n",
+			__func__, devname, test->e_out, rc);
+		rc = -ENXIO;
+		goto out_fail;
+	}
+
+	rc = cxl_cmd_get_mbox_status(cmd);
+	if (test->e_hwrc != INT_MAX && rc != test->e_hwrc) {
+		fprintf(stderr, "%s: %s: expected firmware status %d, got %d\n",
+			__func__, devname, test->e_hwrc, rc);
+		rc = -ENXIO;
+		goto out_fail;
+	}
+	return 0;
+
+out_fail:
+	cxl_cmd_unref(cmd);
+	return rc;
+
+}
+
+static void print_fuzz_test_status(struct cmd_fuzzer *t, const char *devname,
+		unsigned long idx, const char *msg)
+{
+	fprintf(stderr,
+		"%s: fuzz_set[%lu]: in: %d, out %d, e_out: %d, e_rc: %d, e_hwrc: %d, result: %s\n",
+		devname, idx,
+		(t->in == INT_MAX) ? -1 : t->in,
+		(t->out == INT_MAX) ? -1 : t->out,
+		(t->e_out == INT_MAX) ? -1 : t->e_out,
+		(t->e_rc == INT_MAX) ? -1 : t->e_rc,
+		(t->e_hwrc == INT_MAX) ? -1 : t->e_hwrc,
+		msg);
+}
+
+static int test_cxl_cmd_fuzz_sizes(struct cxl_ctx *ctx)
+{
+	struct cxl_memdev *memdev;
+	unsigned long i;
+	int rc;
+
+	cxl_memdev_foreach(ctx, memdev) {
+		const char *devname = cxl_memdev_get_devname(memdev);
+
+		for (i = 0; i < ARRAY_SIZE(fuzz_set); i++) {
+			rc = do_one_cmd_size_test(memdev, &fuzz_set[i]);
+			if (rc) {
+				print_fuzz_test_status(&fuzz_set[i], devname,
+					i, "FAIL");
+				return rc;
+			}
+			print_fuzz_test_status(&fuzz_set[i], devname, i, "OK");
+		}
+	}
+	return 0;
+}
+
 static int debugfs_write_raw_flag(char *str)
 {
 	char *path = "/sys/kernel/debug/cxl/mbox/raw_allow_all";
@@ -350,6 +461,7 @@ static do_test_fn do_test[] = {
 	test_cxl_emulation_env,
 	test_cxl_cmd_identify,
 	test_cxl_cmd_lsa,
+	test_cxl_cmd_fuzz_sizes,
 };
 
 static int test_libcxl(int loglevel, struct test_ctx *test, struct cxl_ctx *ctx)
-- 
2.29.2

