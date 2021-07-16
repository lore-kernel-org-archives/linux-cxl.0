Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B139C636CB
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jul 2021 23:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66DB613D4
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jul 2021 23:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhGPXS6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jul 2021 19:18:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:65193 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237326AbhGPXS5 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 16 Jul 2021 19:18:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="190479024"
X-IronPort-AV: E=Sophos;i="5.84,246,1620716400"; 
   d="scan'208";a="190479024"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 16:16:00 -0700
X-IronPort-AV: E=Sophos;i="5.84,246,1620716400"; 
   d="scan'208";a="431362188"
Received: from jhiga-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.135.195])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 16:15:59 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 0/3] Rework register enumeration for later reuse
Date:   Fri, 16 Jul 2021 16:15:45 -0700
Message-Id: <20210716231548.174778-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In order to plug a cxl_memdev into cxl_core for the purpose of enumerating HDM
decoders, the physical address of the component registers must be known and
retained at the time of cxl_memdev creation. The cxl_mem driver already
enumerates and maps these registers. The main goal of the series is to be able
to reuse that logic for the upcoming cxl_memdev driver.

This patch series is based upon the core-reorg patches I submitted yesterday,
but it could be merged independently. With core-reorg [1] series, and the
expand-decoders [2] patch, everything is in place to implement the region and
memdev drivers.

A few other options were discussed/pursued:
1. Passing around the mapped addresses instead of physical. This caused more
   churn in the existing code. It also causes a somewhat undesirable combination
   of having one entity "own" the mapping and another one using it.
2. Don't map component registers in cxl_pci, and instead map it when needed in
   the port driver. I actually believe this would have been the right thing to
   do except certain register sets (like IDE) may be needed by the cxl_pci
   driver anyway.
3. Export functionality to obtain component register mapping in cxl_core and let
   the cxl_pci driver and memdev driver use that. This solution might be the
   eventual solution, but it's not yet necessary.
3b. Copy the enumeration code from pci.c into the new memdev driver.
4. Obtaining the register mapping from cxl_mem at driver probe since the
   cxl_memdev and cxl_mem are connected. Like #1, this mixes "ownership" of the
   mapping.

[1]: https://lore.kernel.org/linux-cxl/20210715194125.898305-1-ben.widawsky@intel.com/
[2]: https://lore.kernel.org/linux-cxl/20210706160050.527553-1-ben.widawsky@intel.com/

Ben Widawsky (3):
  cxl/pci: Ignore unknown register block types
  cxl/pci: Simplify register setup
  cxl/pci: Retain map information in cxl_mem_probe

 drivers/cxl/cxl.h |  1 -
 drivers/cxl/pci.c | 50 ++++++++++++++++++++---------------------------
 drivers/cxl/pci.h |  1 +
 3 files changed, 22 insertions(+), 30 deletions(-)


-- 
2.32.0

