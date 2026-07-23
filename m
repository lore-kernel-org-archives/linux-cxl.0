Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07461A95E
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 01:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769432; cv=none; b=ms0zMg1UWrsoFZWgwfXSfP0Sj3TVkycGm77NmbLm2NXlKD+ft2JySpix9bcZDOD24E2TGeZmUP4X1iMVafHBjUsP32/7POPi9XUhVr+WaFXPHO2YCM2B7Dl6AOvqT4b2BybK6U064oGmnI8VyETz+/VyvzqUyCJTIfNXNTGOknw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769432; c=relaxed/simple;
	bh=AkFdo61pjFPTuiiOlBTWNsBrgnIuk5IsPynVbmLIz5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u/8W7EdtIinqyNAedIPrPX3w+rCeiXErmUD47SJ1OpdwjgCFpljZH9NRJVOMh45/jW7EQDoINxbDDS3qIKvxu62VZPOxVxfXNwnPep/f5E2nO8S90UDGKaLobGlwN0pi3oAzolG4oCLORPeUrjJkDXf2NM8Lz5pdIZ2+xG5+5n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfS44ZHl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BfS44ZHl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784769430; x=1816305430;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AkFdo61pjFPTuiiOlBTWNsBrgnIuk5IsPynVbmLIz5c=;
  b=BfS44ZHlQqS160cH2ned5siEZ4pTLk4ynQhIH2G4rT40hn+4BRIescJI
   FL3B5Qi+3vcU8OyWsmpFR3/MltJq4B92kRhdNUCs3j08OBwPZYx2QDEKG
   iY9aVrHz+9tR/VXv8ZEHkk1agnetXE/o7ZcRBqnebampV93AxSFcBk1ey
   TjWdutHHrc6i3g4IhzKAaOAxUMJH/03cfIcTt4/FwWxUbI6/togGwnTy9
   rLv/yKktFyvdRVTLTSnyJuW1nThoB3wAFU0d4b87bws3qb6DzU8OCM1A8
   s0tj8YtA9nzcpXy0yAhytR3uqnLhcnGJHb/LuGGKmkB4Hy6rIoepElMjr
   w==;
X-CSE-ConnectionGUID: eAczvGiMRVuNuc6H6SiJaw==
X-CSE-MsgGUID: OlGC4s0QTyuwZ2OfhD/14w==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96074826"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="96074826"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 18:17:09 -0700
X-CSE-ConnectionGUID: m2oTjXZpQByCXvY1SkAZwA==
X-CSE-MsgGUID: cyEvTKuQSda4SLmo/SM/iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="251943341"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 18:17:08 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	qemu-stable@nongnu.org
Subject: [PATCH v2 0/6] hw/cxl: fix Type-3 device reset resource leaks and convert to three-phase
Date: Thu, 23 Jul 2026 09:16:19 +0800
Message-ID: <20260723011625.1117034-1-junjie.cao@intel.com>
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

Changes since v1:
  - Patch 1: reorder cxl_destroy_cci() teardown to reverse
    cxl_init_cci() order, per Jonathan's review.

v1: https://lore.kernel.org/qemu-devel/20260626062149.1844334-1-junjie.cao@intel.com/

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


base-commit: cbd42e2b75b23953a9bdb073c8531518b1bd6163
-- 
2.43.0

