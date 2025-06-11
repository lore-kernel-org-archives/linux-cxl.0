Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D6727CCDA
	for <linux-cxl@vger.kernel.org>; Wed, 11 Jun 2025 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749643626; cv=none; b=EzKcnRc9cJzvLyoGUL0eVdZDYgjN8PeByzC4tb3J029MZj+G12/0i9qREhaavVGT3MZye5elUlM43H8Lr4/NGkSRgw5zz4vq+xQAS3ydS4HuTut4D1dDAT3CfQpC9zYeC48+9YKMUdJK+MFImpKmwAQQze5GEvd608ZvkZD4ShY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749643626; c=relaxed/simple;
	bh=h6QGnb8zTCnhmMnnsmFX1orisHdA4F9SQbVi0UTlgeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=k87WLFkWL0N2PRhocuRYcjQ7If0ie6FfHYcnjKZk5j1hAGAB8/AQL2/xIFbJXbEu62AThjeiov4Q9rmsESD4lepHFIIF1MBgWFO9Ga1ghUWoqcjvo5nCG+xyKVaE31JT4v/68V2/cF7fbxzNypowp1vv1UX9JKOGIEEIgYBOOCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gr75FLRi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gr75FLRi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749643623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e6LfLWwblq0nS0hH5xaHOxT0zDNtTct6Zz6olIqQVMs=;
	b=Gr75FLRikNx96/wKLPeUzIzJswcFC/dxXrLO/ul4Goi4iPD3OXsvTwqm/Y9GRyvILIKbNH
	vdaX07A6WOJNWLSgDHdM7sMzG/d59/JfTmSZNJVaSEBpNLlNdiZhP5mCoFiPEjVnh4xQk8
	onm+Z6/E89lAgZVt3Nx4+NH6LLTg+Og=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-mDDxgEcCMQmy_BglTSyzRg-1; Wed, 11 Jun 2025 08:07:01 -0400
X-MC-Unique: mDDxgEcCMQmy_BglTSyzRg-1
X-Mimecast-MFC-AGG-ID: mDDxgEcCMQmy_BglTSyzRg_1749643621
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d09ed509aaso1158276285a.3
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jun 2025 05:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749643621; x=1750248421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6LfLWwblq0nS0hH5xaHOxT0zDNtTct6Zz6olIqQVMs=;
        b=eNvHHgOfK7qKaB6e79+xEWOwzMDHtn+YTZz9sXoXLqrNMHcqnr72jc6leT7obFk6G5
         ivuhRYjyo6CL5CXBlfrwzKINVBYxZtT7u8SrBFtHHCEx1tmSbTjrcFEVNJ4KwrhzTzSI
         RXJW5IvmOAXQ+2+pcBA1Zr40NhI5bvSu7b+zYuAPCzcFsBArg0pbCRDsW2hC7iDj+Cvz
         BamNjOmemuM+krEsmvUk0Uz8ftKow0viyirfbb8bQ8Jc1sAxSpG5hfnxtLn/ikPqEUl1
         Ukp+eobH14fJBAq1LpIJ7aq7LDWW4E9P1HZOFfg3AcnH/77j/KAxJ9An2XSciaP2AMSp
         QPXA==
X-Forwarded-Encrypted: i=1; AJvYcCXZdAaiCqJcBItJiBgcfHszVQ4G7n59UOOpoc0DTpWMZMGXadiybzj8zS5eQ6EY/ZKoz096nasq9NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLFDEI6oioYcQedy9t+Mf7CBUtUAnP1eGBEu2vS1InTNJGXWMt
	9og6n/rF0bmVJs94MbFz1e73nIUlE2x/Nx8mJp0ryhTn918IoLSXLpPK2hNmBwbrjdFu7gaAZQu
	i1+LyjT8RAX65fuVXJPG+jl0K7ojBTRpNpKsxmsUaHYrvg4zWHPxkXyxQ7JWpVA==
X-Gm-Gg: ASbGncvOlq3Kf1tXEU+TMviL+EE/MO1GU7ZtpLE6pjSoEm5yknIef+xJAk2wXjFM71a
	mCLwVR8FhtGYV4N7jQc12Nl2W66hsTVh+IpoxlAGUH2Y0X24lCbGQ47ArVMNMBX2GvfRp9uprVu
	hvDke5eFdlRNU2Dm+8vDVa6Wh/Qy5tLnQIHAUFLRWEQ6sEdzZO/tE4XPxzC8Te0VBhECqe9iY74
	J0QfNh8WuqmE6pETd18A7FNqOdZM0tY9X3cYGkGyN4fg58qMU20EfEO9oRNKnzj66RXBxcWfhq7
	HLqSXv96EkwxY0+IOZ93h1It/iL6Hf0raZgPizLJnA==
