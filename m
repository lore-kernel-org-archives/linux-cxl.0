Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6179C001B6
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB8460F22
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhJVSjg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:39:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:5582 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233951AbhJVSje (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 22 Oct 2021 14:39:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216528941"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216528941"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:16 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="445854642"
Received: from aagregor-mobl3.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.134.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:16 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH v2 11/28] cxl/acpi: Rescan bus at probe completion
Date:   Fri, 22 Oct 2021 11:36:52 -0700
Message-Id: <20211022183709.1199701-12-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022183709.1199701-1-ben.widawsky@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ensure that devices being probed before cxl_acpi has completed will get
a second chance.

CXL drivers are brought up through two enumerable, asynchronous
mechanism. The leaf nodes in the CXL topology, endpoints, are enumerated
via PCI headers. The root node's enumeration is platform specific. The
current defacto mechanism for enumerating the root node is through the
presence of an ACPI device, ACPI0017.

The primary job of a cxl_mem driver is to determine if CXL.mem traffic
can be routed to/from the PCIe device that it is being probed. A
prerequisite in this determination is that all CXL components in the
path from root to leaf are capable of routing CXL.mem traffic. If the
cxl_mem driver is probed before cxl_acpi is complete the driver will be
unable to make this determination. To address this, cxl_acpi (or in the
future, another platform specific driver) will rescan all devices to
make sure the ordering is correct.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/acpi.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 625c5d95b83f..1cc3a74c16bd 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -451,6 +451,14 @@ static u32 cedt_instance(struct platform_device *pdev)
 	return U32_MAX;
 }
 
+static void bus_rescan(struct work_struct *work)
+{
+	if (bus_rescan_devices(&cxl_bus_type))
+		pr_err("Failed to rescan CXL bus\n");
+}
+
+static DECLARE_WORK(deferred_bus_rescan, bus_rescan);
+
 static int cxl_acpi_probe(struct platform_device *pdev)
 {
 	int rc;
@@ -484,9 +492,19 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (rc)
 		goto out;
 
-	if (IS_ENABLED(CONFIG_CXL_PMEM))
+	if (IS_ENABLED(CONFIG_CXL_PMEM)) {
 		rc = device_for_each_child(&root_port->dev, root_port,
 					   add_root_nvdimm_bridge);
+		if (rc)
+			goto out;
+	}
+
+	/*
+	 * While ACPI is scanning hostbridge ports, switches and memory devices
+	 * may have been probed. Those devices will need to know whether the
+	 * hostbridge is CXL capable.
+	 */
+	schedule_work(&deferred_bus_rescan);
 
 out:
 	acpi_put_table(acpi_cedt);
-- 
2.33.1

