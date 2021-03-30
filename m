Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0E3C433C1
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 02:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA95619BA
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 02:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhC3Crt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 29 Mar 2021 22:47:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:41689 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231521AbhC3Crj (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 29 Mar 2021 22:47:39 -0400
IronPort-SDR: 8hBEo6b+Zcz+xXuPKc2DI4ISRA+MsPb7UnXosF8vH2wcjyCrvHRFo2uzO6bwcv2A7sLN23QvGx
 UGBppmrCSZNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="191770652"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="191770652"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 19:47:39 -0700
IronPort-SDR: DduD5BZUtkv21jBQQcudDENB+7aWmeiOLi716lG1mCshvRKTFRluoUe8kJJo6qiaYysV52ykz1
 hMyOuRESbHQw==
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="454817611"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 19:47:39 -0700
Subject: [PATCH v2 0/4]  cxl/mem: Fix memdev device setup
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com
Date:   Mon, 29 Mar 2021 19:47:39 -0700
Message-ID: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Changes since v1: [1]
- switch percpu_ref to srcu (Jason)
- introduce cxl_memdev_alloc() (Jason)

[1]: http://lore.kernel.org/r/161661970558.1721612.10441826898835759137.stgit@dwillia2-desk3.amr.corp.intel.com

---

A small collection of fixes mostly inspired by Jason's recognition of
dev_set_name() error handling mistakes on other driver review.

dev_set_name() can fail and although device_add() might catch it that's
not a reliable assumption. While fixing that I noticed that the unwind
handling for cdev_device_add() failures leaked the device name.

The sysfs_emit() fixup and unpublishing of device power management files
are just sanity cleanups.

---

Dan Williams (4):
      cxl/mem: Use sysfs_emit() for attribute show routines
      cxl/mem: Fix synchronization mechanism for device removal vs ioctl operations
      cxl/mem: Do not rely on device_add() side effects for dev_set_name() failures
      cxl/mem: Disable cxl device power management


 drivers/cxl/mem.c |  127 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 75 insertions(+), 52 deletions(-)

base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
