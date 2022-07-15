Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FA7CCA480
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Jul 2022 06:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiGOG0L (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 15 Jul 2022 02:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiGOG0K (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 15 Jul 2022 02:26:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61AF3DBF8
        for <linux-cxl@vger.kernel.org>; Thu, 14 Jul 2022 23:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657866369; x=1689402369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NQ4NuWAlV2dadlW4eVcTlcLJAcETtWo3wyISjTFm6B8=;
  b=B2A6IUTO/wt3/DoMXJFUHNJRMRz4tPEpNwSZ8lL+SxGpqI9umW6ZhX7s
   UEJLKqd2pchOtORrM9+o5K3K3iqN4lMo+jXfw+pBWR1R+0eqdVpyQyML1
   esb7TVBLjfjr70+T/a/V8bANZAdSI5exPcLEII4pcAq9+b3RI8mGBCdO7
   pD/nwjP1Qhpeesseq5gQonDmtWfVbn3AJ3l4MI0VZlzQRhiuKIGPEfPV+
   7U3aCbH9bnxYgZMWLQC0AUZ/enLpxQRAqJEKA4s4RUMRG7xGzGFBXJPI7
   fhCYHRYQNKwr8RpWkqgHCzXO0kzTuZsek1yX6FO9f+HcP2BerQqVtBK7H
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286852211"
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="286852211"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 23:26:09 -0700
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="546544608"
Received: from saseiper-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.212.71.32])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 23:26:08 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <nvdimm@lists.linux.dev>, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH 2/8] cxl/port: Consolidate the debug option in cxl-port man pages
Date:   Fri, 15 Jul 2022 00:25:44 -0600
Message-Id: <20220715062550.789736-3-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220715062550.789736-1-vishal.l.verma@intel.com>
References: <20220715062550.789736-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2382; h=from:subject; bh=NQ4NuWAlV2dadlW4eVcTlcLJAcETtWo3wyISjTFm6B8=; b=owGbwMvMwCXGf25diOft7jLG02pJDEkXOXIN7t98y7rdxlU6YvHnKQ2TjHiZ49efsf6YyiDn8YPv xZF7HaUsDGJcDLJiiix/93xkPCa3PZ8nMMERZg4rE8gQBi5OAZjIIXuGP3zXQpdzbVEpnhPUv1rAXz I59ISE7V6u2E3HPKo2CKjPWM3IsP2efIbOb+mYkJmJnJLTul6dn/Dx/Hu7/cfLj8SatHCmswIA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for additional commands that implement the --debug
option, consolidate the option description from the cxl-port man pages
into an include.

The port man pages also mentioned the debug option requiring a build
with debug enabled, which wasn't true - so remove that part.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 Documentation/cxl/cxl-disable-port.txt | 5 +----
 Documentation/cxl/cxl-enable-port.txt  | 5 +----
 Documentation/cxl/debug-option.txt     | 4 ++++
 Documentation/cxl/meson.build          | 1 +
 4 files changed, 7 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/cxl/debug-option.txt

diff --git a/Documentation/cxl/cxl-disable-port.txt b/Documentation/cxl/cxl-disable-port.txt
index ac56f20..7a22efc 100644
--- a/Documentation/cxl/cxl-disable-port.txt
+++ b/Documentation/cxl/cxl-disable-port.txt
@@ -30,10 +30,7 @@ OPTIONS
 	firmware and disabling an active device is akin to force removing memory
 	from a running system.
 
---debug::
-	If the cxl tool was built with debug disabled, turn on debug
-	messages.
-
+include::debug-option.txt[]
 
 include::../copyright.txt[]
 
diff --git a/Documentation/cxl/cxl-enable-port.txt b/Documentation/cxl/cxl-enable-port.txt
index 9a37cef..50b53d1 100644
--- a/Documentation/cxl/cxl-enable-port.txt
+++ b/Documentation/cxl/cxl-enable-port.txt
@@ -31,10 +31,7 @@ OPTIONS
 	memdev is only enabled after all CXL ports in its device topology
 	ancestry are enabled.
 
---debug::
-	If the cxl tool was built with debug enabled, turn on debug
-	messages.
-
+include::debug-option.txt[]
 
 include::../copyright.txt[]
 
diff --git a/Documentation/cxl/debug-option.txt b/Documentation/cxl/debug-option.txt
new file mode 100644
index 0000000..70b922f
--- /dev/null
+++ b/Documentation/cxl/debug-option.txt
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+
+--debug::
+	Turn on additional debug messages including library debug.
diff --git a/Documentation/cxl/meson.build b/Documentation/cxl/meson.build
index d019dfc..423be90 100644
--- a/Documentation/cxl/meson.build
+++ b/Documentation/cxl/meson.build
@@ -22,6 +22,7 @@ filedeps = [
   '../copyright.txt',
   'memdev-option.txt',
   'labels-options.txt',
+  'debug-option.txt',
 ]
 
 cxl_manpages = [
-- 
2.36.1

