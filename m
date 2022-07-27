Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ED8C00144
	for <linux-cxl@archiver.kernel.org>; Wed, 27 Jul 2022 01:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239948AbiG0By5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 26 Jul 2022 21:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239916AbiG0By4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 26 Jul 2022 21:54:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BC73AB33
        for <linux-cxl@vger.kernel.org>; Tue, 26 Jul 2022 18:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658886895; x=1690422895;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yfz67Rq030FjtbmeRYJ14JQhwa2OzQCXKh/tNGKA/jk=;
  b=EK9MaG5r174JuQWyuy9bMVVmVzruKpWFRZV/ARr827zO0bRvvwySVPkb
   b9Q85Y2wR0YrZiYFeS195p0GPBk7bAZW07M0zjC9hJ+Cb/L0XydyxplJb
   QdhB3GszEU2m6IUuyXzyA4q8kXYc4zTZxEUIpBvt64AT1mbpN/+AzsBNr
   XdhG17UlYpHpof6XoHEORqW3IhVslXmHkdzpYFoIrOH/wo/oluz294MAV
   2CtNhEkJtnna14WtgfRtKXenDl99qCdU2Ulsk5ztDHVe3ab1eHEl4zCIc
   du1ag0AMQaG7j2+jBUBnLT7V222S/lqAovOd3Tewlcr7o42xxzzG8vDBt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="289313190"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="289313190"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 18:54:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="742469886"
Received: from lalitham-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.90.7])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 18:54:54 -0700
Subject: [ndctl PATCH] cxl/list: Clarify "-B" vs "-P -p root"
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     Matthew Ho <sunfishho12@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        linux-cxl@vger.kernel.org
Date:   Tue, 26 Jul 2022 18:54:54 -0700
Message-ID: <165888675979.3375698.5785835464908538946.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Matthew notes that 'cxl list' documentation claims that 'cxl list -B' and
'cxl list -P -p root' are equivalent. Which they are not:


$ cxl list -B
[
  {
    "bus":"root0",
    "provider":"ACPI.CXL"
  }
]

$ cxl list -P -p root
[
  {
    "bus":"root0",
    "provider":"ACPI.CXL",
    "ports:root0":[
      {
        "port":"port1",
        "host":"ACPI0016:00"
      }
    ]
  }
]

Clarify that '--single' needs to be appended to '-P -p root' to make it
equivalent to 'cxl list -B'. This is due to the behavior that listing ports
includes all descendants of a port that matches the filter. In the case of
'-P -p root' that results in all enabled ports.

$ cxl list -P -p root -S
[
  {
    "bus":"root0",
    "provider":"ACPI.CXL"
  }
]

Reported-by: Matthew Ho <sunfishho12@gmail.com>
Cc: Adam Manzanares <a.manzanares@samsung.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Matthew, Adam, from today's discussion, turns out the deeper
documentation is not needed and the host bridge being included is by
design of showing enabled descdendants in a -P listing. Here's the
smaller doc fixup for that.

 Documentation/cxl/cxl-list.txt |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
index f6aba0c5c1fa..088ea700c154 100644
--- a/Documentation/cxl/cxl-list.txt
+++ b/Documentation/cxl/cxl-list.txt
@@ -255,19 +255,27 @@ OPTIONS
 --port=::
 	Specify CXL Port device name(s), device id(s), and or port type
 	names to filter the listing. The supported port type names are "root"
-	and "switch". Note that since a bus object is also a port, the following
-	two syntaxes are equivalent:
+	and "switch". Note that a bus object is also a port, so the
+	following two syntaxes are equivalent:
 ----
 # cxl list -B
-# cxl list -P -p root
+# cxl list -P -p root -S
 ----
-	Additionally, endpoint objects are also ports so the following commands
-	are also equivalent.
+	...where the '-S/--single' is required since descendant ports are always
+	included in a port listing and '-S/--single' stops after listing the
+	bus.  Additionally, endpoint objects are ports so the following commands
+	are equivalent, and no '-S/--single' is required as endpoint ports are
+	terminal:
 ----
 # cxl list -E
 # cxl list -P -p endpoint
 ----
-	By default, only 'switch' ports are listed.
+	By default, only 'switch' ports are listed, i.e.
+----
+# cxl list -P
+# cxl list -P -p switch
+----
+	...are equivalent.
 
 -S::
 --single::

