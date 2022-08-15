Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD1CC00140
	for <linux-cxl@archiver.kernel.org>; Mon, 15 Aug 2022 18:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiHOSMC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 Aug 2022 14:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbiHOSMA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 Aug 2022 14:12:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5414622BF6
        for <linux-cxl@vger.kernel.org>; Mon, 15 Aug 2022 11:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660587120; x=1692123120;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6EaW6u8QngBuh6zk7ZxPWQ4L5alvQ/apItGwG+3+9+E=;
  b=coshhfV8hQlm075/W1KbDpxCc64c/AMN/p3PErPD5C4puwSPqSrMdr9o
   KZviB6LWvwac4V0q4O7sO+6xQq2TpvvFvTKZhbJoSjoDUo0rxr7eMHV/Q
   bWDs4lAQaY3nh53D6gnfUzAwrOGgTrl3imztUcbGyQBQkYDlQ1fyJPwI9
   1rhabU3BlTKt4L2HIpasBNrurdKbDKI5R0eVHJJk+aFwmrDil4F7XhC/2
   mNtDS/gDU9QW1jNm6JCahzEoMTJwWwqew3qNRKzjIbmhohVa5nBzLD2bE
   X+YQhF/BzcunvGdZnbtCuIMlbUGmuMkgp8JY49FAA4QHTep99iOmwT1O9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="275081665"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="275081665"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 11:11:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="674917875"
Received: from djiang5-desk4.jf.intel.com ([10.165.157.96])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 11:11:59 -0700
Subject: [PATCH v3 3/3] tools/testing/cxl: Add interleave check support to
 mock cxl port device
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Mon, 15 Aug 2022 11:11:59 -0700
Message-ID: <166058711917.1520730.2606494810403472146.stgit@djiang5-desk4.jf.intel.com>
In-Reply-To: <166058698949.1520730.1888371264289688061.stgit@djiang5-desk4.jf.intel.com>
References: <166058698949.1520730.1888371264289688061.stgit@djiang5-desk4.jf.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Attach the cxl mock hdm to the port device to allow cxl_interleave_verify()
to check the interleave configuration. Set the interleave_mask as well
to support the new verification code.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index a072b2d3e726..3ce353a20b80 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -398,6 +398,9 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port)
 		return ERR_PTR(-ENOMEM);
 
 	cxlhdm->port = port;
+	cxlhdm->interleave_mask = GENMASK(14, 8);
+	cxlhdm->interleave_cap = CXL_HDM_INTERLEAVE_CAP_DEFAULT;
+	dev_set_drvdata(&port->dev, cxlhdm);
 	return cxlhdm;
 }
 


