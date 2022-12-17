Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BDFC4332F
	for <linux-cxl@archiver.kernel.org>; Sat, 17 Dec 2022 01:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiLQBdq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Dec 2022 20:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiLQBdp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Dec 2022 20:33:45 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFDF73319
        for <linux-cxl@vger.kernel.org>; Fri, 16 Dec 2022 17:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671240824; x=1702776824;
  h=subject:from:to:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=yGN+M08U0rZUPTvJG3Yx5fNkmQnaUxvo5iUIr1ABqok=;
  b=O9igpik3RnJTK0DICxO7koF5vpzwszsk/biF2Uad1Fc99lGPc33Efiev
   snJSnOfkY0uRcRxUT6Ui00MbNt5X+19+y8N38YLk+DbXlPANlw6LwvwXM
   hsGZGF09W3YW017gcwuvpgiUA2qeU8pGIdABrPLvMd9D5GTSlZvKbuwVA
   WJY9MMb6YJv+FC+XVtK7sxe5fthDH9KLy7DwKDRsj91JpNbaSY00GTGGW
   Fl2V5GqbvwSKaXRwg9RyCbE+wDVXusN6DwFKBONYB3qPwUrhvf/Zqdexo
   QPr6Z71O6BQi7AlSWH/DEYpMkCnpiWwAq8Arjmct5gOX8MYYy8b2C/Lya
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="302513805"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="302513805"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 17:33:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="649993083"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="649993083"
Received: from smukhe4-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.110.159])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 17:33:44 -0800
Subject: [PATCH 3/3] cxl/port: Link the 'parent_dport' in portX/ and
 endpointX/ sysfs
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Date:   Fri, 16 Dec 2022 17:33:43 -0800
Message-ID: <167124082375.1626103.6047000000121298560.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167124080717.1626103.10654476222026614847.stgit@dwillia2-xfh.jf.intel.com>
References: <167124080717.1626103.10654476222026614847.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Similar to the justification in:

1b58b4cac6fc ("cxl/port: Record parent dport when adding ports")

...userspace wants to know the routing information for ports for
calculating the memdev order for region creation among other things.
Cache the information the kernel discovers at enumeration time in a
'parent_dport' attribute to save userspace the time of trawling sysfs
to recover the same information.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   15 +++++++++++++++
 drivers/cxl/core/port.c                 |   27 +++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 8494ef27e8d2..1b17c8cb48b5 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -90,6 +90,21 @@ Description:
 		capability.
 
 
+What:		/sys/bus/cxl/devices/{port,endpoint}X/parent_dport
+Date:		October, 2022
+KernelVersion:	v6.2
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) CXL port objects are instantiated for each upstream port in
+		a CXL/PCIe switch, and for each endpoint to map the
+		corresponding memory device into the CXL port hierarchy. When a
+		descendant CXL port (switch or endpoint) is enumerated it is
+		useful to know which 'dport' object in the parent CXL port
+		routes to this descendant. The 'parent_dport' symlink points to
+		the device representing the downstream port of a CXL switch that
+		routes to {port,endpoint}X.
+
+
 What:		/sys/bus/cxl/devices/portX/dportY
 Date:		June, 2021
 KernelVersion:	v5.14
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6296d2bc909a..729e4aab5308 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -586,6 +586,29 @@ static int devm_cxl_link_uport(struct device *host, struct cxl_port *port)
 	return devm_add_action_or_reset(host, cxl_unlink_uport, port);
 }
 
+static void cxl_unlink_parent_dport(void *_port)
+{
+	struct cxl_port *port = _port;
+
+	sysfs_remove_link(&port->dev.kobj, "parent_dport");
+}
+
+static int devm_cxl_link_parent_dport(struct device *host,
+				      struct cxl_port *port,
+				      struct cxl_dport *parent_dport)
+{
+	int rc;
+
+	if (!parent_dport)
+		return 0;
+
+	rc = sysfs_create_link(&port->dev.kobj, &parent_dport->dport->kobj,
+			       "parent_dport");
+	if (rc)
+		return rc;
+	return devm_add_action_or_reset(host, cxl_unlink_parent_dport, port);
+}
+
 static struct lock_class_key cxl_port_key;
 
 static struct cxl_port *cxl_port_alloc(struct device *uport,
@@ -695,6 +718,10 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 	if (rc)
 		return ERR_PTR(rc);
 
+	rc = devm_cxl_link_parent_dport(host, port, parent_dport);
+	if (rc)
+		return ERR_PTR(rc);
+
 	return port;
 
 err:

