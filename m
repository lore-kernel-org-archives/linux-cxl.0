Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36232E7369
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jun 2026 02:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781750507; cv=none; b=h663Nk2I5AVUP4OE1SmApEJuKshfG3CF/+d2Yd9GoX40yMVBxtPO+m1hcuJpXJYV2lYYBSPSMLE8oB5YoGcIZyPvypGQxXCM4VEe+3wuZWUSnbR9rqRg+9phtRd7hT+uPgtHw1QvB8vh+CPkT6M0spG0P+kyNTq+1rYkng8Vunw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781750507; c=relaxed/simple;
	bh=YrwcpQ0WvBz/1+z3tCzmFwH0nCWHbcXLoQuFZ9YQf+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g2iP6rFoqm/jhIlFz0FDoVV+hujwjBx9/lNRMRom37P2BN499ekbugPNRUqodZHbRsQzXfFSxVMYmrSS+YZYop4Up1O+j84Q2amjdVLFSjqmMpIKVEsMiRha4GpO2ADjjt7pSdYIoj3OYsPXt/OJrxDNTIyQTGskAG74RaaGVqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=foIIT8Oj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="foIIT8Oj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781750506; x=1813286506;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YrwcpQ0WvBz/1+z3tCzmFwH0nCWHbcXLoQuFZ9YQf+Y=;
  b=foIIT8Ojx2ZvKXXgpOQo25f5yduqAQ5prENsdDQte8yUFw9v28citDLU
   2Hu3x+m9dY0lRyljSwgx8uGjXf4ezRhTSHcVx73qSjkO3NjtPVWkdo3qE
   2ICO6uiiN8sYjwqa0WA0tjDS9sLZBkTR4kyL+PcvRTLuUECUwnbwO4Q1M
   umgmtUTFxHXmq5CwJ9vXZ0XfmtebRH2+EcGOjYsHZJuboqOZHcsEzizUO
   MTFwTz5GfI2G6+CCTTdVHuc1E9C8e0czoKn7F4TESVCYoBoYzs3FnbWjg
   aHx2V5fQXu22raaaN/Y+awdCM28B4mNzTg12BE6BVxu4pkGsZwI7Ovt3n
   g==;
X-CSE-ConnectionGUID: uPLX+UNgRAyjycA9ZajEXQ==
X-CSE-MsgGUID: Zha26acoRauoO4yE7DnBfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="93229262"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="93229262"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 19:41:45 -0700
X-CSE-ConnectionGUID: U2DXYIQjTNO4ofBf2UTmfQ==
X-CSE-MsgGUID: SF09PBIgR5OaK1yi3UvOuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="245302087"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 19:41:43 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	qemu-devel@nongnu.org,
	qemu-stable@nongnu.org,
	linux-cxl@vger.kernel.org,
	Junjie Cao <junjie.cao@intel.com>
Subject: [PATCH] hw/cxl: Fix guest-triggerable QEMU exit on reserved interleave ways
Date: Thu, 18 Jun 2026 18:43:16 +0800
Message-ID: <20260618104316.557306-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A buggy or malicious guest can program a committed HDM decoder with a
reserved Interleave Ways encoding (e.g. 0x5-0x7, 0xb-0xf).  Two call
sites pass &error_fatal to cxl_interleave_ways_dec(), which calls
exit(1) on the reserved encoding before the subsequent decoded_iw == 0
guards can run:

  - cxl-host.c update_non_interleaved(): called at commit time from
    hdm_decoder_commit() via cfmws_update_non_interleaved(), so a guest
    writing COMMIT with a reserved IW terminates QEMU immediately.  This
    is the primary trigger on the current tree.

  - cxl_type3.c cxl_type3_dpa(): called on memory access while iterating
    past committed decoders to accumulate dpa_base.  Once the commit-time
    exit is removed, the decoder stays committed with the reserved
    encoding, so a later guest access outside that decoder's range would
    otherwise hit this second &error_fatal; both are fixed here.

Pass NULL instead of &error_fatal at both sites so that the reserved
encoding returns zero and the existing guards handle it gracefully.

This can be reproduced by writing the HDM Decoder 0 Control register
with a reserved IW encoding and the COMMIT bit set (e.g. IW=0x5,
COMMIT=1).

Cc: qemu-stable@nongnu.org
Fixes: 680935c9a6ff ("hw/cxl: Add a performant (and correct) path for the non interleaved cases")
Fixes: 48461825af1b ("hw/mem/cxl_type3: Fix potential divide by zero reported by coverity")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/cxl-host.c  | 2 +-
 hw/mem/cxl_type3.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 7e744312f1..768fdadc29 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -442,7 +442,7 @@ static int update_non_interleaved(Object *obj, void *opaque)
             }
         }
 
-        interleave_ways_dec = cxl_interleave_ways_dec(iw, &error_fatal);
+        interleave_ways_dec = cxl_interleave_ways_dec(iw, NULL);
         if (interleave_ways_dec == 0) {
             return 0;
         }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index cba05ec57d..102afa1a19 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1197,7 +1197,7 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
         }
         if (((uint64_t)host_addr < decoder_base) ||
             (hpa_offset >= decoder_size)) {
-            int decoded_iw = cxl_interleave_ways_dec(iw, &error_fatal);
+            int decoded_iw = cxl_interleave_ways_dec(iw, NULL);
 
             if (decoded_iw == 0) {
                 return false;
-- 
2.43.0

