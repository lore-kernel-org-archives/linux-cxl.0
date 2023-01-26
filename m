Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F747C05027
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 05:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjAZFhc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 00:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjAZFhb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 00:37:31 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E1A51C73
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jan 2023 21:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674711450; x=1706247450;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=3pLT6cnZImwRDptO85gOUw4tEX3x33aoYAisv7ppXro=;
  b=GnykNzBIelLv3cPIqA+4H612CnDAkQhgkVS5dueILOfFWiCGDTITuaMq
   HdQrTPxUwiJyhwWwO7kyUsYuzQE44ZkaqNKvHX+N6tFFgU6VY6ZiZf4lY
   sFYQOz32KTWKPpvki28uZWo0tuDMhbAVE7Cf+9IGeSItL7sJjelk8qpUb
   IW5LtsSLmFuwTNFnUiLFZMO/gFwFI295dLq143Nf6gMmf1khM5xnt8x5R
   WcMZPY4s6PA39p04IGNMysrVaKw6yw5Qi/+DJPsWIk8mgiQFQXqfY9pZf
   +gZItlSADRINeVPJwSf7LjZu9CtRgDP0FcQmDSzal9awHwTH01Sn3/9gG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="310328958"
X-IronPort-AV: E=Sophos;i="5.97,247,1669104000"; 
   d="scan'208";a="310328958"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 21:37:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="786704001"
X-IronPort-AV: E=Sophos;i="5.97,247,1669104000"; 
   d="scan'208";a="786704001"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.115.122])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 21:37:29 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 0/2] hw/cxl: CXL Event processing fixups
Date:   Wed, 25 Jan 2023 21:37:27 -0800
Message-Id: <20230125-ira-cxl-events-fixups-2023-01-11-v1-0-1931378515f5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJcR0mMC/x2NSwrDMAxErxK0rsAfTNpepXThOEojMGqwmhAIu
 XvVLt8M8+YApcakcO8OaLSx8lsM/KWDMmd5EfJoDMGF6HxIyC1j2SvSRvJRnHhfF8Vfjc6j9xhj
 f0uRrv2URjDNkJVwaFnKbCJZa7VwaWTL/+/jeZ5fVn/dGYcAAAA=
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
X-Mailer: b4 0.12-dev-cc11a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674711449; l=1246;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=3pLT6cnZImwRDptO85gOUw4tEX3x33aoYAisv7ppXro=;
 b=mGx9oQox9Po489OmHsWlMI6Vj8QO8GxdVuOZeG6l6wwpdyg9mRifirA7QcpuNINevLucah1epm1d
 OKPO0TTiDoi3y2eEK5Xho+SFy8prh78TQ8GX7rkvz70Zhgw6/aKU
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

During review of the CXL Event processing series[1] these minor fixes were caught
but I did not have time to respin before Jonathan picked them up.

Make the fixes now.

These are based on Jonathan's latest branch:

        https://gitlab.com/jic23/qemu/-/tree/cxl-2023-01-20

[1] https://lore.kernel.org/all/20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com/

To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>
Cc: Ben Widawsky <bwidawsk@kernel.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: <qemu-devel@nongnu.org>
Cc: <linux-cxl@vger.kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Ira Weiny (2):
      hw/cxl: Fix event log time stamp fields
      hw/cxl: Remove check for g_new0() failure

 hw/cxl/cxl-device-utils.c   | 15 +++++++++++++++
 hw/cxl/cxl-events.c         | 10 +++-------
 hw/cxl/cxl-mailbox-utils.c  | 11 +----------
 hw/mem/cxl_type3.c          |  1 -
 include/hw/cxl/cxl_device.h |  2 ++
 5 files changed, 21 insertions(+), 18 deletions(-)
---
base-commit: bb3f9b2853f9723c11a38c6b7bca7368677f2b43
change-id: 20230125-ira-cxl-events-fixups-2023-01-11-337953e87f5d

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>
