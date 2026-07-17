Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453B43AFD07
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270654; cv=none; b=hYa82UVI7FLO8++1RWdBXZvRqB95qSaU6Yw5PG21jEik5TwxlwWB4Vj5QlcOLaf+7ZnXXiGWY17Xk6V3E+BJvQUBjL7Ygb4+5U7nwu5I2B8bUDKhsurq3PtnpxJCRIcDDeuTJqAZKVVVv25ZX4boMVJqV4EFTGvg3DhwUshqzPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270654; c=relaxed/simple;
	bh=2tLzLs7EZmpe/e8U7VeR8ucFcNoUYQy1QiqufgRi2hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mTIlaiHWx4tkpXku4l/6zvRQblm2ypCVPS+H89UnV+yVAxHfFw8oGMsrY4If94jGneYTfz6WmFGYdeSnZxLtoTY8m6B85TPqATr5ZUD43secwYwBKHH2bJtaggOo4frzjsgQsAlCdbHoeNYzI6bhhRkEKoucXwRTa7G6YLPXvwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L78YVvVh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L78YVvVh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784270642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=auHLqBMySjs37JrZlCpHHjumwhaypJA5zdEIUdQCt/A=;
	b=L78YVvVhw1YdiNlgXxamCmpDi6EXLQj2aXHtT5wiQ7/k1Ht1J4YF0+CBnbd2lDkM5MMNIt
	8AoK2gabUcblvuzydB3ypjeZxG6kgU3F+zcc6SPWJ2e2nHBGGXuV4nIZ9JMga92qI02WK4
	HZ71UIyxr/0R8qzuU92Y8GPudyWV/Ew=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-itfGAbWaPnO2_ggM_SLc1Q-1; Fri,
 17 Jul 2026 02:44:01 -0400
X-MC-Unique: itfGAbWaPnO2_ggM_SLc1Q-1
X-Mimecast-MFC-AGG-ID: itfGAbWaPnO2_ggM_SLc1Q_1784270638
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46FE31800749;
	Fri, 17 Jul 2026 06:43:57 +0000 (UTC)
Received: from p1.redhat.com (unknown [10.22.74.7])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 52F33180036E;
	Fri, 17 Jul 2026 06:43:47 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: ljs@kernel.org,
	willy@infradead.org,
	Nico Pache <npache@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v2 0/2] mm: fix PMD level mTHP accounting bugs
Date: Fri, 17 Jul 2026 00:44:58 -0600
Message-ID: <20260717064502.1980173-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: -Kr9BLp5UbG9RM3ZNdYkogpwbb0DjRvb_F8hipavhf8_1784270638
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While running selftests I noticed the PMD level per-mTHP stats (nr_anon)
remained elevated after each run. After further investigation I noticed
this accounting error occurs for both the migration.private_anon_htlb_test
and the HMM tests.

In the HMM case this is due to folio_add_new_anon_rmap() incrementing the
mTHP stats, but never containing a corresponding decrement in
free_zone_device_folio(). We solve this by making sure to decrement the
counter when freeing device memory.

In the migration case, we are incrementing this counter without first
checking whether this folio is a hugetlb folio, which relies on a separate
accounting system. We solve this by adding the proper hugetlb check before
incrementing this counter.

With these changes in place, the two tests no longer cause elevated PMD
level accounting issues.

Co-developed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Nico Pache <npache@redhat.com>

V2 Changes:
 - add RB from Zi
 - Drop unnecessary check in __folio_migrate_folio(). HugeTLB has its own
   migration system in hugetlbfs_migrate_folio().

V1: https://lore.kernel.org/all/20260702172548.37075-1-npache@redhat.com/

Nico Pache (2):
  mm: decrement MTHP_STAT_NR_ANON in free_zone_device_folio()
  mm/migrate: exclude hugetlb folios from MTHP_STAT_NR_ANON accounting

 mm/memremap.c | 1 +
 mm/migrate.c  | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)


base-commit: e57d6e9e20b551e4910d7a6331a81775c3ad6693
-- 
2.55.0

