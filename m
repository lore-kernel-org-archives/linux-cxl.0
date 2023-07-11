Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAA7EB64DC
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Jul 2023 22:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjGKWn7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Jul 2023 18:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjGKWn7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Jul 2023 18:43:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E1CE5F
        for <linux-cxl@vger.kernel.org>; Tue, 11 Jul 2023 15:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689115438; x=1720651438;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4UyQBQaSrO9M3DzhphVbKRJTuMAc6OpS3rDm2Y5OFd4=;
  b=N5N98SWhwOhqDZhbl5NsnCXf+ayWra8O5utaJpG/XQLXBeN02+qLYjwF
   b7U89dFAHaC7/h4wcMV9gsrV97Q7k+g+S51kqzr5De/ifmhBNS+227y+B
   uezzA1N//TsabHqQ4czSicD29HHlmyT7VWOFaAW9STTxQijPkKFTxuoWo
   eoMop8XqRUraPx1XaTiOLWpgOEK1Vn3sskiIl1udrNe+OmctZdla68BPS
   qQtIAl78pzROlBITWi2yvCptYJu6mpo933SEbser361SStmtEZ294A6kF
   2jAOY69QSQ9EZTcfDNx0S1WHiFcCMN+UkRc0NJZpHbjRKrwpkUK9ibV7p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="362221461"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="362221461"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 15:43:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="1051964717"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="1051964717"
Received: from mdgoodne-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.255.230.21])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 15:43:57 -0700
Subject: [PATCH] cxl: Update MAINTAINERS
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Date:   Tue, 11 Jul 2023 15:43:57 -0700
Message-ID: <168911543699.1871721.9186039943252294173.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ben, thank you for all the work to get the CXL subsystem off the ground
and establishing QEMU as a place where hardware vendors can collaborate
on the new advancements and mechanisms appearing in the CXL
specification.

Jonathan, thank you for your continued review and collaboration, you have
been a defacto CXL maintainer for a while now.

Davidlohr, thank you for getting the background command infrastructure
off the ground and your leadership on and off the lists.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Ben Widawsky <bwidawsk@kernel.org>
Cc: Adam Manzanares <a.manzanares@samsung.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 MAINTAINERS |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..eba395274018 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5140,10 +5140,11 @@ S:	Maintained
 F:	include/linux/compiler_attributes.h
 
 COMPUTE EXPRESS LINK (CXL)
+M:	Davidlohr Bueso <dave@stgolabs.net>
+M:	Jonathan Cameron <jonathan.cameron@huawei.com>
 M:	Alison Schofield <alison.schofield@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Ira Weiny <ira.weiny@intel.com>
-M:	Ben Widawsky <bwidawsk@kernel.org>
 M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained

