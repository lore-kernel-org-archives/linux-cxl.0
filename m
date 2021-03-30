Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351D7C433DB
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 23:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C79619D4
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 23:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhC3Xgh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:36:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:49369 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232661AbhC3Xg2 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 30 Mar 2021 19:36:28 -0400
IronPort-SDR: GsmzRcuoSHbJUYzipTdp6EAnzrcMC2o9x5yMfuR82am5WUyjI+glUHAShXGx/oZObeWIaMs2De
 /JCWv1y0O3oA==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="171286790"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="171286790"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 16:36:27 -0700
IronPort-SDR: 9sURb8rnRSfqIsDe1ZXqOrV8SWzIX862QS0Qtpi/IATdWcOMB9aJemJFNyCjT8D8mfbbWnHuWu
 WgSoRXPpCEYw==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="393800825"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 16:36:26 -0700
Subject: [PATCH v3 0/4]  cxl/mem: Fix memdev device setup
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com
Date:   Tue, 30 Mar 2021 16:36:26 -0700
Message-ID: <161714738634.2168142.10860201861152789544.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Changes since v2: [1]
- switch from non-idiomatic srcu synchronization of the device
  registration state to rwsem protection of the cxlmd->cxlm pointer.
  (Jason)

[1]: http://lore.kernel.org/r/161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com

---

A collection of fixes initially inspired by Jason's recognition of
dev_set_name() error handling mistakes on other driver review, but also
from a deeper discussion of idiomatic device operation shutdown flows.
The end result is easier to reason about and validate. Thank you, Jason.

The sysfs_emit() fixup and unpublishing of device power management files
are independent sanity cleanups.

---

Dan Williams (4):
      cxl/mem: Use sysfs_emit() for attribute show routines
      cxl/mem: Fix synchronization mechanism for device removal vs ioctl operations
      cxl/mem: Do not rely on device_add() side effects for dev_set_name() failures
      cxl/mem: Disable cxl device power management


 drivers/cxl/mem.c |  141 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 83 insertions(+), 58 deletions(-)

base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
