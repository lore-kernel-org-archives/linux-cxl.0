Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03358CCA47B
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Jul 2022 17:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbiGNRCS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Jul 2022 13:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbiGNRCR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Jul 2022 13:02:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F374E851
        for <linux-cxl@vger.kernel.org>; Thu, 14 Jul 2022 10:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657818137; x=1689354137;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NgVTcO/N8lNlztGxQoim/NbcYQnweRCnSkSjx/KcjhI=;
  b=GUNZPZ629Y11SkuPSrqSw84+kLpoDK4R+phTrLy3gzhuo3xCns6cMz8Y
   +mvyTC17Zc3tHIJRjmoudyAFS3Ctel0982RLAR0sCvfTVmBEzTHzF//T3
   dlc4TijCn0D08GHloqhBuN1bU3Edyo7WJ2AbGDDjOkaVkmHwJu6Svtpzq
   62pP1qeYZUgE9Q//zYJMEjdK66Q7ADa4z8gGTxnJHPpaJJdJBVewuKfbX
   M6H+ikvpeUdJoPNKaLAeF2g9SxBFX2gl5StmnEENUtTKLq8shYvjNnOiu
   S8eaj7tspArkb23wj4nlqZP5UYb5yB1NRRe8DTSCO7jSqs46RazcrKfK8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="349542022"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="349542022"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 10:02:04 -0700
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="772693904"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 10:02:04 -0700
Subject: [ndctl PATCH v2 03/12] cxl/list: Hide 0s in disabled decoder
 listings
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     Davidlohr Bueso <dave@stgolabs.net>, alison.schofield@intel.com,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Date:   Thu, 14 Jul 2022 10:02:04 -0700
Message-ID: <165781812427.1555691.5252994293073680408.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165781810717.1555691.1411727384567016588.stgit@dwillia2-xfh.jf.intel.com>
References: <165781810717.1555691.1411727384567016588.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Trim some redundant information from decoder listings when they are
disabled.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/json.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/cxl/json.c b/cxl/json.c
index fdc6f73a86c1..a213fdad55fd 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -442,7 +442,7 @@ struct json_object *util_cxl_decoder_to_json(struct cxl_decoder *decoder,
 	const char *devname = cxl_decoder_get_devname(decoder);
 	struct cxl_port *port = cxl_decoder_get_port(decoder);
 	struct json_object *jdecoder, *jobj;
-	u64 val;
+	u64 val, size;
 
 	jdecoder = json_object_new_object();
 	if (!jdecoder)
@@ -452,21 +452,21 @@ struct json_object *util_cxl_decoder_to_json(struct cxl_decoder *decoder,
 	if (jobj)
 		json_object_object_add(jdecoder, "decoder", jobj);
 
+	size = cxl_decoder_get_size(decoder);
 	val = cxl_decoder_get_resource(decoder);
-	if (val < ULLONG_MAX) {
+	if (size && val < ULLONG_MAX) {
 		jobj = util_json_object_hex(val, flags);
 		if (jobj)
 			json_object_object_add(jdecoder, "resource", jobj);
 	}
 
-	val = cxl_decoder_get_size(decoder);
-	if (val < ULLONG_MAX) {
-		jobj = util_json_object_size(val, flags);
+	if (size && size < ULLONG_MAX) {
+		jobj = util_json_object_size(size, flags);
 		if (jobj)
 			json_object_object_add(jdecoder, "size", jobj);
 	}
 
-	if (val == 0) {
+	if (size == 0) {
 		jobj = json_object_new_string("disabled");
 		if (jobj)
 			json_object_object_add(jdecoder, "state", jobj);

