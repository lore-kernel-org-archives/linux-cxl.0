Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DE4C4338F
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Aug 2021 17:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F41561104
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Aug 2021 17:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhHBR3q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Aug 2021 13:29:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:55738 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhHBR3q (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 2 Aug 2021 13:29:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="274563298"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="274563298"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 10:29:33 -0700
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="478938411"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 10:29:33 -0700
Subject: [PATCH v5 0/6] CXL core reorganization
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kernel test robot <lkp@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan.Cameron@huawei.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Date:   Mon, 02 Aug 2021 10:29:33 -0700
Message-ID: <162792537312.368511.15862521152871631343.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Changes since v4 [1]:
- Fix ARCH=um compile errors reported by 0day caused by header
  filename collisions with "mem.h", moved to "cxlmem.h"

- Improve kdoc note for @fops attribute of 'struct
  cdevm_file_operations' (Jonathan)

- Include core.h in memdev.c to fix "no prior declaration" warnings
  (kbuild robot)

- Collect reviewed-by's from Jonathan

[1]: https://lore.kernel.org/r/162774927110.4094313.9743731504096769799.stgit@dwillia2-desk3.amr.corp.intel.com

---

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
 drivers/cxl/core/bus.c                          |  464 +----------------------
 drivers/cxl/core/core.h                         |   20 +
 drivers/cxl/core/memdev.c                       |  246 ++++++++++++
 drivers/cxl/core/pmem.c                         |  204 ++++++++++
 drivers/cxl/core/regs.c                         |  235 ++++++++++++
 drivers/cxl/cxlmem.h                            |   26 +
 drivers/cxl/pci.c                               |  259 +------------
 drivers/cxl/pmem.c                              |    2 
 11 files changed, 795 insertions(+), 681 deletions(-)
 create mode 100644 drivers/cxl/core/Makefile
 rename drivers/cxl/{core.c => core/bus.c} (58%)
 create mode 100644 drivers/cxl/core/core.h
 create mode 100644 drivers/cxl/core/memdev.c
 create mode 100644 drivers/cxl/core/pmem.c
 create mode 100644 drivers/cxl/core/regs.c
 rename drivers/cxl/{mem.h => cxlmem.h} (76%)

base-commit: ff1176468d368232b684f75e82563369208bc371
