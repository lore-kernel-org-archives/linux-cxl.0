Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D3217C60
	for <linux-cxl@vger.kernel.org>; Wed,  3 Jul 2024 05:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719984598; cv=none; b=YhsexsJMC7AMBWBwXrl66IUlfiGFdBH9nih07Zj4fDISFyVHWx1SvV4xUpeEzxgyYDfq2fiEzQccR4bm5pq9otaQX3H1D4Ry2/UD6ggJlBBxa6QSgODsPSqy4BA9FDdAk2Xvk2RW+yp86kzPZ9p+UzMgIrWA65zpe/ulAKACmGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719984598; c=relaxed/simple;
	bh=Dk/CrgCxzJkFTEibwSU7Ru239wY2YWOJvxxX7LA2QOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F0TTC3r5CNjrmeomG4qwL7O0MrZnmDcMcmLIOOeUkL4At1cpXPlbrkEHJUmzSSL6KS+tMDVFQmFHaLfylOjallsSeXV2r55ISmxUWq9ka+Ck9mVVP0BE12TGozTDMvhs7COGtHj7htPTC89QU0TogND3mLdGXREbqgdiVVUK3U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+k1AYIe; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+k1AYIe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719984596; x=1751520596;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dk/CrgCxzJkFTEibwSU7Ru239wY2YWOJvxxX7LA2QOk=;
  b=j+k1AYIe6I7Q7kyqR7lxipWd3rsd5MM44dcNm5kSlTAhFVo0yH957I2b
   2p5/EApXtOKDHKQg7rhqjBl/wIvloBYuIKWo8JAxgM32tQfTlNJFavy4M
   yuPGwoUzPXNIDSVKO4P1teCSeS04h+92ZWrgYmvcnFjaNUjUOmZODHI4Y
   qilBcXejuuGUq4D5UJylJB35YLa9F0digSVt6aAo8yFVIBn5Vcc3B0vU/
   emCtGGgj8Mmm6KYEYIzgHe6L8CGM0y7Q9oT4Zx1aIzZFRWSWC94+tqme3
   uO9P+rRiIz5HHT/dNW5LaQbnntzhbo2VS5HhMYTxdrHDApygplXiuknF7
   w==;
X-CSE-ConnectionGUID: l6j3Oy1tQUKgfJZCGdPH/Q==
X-CSE-MsgGUID: f8ZZa1odR+e8OJ5dzXNEqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="28326341"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="28326341"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 22:29:56 -0700
X-CSE-ConnectionGUID: DdMx2qcQTim0n/Kra7q1xw==
X-CSE-MsgGUID: mlKZQkuPQ36oWgyKQNyMeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="46004054"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.8.146])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 22:29:55 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 0/4] XOR Math Fixups: translation & position
Date: Tue,  2 Jul 2024 22:29:48 -0700
Message-Id: <cover.1719980933.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>


Dropped tags on Patch 2 due to changes. Please Tag again.

Changes in v4:
- Patch 1: Updated commit msg/log 
  The name tidy-ups eventually led to a 'fold' not a 'rename'
- Patch 2: Rename the root decoder callback hpa_to_spa (Dan)
- Patch 2: Remove hpa_to_spa as a param to cxl_root_decoder_alloc()
- Patch 2: Add code comment that chunk check is modulo only (Fabio)
- Patch 2: Add lore link to unit test in commit log (Fabio)
- Cover Letter: Add an introduction (Dan)

Link to v3:
https://lore.kernel.org/cover.1719275633.git.alison.schofield@intel.com/


Begin cover letter:

XOR Math Fixups are presented for both translation and position.

Translation:
The CXL driver intends to report DPAs and their SPA translation in
the TRACE logs for CXL poison, general_media, and dram events. It
is actually only logging the HPA, not the SPA. That works for CXL
decodes using typical MODULO arithmetic where HPA==SPA, but not for
XOR decodes. The driver needs to restore the XOR'd bits in order to
get to the SPA and it doesn't. This means that address translations
for root decoders using XOR maps are wrong.

Specifically regions that interleave across 2,4,6,8,12, or 16 host
bridges are affected. Interleaves using 1 or 3 host bridges, even if
configured with XOR Arithmetic, do not use xormaps, and are safe.

Aside from knowing that any address translation of a 1 or 3 way host
bridge interleave is correct no matter the decode (XOR or MODULO),
all others are suspect because the decode is actually transparent to
users.

Position:
The position part of this patchset came from the discovery that
the driver doesn't need to calculate a targets position in a region
interleave set. The BIOS sets the target list and the driver can
simply use that order.


Presentation is as follows:

Patch 1: Clean up - cxl_trace_hpa()-> cxl_dpa_to_hpa()

Patch 2: cxl: Restore XOR'd position bits during address translation
This completes the DPA->HPA->SPA translation, correcting the XOR
address translation problem described above.

Patch 3 & Patch 4 are paired. Patch 3 presents the new method for
verifying a target position in the list and Patch 4 removes the
old method.

FYI - the reason I don't present the code removal first is because
I think it is easier to read the diff if I leave in the old root
decoder call back setup for calc_hb, insert the new call back along
the same path, and then rip out the defunct calc_hb. That's the
way I created the patchset and it may be an easier way for reviewers
to follow along with the root decoder callback setup.


Alison Schofield (4):
  cxl/core: Fold cxl_trace_hpa() into cxl_dpa_to_hpa()
  cxl: Restore XOR'd position bits during address translation
  cxl/region: Verify target positions using the ordered target list
  cxl: Remove defunct code calculating host bridge target positions

 drivers/cxl/acpi.c        | 84 ++++++++++++++++-----------------------
 drivers/cxl/core/core.h   |  8 ++--
 drivers/cxl/core/mbox.c   |  2 +-
 drivers/cxl/core/port.c   | 20 +---------
 drivers/cxl/core/region.c | 61 ++++++++++++++--------------
 drivers/cxl/core/trace.h  |  4 +-
 drivers/cxl/cxl.h         | 11 ++---
 7 files changed, 77 insertions(+), 113 deletions(-)


base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
-- 
2.37.3

