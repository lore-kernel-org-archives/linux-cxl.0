Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36221C43334
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Jul 2022 17:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240099AbiGNRDA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Jul 2022 13:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240107AbiGNRC4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Jul 2022 13:02:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D6A5E318
        for <linux-cxl@vger.kernel.org>; Thu, 14 Jul 2022 10:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657818171; x=1689354171;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AeWJ82o6BwFn1NlqdqKUFKk+NqL3Dqc98exzk9j2WHE=;
  b=bhN0cjFnwTz8cee97uwZp7SVT8Adcd/XfzXO9xBUSBix8Y+npjbW2zHn
   v0Qbp9qw2cnv1w+qs91NQAQZQn54DTcX2DSBWHLDvTcVo/YL36IwYMJD2
   b7XGy/0bAqhjY5o9aBzHzdDwNMr9LmnBAeiHuLhCskT7VZ2pewEL0XQh+
   /HKi0NnTMyqIMPYlg0Bbt2g4weky3OP8mdiCsW5DCPOcBFEeuXlzmB2EM
   nhN7O0EoFChgV8LjYdVLo2jTHjfXW2btO9+5Ol3wqFnulHoQTmwJyVCoL
   XQbwxQXNald6VUGLpvSIg5wxjg6s5ktDZuOK10wMDJp7Z+BD3U5VEJaYh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="284331586"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="284331586"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 10:01:59 -0700
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="685643797"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 10:01:58 -0700
Subject: [ndctl PATCH v2 02/12] cxl/list: Emit endpoint decoders filtered by
 memdev
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     alison.schofield@intel.com, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org
Date:   Thu, 14 Jul 2022 10:01:58 -0700
Message-ID: <165781811836.1555691.1997564050287016121.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165781810717.1555691.1411727384567016588.stgit@dwillia2-xfh.jf.intel.com>
References: <165781810717.1555691.1411727384567016588.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

For example, dump all the endpoint decoders from memdev 'mem8'.

    cxl list -Di -m 8 -d endpoint

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/filter.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/cxl/filter.c b/cxl/filter.c
index 66fd7420144a..2f88a9d2f398 100644
--- a/cxl/filter.c
+++ b/cxl/filter.c
@@ -428,7 +428,9 @@ util_cxl_decoder_filter_by_memdev(struct cxl_decoder *decoder,
 				  const char *ident, const char *serial)
 {
 	struct cxl_ctx *ctx = cxl_decoder_get_ctx(decoder);
+	struct cxl_endpoint *endpoint;
 	struct cxl_memdev *memdev;
+	struct cxl_port *port;
 
 	if (!ident && !serial)
 		return decoder;
@@ -438,6 +440,12 @@ util_cxl_decoder_filter_by_memdev(struct cxl_decoder *decoder,
 			continue;
 		if (cxl_decoder_get_target_by_memdev(decoder, memdev))
 			return decoder;
+		port = cxl_decoder_get_port(decoder);
+		if (!port || !cxl_port_is_endpoint(port))
+			continue;
+		endpoint = cxl_port_to_endpoint(port);
+		if (cxl_endpoint_get_memdev(endpoint) == memdev)
+			return decoder;
 	}
 
 	return NULL;

