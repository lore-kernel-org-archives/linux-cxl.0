Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD36C636D3
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Feb 2023 01:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjBCBFc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 20:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjBCBFa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 20:05:30 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE337564BF
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 17:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675386329; x=1706922329;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=cAdCW2dnn9H6Ph5wxfVjzfIXzViYzjaE5/x4RpEKk2s=;
  b=WAL0N4i2S4U3U9zCuBuGbNmxVpPn8rjb2v6MvjKkNbcDy6lUIwy3Gn3+
   PxtBoWhUWka1b5svvgY7OND3QMzPPi8NjihYayPm1yfVSn0Xz8Ndbzote
   qkYn0pdEPkgYGkzukY6Fnm2ZU0ZPsmq7AaArkZZN9AJHRc7xD3H96BySM
   vBUHqgNmY6QtIa5TnYkUbrKI3FkTvq2dGQB4m2MBxelwb2fQiG0H3LM7+
   adDX5okwxlquvDmoh5SFrjAwtdKJbzAfLp4FsqZ174QbKdtz+ngLrmCQn
   2Y6V2w1QrTOhB4yUSzt9AS3OnUlM6DZguNTFlE0ahDsz0cUGS3QK40VdA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="393215332"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="393215332"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 17:04:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="839412552"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="839412552"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.229.82])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 17:04:38 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Thu, 02 Feb 2023 17:04:26 -0800
Subject: [PATCH v4 3/4] cxl/uapi: Tag commands from cxl_query_cmd()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221222-cxl-misc-v4-3-62f701c1cdd1@intel.com>
References: <20221222-cxl-misc-v4-0-62f701c1cdd1@intel.com>
In-Reply-To: <20221222-cxl-misc-v4-0-62f701c1cdd1@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675386275; l=3329;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=cAdCW2dnn9H6Ph5wxfVjzfIXzViYzjaE5/x4RpEKk2s=;
 b=vXX5i89dEhPSLlYhMnjaW2TqoEo0Ey7f8VUgy3u9x61H7rsib+ruLmQRVLD2G6AYbGqYJwqUWEUa
 KB1rR3HyDcts6RLdTcrI8piVMuRWhZDETSU5TsxNjcKlp9cHLvK5
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

It was pointed out that commands not supported by the device or excluded
by the kernel were being returned in cxl_query_cmd().[1]

While libcxl correctly handles failing commands, it is more efficient to
not issue an invalid command in the first place.  This can't be done
without additional information being returned from cxl_query_cmd().  In
addition, information about the availability of commands can be useful
for debugging.

Add flags to struct cxl_command_info which reflect if a command is
enabled and/or exclusive to the kernel.

[1] https://lore.kernel.org/all/63b4ec4e37cc1_5178e2941d@dwillia2-xfh.jf.intel.com.notmuch/

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v4:
	Jonathan
		Add Documentation for the flags
---
 drivers/cxl/core/mbox.c      |  9 +++++++--
 include/uapi/linux/cxl_mem.h | 19 +++++++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index b03fba212799..6ab4613f3cf9 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -445,9 +445,14 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
 	 * structures.
 	 */
 	cxl_for_each_cmd(cmd) {
-		const struct cxl_command_info *info = &cmd->info;
+		struct cxl_command_info info = cmd->info;
 
-		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
+		if (test_bit(info.id, cxlmd->cxlds->enabled_cmds))
+			info.flags |= CXL_MEM_COMMAND_FLAG_ENABLED;
+		if (test_bit(info.id, cxlmd->cxlds->exclusive_cmds))
+			info.flags |= CXL_MEM_COMMAND_FLAG_EXCLUSIVE;
+
+		if (copy_to_user(&q->commands[j++], &info, sizeof(info)))
 			return -EFAULT;
 
 		if (j == n_commands)
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 459a3f7f764b..9fe832afee37 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -72,6 +72,19 @@ static const struct {
  * struct cxl_command_info - Command information returned from a query.
  * @id: ID number for the command.
  * @flags: Flags that specify command behavior.
+ *
+ *         CXL_MEM_COMMAND_FLAG_USER_ENABLED
+ *
+ *         The given command id is supported by the driver and is supported by
+ *         a related opcode on the device.
+ *
+ *         CXL_MEM_COMMAND_FLAG_EXCLUSIVE
+ *
+ *         Requests with the given command id will terminate with EBUSY as the
+ *         kernel actively owns management of the given resource. For example,
+ *         the label-storage-area can not be written while the kernel is
+ *         actively managing that space.
+ *
  * @size_in: Expected input size, or ~0 if variable length.
  * @size_out: Expected output size, or ~0 if variable length.
  *
@@ -81,7 +94,7 @@ static const struct {
  * bytes of output.
  *
  *  - @id = 10
- *  - @flags = 0
+ *  - @flags = CXL_MEM_COMMAND_FLAG_ENABLED
  *  - @size_in = ~0
  *  - @size_out = 0
  *
@@ -91,7 +104,9 @@ struct cxl_command_info {
 	__u32 id;
 
 	__u32 flags;
-#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(0, 0)
+#define CXL_MEM_COMMAND_FLAG_MASK		GENMASK(1, 0)
+#define CXL_MEM_COMMAND_FLAG_ENABLED		BIT(0)
+#define CXL_MEM_COMMAND_FLAG_EXCLUSIVE		BIT(1)
 
 	__u32 size_in;
 	__u32 size_out;

-- 
2.39.1
