Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660533;
	b=ktgjSTXpxJukCD2fBBdO2A7c4yEmS5spt24ZtcRBn8sI6mj5bAMfHAOgBSH4HahRaUiC
	 CoaFL55PKMewz8h8MEzyXwH8Gh2cTEL+sGcWpmN8YwyBHEb+XcU1Tfjl2CJ6AGP8kfEuu
	 pJ16+hdGLzLOdDsbqUBgv8mCKcFrZgMvJ8v3Ree/QfKXASqMBZ9/yD2cqI9Pu9U7oG0t3
	 zmtRLkCyPkQKHztK9SRT6phw/nXs7jxOFcS2P1OgbYpM478IvjelslfmjJvSHsxz3+Ogg
	 9Q5gjI4jhQPqqq3lRXWkrbC+1jBEgPL82VywdoxZzMOAi+B39PQZFvp5YsSdtbG9rnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660533;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=TLKltpFTvCBeWSNaBoTW1xp096x+k2FfaL+MU1v8opA=;
	b=KS18dC0vXcZu26FT6Xe1PDIRr1nCAV+L2a7AV2ZP9Cbs/L19KJL74RYiKRuuoUOBYxYh
	 m9hZPucuxf+4b61/Ggv0b4DZGRL6rypvZ+UrtjnOghPv2ith9KlMC6NDqdgqSuGDzVaNC
	 LXPgwt9cPQVRUQx0fKMJ9q/B4+UbXmb77+rm/7yZ0WTWDzaoGqU6ktzPpDYUs8LFkV58F
	 E2R0SF5EKTDqQdIU+lXmzVkk2FvLutpLIOm1F2J9zLHif67oXTrmBrmlgpbJI/JxiQ44c
	 Wf0Q7AQS8R481xDtlE8k0M5zwef3plAOSTPB2cm3BSWytL+kMpXYP5bCfd6VlUb5tkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B25C606A321
	for <linux-cxl@vger.kernel.org>; Thu, 26 Nov 2026 02:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B25C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-386d1859e1cso1118883eec.0
        for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 18:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795660532; x=1796265332;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TLKltpFTvCBeWSNaBoTW1xp096x+k2FfaL+MU1v8opA=;
        b=Fs58BArB+igst+i4njrq498E05QxxyKPnoNFhUSBga1YRhlIJ7No+sl1I7UtY9e1te
         XbY3Sdn0BgaJXdHeW2j0aglexWI8v4iAeufh1jbqS0tUqB/BUKQCAHGOS7piB4NjOlFk
         w66FrhrDeNkG4oYfOuzCfshmaZ81T7JFw5zzRV45BpXvRQdQqhgdM94oHVAZFH8uPCFh
         WlyxsVAP9nCt71szDFb9+7YbPirmivud2WsGBArBLGnAmirBQ1OAUBHQGQgG3oZgmf/J
         Nr0y76mrq4AFU4fnGB5NVPOwnXo6YCKPmVNNswwmt3r75ayX3L70MSkMD4+ZEkNADyMu
         5X+w==
X-Forwarded-Encrypted: i=1; AL+hErEHEni623Xm6mciSIscBlZtGN5gAo/2P3QZNAalGBI+XBz6756+AArmnllvWoliUD5p/CU35qNiP9E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ajX6Rkc2FgVXBWUnnU0kZRrVfhQCDZxfPoGg0j5vASxBm449R
	CFjrLrvsYmQaBiUIm2QcYSNYxj7kA0QHfUops67PixiNGpVmc23u+ulHnWCaddDpzTLl
X-Gm-Gg: AZFdTZeADz8O2228bOEO+j9JRkgyIXe/P12nvR/LfRkcya/NsIi27W2uum5F0LVvzIN
	wIuLji7pGFI2qZcx6XSHSJSe2GnNwdC5rWKAFd1D4g2cpGbeNIDV2nnxvakSn/aVZUeClwLBeVW
	mc0ubj1rENqFswO8NSoqoEQ843R/djZZoginnaqc/H99MJ+dbwfK3kEjQXn2rKFJlWr5Ud4oUSW
	09+E4iJR4vN1VTAeTYtPmqMxW4bA734DGx6LOX6p2u9ciTa06Y3rz66bOAPxY5OgmvcO3WU6C0g
	/ONRHsR1rKyast9kpkJuGTL0JGTMn0TDTz8SWkSJdV5EWF+jyA7foR0gg6zQk5OxDa7jHKp8wU3
	C+cidNa7eVT5PtvPhH4rJx4tkHaO3wYNKVKyll5yltHQLyzq8d37oDx3cM0nQflQODLAZTGxb6E
	EaGBTLY6/PPCVTDcBn+Eh7+hRwsm9SZdZbEjnDbVUDmLj6q6nx8UehNSm52XhSt0YvAyTEQ2b1s
	7p6LB9MGvq4xakFCnmMVNN79jfyFd26xVGQUaFJUbvNci38RwRm53inpyUqKbKDTMckjGIGdM7Y
	M55yg29S+4a7HfbSRVOJZ/5tsSeiUWvFHuL8js4GQNfzzi1M4g==
X-Received: by 2002:a05:693c:884d:b0:386:d9ab:5cf4 with SMTP id 5a478bee46e88-386d9ab6c21mr1512813eec.3.1795660531373;
        Wed, 25 Nov 2026 18:35:31 -0800 (PST)
