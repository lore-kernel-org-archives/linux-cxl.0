Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208718F2EB
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131763; cv=none; b=jaKRQCJdQHqYVoGC/L1r9mbmh3yaYu8piiVHX8GIaxlfnN/8Ow6K50Ka1OkUN/6Bv2n+jmJKd49ARyS5IpmrsvGC8cRf4fSgIfWx9FsVDvkauaruWBO368AWrw9KCjwFwnb/M6iMopGnaqz6OjDymnj3QmARgxqfR10SpJQ4kB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131763; c=relaxed/simple;
	bh=RrfqIOuouVyiFfEs/ry+HWzLi1ojcMi58Cj0sWJhrio=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=D1R2iGGpVajMCWhrK7nflQvEBUMfqO9IUJCWXqEaXI1HI+jX40WQMcXY7I0F5Xc9cePcDQX4bOVrkNP82GCwhbh2wNGCme3I4rK4aL1pxYBB/8lyoaZRmQMlvVZTs8Bhsr5lO4ubzgZHuK9mCq1vbkSqOejaUR/I0NMRr0r/3pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=nRyZ0z34; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="nRyZ0z34"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bb96ef0e96so5964136d6.2
        for <linux-cxl@vger.kernel.org>; Thu, 08 Aug 2024 08:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723131760; x=1723736560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OoS5c7AqTIEc3lMd5dOxMQfYeBpBDya+0ZxkeiTfX/s=;
        b=nRyZ0z34N1OIErGtmme6OKx/b0JIDFYuQA702qE4KNDJsmMOFPQQrw+v7NK8l2LADG
         JVxfGUcyS4Uv5oEcnELN8CheSzLuvB3RYG7otTNVJpiAMzG1DWlPjHKQzE/cZhjdwey/
         R83h/BJ3t7RU5YFNwzFY1pFirV/SJ70viHzUFlA9Pc0Ozw1KXAc1qlx6qHzSzlkJ43Ir
         IpDpb5pK3wobseW7VoHCwGgalDuqzkY9rCvMpKWp2XoSW0Z8Nn+BXWSwBQb28MDDZWG3
         pWw4+WRx6sUnXgO18NnOaXRMxdIPTMgg97Ids06Rt24YvLEBAfS2gqh+oCiyG4uLr052
         LU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723131760; x=1723736560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OoS5c7AqTIEc3lMd5dOxMQfYeBpBDya+0ZxkeiTfX/s=;
        b=owiaH7eQ14GdH4+dMdHuku81oMwARyieUCStxoUO4ho7EZJw2WPKaCsluhbcahQzet
         9A9IHnfruvPfrEYIs6n6Hj0NMDC7D0TXju53V0xGiIcI9/amTzDCnmklRUv5ovv7ByOL
         +IzP28QLov8voy4oDCIMj57MW9qLoLMCgMCCspHMUln8fyY7X65VkkWcdT0FCz1sPQYd
         +oCKmcWQGl+MXDNdlMd+jylgnGRR/2+fONQ37ZZH+gvAzsfMhn9NMAfP3lyYfQGMRQPP
         rA9WmIc4mkrdVxDsAwSDZqP731UauVKEDYiufnfmniJVmFX5gqJUZnYM3oUp6cQ8iG+s
         uGtg==
X-Forwarded-Encrypted: i=1; AJvYcCXFWJG3+TnmCQ76nPGgx9xHRTwuadEaho/TG0wancuUe+S5+8fHXa6iTvmmRw80teCVGH+sSTo2eTah/NQPv4m1kJXNgKIo7Kdf
X-Gm-Message-State: AOJu0YwFKUSt1S17cJ/sg79Fl1ObL1F/FDMkVmhyzRNMkngHMScGztlm
	Od/bn0N1f9y8q5oOYfUvCSzZjJPzDDlkyUxwH7wKS83oQf6JuA11nI24o7J5dTk=
X-Google-Smtp-Source: AGHT+IEcL0yZePXhMPPsTPK8VSthHtq/oqJtvkGQFO/6miHrQpul5UYc/wo62QVWJrz61dTFYt0okw==
X-Received: by 2002:a05:6214:4886:b0:6b7:99f6:98b0 with SMTP id 6a1803df08f44-6bd6bccdec5mr35072366d6.17.1723131760505;
        Thu, 08 Aug 2024 08:42:40 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b72d9sm67160936d6.60.2024.08.08.08.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:42:40 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	cerasuolodomenico@gmail.com,
	hannes@cmpxchg.org,
	j.granados@samsung.com,
	lizhijian@fujitsu.com,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	pasha.tatashin@soleen.com,
	rientjes@google.com,
	rppt@kernel.org,
	souravpanda@google.com,
	vbabka@suse.cz,
	willy@infradead.org,
	dan.j.williams@intel.com,
	yi.zhang@redhat.com,
	alison.schofield@intel.com,
	david@redhat.com,
	yosryahmed@google.com
Subject: [PATCH v3 0/4] Fixes for memmap accounting
Date: Thu,  8 Aug 2024 15:42:33 +0000
Message-ID: <20240808154237.220029-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memmap accounting provides us with observability of how much memory is
used for per-page metadata: i.e. "struct page"'s and "struct page_ext".
It also provides with information of how much was allocated using
boot allocator (i.e. not part of MemTotal), and how much was allocated
using buddy allocated (i.e. part of MemTotal).

This small series fixes a few problems that were discovered with the
original patch.

Changes:
	- Added patch "mm: add system wide stats items category"
	- Changed from using system-wide events to system-wide stats
v2:
https://lore.kernel.org/lkml/20240807211929.3433304-1-pasha.tatashin@soleen.com

Pasha Tatashin (4):
  mm: update the memmap stat before page is freed
  mm: don't account memmap on failure
  mm: add system wide stats items category
  mm: don't account memmap per-node

 include/linux/mmzone.h |  2 --
 include/linux/vmstat.h | 22 +++++++-----------
 mm/hugetlb_vmemmap.c   | 13 +++++------
 mm/mm_init.c           |  3 +--
 mm/page_alloc.c        |  1 -
 mm/page_ext.c          | 15 +++++--------
 mm/sparse-vmemmap.c    | 11 ++++-----
 mm/sparse.c            |  5 ++---
 mm/vmstat.c            | 51 ++++++++++++++++++++----------------------
 9 files changed, 49 insertions(+), 74 deletions(-)

-- 
2.46.0.76.ge559c4bf1a-goog

