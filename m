Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFBFC4332F
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C4DA60D42
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhJPFRq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 16 Oct 2021 01:17:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:1732 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhJPFRp (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 16 Oct 2021 01:17:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="225489593"
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="225489593"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:38 -0700
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="442743240"
Received: from asimon-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.133.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:38 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 04/27] cxl: Add helper for new drivers
Date:   Fri, 15 Oct 2021 22:15:08 -0700
Message-Id: <20211016051531.622613-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211016051531.622613-1-ben.widawsky@intel.com>
References: <20211016051531.622613-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Many CXL drivers simply want to register and unregister themselves.
module_driver already supported this. A simple wrapper around that
reduces a decent amount of boilerplate in upcoming patches.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxl.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f06c596fad71..4483e1a39fc3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -317,6 +317,9 @@ int __cxl_driver_register(struct cxl_driver *cxl_drv, struct module *owner,
 #define cxl_driver_register(x) __cxl_driver_register(x, THIS_MODULE, KBUILD_MODNAME)
 void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 
+#define module_cxl_driver(__cxl_driver) \
+	module_driver(__cxl_driver, cxl_driver_register, cxl_driver_unregister)
+
 #define CXL_DEVICE_NVDIMM_BRIDGE	1
 #define CXL_DEVICE_NVDIMM		2
 
-- 
2.33.1

