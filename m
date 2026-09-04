Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E7D37BE75
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 03:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788492101; cv=none; b=tXgeTSuBx+Vkx8p/HhpX4UEGCPikvGAVNHQ2tHvVtSmkAx88h1yH1qFDS+2EUTY5s4xA+1G2fzzRmH+PPPzf/ulHl4UeQ0rjJ3EaGTlf54grvoOeRDarJGhGsbOzZLuNcfB/YOWmqULTgfwoBBBeLEtdC4uaxSdTRsDviRhOOAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788492101; c=relaxed/simple;
	bh=gt0BCbnOoZowYWJ3ZL5LfqStZ49YQy8ASCtkgQtT4Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYQN8AdDMcKdrfgkVPZRBQVtQpRmE6ADtOURfh6VhZktUF3RevgUrvGsOMaf1M3Y0SGVc6XEtmGGdbXtnJNVbn+8Cbglhx/0GK0Vi/X/dd+EU8fKadETASKFVKxdaNxYUXveF4HAVO6oBM5urvJnXpLeiXYJMRAoA5DQTvM8kH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UoeKuoQ8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UoeKuoQ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788492099; x=1820028099;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gt0BCbnOoZowYWJ3ZL5LfqStZ49YQy8ASCtkgQtT4Sw=;
  b=UoeKuoQ8TLvD4OQAe8Zxl/70g9ip6qfiM2Pn3RNK+cWCVFWAiJRtEG7e
   7rH7aGSzrUxpTOcGZcJxB/BlhS78gzG/Fikk20c1QUYsdQekJShYUJUa+
   oQB5a7TKqG/T9+fIKCNdZtxDCKowJjTZu+fah6saq/oNL0YmuXeqxM6VZ
   awj3zF41Tw4JGp22ydqY/+oLx6d3sgVpqugm4SZJ6wgleZ6ivVJpkPKhF
   /lIKIQiiB46qVmCE91zx/OB4lLcABjlkRb9RN+XhJLP7uxmIWKLPLQCXX
   Y8p4f5eIL2s9beK9yRubwXqAQoUI61gPtFt0ONz1GYZFhAM/oskG9dXeZ
   Q==;
X-CSE-ConnectionGUID: 67C8OOYyTaONvvau+m6xUg==
X-CSE-MsgGUID: h+kuGyMuSii2j+XPg3bC5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92859848"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92859848"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 20:21:39 -0700
X-CSE-ConnectionGUID: Lzz4tBxKRsahD9alqBDvEA==
X-CSE-MsgGUID: iywJOWZ0Rba9FavXy+3C0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="275194910"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.10])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 20:21:38 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 0/2] cxl: Allow passthrough decoders with >16K granularity
Date: Thu,  3 Sep 2026 20:21:31 -0700
Message-ID: <cover.1788487020.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


I kept RichardC and DaveJ tags as the helper is a mechanical refactor,
not a behavior change. More/re-review is welcome.

Changes in v4:
- Rebase on Linux 7.3-rc1
- Rename Patch 1 to focus on the region config failure that user sees
- Use Reported-by and Closes tags instead of Suggested-by in Patch 1
- Add and use a new granularity_is_valid() helper (RichardC)
- Update the Patch2 commit log to say computes 8K, not 16K (RichardC)
Link to v3:
https://lore.kernel.org/linux-cxl/cover.1784940306.git.alison.schofield@intel.com/

Changes in v3:
- Program the real IG encoding for an encodable non-interleaving granularity
  instead of always writing EIG=0 (RichardC, Sashiko)
- Update Patch 1 commit msg text and this cover letter text per above change
Link to v2:
https://lore.kernel.org/linux-cxl/cover.1783795720.git.alison.schofield@intel.com/

Changes in v2:
- Rebased on Linux 7.2-rc1
- Only v1 feedback was from Sashiko and that was not an issue
Link to v1:
https://lore.kernel.org/linux-cxl/cover.1781136281.git.alison.schofield@intel.com/

Begin Cover Letter:
Sashiko reported [1] that region creation fails when the interleave
granularity accumulated below the root decoder exceeds the 16K maximum
encodable in the interleave granularity (IG) field. The decoder that
computes that granularity is a passthrough decoder, which does not consume
the IG field, so no decoder in the path interleaves at the granularity
being rejected.

The first patch avoids validating the interleave granularity of
non-interleaving decoders, encodes the IG field as a don't-care only when
the computed granularity is not encodable, and updates the sysfs ABI
documentation accordingly.

The second patch extends cxl-test with a topology that allows a CXL unit
test to cover this case.

A unit test update for this case is posted for review [2].

[1] https://lore.kernel.org/all/20260530002613.682E71F00893@smtp.kernel.org/
[2] https://lore.kernel.org/nvdimm/cover.1788489571.git.alison.schofield@intel.com/


Alison Schofield (2):
  cxl/region: Allow regions with an unencodable passthrough granularity
  cxl/test: Add a 2-way 16K root decoder for passthrough testing

 Documentation/ABI/testing/sysfs-bus-cxl |  5 ++-
 drivers/cxl/core/hdm.c                  |  8 ++++-
 drivers/cxl/core/region.c               | 34 ++++++++++--------
 tools/testing/cxl/test/cxl.c            | 48 +++++++++++++++++++++++--
 4 files changed, 76 insertions(+), 19 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.37.3

