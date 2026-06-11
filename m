Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB051DF261
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781137811; cv=none; b=saLmuV40A2Y7oKqALHQFYEKAZGscejB4xewpF5s18XOi3TRo53bC81xd0tMi+NOcnm2rNn5CLOeymE4Vb3u/eNb6ZEKk3S/TJnOwkN2mbwJPNEvNMHlOYDe18K5+aSO3SRHM/OgS2pGgrr1xETqMCM4F+tkZ4lr4ToSpyTAJPNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781137811; c=relaxed/simple;
	bh=Fu7gmDRYE8C+SJRSYqk+gSLdMKnappuXIH3wAR5LXjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=muZRFQklm9Pg0sIDq3W+28A1KsgKMMMf7qaSr5BbepLZ7MQZaOqAK/ZE4fZONWD1GZVqOP0mkEgbdCIshtWi2fvc4a7LnWjLzZSFHNlLxgoQ/03w+Jgq5+WsSecVdOihGxhNmV23yabKhHdvF+bdPw66cqqY3UDoM2ferTLJYWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JwdElLF+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JwdElLF+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781137810; x=1812673810;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Fu7gmDRYE8C+SJRSYqk+gSLdMKnappuXIH3wAR5LXjI=;
  b=JwdElLF+5JdBzhTI/KB/7by5E3OR6jvjyreUQrth4XbdYTnTgdAWZkv/
   t8HtLyw4+jOr6TbTdhvjAlA6w0bdu/XkXBcU84QNyWfJ5M/HXx8RiX/iL
   R4qF84G7VWJrmSknkHKj6Cre3Fux+D81JYwcDLB88HbdRd7uzvhYaXSH0
   vwOOeoUHRLuuxy525637TSftPtOoV6P+2fxrJfzjhL0jF9pAfh80cb9cW
   mLJw4yw5l9dDuf4q8MnIVZ+z5u5oh9UNyTiLdfLhBiv5QTSMWZicCm60D
   3YeHbbFMJo0DFsHRDfEAuUu4ssEg/M/UbuLsbppthVB8/EZqxwC1C5RCa
   A==;
X-CSE-ConnectionGUID: LmXm5d00Qd2z9gT5QO6naA==
X-CSE-MsgGUID: 4qJQGm8SRK6+U4g6ydzZCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81794421"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81794421"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 17:30:09 -0700
X-CSE-ConnectionGUID: xXPhJOlpTTuS2/AH0RWVwQ==
X-CSE-MsgGUID: 7YLUycZ8R8mMq4avN/U36Q==
X-ExtLoop1: 1
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.46])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 17:30:09 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 0/2] cxl: Allow passthrough decoders with >16K granularity
Date: Wed, 10 Jun 2026 17:29:29 -0700
Message-ID: <cover.1781136281.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko reported [1] that region setup rejects valid topologies
containing a passthrough decoder beneath a wide parent interleave. In
these configurations, a passthrough decoder can compute a granularity
above the 16K maximum encodable in the interleave granularity (IG)
field even though non-interleaving decoders do not consume that field.

The first patch avoids validating the interleave granularity of
non-interleaving decoders, encodes the IG field as a don't-care when
committing those decoders, and updates the sysfs ABI documentation
accordingly.

The second patch extends cxl-test with a topology that allows a CXL
unit test to cover this case.

A unit test update for this case is posted for review [2].

[1] https://lore.kernel.org/all/20260530002613.682E71F00893@smtp.kernel.org/
[2] https://lore.kernel.org/all/cover.1781136221.git.alison.schofield@intel.com/


Alison Schofield (2):
  cxl/region: Allow passthrough decoders with >16K granularity
  cxl/test: Add a 2-way 16K root decoder for passthrough testing

 Documentation/ABI/testing/sysfs-bus-cxl |  5 ++-
 drivers/cxl/core/hdm.c                  | 13 +++++--
 drivers/cxl/core/region.c               | 47 ++++++++++++++----------
 tools/testing/cxl/test/cxl.c            | 48 +++++++++++++++++++++++--
 4 files changed, 88 insertions(+), 25 deletions(-)


base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
-- 
2.37.3

