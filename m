Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794104428;
	b=t1Kf+igX2cOHH3xv1qMAFKrqipZv7Wm7WDKF4HcNYBVcDCwmj1ZpT8u9XBBvKMsjhJxz
	 +Fj5jff+xY+7ybrf4UyPs7D5VHyVzBOn/srqc/63CYQ/tby53KhC2xUnv6rujjOdkTnEC
	 +7OkrxHe5jL8pIu8W7FmTzcLLL7M0G+o6HonpxIDdz7mT+s1fELZmlvigDXfECBRmVylj
	 LpVA16aBI/buzRXdyZ0X0GcWo+ESPxYoy1zwx6kayDkjNiQMgv2g162gptiT+UJR980V7
	 nK6xFekZNsQPcyY4+wqYS+dmJemSMdXMjI3hPj4K+Mj2kjESyHT1rbbGQuiIqcichrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794104428;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=HRpb0ZNgMoAuUWmIwHiaFI9curVX3i22DFTskIwhq1w=;
	b=XF+PtainbS283RDQ2sSHNBHEwUMT9nDQ7Qkz/0kIkXbA9GB7KOt+Db092ocsZFjEs1Dp
	 1YoJKHio4clkIWFK4RrJYG59yOWkHlzqthpFco/KvU9XltU2pKTELwUDUI82AdboyUDaC
	 fh+xuML1Ar2zkXDuIjxiSFTW7DH4N5t3KbchXxbpEVxx/pRjy9XopGL1aNXb64kp+iqph
	 9YK8wQwOOYNx1mhnt64wSulGPpc0JQJsO1jEij/p3WCxRbP0K8iUD0z92Shu+eCSMP2SH
	 nzkMwY820H92/lVQKxJz4GHe9ifF1JhHTUIg56qMI+SgSQBfHidajlZaIW5O0a+6FAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C968606A31A
	for <linux-cxl@vger.kernel.org>; Sun,  8 Nov 2026 02:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C968606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso655626eec.0
        for <linux-cxl@vger.kernel.org>; Sat, 07 Nov 2026 18:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794104427; x=1794709227;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HRpb0ZNgMoAuUWmIwHiaFI9curVX3i22DFTskIwhq1w=;
        b=yw92UXdMQJ9ajFlkEXvv/aasct+EIhM3OL7T0h2lurygmy87T8YzI1mhArLQZ7zWU4
         iC0Jg/WV0X947jTm2qHF4o+vaiQa0Ha81l41BkqY/8peikrXW/1gvTu5AC2fADD1f6Me
         eVsTdFtZSAeyNgC5lzCQdXSwFfZdhGIX0q/aXGlYRpY0lB60KvsueDeQJD6ZMhnnx5+Y
         GET1lmDfD6RYhvu9/pS/Nn/Ix8MoGlZ56zbrazr7ncvEIjRvTPFu74+jmTcvp7jpK3dE
         yS8SR0C0NyI8myD73A8CsWEgezziAr7Y8c2DFh1dkTKUDHUtujUW9fVXPE+VXkT05SWN
         0kog==
X-Forwarded-Encrypted: i=1; AKwUvByRKG1txW5/8VAvPMjaYJ4faR8YngtfhsHmFArX4f8729kedRJO8ifbl9WPrI5gIIcaMN3+G3sMauk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4f+IBf+QpMpTe9Yn63nwXDqdWCl6ItdnsOeXft1Xe2qAbtOQR
	U5nOSNevCEtpq4BQ4DUgnQ5ZTEvlu1klqYbd3S0bM8JkUJap4Cbn8XEIb7L/Brmdb/xVRrtCqUc
	NlrjzXb+i
