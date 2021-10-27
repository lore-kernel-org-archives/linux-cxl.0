Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE8CC433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 27 Oct 2021 22:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0640600D3
	for <linux-cxl@archiver.kernel.org>; Wed, 27 Oct 2021 22:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhJ0Woc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:44:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:50708 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229987AbhJ0Wob (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 27 Oct 2021 18:44:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="211054948"
X-IronPort-AV: E=Sophos;i="5.87,188,1631602800"; 
   d="scan'208";a="211054948"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 15:40:51 -0700
X-IronPort-AV: E=Sophos;i="5.87,188,1631602800"; 
   d="scan'208";a="447414149"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 15:40:51 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH 1/9] Documentation/auxiliary_bus: Clarify auxiliary_device creation
Date:   Wed, 27 Oct 2021 15:40:35 -0700
Message-Id: <20211027224043.3551125-2-ira.weiny@intel.com>
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

The documentation for creating an auxiliary device is a 3 step not a 2
step process.  Specifically the requirements of setting the name, id,
dev.release, and dev.parent fields was not clear as a precursor to the '2
step' process documented.

Clarify by declaring this a 3 step process starting with setting the
fields of struct auxiliary_device correctly.

Also add some sample code and tie the changed into the rest of the
documentation.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 Documentation/driver-api/auxiliary_bus.rst | 78 +++++++++++++++++-----
 1 file changed, 60 insertions(+), 18 deletions(-)

diff --git a/Documentation/driver-api/auxiliary_bus.rst b/Documentation/driver-api/auxiliary_bus.rst
index ef902daf0d68..29b1322592ef 100644
--- a/Documentation/driver-api/auxiliary_bus.rst
+++ b/Documentation/driver-api/auxiliary_bus.rst
@@ -79,18 +79,6 @@ is given a name that, combined with the registering drivers KBUILD_MODNAME,
 creates a match_name that is used for driver binding, and an id that combined
 with the match_name provide a unique name to register with the bus subsystem.
 
-Registering an auxiliary_device is a two-step process.  First call
-auxiliary_device_init(), which checks several aspects of the auxiliary_device
-struct and performs a device_initialize().  After this step completes, any
-error state must have a call to auxiliary_device_uninit() in its resolution path.
-The second step in registering an auxiliary_device is to perform a call to
-auxiliary_device_add(), which sets the name of the device and add the device to
-the bus.
-
-Unregistering an auxiliary_device is also a two-step process to mirror the
-register process.  First call auxiliary_device_delete(), then call
-auxiliary_device_uninit().
-
 .. code-block:: c
 
 	struct auxiliary_device {
@@ -99,15 +87,69 @@ auxiliary_device_uninit().
 		u32 id;
 	};
 
-If two auxiliary_devices both with a match_name "mod.foo" are registered onto
-the bus, they must have unique id values (e.g. "x" and "y") so that the
-registered devices names are "mod.foo.x" and "mod.foo.y".  If match_name + id
-are not unique, then the device_add fails and generates an error message.
+Registering an auxiliary_device is a three-step process.
+
+First, a 'struct auxiliary_device' needs to be defined or allocated for each
+sub-device desired.  The name, id, dev.release, and dev.parent fields of this
+structure must be filled in as follows.
+
+The 'name' field is to be given a name that is recognized by the auxiliary
+driver.  If two auxiliary_devices with the same match_name, eg
+"mod.MY_DEVICE_NAME", are registered onto the bus, they must have unique id
+values (e.g. "x" and "y") so that the registered devices names are "mod.foo.x"
+and "mod.foo.y".  If match_name + id are not unique, then the device_add fails
+and generates an error message.
 
 The auxiliary_device.dev.type.release or auxiliary_device.dev.release must be
-populated with a non-NULL pointer to successfully register the auxiliary_device.
+populated with a non-NULL pointer to successfully register the
+auxiliary_device.
+
+The auxiliary_device.dev.parent should be set.  Typically to the registering
+drivers device.
+
+Second, call auxiliary_device_init(), which checks several aspects of the
+auxiliary_device struct and performs a device_initialize().  After this step
+completes, any error state must have a call to auxiliary_device_uninit() in its
+resolution path.
+
+The third and final step in registering an auxiliary_device is to perform a
+call to auxiliary_device_add(), which sets the name of the device and adds the
+device to the bus.
+
+.. code-block:: c
+
+	struct axiliary_device *my_aux_dev = my_aux_dev_alloc(xxx);
+
+        /* Step 1: */
+	my_aux_dev->name = MY_DEVICE_NAME;
+	my_aux_dev->id = alloc_unique_id(xxx);
+	my_aux_dev->dev.release = my_aux_dev_release;
+	my_aux_dev->dev.parent = my_dev;
+
+        /* Step 2: */
+        if (auxiliary_device_init(my_aux_dev))
+                goto fail;
+
+        /* Step 3: */
+        if (auxiliary_device_add(my_aux_dev)) {
+                auxiliary_device_uninit(my_aux_dev);
+                goto fail;
+        }
+
+        /* manage the memory */
+        my_dev->my_aux_dev = my_aux_dev;
+
+Unregistering an auxiliary_device is a two-step process to mirror the register
+process.  First call auxiliary_device_delete(), then call
+auxiliary_device_uninit().
+
+
+.. code-block:: c
+
+        auxiliary_device_delete(my_dev->my_aux_dev);
+        auxiliary_device_uninit(my_dev->my_aux_dev);
+        my_aux_dev_free(my_dev->my_aux_dev);
 
-The auxiliary_device.dev.parent must also be populated.
 
 Auxiliary Device Memory Model and Lifespan
 ------------------------------------------
-- 
2.28.0.rc0.12.gb6a658bd00c9

