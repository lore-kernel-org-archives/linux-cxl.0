Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9260E1397
	for <linux-cxl@vger.kernel.org>; Sat,  8 Aug 2026 00:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147559; cv=none; b=RRupHflAU9ICZuSXuFQapzWnSnWcJa/u8Ifhval86CDdT5YZ/I+0y6o3tr8WM45JmCdpWelU/CtD2dkSsZT1vncyVYI0jSeIbOLKhXY34NhaMLvxb7joTOBN6fvlczW92CfTgjp9uXYSqr+uIcUt3gjzx1fat7jdIs6PiEJ6mfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147559; c=relaxed/simple;
	bh=+udYoT2FSdYbPhjRZ6OMig6daxUEE95sjj44VauyutA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tsZZZNQ431SRm3z0md/H+m0k2mc4PyYj6LIsVQHycpJQ7b2lPAOL5FL8Dsg9CmzyyleOQbnUoDIZJa/z88tSqYvlap0FawLolvq40uMHnD340fz4NN1ySPjHODNYkkpzxr2F9DNwEjkQ1EcC1239rQMsHsto6CmqRYB9lH3stbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CjmJsB6H; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CjmJsB6H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786147558; x=1817683558;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+udYoT2FSdYbPhjRZ6OMig6daxUEE95sjj44VauyutA=;
  b=CjmJsB6Hf1UipYnqlUfI9pYZcVoomoENgzJtMmXQFWMbxdFOsEZEqlx+
   9yskqGijzEkqfdBs3j2XQJ41gwOY+5xTjGsEUnSEXhe5smHVsq2JzS5Qt
   aj1iUNskNSVyEZdcJPRBitZrxa7n9I04qQFIOHJOW82MQkf1r53Th5yY/
   tEZFCvxJEletLwPQqoyirvXFB00YwpZoVPBZi9o2Hu1rY9LJzsOxrM5sW
   /H/nmdvIvw/3f10DV9YA5xuvh84J4EFPm8LItvZj3n8+zxOfjfGlsHjUE
   HP4otFoKwVLMXdw0ETlZ5h26md5BiiNyOf/SxhjTW1RF4XbHYMvA76Abu
   Q==;
X-CSE-ConnectionGUID: 6wZy18XZRxelIaZGVyMfZg==
X-CSE-MsgGUID: S7mFFFqhRdept0DoLTBEJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="90441172"
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="90441172"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 17:05:58 -0700
X-CSE-ConnectionGUID: ECXTssFpRCWmufz2LGQsEg==
X-CSE-MsgGUID: gW61cb/TTJaf0zs617oEcg==
X-ExtLoop1: 1
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.80])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 17:05:56 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v5 0/4] Harden HDM decoder enumeration
Date: Fri,  7 Aug 2026 17:05:47 -0700
Message-ID: <cover.1786143520.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v5:
Drop P2 of v4 as it changed what user sees in iw and ig attributes (Davidlohr)
Renumbering: v4 P3 and P4 are now P2 and P3
P1: Validate the target count once per port, not per decoder (Jonathan)
P1: Move the zero-target reject back to cxl_switch_decoder_init() (Ming)
P1: Drop the ways reset for uncommitted decoders (Jonathan, Davidlohr)
P1: Declare cxlsd on one line (Jonathan)
P1: Reword the CXL_HDM_DECODER0_TL_TARGETS comment (Jonathan)
P2: Build the target IDs with put_unaligned_le32() (Jonathan)
P2: Dropped all the tags on endian-ness patch
P3: Commit log s/none committed/uncommitted/ (DaveJ)
P4: New - bound switch decoder target array walks by nr_targets

Changes in v4:
A new patch was inserted as Patch2, so now set is 4 patches.
   Sashiko is likely to complain in Patch 1 for something fixed in
   Patches 2 and 3, but reordering does not makes sense.
P2: Only interpret interleave settings on committed decoders (Ming)
    This is the newly inserted patch
P4: Register reset w devm_add_action (Ming)
P4: Fix up a kernel-doc comment issue (lkp)

Changes in v3:
P1: Move zero-target reject to init_hdm_decoder() (RichardC)
P3: Reset commit_end via a devres action after decoder teardown (RichardC)

Changes in v2:
P1: Handle uncommitted decoders (Sashiko)
P1: Reject switch decoders with zero targets (Sashiko)
P1: Add in code comment clarifying target_count (Sashiko)
P1: Update commit log
P3: Reset commit_end on the failure path only (Sashiko)
P3: Update commit log
P2: No


This set started as Sashiko reported cleanups. The patch added at v4 on
Li Ming's review is dropped in v5. Davidlohr pointed out that it changes
what interleave_ways and interleave_granularity report for an uncommitted
decoder, and those are documented ABI. That is also the answer to Ming's
v3 question that prompted the patch -  enumeration decodes those fields
because userspace reads them, not because the driver needs them.

Only the first patch includes a link to the original Sashiko complaint,
since the others did not originally appear on Lore for me to add public
links.

Srirangan: I believe some of these patches address pre-existing issues
Sashiko posted in reply to your reset series, but frankly, with the
renumbering here, and the respin of your series, I no longer have 
the exact patch to patch correlation.
Alison Schofield (4):
  cxl/hdm: Reject switch decoder interleave ways that overflow targets
  cxl/hdm: Make switch decoder target parsing endian-safe
  cxl/hdm: Restore commit_end when decoder enumeration fails
  cxl/port: Bound switch decoder target array access by nr_targets

 drivers/cxl/core/hdm.c  | 62 +++++++++++++++++++++++++++++++++--------
 drivers/cxl/core/port.c | 27 ++++++++++++------
 drivers/cxl/cxl.h       |  2 ++
 3 files changed, 72 insertions(+), 19 deletions(-)


base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.37.3

