Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A319C43334
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Jul 2022 19:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiGLTcD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Jul 2022 15:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiGLTbt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Jul 2022 15:31:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF79F90C2
        for <linux-cxl@vger.kernel.org>; Tue, 12 Jul 2022 12:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657652863; x=1689188863;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mrnwLl55GJn/AdTFh1P9ioZWwwFqWv5sPXutL333B8w=;
  b=WuEDVyOenj4ltIkiQWWRPVSZDVMQA59LHKm19DhRRJa3LoKeIp0/22XU
   IcPSu7Wy1ifhFyZaDeFSDzjdulWia0K9+zc8SIwX/RwEf2Enmaz2debel
   92VEuADgQQXr9eK/1BCk/DPzPV+qDTLOvdFusEdneJp3SRxf5mvCnfZCH
   ZAVgZzVKWby8rtp2a+5sm9x3BxMv3EaFngxCbmVNuEf5OexMOwamLn6iU
   bS6PlPbTMhg312pMDFh/dnGCgpw0bGuDADxlfYUk03Y5SSCoT5ABU/egH
   80jczYaJmly311+PcAt1PNDeES44XnkEYHMUnYhyp6Eh63ZRaAhpiC051
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="268058633"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="268058633"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 12:07:42 -0700
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="653039379"
Received: from sheyting-mobl3.amr.corp.intel.com (HELO [192.168.1.117]) ([10.212.147.156])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 12:07:42 -0700
Subject: [ndctl PATCH 03/11] cxl/list: Hide 0s in disabled decoder listings
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     alison.schofield@intel.com, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org
Date:   Tue, 12 Jul 2022 12:07:41 -0700
Message-ID: <165765286159.435671.9172753303612160309.stgit@dwillia2-xfh>
In-Reply-To: <165765284365.435671.13173937566404931163.stgit@dwillia2-xfh>
References: <165765284365.435671.13173937566404931163.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Trim some redundant information from decoder listings when they are
disabled.

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

