Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2999C155728
	for <linux-cxl@vger.kernel.org>; Thu, 25 Apr 2024 23:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714087541; cv=none; b=dwHgPqd1Lw73AYn+FUb44G9vZKpASwxnIiLP8mw65ErmOnWYZdUHA3lhyQt3i9R/14WsiXr0vl/wll/O+OFcZMc0QU6b4Eoa06dlGeP5QWFoyvXdreQtf+Hk8sDWo9u9cFlq8vsAkhjYdIt41yP1J+PiiKntBUrWVJohGaRQuGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714087541; c=relaxed/simple;
	bh=jB8nYl9ZzOHuPk2FBUVpV99U8gvm87tSch+fDmOUjAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n0Uh4eEbXkXxw70r0tPHvIfRTO8bkcJ06rr8CEcIPzLx2OyMaDczSyh55I1jofW2SXsDPYB+hd9FRQvLvljp5X58cPswBbMBGrhFqnqCix1YKVVEf3iUy7EYAeFZdnJD+LNadQfOviesf8HB5/793uYMS2u53BNRDoMJVaWoHrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+RLlfBY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+RLlfBY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714087540; x=1745623540;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jB8nYl9ZzOHuPk2FBUVpV99U8gvm87tSch+fDmOUjAw=;
  b=E+RLlfBYEVttsymbwQPn6EB0hv9tzWv8DnfEik5RUlSUqgk9H3GKeSsb
   mOAF11Qe6yja3pfhFmJzpBDQXZB3ofnUrBLE2OXRmcQVsqCa0g35OcsAu
   /z1CMe6Pw77lx8PizTQ2qHYLOVNL46Jn83qsKWFBTNA2NHSl3oIzTAprO
   3GvkYJK6Xy7MXOB3oin1Tjl7tAqLyDR9rerp+HVaT2WPm0WFe/5vbUFtx
   ykD7mOu9X/LEOD6Z9jlUdawyV4dGiScCHGW+sucBwDDBZmewi1fMOdIx9
   pJbWvH3BgbUKS7POqfUAodSQ4/YTGxcttL/c67ICLXmgOujjnwY9A854c
   g==;
X-CSE-ConnectionGUID: 65MS28OfQOiyPVwBgwjSnw==
X-CSE-MsgGUID: AuE6ZfXgSh6oxswr7gHt+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="21230602"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="21230602"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 16:25:38 -0700
X-CSE-ConnectionGUID: ue7h+et9Rdmy8Dxx/M7zvA==
X-CSE-MsgGUID: i2rm5y9zS8enmkhDWSrEww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="25249834"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.128.24])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 16:25:37 -0700
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
Subject: [PATCH v3 0/3] Add DPA->HPA translation to dram & general_media
Date: Thu, 25 Apr 2024 16:25:32 -0700
Message-Id: <cover.1714085857.git.alison.schofield@intel.com>
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
- Harvest the cxlr before calling trace handler (Dan)
- Replace macros w inline fast assigns (made easier w available cxlr)
- Drop prior review (Jonathan) on Patch 3 due to churn.
- Remove Patch 4 which was making cxl_poison use the (now gone) macros.
  (A uuid_t change was tucked in Patch 4 and can be posted as a separate
  tidy-up patch.)

Link to v2: https://lore.kernel.org/cover.1713842838.git.alison.schofield@intel.com/

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
events. Lookup and log the DPA->HPA translation along with the
region name and region uuid.


Alison Schofield (3):
  cxl/region: Move cxl_dpa_to_region() work to the region driver
  cxl/region: Move cxl_trace_hpa() work to the region driver
  cxl/core: Add region info to cxl_general_media and cxl_dram events

 drivers/cxl/core/core.h   |  14 ++++
 drivers/cxl/core/mbox.c   |  30 +++++++--
 drivers/cxl/core/memdev.c |  44 -------------
 drivers/cxl/core/region.c | 135 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/trace.c  |  91 -------------------------
 drivers/cxl/core/trace.h  |  48 ++++++++++----
 6 files changed, 210 insertions(+), 152 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.37.3

