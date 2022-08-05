Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3798BC00140
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Aug 2022 20:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbiHEUiF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 Aug 2022 16:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiHEUiE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 Aug 2022 16:38:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B7EDFA
        for <linux-cxl@vger.kernel.org>; Fri,  5 Aug 2022 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659731883; x=1691267883;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MdnkW3zHJpxjY07Rupkb3kS0eWfU8z0wceaky1oj0rE=;
  b=fIKPA+aNxGUsYnfC+YFUAB+BihSon+ZfppAZeOVfE+nfLA/xlE0EFLvW
   hHEBkpXHk9A0uhEiX/OGyNN8q37mHW3qSsMrrPqOSxwD7TJQ+jNeY565o
   KIZZ4piJw8ym4lzxkFh5IGTzTutBtzXpKYAkb9pTIGtCfIkcsHz792yK6
   0DxGffy6z8onNmGDOKzV8+QoBv+Hi4aYzNoVEQ7rGQ2oCmjqfnTF8FY1T
   O6boKjW3n/Ux8EVNED4Vge9r0VykHq0zYqdMmU14uLrC8FDrvuGtMFQJS
   D8ggUN+S6zQ1K3STxJMyJwN5AJeJL2jODhc4pHIbtvPqduDQ4nKGtIBHe
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="277209725"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="277209725"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:38:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="603714849"
Received: from jivaldiv-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.255.228.201])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:38:03 -0700
Subject: [ndctl PATCH 2/6] cxl/list: Add interleave parameters to decoder
 listings
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com
Date:   Fri, 05 Aug 2022 13:38:03 -0700
Message-ID: <165973188300.1528532.222988685552982872.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165973187080.1528532.8097010788284626448.stgit@dwillia2-xfh.jf.intel.com>
References: <165973187080.1528532.8097010788284626448.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Emit interleave_ways and interleave_granularity in decoder output.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/json.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/cxl/json.c b/cxl/json.c
index ad93413b5f05..36b76d34b4e5 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -466,6 +466,26 @@ struct json_object *util_cxl_decoder_to_json(struct cxl_decoder *decoder,
 			json_object_object_add(jdecoder, "size", jobj);
 	}
 
+	val = cxl_decoder_get_interleave_ways(decoder);
+	if (val < UINT_MAX) {
+		jobj = json_object_new_int(val);
+		if (jobj)
+			json_object_object_add(jdecoder, "interleave_ways",
+					       jobj);
+
+		/* granularity is a don't care if not interleaving */
+		if (val > 1) {
+			val = cxl_decoder_get_interleave_granularity(decoder);
+			if (val < UINT_MAX) {
+				jobj = json_object_new_int(val);
+				if (jobj)
+					json_object_object_add(
+						jdecoder,
+						"interleave_granularity", jobj);
+			}
+		}
+	}
+
 	if (size == 0) {
 		jobj = json_object_new_string("disabled");
 		if (jobj)

