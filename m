Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C06CC433F5
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 458F961263
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhJPFRt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 16 Oct 2021 01:17:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:1740 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243683AbhJPFRs (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 16 Oct 2021 01:17:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="225489603"
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="225489603"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:40 -0700
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="442743272"
Received: from asimon-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.133.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:40 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 10/27] cxl/acpi: Rescan bus at probe completion
Date:   Fri, 15 Oct 2021 22:15:14 -0700
Message-Id: <20211016051531.622613-11-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211016051531.622613-1-ben.widawsky@intel.com>
References: <20211016051531.622613-1-ben.widawsky@intel.com>
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

