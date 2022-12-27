Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6933AC4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 27 Dec 2022 14:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiL0OwU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 27 Dec 2022 09:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiL0OwT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 27 Dec 2022 09:52:19 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1390D6D
        for <linux-cxl@vger.kernel.org>; Tue, 27 Dec 2022 06:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672152738; x=1703688738;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=thFlGy0LSMuS+GDri1Z9MxuGzPJW8edWotC7xdczrao=;
  b=QYoHwbFo3uJpUD/on75REVdViCjrOhTJ3JFyPTQ1rfZWzFzM2MoI2uNv
   vg49sq2tSOcTip745LKuISLjEEVsiZgqPVnneSRBi8Vq5OGPJMObcRMAb
   AyBdl4brF7ZkCLOFTC5u4U+cXQG2eP8U4SdbX3gyhwOWOicwRkbXAFY8b
   e8aOJMVQbzuGfPf2FlHc8XWpO8wXxjqt2gEderx9vspQQfoUNPa6gqVPY
   vTQn3QGSLWsrQ96Fw2bj9yb4WF/utKUvcS9KX/b4va5k+I+jWbPRtdMFy
   SPCq3cPt4muJt6e2QV4JWA+dAGoIAPkwUWQs2YFshaPYmxIChGlum+5UJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="300398210"
X-IronPort-AV: E=Sophos;i="5.96,278,1665471600"; 
   d="scan'208";a="300398210"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 06:52:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="777175357"
X-IronPort-AV: E=Sophos;i="5.96,278,1665471600"; 
   d="scan'208";a="777175357"
Received: from yguan1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.93.223])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 06:52:17 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 0/3] CXL: Miscellaneous fixes
Date:   Tue, 27 Dec 2022 06:52:09 -0800
Message-Id: <20221222-cxl-misc-v1-0-9343bab16e72@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJkGq2MC/x2NQQqDQAxFryJZG9A4Iu1ViosxjRqo05KICOLdH
 bt8/Pd5B7iYisOzOMBkU9dvylCXBfAc0ySo78xAFVFNRMj7Bxd1xu7RCFMIFNoWsj5EFxwsJp7v
 wxJ9FbuHn8mo+7/x6s/zAnvlCvRzAAAA
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.11.0-dev-e429b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1672152737; l=837;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=thFlGy0LSMuS+GDri1Z9MxuGzPJW8edWotC7xdczrao=;
 b=7ELQko2yvnhF0/UOL8YCvQf0e965H2ek9fSZ7OWsTAJ/hui7aQgoQm3w15przoYMgAkmKtO8C6RI
 gtSYLJtHAZq343/lSWgb6Yl1Dw/11RbyUsN4lAenXwTgwa8qLmhr
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

These are minor fixes I have seen along the way in the CXL code.

To: "Dan Williams" <dan.j.williams@intel.com>
Cc: "Jiang, Dave" <dave.jiang@intel.com>
Cc: "Alison Schofield" <alison.schofield@intel.com>
Cc: "Vishal Verma" <vishal.l.verma@intel.com>
Cc: "Ben Widawsky" <bwidawsk@kernel.org>
Cc: linux-cxl@vger.kernel.org
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Ira Weiny (3):
      cxl/mem: Fix command comment
      cxl/mem: Remove unused CXL_CMD_FLAG_NONE define
      cxl/uapi: Add warning on CXL command enum

 drivers/cxl/cxlmem.h         |  1 -
 include/uapi/linux/cxl_mem.h | 10 +++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)
---
base-commit: 8395ae05cb5a2e31d36106e8c85efa11cda849be
change-id: 20221222-cxl-misc-793ec2442455

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>
