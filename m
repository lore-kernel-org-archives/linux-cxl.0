Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6536C4338F
	for <linux-cxl@archiver.kernel.org>; Fri, 30 Jul 2021 20:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B5660F42
	for <linux-cxl@archiver.kernel.org>; Fri, 30 Jul 2021 20:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhG3UHC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 30 Jul 2021 16:07:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:15355 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230217AbhG3UHB (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 30 Jul 2021 16:07:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="213149793"
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="213149793"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 13:06:55 -0700
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="439152809"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 13:06:55 -0700
Subject: [PATCH v3 0/6] CXL core reorganization
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, Jonathan.Cameron@huawei.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Fri, 30 Jul 2021 13:06:55 -0700
Message-ID: <162767561501.3322476.716972045397140827.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Changes since v2 [1]:
- Rebase on top of the Makefile changes
- Split register and pmem moving into 2 independent patches
- Drop inclusion of mem.h and cxl.h from core.h. I.e. require all
  compilation units to directly include only the headers they need.
- Squash / rewrite "cxl/mem: Move character device region creation" to
  move the char-dev infrastructure to drivers/cxl/core/memdev.c
- Rewrite the justification in some of the changelogs
- Rewrite "cxl: Pass fops and shutdown to memdev creation" to introduce
  cdevm_file_operations.

[1]: https://lore.kernel.org/linux-cxl/20210720180742.89992-1-ben.widawsky@intel.com/

---

Given Ben is out for a bit I have folded my review comments into the set
directly.

Original Cover from Ben:

The main motivation of the patch series is to establish the cxl_core driver in
its own directory and modularize it. Specifically, the patch series aims to
achieve three things:
1. Move existing core functionality to a new directory.
2. Split existing core functionality into multiple files.
3. Migrate memdev functionality into core.

#1 is trivially accomplished with git mv. The file itself is renamed back to
bus.c since the goal is to break up core functionality into multiple files, and
so the name core.c doesn't make sense in that context.

#2 is also trivially accomplished via cut/paste.

#3 is slightly invasive in that it has certain functional changes to improve the
existing interfaces and make them more generic. The rest of the change is
cut/paste. This is also the only part of the series which has runtime functional
change in that some interfaces are removed from cxl_pci, moved into cxl_core,
and exported for other drivers to use.

---

Ben Widawsky (3):
      cxl: Move cxl_core to new directory
      cxl/core: Improve CXL core kernel docs
      cxl/core: Move memdev management to core

Dan Williams (3):
      cxl/core: Move pmem functionality
      cxl/core: Move register mapping infrastructure
      cxl/pci: Introduce cdevm_file_operations


 Documentation/driver-api/cxl/memory-devices.rst |    8 
 drivers/cxl/Makefile                            |    4 
 drivers/cxl/core/Makefile                       |    8 
 drivers/cxl/core/bus.c                          |  463 +----------------------
 drivers/cxl/core/core.h                         |   20 +
 drivers/cxl/core/memdev.c                       |  245 ++++++++++++
 drivers/cxl/core/pmem.c                         |  204 ++++++++++
 drivers/cxl/core/regs.c                         |  235 ++++++++++++
 drivers/cxl/mem.h                               |   26 +
 drivers/cxl/pci.c                               |  257 +------------
 10 files changed, 791 insertions(+), 679 deletions(-)
 create mode 100644 drivers/cxl/core/Makefile
 rename drivers/cxl/{core.c => core/bus.c} (58%)
 create mode 100644 drivers/cxl/core/core.h
 create mode 100644 drivers/cxl/core/memdev.c
 create mode 100644 drivers/cxl/core/pmem.c
 create mode 100644 drivers/cxl/core/regs.c

base-commit: ff1176468d368232b684f75e82563369208bc371