X-Gm-Gg: AYBFou1+hdB5UFxNiPNymPuU4NAKPe6Oj4HVsdSfVfB7Yse2eiiMFlkPU0Ufs7tim2T
	/Wzb3pNpBknzk2kb/YgWHnxgw773TldAmaWdp234ffSdO/O85gt7GBSfJ+p9Llr5nGsf9zUteqy
	7yzw5oBlMJbTW/q9FaAA/zImg17buKJtPhGmaXPo1ms5zXFBwg4J/57D4rfbkCADBHkZJluB43z
	kZ2M/h48HWtzguC9RWNIVIsgJ9TmHlpBXNKt6wloPXygjUY17tS80oLIu9AJmjVvMJ74qjIcSOi
	ykO98l/di4LZp9OsfVYaF/i6XwdcQ9EWqd22X6tfWyHRRQ7boQbb9LGhad0wyGAcnNShwbFDKq8
	nqrw57B7D2L8G8VHAaDAwDVcRh3xgBc3BHOwR+A3yNSX2NUtPbp7OJo8oLQiaJtRum2roU/4MAp
	7yxpOLT1Ybebt/ku5q4RAPekzRI/nk1+ByAjg+J5g4gUUUX7Hprk1jq0DRpREb504JN4zaR9yxj
	p6DQHw8o1xjbw64UR2d1WfJaSyP2nZG9eV8g7in0cxPsvs4ajcTJGKxgkYZq/Bp7v14QBLvBQ2M
	f/DJeAPgEaVSO/80plzBjTA4LQIgIx/sD5TCKEqUnkDvShyS7mM/aUdGyHErveOnk0CD9Ps7bsb
	3wBOrQ2m+4bNz+v81USKmbyJhcIOrFzR9ux1vulY=
X-Received: by 2002:a05:701b:290e:b0:152:3812:496a with SMTP id a92af1059eb24-1b39ff278bcmr407982c88.43.1794104426444;
        Sat, 07 Nov 2026 18:20:26 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314626dsm3027961c88.1.2026.11.07.18.20.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Nov 2026 18:20:26 -0800 (PST)
From: Jongwon Lee <ai@linux.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>
Cc: Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Richard Cheng <icheng@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] cxl/edac: Fix event record lookups for memory repair
Date: Sun, 08 Nov 2026 11:20:22 +0900
Message-ID: <20261108022022.3352-1-ai@linux.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

This series fixes how the memory repair path looks up cached event
records.

Patch 1 fixes a use-after-free between the repair path and the event
path. Sashiko's review of v2 found that the repair path reads cached
DRAM event records without any lock that stops the event path from
freeing them [1]. This race was already there in cxl_find_rec_dram()
and cxl_mem_perform_sparing(). Patch 1 does the DRAM lookup under the
xarray lock, and copies the record out for the sparing path.

Patch 2 makes both lookups skip records that the device marked
NOT_REPAIRABLE. Since the General Media lookup now reads the record, it
also takes the xarray lock.

Patch 3 is the DPA flag masking fix from the earlier versions. It has to
come after patch 2. With the masked key, the DPA from the trace event
matches a NOT_REPAIRABLE record, so masking alone would let such a
record be repaired.

I used xa_lock() for the race. kfree_rcu() would need a wrapper struct
with an rcu_head, since the cached records are copies of the event
structures from the spec. The lookups only compare a few fields, so the
lock is held for a short time. Taking device_lock() in the repair path,
like the event path does, looked like it could deadlock with unbind.
Unbind removes the EDAC sysfs files while holding device_lock().

Changes in v5:
- New patch 2: the NOT_REPAIRABLE check, split out of v4 patch 2 and
  placed before the masking patch (Li Ming)
- Patch 3: rename cxl_rec_key() to cxl_rec_dpa() (Li Ming)
- Patch 1: drop the found variable in cxl_find_rec_dram() (Li Ming).
  It now returns rec. I said rec != NULL in my reply, but checkpatch
  --strict warns about that.
- No message is printed when a NOT_REPAIRABLE record is skipped. The
  trace events already show dpa_flags='NOT_REPAIRABLE' for it. I can
  add a dev_dbg() there if that is preferred.
- Richard's Reviewed-by on v4 2/2 is not carried over to patches 2 and
  3, since that patch was split.
- Rebased on cxl/next (e44dc3a303), no conflicts.

Changes in v4:
- Patch 1: copy the whole struct cxl_event_dram out instead of only
  validity_flags (Richard Cheng)
