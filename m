Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA41C636CB
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jul 2021 19:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8DEC61380
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jul 2021 19:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbhGOT6n (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:58:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:23881 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240673AbhGOTtJ (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 15 Jul 2021 15:49:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="197803787"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="197803787"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 12:41:32 -0700
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="489564771"
Received: from cherrera-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.135.149])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 12:41:31 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 0/6] CXL core reorganization
Date:   Thu, 15 Jul 2021 12:41:19 -0700
Message-Id: <20210715194125.898305-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

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

Ben Widawsky (6):
  cxl: Move cxl_core to new directory
  cxl/core: Improve CXL core kernel docs
  cxl/core: Extract register and pmem functionality
  cxl/mem: Move character device region creation
  cxl: Pass fops and shutdown to memdev creation
  cxl/core: Move memdev management to core

 .../driver-api/cxl/memory-devices.rst         |   8 +-
 drivers/cxl/Makefile                          |   2 +-
 drivers/cxl/{core.c => core/bus.c}            | 458 +-----------------
 drivers/cxl/core/core.h                       |  20 +
 drivers/cxl/core/memdev.c                     | 224 +++++++++
 drivers/cxl/core/pmem.c                       | 201 ++++++++
 drivers/cxl/core/regs.c                       | 235 +++++++++
 drivers/cxl/mem.h                             |   9 +
 drivers/cxl/pci.c                             | 239 +--------
 9 files changed, 731 insertions(+), 665 deletions(-)
 rename drivers/cxl/{core.c => core/bus.c} (58%)
 create mode 100644 drivers/cxl/core/core.h
 create mode 100644 drivers/cxl/core/memdev.c
 create mode 100644 drivers/cxl/core/pmem.c
 create mode 100644 drivers/cxl/core/regs.c

-- 
2.32.0

