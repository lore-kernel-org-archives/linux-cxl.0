Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FA7C61DA4
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Feb 2023 01:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjBCBF3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 20:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBCBF3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 20:05:29 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FB2470AE
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 17:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675386328; x=1706922328;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=i0lgQclJKjLSYx9sYkT+zi3xmA1ubm138VZr8tBJQP4=;
  b=W+BqYgwZppVVl8clXDdG8D8/HdBqXyYfT8pliuyBhyak8G11SZruiosR
   fNIFIX0U/W4VA2ePSuJI8G2VlKw2NoA4vtsPMsD8dEH96BgBzAdZ3EtCN
   vbR7O/gR6JcjRfzm+9MSroIYrM63nhwO2Ecn8JMI8SlKPHOO1/AK1bqT2
   cDCpK2dqinLbzog2OWcQhrQJkCi9qye+b5vBIvvnUJ3ZI4K9efEia3ayF
   5TSXxjvcyYQx19ml92n3K0cGPuNKyHW6lozeqiNdxJuCyhKxFkoUINuOP
   NtSRawsoaKL/y29ozxg5kqCdB74qeWjK5sXiHgV6y5oR+sHyCxFZgmK2L
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="393215312"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="393215312"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 17:04:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="839412540"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="839412540"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.229.82])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 17:04:36 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v4 0/4] CXL: Miscellaneous fixes
Date:   Thu, 02 Feb 2023 17:04:24 -0800
Message-Id: <20221222-cxl-misc-v4-0-62f701c1cdd1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJhd3GMC/3XNwQ6CMAwG4FcxOzsz2o0FT76H8bCNIktgmI0QD
 OHdHZyMkePf9uu/sETRU2LX08IiTT75IeQgzyfmWhOexH2dMwMBUAAAd3PHe58c1xWSAylBKsXy
 uTWJuI0muHYDvUkjxW3xitT4ee+4P3JufRqH+N4rp2Kb/vk+FVzwCiVaY4uSNNx8GKm7uKFn25M
 JjiBkWAop0DnUoPQvxCOIO6xlg4qkxeobruv6AYjOJJMrAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675386275; l=1327;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=i0lgQclJKjLSYx9sYkT+zi3xmA1ubm138VZr8tBJQP4=;
 b=lSy018R4XmKVGehGriJ4Dg7V6UUVwwq9HSgWbWFWhFXI3pF2cAUqg2W4/CIxnuo5hiIzneG7epd0
 7H9r+I1mDS77yS6dQu46jXdakU6PxM7sE5ZNx4/ub6sSdgZeXbYB
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
Changes in v4:
- Pick up tags from v3
- Jonathan: Add documentation for the flags
- Link to v3: https://lore.kernel.org/r/20221222-cxl-misc-v3-0-60d4f35e4b39@intel.com

---
Ira Weiny (4):
      cxl/mem: Remove unused CXL_CMD_FLAG_NONE define
      cxl/uapi: Add warning on CXL command enum
      cxl/uapi: Tag commands from cxl_query_cmd()
      cxl/mem: Fix UAPI command comment

 drivers/cxl/core/mbox.c      |  9 +++++++--
 drivers/cxl/cxlmem.h         |  1 -
 include/uapi/linux/cxl_mem.h | 30 +++++++++++++++++++++++++-----
 3 files changed, 32 insertions(+), 8 deletions(-)
---
base-commit: 22b8077d0fcec86c6ed0e0fce9f7e7e5a4c2d56a
change-id: 20221222-cxl-misc-793ec2442455

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>
