Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F591C433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 29 Nov 2021 21:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhK2V76 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 29 Nov 2021 16:59:58 -0500
Received: from mga18.intel.com ([134.134.136.126]:46994 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232388AbhK2V56 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 29 Nov 2021 16:57:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="222968506"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="222968506"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:47:26 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="458596098"
Received: from ajsteine-mobl13.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.141.244])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:47:26 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huwei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 6/9] cxl/pci: Add new DVSEC definitions
Date:   Mon, 29 Nov 2021 13:47:18 -0800
Message-Id: <20211129214721.1668325-7-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129214721.1668325-1-ben.widawsky@intel.com>
References: <20211129214721.1668325-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for properly supporting memory active timeout, and later
on, other attributes obtained from DVSEC fields, add the full list of
DVSEC identifiers from the CXL 2.0 specification.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com> (v1)
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---

Changes since v1:
- Reword commit message (Dan)
---
 drivers/cxl/pci.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index 29b8eaef3a0a..8ae2b4adc59d 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -16,6 +16,21 @@
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
 
+/* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
+#define CXL_DVSEC_FUNCTION_MAP					2
+
+/* CXL 2.0 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
+#define CXL_DVSEC_PORT_EXTENSIONS				3
+
+/* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
+#define CXL_DVSEC_PORT_GPF					4
+
+/* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
+#define CXL_DVSEC_DEVICE_GPF					5
+
+/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
+#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
+
 /* CXL 2.0 8.1.9: Register Locator DVSEC */
 #define CXL_DVSEC_REG_LOCATOR					8
 #define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC
-- 
2.34.1

