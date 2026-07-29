Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413BE484220
	for <linux-cxl@vger.kernel.org>; Wed, 29 Jul 2026 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336466; cv=none; b=Kqt2TkYqqVeXvL+sUZitcoh2ClCjKmT3eC/1jJzY4pcFN0AMWEFy8doTtfdE5C9DoiAj9oOLSRvIJqvPxMTFq9+smMH71SQZLXab0ij0VeIzPdCl/15QgQ0eNN3t4FARo32xtjt3VqcMmjfCH+5nFXbqAsQM5PpsRFw7vXJ9rO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336466; c=relaxed/simple;
	bh=nFqNu0iSMQjFsciEfqn515iB7LjyxAmJ+64HOq2b4Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TsNeznLXWWuM1cYD24u6o1WOo5npmsTI5Gar+szEzvvmB4tpcQvZWT199wqHh+xm7sI3jgzFALinWyi9dSCz71z1koK0z9Z3+TWyJL7d7+IBSf/dJbn82jT1W3cPOzfDKK3tnDE4JdhwjN93L2cd3FvMX6DVMczBP5rMrfpqN5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHaMM0Ng; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHaMM0Ng"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785336463; x=1816872463;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nFqNu0iSMQjFsciEfqn515iB7LjyxAmJ+64HOq2b4Ng=;
  b=PHaMM0Ngdv7ErBSafjo3g+MYCb3TsKMFMmsEUwp79gMPLOzazUd1GmBC
   EX2Yjfp+It95iAQ+1ITGoHCimKl8DH/jxRGaGcrPBLGH/1J9cQalaBU0D
   5NfrkHW6TI5ahpP7DfyPLeg6OcgiutVzYPIzX517lNYlNdUCyuhTSOrae
   RS9plblGwpz0AUVybtZxsK7edT+RqdWcPk/+SP51tgohAmaAYM2niWWVF
   J2I75TWZ4fxi2wZhgUFPJJJpFseHYtv74lWBzsfhRv5a0higfKFfPyTBS
   cep7Ws4dmj87J4/KyVpwJuZiRXHRzzyEJQm9+kLhahikPdWKIcY6Q7r7b
   g==;
X-CSE-ConnectionGUID: cd4Yxze2RN6a/iGrArjqaA==
X-CSE-MsgGUID: 8Q93+Vv7R7WPoc4PAA5WrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86133602"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="86133602"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 07:47:41 -0700
X-CSE-ConnectionGUID: zvsbSv6hRcWtRhs1R4VQsQ==
X-CSE-MsgGUID: eIFAtXanSSSB9POXZovHyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="258788794"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 07:47:40 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	philmd@oss.qualcomm.com,
	qemu-stable@nongnu.org
Subject: [PATCH v3 0/7] hw/cxl: fix Type-3 device reset resource leaks and convert to three-phase
Date: Wed, 29 Jul 2026 22:46:38 +0800
Message-ID: <20260729144645.1552511-1-junjie.cao@intel.com>
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
  - Patch 4: factor the primary CCI teardown into a
    cxl_destroy_mailbox_t3() helper pairing cxl_initialize_mailbox_t3()
  - Patches 5-7: clean up device state on reset

The state cleanup in patches 6-7 is gated on reset type:
RESET_TYPE_WAKEUP returns early (patch 6) since a resume from S3 is
not a Conventional or CXL Reset.  The CCI re-initialization and the
in-flight sanitize discard run unconditionally regardless of type.

Not addressed here:

  - Committed Feature attributes and alert thresholds (Table 8-276
    Deepest Reset Persistence = None) are not reverted to defaults.
    Factoring the realize-time defaults into a reset helper is left
    for a follow-up.

  - Dynamic Capacity extent lifecycle across reset.

  - The Media Disabled latch after an interrupted Sanitize (Section
    8.2.10.9.5.1); patch 5 addresses only the resource leak.

Tested: per-commit build clean; cxl qtest passes.  Differential
LeakSanitizer (5x system_reset): pre-series leaks 720 B / 15 allocs
in cxl_init_cci -> timer_new_ms; post-series zero (re-verified on
v3).  Poison inject -> reset -> re-inject same DPAs succeeds (no
stale "Overlap" rejection).  20x inject+reset stress cycles with no
crash.

Changes since v2:
  - New patch 4: factor the primary CCI teardown into
    cxl_destroy_mailbox_t3(), the teardown counterpart of
    cxl_initialize_mailbox_t3(), called from both the reset path and
    ct3_exit(). [Philippe]
  - Patch 5 (was patch 4): discard the in-flight sanitize state from
    cxl_destroy_mailbox_t3() through a helper shared with the
    __do_sanitize() completion path, so the whole media_op_sanitize
    lifecycle stays within cxl-mailbox-utils.c.  This also plugs the
    same leak on device unrealize, which v2 missed. [Philippe]
  - Picked up Philippe's Reviewed-by on patches 1 and 3.

Changes since v1:
  - Patch 1: reorder cxl_destroy_cci() teardown to reverse
    cxl_init_cci() order, per Jonathan's review.

v2: https://lore.kernel.org/qemu-devel/20260723011625.1117034-1-junjie.cao@intel.com/
v1: https://lore.kernel.org/qemu-devel/20260626062149.1844334-1-junjie.cao@intel.com/

Junjie Cao (7):
  hw/cxl: fix timer leak in cxl_destroy_cci()
  hw/cxl: destroy primary CCI before re-initialization on reset
  hw/cxl: convert cxl-type3 to three-phase reset
  hw/cxl: add cxl_destroy_mailbox_t3() as the mailbox teardown
    counterpart
  hw/cxl: discard in-flight sanitize state on mailbox teardown
  hw/cxl: clear event logs, scan media and interrupt policy on reset
  hw/cxl: clear poison lists and feature transfer state on reset

 hw/cxl/cxl-mailbox-utils.c  | 24 +++++++++++++--
 hw/mem/cxl_type3.c          | 60 +++++++++++++++++++++++++++++++++----
 include/hw/cxl/cxl_device.h |  3 ++
 3 files changed, 80 insertions(+), 7 deletions(-)


base-commit: e1705a25aff35635c360bbaba4c2731d019a422a
-- 
2.43.0

