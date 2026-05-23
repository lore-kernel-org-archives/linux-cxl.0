Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461A333D4E8
	for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529852; cv=none; b=tzemIex/9c21VfyACXyUx1GpDuPLsQJyv3efkRyfCtTCAsWhSfB8JzX+/pf7BkMeq5OS9srMsyOndTRcmkRQB2ResRG4CQh9XVKjFU3RmJIDbmcc3+9n957KTbSM8YZ3+bGCzCJbis2bPQ2X1T73nxOVbLg7Z/CBRXKlUHjtC58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529852; c=relaxed/simple;
	bh=wpJgigQKuEhvMpP7Og+WZKRi2n7dbupMECmkwtjor90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R079AgFAVmbKQaTYx7U3w+1IOTYtsZoVVLQQFhV2p+w1/enmY6sQLIG9sY5bDVBvkJAqgubXjJMzcxGfTiJpnTVAOrcg2W60MoSZwyAKHwyGTu2J1GRI8a4cyUk30UY5pGPbveqKgIfJqdjm10jcxbC5pOEZSp002rsNv/X7j/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQe05oYX; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQe05oYX"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2f33ae12f97so2856649eec.1
        for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 02:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779529850; x=1780134650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WI8driggD6+32XemxaaLDgZ7NuXnmEQpi6CnLMIKw2o=;
        b=dQe05oYXU+7HUKdptbRDp3sWSK5EXhoOeb6WkQmF7PPMRtj5s+T2LWq5QPEGTl7E+N
         ccLNYraE+rgfZNwcpeaMZTtfpMeQ+Setdiej7jCb6ZyDx+9eJhtL6YYy1h2WU2RJgvk2
         yrteAlMW4/jrDZEgALRXwwhRVsnwB5WRNYoFWW2jLkel4DZm2ruhxLaqsnDnmMXh2IUg
         9GzqQ4wskPF10Xit2n9wdy9j8t2MYCCcSo1Frhv0S9asapg2iQmktQDMg97M/ff3ZbGZ
         NpLsLoX7/73vbr4sZUDniwTvMHmZ5NcdYuN3fP7aaLQVlT9yG88xk4u88N1AH3eOed82
         zKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779529850; x=1780134650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI8driggD6+32XemxaaLDgZ7NuXnmEQpi6CnLMIKw2o=;
        b=mvvkL8AKarkavN2drza+U7hwuHt3Ckd9In+nLTc6dKj0YSVs9ttRn8BjOtZ4bplrWp
         OIc7OtVUyP8Ucb6/q/patb+287JXVJaVId2PinU+jWbMt2CQdXl+AjWjVh7ctfNUwGiz
         RjVb5z9uoNu6FwZq3fn/sFdNhs5jxT/e5KE4+E9adhINPw+n+TPF8bW4Cza868+EM+BC
         8+YuTgzIgxsWQMXh8U19de2haNQEe1VSBLv0WAEr6KFTldfCbVNLyMYLvIj+30o1zjZ3
         diRcOqygjPIvItMLA9oGkTDym5OSmsDhhtonYVmj2WJkRWQkTNNNf2py9fmuVDzYmTip
         XjWA==
X-Gm-Message-State: AOJu0YzRflKHlhNdSplxT4LAryPqPERNugAZME3hhIB5lyircqP+xKNA
	4DchgLChvmLEbje20dcyFDsRfri98L1Vs2dYkAKeXvYiVDo/EpsoFUx1Sl5u+w==
X-Gm-Gg: Acq92OEMXzjHkUMMMunJkoo+TFO5ZNmpCZXvu57cJzepJqJHY6vMqhcIxmDhMchmgxs
	mpEWLHU9EDEtyZX7AsiTaaaenUME9uJ+ZI0vdIrB5pyv3e84Z+mxiHZZfJeqzpwEGMfIq8+Gquf
	Vs/F7xPyPYVqmBH4boIpOP/fmolWMWS43ksJZr4b9Fhd+VYKqa0ExR3L5coC5ntr58YWTXYYrNP
	SFvOQxlENzvnta74jfJrzEJVDMBw5NN+AwNhVUDE7DfFkXWwMn28hHiX/2RpFtd2yVZ0N5cpiQ9
	rDXihLMusO7oIspR5eg1Pr9s4GwPOJjSOHyfoW7p/zJog9YFQLO/qSYJX9guS3PD7XppW7eeSWN
	DQzPDFrag5pVVwWkGH4X7hu3MbOnJivFHCAAaAUfDF5miXmDQk8lWQyftJ1ubSiygynWc+Z3znS
	GAMc8nKmXG8m96EoOvcGMpSvHOy3srER7D7zFUxha7GtDs+wV5STuKATXsLg3cK347rqnke+c9O
	pmKI1z2u2CehEWtWg==
X-Received: by 2002:a05:7300:dc83:b0:2c1:6676:5ebd with SMTP id 5a478bee46e88-3044902cee2mr3463901eec.10.1779529850316;
        Sat, 23 May 2026 02:50:50 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3045225b7b6sm4595756eec.25.2026.05.23.02.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:50:49 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v6 0/7] ndctl: Dynamic Capacity additions for cxl-cli
