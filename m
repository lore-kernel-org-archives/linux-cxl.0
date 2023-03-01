Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90619C7EE23
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Mar 2023 21:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCAVgs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 16:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCAVgr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 16:36:47 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2682C66F
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 13:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677706606; x=1709242606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9XlRh/ds203jgRKUL0nOY0dM7MckI8S56IRONmZF5VY=;
  b=IvcutTvuj5HCXHxi/dnq/3jUBAvXE9inLgAMHUSkUbGba2Fb4H1tdf2p
   lMnsudB8axvrciFo4XFI7BoYBSwVhFhxois32IgU/mIBmfikW6lSp7h6y
   nQvBnaHnC8bG3k0KFCsFhyFirOqjgzfJwXl4/M31Q3El6lAaJ2y+E8OMn
   wWx8VFDXeMkr9eYMlV/2G8lfapinYPI59OwOemhmw3xOdTw3+UNxGrnsU
   pJDrf9thBlQX1q+y0RJp5+uybx4Dx2G2QiJAKZj6pxvYUp1TYAexR8xtd
   VQHwTMr5tcmF9g97XACoBXSNH8oGNFmT6XCMiC5DKoJQ1nqpEo5FbHg5N
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397094707"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="397094707"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 13:36:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="784520833"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="784520833"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.70.38])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 13:36:44 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v3 7/8] cxl/memdev: Make inject and clear poison cmds kernel exclusive
Date:   Wed,  1 Mar 2023 13:36:32 -0800
Message-Id: <82199c54a421aeb05fb0e3b4a353a4fed8c98bc9.1677704994.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1677704994.git.alison.schofield@intel.com>
References: <cover.1677704994.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Inject and clear poison commands are intended to be used in debug
mode only, and if improperly used, can lead to data corruption. The
kernel provides a sysfs interface that provides the protection needed
to issue these commands.[1]

The CXL driver defines Enabled commands in its ABI.[2] Enabled means
that the device and the driver both support the command. If a device
supports inject and/or clear, those commands are flagged Enabled.

The ABI also defines another command flag: Exclusive. Exclusive
commands are reserved for kernel use. The exclusive flags can be
temporal, but for inject and clear, the status is permanent.

Document the exclusivity of Inject and Clear in the ABI kernel doc.
(Clean up a typo in kdoc too: 'CXL_MEM_COMMAND_FLAG_ENABLED')

Create an exclusive commands bitmap in the memdev driver, add the
inject and clear poison commands, and set it in the cxl_dev_state.

[1] Documentation/ABI/testing/sysfs-bus-cxl
[2] include/uapi/linux/cxl_mem.h

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/memdev.c    |  6 ++++++
 include/uapi/linux/cxl_mem.h | 21 ++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index ed3e4517dc3a..f746a0c222b6 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -10,6 +10,8 @@
 
 static DECLARE_RWSEM(cxl_memdev_rwsem);
 
+static __read_mostly DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
+
 /*
  * An entire PCI topology full of devices should be enough for any
  * config
@@ -571,6 +573,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 	cxlmd->cxlds = cxlds;
 	cxlds->cxlmd = cxlmd;
 
+	set_bit(CXL_MEM_COMMAND_ID_INJECT_POISON, exclusive_cmds);
+	set_bit(CXL_MEM_COMMAND_ID_CLEAR_POISON, exclusive_cmds);
+	set_exclusive_cxl_commands(cxlds, exclusive_cmds);
+
 	cdev = &cxlmd->cdev;
 	rc = cdev_device_add(cdev, dev);
 	if (rc)
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 86bbacf2a315..6f9ae244f7fd 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -74,17 +74,28 @@ static const struct {
  * @id: ID number for the command.
  * @flags: Flags that specify command behavior.
  *
- *         CXL_MEM_COMMAND_FLAG_USER_ENABLED
+ *         CXL_MEM_COMMAND_FLAG_ENABLED
  *
  *         The given command id is supported by the driver and is supported by
  *         a related opcode on the device.
  *
  *         CXL_MEM_COMMAND_FLAG_EXCLUSIVE
  *
- *         Requests with the given command id will terminate with EBUSY as the
- *         kernel actively owns management of the given resource. For example,
- *         the label-storage-area can not be written while the kernel is
- *         actively managing that space.
+ *	   The given command id is for kernel exclusive use and is not
+ *	   available to userspace. Requests will terminate with EBUSY.
+ *
+ *	   The exclusive flag may be temporal, and only set while the
+ *	   kernel actively owns management of the given resource. For
+ *	   example, the label-storage-area can not be written while the
+ *	   kernel is actively managing that space.
+ *
+ *	   The exclusive flag can be permanent, as in commands that can
+ *	   never be issued through the ioctl interface.
+ *
+ *	   INJECT_POISON and CLEAR_POISON are permanently kernel exclusive.
+ *	   They are supported through a sysfs interface that validates the
+ *	   safety of each command based on the state of the memdev.
+ *	   See: Documentation/ABI/testing/sysfs-bus-cxl
  *
  * @size_in: Expected input size, or ~0 if variable length.
  * @size_out: Expected output size, or ~0 if variable length.
-- 
2.37.3

