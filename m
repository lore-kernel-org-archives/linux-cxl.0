Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E300BC76186
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Mar 2023 18:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjCJSte (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Mar 2023 13:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjCJStc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Mar 2023 13:49:32 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA945115B7D
        for <linux-cxl@vger.kernel.org>; Fri, 10 Mar 2023 10:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678474171; x=1710010171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WdJqltXxiVM4rr+PaU/bMie9WKLi+jaUFE8ZgpwNrHw=;
  b=N5i7CXzdBYRxP22I5trMUokF+WekoBmoEUck3q8sady357ms0SsbeitY
   P1h/te02xv5L8NS9mjeYTpzPA172TNov6qS6u59cPpHKe4iITZhQb5LTS
   XoE+6YxlX4K5P6UyzRc5bMpJ7dSUkZk+lWBdSExwyQCEj98mutVdHj/SJ
   1J9UgcKD9HxV0WH23p2HzCc8LpSmtS/sroh5KdwdB9pmfQuoNoRu3GjNE
   c2p9gW32Gs0KUxoWfKj744GVbnCkfoctQHbR4lHYFEH1jsfjcWqgfxeDP
   EvYs1fKKrVHz4S28N7bc9RG9x/IMy/5+77LhmY4Q6aiiWa5/IcxaUzyJN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="336824175"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="336824175"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 10:49:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="627906770"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="627906770"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.255.228.62])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 10:49:30 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v4 7/8] cxl/memdev: Make inject and clear poison cmds kernel exclusive
Date:   Fri, 10 Mar 2023 10:49:08 -0800
Message-Id: <66f6c36d20fa6ab906fe800bcf7059d1f5a552e6.1678471465.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1678471465.git.alison.schofield@intel.com>
References: <cover.1678471465.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Inject and clear poison commands are intended to be used in debug
mode only, and if improperly used, can lead to data corruption. The
kernel provides a sysfs interface that provides the protection needed
to issue these commands [1]

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
index 5dd334c4caf2..6ca2815d5c12 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -10,6 +10,8 @@
 
 static DECLARE_RWSEM(cxl_memdev_rwsem);
 
+static __read_mostly DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
+
 /*
  * An entire PCI topology full of devices should be enough for any
  * config
@@ -574,6 +576,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
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

