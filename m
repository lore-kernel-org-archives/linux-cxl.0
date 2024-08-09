Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DC0624
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230626; cv=none; b=fsEn+f/C4xkz/LIXC8DZjQRVkgcJBWYZhwnxu444YXWEyTjUU0Hdc72AjuMYGtyfPORZco8ttn04h1h85oE462JhIMPsGbOs57Di6EJSSw10dWxr+pwm3BwgYo9f3AXhPZvGwVCM9ctxXSiR/UFbapZYFTlAu5Zv1w06MjbSl7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230626; c=relaxed/simple;
	bh=vAYMu5+gToEM7W0TgVbNo60e7hW9j/PdVzy9lkQr96g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iNoCAOxSOecNERnxKjeeG/zB/l0H4v2Cv3WFz3wBRdxiSMoGJ32C4Lr2rkciT3O07bQuChtaMcLo4OuTC9beya39IJa2RRqE0uy3tzYgceNYzMKGtkSDDKD5OV5g3DgZzfPW4uPPRJ5t8RCEIL0x6zO5W/Ufk9RdYwWKbAfuakI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=uckRFvV1; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="uckRFvV1"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1d42da3baso152627085a.1
        for <linux-cxl@vger.kernel.org>; Fri, 09 Aug 2024 12:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723230624; x=1723835424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o9iV2vbRkMRwI36Z4VJPdIDCj9RUg+36U4enIZc0tT8=;
        b=uckRFvV1/LsTPhnsgFLnrQlMpkTBuhG3eXeojz5jHiQvQS+CKHIEwY1Nfkwmx/juld
         1IaMmUq7njXtbhsvHeUcKZQ7nRuGRkP5cPe7a5x2m9wxp+GdX0//ueJga2gTukJ888QF
         RIk7z3IeJwdl33ZyVrk9QgzA8Aybmlvowspw8XTuTOaI5zHzT+WStUMFMY7HbedPqDSu
         BiZbkfLD8fYNrOl6giVKPpRv0O6P4zvmU8dnG5wjAg5s+opzX/4E2CVEVzWi5y7Z9473
         JEOWxf1MISLPadI2fmostz9yuFggYzV2qUlb5khEzE/FkS4tZE6dYgmDh5eRwh53ttgT
         4EzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723230624; x=1723835424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9iV2vbRkMRwI36Z4VJPdIDCj9RUg+36U4enIZc0tT8=;
        b=cinwFFoR1y0AF65wmMxYkzKEAUcaDVmi+WC2qErkoYit3mzvc6CLhnR9bTr5jemdL1
         N33ZqyxIWpXqt6zfe6J5zdHhsDH0fYTfKqgz9ohe7tcXv2Cdsz9uA3FSj7f1mivk0Eyz
         31YoOlGRv6r4BuQaehPOYzZyamjhp9gpim3DV+FsJmq4nXgLdYWh34u4eBEYA3Ddj5eY
         HHZPfjkHXnRHvg6zsKgKd8ofRfwYD0LufDqFLsZ1NUjw7e6rI+0MgJeA1hhZ2yl3AkN7
         344AxMKl3vAw8C3BLooLDIyKstNwHsiAiMW/poOlsVZgJxPong4BWBSANhQGlmVmoCc5
         TPLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGLtB1a5avsG8/b9Iv3NWDK0h2tbr+n9xvB1zlOEcuzdkoxJYorDYa0rWmn+UOlOgpjQ8WdCv2sv4ayXmoneW1117ZXRM6JERA
X-Gm-Message-State: AOJu0YztCbwyYRNaQts8pJBHjYVAivdZzuXR6B614ReTqpGEFEospGys
	UxkVsV1iUkUjxuLpgjrXHofGfqedZaZ2Yt4P+m4yeQ2WHK+8Np8bg7ZKwv00ZdM=
X-Google-Smtp-Source: AGHT+IFg8hx8a43JYt48V2DzftFYWno8moyxBq05V1X3Uw/96SIO96frfXFhv6JTrc9ZbeZ0FeRecg==
X-Received: by 2002:a05:620a:4045:b0:7a1:c431:3587 with SMTP id af79cd13be357-7a4c17def6dmr327493885a.32.1723230624200;
        Fri, 09 Aug 2024 12:10:24 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7df5a55sm5522085a.86.2024.08.09.12.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 12:10:23 -0700 (PDT)
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
Subject: [PATCH v5 0/3] Fixes for memmap accounting
Date: Fri,  9 Aug 2024 19:10:17 +0000
Message-ID: <20240809191020.1142142-1-pasha.tatashin@soleen.com>
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
- addressed a few nits from David Hildenbrand
- added Acks, and Tested by's

v4
https://lore.kernel.org/linux-mm/20240808213437.682006-1-pasha.tatashin@soleen.com

Pasha Tatashin (3):
  mm: don't account memmap on failure
  mm: add system wide stats items category
  mm: don't account memmap per-node

 include/linux/mmzone.h |  2 --
 include/linux/vmstat.h | 22 +++++++-----------
 mm/hugetlb_vmemmap.c   | 13 ++++-------
 mm/mm_init.c           |  3 +--
 mm/page_alloc.c        |  1 -
 mm/page_ext.c          | 18 ++++-----------
 mm/sparse-vmemmap.c    | 11 ++++-----
 mm/sparse.c            |  5 ++--
 mm/vmstat.c            | 52 ++++++++++++++++++++----------------------
 9 files changed, 49 insertions(+), 78 deletions(-)

-- 
2.46.0.76.ge559c4bf1a-goog

