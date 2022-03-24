Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77B1C433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 24 Mar 2022 01:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbiCXBKX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Mar 2022 21:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240432AbiCXBKW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Mar 2022 21:10:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3EC527D3
        for <linux-cxl@vger.kernel.org>; Wed, 23 Mar 2022 18:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648084130; x=1679620130;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kPn9FsgRWvpZktZa/D8JyVHSeK6QUSW65xnGgklm/3Y=;
  b=XSm2/ol30vs5Ip6gFZol4gtnDSAAw9OIsD3rLCsasPj0TZzJBrlxK9NJ
   tqJke9Kz6LUOAz62Kxe7T/Cer/Tbn+qwFAsAXVWXuXn2eeoa3Fmf28Wta
   eo2cK5nEfxSqwstw3sg+HzaOz54Vgez0EyY8yQhVglKq2FoH/vgMms4js
   eaUztQlfd9PJ72jcQQOGrQ5zfa1VS6cPM0to/egYc+/ZG5wXf6BByG7AS
   +MZE5Iuj9Eiv8nTITRyPNFdxdikU9b3S+S166EODRFCPV1qLSUu2YyzTj
   +J3cA2U9cpikJltba0275unH8vQgfYz8OUJDsywZtK9r67FLao12F2nQF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="321457629"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="321457629"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:08:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="561161449"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:08:50 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v3 0/9]  Do not allow set-partition immediate mode
Date:   Wed, 23 Mar 2022 18:11:17 -0700
Message-Id: <20220324011126.1144504-1-alison.schofield@intel.com>
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

The v2 patchset [2] added refactoring of the send path so that
validation work can all spawn from cxl_validate_cmd_from_user().

Here, v3 offers a finer level of refactoring:

Patches 1-7: Refactor existing code so that all validation work
	can spawn from cxl_validate_cmd_from_user().

	The movement intends to cleanly rip the work of building a
	mailbox command away from handle_mailbox_command_from_user()
	and give it to cxl_validate_cmd_from_user().

Patch 8: Blocks the immediate mode of the set-partition command.
Patch 9: Removes CXL_PMEM exclusive commands restriction.

[1] https://lore.kernel.org/linux-cxl/20220103202100.784194-1-alison.schofield@intel.com/
[2] https://lore.kernel.org/linux-cxl/a4daafc4b537a0b1a673c55300da7747784c4573.1645817416.git.alison.schofield@intel.com/

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
  cxl/mbox: Move build of user mailbox cmd to a helper function
  cxl/mbox: Construct a users cxl_mbox_cmd in the validation path
  cxl/mbox: Remove dependency on cxl_mem_command for a debug msg
  cxl/mbox: Make handle_mailbox_cmd_from_user() use a mbox param
  cxl/mbox: Move cxl_mem_command param to a local variable
  cxl/mbox: Block immediate mode in SET_PARTITION_INFO command
  cxl/pmem: Remove CXL SET_PARTITION_INFO from exclusive_cmds list

 drivers/cxl/core/mbox.c | 311 +++++++++++++++++++++++++---------------
 drivers/cxl/cxlmem.h    |   7 +
 drivers/cxl/pmem.c      |   1 -
 3 files changed, 200 insertions(+), 119 deletions(-)


base-commit: 9b688fc651b9d2b633e8d959454670aba1c39162
-- 
2.31.1

