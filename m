Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725639;
	b=HlBGxtlWeMDUDUc9eiZT/mHbNa/q+ig9wJdQ9M95NnGin8DG5mDxZVkH9E3+v5l9kcOl
	 a1JCbyDbAeQWFqtRIAbCqaLDnbuPKtTREeGDNDVgrexpkliqp1xW3TNODcVjWKUpcWdZc
	 IljmylHqsjwgYo8O+Z1co8Z/vn7NtRoQhttLOhfjwm0cKpgXLPYNE2/8mhm7SPJ4ytzt8
	 qvxoiBCCKu3v0+C+8bFWbDHWWO8mSXSl3X6mL6aTZDnNRTFWZNcpf9jFXEbwiIjFNctnP
	 w6x6i+JWV34j6d6PulZV8/SWa1+CUehjd7BDExcYQV6YAagP0kvd/H3NEB1g5X+OggQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725639;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vcT5mKPK3ijqSBnvmhJlsitgI4aOjpa0/BC2N/7sLk4=;
	b=zZBzeQzGv7CBlqdAOXyRooNIjB+0VRsy0vw6qu3vdxKmwuiv2BINCTZJd8+fZN0LDsB2
	 060COJHIGGM1o5S4MNCh7HJkcfyqb646Kw+XS1f9XzCdQvFBi6Mkc0kU7Et/Y5yJD0JF0
	 dxd0mFQu/LpJHpm9d9TIswVi7Pa6KTl9q0KVHpEQ/AaxURPjxs2DGwGCceSt1zjJMqUy8
	 zXJpm4qJYwnT+gzV6LFjstR1mAWbzTQF0K9Nr8B7+0AHUnCY+OD+S9t3XwkUa7U86MGDw
	 ItoSDjI1Kho9sr8dR6bDGLe90bWSr7dWN7Io1x3ICEcujgJUHNB4eLPzgj3kbpTED4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D0NtJmSe;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4355C606A329
	for <linux-cxl@vger.kernel.org>; Tue,  3 Nov 2026 17:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4355C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D0NtJmSe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793725639; x=1825261639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F8HqY+Kv+yz/gTqV+5rtlHWN/3XSZHvlSwYnifBwr/g=;
  b=D0NtJmSe7NXRR46RMbph+EVjwx4ALmkUXLsvjvK7GBAa5Q3VryiKwalU
   m1QI1rTi8t2X0Eza+MXB+n/b/IUWFzuhVBNy1uakKvOwjxhGG2L786CY5
   yzRNaeESVUuM8Mwo37D9UZuWYln3P1yN+T7/3c/OvN0qWi/dYF0a0/pXr
   vjU0g04tQxRaLtUtIxUrgtCr/SX51et0nKJ7tp7oftEIBJkMho8KKyiVk
   BxGb6wEtHRbgKJX9+lWvP+KfsYJA4S+I7kpJfNZ+Qrcg0b6ggRq/Y/ave
   fpp8+x4UMcEJOwFEkfQUZdM8RkpBot2uoGlnxFe+CR1ux1wxBJXHAgmfS
   g==;
X-CSE-ConnectionGUID: OXTnVuXlTfqte6Vl7JDfNA==
X-CSE-MsgGUID: lmdpm1n8R6yVGpl3Z57isA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2489319"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2489319"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:07:17 -0800
X-CSE-ConnectionGUID: kWn1f4saRP+07hkM09rD7A==
X-CSE-MsgGUID: oexgUckxSoWzL/fHO+mZ/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6334155"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.242])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:07:17 -0800
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
Subject: [PATCH v4 2/2] cxl/Documentation: Describe clearing a region targetN position
Date: Tue,  3 Nov 2026 09:07:11 -0800
Message-ID: <4d2fa8561a443d9859ca08c04950e6c15e168f98.1793724885.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <e8235faea3d75dbfd45f197fe657c467b6259705.1793724885.git.alison.schofield@intel.com>
References: <e8235faea3d75dbfd45f197fe657c467b6259705.1793724885.git.alison.schofield@intel.com>
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
returns EBUSY, but does not describe how to clear the position after
assigning the wrong endpoint decoder.

Document how to clear a position by writing an empty string, how clearing a
position decommits a committed region, and how the region can be committed
again after all positions are filled.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v4:
- Minor wordsmithing in commit log
v3: https://lore.kernel.org/linux-cxl/e87248b8d13d3f07741243a45891365450c66881.1793653629.git.alison.schofield@intel.com/

Changes in v3:
- Restore the original entry text and append how to clear a position
v2: https://lore.kernel.org/linux-cxl/efa1a098550077dc3571796ba0102ddabe1e9b0d.1792989098.git.alison.schofield@intel.com/

Changes in v2:
- Say that writing the endpoint decoder already at a position succeeds
- Split the entry into paragraphs and drop the v1 error code reordering
v1: https://lore.kernel.org/linux-cxl/a007c751d88ee64c9d0b7bb3c69a486c42358b36.1790829690.git.alison.schofield@intel.com/
---
 Documentation/ABI/testing/sysfs-bus-cxl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 7352dbd70bc7..3629c983f05c 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -568,6 +568,10 @@ Description:
 		not an endpoint decoder. Once all positions have been
 		successfully written a final validation for decode conflicts is
 		performed before activating the region.
+		To clear a position, for example to replace an endpoint
+		decoder, write an empty string (echo > targetX). Clearing
+		a position in a committed region also decommits the region.
+		It can be committed again after all positions are filled.
 
 
 What:		/sys/bus/cxl/devices/regionZ/commit
-- 
2.37.3

