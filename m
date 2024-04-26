Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435651CD2B
	for <linux-cxl@vger.kernel.org>; Fri, 26 Apr 2024 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161073; cv=none; b=WZ3pev29gF3eAgHdHKCKMDNIJXbUVVSFaOcgaQLw3O3vBqtOLlxRqrRIxiN+zdB/xcoLnln7blgq2M1NWS6wF8nccaYj84A2oC2/MSFxHvc+Ej3NzRvtJKNkqWXPpDZHu0lVyVvu5YHqrOmia7048hexGjo7PW1LN29feMpHi2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161073; c=relaxed/simple;
	bh=43T+t1dedygmP7y2x5KElC5RiJQUzVe+V0uKI2OBiA8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sj1/K3p9nRe6OaPKbcovi2M41dqNavX25PNQuTuS20Y63VMFAOHEEWns+lbRdMqPMNwLpd4PzGr72fCBd6Do/rzMesSo7pQtnlE/o25qgbzh6je60UBbQFdACMturw8BR+21dHQDJULX4pIsxk0Z82f57XKA8EIkUzvx8K7CojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gFTe/cE6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gFTe/cE6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714161071; x=1745697071;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=43T+t1dedygmP7y2x5KElC5RiJQUzVe+V0uKI2OBiA8=;
  b=gFTe/cE6+EYagP+uwzhj5SPzrsZAcQy2LXv7VvWD3o9r2VFA0FZAEn2B
   SJOOdA40QgfUuR9GXfqo4xe7FV03t0zwCaNVox363mmQiLF3iEWxPdHFB
   LLjNWqzcE06ppf5hV0GibkHwyW5Q3ZW+X5Z0a4Q9ZbsKEMGcRVL8NSSdw
   kMuWfZcKFam+oLl0QAsCOePxrs7r5i0+mZAt2f6Ra/c6VYl0y7OhJcCxJ
   zr4roZRC1WxpoJSssdsWWdDdg+VZ6k8laowWdmb8xIcSTzqbjegIh7j7i
   5M2uzQXZTaR6uxI5RdA9FxB2Uph6BJHrAxLbrPvTeuednd6lGC5r6KMUu
   A==;
X-CSE-ConnectionGUID: KuFJgtscTxG8TAeUY97+Vg==
X-CSE-MsgGUID: u61nd8XzTweep6EDDWX84Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10067037"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="10067037"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 12:51:11 -0700
X-CSE-ConnectionGUID: H6fY8iSsSM+4iDijw1vr9Q==
X-CSE-MsgGUID: JuLf/3aHS5+0KJVKySCmcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="56432089"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.224.120])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 12:51:10 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 0/3] XOR Math Fixups: translation & position
Date: Fri, 26 Apr 2024 12:51:04 -0700
Message-Id: <cover.1714159486.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Rather than repeat the individual patch commit message content,
let me describe the flow of this set:

Patch 1: cxl/acpi: Restore XOR'd position bits during address translation
The problem fixed in this patch, bad HPA translations with XOR math,
came to my attention recently. Patch 1 can stand alone, but since that
discovery also shed light on how to repair an issue with calculating
positions in interleave sets (Patch 2,3) they are presented together.

Patch 2 & Patch 3 are paired. Patch 2 presents the new method for
verifying a target position in the list and Patch 3 removes the
old method. These 2 could be squashed.

FYI - the reason I don't present the code removal first is because
I think it is easier to read the diff if I leave in the old root
decoder call back setup for calc_hb, insert the new call back along
the same path, and then rip out the defunct calc_hb. That's the
way I created the patchset and it may be an easier way for reviewers
to follow along with the root decoder callback setup.


Alison Schofield (3):
  cxl/acpi: Restore XOR'd position bits during address translation
  cxl/region: Verify target positions using the ordered target list
  cxl: Remove defunct code calculating host bridge target positions

 drivers/cxl/acpi.c        | 76 ++++++++++++++++-----------------------
 drivers/cxl/core/port.c   | 21 ++---------
 drivers/cxl/core/region.c |  9 ++++-
 drivers/cxl/core/trace.c  |  5 +++
 drivers/cxl/cxl.h         | 10 +++---
 5 files changed, 51 insertions(+), 70 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.37.3

