Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9731190075
	for <linux-cxl@vger.kernel.org>; Wed,  6 Nov 2024 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908744; cv=none; b=Z9vvVazK/4TOeIQVW4a7r+ZVhAA8R/VsSGW5JRSEpJTGQrtMjp4tNlFfIB9/XSWDDBzMewg3FIf2lw0CZUXG9f5H2cdel4f7kO/TZ19PMBAKoCx4M6/FcZvMh27tbSf4ubYIHVY5zwSB4L5XxySHdZNHTlkcGtFtfUfr0cstkvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908744; c=relaxed/simple;
	bh=paq517tYRzuQaE6aQ3+DbbwkaZbJpXgurSOIcvPUs80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CBL66+oww6LCJG8sSs6AloLn2cPi+duMJJS+gVIjESoQTSY3LXA1bRjnRkmS1PRvyVd9jQlNJe1sNO2wvv/H2l6d56i2p5NhmLlC8LV2Cz5XCXRVWC3aoGHJBxY3t5PS64MHUAVKa7pw8RsZs0ipKiau8NW6rF3r8u+9L4m/d+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NcdK7XFZ; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NcdK7XFZ"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-50d58e5bfd2so2318283e0c.2
        for <linux-cxl@vger.kernel.org>; Wed, 06 Nov 2024 07:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730908740; x=1731513540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=onjaUxq9jxQzB8yd13QCSLIfBZyPKRSn2LqnOpXSgfY=;
        b=NcdK7XFZAaZDAVyQPd7emTKbUpZw+ER7+BJEw4hO7miWEzv6lPJVpp8EP52qNdQ92G
         r+74mWSdoNHXAa8yU8a/a4qZFaTnk9N62Pt9IHXQZrgkXJvScWApePNZsTXyNN7EH233
         mMy5Noq8weySD4iur14f9pTgp9NY6RK1f0+n6O7QyhpCri1XzPhbDj4LY/b15NOibZAJ
         C2KbfLZv1xfUkQqieuyIKghpYIL1t9mgQWHE9FXWOf36S+7+Qw72a/AROrFr6yLaeuQ+
         6LlWbfkhykV+6gO4GboPtx7v6C8KYCB8NWgDI9+nCH/GzTTBC+nsoVWvrnSRlExfJ52j
         /xNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730908740; x=1731513540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=onjaUxq9jxQzB8yd13QCSLIfBZyPKRSn2LqnOpXSgfY=;
        b=gZeLLZcZMSV8qmWU/jRoIJagF2wAd0Q172+rIcZVtN9uNmfZmDYDKjKLMCUFhDiGFv
         vc5k7PXtmhu5SzpqSFtdnYKKJyEnkBa0EP7zdXb5vfNjTh5l8KquSvLYcgeSKI9culFY
         v5xBaaVqx4g0z3PJhuSTElG5qJwAi3KfSzgC4pwWjHX3UiU10FnHmeG0bHGlpVIn1xKL
         fFeEh7h68UL2Nc87gGYCTNoLlKQYZ1xmKwjwhZnhCdoLA9wNLQ/g33jrULG2/iZC59hn
         5vz3PIlimdazgj683AJDQ83RsfJcZOAvUH4jBRlJ1DsdPF687WDWDv/WIps5nShOFh5P
         MM/Q==
X-Gm-Message-State: AOJu0YyUuqiRw60cCiM+v/quJzPdIw5N3CitdATQyBV50VqYQ6rYGKr6
	qFZn/S95+9Q1DMFjo+LBf4OFzSB0J0Q22Q06U3onrmBENyNcoqUtqv2nUh1apLOX3/xx28NifD1
	7
X-Google-Smtp-Source: AGHT+IEjVTXnrrJWDoPU07CCpmZR8Q4L/phPwYQPM8ei+fLWgcGnZ72fL5YgaRfLrc0OC1cc+i5L0g==
X-Received: by 2002:a05:6102:3a09:b0:4a3:c3cf:42b1 with SMTP id ada2fe7eead31-4a8cfd573a7mr37335611137.26.1730908739921;
        Wed, 06 Nov 2024 07:58:59 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39f7b85sm641377285a.31.2024.11.06.07.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:58:59 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	Terry.Bowman@amd.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	gourry@gourry.net,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	rppt@kernel.org
Subject: [PATCH v6 0/3] memory,x86,acpi: hotplug memory alignment advisement
Date: Wed,  6 Nov 2024 10:58:44 -0500
Message-ID: <20241106155847.7985-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When physical address regions are not aligned to memory block size,
the misaligned portion is lost (stranded capacity).

Block size (min/max/selected) is architecture defined. Most architectures
tend to use the minimum block size or some simplistic heurist. On x86,
memory block size increases up to 2GB, and is otherwise fitted to the
alignment of non-hotplug (i.e. not special purpose memory).

CXL exposes its memory for management through the ACPI CEDT (CXL Early
Detection Table) in a field called the CXL Fixed Memory Window.  Per
the CXL specification, this memory must be aligned to at least 256MB.

When a CFMW aligns on a size less than the block size, this causes a
loss of up to 2GB per CFMW on x86.  It is not uncommon for CFMW to be
allocated per-device - though this behavior is BIOS defined.

This patch set provides 3 things:
 1) implement advise/query functions in driverse/base/memory.c to
    report/query architecture agnostic hotplug block alignment advice.
 2) update x86 memblock size logic to consider the hotplug advice
 3) add code in acpi/numa/srat.c to report CFMW alignment advice

The advisement interfaces are design to be called during arch_init
code prior to allocator and smp_init.  start_kernel will call these
through setup_arch() (via acpi and mm/init_64.c on x86), which occurs
prior to mm_core_init and smp_init - so no need for atomics.

There's an attempt to signal callers to advise() that query has already
occurred, but this is predicated on the notion that query actually
occurs (which presently only happens on the x86 arch). This is to
assist debugging future users.  Otherwise, the advise() call has
been marked __init to help static discovery of bad call times.

Once query is called the first time, it will always return the same value.

Interfaces return -EBUSY and 0 respectively on systems without hotplug.

v6:
- boot_cpu_has -> cpu_feature_enabled() in x86 code
- ack tags

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>

Gregory Price (3):
  memory: implement memory_block_advise/probe_max_size
  x86: probe memory block size advisement value during mm init
  acpi,srat: give memory block size advice based on CFMWS alignment

 arch/x86/mm/init_64.c    | 15 ++++++++----
 drivers/acpi/numa/srat.c | 12 ++++++++-
 drivers/base/memory.c    | 53 ++++++++++++++++++++++++++++++++++++++++
 include/linux/memory.h   | 10 ++++++++
 4 files changed, 84 insertions(+), 6 deletions(-)

-- 
2.43.0

