Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E078C61DA4
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Feb 2023 21:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjBCV5Z (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Feb 2023 16:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbjBCV5X (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Feb 2023 16:57:23 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DD888CFE
        for <linux-cxl@vger.kernel.org>; Fri,  3 Feb 2023 13:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675461436; x=1706997436;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=VefnzpEsvylTKY63n5fnuX2lkN52K6wEsPPU5OQtVBc=;
  b=RAjF6lLZVQVzgQA/bvXUxvCSY8LAFnFS1Z6tY2Cd45Aw/2AebL1GnkWY
   ZVnOBda2EKNrspjSTfrfhm3ij7e2ne5VIlVxVR+/ApMJZU61qdFbSmv8N
   HZXYrm7g1XqqzvyXGLhhjuZ16zZQXMFfUqEo8MYwmuJj/8BscCRemLwum
   ezZwXqr87AAk/zs4OviRcJ3Xr+hved/sOOLtCvOWsaHgMLHJh7PizeSkH
   VVvZf8iy5LJ6rjXVD8xlivsFCp34hlFPeRPM/4bkGeYKqO5yv4TyqWNYq
   FDu1AUww5amAiXDHl3gFHZbl4I64StTqPUmox1/QXbDIW84TbT0C1aR8l
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="415078929"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="415078929"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 13:56:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="665868650"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="665868650"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.251.23.59])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 13:56:46 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Fri, 03 Feb 2023 13:56:42 -0800
Subject: [PATCH ndctl] ndctl/cxl: Remove unnecessary null check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230201-update_query-v1-1-4dd3de2d35c1@intel.com>
X-B4-Tracking: v=1; b=H4sIABqD3WMC/x2NQQqDMBAAvyJ7NpDEFq1fEZGN2eoeTHWjYhH/3
 tjjDAxzQiRhilBnJwjtHPkTEpg8g37EMJBinxistoW22qht9rhSt2wkX4XeVo+nQ/MqEVLiMJJy
 gqEf72hCDreehd58/C9Ne10/hm7m3XUAAAA=
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.11.0-dev-e429b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675461405; l=1192;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=VefnzpEsvylTKY63n5fnuX2lkN52K6wEsPPU5OQtVBc=;
 b=hsSDLf+VxLgp1+JnMGbynVXWpQmMolaBEWjXvuRcVdt5Je9S5cvhGtVdVrgDvutpFNoQCed0fxn2
 5EWDtgukC2sr1ACJ1ZZy5fopoz0qW4xLQRjGS2gyLGTI6Yu9tR/t
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

cmd->query_cmd can never be null in cxl_cmd_alloc_send().  The only call chain
is:

        cxl_cmd_do_query(cmd);
        cxl_cmd_validate(cmd, cmd_id);
        cxl_cmd_alloc_send(cmd, cmd_id);

And cxl_cmd_do_query() ensures it is non-null.  In addition the local variable
query is already dereferenced by the time it is checked for null.

Remove the unneeded null check.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Minor fix I found while working on the kernel side query command.
---
 cxl/lib/libcxl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 4205a587d3bb..4859bd5e2fbb 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -3091,9 +3091,6 @@ static int cxl_cmd_alloc_send(struct cxl_cmd *cmd, u32 cmd_id)
 	struct cxl_command_info *cinfo = &query->commands[cmd->query_idx];
 	size_t size;
 
-	if (!query)
-		return -EINVAL;
-
 	size = sizeof(struct cxl_send_command);
 	cmd->send_cmd = calloc(1, size);
 	if (!cmd->send_cmd)

---
base-commit: b73e4e0390aae822bc91b8bf72430e6f0e84d668
change-id: 20230201-update_query-ad2845ba197a

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>
