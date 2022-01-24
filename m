Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB87C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbiAXAv4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:51:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:37216 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240634AbiAXAvz (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:51:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985515; x=1674521515;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DYCU5+G667mp+YOiS7/QvNSu+aBhOgO2WwQwWkPTsMY=;
  b=Ndf9KRhiDk3e1fNzJbyT00hbkshxVkOG90peEY6WrWmObAZNn1TE+3Iy
   wXAN8w6FrQYxF6F4woy+F8dj/cA+LV09niZY9LmF2k9YzDUBt7UKwxIlX
   C7xfyLIFEmr8L4R3gbt3OPJ4EmHybvSo33vagB4ojLFs+0ABDxUOowbxk
   w2jtxnOK5iFA55WFuxSoz7om6e/ZEM9VwO/EZVJbTirBZ0gpFB/G8FyV1
   dLhGnQ6wxKGmu8OJEkjMdIy0RBYuwegNKa2Z3nDWxYHqSkcaxFJANhDAq
   3ypiLrM+znPIzWGeZcqcaJNS0HNbO7fVMqiQkcXzQ536S7EIvwJiXXH1p
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="233293902"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="233293902"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:51:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="623905841"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:51:54 -0800
Subject: [ndctl PATCH 01/37] test: Add 'suite' identifiers to tests
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:51:54 -0800
Message-ID: <164298551461.3021641.4591877842309963514.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for adding CXL tests, and in anticipation of wanting to only
run the CXL tests, label each test with a suite id.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/meson.build |   73 +++++++++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/test/meson.build b/test/meson.build
index 94287aaef85b..07a5bb6e7f62 100644
--- a/test/meson.build
+++ b/test/meson.build
@@ -152,28 +152,28 @@ pfn_meta_errors = find_program('pfn-meta-errors.sh')
 track_uuid = find_program('track-uuid.sh')
 
 tests = [
-  [ 'libndctl',               libndctl ],
-  [ 'dsm-fail',               dsm_fail ],
-  [ 'create.sh',              create ],
-  [ 'clear.sh',               clear ],
-  [ 'pmem-errors.sh',         pmem_errors ],
-  [ 'daxdev-errors.sh',       daxdev_errors_sh ],
-  [ 'multi-dax.sh',           multi_dax ],
-  [ 'btt-check.sh',           btt_check ],
-  [ 'label-compat.sh',        label_compat ],
-  [ 'sector-mode.sh',         sector_mode ],
-  [ 'inject-error.sh',        inject_error ],
-  [ 'btt-errors.sh',          btt_errors ],
-  [ 'hugetlb',                hugetlb ],
-  [ 'btt-pad-compat.sh',      btt_pad_compat ],
-  [ 'firmware-update.sh',     firmware_update ],
-  [ 'ack-shutdown-count-set', ack_shutdown_count ],
-  [ 'rescan-partitions.sh',   rescan_partitions ],
-  [ 'inject-smart.sh',        inject_smart ],
-  [ 'monitor.sh',             monitor ],
-  [ 'max_extent_ns',          max_extent ],
-  [ 'pfn-meta-errors.sh',     pfn_meta_errors ],
-  [ 'track-uuid.sh',          track_uuid ],
+  [ 'libndctl',               libndctl,		  'ndctl' ],
+  [ 'dsm-fail',               dsm_fail,	      	  'ndctl' ],
+  [ 'create.sh',              create,	      	  'ndctl' ],
+  [ 'clear.sh',               clear,	      	  'ndctl' ],
+  [ 'pmem-errors.sh',         pmem_errors,    	  'ndctl' ],
+  [ 'daxdev-errors.sh',       daxdev_errors_sh,	  'dax'	  ],
+  [ 'multi-dax.sh',           multi_dax,	  'dax'   ],
+  [ 'btt-check.sh',           btt_check,	  'ndctl' ],
+  [ 'label-compat.sh',        label_compat,       'ndctl' ],
+  [ 'sector-mode.sh',         sector_mode,        'ndctl' ],
+  [ 'inject-error.sh',        inject_error,	  'ndctl' ],
+  [ 'btt-errors.sh',          btt_errors,	  'ndctl' ],
+  [ 'hugetlb',                hugetlb,		  'ndctl' ],
+  [ 'btt-pad-compat.sh',      btt_pad_compat,	  'ndctl' ],
+  [ 'firmware-update.sh',     firmware_update,	  'ndctl' ],
+  [ 'ack-shutdown-count-set', ack_shutdown_count, 'ndctl' ],
+  [ 'rescan-partitions.sh',   rescan_partitions,  'ndctl' ],
+  [ 'inject-smart.sh',        inject_smart,	  'ndctl' ],
+  [ 'monitor.sh',             monitor,		  'ndctl' ],
+  [ 'max_extent_ns',          max_extent,	  'ndctl' ],
+  [ 'pfn-meta-errors.sh',     pfn_meta_errors,	  'ndctl' ],
+  [ 'track-uuid.sh',          track_uuid,	  'ndctl' ],
 ]
 
 if get_option('destructive').enabled()
@@ -188,26 +188,26 @@ if get_option('destructive').enabled()
   mmap_test = find_program('mmap.sh')
 
   tests += [
-    [ 'pmem-ns',           pmem_ns ],
-    [ 'sub-section.sh',    sub_section ],
-    [ 'dax-dev',           dax_dev ],
-    [ 'dax-ext4.sh',       dax_ext4 ],
-    [ 'dax-xfs.sh',        dax_xfs ],
-    [ 'align.sh',          align ],
-    [ 'device-dax',        device_dax ],
-    [ 'revoke-devmem',     revoke_devmem ],
-    [ 'device-dax-fio.sh', device_dax_fio ],
-    [ 'daxctl-devices.sh', daxctl_devices ],
-    [ 'daxctl-create.sh',  daxctl_create ],
-    [ 'dm.sh',             dm ],
-    [ 'mmap.sh',           mmap_test ],
+    [ 'pmem-ns',           pmem_ns,	   'ndctl' ],
+    [ 'sub-section.sh',    sub_section,	   'dax'   ],
+    [ 'dax-dev',           dax_dev,	   'dax'   ],
+    [ 'dax-ext4.sh',       dax_ext4,	   'dax'   ],
+    [ 'dax-xfs.sh',        dax_xfs,	   'dax'   ],
+    [ 'align.sh',          align,	   'ndctl' ],
+    [ 'device-dax',        device_dax,	   'dax'   ],
+    [ 'revoke-devmem',     revoke_devmem,  'dax'   ],
+    [ 'device-dax-fio.sh', device_dax_fio, 'dax'   ],
+    [ 'daxctl-devices.sh', daxctl_devices, 'dax'   ],
+    [ 'daxctl-create.sh',  daxctl_create,  'dax'   ],
+    [ 'dm.sh',             dm,		   'dax'   ],
+    [ 'mmap.sh',           mmap_test,	   'dax'   ],
   ]
 endif
 
 if get_option('keyutils').enabled()
   security = find_program('security.sh')
   tests += [
-    [ 'security.sh', security ]
+    [ 'security.sh', security, 'ndctl' ]
   ]
 endif
 
@@ -226,6 +226,7 @@ foreach t : tests
       dax_dev,
       mmap,
     ],
+    suite: t[2],
     timeout : 0,
     env : [
       'NDCTL=@0@'.format(ndctl_tool.full_path()),

