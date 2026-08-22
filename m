Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B7438AC78
	for <linux-cxl@vger.kernel.org>; Sat, 22 Aug 2026 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385916; cv=none; b=fgwscB7EkVJvxpA9gBtJ9GJpyuNcv/6DKWWGB9/6ggXgQM2rh8mIWnUlch4X17qR32XNKAT5iGbarbB9eGtJFYqHrhg1RcfHQhpHRAcvwiB17VBEtS0QROL51QFoSmBZDUhXZXM0QnavjYT9pxj5MZbrA3ttPXPFxpbFFx6qyrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385916; c=relaxed/simple;
	bh=ZQTpR5m2HYemScE6+fxCLUrN5DDI2sT+aIhkpWEB6dM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iW2/h/6NGJz/p3I0H1CNEnuCcj04wUnhdD6RP2omrIcs/iAOXtabnC+veqtLu3Uz+85pEFLJB8NVQHgjOg0yaap42SPPIwumruJFGQCJSBeOACy20ZOrxi169cQTRvZJ7cKvqFp2kokGFJzt4WdRHrTLrOIMAHOGyWD/BEQ7Hsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LgbTstjU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgbTstjU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787385915; x=1818921915;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZQTpR5m2HYemScE6+fxCLUrN5DDI2sT+aIhkpWEB6dM=;
  b=LgbTstjUX0C9PwrVIhO4ThuDDCpmCtPfbra9i8XmmA3yoaJalp4RJKFn
   BmvLkvXIHsofAtNe80qUZA+GFUQQk/u12Zp3hxz/QxBjIznlTCSDqt6f6
   nGs1FabgW1glwDDVqipubQVgskOK9b8jgwD+ZXUCOulaNBPnpGiXYjtnV
   Qwa0q+sMCkF73sJGsV7mzlbPO3A+bKqbdbH5mwIDK+R/KKzaSwUcEXwzp
   nTc0sq4iANwCYbpLmfqrk4g40gzcNzTg4aN7z1NUzGDFH/LTp56xzYhJY
   CfDDtRBgFadicea6sDqNfDEtf/T+oy3Y3ftPvzUZKU7PGv3uVJiqM5iex
   A==;
X-CSE-ConnectionGUID: FAnXS+BSTZC3bTNF+anGUA==
X-CSE-MsgGUID: HLv3u/7wQ/eWFNZJSIWD5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91796016"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="91796016"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2026 01:05:15 -0700
X-CSE-ConnectionGUID: 0ydaDvUJS3WXKU+NoTnpBw==
X-CSE-MsgGUID: Y8FloF0nTMKA/9UkbFQ9Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="265239305"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2026 01:05:13 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	linux-cxl@vger.kernel.org,
	qemu-stable@nongnu.org
Subject: [PATCH] hw/cxl: Fix heap buffer overflow in Set Feature cleanup path
Date: Sat, 22 Aug 2026 16:05:08 +0800
Message-ID: <20260822080508.300921-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cmd_features_set_feature() uses set_feat_info->data_size as the memset
length when zeroing write-attribute buffers on Finish/Abort.  data_size
accumulates bytes_to_copy across transfer parts but is only reset on
INITIATE.  Since QEMU never returns Feature Transfer Out of Order,
repeated transfers at the same offset grow data_size past sizeof(struct),
and the final memset overflows the target buffer.

b71a179148 bounded the per-transfer memcpy against sizeof, but the
cleanup memset still runs on the accumulated data_size, so the overflow
survives that fix.

Pass sizeof() of the target struct to memset instead of data_size.

Fixes: d88f66741410 ("hw/cxl/cxl-mailbox-utils: Add device patrol scrub control feature")
Fixes: 2d41ce38fb9a ("hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS control feature")
Fixes: 5e5a86bab830 ("hw/cxl: Add support for Maintenance command and Post Package Repair (PPR)")
Fixes: da5cafdc4ddd ("hw/cxl: Add emulation for memory sparing control feature")
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/cxl-mailbox-utils.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ec18338b42..f81b7b3303 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1947,22 +1947,28 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         data_transfer_flag ==  CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER) {
         memset(&set_feat_info->uuid, 0, sizeof(QemuUUID));
         if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
-            memset(&ct3d->patrol_scrub_wr_attrs, 0, set_feat_info->data_size);
+            memset(&ct3d->patrol_scrub_wr_attrs, 0,
+                   sizeof(ct3d->patrol_scrub_wr_attrs));
         } else if (qemu_uuid_is_equal(&hdr->uuid, &ecs_uuid)) {
-            memset(&ct3d->ecs_wr_attrs, 0, set_feat_info->data_size);
+            memset(&ct3d->ecs_wr_attrs, 0, sizeof(ct3d->ecs_wr_attrs));
         } else if (qemu_uuid_is_equal(&hdr->uuid, &soft_ppr_uuid)) {
-            memset(&ct3d->soft_ppr_wr_attrs, 0, set_feat_info->data_size);
+            memset(&ct3d->soft_ppr_wr_attrs, 0,
+                   sizeof(ct3d->soft_ppr_wr_attrs));
         } else if (qemu_uuid_is_equal(&hdr->uuid, &hard_ppr_uuid)) {
-            memset(&ct3d->hard_ppr_wr_attrs, 0, set_feat_info->data_size);
+            memset(&ct3d->hard_ppr_wr_attrs, 0,
+                   sizeof(ct3d->hard_ppr_wr_attrs));
         } else if (qemu_uuid_is_equal(&hdr->uuid, &cacheline_sparing_uuid)) {
             memset(&ct3d->cacheline_sparing_wr_attrs, 0,
-                   set_feat_info->data_size);
+                   sizeof(ct3d->cacheline_sparing_wr_attrs));
         } else if (qemu_uuid_is_equal(&hdr->uuid, &row_sparing_uuid)) {
-            memset(&ct3d->row_sparing_wr_attrs, 0, set_feat_info->data_size);
+            memset(&ct3d->row_sparing_wr_attrs, 0,
+                   sizeof(ct3d->row_sparing_wr_attrs));
         } else if (qemu_uuid_is_equal(&hdr->uuid, &bank_sparing_uuid)) {
-            memset(&ct3d->bank_sparing_wr_attrs, 0, set_feat_info->data_size);
+            memset(&ct3d->bank_sparing_wr_attrs, 0,
+                   sizeof(ct3d->bank_sparing_wr_attrs));
         } else if (qemu_uuid_is_equal(&hdr->uuid, &rank_sparing_uuid)) {
-            memset(&ct3d->rank_sparing_wr_attrs, 0, set_feat_info->data_size);
+            memset(&ct3d->rank_sparing_wr_attrs, 0,
+                   sizeof(ct3d->rank_sparing_wr_attrs));
         }
         set_feat_info->data_transfer_flag = 0;
         set_feat_info->data_saved_across_reset = false;

base-commit: af06b5df2610fe5de6c02d17c17bced9e9f0d47d
-- 
2.43.0

