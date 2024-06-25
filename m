Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98307101EE
	for <linux-cxl@vger.kernel.org>; Tue, 25 Jun 2024 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719276961; cv=none; b=Kev9dOd2gu0XvJGCHNYjCTwz7oMSN2WaQBEoJ7B+xzlaIq2OyThH1jPzQUGBcST5lvktD7UDSDPivouB0m7dEoIQEi0E/QDR7+gXTh0Kr7HBWKWLAYVpFnyR9F/tDRwAg4bd3AW5WvGAdOPDiql3IAvNhImyVg0fZXfJsmR3mmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719276961; c=relaxed/simple;
	bh=D7oc/Tlpz+T8PTOCiP6meM7v0boVWqcgCjle4UuBQNI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jqbDio6/qYrpYI4tfbQqgZ9i+kXDtVn1l8lmJK9gsvDN/okSzp7PGIhhPV6U0YZsv0v5agAzbUe6G0gGu9wUwpyePAj4AbS1r/cxylw92CprLCGk6wc6Vxxs9LMDXTLwPaYHNGSy6F0UGmgHZmBwFbqxUWuXUgex9k7O19VQVCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khSrV1/m; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khSrV1/m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719276960; x=1750812960;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D7oc/Tlpz+T8PTOCiP6meM7v0boVWqcgCjle4UuBQNI=;
  b=khSrV1/mesZX86AWXTUz7qgcIjxWITCYHMQgrbg5vB/81qJ6WHY+4jz8
   fHMTvFr5HEaQfaORuiyCJKottySRv33NRkmLguv10ZbKFqNJMKBUdEbQ+
   bOJF3Bg0S/Dv/nIDCIgO3uOLT/U8rTa4WSCUaOCeCeRK3zi9pTOfOaLAb
   8Uw4fxflTKuk/Tann6Y26PDIi0KJVDMjifUNLA1MyN4qIt730PzVzWOyG
   GkcSbvQq/E+BETt2yHhQqhkUmS/bCrMZTHqkl52L575qMPqkIWXdQuU3T
   R3Da7AQwJKakdMDrhdSspzstmx0N2oxDMrT/DnXxW5/dyFpriJawCwGPD
   A==;
X-CSE-ConnectionGUID: CGsr7uYoQnemCkfzC/K63Q==
X-CSE-MsgGUID: WXdvZGkIQLu6XiEMrAWBvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16028464"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="16028464"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 17:55:59 -0700
X-CSE-ConnectionGUID: ugBbTVKZSHWibPwvQYImHw==
X-CSE-MsgGUID: DLz1TAGQTfmVOdJ1dP3Stg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="66697308"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.55.37])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 17:55:58 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 0/4] XOR Math Fixups: translation & position
Date: Mon, 24 Jun 2024 17:55:51 -0700
Message-Id: <cover.1719275633.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Changes in v3:
- Patch 2: Perform the 'chunk' check on Modulo decodes only
- Patch 1: Fold cxl_translate() into cxl_dpa_to_hpa()	(Jonathan)
  Jonathan asked for a rename of cxl_translate to cxl_dpa_to_hpa()
  but the latter already existed and the work of cxl_translate() was
  minimal. They are now one.
- Remove the mention of XOR's purpose in Patch 2 commit log (Dan)
- Reword hamming weight wrt XORALLBITS code comment (Jonathan)
- Post a unit test upstream[1]  (Dan, Jonathan)
- Remove Reviewed-by Tags on Patch 1 & 2 due to rework
- Add Diego's Tested-by tag to Patch 2,3

Link to v2:
https://lore.kernel.org/cover.1714159486.git.alison.schofield@intel.com/

[1] https://lore.kernel.org/20240624210644.495563-1-alison.schofield@intel.com/


Begin cover letter:

Rather than repeat the individual patch commit message content,
let me describe the flow of this set:

Patch 1: Rename an existing fn - cxl_trace_hpa()-> cxl_dpa_to_hpa()
A tiny, yet essential cleanup to take first.

Patch 2: cxl: Restore XOR'd position bits during address translation
The problem fixed in this patch, bad HPA translations with XOR math,
came to my attention recently. 

Patch 3 & Patch 4 are paired. Patch 3 presents the new method for
verifying a target position in the list and Patch 4 removes the
old method. These could be squashed.

FYI - the reason I don't present the code removal first is because
I think it is easier to read the diff if I leave in the old root
decoder call back setup for calc_hb, insert the new call back along
the same path, and then rip out the defunct calc_hb. That's the
way I created the patchset and it may be an easier way for reviewers
to follow along with the root decoder callback setup.


Alison Schofield (4):
  cxl/core: Rename cxl_trace_hpa() to cxl_dpa_to_hpa()
  cxl: Restore XOR'd position bits during address translation
  cxl/region: Verify target positions using the ordered target list
  cxl: Remove defunct code calculating host bridge target positions

 drivers/cxl/acpi.c        | 80 ++++++++++++++++-----------------------
 drivers/cxl/core/core.h   |  8 ++--
 drivers/cxl/core/mbox.c   |  2 +-
 drivers/cxl/core/port.c   | 21 ++--------
 drivers/cxl/core/region.c | 60 ++++++++++++++---------------
 drivers/cxl/core/trace.h  |  4 +-
 drivers/cxl/cxl.h         | 10 ++---
 7 files changed, 77 insertions(+), 108 deletions(-)


base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
-- 
2.37.3

