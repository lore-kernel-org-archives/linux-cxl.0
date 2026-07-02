Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CE1349AE0
	for <linux-cxl@vger.kernel.org>; Thu,  2 Jul 2026 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013110; cv=none; b=X18oD3nqj4CUxlOv9N9KFGa8/dsA6IDWtP+UytdEi9SkZ4jUsKnvGuJ11kWfxYqsh25xNh9KMS7/RQq4nxZaL5tHPyxCKA0xSSWxWTsp/JwJL6zb+rAbMOhGmM7New+ENfYzTwzLsZvpbMmEntCcZQI8F8ZzJ1ZfrrAHybXMSgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013110; c=relaxed/simple;
	bh=wC85SlcB8tKCnNUkljig33zwjFejqec25kpt/3M+9i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t+qTgXZgABJ/luEMhNYclVJNvAuglDgCt60jRqtaVVOq0SWh75hUJh43T5WffHsyOtLEHWeikSTV+W0sMjbg2ag29yBvxAZjLr3JYBS/Sr2VVDkRwwcyjq407wiBz/niQnSTN94+8S67Y/srsx/fKxJfTqVYbnLTmIt0Ai4l120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUjj0LXf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUjj0LXf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783013108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h2Ms0gDqn541Zm3m4bDAe3INBlyb1cMJpyBl6JN9E+g=;
	b=hUjj0LXfiM3i/0vDMNbKyx86TSHKAI7aMlbA8K9qKAF+UQcnnBocjN5G7s1QZZmF/6u7Hf
	VwNYYN5+Mshp8JUtInXHG0C46hYZw6G0V0b1RNLeVuuGpOB7OB/rop9awu5tsJSO5xX30B
	MIVXNKYCXK9BEW6aBq62NFthyb7Bl48=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-_Mnzm0EiNzKnCBN8KhOh8Q-1; Thu,
 02 Jul 2026 13:25:03 -0400
X-MC-Unique: _Mnzm0EiNzKnCBN8KhOh8Q-1
X-Mimecast-MFC-AGG-ID: _Mnzm0EiNzKnCBN8KhOh8Q_1783013100
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 995D71944B24;
	Thu,  2 Jul 2026 17:24:59 +0000 (UTC)
Received: from p1.redhat.com (unknown [10.22.76.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0874E3002D2F;
	Thu,  2 Jul 2026 17:24:50 +0000 (UTC)
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
Subject: [PATCH 0/2] mm: fix PMD level mTHP accounting bugs
Date: Thu,  2 Jul 2026 11:25:45 -0600
Message-ID: <20260702172548.37075-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: -XWvHkk3KLqdkG4yQzMVILyKa6mUcJ6gMzmK-AVIRso_1783013100
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

Nico Pache (2):
  mm: decrement MTHP_STAT_NR_ANON in free_zone_device_folio()
  mm/migrate: exclude hugetlb folios from MTHP_STAT_NR_ANON accounting

 mm/memremap.c | 1 +
 mm/migrate.c  | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.54.0

