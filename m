Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0018CC3A5A7
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 04:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiLFEW0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Dec 2022 23:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiLFEWZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Dec 2022 23:22:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4DA218AB
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 20:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670300543; x=1701836543;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u6tjoHge4n/J8vlHbHx8AHGudwONzR9CGXRXiVYps6E=;
  b=Ppdw0ZodqAXHzwwTWUyyFf/kiU6JIiHmKaA82PY5R7CExtJAPsdRzSyL
   BNDghDgxPuHrgfVhzrORRZLMEYTSLQvkQh0UtPxtYA8E4IKODKEwM6Gi3
   60w1VMUiErgMfz4bJKuKOh6QjJySYgOIOpoXDk3q/f9wqKhbn2bsBd9W8
   D1WKmNAnUGckd/+2KjJ+FzH8Mn5BojKgvjcmKi0M7YX3PdCDrbE4KaSAH
   zF3bL/GWxchLZJsca79tJrLtTj4gGcGpFOPnGvgcFy6ItFlJV0rkjzBX/
   gZ8+gFD7lvFqIg98oU18XWGx64z7vZeaxFTYokC0bIhwihfgi7igY2rXI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="315238625"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="315238625"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 20:22:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="639733699"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="639733699"
Received: from bmnebren-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.114.171])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 20:22:23 -0800
Subject: [PATCH 0/4] cxl/mbox: Output payload validation reworks
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, dave.jiang@intel.com,
        ira.weiny@intel.com
Date:   Mon, 05 Dec 2022 20:22:22 -0800
Message-ID: <167030054261.4044561.2164047490200738083.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

cxl_mbox_send_cmd() mentions:

        /*
         * Variable sized commands can't be validated and so it's up to the
         * caller to do that if they wish.
         */

...but it turns out that is not true. The caller never sees the
resulting output size, so all currently all kernel-internal
variable-output-size command code paths skip output payload size
validation. Additionally, to get any output size validation even for
non-variable sized commands, the command must appear in the
cxl_mem_commands array. That is a waste, especially for internal only
commands like PMEM security commands, because appearing in
cxl_mem_commands currently also a requires new entries in
include/uapi/linux/cxl_mem.h.

Fix this situation by pushing the responsibility to construct a 'struct
cxl_mbox_cmd' to callers. Rename cxl_mbox_send_cmd() to differentiate it
from the ioctl path handling. Add support for validating variable sized
output payloads optionally by a minimum size. Unrelated, but needs to be
fixed before this rework, fixup the endian handling of "Get Security
State" output in cxl_pmem_get_security_flags(). Lastly, remove the
uapi definitions for the security commands, only the opcodes need to be
defined for internal command usage.

---

Dan Williams (4):
      cxl/security: Fix Get Security State output payload endian handling
      cxl/mbox: Enable cxl_mbox_send_cmd() users to validate output size
      cxl/mbox: Add variable output size validation for internal commands
      cxl/security: Drop security command ioctl uapi


 drivers/cxl/core/mbox.c      |  118 ++++++++++++++++++++++--------------------
 drivers/cxl/cxlmem.h         |    6 +-
 drivers/cxl/pmem.c           |   21 ++++++-
 drivers/cxl/security.c       |   81 +++++++++++++++++++++--------
 include/uapi/linux/cxl_mem.h |    6 --
 5 files changed, 142 insertions(+), 90 deletions(-)

base-commit: 02fedf1466567424c336cd11cf368dcf78f2af33
