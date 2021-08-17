Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAB3C4338F
	for <linux-cxl@archiver.kernel.org>; Tue, 17 Aug 2021 03:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC08A60FC3
	for <linux-cxl@archiver.kernel.org>; Tue, 17 Aug 2021 03:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbhHQDjb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 16 Aug 2021 23:39:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:48991 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233686AbhHQDja (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 16 Aug 2021 23:39:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="214138622"
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; 
   d="scan'208";a="214138622"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 20:38:57 -0700
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; 
   d="scan'208";a="520276066"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 20:38:57 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2] cxl/acpi: Do not add DSDT disabled ACPI0016 host bridge ports
Date:   Mon, 16 Aug 2021 20:49:07 -0700
Message-Id: <20210817034908.149795-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

During CXL ACPI probe, host bridge ports are discovered by scanning
the ACPI0017 root port for ACPI0016 host bridge devices. The scan
matches on the hardware id of "ACPI0016". An issue occurs when an
ACPI0016 device is defined in the DSDT yet disabled on the platform.
Attempts by the cxl_acpi driver to add host bridge ports using a
disabled device fails, and the entire cxl_acpi probe fails.

The DSDT table includes an _STA method that sets the status and the
ACPI subsystem has checks available to examine it. One such check is
in the acpi_pci_find_root() path. Move the call to acpi_pci_find_root()
to the matching function to prevent this issue when adding either
upstream or downstream ports.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
Changes v2:
- make subject line appear in mail header

 drivers/cxl/acpi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index ab0ede9a526c..69c4bf18b449 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -249,6 +249,9 @@ __weak struct acpi_device *to_cxl_host_bridge(struct device *host,
 {
 	struct acpi_device *adev = to_acpi_device(dev);
 
+	if (!acpi_pci_find_root(adev->handle))
+		return NULL;
+
 	if (strcmp(acpi_device_hid(adev), "ACPI0016") == 0) {
 		dev_dbg(host, "found host bridge %s\n", dev_name(&adev->dev));
 		return adev;
@@ -274,10 +277,6 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	if (!bridge)
 		return 0;
 
-	pci_root = acpi_pci_find_root(bridge->handle);
-	if (!pci_root)
-		return -ENXIO;
-
 	dport = find_dport_by_dev(root_port, match);
 	if (!dport) {
 		dev_dbg(host, "host bridge expected and not found\n");
@@ -290,6 +289,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 		return PTR_ERR(port);
 	dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
 
+	pci_root = acpi_pci_find_root(bridge->handle);
 	ctx = (struct cxl_walk_context){
 		.dev = host,
 		.root = pci_root->bus,

base-commit: fa809cc6feedcd2575b63def7135dfaf066266bb
-- 
2.26.2

