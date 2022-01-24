Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2E9C433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbiAXAwQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:52:16 -0500
Received: from mga06.intel.com ([134.134.136.31]:17039 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240634AbiAXAwQ (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:52:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985535; x=1674521535;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tl0B76NhTuz3dgMGjXjwas0s1oooQWVjsPp0B7rfZ+c=;
  b=V430JhHgezfj24wA97bQT3sQDg/1csiwMDkRv2kEGR4fdpXxDAWChzxq
   ZuAwtFBOj3hLNEAUhT0ekOhH/VUqEe0ChkhR0n8ilxHS7eUwRI/Lb9kYd
   rUC50WAAgNv/Mp3fsB41vVWWgMIDR382rlyj6syQp2JEu9bF7qC1gjbZu
   lBhwu1pCchwcfGETimWt03bK3b7vhNMv7cy0pwj/ejUXHWABku5EmC90T
   Enl5ksswLYJBVMdK66X7OjtK0QOubQa+BQykGXn+2KDB7d764sPz5A8Zz
   KkQIdeceBTZCDYwlwm4Cs9xM6MDThJFOZVR0ngRL80ua84MIjwNFiNSiH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="306652113"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="306652113"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="476540359"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:15 -0800
Subject: [ndctl PATCH 05/37] cxl/json: Cleanup object leak false positive
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:52:15 -0800
Message-ID: <164298553566.3021641.11858634436119663877.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

As written it is a leak of the json object to return if devname is NULL.
However, the devname can not be NULL because the memdev would not have been
enumerated. Drop the error checking.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/json.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cxl/json.c b/cxl/json.c
index 97ed76b65a6b..3ef9f7670510 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -190,7 +190,7 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 	struct json_object *jdev, *jobj;
 
 	jdev = json_object_new_object();
-	if (!devname || !jdev)
+	if (!jdev)
 		return NULL;
 
 	jobj = json_object_new_string(devname);

