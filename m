Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E517C05023
	for <linux-cxl@archiver.kernel.org>; Wed, 20 Sep 2023 20:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjITUuM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 20 Sep 2023 16:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjITUuM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 20 Sep 2023 16:50:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF012B9
        for <linux-cxl@vger.kernel.org>; Wed, 20 Sep 2023 13:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695243006; x=1726779006;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=96f1p13qBXDdV4fCdEgIEto8qvKn3jLUbRiKxQQrAP8=;
  b=n+FWa7EGrwq+iSSPEfl5f3IuhHHDl1zHMZI+KOWo/ACg8weWWq5Tvl2X
   YA4+kS9nND2lyEJzuT9FCCYOF2Ppbx0t8aYMWRU9y6iY5tC05xcv9/KBL
   WfMq1o23UNqVavSs7BKhZZdebW75M7NytokETMxzHj+/zrJ43UGUp5l6q
   PXk5snWoyaHUsglIYOZRa9mXQc7WuP5Y8IJeZMX/T9IZbfR/r7Rf22jZ3
   OlZ5fKlWmAmw6YNqhIovjpaNZL4S+MzV1u5Yhz+jF/5V9Q8+atEM/W/iv
   TaJtWp5TPFUm71ZOWYErjXfxDlFSbqyspx3hXjzGsiGChK808N6ONxsfB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="377634822"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="377634822"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 13:50:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="776143837"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="776143837"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.114.229])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 13:50:04 -0700
Subject: [PATCH v3] cxl: Remove noisy dev_dbg() outputs
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave@stgolabs.net, jonathan.cameron@huawei.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com
Date:   Wed, 20 Sep 2023 13:50:04 -0700
Message-ID: <169524300432.3077964.4526387988891514104.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Remove noisy enumeration of commands and CEL opcodes via dev_dbg()
emit. These outputs were useful during early development. However they are
now unnecessary and creates excessive noise in the debug log. On certain
hardware up to 500+ entries have been observed.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
https://lore.kernel.org/linux-cxl/b72946f0-31dd-b22a-f2e8-a12eb2f522ae@intel.com/T/#t

v3:
- Drop eventtrace and just remove the dev_dbg(). (Ira & Alison)
v2:
- Add enabling note in commit log (Ira)
---
 drivers/cxl/core/mbox.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index ca60bb8114f2..963c668a4eb4 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -707,7 +707,6 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 {
 	struct cxl_cel_entry *cel_entry;
 	const int cel_entries = size / sizeof(*cel_entry);
-	struct device *dev = mds->cxlds.dev;
 	int i;
 
 	cel_entry = (struct cxl_cel_entry *) cel;
@@ -717,11 +716,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
 
 		if (!cmd && (!cxl_is_poison_command(opcode) ||
-			     !cxl_is_security_command(opcode))) {
-			dev_dbg(dev,
-				"Opcode 0x%04x unsupported by driver\n", opcode);
+			     !cxl_is_security_command(opcode)))
 			continue;
-		}
 
 		if (cmd)
 			set_bit(cmd->info.id, mds->enabled_cmds);
@@ -731,8 +727,6 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 
 		if (cxl_is_security_command(opcode))
 			cxl_set_security_cmd_enabled(&mds->security, opcode);
-
-		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
 	}
 }
 
@@ -787,7 +781,6 @@ static const uuid_t log_uuid[] = {
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 {
 	struct cxl_mbox_get_supported_logs *gsl;
-	struct device *dev = mds->cxlds.dev;
 	struct cxl_mem_command *cmd;
 	int i, rc;
 
@@ -801,8 +794,6 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 		uuid_t uuid = gsl->entry[i].uuid;
 		u8 *log;
 
-		dev_dbg(dev, "Found LOG type %pU of size %d", &uuid, size);
-
 		if (!uuid_equal(&uuid, &log_uuid[CEL_UUID]))
 			continue;
 


