Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98157C07E96
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jul 2021 16:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7790561C40
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jul 2021 16:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhGFRCJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jul 2021 13:02:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:53397 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229873AbhGFRCJ (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 6 Jul 2021 13:02:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="230885997"
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="230885997"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 09:59:30 -0700
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="427650704"
Received: from bsyntia-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.129.32])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 09:59:30 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH] cxl: Convert driver id to an enum
Date:   Tue,  6 Jul 2021 09:59:14 -0700
Message-Id: <20210706165914.575990-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
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
index ec90b32d4bd8..dd005a5e296b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -328,12 +328,17 @@ devm_cxl_add_passthrough_decoder(struct device *host, struct cxl_port *port)
 
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
@@ -346,9 +351,6 @@ int __cxl_driver_register(struct cxl_driver *cxl_drv, struct module *owner,
 #define cxl_driver_register(x) __cxl_driver_register(x, THIS_MODULE, KBUILD_MODNAME)
 void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 
-#define CXL_DEVICE_NVDIMM_BRIDGE	1
-#define CXL_DEVICE_NVDIMM		2
-
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
 
-- 
2.32.0