- Patch 2: make cxl_rec_key() and cxl_rec_not_repairable() static
  inline (Richard Cheng)
- Cover letter: describe patch 1 first (Richard Cheng)

Changes in v3:
- New patch 1 for the record lifetime race (Sashiko)
- Patch 2: General Media lookup under the xarray lock, returns bool

Changes in v2:
- Moved the Claude Code note below the --- (Dave Jiang)

v4: https://lore.kernel.org/r/20261102123233.74598-1-ai@linux.com
v3: https://lore.kernel.org/r/20261101013418.87326-1-ai@linux.com
v2: https://lore.kernel.org/r/20261031161121.15948-1-ai@linux.com
v1: https://lore.kernel.org/r/20261030072721.31970-1-ai@linux.com

Testing was done in QEMU master (b574eaf) with a CXL type 3 device and
a committed region, on top of d89e1d186e. Debug options: KASAN,
PROVE_LOCKING, PROVE_RAW_LOCK_NESTING, PROVE_RCU, DEBUG_ATOMIC_SLEEP,
DEBUG_LIST, UBSAN_BOUNDS, KMEMLEAK, hung task and soft lockup detection,
booted with preempt=full. The unpatched results are from the v4 runs on
the same base. Not tested on real CXL hardware.

- Repair table: DRAM events at 0x1001, 0x2000 and 0x3002 and General
  Media events at 0x5001 and 0x6002, then a repair request on all five
  mem_repair devices for eight DPAs. With the series, 0x1000 and 0x2000
  succeed for all five repair types, and 0x5000 succeeds for PPR only.
  0x3000 and 0x6000 (NOT_REPAIRABLE set), 0x7000 (no record), 0x1001
  and 0x3002 fail with -EINVAL, same as v4. With only patches 1 and 2,
  0x3002 is rejected, 0x1001 is accepted, and 0x1000 and the PPR
  request at 0x5000 still fail. Unpatched, 0x1000 and the PPR request
  at 0x5000 fail, and 0x1001 and 0x3002 are accepted.
- Race test with a test-only mdelay(20): the host injects DRAM and
  General Media events back to back. Some DPAs repeat, so xa_store()
  replaces and frees records, and there are enough distinct DPAs to hit
  the overflow path. Four guest loops request repairs on all five
  devices at the same time. Unpatched, with the delay after xa_load()
  and after the lookup in the sparing path, KASAN reported a
  slab-use-after-free in cxl_do_mem_sparing() after 120 s. With v5 and
  the delay after both xa_load() calls inside the locked section and
  after the lookup in the sparing path: 600 s, 10650 repair requests,
  241298 events, no report.
- The same race test without the delay: v5 ran for 1800 s, 67830
  repair requests and 988817 events, no report.
- Unbind test: two repair loops and the same event injection for 600 s,
  while another loop unbinds cxl_mem, waits 2 s, binds it again and
  waits 3 s. v5: 82 unbind/bind cycles, 8838 repair requests, no
  report, and mem0 was still bound at the end.
- kmemleak scan at the end of each run: no unreferenced objects.
- Builds: the x86_64 test kernel with gcc. For drivers/cxl/core/edac.o:
  W=1 after each patch, sparse, clang W=1 for x86_64 and arm64, and
  CONFIG_CXL_EDAC_MEM_REPAIR=n, with no new warnings. The series
  applies to cxl/next (e44dc3a303) and edac.o builds there after each
  patch with W=1 and no new warnings.

This series was developed with Claude Code.

[1] https://lore.kernel.org/r/sashiko-outbox-192042@kernel.org

Jongwon Lee (3):
  cxl/edac: Read cached DRAM event records under the xarray lock
  cxl/edac: Skip event records marked NOT_REPAIRABLE
  cxl/edac: Mask DPA flags in the event record cache key

 drivers/cxl/core/edac.c | 113 ++++++++++++++++++++++++++--------------
 1 file changed, 74 insertions(+), 39 deletions(-)


base-commit: e44dc3a3037346354ac0dcd70415a7e049fab059
-- 
2.55.0