Date: Sat, 23 May 2026 02:50:35 -0700
Message-ID: <20260523095043.471098-1-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CXL Dynamic Capacity Device (DCD) support has continued to evolve in the
upstream kernel since Ira's v5 posting [1].  The kernel side has settled
on a uuid-driven claim model for sparse DAX devices: dax_resources carry
the tag delivered with each extent, and userspace selects which ones to
claim by writing a UUID to the dax device's sysfs 'uuid' attribute (or
"0" to claim a single untagged resource).  Size on a sparse region is
determined by the claim, not requested up-front.

This series brings cxl-cli and daxctl in line with that model and
extends cxl_test to exercise the new paths end-to-end.

The corresponding kernel patchset is here:
https://lore.kernel.org/linux-cxl/cover.1779528761.git.anisa.su@samsung.com/T/#t

Picked up unchanged from v5 (Ira):

  libcxl: Add Dynamic RAM A partition mode support
  cxl/region: Add cxl-cli support for dynamic RAM A
  libcxl: Add extent functionality to DC regions
  cxl/region: Add extent output to region query

New in v6:

  daxctl: Add --uuid option to create-device for DC DAX regions
    - Plumbs writes to the new dax 'uuid' sysfs attribute through a new
      daxctl_dev_set_uuid() helper (LIBDAXCTL_11).
    - --uuid is mutually exclusive with --size; pass "0" to claim a
      single untagged dax_resource.  An unmatched UUID surfaces ENOENT
      from the kernel and leaves the device at size 0.
    - Documents the option in the man page.

  cxl/test: Add Dynamic Capacity tests (rewritten on top of Ira's
  original patch to track the post-redesign kernel)
    - Routes untagged claims via --uuid "0" so daxctl exercises the
      kernel uuid_store path; tagged claims use real UUID strings.
    - Asserts that for DC regions, size-grow returns -EOPNOTSUPP (real grow is
      --uuid only) and that tag reuse across More-chains is rejected
      by the cross-More uniqueness gate.
    - Adds coverage for the new validators: test_uuid_no_match,
      test_uuid_no_match_seed_intact, test_uuid_show,
      test_cross_more_uniqueness, test_alignment_rejection.
    - Sharable-partition coverage (test_shared_extent_inject,
      test_seq_integrity_gap) is routed at runtime to a dedicated mock
      memdev that tools/testing/cxl stamps with serial 0xDCDC, so a
      single cxl_test module load exercises both regimes.
    - Localizes positional-arg assignments in every helper so functions
      no longer clobber caller globals (the previous behavior leaked
      the sharable memdev into later tests).
    - test_reject_overlapping arithmetic now lands an actual overlap
      inside the DC region (the prior math landed past the end).

Depends on the kernel DCD/sparse-DAX series; without it the new tests
will skip and 'cxl list -r N -Nu' will simply report no extents.

The branch is also available at:

  https://github.com/anisa-su993/anisa-ndctl/tree/dcd-2026-05-21

Based on pmem/pending commit:

  bbd403a test/cxl-sanitize: avoid sanitize submit/wait race

[1] https://lore.kernel.org/nvdimm/20250413-dcd-region2-v5-0-fbd753a2e0e8@intel.com/

---
Changes in v6:
- anisa: New patch — daxctl --uuid option + daxctl_dev_set_uuid() helper
- anisa: Rewrite cxl/test DCD tests against the post-redesign kernel
         (uuid sysfs claim, tag-group atomic release, cross-More
         uniqueness, alignment rejection, DC size-grow refusal)
- anisa: Rebase onto bbd403a (pmem/pending)
- Link to v5: https://lore.kernel.org/nvdimm/20250413-dcd-region2-v5-0-fbd753a2e0e8@intel.com/

Changes in v5:
- iweiny: Adjust all code to view only the dynamic RAM A partition
- Alison: s/tag/uuid/ in region query extent output
- Link to v4: https://patch.msgid.link/20241214-dcd-region2-v4-0-36550a97f8e2@intel.com

Anisa Su (1):
  daxctl: Add --uuid option to create-device for DC regions

Ira Weiny (6):
  ndctl: Dynamic Capacity additions for cxl-cli
  libcxl: Add Dynamic RAM A partition mode support
  cxl/region: Add cxl-cli support for dynamic RAM A
  libcxl: Add extent functionality to DC regions
  cxl/region: Add extent output to region query
  cxl/test: Add Dynamic Capacity tests

 Documentation/cxl/cxl-list.txt                |   29 +
 Documentation/cxl/lib/libcxl.txt              |   33 +-
 Documentation/daxctl/daxctl-create-device.txt |   12 +
 cxl/filter.h                                  |    3 +
 cxl/json.c                                    |   67 +
 cxl/json.h                                    |    3 +
 cxl/lib/libcxl.c                              |  181 +++
 cxl/lib/libcxl.sym                            |    9 +
 cxl/lib/private.h                             |   14 +
 cxl/libcxl.h                                  |   21 +-
 cxl/list.c                                    |    3 +
 cxl/memdev.c                                  |    4 +-
 cxl/region.c                                  |   27 +-
 daxctl/device.c                               |   72 +-
 daxctl/lib/libdaxctl.c                        |   44 +
 daxctl/lib/libdaxctl.sym                      |    5 +
 daxctl/libdaxctl.h                            |    1 +
 test/cxl-dcd.sh                               | 1267 +++++++++++++++++
 test/meson.build                              |    2 +
 util/json.h                                   |    1 +
 20 files changed, 1771 insertions(+), 27 deletions(-)
 create mode 100644 test/cxl-dcd.sh


base-commit: bbd403a03fa2a1551c1a10bbf78f32027c718758
-- 
2.43.0

