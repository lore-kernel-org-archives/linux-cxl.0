Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35DF388397
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160818; cv=none; b=cjEfSkW6NU9b9modBGJ0j4zBxZ6lTaqMBviMY9AEy9yXuzXoatydxso2QG40sSQIBl5tfTkZoNp8GsxqwGKbGD7qFPP2z06nQz2IsEFX62OX3iN9XwFVwPkKWRsvrisWVwh7gSkhQZCdP3UQ1FvX8OfADwa/gItgZZAGxZnajww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160818; c=relaxed/simple;
	bh=w+NWyNCiA9FPJArTEmBIfUD57JuYWKayWZ3GY406jSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mxYv4LT4RV23HGz56rThklUIFxBuh8am/GSh7ndeQn6+qxYVZy3id2du9+8HxrNZaODYl3WjniB65wLP2cfMuKMei8GCAd1d6kOWGZOZgYVRbyp6vEMS2dAcxETaloCT7P10/uOhMcSSPj+Ocm45HyJDOufsEJ/uFASCXYqr2LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ep+R9K5i; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ep+R9K5i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781160815; x=1812696815;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w+NWyNCiA9FPJArTEmBIfUD57JuYWKayWZ3GY406jSg=;
  b=ep+R9K5iwai+ddE5rfHjCycmB3p0ShqVYe8kF4/IQKeZm2F+ADmzMLX1
   nA0T47CNsSb0Cq905tfKiHtuws537lI7+AOmFwMkzijG8huPt02rOF3Dw
   cgc6lf8QfrFy6lCVI8a4CM47IWfbpKxysOX9JFlGcp4xVhohk0A+HEV9X
   unqi732FUJkNnVF7xHQlMTMqEaKcmnbhCbLS9sDeMnjkInG7lKy8Dlcb1
   wWTMaAWGLYRPMQ6jsiY2v8YYENLSkltC8g/rUHH280RAXnNcZr/Klt1Ja
   aDZxt0czcarMm/L5WxZgzH4U45mGpGEhXoEJWDPAHN0ODaRJWWIHtWv2r
   A==;
X-CSE-ConnectionGUID: 2MMPefGiQ9KEZ4/xA3YE3g==
X-CSE-MsgGUID: EXeSQvogSFitJqpE35rzeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85595412"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="85595412"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 23:53:34 -0700
X-CSE-ConnectionGUID: kUOFblCmREWuBer6+Y8LLA==
X-CSE-MsgGUID: oUJ7Vc7BTCiksKvtspAqvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="246469695"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 23:53:32 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: jic23@kernel.org
Cc: fan.ni@samsung.com,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	junjie.cao@intel.com
Subject: [PATCH v2 0/5] hw/cxl: add trace-events coverage
Date: Thu, 11 Jun 2026 14:30:22 +0800
Message-ID: <20260611063027.1166493-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL subsystem in QEMU currently has no trace coverage.  Debugging
mailbox commands, HDM decoder programming, event log activity, and
CFMWS address decoding relies on temporary printf or qemu_log_mask.

This series introduces trace-events infrastructure for the CXL
subsystem and adds 11 trace points covering the above paths.  All
events use the cxl_ prefix so -trace 'cxl_*' captures everything.

Changes since v1:
  - Split patch 2 into HDM-only; dropped CDAT traces -- source is
    commandline-controlled (Jonathan)
  - Split patch 3 into separate event-log and CFMWS patches (Jonathan)
  - Pass set and cmd as separate uint8_t parameters instead of a
    combined opcode (Jonathan)
  - Cover all 21 CXL_MBOX_INVALID_PAYLOAD_LENGTH return sites, not
    just the centralised entry check (Jonathan)
  - Rename depth -> occupancy in event log trace (Jonathan)
  - Defer passthrough-specific trace pending upstream support (Jonathan)
  - Add cxl_hdm_decoder_uncommit for commit/uncommit symmetry

v1: https://lore.kernel.org/qemu-devel/20260603013420.904749-1-junjie.cao@intel.com/

Junjie Cao (5):
  hw/cxl: introduce trace-events infrastructure
  hw/cxl: trace mailbox command dispatch and payload errors
  hw/cxl: trace HDM decoder write, commit and uncommit
  hw/cxl: trace event log insertion, overflow and clear
  hw/cxl: trace CFMWS address-to-device routing

 hw/cxl/cxl-events.c         | 13 +++++--
 hw/cxl/cxl-host.c           |  4 +++
 hw/cxl/cxl-mailbox-utils.c  | 71 +++++++++++++++++++++++++++++++++++--
 hw/cxl/trace-events         | 15 ++++++++
 hw/cxl/trace.h              |  2 ++
 hw/mem/cxl_type3.c          | 19 +++++++++-
 hw/mem/trace-events         |  5 +++
 include/hw/cxl/cxl_device.h |  1 +
 meson.build                 |  1 +
 9 files changed, 126 insertions(+), 5 deletions(-)
 create mode 100644 hw/cxl/trace-events
 create mode 100644 hw/cxl/trace.h

-- 
2.43.0

