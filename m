Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4369C433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 20:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A750761058
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 20:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhKBUbk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Nov 2021 16:31:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:35267 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231254AbhKBUbj (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 2 Nov 2021 16:31:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10156"; a="292198214"
X-IronPort-AV: E=Sophos;i="5.87,203,1631602800"; 
   d="scan'208";a="292198214"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 13:29:04 -0700
X-IronPort-AV: E=Sophos;i="5.87,203,1631602800"; 
   d="scan'208";a="500743973"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 13:29:03 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [INTERNAL PATCH 0/2] CXL: Clarify struct cxl_mem
Date:   Tue,  2 Nov 2021 13:28:59 -0700
Message-Id: <20211102202901.3675568-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The first patch is a simple clean up.

The cxl_mem object actually represents the state of a CXL device within the
driver.  Furthermore, there was confusion with the cxl_memdev structure.

Clean this up with a new structure name, function names and kernel docs.

---
Changes made based on Ben's comments.

Ira Weiny (2):
  cxl/mbox: Remove bad comment
  cxl/cxlmem: Change cxl_mem to a more descriptive name

 drivers/cxl/core/mbox.c      | 184 +++++++++++++++++------------------
 drivers/cxl/core/memdev.c    |  48 ++++-----
 drivers/cxl/cxlmem.h         |  35 ++++---
 drivers/cxl/pci.c            | 146 +++++++++++++--------------
 drivers/cxl/pmem.c           |  39 ++++----
 tools/testing/cxl/test/mem.c |  50 +++++-----
 6 files changed, 252 insertions(+), 250 deletions(-)

-- 
2.28.0.rc0.12.gb6a658bd00c9

