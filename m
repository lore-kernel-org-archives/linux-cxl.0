Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CB9C4361A
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Apr 2021 17:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFABE61285
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Apr 2021 17:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbhDARqE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:46:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:46971 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234761AbhDARjo (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 1 Apr 2021 13:39:44 -0400
IronPort-SDR: 7RTzpmziWccGAnCuDmgMRMGKpfjVRF1vhG2Q9Rb808fCxHHkDNAvC8r6Ab3PgB05Mq7IVJhn5m
 PgZKwB2StV7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="212512494"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="212512494"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:33:30 -0700
IronPort-SDR: 04Ncoca1nJRoDSwGnjJvN7BCpzNHO0S7x0sWmRT0TdpBTzGvhADArG5s6DkpoYVFnx/X0tIu3E
 C/4RRmJIocog==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="439236058"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:33:30 -0700
Subject: [PATCH v4 4/4] cxl/mem: Disable cxl device power management
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com
Date:   Thu, 01 Apr 2021 07:33:30 -0700
Message-ID: <161728761025.2474381.808344500111924819.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161728758895.2474381.12683589190335430004.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161728758895.2474381.12683589190335430004.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

There is no power management of cxl virtual devices, disable
device-power-management and runtime-power-management to prevent
userspace from growing expectations of those attributes appearing. They
can be added back in the future if needed.

Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index e59b373694d3..e3003f49b329 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1203,6 +1203,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm)
 	dev->bus = &cxl_bus_type;
 	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
 	dev->type = &cxl_memdev_type;
+	device_set_pm_not_required(dev);
 
 	cdev = &cxlmd->cdev;
 	cdev_init(cdev, &cxl_memdev_fops);

