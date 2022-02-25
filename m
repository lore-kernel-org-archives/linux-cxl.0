Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6C6C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Feb 2022 20:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbiBYU2L (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Feb 2022 15:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236779AbiBYU2I (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Feb 2022 15:28:08 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CEF71C8A
        for <linux-cxl@vger.kernel.org>; Fri, 25 Feb 2022 12:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645820855; x=1677356855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7fonY0Gp8YIdQSKGFtkuDPnP3QHOTzZLEgizHVlgg/Y=;
  b=BClu60OFHF6LjXLHlv1V44xKksTvegqcQnq7ZAPpI0bXlp92cdIWq+bX
   kTY+lv5c3fSNqUsW1T31L0vVPBBftwaWwv5G+7iJzTUdcDsLBwbMQ/Vp+
   BdOad74KkDVIqwScKMQgwdRIZeAC+Yky+jtsxtHyCndWguyKZOjyBJZFB
   vSmva98hswEMhv+TfwyE8FLtfTNIGUQkLkz7axi6v7HZnKQU3st8J+8IY
   derHAUVOww6LHK67UK3tuglE/2k6toM26IqMNQ78kmMd124ag0oPEkIrc
   VBV1jipbjqJpnU+99d8vq8jVUkRlDNg8Ym4qHH5Uvapf83H4pNH7rQfH/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="232546070"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="232546070"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 12:27:32 -0800
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="607868811"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 12:27:32 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2 4/4] cxl/pmem: Remove CXL SET_PARTITION_INFO from exclusive_cmds list
Date:   Fri, 25 Feb 2022 12:31:01 -0800
Message-Id: <b5161bb8ad908510e2af36a837e43e3662a357b5.1645817416.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1645817416.git.alison.schofield@intel.com>
References: <cover.1645817416.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

With SET_PARTITION_INFO on the exclusive_cmds list for the CXL_PMEM
driver, userspace cannot execute a set-partition command without
first unbinding the pmem driver from the device.

When userspace requests a partition change to take effect on the
next reboot this unbind requirement is unnecessarily restrictive.
The driver does not need to enforce quiescing of the device before
setting up the 'next' partitions. Of course, userspace still needs
to be aware that changing the size of persistent capacity on the
next reboot will result in the loss of data stored. That can
happen regardless of whether it is presently bound/unbound at the
time of issuing the set-partition command.

When userspace requests a partition change to take effect immediately,
restrictions are needed. The CXL_MEM driver currently blocks the usage
of immediate mode, making the presence of SET_PARTITION_INFO on this
exclusive commands list redundant.

In the future, when the CXL_MEM driver adds support for immediate
changes to device partitions it will ensure that the partition change
will not affect any active decode. That means the work will not fall
right back here, onto the CXL_PMEM driver.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/pmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index fabdb0c6dbf2..73a2868b5f95 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -344,7 +344,6 @@ static __init int cxl_pmem_init(void)
 {
 	int rc;
 
-	set_bit(CXL_MEM_COMMAND_ID_SET_PARTITION_INFO, exclusive_cmds);
 	set_bit(CXL_MEM_COMMAND_ID_SET_SHUTDOWN_STATE, exclusive_cmds);
 	set_bit(CXL_MEM_COMMAND_ID_SET_LSA, exclusive_cmds);
 
-- 
2.31.1

