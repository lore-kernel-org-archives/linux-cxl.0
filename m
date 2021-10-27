Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78EDC433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 27 Oct 2021 22:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8715460234
	for <linux-cxl@archiver.kernel.org>; Wed, 27 Oct 2021 22:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhJ0Wob (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:44:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:50708 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229705AbhJ0Wob (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 27 Oct 2021 18:44:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="211054951"
X-IronPort-AV: E=Sophos;i="5.87,188,1631602800"; 
   d="scan'208";a="211054951"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 15:40:53 -0700
X-IronPort-AV: E=Sophos;i="5.87,188,1631602800"; 
   d="scan'208";a="447414179"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 15:40:53 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH 2/9] Documentation/auxiliary_bus: Clarify match_name
Date:   Wed, 27 Oct 2021 15:40:36 -0700
Message-Id: <20211027224043.3551125-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20211027224043.3551125-1-ira.weiny@intel.com>
References: <20210617221620.1904031-4-ira.weiny@intel.com>
 <20211027224043.3551125-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Provide example code for how the match name is formed and where it is
supposed to be set.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 Documentation/driver-api/auxiliary_bus.rst | 33 ++++++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/auxiliary_bus.rst b/Documentation/driver-api/auxiliary_bus.rst
index 29b1322592ef..498b9ad4b6ff 100644
--- a/Documentation/driver-api/auxiliary_bus.rst
+++ b/Documentation/driver-api/auxiliary_bus.rst
@@ -78,6 +78,9 @@ An auxiliary_device represents a part of its parent device's functionality. It
 is given a name that, combined with the registering drivers KBUILD_MODNAME,
 creates a match_name that is used for driver binding, and an id that combined
 with the match_name provide a unique name to register with the bus subsystem.
+For example, a driver registering an auxiliary device is named 'foo_mod.ko' and
+the subdevice is named 'foo_dev'.  The match name is therefore
+'foo_mod.foo_dev'.
 
 .. code-block:: c
 
@@ -95,9 +98,9 @@ structure must be filled in as follows.
 
 The 'name' field is to be given a name that is recognized by the auxiliary
 driver.  If two auxiliary_devices with the same match_name, eg
-"mod.MY_DEVICE_NAME", are registered onto the bus, they must have unique id
-values (e.g. "x" and "y") so that the registered devices names are "mod.foo.x"
-and "mod.foo.y".  If match_name + id are not unique, then the device_add fails
+"foo_mod.foo_dev", are registered onto the bus, they must have unique id
+values (e.g. "x" and "y") so that the registered devices names are "foo_mod.foo_dev.x"
+and "foo_mod.foo_dev.y".  If match_name + id are not unique, then the device_add fails
 and generates an error message.
 
 The auxiliary_device.dev.type.release or auxiliary_device.dev.release must be
@@ -118,6 +121,10 @@ device to the bus.
 
 .. code-block:: c
 
+        #define MY_DEVICE_NAME "foo_dev"
+
+        ...
+
 	struct axiliary_device *my_aux_dev = my_aux_dev_alloc(xxx);
 
         /* Step 1: */
@@ -139,6 +146,9 @@ device to the bus.
         /* manage the memory */
         my_dev->my_aux_dev = my_aux_dev;
 
+        ...
+
+
 Unregistering an auxiliary_device is a two-step process to mirror the register
 process.  First call auxiliary_device_delete(), then call
 auxiliary_device_uninit().
@@ -206,6 +216,23 @@ Auxiliary drivers register themselves with the bus by calling
 auxiliary_driver_register(). The id_table contains the match_names of auxiliary
 devices that a driver can bind with.
 
+.. code-block:: c
+
+        static const struct auxiliary_device_id my_auxiliary_id_table[] = {
+		{ .name = "foo_mod.foo_dev" },
+                {},
+        };
+
+        MODULE_DEVICE_TABLE(auxiliary, my_auxiliary_id_table);
+
+        struct auxiliary_driver my_drv = {
+                .name = "myauxiliarydrv",
+                .id_table = my_auxiliary_id_table,
+                .probe = my_drv_probe,
+                .remove = my_drv_remove
+        };
+
+
 Example Usage
 =============
 
-- 
2.28.0.rc0.12.gb6a658bd00c9

