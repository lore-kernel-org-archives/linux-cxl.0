Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3AEC4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Dec 2022 22:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLNWA4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Dec 2022 17:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiLNWAz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Dec 2022 17:00:55 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F63C286D1
        for <linux-cxl@vger.kernel.org>; Wed, 14 Dec 2022 14:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671055254; x=1702591254;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mwVah/u+qM7VhJ72QMALIWdkabtUltYcykRGgJ72ORQ=;
  b=nbHrlXOIhitvpFKkstmDdDFqBH3JC+mHzdjv32YLa3HT0PM6v/tLxEFT
   9M7Tcbxi3k+V0cyBb3fJgNVLj+rZe6YKH1DLxCQcC2PEIhTp/ThUdVPu7
   Vc7zqYEYcSxxrm2fcAEVqJio9gRQpEoxr8sS6n1l4gen5a4Wg21wjkZA1
   kSq0le9r0gFOwH1gjEUzzZbAsHhLnuCgy89qwyPrSXPQr4ly2PX2YncWO
   JLbHyVU6MeS0lf9wIiTEj/7dx4M09Vpi26U0xzE1sfyFiXkTzAqOGpqJM
   MwvW3CVdcJ4dHXShfj8ggDZ9RJjyCVoLT+F5+vZfL0mOZy+0dgkplSFFY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="316159242"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="316159242"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 14:00:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="679907729"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="679907729"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 14:00:32 -0800
Subject: [ndctl PATCH v2 2/4] ndctl/libndctl: Add bus_prefix for CXL
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     vishal.l.verma@intel.com
Date:   Wed, 14 Dec 2022 15:00:31 -0700
Message-ID: <167105523165.3034751.4940603908511673299.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <167105505204.3034751.8113387624258581781.stgit@djiang5-desk3.ch.intel.com>
References: <167105505204.3034751.8113387624258581781.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

When the 'ndbus' is backed by CXL, setup the bus_prefix for dimm object
appropriately.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- improve commit log. (Vishal)
---
 ndctl/lib/libndctl.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 10422e24d38b..d2e800bc840a 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -2012,6 +2012,12 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 			goto out;
 		}
 		rc =  add_papr_dimm(dimm, dimm_base);
+	} else if (ndctl_bus_has_cxl(bus)) {
+		dimm->bus_prefix = strdup("cxl");
+		if (!dimm->bus_prefix) {
+			rc = -ENOMEM;
+			goto out;
+		}
 	}
 
 	if (rc == -ENODEV) {


