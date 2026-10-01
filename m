Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ED63BBFBF
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 04:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790830614; cv=none; b=aoXmuiT+go36CwDfxDMGYkmO3ih3nqzOgpkEN5p+Jo4VmN6qcaWDFMQavUE8VyOtH3/tNgSWfWxIlK/XXnVJ3ATGdnO5nPZFsUqKKmW6vbsMQzwKTEPyysKGNBLLEU1mmYwbFIKfyJ2AQB5n2eouA6GszokWbFxYYWdP2UTzV1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790830614; c=relaxed/simple;
	bh=ePv6Z8BwVqteDa6PlNYUgw5wuSh9vvrdGngpkiPVwYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOYB0Ve/f69ntn56aEZt1c3MxCcDI5ntAD70sBJoWW2XWB+67d+fnRydcPB1Mb77IoCePbbRcvhu4BUj/qcZFHLxl2WyU9VbDvOFuMFV1FMmJ9vG5Y9rhvTyeCFVqbsBGBgsQIBGHqOa6ePMfLcKXT60MknmGvWXg9eQxxr5tdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RrKvI2Hb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RrKvI2Hb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790830613; x=1822366613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ePv6Z8BwVqteDa6PlNYUgw5wuSh9vvrdGngpkiPVwYQ=;
  b=RrKvI2HbITa+4Jv1WBdT3LAjKxLxKXDFF51A11m9cwoJi9Oyc4MJlNGx
   /kVFGULK9/aQog8zc+Ba0y2y+Tv+J7XeHdtrrFY/RxaFW2ArDjjU4gVQp
   mOf98yhKJtltt/ZC/+B/EZWKyak0CjlySsyoHfFF+Q+Xbz+4mD5mzteuB
   DFrC4/tdpvPH98fNBlK8s5C9/6EV1e7AvB4We5OXxpXuWNpjojqI9JBeO
   2ofVhDztCxwhcmy7Ko26JhzKc2boGCVbgdVbXuw8BKA5XNIgmzJk0fiV+
   lXe77qy7/V/bsIhbKKV8Kz0c2mHQPIF2H+tZTluC0Gd/D9+Bn4zWRafUu
   Q==;
X-CSE-ConnectionGUID: Cb8tDKFvQbO675vLrAplMw==
X-CSE-MsgGUID: engu6nWfT1OESReVbwLB/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="101739093"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="101739093"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 21:56:52 -0700
X-CSE-ConnectionGUID: HGKcgumvQBqEqzoQ996ISw==
X-CSE-MsgGUID: Mh3DtwL6SPyHZytjnScY4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="279184339"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.57])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 21:56:52 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 2/2] cxl/Documentation: Describe clearing a region targetN position
Date: Wed, 30 Sep 2026 21:56:39 -0700
Message-ID: <a007c751d88ee64c9d0b7bb3c69a486c42358b36.1790829690.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <94e9157aac2e99df1251d733769d539b914fdefc.1790829690.git.alison.schofield@intel.com>
References: <94e9157aac2e99df1251d733769d539b914fdefc.1790829690.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The regionZ/target[0..N] ABI says a write to an occupied position fails
with EBUSY, but does not describe how to free the position. Clearing a
position is supported but undocumented, leaving no documented recovery
path after writing the wrong endpoint decoder.

Document how to clear a position.

Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 7352dbd70bc7..3b96b855961a 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -559,15 +559,20 @@ Description:
 		(RW) Write an endpoint decoder object name to 'targetX' where X
 		is the intended position of the endpoint device in the region
 		interleave and N is the 'interleave_ways' setting for the
-		region. ENXIO is returned if the write results in an impossible
-		to map decode scenario, like the endpoint is unreachable at that
-		position relative to the root decoder interleave. EBUSY is
-		returned if the position in the region is already occupied, or
-		if the region is not in a state to accept interleave
-		configuration changes. EINVAL is returned if the object name is
-		not an endpoint decoder. Once all positions have been
-		successfully written a final validation for decode conflicts is
-		performed before activating the region.
+		region. Write a newline to 'targetX', as 'echo "" > targetX'
+		does, to remove the endpoint decoder from that position, for
+		example to replace it with another decoder. Removing a target
+		from a committed region also decommits the region. It can be
+		committed again after all positions are filled. ENXIO is
+		returned if the write results in an impossible to map decode
+		scenario, like the endpoint is unreachable at that position
+		relative to the root decoder interleave. EINVAL is returned if
+		the object name is not an endpoint decoder. EBUSY is returned if
+		the position in the region is already occupied, or if the region
+		is not in a state to accept interleave configuration changes.
+		Once all positions have been successfully written a final
+		validation for decode conflicts is performed before activating
+		the region.
 
 
 What:		/sys/bus/cxl/devices/regionZ/commit
-- 
2.37.3

