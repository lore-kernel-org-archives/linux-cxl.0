Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A41DC54EAA
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 00:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjA1AKi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 19:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjA1AKg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 19:10:36 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BE62692
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 16:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674864626; x=1706400626;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=8NyFhgbhQG1X8QwaYEv9c6EeEgpqjuu8OsFmhBTWvuo=;
  b=XjTPAEQ5lJv5h8ZwKRYgiZE6pM8T9EW8x0TIiMEua1b0p0n5fIlrSJvG
   amTzyQ/PB/KxurUq8K3cWQsUYhbnzIEJ3POJtuFiADG929A+Kz7+odzm9
   kTHUStudn1seEIrJOU+oK4Fo0KQcJqPHRdy1abpZu/LPStQmCHfPoUk7V
   TH4qP/+8S482THO5tBtbB+pAdZszn9Pk0XDbb0G46wIPPbPPmeGH1FGJ3
   sJ5wCPpVGVYZQivEU/+Bwmq2P7X4vo3IfNrmBlSXck8pXwMLMSCcKfX7m
   nj56u5/G/gBuitX3Sdw3gYw39g0cIlMfbz7Wi2dhjR/ZHPsXfOjR8Ei0l
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="389608231"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="389608231"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 16:09:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="656793061"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="656793061"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.64.226])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 16:09:48 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Fri, 27 Jan 2023 16:09:40 -0800
Subject: [PATCH v2 3/4] cxl/uapi: Only return valid commands from cxl_query_cmd()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221222-cxl-misc-v2-3-60403cc37257@intel.com>
References: <20221222-cxl-misc-v2-0-60403cc37257@intel.com>
In-Reply-To: <20221222-cxl-misc-v2-0-60403cc37257@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.11.0-dev-e429b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674864584; l=2871;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=8NyFhgbhQG1X8QwaYEv9c6EeEgpqjuu8OsFmhBTWvuo=;
 b=mAn1Q5XkO+LtkjKSz0r/MzkWDOsLkIyzRE/0HVbieddzI5J7y5rkK84z/N52zXf+kRi8u8zF7uWC
 OjvpVqZKBRl7xjdDywI5GxpCrD6vvlXCoKvskOgU05XogAzDeEL9
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

It was pointed out that commands not supported by the device or excluded
by the kernel were being returned in cxl_query_cmd().[1]

While libcxl correctly handles failing commands, it is more efficient to
not issue an invalid command in the first place.

Exclude both kernel exclusive and disabled commands from the list of
commands returned by cxl_query_cmd().

[1] https://lore.kernel.org/all/63b4ec4e37cc1_5178e2941d@dwillia2-xfh.jf.intel.com.notmuch/

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v2:
	New patch
---
 drivers/cxl/core/mbox.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index b03fba212799..a1618b7f01e5 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -326,12 +326,27 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
 	return 0;
 }
 
+/* Return 0 if the cmd id is available for userspace */
+static int cxl_cmd_id_user(__u32 id, struct cxl_dev_state *cxlds)
+{
+	/* Check that the command is enabled for hardware */
+	if (!test_bit(id, cxlds->enabled_cmds))
+		return -ENOTTY;
+
+	/* Check that the command is not claimed for exclusive kernel use */
+	if (test_bit(id, cxlds->exclusive_cmds))
+		return -EBUSY;
+
+	return 0;
+}
+
 static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
 			  const struct cxl_send_command *send_cmd,
 			  struct cxl_dev_state *cxlds)
 {
 	struct cxl_mem_command *c = &cxl_mem_commands[send_cmd->id];
 	const struct cxl_command_info *info = &c->info;
+	int rc;
 
 	if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
 		return -EINVAL;
@@ -342,13 +357,9 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
 	if (send_cmd->in.rsvd || send_cmd->out.rsvd)
 		return -EINVAL;
 
-	/* Check that the command is enabled for hardware */
-	if (!test_bit(info->id, cxlds->enabled_cmds))
-		return -ENOTTY;
-
-	/* Check that the command is not claimed for exclusive kernel use */
-	if (test_bit(info->id, cxlds->exclusive_cmds))
-		return -EBUSY;
+	rc = cxl_cmd_id_user(info->id, cxlds);
+	if (rc)
+		return rc;
 
 	/* Check the input buffer is the expected size */
 	if ((info->size_in != CXL_VARIABLE_PAYLOAD) &&
@@ -446,9 +457,15 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
 	 */
 	cxl_for_each_cmd(cmd) {
 		const struct cxl_command_info *info = &cmd->info;
+		struct cxl_dev_state *cxlds = cxlmd->cxlds;
+		int rc;
 
-		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
-			return -EFAULT;
+		rc = cxl_cmd_id_user(info->id, cxlds);
+		if (!rc) {
+			if (copy_to_user(&q->commands[j++], info,
+					 sizeof(*info)))
+				return -EFAULT;
+		}
 
 		if (j == n_commands)
 			break;

-- 
2.39.1
