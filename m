Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gFzeXnYt"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCC310C6;
	Fri, 17 Nov 2023 17:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700270073; x=1731806073;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KY6Trv4Z4Ss7v75GlFvhDLJZq876VbvgUNG6vb3DWIM=;
  b=gFzeXnYtXbjujeTjB6gX5FivL0L7eIpuJZvHETJsDJeP7zA/40WyKDCV
   hndJP5ouy1wCCL20QRpv1cdkqU6vTGzrp1w15sExF0ehs6YURAvbdXGTE
   Sxvi8FTparggQCslUevKnOpOdLS+0Xlwd/tIg0qqd3x8u7MtLLWH/DNpI
   +wzfyX2Iv8Pfxk1dprR2nIKXO9gsvyIKDQPY3Zj7syqK0TgqFKY8DH4RF
   fH/mC5KmnfTkTdgfGdZ+eLeXm7COXKc5Qcw9WMJ7J4KwQ7/Entiv5d93K
   1VfkECdcs1d9GkhOMXq/lA8kG3xrh5uGRfiuY8wXcueLXIUhI0YCMHwgI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="390256200"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="390256200"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 17:14:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="889406632"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="889406632"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.174.178])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 17:14:32 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 17 Nov 2023 17:14:22 -0800
Subject: [PATCH 2/2] cxl/cdat: Fix header sum value in CDAT checksum
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231117-fix-cdat-cs-v1-2-ffc2b116ca6c@intel.com>
References: <20231117-fix-cdat-cs-v1-0-ffc2b116ca6c@intel.com>
In-Reply-To: <20231117-fix-cdat-cs-v1-0-ffc2b116ca6c@intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Fan Ni <nifan.cxl@gmail.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700270069; l=1439;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=KY6Trv4Z4Ss7v75GlFvhDLJZq876VbvgUNG6vb3DWIM=;
 b=jqARDpOM2gS8EEBlFN8o2CMOCfoDHYZeJn8FlrS/jOBezFk9NeTm3Ih2OGwCpc9eqw4o6Ot6H
 sFV4Ip8Qwq5DcoH5VG9rx9ZA6g71CcZmoBxyXb7bMpnPabn40NVNd1X
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The addition of the DCD support for CXL type-3 devices extended the CDAT
table large enough that the checksum being returned was incorrect.[1]

This was because the checksum value was using the header length field
rather than each of the 4 bytes of the length field.  This was
previously not seen because the length of the CDAT data was less than
256 thus resulting in an equivalent checksum value.

Properly calculate the checksum for the CDAT header.

[1] https://lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 hw/cxl/cxl-cdat.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
index 24829cf2428d..d93e2e4e64f2 100644
--- a/hw/cxl/cxl-cdat.c
+++ b/hw/cxl/cxl-cdat.c
@@ -95,8 +95,15 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
     /* For now, no runtime updates */
     cdat_header->sequence = 0;
     cdat_header->length += sizeof(CDATTableHeader);
-    sum += cdat_header->revision + cdat_header->sequence +
-        cdat_header->length;
+
+    do {
+        uint8_t *buf = (uint8_t *)cdat_header;
+
+        for (i = 0; i < sizeof(*cdat_header); i++) {
+            sum += buf[i];
+        }
+    } while (0);
+
     /* Sum of all bytes including checksum must be 0 */
     cdat_header->checksum = ~sum + 1;
 

-- 
2.41.0

