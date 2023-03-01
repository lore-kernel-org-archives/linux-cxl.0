Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862F6C678D4
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Mar 2023 23:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCAXHF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 18:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCAXHC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 18:07:02 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F0451FB0
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 15:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677712021; x=1709248021;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0GJO9poZz0k9u3Vc7/gntvvJFk8OTkGehGKxadF+XRE=;
  b=YIlVhY12dEb0zPGPLYa8A43dHGX+HCHSgpTQEm3mYWQCa2HdZmIG4gha
   A3QM+DmO1DLsuuNWnm5qBRCs6+hwGIOD1NW3FIBqgTNoIuN2UZb5isDhj
   OEiBQcbu9PwzHxDlhW1FlfAORUnrzcK7kAvHFJqj7d7XYbg9x4eRaG1FS
   CVVVzv7bDv4C4MqAbpwmRrJQSvqo97MzcltXRzI/M9YE+O9IMJTkFHahZ
   QmxovgkZsAf6bcFZsJCb0VW5xBmOei45bEyBee8jluaRiPvfOboSHfaTK
   XvSahwdkleUAPK2dRs+0Kvvmi4e23SuThPw8SUiQyglpRWqBhZzJg3Amg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="336044047"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="336044047"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:07:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="848843497"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="848843497"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.71.27])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:07:00 -0800
Subject: [PATCH] cxl: fix compile warning for cxl_security_ops extern
From:   Dave Jiang <dave.jiang@intel.com>
To:     jonathan.cameron@huawei.com, dan.j.williams@intel.com
Cc:     linux-cxl@vger.kernel.org
Date:   Wed, 01 Mar 2023 16:06:58 -0700
Message-ID: <167771196186.3285982.18283746206612049722.stgit@djiang5-mobl3.local>
In-Reply-To: <20230228150911.00002535@Huawei.com>
References: <20230228150911.00002535@Huawei.com>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan says he has observed compiler warning when using running with W=1
C=1 for cxl_security_ops that is declared as an extern in cxl/pmem.c. Move
to cxl.h to make it visible to all cxl sources.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

Hi Jonathan, I was not able to reproduce the issue with W=1 C=1. Can you
please see if this fixes what you were seeing? Thanks!

 drivers/cxl/cxl.h  |    2 ++
 drivers/cxl/pmem.c |    2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f2b0962a552d..6f00b938f342 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -10,6 +10,8 @@
 #include <linux/log2.h>
 #include <linux/io.h>
 
+extern const struct nvdimm_security_ops *cxl_security_ops;
+
 /**
  * DOC: cxl objects
  *
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 71cfa1fdf902..55930567fc01 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -11,8 +11,6 @@
 #include "cxlmem.h"
 #include "cxl.h"
 
-extern const struct nvdimm_security_ops *cxl_security_ops;
-
 static __read_mostly DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
 
 static void clear_exclusive(void *cxlds)


