Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE591C687
	for <linux-cxl@vger.kernel.org>; Tue, 23 Apr 2024 03:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844092; cv=none; b=AQhru6FPQgUqyvKuk67v+5LvR0WoMnrJ1Q+LaG5cr7kQtaVYHbOsrNk0LrgIyUmUCEa+SIM/uoYtgjEcP18VwHPTYZpjauVRYJTe4cL6xwxWS/7uzD9ttXH/ty8UAAJnBTQMJp7wAtu0haazbtz9S43KGLXBCwWEMEWDzqZqKho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844092; c=relaxed/simple;
	bh=OHrEtKnygUQCzjRGdLlMCinsxBjxMcOjxWrmowfDtKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NvNze20QZ/ZMHLJvLZYpg9ZCUdJvVGShDdcKxVFlAjMmpUOepDIbaOB+M/uONU7w8Me33n/gGTCw4UuxHZfNyiKXnQYkaaY5uiz7BZJBewA5JRzJSgROzXHv1owXyegBua/ywV9Uddf3rqNjLe+SkxI1hnvwHdK2AvvQ/ymUfpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNkDDm5W; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNkDDm5W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713844091; x=1745380091;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OHrEtKnygUQCzjRGdLlMCinsxBjxMcOjxWrmowfDtKg=;
  b=eNkDDm5WapCNkaFK5qF/tsLJ8tKI8VOTmpSWR+zVjWYpHQzZ+PckCDni
   I7s6UHWMVYUc00ZzJhGXpDE8yNkgFmefyry7Awu9jlklRT5GvZkrdPMuk
   3jH7uiIQvwdrg3+6OJ3DoGQ/y8gXA/8RSTuYANM0qnyeOpFD38+9bKYz2
   i+9XtkbW00/vjEDRmL7pEtCKlrBJ9IJUnrs8LWjUbhWnca0kN15jXhbbX
   rWSYl5BAZHayDGqWmReJuwSPczDycPN1w3LakobMV43CGia+/tObSyphn
   4/YrJ0JLdSCYFyq2XssPMOO/Cxq3W0ZxlwB44cdwCeWZwK83N4E2UfuN4
   A==;
X-CSE-ConnectionGUID: bNrE8AXzQL23sBgWCDEcEw==
X-CSE-MsgGUID: viQAJHB+SGeU3B+JZ0FShQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="26925880"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26925880"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 20:48:09 -0700
X-CSE-ConnectionGUID: BYFaFWvTTlqtUX2nbEewcg==
X-CSE-MsgGUID: Fp4Ji8ESTlmuEGmsa/JMVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28884696"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.73.120])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 20:48:09 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 0/4] Add DPA->HPA translation to dram & general_media
Date: Mon, 22 Apr 2024 20:48:02 -0700
Message-Id: <cover.1713842838.git.alison.schofield@intel.com>
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
- Fix !CONFIG_CXL_REGION build error in cxl/core.h stub (lkp@intel.com)
- Remove 'to dpa' usage when DPA is already adjusted in TP_fast_assign
- Use a common macro for extracting dpa from event record (Ira)
- Return "" instead of NULL for region name in stub (Jonathan)
- Replace store_region_info MACRO w static inline func (Dan)
- Set uuid to uuid_null when no region info available (Ira)
- Remove useless macro wrapping cxl_to_region_name() (Ira)
- Remove extraneous diff in Patch 4's TP_printk (Jonathan)
- Update commit msg patch 1 & 2, s/stubs/stub (Jonathan)
Link to v1: https://lore.kernel.org/cover.1711598777.git.alison.schofield@intel.com/

An update to the cxl_events unit test is in review here:
https://lore.kernel.org/20240328043727.2186722-1-alison.schofield@intel.com/


Begin Cover Letter:
Add HPA translations to CXL events: cxl_dram and cxl_general_media

Patches 1 & 2:
Before adding the new support, do some housekeeping and move related
helpers to the region driver because there is no looking up region
related info without CONFIG_CXL_REGION.

Patch 3:
The new functionality is introduced - cxl_dram & cxl_general_media
events will lookup and log the DPA->HPA translation along with the
region name and region uuid.

Patch 4:
Apply the new lookup helpers to the existing cxl_poison event, so it
can be the same, share in the new goodness, and also tidy up its
implementation.

An update to the cxl_event unit test is posted separately.

Alison Schofield (4):
  cxl/region: Move cxl_dpa_to_region() work to the region driver
  cxl/region: Move cxl_trace_hpa() work to the region driver
  cxl/core: Add region info to cxl_general_media and cxl_dram events
  cxl/core: Remove cxlr dependency from cxl_poison trace events

 drivers/cxl/core/core.h   |  20 +++++
 drivers/cxl/core/mbox.c   |  22 ++++--
 drivers/cxl/core/memdev.c |  52 +------------
 drivers/cxl/core/region.c | 151 +++++++++++++++++++++++++++++++++++++-
 drivers/cxl/core/trace.c  |  91 -----------------------
 drivers/cxl/core/trace.h  |  81 ++++++++++++++------
 drivers/cxl/cxlmem.h      |   3 +-
 7 files changed, 245 insertions(+), 175 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.37.3

