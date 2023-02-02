Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BBDC05027
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Feb 2023 01:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjBBBXq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Feb 2023 20:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBBBXp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Feb 2023 20:23:45 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E284D3FF12
        for <linux-cxl@vger.kernel.org>; Wed,  1 Feb 2023 17:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675301016; x=1706837016;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=+i9oSZfQ5g+3vvuIPaluv8EpQnA5jiwde6foWG0D3TI=;
  b=CQERrmgJ00NXKCyqWc6gGK5O/G+lAzvp+wK/H6RBemwJvUgT6xTkzOq3
   9Km1TnE8gZYIkSrfQe1Gy12+xJZ1Ljf8il8yoz2y2HyNsrAneE9Oj4DkO
   jV1J6ge55ld5qgpLy1HNH8mMlz/+vfATKXbGtc6CrAbRzwixm2QPVilie
   YD2lX2haN8JH9nSbG2+8nl1Zvb8m9XRqvyMhkqR/q8qkih2XslZ18Zoxg
   twMy9OzOBIfF6PgwfkI36a0Azb7343VGkkzV8+QlRJ+g1gcF0lErfDfPm
   KwThbpBdnNDJrzT0Qj6jM+JN0tVugjR4REXSyY6Z+YAT4koA99oUIN8Lf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="308661530"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="308661530"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 17:23:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="993888785"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="993888785"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.15.11])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 17:23:30 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 01 Feb 2023 17:23:12 -0800
Subject: [PATCH v3 3/4] cxl/uapi: Tag commands from cxl_query_cmd()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221222-cxl-misc-v3-3-60d4f35e4b39@intel.com>
References: <20221222-cxl-misc-v3-0-60d4f35e4b39@intel.com>
In-Reply-To: <20221222-cxl-misc-v3-0-60d4f35e4b39@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675301007; l=2301;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=+i9oSZfQ5g+3vvuIPaluv8EpQnA5jiwde6foWG0D3TI=;
 b=YrdrwfWlDCcCBJlkSctsmssLIrnL91qoX5tWATw7rDp2H61VSZGKaI1Km4pgaUnwN61jb2p0cQX6
 neSasFptDXGnftNJhGM4NSFzNU5YTHggnS+JXPq9ICA1srd532ae
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
Changes for v3:
	Dan
		Pass enabled/exclusive flags to user space rather than
		masking those commands.
---
 drivers/cxl/core/mbox.c      | 9 +++++++--
 include/uapi/linux/cxl_mem.h | 4 +++-
 2 files changed, 10 insertions(+), 3 deletions(-)

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
index 459a3f7f764b..4aee64b7cc1a 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -91,7 +91,9 @@ struct cxl_command_info {
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
