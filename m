Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216C5762C1
	for <linux-cxl@vger.kernel.org>; Fri, 26 Apr 2024 03:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714103190; cv=none; b=Ma9+Q68XUus4e5UQ17fVNQKBAWSHpBiPdu2wuZivmg13dgfZo7i/1PJnz75AmfrKgWZq+YYSxtUwEd10Gs5ULQAcbLYmSVtm4vqmCGFy5npKcTfZNigpXZgzme107dVUgGQGVRCSuIqy9GiwwR4QGamsom2MeavjyGLXv1HEa1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714103190; c=relaxed/simple;
	bh=M+V7eaag56bkTu7oLkpJyeY1QLWG0JQz1dtu0SMLzeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s1KjvyQJMDPY1HIRD4EJU9egrQ9KU6XFkpAB76USr7oo+p/AP/upET5fNpjI5HjoFx3V+oWYA6tZEJrYVZ9VrOXOXigAo1yF602LEJAWHvHNRV+seqhIYqXoTJhRkHuxDlnW8Ai6biw25dXxknLgkBM4XKrs9APRGopJw5WEEwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lea+YPXv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lea+YPXv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714103188; x=1745639188;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M+V7eaag56bkTu7oLkpJyeY1QLWG0JQz1dtu0SMLzeQ=;
  b=Lea+YPXvRXsytZww7qgO6EMWCp8sTvtcnRjSiC7XOv4adUprju2RpExZ
   VlDJNxq35MV6k28M2bfYoWEokxXBgpsAKLPhHdED/trgWY6NwE6R5ukWJ
   NyuVdrUb/t5MCWAhKy6btzxJsEU2fKQJ8Fedq7Do+91oDDZ6v7T0EgVZw
   wDbSDqa5R/Qpd3Qkv8XTm+OAOhJwbzx0858qnoggWcmEIzrX0fI5P3Gid
   CS5HlNXcWXPAJxX4E+JA0U7CzgKGB/esTg5l8gjiMGxYwxAgv61Ru8WCq
   83xjdb4hQu0ne3Bh2GK4JvCPa0fuZnjEn/2fnc137d9EdKGYaOLnkIlnZ
   g==;
X-CSE-ConnectionGUID: sm3b7nG2RhmFUN9BfumNkg==
X-CSE-MsgGUID: JhLYwj51R1OvwIr1+MqGOQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20381456"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="20381456"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 20:46:27 -0700
X-CSE-ConnectionGUID: yQ9vculjSl6VKuZvovZMzA==
X-CSE-MsgGUID: jVM3o9O1TCezBfddsqlGuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="29738207"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.128.24])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 20:46:26 -0700
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
Subject: [PATCH v4 0/3] Add DPA->HPA translation to dram & general_media events
Date: Thu, 25 Apr 2024 20:46:22 -0700
Message-Id: <cover.1714102202.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>


Changes in v4:
- Pick up Dan's style suggestions I missed in v3 (Dan)
- Lookup hpa earlier (within trace_enabled()) and pass to the event handler (Dan)
- Add and use a new member in cxl_event union to access the common phys_addr field.
Link to v3: https://lore.kernel.org/cover.1714085857.git.alison.schofield@intel.com/

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
 drivers/cxl/core/mbox.c   |  36 ++++++++--
 drivers/cxl/core/memdev.c |  44 -------------
 drivers/cxl/core/region.c | 135 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/trace.c  |  91 -------------------------
 drivers/cxl/core/trace.h  |  46 +++++++++----
 include/linux/cxl-event.h |  10 +++
 7 files changed, 224 insertions(+), 152 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.37.3

