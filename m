Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B79C77B6D
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Mar 2023 05:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjC0FD2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Mar 2023 01:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjC0FDZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Mar 2023 01:03:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D6CAA
        for <linux-cxl@vger.kernel.org>; Sun, 26 Mar 2023 22:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679893404; x=1711429404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pBV9VOAMkbepzR+gVgGgvxx6gd/wvP6z2s4+Acq00EQ=;
  b=jlCk7T+34256ysuAT3wVxvSyUj/Dh+GbYtuLi1RiRXaC/PNzC4v2/Fmj
   Iiy1BwO0RW29c6q/gZX2mO0ruglOviQl80c6oNDd2EqDFsf1OLw1MxlUI
   IE8thxbY+dR314WdivpjasFEIlSZMXhbcDYrNNCB1UJjc/RCND6E6n3xV
   QPjcut1HAGCbitsaqk7gIiDMO54qXEn1hU4Tt2BvX6www+2hOt/P45qKx
   j7HaiDPIi1EqOvEFNX3yDr8pEKcUraa31y5Fi5AMUi6aAm89lYbNyqH5P
   ZNR/zEQWkY4kbbqr7cMb1+TbhnG1OHk0GZ7qcvA4t1TwAAU6zcOsYrYTp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="367920194"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="367920194"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="633492269"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="633492269"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.227.2])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:23 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 06/12] cxl/memdev: Make inject and clear poison cmds kernel exclusive
Date:   Sun, 26 Mar 2023 22:03:12 -0700
Message-Id: <d88366e1b749c0100f2480f0036117667b62bc95.1679892337.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1679892337.git.alison.schofield@intel.com>
References: <cover.1679892337.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Inject and clear poison commands are intended to be used in debug
mode only, and if improperly used, can lead to data corruption. The
kernel provides a debugfs interface to issue these commands [1]

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

[1] Documentation/ABI/testing/debugfs-cxl
[2] include/uapi/linux/cxl_mem.h

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/memdev.c    |  6 ++++++
 include/uapi/linux/cxl_mem.h | 20 +++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 71ebe3795616..617d8378ca9a 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -11,6 +11,8 @@
 
 static DECLARE_RWSEM(cxl_memdev_rwsem);
 
+static __read_mostly DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
+
 /*
  * An entire PCI topology full of devices should be enough for any
  * config
@@ -628,6 +630,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
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
index 86bbacf2a315..6294278f9dcb 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -74,17 +74,27 @@ static const struct {
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
+ *         The given command id is for kernel exclusive use and is not
+ *         available to userspace. Requests will terminate with EBUSY.
+ *
+ *         The exclusive flag may be temporal, and only set while the
+ *         kernel actively owns management of the given resource. For
+ *         example, the label-storage-area can not be written while the
+ *         kernel is actively managing that space.
+ *
+ *         The exclusive flag can be permanent, as in commands that can
+ *         never be issued through the ioctl interface.
+ *
+ *         INJECT_POISON and CLEAR_POISON are permanently kernel exclusive,
+ *         and are supported through a debugfs interface.
+ *         See: Documentation/ABI/testing/debugfs-cxl
  *
  * @size_in: Expected input size, or ~0 if variable length.
  * @size_out: Expected output size, or ~0 if variable length.
-- 
2.37.3

