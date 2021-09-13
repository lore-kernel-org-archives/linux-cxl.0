Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B172C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Sep 2021 16:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF87A60EFF
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Sep 2021 16:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbhIMQfL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 13 Sep 2021 12:35:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:17901 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237242AbhIMQfK (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 13 Sep 2021 12:35:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="221393852"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="221393852"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 09:33:54 -0700
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="469515026"
Received: from dvannith-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.128.229])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 09:33:53 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 0/3] Decoder prep patches
Date:   Mon, 13 Sep 2021 09:33:21 -0700
Message-Id: <20210913163324.1008564-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This small series are the less controversial patches from the cxl_mem driver
series I posted previously [1]. It includes some small doc fixups and the final
nail in the coffin of the earlier cxl_mem rename to cxl_pci [2].

[1]: https://lore.kernel.org/linux-cxl/20210902195017.2516472-1-ben.widawsky@intel.com/
[2]: https://lore.kernel.org/linux-cxl/20210526174413.802913-1-ben.widawsky@intel.com/

Ben Widawsky (3):
  Documentation/cxl: Add bus internal docs
  cxl/core/bus: Document and tighten up decoder API
  cxl/pci: Disambiguate cxl_pci further from cxl_mem

 .../driver-api/cxl/memory-devices.rst         |  3 +
 drivers/cxl/acpi.c                            |  4 +-
 drivers/cxl/core/bus.c                        | 36 ++++++++--
 drivers/cxl/cxl.h                             |  3 +-
 drivers/cxl/pci.c                             | 68 ++++++++++---------
 5 files changed, 71 insertions(+), 43 deletions(-)

-- 
2.33.0