X-Received: by 2002:a05:620a:1707:b0:7d3:a6e3:769 with SMTP id af79cd13be357-7d3a8a023camr487204085a.54.1749643619942;
        Wed, 11 Jun 2025 05:06:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+nvpy4eZgQ3IggiGnz01S9n6WnULoMe0QCjNT4gmRa+I93C9/yB+cBKGgJVnp79XMZ/tWiQ==
X-Received: by 2002:a05:620a:1707:b0:7d3:a6e3:769 with SMTP id af79cd13be357-7d3a8a023camr487198585a.54.1749643619433;
        Wed, 11 Jun 2025 05:06:59 -0700 (PDT)
Received: from localhost (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d25a608ff5sm855840885a.76.2025.06.11.05.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 05:06:58 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 0/3] mm/huge_memory: vmf_insert_folio_*() and vmf_insert_pfn_pud() fixes
Date: Wed, 11 Jun 2025 14:06:51 +0200
Message-ID: <20250611120654.545963-1-david@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3DpfxY-p0oujHxeUxNnO-v3WHx_tyo8FKQ54IgrOXLE_1749643621
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This is v2 of
	"[PATCH v1 0/2] mm/huge_memory: don't mark refcounted pages special
	 in vmf_insert_folio_*()"
Now with one additional fix, based on mm/mm-unstable.

While working on improving vm_normal_page() and friends, I stumbled
over this issues: refcounted "normal" pages must not be marked
using pmd_special() / pud_special().

Fortunately, so far there doesn't seem to be serious damage.

I spent too much time trying to get the ndctl tests mentioned by Dan
running (.config tweaks, memmap= setup, ... ), without getting them to
pass even without these patches. Some SKIP, some FAIL, some sometimes
suddenly SKIP on first invocation, ... instructions unclear or the tests
are shaky. This is how far I got:

# meson test -C build --suite ndctl:dax
ninja: Entering directory `/root/ndctl/build'
[1/70] Generating version.h with a custom command
 1/13 ndctl:dax / daxdev-errors.sh          OK              15.08s
 2/13 ndctl:dax / multi-dax.sh              OK               5.80s
 3/13 ndctl:dax / sub-section.sh            SKIP             0.39s   exit status 77
 4/13 ndctl:dax / dax-dev                   OK               1.37s
 5/13 ndctl:dax / dax-ext4.sh               OK              32.70s
 6/13 ndctl:dax / dax-xfs.sh                OK              29.43s
 7/13 ndctl:dax / device-dax                OK              44.50s
 8/13 ndctl:dax / revoke-devmem             OK               0.98s
 9/13 ndctl:dax / device-dax-fio.sh         SKIP             0.10s   exit status 77
10/13 ndctl:dax / daxctl-devices.sh         SKIP             0.16s   exit status 77
11/13 ndctl:dax / daxctl-create.sh          FAIL             2.61s   exit status 1
12/13 ndctl:dax / dm.sh                     FAIL             0.23s   exit status 1
13/13 ndctl:dax / mmap.sh                   OK             437.86s

So, no idea if this series breaks something, because the tests are rather
unreliable. I have plenty of other debug settings on, maybe that's a
problem? I guess if the FS tests and mmap test pass, we're mostly good.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Oscar Salvador <osalvador@suse.de>


v1 -> v2:
* "mm/huge_memory: don't ignore queried cachemode in vmf_insert_pfn_pud()"
 -> Added after stumbling over that
* Modified the other tests to reuse the existing function by passing a
  new struct
* Renamed the patches to talk about "folios" instead of pages and adjusted
  the patch descriptions
* Dropped RB/TB from Dan and Oscar due to the changes

David Hildenbrand (3):
  mm/huge_memory: don't ignore queried cachemode in vmf_insert_pfn_pud()
  mm/huge_memory: don't mark refcounted folios special in
    vmf_insert_folio_pmd()
  mm/huge_memory: don't mark refcounted folios special in
    vmf_insert_folio_pud()

 include/linux/mm.h |  19 +++++++-
 mm/huge_memory.c   | 110 +++++++++++++++++++++++++++------------------
 2 files changed, 85 insertions(+), 44 deletions(-)

-- 
2.49.0

