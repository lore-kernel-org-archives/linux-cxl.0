Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A66C636D6
	for <linux-cxl@archiver.kernel.org>; Sat, 18 Feb 2023 00:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBRAp4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Feb 2023 19:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBRApz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Feb 2023 19:45:55 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7739C6745E
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 16:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676681123; x=1708217123;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4mXc8aXzC2a5QQ64fr2TipWZlLxkknQajmWzGZWeva0=;
  b=AZ+ZFQyV6Rl3B1I0neOF2lyHf3uILbtddzNCbs2SYR+ez966JJRE9d8Z
   yN3GXaQMG6DU1FQcYKDReEi68hqDatRq2q88IzMRKb/rqJcRpuimeAokI
   fRPmsqIHdJlaS0YhS9oFVeZ8zeQxAtsfWCuA0sQAKASznxMRSzQtlZWiM
   u1ryoiL2WyIaITfO4ifLP7gF0Co//ZXTv7gWzqOd5siPxLYoWQnUp7tzg
   uUlJPkQyeiDNXSr8sdDq7bF+PyYdAQygDvxLtKIHqS0Aqe4AhTItXiNI9
   f0HKeE1HFiULQwa5keo2k6b6+ZYtsVCsT2oBDcMt3Ex+K3f5Jeax6UjZ0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="311754226"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="311754226"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 16:40:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="844749009"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="844749009"
Received: from basavana-mobl.amr.corp.intel.com (HELO vverma7-desk1.local) ([10.209.2.127])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 16:40:32 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Fri, 17 Feb 2023 17:40:24 -0700
Subject: [PATCH ndctl 3/3] test/cxl-security.sh: avoid intermittent
 failures due to sasync probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-coverity-fixes-v1-3-043fac896a40@intel.com>
References: <20230217-coverity-fixes-v1-0-043fac896a40@intel.com>
In-Reply-To: <20230217-coverity-fixes-v1-0-043fac896a40@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.13-dev-ada30
X-Developer-Signature: v=1; a=openpgp-sha256; l=896;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=4mXc8aXzC2a5QQ64fr2TipWZlLxkknQajmWzGZWeva0=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDMkf5OqLBFx1l6UXlB2W6bmTu9Zyy50dsq83SVoWZz1Yz
 xYg7D+7o5SFQYyLQVZMkeXvno+Mx+S25/MEJjjCzGFlAhnCwMUpABN5y8Lwhz8r8Gl//o/jXjWR
 vz0fZByLcvvMuVdn844g4Y5tal+yfRkZemJfe3efblUuTnmvsXJP0bX55vHzp04892vh144FLXd
 WcQMA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This test failed intermittently because the ndctl-list operation right
after a 'modprobe cxl_test' could race the actual nmem devices getting
loaded.

Since CXL device probes are asynchronous, and cxl_acpi might've kicked
off a cxl_bus_rescan(), a cxl_flush() (via cxl_wait_probe()) can ensure
everything is loaded.

Add a plain cxl-list right after the modprobe to allow for a flush/wait
cycle.

Cc: Dave Jiang <dave.jiang@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 test/security.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/security.sh b/test/security.sh
index 04f630e..fb04aa6 100755
--- a/test/security.sh
+++ b/test/security.sh
@@ -225,6 +225,7 @@ if [ "$uid" -ne 0 ]; then
 fi
 
 modprobe "$KMOD_TEST"
+cxl list
 setup
 check_prereq "keyctl"
 rc=1

-- 
2.39.1

