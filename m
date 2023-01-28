Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6823C54EAA
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 00:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjA1AK2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 19:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjA1AK0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 19:10:26 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EC41CF70
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 16:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674864602; x=1706400602;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=nQEnfGFmMlrEo9aAfJjnmykn9EiD2kxw7N59r0ZJRxM=;
  b=mFN05lE9UM0wOzHAibPcFctbPWUvcKTR0pwKEGclMu/T19wRD/WPK3x4
   jH0GkGoR/ghJV2hZ0CTqVLCBShNUMP72nJpcl90IAL9EiQCsmBoTozFlh
   Sw2WmskgY854zNf/mjZ+ZODRrmVqZW1Srb0fKbYgMcjrqR/Cp3AJB5NMk
   +Qvh3pNv2KVX9j+MygN8j9PpXi7+gw5OghX34LiyVo0MyfcEmTWGUbVFD
   /grGGSWl7b5DKAWIkTCEgWT1fYIWaMFhfG23eY+YW3aXAP2DWkEJEfqFC
   cQZs7Au+LgMZvS9CZROWqd4k1AemPFWFJVTwCitDLj8r9EaBwA5KrSfe6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="389608217"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="389608217"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 16:09:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="656793045"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="656793045"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.64.226])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 16:09:44 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 0/4] CXL: Miscellaneous fixes
Date:   Fri, 27 Jan 2023 16:09:38 -0800
Message-Id: <20221222-cxl-misc-v2-0-60403cc37257@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMJn1GMC/22NSw6CMBCGr2Jm7Rg6FAmuvIdh0dZRJoFiOoRgC
 He3sHb5/c8VlJOwwu20QuJZVMaYgc4nCJ2Lb0Z5ZgYqiAwRYVh6HEQD1k3JgawlW1WQ494po08u
 hm4vDE4nTrvxSfyS5fh4tJk70WlM3+NyNrv6Z302WGBT2tI7b65c013ixP0ljAO027b9AHkd0ly
 5AAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674864584; l=1374;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=nQEnfGFmMlrEo9aAfJjnmykn9EiD2kxw7N59r0ZJRxM=;
 b=t/yJCbtH/y9c+2QaCUCZhEaRgi7lSxoYMLAljMPV4oSiq3CW8bJAevtn6ux1nghqkpZHMrQdeG+s
 pXeYfodRBPUaY+3JxiAkHlg9Zww6rYUARWz4wZIknmukTxnstcc4
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
Changes in v2:
- Add checks for kernel exclusive and enabled commands to query before fixing
  the comment
- Link to v1: https://lore.kernel.org/r/20221222-cxl-misc-v1-0-9343bab16e72@intel.com

---
Ira Weiny (4):
      cxl/mem: Remove unused CXL_CMD_FLAG_NONE define
      cxl/uapi: Add warning on CXL command enum
      cxl/uapi: Only return valid commands from cxl_query_cmd()
      cxl/mem: Fix UAPI command comment

 drivers/cxl/core/mbox.c      | 35 ++++++++++++++++++++++++++---------
 drivers/cxl/cxlmem.h         |  1 -
 include/uapi/linux/cxl_mem.h | 11 ++++++++---
 3 files changed, 34 insertions(+), 13 deletions(-)
---
base-commit: 1fe4fd6f5cad346e598593af36caeadc4f5d4fa9
change-id: 20221222-cxl-misc-793ec2442455

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>
