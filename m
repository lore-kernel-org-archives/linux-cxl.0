Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E759C05027
	for <linux-cxl@archiver.kernel.org>; Sat, 18 Feb 2023 00:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBRAo2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Feb 2023 19:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjBRAoZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Feb 2023 19:44:25 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6B36745E
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 16:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676681026; x=1708217026;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=px4xhLIWrOdfy8hwdxneIDO3Q0UT2tBgjgQb004DE4w=;
  b=XcYwTXLKZh8x+4ji6q4gYqB+UiBZFnim0Qs/Qvk9cG0awE29V5oxch/3
   VR0iLBlCf5lTLM8UKr51Za1XsXYstnlfdZOgCesufIr5cz3jMLAYOCJv4
   vovSrmEIPnJiT7wHDECUhpxG5twdhJE0hxtLNkDidWKpGf5eyCofNt9te
   1fJNiVRfcTx6NuqFcFTaYgCmheewUu/rG1L98QqztG9Cvh7UNufZRQXhc
   jvI6cIOIkGupDZVDb7S0xKI44CZTusgmBk1DuV/i5oefTtfdISTG9VNv7
   txk2PEOoy8MqIB+rufdqkq09NKxZ0o7nQ43QByemHZLDHSIwDeTXLc/ne
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="311754220"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="311754220"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 16:40:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="844748999"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="844748999"
Received: from basavana-mobl.amr.corp.intel.com (HELO vverma7-desk1.local) ([10.209.2.127])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 16:40:31 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl 0/3] cxl/monitor: coverity and misc other fixes
Date:   Fri, 17 Feb 2023 17:40:21 -0700
Message-Id: <20230217-coverity-fixes-v1-0-043fac896a40@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHUe8GMC/x3LMQ6DMAyF4asgz7VEwlDEVaoOieOAF4PiCrVC3
 B3T8X9P3wHGTdhg6g5ovIvJqh7h0QEtSWdGKd4Q+zj0MTyR1t3F54dVvmzIoQx1zBSpZnCUkzH
 mlpSWm22sRXS+n63xn/j8ep/nBSCuzzF6AAAA
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.13-dev-ada30
X-Developer-Signature: v=1; a=openpgp-sha256; l=714;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=px4xhLIWrOdfy8hwdxneIDO3Q0UT2tBgjgQb004DE4w=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDMkf5OpNJDrmLD8npJnwUbzg16J4zcAHTbqT7dOqdyWcf
 bz85cTcjlIWBjEuBlkxRZa/ez4yHpPbns8TmOAIM4eVCWQIAxenAEwkdQMjwwSJGqcAAZnFYpWb
 FjMXv9Z4bPdsRbVf4PZte/LOa24/sISRYdITTykV++bYl5w8T+9FNpeoHZss0DH7tMzNE2a3rr7
 vYgEA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Fix a couple of issues reported by Coverity in the cxl-monitor code, and
an async probe wait in the cxl=security.sh test.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
Vishal Verma (3):
      cxl/event_trace: fix a resource leak in cxl_event_to_json()
      cxl/monitor: retain error code in monitor_event()
      test/cxl-security.sh: avoid intermittent failures due to sasync probe

 cxl/event_trace.c | 3 ++-
 cxl/monitor.c     | 3 ++-
 test/security.sh  | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)
---
base-commit: a88bdcfb4202c73aadfee6f83c5502eb5121cbd9
change-id: 20230217-coverity-fixes-e1d3f8bc2cfb

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

