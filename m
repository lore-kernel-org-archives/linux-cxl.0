Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488AFC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 31 Mar 2022 01:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiCaB0o (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiCaB0o (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Mar 2022 21:26:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D3642A37
        for <linux-cxl@vger.kernel.org>; Wed, 30 Mar 2022 18:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648689898; x=1680225898;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y5AWpleQ4etu6jB5Qm0cWi+n5954qaUyvtR0Q1jaQKo=;
  b=Z40DFQhf/SwCwoCfZX+y5Ap46UdPMw4UnqqWU4M85aAaK2oWUiwwwEVM
   7dgFkgkwJd5/MfY7u+oce/JXQc8TAA8/rvrk/bC9Eps0HVqNL6eZFIgFj
   kEeVLNYA5NDx42pEjFJk8HT6Z3A2QI24llSYZaSjRvg+Ai+Z6hJPRrHgl
   hIPwEP5WCaO3eChHwandhWknBKQnYsvfVXI5CnNIddHq9X6H8fqt3bTTv
   nUkHorIp+0jLB3qJ2+A2PUClGpHSCOQiTP7pDyu+kmus/9cdDz1+VlOEO
   X2F/AZNz144PNn5PAJ9YDLko5JgsdBRWckFOWTmGZ0bk7ZsqIjfNLHvHQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247186020"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="247186020"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:24:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="838664490"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:24:57 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v5 0/9]  Do not allow set-partition immediate mode
Date:   Wed, 30 Mar 2022 18:27:10 -0700
Message-Id: <cover.1648687552.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Blocking immediate mode in set-partition info triggered a
refactoring of the send path of userspace mailbox commands.

The v1 to address the issue was a single patch [1] that inserted
a new immediate mode check in the send path where the payload was
available for examining. That was not in a validation function.

Revisions after v1 included the refactoring of the send path so
that validation work all spawns from cxl_validate_cmd_from_user().

Patches 1-7: Refactor existing code so that all validation work
	can spawn from cxl_validate_cmd_from_user().

	The movement intends to cleanly rip the work of building a
	mailbox command away from handle_mailbox_command_from_user()
	and give it to cxl_validate_cmd_from_user().

Patch 8: Blocks the immediate mode of the set-partition command.
Patch 9: Removes CXL_PMEM exclusive commands restriction.

[1]https://lore.kernel.org/linux-cxl/20220103202100.784194-1-alison.schofield@intel.com/

Changes in v5:
- Put destination params first in function param lists. (Dan)
- Renamed the cxl_to_mbox_cmd() to cxl_mbox_cmd_ctor() and added
  a deconstruct counterpart cxl_mbox_cmd_dtor() to clean up mbox
  allocations. (Dan)
- Added Dan's Reviewed-by tag to Patches 1-6.

Changes in v4: (All from Jonathan's review - Thank-you Jonathan)
- Add a blank line after return
- Combine cxl_mem_command and info declaration and init.
- Replace "rc =" with direct returns in cxl_validate_cmd_from_user()
- Don't init and then overwrite out_size
- Rm the 'refactor foreshadowing' goto & don't restore it later
- Wordsmithing in Patch 4 commit log
- Mv error path to be out of line, normal path inline.
- Move kvfree()'s from handle_mbox...() to cxl_send_cmd()
Patches 1,2,4,5,6,7,8: Added Jonathan Reviewed-by Tags.
Patches 2,7,8,9: No code changes

Changes in v3:
- Split up the 'Centralize the validation...' patch into 6 pieces.
Patch: cxl/mbox: Move cxl_mem_command construction to helper funcs
- Safely initialize the cxl_mem_command structs. (Dan)
- Remove unneeded memcpy (Dan)
Patch: cxl/mbox: Block immediate mode in SET_PARTITION_INFO command
- No Changes
Patch: cxl/pmem: Remove CXL SET_PARTITION_INFO from exclusive_cmds list
- No Changes

Changes in v2:
- Refactor the send path of userspace mbox cmds. (Dan, Ben)
- Patch 3 commit log - update the need to block. (Dan)
- Return -EBUSY (not -EINVAL), when blocking immediate mode. (Ben)
- Remove unneeded cast of void (payload_in). (dan)
- s/u64/__le64 in struct cxl_mbox_set_partition_info. (Dan)


Alison Schofield (9):
  cxl/mbox: Move cxl_mem_command construction to helper funcs
  cxl/mbox: Move raw command warning to raw command validation
  cxl/mbox: Move build of user mailbox cmd to a helper functions
  cxl/mbox: Construct a users cxl_mbox_cmd in the validation path
  cxl/mbox: Remove dependency on cxl_mem_command for a debug msg
  cxl/mbox: Make handle_mailbox_cmd_from_user() use a mbox param
  cxl/mbox: Move cxl_mem_command param to a local variable
  cxl/mbox: Block immediate mode in SET_PARTITION_INFO command
  cxl/pmem: Remove CXL SET_PARTITION_INFO from exclusive_cmds list

 drivers/cxl/core/mbox.c | 339 ++++++++++++++++++++++++----------------
 drivers/cxl/cxlmem.h    |   7 +
 drivers/cxl/pmem.c      |   1 -
 3 files changed, 214 insertions(+), 133 deletions(-)


base-commit: 9b688fc651b9d2b633e8d959454670aba1c39162
-- 
2.31.1

