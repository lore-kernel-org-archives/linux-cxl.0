Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BEBC3F6B0
	for <linux-cxl@archiver.kernel.org>; Mon, 15 Aug 2022 21:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiHOV17 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 Aug 2022 17:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347834AbiHOV0U (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 Aug 2022 17:26:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E26E8334
        for <linux-cxl@vger.kernel.org>; Mon, 15 Aug 2022 12:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660591364; x=1692127364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hWdnQGSa5Du+Yzjo1XKDR7Gzv21wnxh5foUJXYJfm4I=;
  b=S4yzr+5ELN2Es/t1TWQlYk1w4yeoBqwuJC/NfQv5JC7Xw0EjU9/NO449
   Ts/CuWiDA5t+8DGJG3dJgq7qPXmufLkOhcOjwLQqkkB7BvtTt3RInYyPX
   y7omoIUmf3mrJev0ke9TAQBL/GivsIZrKILOwWbo0+BCupPAAOz8Ks7OY
   6PC5vp8wzNWe/Ko6ssp868aIfvkfE3qFOKg2N0IPMWIH9gHk1aGPwCqan
   NiV4S2WrsQJH2vNn4sXPnXM0fhjUNdWAeueuxxjIR2cPbrK+U1kPj7BOs
   DHtfT96vwsPMEfwH4YCZq3mYTg0OSA2nwM4yWWXJ13HVpEImL71pANv33
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="293313123"
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="293313123"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 12:22:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="606758243"
Received: from smadiset-mobl1.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.209.5.99])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 12:22:18 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <nvdimm@lists.linux.dev>, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH v3 02/11] cxl/port: Consolidate the debug option in cxl-port man pages
Date:   Mon, 15 Aug 2022 13:22:05 -0600
Message-Id: <20220815192214.545800-3-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815192214.545800-1-vishal.l.verma@intel.com>
References: <20220815192214.545800-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2436; h=from:subject; bh=hWdnQGSa5Du+Yzjo1XKDR7Gzv21wnxh5foUJXYJfm4I=; b=owGbwMvMwCXGf25diOft7jLG02pJDEm/5jy1T4txFP074dWHG/zNkyPcl98UsY4oOVsXqv59wvM1 YcoPOkpZGMS4GGTFFFn+7vnIeExuez5PYIIjzBxWJpAhDFycAjCR2ZMY/ofwVSRcrLCZ0bn+yvWWi/ euXZn6JiLbNubFxdqTvB2VvPMZGZZvenv6nCf35j+nd/Xm1BiWHe0+LlHXtn//9sLJ+qte2vECAA==
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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
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
2.37.1

