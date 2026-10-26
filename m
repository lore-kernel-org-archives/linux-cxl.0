Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793031419;
	b=0EHLqnCU6hY6aTKyU2NBBVRB4hfHPrURj0y3EGjiuKq6DdlnqVnu/NovJ3hMsUbRUDse
	 UA1r/cMB/DjDiBJAiL6UjwucqsmXwLnkT4Su9R4Pe8ovECZOwJ8cMFmcHa2wHjPtv7VOG
	 /Et68tcHOERs09eQGonyUshryVBQPAwazjM3kLm+COmWSq4GuuAdyXxIo3sN+DUJoYsf+
	 4dqJPW7w5nK6Tcdig0FMIH4TDuGCfQ2F0FanD2/yFlJ1DQqbPhtUzlyt6KZDwTzHtv/hR
	 njv2DHEtgMYzACaiRIFXX4J4l4spW7a1XL7RehFV1pwKshaE1bsoTwsJ/Z4e2txm2BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793031419;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Bc5bORHRA/j4vUEOmzGxVyuHCFSd53oZN4DvDV9dj9Y=;
	b=QshJV7I4fXXnBkbEXujMXyJ1DhzkRPIXpvbL4QR+1CZ0Pq5bUkoc8k3Q1zZ8UelsxjgF
	 SS01gqBXN+X6+e64LcGXy/u1qBBglpQj8DYsOUJXgWPuftTIbjH5FAeneOwapsbeFNECY
	 pr++QVO6KjWc+wGZfD8RKmpSwYFbDUDS+DrQ08PxchMquJ0MO/kM66J7od4HyJLsA4frU
	 LPqZZZu/V/JFUXCrDvpqZsGWbXz9hbWv3YA2CCri3UAoUrZk+m+W2R4sTxkmacZbZphtR
	 o8dZi93+2hgkG1yLzXcZZpfIE/jkcGt7OS6+LxDr9Gwe4XaAMV91Icdl3WWPVJ0QhyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q2NtOKHm;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB02606A31E
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 16:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BB02606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q2NtOKHm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793031418; x=1824567418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/SPpw02xC0mbFR8LcHk5c5kU6pEG6zI70qyRT5Nswww=;
  b=Q2NtOKHmG4xBcn7PUkL0DfHeedaoeJwKxV/uadOa/bPaBbEuS96MI9nt
   t1kSqpjgG/BV6PwMADr+7HyE7kvR7whisZqWAUrP8gl/+kEHmC+EqeBQ3
   wANz1WFVHm1Yq+AdSTFyLHoS5TZvyH9TBvyftRIhga4tLNO7FeBlYeYGM
   KNjFnlzGKwaE2jbhZZwsCVXd5YxM1NDFWdOO0YxS+JJNXnBvAHDRqaRTc
   D43r4J1/27hDHuQuEh8Jb329D6VTkE3oirt9R5y8dKU5/qZ+N/O7Sb2B1
   qkJFHV79mnmlsemGRWAZsSffZ2rgYBMo67YOw8w0sgfo941kDNJitYH25
   g==;
X-CSE-ConnectionGUID: oAxg6LbxRUuTcuQSljxaNQ==
X-CSE-MsgGUID: aR9AxU0uQLKB8BKY1kvq8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1739132"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1739132"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 09:16:55 -0700
X-CSE-ConnectionGUID: XawLM3ZvRhq8w8MNBmaTSg==
X-CSE-MsgGUID: u2D4Rt2uQc2VIv6aBCQZ9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4214813"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.108.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 09:16:55 -0700
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
Subject: [PATCH v2 2/2] cxl/Documentation: Describe clearing a region targetN position
Date: Mon, 26 Oct 2026 09:16:50 -0700
Message-ID: <efa1a098550077dc3571796ba0102ddabe1e9b0d.1792989098.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <920d80735a449f93a1f17a8bca4c25e4b302cb42.1792989098.git.alison.schofield@intel.com>
References: <920d80735a449f93a1f17a8bca4c25e4b302cb42.1792989098.git.alison.schofield@intel.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The region targetN ABI documents that writing to an occupied position
returns EBUSY, but does not describe how to clear the position. Clearing
a position is supported but undocumented, leaving no documented recovery
path after writing the wrong endpoint decoder.

Document how to clear a position by writing an empty string, how clearing a
position decommits a committed region, and how the region can be committed
again after all positions are filled. Also clarify that writing the same
decoder to a position in a partially populated region succeeds without
changing the region.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
Changes in v2:
- Say that writing the endpoint decoder already at a position succeeds
- Split the entry into paragraphs and drop the v1 error code reordering

v1: https://lore.kernel.org/linux-cxl/a007c751d88ee64c9d0b7bb3c69a486c42358b36.1790829690.git.alison.schofield@intel.com/
---
 Documentation/ABI/testing/sysfs-bus-cxl | 31 ++++++++++++++++++-------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 7352dbd70bc7..83188d154549 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -559,15 +559,30 @@ Description:
 		(RW) Write an endpoint decoder object name to 'targetX' where X
 		is the intended position of the endpoint device in the region
 		interleave and N is the 'interleave_ways' setting for the
-		region. ENXIO is returned if the write results in an impossible
-		to map decode scenario, like the endpoint is unreachable at that
+		region.
+
+		To remove the endpoint decoder from a position, for example to
+		replace it, write an empty string::
+
+		  echo "" > targetX
+
+		Clearing a position in a committed region also decommits the
+		region. It can be committed again after all positions are
+		filled.
+
+		ENXIO is returned if the write results in an impossible to map
+		decode scenario, like the endpoint is unreachable at that
 		position relative to the root decoder interleave. EBUSY is
-		returned if the position in the region is already occupied, or
-		if the region is not in a state to accept interleave
-		configuration changes. EINVAL is returned if the object name is
-		not an endpoint decoder. Once all positions have been
-		successfully written a final validation for decode conflicts is
-		performed before activating the region.
+		returned if the position in the region is already occupied by
+		another endpoint decoder, or if the region is not in a state to
+		accept interleave configuration changes. EINVAL is returned if
+		the object name is not an endpoint decoder.
+
+		While the region is partially populated, writing the endpoint
+		decoder already at a position succeeds without changing the
+		region. Once all positions have been successfully written a
+		final validation for decode conflicts is performed before
+		activating the region.
 
 
 What:		/sys/bus/cxl/devices/regionZ/commit
-- 
2.37.3

