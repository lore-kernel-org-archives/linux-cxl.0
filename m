Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CCEC43216
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Aug 2021 17:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB9A60F42
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Aug 2021 17:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhH3RS2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Aug 2021 13:18:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:52385 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237940AbhH3RS1 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 30 Aug 2021 13:18:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="218360690"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="218360690"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 10:17:33 -0700
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="427905718"
Received: from lopezale-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.130.82])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 10:17:33 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 3/3] cxl/docs: Remove undocumented references
Date:   Mon, 30 Aug 2021 10:17:26 -0700
Message-Id: <20210830171726.2342558-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830171726.2342558-1-ben.widawsky@intel.com>
References: <20210830171726.2342558-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

When the core pmem and regs implementation was added, there were no
structured comments added. This change allows docs to be generated
without warnings.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/driver-api/cxl/memory-devices.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index 356f70d28316..20e177fab487 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -39,12 +39,6 @@ CXL Core
 .. kernel-doc:: drivers/cxl/core/bus.c
    :doc: cxl core
 
-.. kernel-doc:: drivers/cxl/core/pmem.c
-   :internal:
-
-.. kernel-doc:: drivers/cxl/core/regs.c
-   :internal:
-
 .. kernel-doc:: drivers/cxl/core/mbox.c
    :doc: cxl mbox
 
-- 
2.33.0

