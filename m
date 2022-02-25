Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B0BC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Feb 2022 20:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbiBYU2Y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Feb 2022 15:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236760AbiBYU2X (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Feb 2022 15:28:23 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D6B8D69E
        for <linux-cxl@vger.kernel.org>; Fri, 25 Feb 2022 12:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645820871; x=1677356871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CMnLN+mZoFMMc+iwa/31qnlF5EA+Yr4d/JMjfbBueOQ=;
  b=XkepKNU0rEXym9lqm9ypT+AgK8AsRBCKr27acGxcqoC3ycNbwa1qfUkW
   NXQ6qKQgEdPyAMq++K0FyBTa5LO+RLmghL1fTO6iJ/s2dL1iSMQUV9T+F
   Pz0TKVjPbYlM0NTilMlVgrHlhpzg+dFhsgn4xAs2T9v6bXkCtZ9Dzf6bd
   qQy8NLw6IaRINstbho4buu4AHbeovHJAz+Y9DH96njYxZJT/BF9323mhl
   aSP2KIeDEd2N32sO+jzVrV657NJfRGmoUqKpD82nRvsJdkj2ylBNP64nK
   ojgC1vsgd6HT3+AlrOb69ghRRVEqI/pQ14N+2c/GFuWdEEzjswdslkffc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="233198456"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="233198456"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 12:27:31 -0800
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="684753717"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 12:27:30 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2 0/4] Do not allow set-partition immediate mode
Date:   Fri, 25 Feb 2022 12:30:57 -0800
Message-Id: <cover.1645817416.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

The v1 to address this issue was a single patch [1] that inserted
a new immediate mode check in the send path where the payload was
available for examining. That was not in the 'validation' function.

Reviewer feedback led to refactoring the send path of userspace mailbox
commands so that validation work can all spawn from one place:
cxl_validate_cmd_from_user().

Hence this set:
Patches 1,2: Refactor existing code. 
Patch 3: Blocks the immediate mode of the set-partition command.
	 Original v1 patch updated per reviewer feedback.
Patch 4: Removes CXL_PMEM exclusive commands restriction.

Changes in v2:
- Refactor the send path of userspace mbox cmds. (Dan, Ben)
- Patch 3 commit log - update the need to block. (Dan)
- Return -EBUSY (not -EINVAL), when blocking immediate mode. (Ben)
- Remove unneeded cast of void (payload_in). (dan)
- s/u64/__le64 in struct cxl_mbox_set_partition_info. (Dan)

[1] https://lore.kernel.org/linux-cxl/20220103202100.784194-1-alison.schofield@intel.com/

Alison Schofield (4):
  cxl/mbox: Move cxl_mem_command construction to helper funcs
  cxl/mbox: Centralize the validation of user commands
  cxl/mbox: Block immediate mode in SET_PARTITION_INFO command
  cxl/pmem: Remove CXL SET_PARTITION_INFO from exclusive_cmds list

 drivers/cxl/core/mbox.c | 308 +++++++++++++++++++++++-----------------
 drivers/cxl/cxlmem.h    |   7 +
 drivers/cxl/pmem.c      |   1 -
 3 files changed, 184 insertions(+), 132 deletions(-)


base-commit: 3e9e1e72c0c24fcbeb8c96f4e886be138f61496f
-- 
2.31.1

