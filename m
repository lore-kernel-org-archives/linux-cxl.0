Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9DC1E521
	for <linux-cxl@vger.kernel.org>; Wed,  8 May 2024 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194078; cv=none; b=ZQCHdpM9tl1nuJZDSFEgJIGqG85zhRYgCUmiF4wn9ARR7Y6E3TnPNoMmDRuiZNLH3UlGhcrX1fJRIq/2cDr9CHPpOWNyRSrqRs/e+8HSq1cibV1OAlU+sEBsJSFETlmdr8UDNgNy/dU60RBlauQXYDA8V7veIiHoLI5rfS15WwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194078; c=relaxed/simple;
	bh=//uaGFiVAw+W+xlhPqH+FRTDBJpqurEUQSs3+He4DGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RymUd2hG8v8sJb55a7FYrqsktwjjFGCo0b+m8vD0AgnCSzRWa+A1QEWBnhTabt+WSunJNmtuWM2oJGhVu2lx4q61/TijgxNbeRGb78sNynfzi4gqDcbqu3tLhCOv9j8RwZKC4zTwll6A8+pgJRMGDGq4a2VTfcIWyDCXt7K6ACg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pjxb5yeR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pjxb5yeR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715194076; x=1746730076;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=//uaGFiVAw+W+xlhPqH+FRTDBJpqurEUQSs3+He4DGY=;
  b=Pjxb5yeRq8YWQ1UZUqYUU2XLmOrDJfyMXJywlC0DDa/tjY1svZ0dHiWd
   Fxuvbb+GpAM8So8sXzfMNAVfBoE2khkQKSxTUd52FSaSALKlrIDkc6uKF
   FnoY7hPe+iH88sjRvN48ELCu1GPM/gWkgNHyDG0LhQO5BlVa7Uo1MCnkA
   LwjB41KUbFte0efLnmn10zqjb+iCc7cg75+rNiIauguD0WtbjdiSHEgmw
   SDXM09U0FfTV1OkrAwuGAnj+PBLCJGqhIwLJ8IWS1tFRZgZdNNQ+pSc64
   QZzwgNsYu4hJK4jgZus6xPCNZBqVmcebdTkx4AdmykWpOP7hLBXhACycB
   Q==;
X-CSE-ConnectionGUID: rb7MhpcWRHSqZYFslmEjIw==
X-CSE-MsgGUID: PAJFlCC+S1uZAZ8mFrhwMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="21675605"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="21675605"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:47:55 -0700
X-CSE-ConnectionGUID: BdNKzt2KSUOKbo784ICdvA==
X-CSE-MsgGUID: lvl4ZHUpSxG5nJDFr5aVaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33531050"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.242.107])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:47:55 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 0/4] XOR Math Fixups: translation & position
Date: Wed,  8 May 2024 11:47:49 -0700
Message-Id: <cover.1715192606.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Changes in v2:
- Rebase on cxl/next
- Remove 'misconfigured root decoder' warn in cxl_region_attach_position() (Dan)
- Comment the implementation of CXL Spec's XORALLBITS in cxl_xor_restore (Dan)
- Prepend new Patch 1 to rename cxl_trace_hpa()-> cxl_translate() (Dan)
- Simplify the setting of position bit in cxl_xor_restore() (Dan)
- Collapse the helper restore_xor_pos() into cxl_xor_restore() 
- Use host bridge ways, not region ways, in cxl_xor_restore().
- Update 'override' comment in cxl_translate() (Dan)
- Clarify via renames (Dan)
	cxl_addr_trans_fn -> cxl_translate_fn
	cxl_xor_trans()   -> cxl_xor_translate()

Link to v1:
https://lore.kernel.org/cover.1714159486.git.alison.schofield@intel.com/


Begin cover letter:

Rather than repeat the individual patch commit message content,
let me describe the flow of this set:

Patch 1: Rename an existing fn - cxl_trace_hpa()-> cxl_translate()

Patch 2: cxl/acpi: Restore XOR'd position bits during address translation
The problem fixed in this patch, bad HPA translations with XOR math,
came to my attention recently. Patch 1 can stand alone, but since that
discovery also shed light on how to repair an issue with calculating
positions in interleave sets (Patch 2,3) they are presented together.

Patch 3 & Patch 4 are paired. Patch 3 presents the new method for
verifying a target position in the list and Patch 3 removes the
old method. These could be squashed.

FYI - the reason I don't present the code removal first is because
I think it is easier to read the diff if I leave in the old root
decoder call back setup for calc_hb, insert the new call back along
the same path, and then rip out the defunct calc_hb. That's the
way I created the patchset and it may be an easier way for reviewers
to follow along with the root decoder callback setup.


Alison Schofield (4):
  cxl/core: Rename cxl_trace_hpa() to cxl_translate()
  cxl/acpi: Restore XOR'd position bits during address translation
  cxl/region: Verify target positions using the ordered target list
  cxl: Remove defunct code calculating host bridge target positions

 drivers/cxl/acpi.c        | 80 ++++++++++++++++-----------------------
 drivers/cxl/core/core.h   |  4 +-
 drivers/cxl/core/mbox.c   |  2 +-
 drivers/cxl/core/port.c   | 21 ++--------
 drivers/cxl/core/region.c | 12 +++++-
 drivers/cxl/core/trace.h  |  2 +-
 drivers/cxl/cxl.h         | 10 ++---
 7 files changed, 54 insertions(+), 77 deletions(-)


base-commit: d99f13843237cf9dbdc1bd873a901662b4aee16f
-- 
2.37.3

