Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7354C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Dec 2022 01:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiLOBeA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Dec 2022 20:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLOBd7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Dec 2022 20:33:59 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4CF275F3
        for <linux-cxl@vger.kernel.org>; Wed, 14 Dec 2022 17:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671068038; x=1702604038;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pkZycG9iTsAGeHs/LogJmeAs9gev03WAcJys6JCnqRA=;
  b=Ju8yVKb/wckfz1YaOHP0d59dOr1xo5nlr2Af1ow4Fx8limmk29rgQvFV
   21Slcxoba+iQM5Qvqqnsh4NEFxrs05+tubHjcmruYvTDtjxggEBaUGMOm
   zbqplMHIGXBb+5aQF3s9H68bIsJkOfPXX71TZqMyaN1wbrOjhtw2mLCA7
   Aw1TdhdMUY8h94S0d55u2vSpz+YeUuv0K1efB26Im9w2sF+ReaR5kOSal
   VbwpzaxUzsLT58AeOAxoy/8jd+unLpOYKDpifv2nQbbKfFJ3XfNrBNprX
   GB6F7uAgngaDrGaZGOHoEZLS9HxBRjp893EinoJrNqdyIh5hgNO8r1jUx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="345642659"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="345642659"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 17:33:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="823495331"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="823495331"
Received: from shellyki-mobl3.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.180.133])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 17:33:57 -0800
Subject: [PATCH 2/2] cxl/region: Fix memdev_filter_pos() separator detection
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-cxl@vger.kernel.org
Date:   Wed, 14 Dec 2022 17:33:57 -0800
Message-ID: <167106803771.1326377.10608704295797398750.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167106802682.1326377.13483249974201112428.stgit@dwillia2-xfh.jf.intel.com>
References: <167106802682.1326377.13483249974201112428.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Stop using the modified version of the @_csv as the string to determine
the separator it may cause which_sep() to get different answers each
iteration. Moreover there is no need to retrieve the separator each
iteration, so just retrieve it once from @_csv.

If the separator is mismatched it can lead to the sort not following the
specified device order for create-region.

Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Link: https://gist.github.com/mcgrof/aeac639365a651bd77f143cf38eb7493
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/region.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cxl/region.c b/cxl/region.c
index 2202afa440ef..bb3a10a7713c 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -172,6 +172,7 @@ static struct sort_context {
 static int memdev_filter_pos(struct json_object *jobj, const char *_csv)
 {
 	struct cxl_memdev *memdev = json_object_get_userdata(jobj);
+	const char *sep = which_sep(_csv);
 	char *csv, *save;
 	const char *arg;
 	int pos;
@@ -180,8 +181,8 @@ static int memdev_filter_pos(struct json_object *jobj, const char *_csv)
 	if (!csv)
 		return -1;
 
-	for (pos = 0, arg = strtok_r(csv, which_sep(csv), &save); arg;
-	     arg = strtok_r(NULL, which_sep(csv), &save), pos++)
+	for (pos = 0, arg = strtok_r(csv, sep, &save); arg;
+	     arg = strtok_r(NULL, sep, &save), pos++)
 		if (util_cxl_memdev_filter(memdev, arg, NULL))
 			break;
 	free(csv);

