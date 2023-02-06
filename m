Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313DDC636D4
	for <linux-cxl@archiver.kernel.org>; Mon,  6 Feb 2023 01:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBFBCy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 5 Feb 2023 20:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBFBCx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 5 Feb 2023 20:02:53 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BF48A71;
        Sun,  5 Feb 2023 17:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675645372; x=1707181372;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yszGLPkFMXedVGllSqe6JjeO5D0jX4yLcgUfwilZAzI=;
  b=FTdgOzxiK/n8EQrct1NKXny2jtk1ViZwiVEpgp9OZkPYE4CXUjZBJSUj
   VZqMuRxyEbtehyZ11M36/P/r7n4tsbt9qu/15yhULYXKG+d0NwadZA5uE
   SM+sw2ibRu3KiXXkjtyL6zw95dwgLgx/KWw2mmruy7mpKlYo5yO/RQ931
   Z1TkR8raZZ56FFpisyDfzoUnARRtGBkVagXqkbGJE0jhqf899RhjZMwSl
   PAz64pP9vJ7oILUYmdcQ/JfH3g6hgKj8YfEyejrG04X1WngqADCNrvHQe
   8P1ktKEjs18+ZoWNCYjnZ9s2rjiUuqdvRREd76PUOnofiVCkEWeAWO4Ow
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="331243798"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="331243798"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:02:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="643855741"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="643855741"
Received: from mkrysak-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.255.187])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:02:51 -0800
Subject: [PATCH 04/18] cxl/region: Validate region mode vs decoder mode
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Sun, 05 Feb 2023 17:02:51 -0800
Message-ID: <167564537131.847146.9020072654741860107.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for a new region mode, do not, for example, allow
'ram' decoders to be assigned to 'pmem' regions and vice versa.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c9e7f05caa0f..53d6dbe4de6d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1217,6 +1217,12 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	struct cxl_dport *dport;
 	int i, rc = -ENXIO;
 
+	if (cxled->mode != cxlr->mode) {
+		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
+			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
+		return -EINVAL;
+	}
+
 	if (cxled->mode == CXL_DECODER_DEAD) {
 		dev_dbg(&cxlr->dev, "%s dead\n", dev_name(&cxled->cxld.dev));
 		return -ENODEV;

