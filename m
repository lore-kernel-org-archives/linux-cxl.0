Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84AD2BFC60
	for <linux-cxl@vger.kernel.org>; Sat, 11 Jul 2026 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783800332; cv=none; b=dp7G+EamEmNBSSSgfcM0x353IjYsPKSaSMEy4jrNVFHIPiTA1XnCXqIaXyYUUsZCtOvA04PRemxr+uKiatEKrshN2V4Klo/Qv/ZzIANsiP++IDi9g5D6HnCpGPKfG064sWJC/y9APPSxhCUCa8uNZFZYi3d60G47xYmPHPYfU/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783800332; c=relaxed/simple;
	bh=AKD6TTRRL3YLtLZh0eoxRHgfGiwb0O7q933uK2gVGiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jN5XJpSV2GrBcnY7NZkeP+AN84sCDQLz7/P86MuJdn33L25wY/LPudfPSjLw77AU+YwhLj3JmJ7iuS5hXyWfoUTJl36u9QODU+WRBWUOCq5LLWiiuT6TAcVnOKE5no4EiLCFZWyfl9qJxLAnZYgr2Ii1/NqBo1nIjRR/qY5ydZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mZuzG2tz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mZuzG2tz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783800331; x=1815336331;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AKD6TTRRL3YLtLZh0eoxRHgfGiwb0O7q933uK2gVGiQ=;
  b=mZuzG2tz6MKPLSXbR1A6wYf//lj/IG0Pi/k4IBxvkxq+0hnX6/Mb6/Mu
   /rL+KJ2tvmE8KFNuMAI0unaA8TghqXjiMKAwMXZxjzBBBF8XIhnmgxfeI
   D8hu75BQF/CJXingVa8yr5GFzbdAXo88fUQ3tLZjokmt5p8MtJsg2m8G3
   LoUjSeefnvstmliN2cPzODpsWLz+/vq4+i31iD9RJQyfcw9MYx032Ls2w
   J/VoN5c6ODaacOWRRb9MkAUNAtDsSNK+FCdvKTljnFtAgFIPkPibpGFJ/
   Xi+cWquUVn2axIw9m/nmrCFkMouFO7EMprpah7JpUAn3Gp/GG8ceXMtVG
   Q==;
X-CSE-ConnectionGUID: qbwQqnX9Ry+/JOEfnnp+5g==
X-CSE-MsgGUID: lLv/cRsARM2RWspqG8sFcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88379105"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88379105"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 13:05:31 -0700
X-CSE-ConnectionGUID: lxWf/pStSSm5rO6Gp2CmFQ==
X-CSE-MsgGUID: RLg33ZqiROWjM4ClGXTbrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254048277"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 13:05:30 -0700
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
Subject: [PATCH v2 0/2] cxl: Allow passthrough decoders with >16K granularity
Date: Sat, 11 Jul 2026 13:05:21 -0700
Message-ID: <cover.1783795720.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
- Rebased on Linux 7.2-rc1
- Only v1 feedback was from Sashiko and that was not an issue
Link to v1:
https://lore.kernel.org/linux-cxl/cover.1781136281.git.alison.schofield@intel.com/

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


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.37.3

