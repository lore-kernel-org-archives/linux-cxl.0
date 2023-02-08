Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA29C636D3
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Feb 2023 22:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjBHWNE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Feb 2023 17:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjBHWND (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Feb 2023 17:13:03 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F83E4228
        for <linux-cxl@vger.kernel.org>; Wed,  8 Feb 2023 14:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675894380; x=1707430380;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=7hmAWX2TkK4bLtgksYcYEaN57Y50IHbQGEZGoOyhGeM=;
  b=a/mlgzMwtJNU1VMgaMw89WNFOWRuuAoRqEv6qulmy3MuF3XRfkINrfqh
   eSm9of5VRRfdq70wPyhnWbk9s1EnZ7wYsQ7ZK1giht4s/7ep5FRd9hFHm
   aBwF56E+kQKV7au692OrUYKLBfDphmKnSTo3k0n9tQjrEu4wMsUC3DozW
   slI35B0VNhEFz9/Jiyl8CivywyWBisMJ3asPjz+6stv7YPAO1LZ0peiZf
   xpPj50w9t2M1LMzU6QTB/3/CkwRssXpo8Oz8rOcY2mEVI7/Vfm+Yi/A5l
   /GkIrAqrHezUG1lnsjZv1QQKYrAiSOQB92aVhRe3mwZdNV6Aykqhoxhdu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="317944610"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="317944610"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 14:12:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="731039509"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="731039509"
Received: from laarmstr-mobl.amr.corp.intel.com (HELO vverma7-desk1.local) ([10.251.6.109])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 14:12:58 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Wed, 08 Feb 2023 15:12:48 -0700
Subject: [PATCH ndctl] meson.build: fix version for v75
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230208-v75-fix-version-v1-1-cb90e3740011@intel.com>
X-B4-Tracking: v=1; b=H4sIAF8e5GMC/x2NQQrDMAwEvxJ0rsBxYhr6ldKDHW8TXdQggymE/
 L12j8PssCcVmKDQYzjJUKXIRxuMt4HWPeoGltyYvPOT827heg/8li9XWN/yPIYlzX7KAYFalWI
 BJ4u67r07oFl06+YwtPD/9Xxd1w98Qa6HewAAAA==
To:     nvdimm@lists.linux.dev
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.13-dev-ada30
X-Developer-Signature: v=1; a=openpgp-sha256; l=899;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=7hmAWX2TkK4bLtgksYcYEaN57Y50IHbQGEZGoOyhGeM=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDMlP5LI2W2V4dPhPDU1aoJgfNKlgd+3r2dHzC2+o/hPb/
 MT8+EmpjlIWBjEuBlkxRZa/ez4yHpPbns8TmOAIM4eVCWQIAxenAExEs5nhn7aJcGTLlvY5Lv8m
 q3/RP3LDZ8fOL5Pmn8ivmJcTVagVuI+R4ebRx+bnl76639e13EA/SHQ2zylz1n+6CYmt3m4zQgU
 mMwIA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The v75 release neglected to update the meson.build version to 75.
This results in the build and '--version' commands to output a v74 based
version. Update this to 75 now for the git tree and subsequently have a
v75.1 branch / release if needed.

Reported-by: Michal Suchánek <msuchanek@suse.de>
Link: https://github.com/pmem/ndctl/issues/230
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 2a96cb3..6a1b32e 100644
--- a/meson.build
+++ b/meson.build
@@ -1,5 +1,5 @@
 project('ndctl', 'c',
-  version : '74',
+  version : '75',
   license : [
     'GPL-2.0',
     'LGPL-2.1',

---
base-commit: eee8fa6cea7403f3998c7a3e23a881b85e661664
change-id: 20230208-v75-fix-version-4158b423d5e5

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

