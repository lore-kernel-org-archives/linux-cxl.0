Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4823BB118
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jun 2026 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782456960; cv=none; b=W4BwvmaOH+dWNLtxt4PYxMhr9pQ9uBlsgAOaxIWZ/EMB2GynIAlsnQt0N6cdztJ+sAoI4g3/zY9wFto+waQhtkcsUS6iN2WU67If5a5eqXUP5OHnHkDrjhSZwaYzAgdQk2S4cD6QyT73dn9KU7EjxqSBLMfisGAAhpNVOTnCFd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782456960; c=relaxed/simple;
	bh=iARy3cRYNassfTGD4WkDMHzE6Bdi/ddDojiWpPiYACA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tX6xEOZDIRV8EfcpSS10XCQgkY5UI6S+9DVNsZoyWoasBkAind7B/HBNpgIlCl3Tmo+Ko3/RIUWVRdDk0rwpzTxer5+e+9IueN9Cz5bUjX3FeDXhztleuK7xnKTdW4HVyXfzz4JKkXlPYeuMXnqfjMvXw0RC28nMoP2CWy5y7GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpiLx8Pw; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpiLx8Pw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782456959; x=1813992959;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iARy3cRYNassfTGD4WkDMHzE6Bdi/ddDojiWpPiYACA=;
  b=hpiLx8PwLbIsV8GfBsfP0PNusnzteDvotwzuSZqwoluFxOJQYz4jhoOp
   v5mC9nzGP0qel48BIlnAKc6FN6lZP8CIO9+0JW4i4hIh4VCzT2SK6xHIv
   SW/ETgK6Lj65THfK6G2KP1prQ2V06uqppmENdf/mjolkHK5Dj5ftLBzGd
   MQmaOlU/uTKtsDy+vHEt6dCAxxapKwb+FMV2Z4VVsZH5Skz0mu8geKLyd
   2NIawbRZzXyqN//jfaeBbr9zQKDE1vV5INzbJNsdXrPC520npD5ao4zql
   2f6/ErsXF69BfvyeRk2hCLPOmqffNm6gOtQ2GZgDbcA93fQ/1SSeMIojM
   g==;
X-CSE-ConnectionGUID: gugx6Kw7TfW2vW0OEn2TaQ==
X-CSE-MsgGUID: zYTQzqY1R/a5h0WlJt4bUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="85802325"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="85802325"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 23:55:58 -0700
X-CSE-ConnectionGUID: eTBD9Fi/RIS+SZEmscM+1g==
X-CSE-MsgGUID: yF5XFUvrS3SubeOL5hvcsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="244865865"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 23:55:56 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	linux-cxl@vger.kernel.org,
	junjie.cao@intel.com
Subject: [PATCH 0/6] hw/cxl: fix Type-3 device reset resource leaks and convert to three-phase
Date: Fri, 26 Jun 2026 14:21:43 +0800
Message-ID: <20260626062149.1844334-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The CXL Type-3 device reset path (ct3d_reset) has several issues:

1) Resource leaks:
   - cxl_destroy_cci() never frees the QEMUTimer allocated by
     cxl_init_cci(), leaking a timer on each destroy/reinit cycle.
   - The primary CCI (ct3d->cci) is re-initialized through
     cxl_device_register_init_t3() without being destroyed first,
     leaking the timer and leaving the mutex undestroyed on every
     reset.
   - The secondary CCIs are never destroyed at device exit time,
     leaking their timers and mutexes on device removal.

2) Incomplete state cleanup:
   - Background commands do not survive Conventional Resets (CXL r4.0
     Section 8.2.9.4), yet the in-flight sanitize state is never freed.
   - Scan media results are explicitly invalidated after reset (Section
     8.2.10.9.4.6), yet scan_media_hasrun is never cleared.
   - Event interrupt settings shall be reset to 00b on Conventional
     Reset (Section 8.2.10.2.5), yet irq_enabled is never cleared.
   - When "Injects Persistent Poison" is 0 (the QEMU default), injected
     poison shall be automatically cleared on reset (Table 8-309), yet
     the poison lists are never drained.
   - Stale event records remain in the queues across reset even though
     the Event Status register (Table 8-203) is non-sticky.

3) Deprecated API usage:
   - Uses device_class_set_legacy_reset() instead of the three-phase
     resettable interface, preventing reset-type-aware behavior.

This series fixes the issues incrementally:
  - Patches 1-2: fix resource leaks (deterministic bugs)
  - Patch 3: mechanical conversion to three-phase reset
  - Patches 4-6: clean up device state on reset

The state cleanup in patches 4-6 is gated on reset type:
RESET_TYPE_WAKEUP returns early (patch 5) since a resume from S3 is
not a Conventional or CXL Reset.  The CCI re-initialization and the
in-flight sanitize free run unconditionally regardless of type.

Not addressed here:

  - Committed Feature attributes and alert thresholds (Table 8-276
    Deepest Reset Persistence = None) are not reverted to defaults.
    Factoring the realize-time defaults into a reset helper is left
    for a follow-up.

  - Dynamic Capacity extent lifecycle across reset.

  - The Media Disabled latch after an interrupted Sanitize (Section
    8.2.10.9.5.1); patch 4 addresses only the resource leak.

Tested: per-commit build clean; qtest passes.  Differential
LeakSanitizer (5x system_reset): pre-series leaks 720 B / 15 allocs
in cxl_init_cci -> timer_new_ms; post-series zero.  Poison inject ->
reset -> re-inject same DPAs succeeds (no stale "Overlap" rejection).
20x inject+reset stress cycles with no crash.

Junjie Cao (6):
  hw/cxl: fix timer leak in cxl_destroy_cci()
  hw/cxl: destroy primary CCI before re-initialization on reset
  hw/cxl: convert cxl-type3 to three-phase reset
  hw/cxl: free in-flight sanitize state on reset
  hw/cxl: clear event logs, scan media and interrupt policy on reset
  hw/cxl: clear poison lists and feature transfer state on reset

 hw/cxl/cxl-mailbox-utils.c  |  2 +
 hw/mem/cxl_type3.c          | 74 ++++++++++++++++++++++++++++++++++---
 include/hw/cxl/cxl_device.h |  2 +
 3 files changed, 73 insertions(+), 5 deletions(-)

--
2.43.0

