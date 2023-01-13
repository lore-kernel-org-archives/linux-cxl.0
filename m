Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7B5C3DA78
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 21:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjAMVas (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 16:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjAMVaq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 16:30:46 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0604EB7CE
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 13:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673645446; x=1705181446;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zubFUFYXvyNUYhr0fS3OT03QBEIGB9S9arm1PqISq7E=;
  b=VJ3Amqo+VHKBdJZyTw4epubxId4YemXAzPRA7O1MSzqfwUn9D8y21u2B
   6dwvNp15T7Zg5iXiYgoO9l0SXaqJxTIhslXyeiWpVPQ3cOP1Kgm6orc1l
   0DoXOwKtUGR7bfl+r6q3vbyCxo3SpI0M7u5kbpqXrVikLVutN8j9Wy9BT
   uBZgvl+acn2vrP2PvPpnrP5EgJ4w1+xElV1nPOwYaJ5ese88G13CmvkYx
   Z+ziHHSzikgj6obYpShEhQvAIEs8Iu6LWgIlJbbcKfze6Ag0goe0dsA+P
   ybfmtBP8l1pZoxOW4QT3gm05KGqX9zklM6P4E9wnfvpVM2YmP9HSU1M+c
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="325362660"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="325362660"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:30:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="660342252"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="660342252"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.60.10])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:30:35 -0800
Subject: [PATCH] cxl: fix cdat_available state post error
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Fri, 13 Jan 2023 14:30:34 -0700
Message-ID: <167364543268.908947.8539778012050364814.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Given that the sysfs attributre for CDAT_read() checks port->cdat_avilable,
it indicates that the binary backing cdat must be present.

port->cdat_available is set to true in read_cdat_data() before the data is
actually read. When error happens during read, this state is never set to
false. Move the setting of the attribute to after everything is done to
ensure it's always true.

Fixes: c97006046c79 ("cxl/port: Read CDAT table")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 1d1492440287..91cdd6a00964 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -601,8 +601,6 @@ void read_cdat_data(struct cxl_port *port)
 		return;
 	}
 
-	port->cdat_available = true;
-
 	if (cxl_cdat_get_length(dev, cdat_doe, &cdat_length)) {
 		dev_dbg(dev, "No CDAT length\n");
 		return;
@@ -621,6 +619,8 @@ void read_cdat_data(struct cxl_port *port)
 		port->cdat.length = 0;
 		dev_err(dev, "CDAT data read error\n");
 	}
+
+	port->cdat_available = true;
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
 


