Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C7DC433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Feb 2022 07:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbiBIHhp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Feb 2022 02:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238854AbiBIHhj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Feb 2022 02:37:39 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B28BC05CBB4
        for <linux-cxl@vger.kernel.org>; Tue,  8 Feb 2022 23:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644392249; x=1675928249;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dJ32AsDXAD/pfIHFRl2Jb1sOCI3TwGLnDmQDMqi1/g0=;
  b=LmU6g3pEjEwUipopH/p/8ZX7Y+tLxzr69KqU94KBTEBhyg/+Ev47U52C
   KOQtu2mbK7rgyWmnEov6ZGkZUIc74ydTmJeOSZDDXZVLkE3quAfYsEI2f
   pHENG5qjaLNrxS3RH6ncOi0s96C/rP1RY861WuIoJmZHsIdfFUrekv0EB
   35wSVVUWdzh2+gcbOLM7gwz5LG27UJt7OUgVw6SgzX3jXbdcWEWZSbKWI
   EW7i4Syggeklu3P4mUANDxbLQWNzTr1vADsX04NLImOYz0MLjDGL/GKgy
   ZYY0t/TsLiwIImJUQu/Wwlcp0dVIbofABOP9e2cM/yN9w3XQTq4ouk5WT
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229117195"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="229117195"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 23:37:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="540983100"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 23:37:29 -0800
Subject: [PATCH] cxl/core/port: Fix unregister_port() lock assertion
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>
Date:   Tue, 08 Feb 2022 23:37:28 -0800
Message-ID: <164439224893.2941117.18331456248117887720.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The device_lock_assert() in unregister_port() fails to pick the right
device leading to splats like the following from:

echo "ACPI0017:00" > /sys/bus/platform/drivers/cxl_acpi/unbind

 WARNING: CPU: 32 PID: 1147 at include/linux/device.h:787 unregister_port+0x49/0x50 [cxl_c
 [..]
 RIP: 0010:unregister_port+0x49/0x50 [cxl_core]
 [..]
 Call Trace:
  <TASK>
  release_nodes+0x63/0x80
  devres_release_all+0x8b/0xc0
  __device_release_driver+0x190/0x240
  device_driver_detach+0x3e/0xa0
  unbind_store+0x113/0x130

Fix it up to assert on the device_lock() for ACPI0017 for root and 1st
level ports, and parent ports for all the rest.

Fixes: 54cdbf845cf7 ("cxl/port: Add a driver for 'struct cxl_port' objects")
Reported-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index c3e83c624700..9b4bbd51fbaa 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -348,12 +348,28 @@ EXPORT_SYMBOL_NS_GPL(to_cxl_port, CXL);
 static void unregister_port(void *_port)
 {
 	struct cxl_port *port = _port;
+	struct cxl_port *parent;
+	struct device *lock_dev;
 
-	if (!is_cxl_root(port)) {
-		device_lock_assert(port->dev.parent);
-		port->uport = NULL;
-	}
+	if (is_cxl_root(port))
+		parent = NULL;
+	else
+		parent = to_cxl_port(port->dev.parent);
+
+	/*
+	 * CXL root port's and the first level of ports are unregistered
+	 * under the platform firmware device lock, all other ports are
+	 * unregistered while holding their parent port lock.
+	 */
+	if (!parent)
+		lock_dev = port->uport;
+	else if (is_cxl_root(parent))
+		lock_dev = parent->uport;
+	else
+		lock_dev = &parent->dev;
 
+	device_lock_assert(lock_dev);
+	port->uport = NULL;
 	device_unregister(&port->dev);
 }
 

