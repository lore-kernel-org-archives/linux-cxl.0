Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91932C04FE3
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CDB960F38
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhGWU0J (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:26:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:34290 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231823AbhGWU0G (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 23 Jul 2021 16:26:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="211671209"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="211671209"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:38 -0700
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="497436159"
Received: from rfrederi-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.136.168])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:37 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 14/23] cxl: Convert driver id to an enum
Date:   Fri, 23 Jul 2021 14:06:14 -0700
Message-Id: <20210723210623.114073-15-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723210623.114073-1-ben.widawsky@intel.com>
References: <20210723210623.114073-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL drivers can be of only one type. As such, an enum is the most
logical way to represent that singleton nature. By converting to an
enum, it's easy and obvious how to add new driver types.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxl.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 448abc5c7918..ecfa5ae082fa 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -315,12 +315,17 @@ devm_cxl_add_passthrough_decoder(struct device *host)
 
 extern struct bus_type cxl_bus_type;
 
+enum cxl_driver_id {
+	CXL_DEVICE_NVDIMM_BRIDGE,
+	CXL_DEVICE_NVDIMM,
+};
+
 struct cxl_driver {
 	const char *name;
 	int (*probe)(struct device *dev);
 	void (*remove)(struct device *dev);
 	struct device_driver drv;
-	int id;
+	enum cxl_driver_id id;
 };
 
 static inline struct cxl_driver *to_cxl_drv(struct device_driver *drv)
@@ -333,9 +338,6 @@ int __cxl_driver_register(struct cxl_driver *cxl_drv, struct module *owner,
 #define cxl_driver_register(x) __cxl_driver_register(x, THIS_MODULE, KBUILD_MODNAME)
 void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 
-#define CXL_DEVICE_NVDIMM_BRIDGE	1
-#define CXL_DEVICE_NVDIMM		2
-
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
 
-- 
2.32.0

