Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900C7C433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  5 Jan 2022 21:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244489AbiAEVcR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 5 Jan 2022 16:32:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:32461 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244495AbiAEVbr (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 5 Jan 2022 16:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641418307; x=1672954307;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1jf6mjMkVfAxzHE5koXGaHq5xLDtB1enGeGWwlLvxlI=;
  b=Ux+6tiSgFyLrdhmu5Jam255tzKaiILGgBpqyEWRWEejuVli7mYTgXEZP
   e3E8Tw0IH5TbYycRBNT92edDYUWKvVPRFgrA4HbQU/tm1ooSAQMPQ1oCu
   MzoqKAHK/BV8APwPWYFrPwEPk79X6cv3ItcTL+da30b5qvNHuoIyJnmyl
   dtpYZRJ6jdsAVK/XZ1PXoG1AM1G1rabdAjXLV8KAKvkfx81BSjjnAo9QR
   K0t6xv/HyjIblg78eJfJog7EUGIHaGmJa37Y6KFtYTiSs3NN33K7uCZXh
   5hulzSD3fxjzEUFxVr8LWXJHIriDvSs135ey3GfhIjPld/Ssjd+HslUU8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="240083925"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="240083925"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 13:31:45 -0800
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="488727214"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 13:31:44 -0800
Subject: [ndctl PATCH v3 01/16] ndctl/docs: Clarify update-firwmware
 activation 'overflow' conditions
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Date:   Wed, 05 Jan 2022 13:31:44 -0800
Message-ID: <164141830490.3990253.6263569501446070716.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164141829899.3990253.17547886681174580434.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164141829899.3990253.17547886681174580434.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Give examples and remediation for "overflow" events, i.e. where the
estimated time to complete activation exceeds the platform advertised
maximum. When that happens forced activation can lead to undefined results.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ndctl/ndctl-update-firmware.txt |   64 +++++++++++++++++++++++++
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/Documentation/ndctl/ndctl-update-firmware.txt b/Documentation/ndctl/ndctl-update-firmware.txt
index 1080d62a20b9..61664575f5b1 100644
--- a/Documentation/ndctl/ndctl-update-firmware.txt
+++ b/Documentation/ndctl/ndctl-update-firmware.txt
@@ -58,7 +58,69 @@ include::xable-bus-options.txt[]
 	Arm a device for firmware activation. This is enabled by default
 	when a firmware image is specified. Specify --no-arm to disable
 	this default. Otherwise, without a firmware image, this option can be
-	used to manually arm a device for firmware activate.
+	used to manually arm a device for firmware activate. When a
+	device transitions from unarmed to armed the platform recalculates the
+	firmware activation time and compares it against the maximum platform
+	supported time. If the activation time would exceed the platform maximum the
+	arm attempt is aborted:
+
+[verse]
+ndctl update-firmware --arm --bus=nfit_test.0 all
+  Error: update firmware: nmem4: arm aborted, tripped overflow
+[
+  {
+    "dev":"nmem1",
+    "id":"cdab-0a-07e0-ffffffff",
+    "handle":"0",
+    "phys_id":"0",
+    "security":"disabled",
+    "firmware":{
+      "current_version":"0",
+      "can_update":true
+    }
+  },
+  {
+    "dev":"nmem3",
+    "id":"cdab-0a-07e0-fffeffff",
+    "handle":"0x100",
+    "phys_id":"0x2",
+    "security":"disabled",
+    "firmware":{
+      "current_version":"0",
+      "can_update":true
+    }
+  },
+  {
+    "dev":"nmem2",
+    "id":"cdab-0a-07e0-feffffff",
+    "handle":"0x1",
+    "phys_id":"0x1",
+    "security":"disabled",
+    "firmware":{
+      "current_version":"0",
+      "can_update":true
+    }
+  }
+]
+updated 3 nmems.
+
+	It is possible, but not recommended, to ignore timeout overflows
+	with the --force option. At any point to view the 'armed' state of the
+	bus do:
+
+[verse]
+ndctl list -BF -b nfit_test.0
+[
+  {
+    "provider":"nfit_test.0",
+    "dev":"ndbus2",
+    "scrub_state":"idle",
+    "firmware":{
+      "activate_method":"suspend",
+      "activate_state":"overflow"
+    }
+  }
+]
 
 -D::
 --disarm::

