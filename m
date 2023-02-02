Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D506AC05027
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Feb 2023 01:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjBBBXi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Feb 2023 20:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjBBBXg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Feb 2023 20:23:36 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C56369B0E
        for <linux-cxl@vger.kernel.org>; Wed,  1 Feb 2023 17:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675301009; x=1706837009;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=LRYcLtvysL6Aq0s3itX1UIXZNIA46Bms8RilFwOKako=;
  b=NCfeC7VjOyphO9uy3+S2DAdiZbk1MUZiWgdmT6JA3AIiu7Ji0xAxxKVh
   qjs77Kj/U2oAZz3PlVG4ejI7WGHNEHDax6b1qE++sCUF2Z2fsbrjcd2Ps
   q7ZFe2TUexsjGYqHeRdi7Uf37C5ko9CR0t0HlSrrACm6/a6igkMRK1i+2
   WqYKg3sb1NgKUxmiDocW7oydyTH/y8pjrcgjKwQCcmPyYVCmQDEnfMQbC
   nb7frB/ULFTZDIH17NprDZynEvd1jX20iD5lxoLpEQu7aCIsjKNBaDzVU
   Fu6qZA2RrFaoghK9hOguZPqPWpQ0KLQO4N2tSXVosiM+qWJoIZt6Aaykj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="308661519"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="308661519"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 17:23:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="993888765"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="993888765"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.15.11])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 17:23:28 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v3 0/4] CXL: Miscellaneous fixes
Date:   Wed, 01 Feb 2023 17:23:10 -0800
Message-Id: <20221222-cxl-misc-v3-0-60d4f35e4b39@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH4Q22MC/3WNQQ7CIBBFr2JYi4GBltSV9zAuAEc7SUsNNKSm6
 d2Frlzo8s389//KEkbCxM6HlUXMlGgKBdTxwHxvwxM53QszEAASALhfBj5S8tx0Cj1oDbppWIk7
 m5C7aIPvqzDaNGOsj1fEBy37xvVWuKc0T/G9T2ZZrz/as+SCd0orZ51s0cCFwozDyU8jqyUZ/ol
 QxFZoobxXBhrzLW7b9gGBoNgk8gAAAA==
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.11.0-dev-e429b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675301007; l=1332;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=LRYcLtvysL6Aq0s3itX1UIXZNIA46Bms8RilFwOKako=;
 b=o72u2a2aETO4BMxRn13b8YWhlSL/L2efLnNiRSQBX+s3Z4IjPLjlwlmvH3fGK3nF8hE4tWRTfkYU
 ZK6Kf/dYC0nlIfs1hcPe5U2oZn64tXvfBvlqPVAoPYOs4FrcsP6A
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

These are minor fixes I have seen along the way in the CXL code.

This includes fixing the query command to account for kernel exclusive and
enabled commands.

To: "Dan Williams" <dan.j.williams@intel.com>
Cc: "Jiang, Dave" <dave.jiang@intel.com>
Cc: "Alison Schofield" <alison.schofield@intel.com>
Cc: "Vishal Verma" <vishal.l.verma@intel.com>
Cc: "Ben Widawsky" <bwidawsk@kernel.org>
Cc: Robert Richter <rrichter@amd.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes in v3:
- Pick up tags from v2
- Dan : Return flags to user space rather than masking commands
- Link to v2: https://lore.kernel.org/r/20221222-cxl-misc-v2-0-60403cc37257@intel.com

---
Ira Weiny (4):
      cxl/mem: Remove unused CXL_CMD_FLAG_NONE define
      cxl/uapi: Add warning on CXL command enum
      cxl/uapi: Tag commands from cxl_query_cmd()
      cxl/mem: Fix UAPI command comment

 drivers/cxl/core/mbox.c      |  9 +++++++--
 drivers/cxl/cxlmem.h         |  1 -
 include/uapi/linux/cxl_mem.h | 15 +++++++++++----
 3 files changed, 18 insertions(+), 7 deletions(-)
---
base-commit: 22b8077d0fcec86c6ed0e0fce9f7e7e5a4c2d56a
change-id: 20221222-cxl-misc-793ec2442455

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>
