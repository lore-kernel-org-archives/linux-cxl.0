Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBEBC636D6
	for <linux-cxl@archiver.kernel.org>; Sat, 18 Feb 2023 00:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjBRAow (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Feb 2023 19:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjBRAov (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Feb 2023 19:44:51 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0FF6B336
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 16:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676681059; x=1708217059;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=LT0dFcEhdmV5La+BwNbufwp+Qmm3U4wmcz4EnEgESaI=;
  b=SlYQ2n1R8UVcCcpUTzLexI0qD6t673KPNeKhgXHJu5rl89I1nvp+cdNK
   t0bFOpXU0MxdX+kmVFk3XfmqCe/oepj+7rMhTYPcRgPpzrvRVHPoU+Nha
   IaWwPfA9TkgGKvLH6Z/IIZX5zdotp52bcgqFT+h07cp5BR2PsW4nGVEsj
   qBi2LVcEifxU4F8iOY9QsdDoPixrURdDg1gKb/WRtnfjxU/TTN/X3UXSF
   hexxStpeEXJaMHXJewZ63MiMezolKhMW11CZ4K60Klxr+ybbvidRL5Efm
   03FQMCAnhy2oJjXS5bpE7n3ZREIo4RNWqELQIII40QHM6P80C/pUp+Rwr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="311754222"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="311754222"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 16:40:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="844749002"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="844749002"
Received: from basavana-mobl.amr.corp.intel.com (HELO vverma7-desk1.local) ([10.209.2.127])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 16:40:32 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Fri, 17 Feb 2023 17:40:22 -0700
Subject: [PATCH ndctl 1/3] cxl/event_trace: fix a resource leak in
 cxl_event_to_json()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-coverity-fixes-v1-1-043fac896a40@intel.com>
References: <20230217-coverity-fixes-v1-0-043fac896a40@intel.com>
In-Reply-To: <20230217-coverity-fixes-v1-0-043fac896a40@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.13-dev-ada30
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=LT0dFcEhdmV5La+BwNbufwp+Qmm3U4wmcz4EnEgESaI=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDMkf5OrtNqj9Oi8mONXFNjPnluU+xthEnnbvvT4pa5S41
 VhivrF0lLIwiHExyIopsvzd85HxmNz2fJ7ABEeYOaxMIEMYuDgFYCJf1BgZZtjvadkRZnKEMTJE
 hmO//yqT9osredXf/9rXO/fAcs6Zuxj++2YXJq2W6C733H7721n2dT7yupN+dy26Hfzx9Kdat5/
 veAE=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Static analysis reports that a 'return -ENOMEM' in the above function
bypasses the error unwinding and leaks 'jevent'.

Fix the error handling to use the right goto sequence before returning.

Fixes: 8dedc6cf5e85 ("cxl: add a helper to parse trace events into a json object")
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/event_trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cxl/event_trace.c b/cxl/event_trace.c
index a973a1f..76dd4e7 100644
--- a/cxl/event_trace.c
+++ b/cxl/event_trace.c
@@ -142,7 +142,8 @@ static int cxl_event_to_json(struct tep_event *event, struct tep_record *record,
 				jobj = num_to_json(data, f->elementsize, f->flags);
 				if (!jobj) {
 					json_object_put(jarray);
-					return -ENOMEM;
+					rc = -ENOMEM;
+					goto err_jevent;
 				}
 				json_object_array_add(jarray, jobj);
 				data += f->elementsize;

-- 
2.39.1

