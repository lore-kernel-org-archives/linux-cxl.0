Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63863C46467
	for <linux-cxl@archiver.kernel.org>; Tue, 10 Jan 2023 23:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjAJXJ6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 10 Jan 2023 18:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjAJXJy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 10 Jan 2023 18:09:54 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735DE51331
        for <linux-cxl@vger.kernel.org>; Tue, 10 Jan 2023 15:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673392192; x=1704928192;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=fmSaGPa45YfheJe/4NK35ErzQMDPkD19G7Hxl9UoBDc=;
  b=Qqc8GPnhlOHNCHFki/MAv9RvatonHGNDdoYmvZs8wE5mvaD9yvxXwaEV
   L3kgUbBTQX6l+KJB999uVvujifdoOYYPKAHvONxdJDOiIZ/oGO9R5vxXO
   ffkmHNSbRfMetCHrz6ZMxH13megUTYGFtGi7q4wHVqDDjr38J/mnQsHnw
   tL7yy2d8Ha619UiKzL98c3rDBO1f6BNZI5lTgI0a8b/ugqbYuvOkBqxJs
   l8ZNRLXapFy9z/UfxJXuhU2eGCfXw8IN86QHZwAijYhizdrbDcZG9ti3R
   xxJluk1hyAEuF7SqaFRigNVkO5uYTTR0+L65N7pRYPXRCC9suGkm9O/GU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="321981261"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="321981261"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 15:09:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659155901"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="659155901"
Received: from ffallaha-mobl.amr.corp.intel.com (HELO vverma7-desk1.local) ([10.212.116.179])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 15:09:51 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl 0/4] cxl: misc coverity and typo fixes
Date:   Tue, 10 Jan 2023 16:09:14 -0700
Message-Id: <20230110-vv-coverity-fixes-v1-0-c7ee6c76b200@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABvwvWMC/x2L0QqDMAwAf0XybCCtwuZ+RXyoNZsBqaNxZSL+u
 8HHO+4OUM7CCq/qgMxFVNZk4OoK4hzSh1EmY/DkG3KOsBSMa7Fp2/Etf1bsODynhjrf0gPsG4My
 jjmkONuZfsti8pv5rs30w3lerdWylngAAAA=
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.12-dev-cc11a
X-Developer-Signature: v=1; a=openpgp-sha256; l=729;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=fmSaGPa45YfheJe/4NK35ErzQMDPkD19G7Hxl9UoBDc=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDMl7P9if1VjzZEJYo1Wd3ZT1O+I3zWZY3apfUhK0p7rh4NQV
 iUfbOkpZGMS4GGTFFFn+7vnIeExuez5PYIIjzBxWJpAhDFycAjAR9mqG//nWbHxvbrJEuNXejr2sKj
 AzumfGDe8NTUo3pyzdc/j8fz+G/5nNlbkiJUY6fMubNy3ve3RmWofTkjn3Y6uEFnvECx0z4wUA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Fix a few issues reported by Coverity, and a comment typo.

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

---
Vishal Verma (4):
      ndctl/lib: fix usage of a non NUL-terminated string
      cxl/region: fix a resource leak in to_csv()
      cxl/region: fix an out of bounds access in to_csv()
      cxl/region: fix a comment typo

 ndctl/lib/libndctl.c | 2 ++
 cxl/region.c         | 8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)
---
base-commit: 5b57c48998186b894fb94ce099c785d584773402
change-id: 20230110-vv-coverity-fixes-9ea8d3092407

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>
