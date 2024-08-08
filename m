Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F50146D6D
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723152882; cv=none; b=sBoBk6EKPS7L39Ezb1XNiwXR/FMOGLgBl4H69sHVa5GwdaVJ4pdep7/SIGMn8R0zNElIg3V2QuTTqRqXeTc35lHhocGTkbu/gPC/sOnw+f/Dah03B7STiHHTlVgv8voWziSpk6LBiJ0FHEdMrkdIMK9Bq+DzSm5U8drFTKygRuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723152882; c=relaxed/simple;
	bh=RbMYgA++9fV0EBRect7rFATXup7VOfQbVaa+QMmyIIo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fLVt5vkUMP3gGhKXYXa5ZZ3iUTK2MwctI1cevTUKHEs5H9ZYVXB1PnX8P33KzLPGMM0gEbjPfr+C9jc5quOPT9uwjtXXgtkxuWYMg2b7l6tbnuek5YPVZMECgKalgtGTHORd4z02MaQjC2H9zBthOQyxDR84ostjd6aRUVVCl4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=1diaB+tD; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="1diaB+tD"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b791cddfcbso8462226d6.0
        for <linux-cxl@vger.kernel.org>; Thu, 08 Aug 2024 14:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723152879; x=1723757679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sR4Q4RBNyDlEyEtMKpSg2raAJFHhcndUnkwyiIaahuQ=;
        b=1diaB+tD2tnfjkLFy5oNsQx83WdZ4suVKYPD7HWX3jWMOp6wFSqyhyY6ofGUJ0iPFs
         LAv8ADpMmLYKRnUSDfhXNmOFx/3ChwSWCjajfaNKyfKlscjQ2V3l5i6Rb2YqKuM68/Io
         OYBFP9wKzRB0UIhRAnfo9imYHwWp68hYSQbG/ZfVFWOJlKuBy7DL6ygWRmbC63JVVmwQ
         SVusyRFrUpRYY8il4k4qWcSrkQ8a314rlx3NPFvAbwcoFCewge8C2lzytUwW6CJVbq1P
         Jux4GeEw9/BPhUjN4IqlBDNveFd5OlW/28R7BUd8lmYnDXC4C1NjV6nICfyKwL6mWEXj
         7RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723152879; x=1723757679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sR4Q4RBNyDlEyEtMKpSg2raAJFHhcndUnkwyiIaahuQ=;
        b=jVXn69SbaYHuQ4Nka3e64JiH8Ll8SW85F3Jd/DnXEgc9MZCDB+bSmUhoBAVDPEWxq5
         plG4uaXkL4l5CNA8p1wHTl3celUykANyXOvvy+O4N5hwRvOgWI+25gfCCCayctj6STMe
         /0VU0xqA2B9LUbL3TT/zsAJ5tQ9V6eMN+T2+tGfNb261xHY9nf5BUmyiWwzWVXJXDvTr
         QU2U56nB+HAqm8p9h9GpTgb93QqcWi8fQLtxxZ1yEyNB8fpZwKvKASHYCLRl05IlbeVk
         b9pa6/v+MyrJdd3k6NuwWOmE9TGD2VBrvFoTUzV3bjkuNyLDVsBcd2CKFEkyI/6EOKLV
         IX7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9GETYa6i5DPS4fvZoIvbekXFmAt4ptFEMYVEpQpb2toMjZqIqIys7TKfF1gMMJzQ90bv8uYBtzUWBiwp4sU16VY/Er++S5Mo5
X-Gm-Message-State: AOJu0YwafV6FRQiwWEWQ12ficfnNMBIQYM1erJW5WiZ0ODVJqlZCqI8O
	T/AhUu1yrg01DFC/rCcF6ormXdkKgws75efL2weMUKgD3AWTNsX6z9ek7Yzar7Q=
X-Google-Smtp-Source: AGHT+IHhBAY4jB88eZ0nLk17m3lkT6t2c4WPOVLAuUQhNq1gELh0d4mWiwBC5MNPkQLlby32mEfHBg==
X-Received: by 2002:a05:6214:33c3:b0:6b7:a175:29b7 with SMTP id 6a1803df08f44-6bd6bda2ed6mr42811146d6.51.1723152879490;
        Thu, 08 Aug 2024 14:34:39 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c762bd1sm70205026d6.29.2024.08.08.14.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 14:34:39 -0700 (PDT)
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
Subject: [PATCH v4 0/3] Fixes for memmap accounting
Date: Thu,  8 Aug 2024 21:34:33 +0000
Message-ID: <20240808213437.682006-1-pasha.tatashin@soleen.com>
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
- Removed patch 'mm: update the memmap stat before page is freed', as
  noticed by Yosry after 3/3 that patch is not needed anymore.
- renamed nr_memmap to nr_mammp_pages and nr_memmap_boot to
  nr_memmap_boot_pages as suggested by David Hildenbrand
- Added the origianl oops information as suggested by Alison Schofield
- Improved commit log message as suggested by David Hildenbrand
- Added review-by's, acked-by's, and tested-by's

v3:
https://lore.kernel.org/linux-mm/20240808154237.220029-1-pasha.tatashin@soleen.com

Pasha Tatashin (3):
  mm: don't account memmap on failure
  mm: add system wide stats items category
  mm: don't account memmap per-node

 include/linux/mmzone.h |  2 --
 include/linux/vmstat.h | 22 +++++++-----------
 mm/hugetlb_vmemmap.c   | 13 +++++------
 mm/mm_init.c           |  3 +--
 mm/page_alloc.c        |  1 -
 mm/page_ext.c          | 18 ++++-----------
 mm/sparse-vmemmap.c    | 11 ++++-----
 mm/sparse.c            |  5 ++---
 mm/vmstat.c            | 51 ++++++++++++++++++++----------------------
 9 files changed, 48 insertions(+), 78 deletions(-)

-- 
2.46.0.76.ge559c4bf1a-goog

