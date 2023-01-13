Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD31C54EBE
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 17:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjAMRaU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 12:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjAMR3n (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 12:29:43 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B10A88A2B
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 09:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673630307; x=1705166307;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=czDPd7cRgkAhGvDLUHzw8TzbNVK7GhsXxCrOpxgVpjI=;
  b=nxSXqmK03MD5h+eGMAyeg2B+ExsOyg0uVljqHDtjCx9Wk+idp3gehR7R
   +Qk9LLYj+xI9XNpeVFAlk3hqieC0EBqM9g45pwlMCwz0FCcDfSXuuJ5G8
   SZ8Z6+VpylXjQSGaZC2laYp1mxCqAfoV8/yakqzd92xxi8HlGVdYaJ8H3
   rdxLY0b1ops7lnO05kgmGNGGI/oFpqDksIEGGXT//muLgIhJ3YxRnryJD
   AK4CBS0bO9ym6ecGl/DdgphKFpMreBbRgPJUoTF+Hfmnj0NU3PNMmvqev
   eub7nDhZDe/IHBKPqri9lTD8frvhqjI3nw9WCMMhg3QUUrkNtIeVAREht
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="326103487"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="326103487"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:16:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="903626543"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="903626543"
Received: from ajlopez1-mobl.amr.corp.intel.com (HELO vverma7-desk1.local) ([10.212.14.206])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:16:28 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Fri, 13 Jan 2023 10:16:21 -0700
Subject: [PATCH ndctl] test/cxl-xor-region.sh: skip instead of fail for
 missing cxl_test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230112-vv-xor-test-skip-v1-1-92ddc619ba6c@intel.com>
X-B4-Tracking: v=1; b=H4sIAOWRwWMC/x2NywqEMAwAf0Vy3kBbH4f9lWUP1UYNQiyJFEH89
 617HIZhLjBSJoN3c4FSYeNdKvhXA9MaZSHkVBmCC63zPmApeO6KB9mBtnHGNlI398kNPXVQszE
 a4ahRpvUJM0liWR6TlWY+/7PP975/c/kp23wAAAA=
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.12-dev-78c63
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=czDPd7cRgkAhGvDLUHzw8TzbNVK7GhsXxCrOpxgVpjI=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDMkHJ76RuuEQ9WqrclDckoMnd8/ZlPxp6pUX8yZ7Lwyu2qPy
 53zht45SFgYxLgZZMUWWv3s+Mh6T257PE5jgCDOHlQlkCAMXpwBMxHY9w//EA6nqJwRNpjD1+F7/M6
 tzV3Zi7g9m0dz51rWmZxZ0CXoxMryqWa7+NjOs9rbVjFq52d9u98vq5NVOjZnRKxuWdDBIgR8A
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Fix cxl-xor-region.sh to correctly skip if cxl_test is unavailable by
returning the special code '77' if the modprobe fails.

Link: https://github.com/pmem/ndctl/issues/229
Fixes: 05486f8bf154 ("cxl/test: add cxl_xor_region test")
Cc: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 test/cxl-xor-region.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/cxl-xor-region.sh b/test/cxl-xor-region.sh
index 5c2108c..1962327 100644
--- a/test/cxl-xor-region.sh
+++ b/test/cxl-xor-region.sh
@@ -4,7 +4,7 @@
 
 . $(dirname $0)/common
 
-rc=1
+rc=77
 
 set -ex
 
@@ -15,6 +15,7 @@ check_prereq "jq"
 modprobe -r cxl_test
 modprobe cxl_test interleave_arithmetic=1
 udevadm settle
+rc=1
 
 # THEORY OF OPERATION: Create x1,2,3,4 regions to exercise the XOR math
 # option of the CXL driver. As with other cxl_test tests, changes to the

---
base-commit: b73e4e0390aae822bc91b8bf72430e6f0e84d668
change-id: 20230112-vv-xor-test-skip-3ae4f5d065e4

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

