Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3BACCA47F
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Jul 2022 19:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiGLTb5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Jul 2022 15:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiGLTbk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Jul 2022 15:31:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45451E4764
        for <linux-cxl@vger.kernel.org>; Tue, 12 Jul 2022 12:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657652857; x=1689188857;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AeWJ82o6BwFn1NlqdqKUFKk+NqL3Dqc98exzk9j2WHE=;
  b=bgSjKtaJGvospnPglgA9P3vFhzMEgsgqvpJSlcuZ5Ivi8kNwQsQiQCPF
   jHU15wURvqaOqzi6TBHF+7ZiF2fD0+8oqNq/i72gQUnDdzRbhmDzqdXeh
   8wFKh6ZB8Si9EaGdVdP/D4FjIzg/GfM3k2Zpz79WAygr1KEo5WZTQFXhG
   axa/zvjZAvhxPvXGjrX3BSQmkaXcMsyOzYRpZpsExxuzorS8tm9ITty+V
   3ky8FLU7aTyHXqQMZNsqAhZf/iBiR/lsI84eP1h9e9wD8E1fDVnMPA47R
   15PUq6HFdJhQCIzZQI3fkAAUb1gePCvctfeHUB+shRetWIaxpzXgGwB9l
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="310645995"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="310645995"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 12:07:36 -0700
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="570316577"
Received: from sheyting-mobl3.amr.corp.intel.com (HELO [192.168.1.117]) ([10.212.147.156])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 12:07:36 -0700
Subject: [ndctl PATCH 02/11] cxl/list: Emit endpoint decoders filtered by
 memdev
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     alison.schofield@intel.com, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org
Date:   Tue, 12 Jul 2022 12:07:36 -0700
Message-ID: <165765285600.435671.1816486143808105272.stgit@dwillia2-xfh>
In-Reply-To: <165765284365.435671.13173937566404931163.stgit@dwillia2-xfh>
References: <165765284365.435671.13173937566404931163.stgit@dwillia2-xfh>
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

