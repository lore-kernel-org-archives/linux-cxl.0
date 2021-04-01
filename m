Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889D4C43603
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Apr 2021 17:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 666D56112E
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Apr 2021 17:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbhDAR6i (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:58:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:59663 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235232AbhDARzx (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 1 Apr 2021 13:55:53 -0400
IronPort-SDR: yOaaoXReRAjs1GJCIZ7v0aQLhAJPliTkHblGWrkL42eivIbjhcc5VZXHRqxSKoRzF0PV5XPMED
 TQiL+TXrpH4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="192359359"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="192359359"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:33:09 -0700
IronPort-SDR: nYAME5euVFgWBohmaIqvNezC9mKg/smE496aAGPx+sbu+lfxXveyfBZfIcyJnKRRlOy1EGDGD6
 ytxU5FlgYepQ==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="377721508"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:33:09 -0700
Subject: [PATCH v4 0/4] cxl/mem: Fix memdev device setup
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com
Date:   Thu, 01 Apr 2021 07:33:09 -0700
Message-ID: <161728758895.2474381.12683589190335430004.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Changes since v3 [1]:

- Drop cxl_memdev_activate(). An open-coded pointer assignment is
  sufficient relative to cdev_device_add() publishing the device (Jason)

[1]: http://lore.kernel.org/r/161714738634.2168142.10860201861152789544.stgit@dwillia2-desk3.amr.corp.intel.com

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
 1 file changed, 82 insertions(+), 59 deletions(-)

base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
