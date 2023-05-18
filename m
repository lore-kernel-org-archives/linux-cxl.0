Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F75C77B7A
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 03:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjERDTu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 May 2023 23:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjERDTp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 May 2023 23:19:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB30BD
        for <linux-cxl@vger.kernel.org>; Wed, 17 May 2023 20:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684379984; x=1715915984;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qRl86yvhoBUswh7fNJIMjLg9Ruz01bLKoQEtWJiw3LY=;
  b=SK6vxgb+6yY7li+1hfcc/Go6ucuyiP8WeSGrXt+Hsxd1dSjK2jWgg88Y
   hB+Kg47bxH3ebqg/cCxpVcba7csFQsf3oGrukwxiKdqv8HGDZBoSaEual
   NiC2uxsBB/qr6hyj8J1RcIS96RafoWG1cwzPviY8Nq7T3L20KDbH4eVP4
   y8pWFmJ0mmc8Ruj+DX8yg4pL7yYyXVmOhZ7VoLLBk+QjpvJAJAdaO99II
   ohHmpoGZHup0L8fyR6skn0d+cUUmGYaLVQn26WDlfLawyf5OaE2JhGj8/
   mtIrIQdT4bo0uE8QgvmOInJPK8rhWGqUg1iN8UyKijndsvEST0LKj7LNu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="349458619"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="349458619"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 20:19:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="876274220"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="876274220"
Received: from rprakasx-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.36.202])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 20:19:43 -0700
Subject: [PATCH] cxl/port: Enable the HDM decoder capability for switch ports
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, dave.jiang@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com
Date:   Wed, 17 May 2023 20:19:43 -0700
Message-ID: <168437998331.403037.15719879757678389217.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Derick noticed, when testing hot plug, that hot-add behaves nominally
after a removal. However, if the hot-add is done without a prior
removal, CXL.mem accesses fail. It turns out that the original
implementation of the port driver and region programming wrongly assumed
that platform-firmware always enables the host-bridge HDM decoder
capability. Add support turning on switch-level HDM decoders in the case
where platform-firmware has not.

The implementation is careful to only arrange for the enable to be
undone if the current instance of the driver was the one that did the
enable. This is to interoperate with platform-firmware that may expect
CXL.mem to remain active after the driver is shutdown. This comes at the
cost of potentially not shutting down the enable on kexec flows, but it
is mitigated by the fact that the related HDM decoders still need to be
enabled on an individual basis.

Cc: <stable@vger.kernel.org>
Reported-by: Derick Marks <derick.w.marks@intel.com>
Fixes: 54cdbf845cf7 ("cxl/port: Add a driver for 'struct cxl_port' objects")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pci.c        |   27 +++++++++++++++++++++++----
 drivers/cxl/cxl.h             |    1 +
 drivers/cxl/port.c            |   14 +++++++++-----
 tools/testing/cxl/Kbuild      |    1 +
 tools/testing/cxl/test/mock.c |   15 +++++++++++++++
 5 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index f332fe7af92b..c35c002b65dd 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -241,17 +241,36 @@ static void disable_hdm(void *_cxlhdm)
 	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
 }
 
-static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
+int devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm)
 {
-	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	void __iomem *hdm;
 	u32 global_ctrl;
 
+	/*
+	 * If the hdm capability was not mapped there is nothing to enable and
+	 * the caller is responsible for what happens next.  For example,
+	 * emulate a passthrough decoder.
+	 */
+	if (IS_ERR(cxlhdm))
+		return 0;
+
+	hdm = cxlhdm->regs.hdm_decoder;
 	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	/*
+	 * If the HDM decoder capability was enabled on entry, skip
+	 * registering disable_hdm() since this decode capability may be
+	 * owned by platform firmware.
+	 */
+	if (global_ctrl & CXL_HDM_DECODER_ENABLE)
+		return 0;
+
 	writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
 	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
 
-	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
+	return devm_add_action_or_reset(&port->dev, disable_hdm, cxlhdm);
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_enable_hdm, CXL);
 
 int cxl_dvsec_rr_decode(struct device *dev, int d,
 			struct cxl_endpoint_dvsec_info *info)
@@ -425,7 +444,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	if (info->mem_enabled)
 		return 0;
 
-	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
+	rc = devm_cxl_enable_hdm(port, cxlhdm);
 	if (rc)
 		return rc;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 044a92d9813e..f93a28538962 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -710,6 +710,7 @@ struct cxl_endpoint_dvsec_info {
 struct cxl_hdm;
 struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 				   struct cxl_endpoint_dvsec_info *info);
+int devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm);
 int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 				struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index eb57324c4ad4..17a95f469c26 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -60,13 +60,17 @@ static int discover_region(struct device *dev, void *root)
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
-	int rc;
+	int rc, nr_dports;
 
-	rc = devm_cxl_port_enumerate_dports(port);
-	if (rc < 0)
-		return rc;
+	nr_dports = devm_cxl_port_enumerate_dports(port);
+	if (nr_dports < 0)
+		return nr_dports;
 
 	cxlhdm = devm_cxl_setup_hdm(port, NULL);
+	rc = devm_cxl_enable_hdm(port, cxlhdm);
+	if (rc)
+		return rc;
+
 	if (!IS_ERR(cxlhdm))
 		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
 
@@ -75,7 +79,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 		return PTR_ERR(cxlhdm);
 	}
 
-	if (rc == 1) {
+	if (nr_dports == 1) {
 		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
 		return devm_cxl_add_passthrough_decoder(port);
 	}
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index fba7bec96acd..6f9347ade82c 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -6,6 +6,7 @@ ldflags-y += --wrap=acpi_pci_find_root
 ldflags-y += --wrap=nvdimm_bus_register
 ldflags-y += --wrap=devm_cxl_port_enumerate_dports
 ldflags-y += --wrap=devm_cxl_setup_hdm
+ldflags-y += --wrap=devm_cxl_enable_hdm
 ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
 ldflags-y += --wrap=devm_cxl_enumerate_decoders
 ldflags-y += --wrap=cxl_await_media_ready
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index de3933a776fd..284416527644 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -149,6 +149,21 @@ struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_setup_hdm, CXL);
 
+int __wrap_devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm)
+{
+	int index, rc;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (ops && ops->is_mock_port(port->uport))
+		rc = 0;
+	else
+		rc = devm_cxl_enable_hdm(port, cxlhdm);
+	put_cxl_mock_ops(index);
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_enable_hdm, CXL);
+
 int __wrap_devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 {
 	int rc, index;