Received: from alanui-MacBookPro.local ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b1965c02sm26703230eec.27.2026.11.25.18.35.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Nov 2026 18:35:30 -0800 (PST)
From: Jongwon Lee <ai@linux.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>,
 Michal Schmidt <mschmidt@redhat.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] cxl/edac: Fix event record lookups for memory repair
Date: Thu, 26 Nov 2026 11:35:20 +0900
Message-ID: <20261126023520.39368-1-ai@linux.com>
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

This series fixes the cached event record lookups in the CXL memory
repair path.

Patch 1 fixes a use-after-free that Sashiko reported on v2 [1]. The
repair path reads cached DRAM records without a lock, and the event
path can free them at the same time. The DRAM lookup now runs under
the xarray lock, and the sparing path works on a copy of the record.

Patch 2 makes both lookups skip records that the device marked
NOT_REPAIRABLE.

Patch 3 masks the DPA flag bits in the cache key, and depends on
patch 2. With the masked key alone, the trace event DPA would also
match NOT_REPAIRABLE records and let them be repaired.

I used xa_lock() for the race. kfree_rcu() would need a wrapper with
an rcu_head around the record structs from the spec. Taking
device_lock() in the repair path could deadlock with unbind, which
removes the EDAC sysfs files while holding device_lock().

Changes in v6:
- Rebase on cxl/next (32af7819352b), no conflicts
- Patch 2: rename cxl_find_rec_gen_media() to
  cxl_check_for_rec_gen_media() and split the two tests (Jonathan)
- Patch 2: changelog wording for the online repair case (Alison)
- Patch 2: drop the Fixes: tag (Jonathan). Patch 3 keeps its Fixes:
  tag, so a backport of patch 3 needs patch 2.
- Add the Reviewed-by tags from v5
- Cc Michal Schmidt for guard(xa_lock), as Jonathan suggested, and
  Ben Cheatham as a CXL reviewer

There is no guard(xa_lock) in the tree, and the 2024 patch for it [2]
was not merged. v6 keeps xa_lock()/xa_unlock(), and I can convert
these sites in a follow-up once a guard exists.

Changes in v5:
- New patch 2: NOT_REPAIRABLE check split out of v4 patch 2 and moved
  before the masking patch (Li Ming)
- Patch 3: rename cxl_rec_key() to cxl_rec_dpa() (Li Ming)
- Patch 1: drop the found variable in cxl_find_rec_dram() (Li Ming)
- Richard's Reviewed-by on v4 2/2 not carried over, as it was split
- Rebase on cxl/next (e44dc3a303)

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

v5: https://lore.kernel.org/r/20261108022022.3352-1-ai@linux.com
v4: https://lore.kernel.org/r/20261102123233.74598-1-ai@linux.com
v3: https://lore.kernel.org/r/20261101013418.87326-1-ai@linux.com
v2: https://lore.kernel.org/r/20261031161121.15948-1-ai@linux.com
v1: https://lore.kernel.org/r/20261030072721.31970-1-ai@linux.com

Tested in QEMU (master b574eaf) with a CXL type 3 device and a
committed region, on cxl/next 32af7819352b, with KASAN, lockdep,
kmemleak and preempt=full. Not tested on real CXL hardware.

- Repair requests for eight DPAs on all five mem_repair devices. With
  the series, 0x1000 and 0x2000 succeed, 0x5000 succeeds for PPR only,
  and NOT_REPAIRABLE (0x3000, 0x6000), missing (0x7000) and unmasked
  (0x1001, 0x3002) DPAs get -EINVAL. Unpatched, 0x1000 and PPR at
  0x5000 fail, and 0x1001 and 0x3002 are accepted.
- Race test: event injection from the host, four guest repair loops,
  and a test-only mdelay(20) after the lookups. Unpatched, KASAN
  reports a slab-use-after-free in cxl_find_rec_dram() within seconds.
  With the series: 600 s, 10,950 repairs, 274,946 events, no report.
  Without the delay, on the previous base (2101c39473a0) with the same
  code: 1,800 s, 98,220 repairs, 1,155,590 events, no report.
- Unbind test: cxl_mem unbound and rebound in a loop during repairs
  and event injection. 600 s, 78 cycles, 7,260 repairs, no report.
- kmemleak finds nothing after each run.
- edac.o builds with W=1 after each patch, sparse, clang W=1 (x86_64,
  arm64) and CONFIG_CXL_EDAC_MEM_REPAIR=n with no new warnings. The
  series also applies to cxl/fixes and v7.4-rc4.

This series was developed with Claude Code.

Thanks to Richard, Li Ming, Jonathan and Alison for the reviews.

[1] https://lore.kernel.org/r/sashiko-outbox-192042@kernel.org
[2] https://lore.kernel.org/all/20240228135352.14444-1-mschmidt@redhat.com/

Jongwon Lee (3):
  cxl/edac: Read cached DRAM event records under the xarray lock
  cxl/edac: Skip event records marked NOT_REPAIRABLE
  cxl/edac: Mask DPA flags in the event record cache key

 drivers/cxl/core/edac.c | 116 ++++++++++++++++++++++++++--------------
 1 file changed, 77 insertions(+), 39 deletions(-)


base-commit: 32af7819352bae9c690ebe277a44eceb501d5c68
-- 
2.55.0

