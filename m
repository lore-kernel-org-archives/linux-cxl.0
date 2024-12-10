Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD6B2451C4
	for <linux-cxl@vger.kernel.org>; Tue, 10 Dec 2024 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733868348; cv=none; b=MfofyGYeTeH+9NY1EAZk2ATXb4mAAe2mxhE5h+Lcd3Yd1nFTH7R5E132LggHJ9i6PK51jdVowhB7u5riFwt+WVuCdYXa2GON8jfMtfae1M0IutYUXfWIntAW1QU2rj/5AYEbjU7JOD09u2jruRdQ/JOnyyoypmNt7QGQMc+wj8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733868348; c=relaxed/simple;
	bh=KBDt8XQ6WNq8J6YT/YXtGkmxgvjSQrEexeJW45WGLKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YuemRdfTDiAiokFWOah4AKdGnPvCZds3hS++t+x1hygLg4G1TApp8T/rh+lndlAbtnwVkoQ3LjI6rzEGUhk2GRec566G/PBCd33l/K77hfasN72GEyTlavrCTiZ8CPNGptXTRy4SSALkkvNHwddtEYReCiU9IVPoNDgq6PJ2N/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=EKyqi0SA; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="EKyqi0SA"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46785fbb949so8097341cf.3
        for <linux-cxl@vger.kernel.org>; Tue, 10 Dec 2024 14:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1733868344; x=1734473144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UvgUsC8+OSYl1zj6uOGNQd8LMwZ5SWRB4r93/t1srT0=;
        b=EKyqi0SAOzaLREivAT5m86LSRa8vpURY+dfI+Hak+CWSxB+IGJwwyRjxHtyvXXqXlr
         woAloMsCwaMpcvVE96l0aXgOTXXkJWc4AaPatHolzpf/qorAf3stHaV7Cd5hIUtTS1Gj
         UsrYBv+3ajzOxvS/6OxkmDq2oyi/S85L0B4rPHrHIqswwk6PSKh6cWb1JQ89U0m7LLaT
         FvbSwLTv051+JsrVtV86eJ2lEI56yi9fLwuaQ2PQ9y/aOEqkjj6zUdYXtp7HfGHJ2p8u
         xHKI0dHw04H22IKv2P3s/VH5l+OHw5Z4gFIIgZYmZFLKAykTjrTnfm8burSC5Usxvz85
         q98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733868344; x=1734473144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvgUsC8+OSYl1zj6uOGNQd8LMwZ5SWRB4r93/t1srT0=;
        b=dtFUsgEmbo9BYH+jeZF5ljWvv+AsyU2rwvsuTmBzedztnjitQpXMXhfZWeNWSVB6xo
         gXpsE5FNjdDGLApeRQOvtQ80T0DmT4YBUnkvvwL7Bb1Y64Z7DwZGSdKsK7iQfmfo3fHG
         1O0RFxPHvwqLxqq+V78EXw/ijKbKQpFJ2rk69+JU+eMqpNHT40Uc4zV2I+N/2JXkO4HJ
         yvvcdvSKnRsKlIonTn95Ww9NC7g7nSxFHC1cR4ZaZpr/y/N6FmNJTbbjADs8heJuSK3s
         e3YaiTUoyXYpstSiJiydJ7vybjBlHhi4WBuTY5vL9ZuuTTNjF4WBjdUHscM094LaHtbA
         NbMw==
X-Gm-Message-State: AOJu0Yzq3tdrm2VzaTvqz5hZ55tGd1ILNHMKh5bbb6Y8NqpHxQWqZVOy
	5+DFF6P9sL8ok9hvRxtn5twfo/1BYMzi8Gi8+fNnZmnazeFJrHV/DTEFdolNlbg=
X-Gm-Gg: ASbGncsEPLsS21duLC6o9wWMsxh3JQ2gosf1hN3tPhSQTMtVTQ0ttS+zHjNymtw+Yzl
	lNDYH1INEGKXzrl0Yqa8FOGZ63F0+XBzBETgnjTLNmyglQbVGPAAdPs0F5nIDoBmNEjXeSDqvUS
	arlixtpQFv2olrAGjjyPgIBUqbFYuZxsUa5BEPK8d/rTo99m/In1g84YcT969lkWAbae81Bx86R
	yeNvqTq80rKjQ7KQj0TWVnQlyIxTPNuhm2pT3JNyMmWmz3PDm7uYYf3vczfBQUl96ZoEjZFA0oB
	7SeKfHwZLP6/DOFd1eQr15scITCW0jGpDKTRRHA=
X-Google-Smtp-Source: AGHT+IE5ydpoL70LSKM9Nla3l7Xx3LL3OIA9p7ihHnld0+zQW3qbNmeKX9aX6FlxL/xgIC54FK+x8g==
X-Received: by 2002:a05:6214:20a3:b0:6d8:b3a7:75a0 with SMTP id 6a1803df08f44-6d934c161d4mr12732836d6.47.1733868344301;
        Tue, 10 Dec 2024 14:05:44 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8eeb132e1sm49707756d6.35.2024.12.10.14.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:05:43 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	ira.weiny@intel.com,
	gourry@gourry.net,
	dave.hansen@linux.intel.com,
	david@redhat.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	osalvador@suse.de,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v7 0/3] memory,x86,acpi: hotplug memory alignment advisement
Date: Tue, 10 Dec 2024 17:05:14 -0500
Message-ID: <20241210220517.3744-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v7: collect tags and rebase on latest mm-unstable.
    ACKs: x86 MM, Memblock/MM Init, Memory Hotplug, and CXL
    Missing any critical acks? Best merge target seems -mm

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

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Tested-by: Fan Ni <fan.ni@samsung.com>

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

