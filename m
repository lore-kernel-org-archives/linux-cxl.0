Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EFF3B9DAD
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270680; cv=none; b=q/q+NRPhFzBI9hWKGu7v46Oi1w0NWDwUCiGOsOfSTeR1JvSE5LBkCJQ/INjuVQb+aREbBhA/Ym2yNtxj1dykYuTOt/TrrEVafLNk2IURNc281czV3cMBGXZo8KuF+t6t4t/oJNpctVGVaEy2B3KbDHI8ig10ISJekbQWzZ4Gxk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270680; c=relaxed/simple;
	bh=sORV0X+F4O0KR4Pc+tiRmUJlRF6pji9/qC/zLQyUz8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvVxHUSi9Vmn9drb+se2lJQxrTn80zSdKe3Xn3ekQHT22t1KQtbdBOxrH5MPYwf8X3RzRaiCYQUQFV/yowG7+SlTvKLs/2Kisyj31wSSEqNasWOT/TN8KSzOXjOon+3ziWegqrsdU6vOt/Xq3RegHjpqBb3ERYoQqfJiCrz4VaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IEX/0s4x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEX/0s4x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784270666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MfX3Q3RbVvpkOOQ837KTiogN+xhujAPLrjvpYVR6OyQ=;
	b=IEX/0s4xdSdUk9cddvVpn0Ea9WQ1Sw1p6ZxikTOFmzo+tXfsFDHy2Fmxi/c+0A6ilYqT7v
	lEIZvInnOIfUybbwuL2h/zOSKJbjzbjnekiL04djkNoe9YsX3MbERoNH1SxBqoos/WqpX4
	dIG8frqMxJ9i0Mpulf1slJALbnvIGeU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-t0hT6U0FPpu1tZ_D-cZpZQ-1; Fri,
 17 Jul 2026 02:44:21 -0400
X-MC-Unique: t0hT6U0FPpu1tZ_D-cZpZQ-1
X-Mimecast-MFC-AGG-ID: t0hT6U0FPpu1tZ_D-cZpZQ_1784270658
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AB5F18007F5;
	Fri, 17 Jul 2026 06:44:18 +0000 (UTC)
Received: from p1.redhat.com (unknown [10.22.74.7])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3548E180036E;
	Fri, 17 Jul 2026 06:44:08 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: ljs@kernel.org,
	willy@infradead.org,
	Nico Pache <npache@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v2 2/2] mm/migrate: exclude hugetlb folios from MTHP_STAT_NR_ANON accounting
Date: Fri, 17 Jul 2026 00:45:00 -0600
Message-ID: <20260717064502.1980173-3-npache@redhat.com>
In-Reply-To: <20260717064502.1980173-1-npache@redhat.com>
References: <20260717064502.1980173-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: UCF-L7ldnEYNp15QPtixHQp56E6KLTQHqMqkEoo35HM_1784270658
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__folio_migrate_mapping() increments MTHP_STAT_NR_ANON for the
destination folio when `folio_test_anon(folio) && folio_test_large(folio)`
is true. However, hugetlb folios satisfy both conditions despite having a
completely separate accounting system — they use hugetlb_add_anon_rmap()
which does not touch mTHP stats, and their free path also bypasses the
mTHP decrement in __free_pages_prepare().

This causes MTHP_STAT_NR_ANON to be incremented on each hugetlb
migration without a corresponding decrement, permanently inflating the
nr_anon counter.

Add a !folio_test_hugetlb() check to __folio_migrate_mapping() so that
only actual mTHP folios are counted.

Fixes: 5d65c8d758f2 ("mm: count the number of anonymous THPs per size")
Reviewed-by: Zi Yan <ziy@nvidia.com>
Co-developed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/migrate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d9b23909d716..dd15a84b2a52 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -590,7 +590,8 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 		/* No turning back from here */
 		newfolio->index = folio->index;
 		newfolio->mapping = folio->mapping;
-		if (folio_test_anon(folio) && folio_test_large(folio))
+		if (folio_test_anon(folio) && folio_test_large(folio) &&
+		    !folio_test_hugetlb(folio))
 			mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 		if (folio_test_swapbacked(folio))
 			__folio_set_swapbacked(newfolio);
-- 
2.55.0

