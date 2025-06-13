Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D46272815
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749806830; cv=none; b=i30U085IwZY+3DrpW/rD7zontdQPMdN7ijqFw34JdLXQ2+e51wcQBnw7BB8sFPYUhWhGfL8s5RaNKlLfxcqcLOuciMFI2U99K0Dtu2jMBHAmeN9O6Ctr0ySpXpHNdxoHzGIvUFw/7gnZVarmDhtUFiXnAZA1j5LoaaO2tuexEJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749806830; c=relaxed/simple;
	bh=mhgTTIZZsefj8mnYxT3QFETIlhACxk/HMINCBYR2EQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=nGg1KW31O2YkaQDHut1QXmFptI03Za8FkNu0pAFRRIeO7gW2tc24r0WxiAgssccGzNK9WfW1ZXLd28MsTuNCYf0G+q+CUqPR9GvRMgLSIYTiNzxS8xNBT+NpueBaCBO3KURy9El8+Pqw/42ARvxWy/bdqpUAdKxxqp13u/s8A+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SF4tNt/W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SF4tNt/W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749806828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eA9hGBugFKNk6aXi/MtXxZpnAai7SGsOuKl0QrS3BOQ=;
	b=SF4tNt/W+7uSySIR0vI2W3HDUJk3VwO5Eon0EY4v8THbTjqf3AcMKTNl4W6KacnQZURrA3
	Y/ckQD6KrRg96T8PD/Qhtn0w41UZ53LfFJk2wEyJIzCHnK/nweHe3tKanfX7qNkMKuuRSO
	ArMAe38BCchItGH3W90Vs06bXEc8bHk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-Dw9SW8LFMyu_SyLdXPQPeQ-1; Fri, 13 Jun 2025 05:27:05 -0400
X-MC-Unique: Dw9SW8LFMyu_SyLdXPQPeQ-1
X-Mimecast-MFC-AGG-ID: Dw9SW8LFMyu_SyLdXPQPeQ_1749806824
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d5600a54so16869335e9.2
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 02:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749806824; x=1750411624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eA9hGBugFKNk6aXi/MtXxZpnAai7SGsOuKl0QrS3BOQ=;
        b=mJ+PE4kUDyXIXAh5E8W5rJ114YEEi5yWXUmZPcmJiV/lfmsChvltIS2FIDrQfqI0YQ
         D/IlbBK+w2/TNsmlZwa3cArvMBKYMhXXOsJUevY4KILTfsI1Oz/5+oarcI+N3gkeY485
         pBhdni8fUiQ2DSQB3I4KXq3xMXAGHdGpq131RzB3zlTT/nhYEvWrXRnuPQqRvVcT5U16
         bPzLAJmPWIzvqy9cgAVm++DAeRLZVQFVq7mZvkGwOGg2EyGH37oec86QmKbf96SjEgs9
         M5cx6MZ43CN+tG0TkhuqgRn/+8QYjaiQq7HLgXd9JLycOQfS4cXtX8e89RYtWsCqTD06
         JyDA==
X-Forwarded-Encrypted: i=1; AJvYcCWSdafyLFzSyu5sy+4S2ygl7GUk5Pokl02mNLCSMGGNXGyaixFVrjDBGq7OmY1DGoovwnOH+36iiiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6V5n/gkJHy1f315wl3n4wV42dm6UHhdyO+2SKQUsndMMgdbFb
	L1GQNrGcD4MItuYIxVzHjLLJLlo3x879P/xVswjsU/HXD9OXEiElWPO9th59qLTL4fZHeTnSKz8
	7Ni8ZFfSNN9WXzLoHAyjrnmAult4xhQUwy+xcepUtPEHO/NGt5Pnz5F2VrcMQp9NAmcvZeKyT
X-Gm-Gg: ASbGnctQ2JrCfLgEHCSNyH4nM/Exbgk0hLYZSxJijIcZLJN+BoPsHxsGnJP7TtBscAC
	oEwf2GScabqToAFyI9rUwy6NKl3xxIylYzFRhg55+zS6hmXmItKqKZNaglI5PIjhL2d70SWF6pv
	J7yfo6LglvpA9jU375LFdEAC9kl5C6agMIGD1u9cscRdI9T3U4uB5uPLo+onaMehL+IqN55ytw4
	krKB9sffN2JoTEJfolKG1sXOib47rJzgTObxhFQMLL3X9t7QU6qUNY2quI8gwx1hcxK7yrjI4gf
	2wwOUiMrZzdC6m0OtB61jic4ZOHBaj0x5OuSAYBYC2L9muJEyWLdOWEVMLH6HNLb2LJlDIzbLcN
	ns0XFaDg=
X-Received: by 2002:a05:600c:1c19:b0:442:e9eb:cba2 with SMTP id 5b1f17b1804b1-4533499edc7mr24667975e9.0.1749806824356;
        Fri, 13 Jun 2025 02:27:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGERaE8MR+6/dmyK3cZQ7xtwJhWFU3zCcnVAfTUdbkGjRrz6rE1iR9ahL+Nyc7gnKqK2+FRCw==
X-Received: by 2002:a05:600c:1c19:b0:442:e9eb:cba2 with SMTP id 5b1f17b1804b1-4533499edc7mr24667655e9.0.1749806823907;
        Fri, 13 Jun 2025 02:27:03 -0700 (PDT)
Received: from localhost (p200300d82f1a37002982b5f7a04e4cb4.dip0.t-ipconnect.de. [2003:d8:2f1a:3700:2982:b5f7:a04e:4cb4])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568a73a7bsm1822993f8f.36.2025.06.13.02.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 02:27:03 -0700 (PDT)
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
Subject: [PATCH v3 0/3] mm/huge_memory: vmf_insert_folio_*() and vmf_insert_pfn_pud() fixes
Date: Fri, 13 Jun 2025 11:26:59 +0200
Message-ID: <20250613092702.1943533-1-david@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jvKifE-xibtD7QLib7ZNg7b6qGito07S55WSXDlsLP4_1749806824
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Based on mm/mm-unstable.

While working on improving vm_normal_page() and friends, I stumbled
over this issues: refcounted "normal" folios must not be marked
using pmd_special() / pud_special(). Otherwise, we're effectively telling
the system that these folios are no "normal", violating the rules we
documented for vm_normal_page().

Fortunately, there are not many pmd_special()/pud_special() users yet.
So far there doesn't seem to be serious damage.

Tested using the ndctl tests ("ndctl:dax" suite).

v2 -> v3:
* Added tags (thanks for all the review!)
* Smaller fixups (add empty lines) and patch description improvements

v1 -> v2:
* "mm/huge_memory: don't ignore queried cachemode in vmf_insert_pfn_pud()"
 -> Added after stumbling over that
* Modified the other tests to reuse the existing function by passing a
  new struct
* Renamed the patches to talk about "folios" instead of pages and adjusted
  the patch descriptions
* Dropped RB/TB from Dan and Oscar due to the changes

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

David Hildenbrand (3):
  mm/huge_memory: don't ignore queried cachemode in vmf_insert_pfn_pud()
  mm/huge_memory: don't mark refcounted folios special in
    vmf_insert_folio_pmd()
  mm/huge_memory: don't mark refcounted folios special in
    vmf_insert_folio_pud()

 include/linux/mm.h |  19 +++++++-
 mm/huge_memory.c   | 112 ++++++++++++++++++++++++++++-----------------
 2 files changed, 87 insertions(+), 44 deletions(-)

-- 
2.49.0

