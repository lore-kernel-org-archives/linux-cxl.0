Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F295344D9D
	for <linux-cxl@vger.kernel.org>; Thu,  2 Jul 2026 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013128; cv=none; b=LKWuNFLRn8AGXVcEdBiBl0eXZZPTO6ejuoVigUve3XiO1XxWbGf2u9rjbPkrqfw7DyJvAb+Zf07UqbjaVPdEfzPYRxW3p3kf8zot5aDZr8B0sjxNcfpn82KrHCSob/suu8xQJUgzS0/L3xdIDqpPozn5FwIv5P7KsVfzibDGgB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013128; c=relaxed/simple;
	bh=yboSpJ802K0S2cDoLeg+lmU6Mj9OqOoWR8jTcxxEsi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ha9nNjqIFACXbFT8RTSuqWUkMl1DM+YAeqTCHv9bq+WGZGMgXJ2jWTxo7DRccgS7tFur7QnUYYLxDY3gSUksi7BTYhByHGoLj6h5c4IxdLZIQLECWBqxzhG4CZw0zYTlsh/rq6NeU3akWr/kQ8y8CWPW0ekfPaB702dBRI+MjeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WOMxVPZ+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOMxVPZ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783013126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBefviiafkFbe/nsc/cyLo5CV934Kk6BkNirD8bq4mc=;
	b=WOMxVPZ+IpilxQeg9RP9Sob8TLr847FAU+HBQ7ZZLl9YdVMETMaN+LOamqPZzC5j3ajFqj
	TMfVYt/62sQWIwgzklqVQboCyZMkmzykxkCdVLGqCpueROYQDsHHlaj+h0J4q9IQ0ZO6Uk
	ofCIt/l6swDbOk7ENWnHv9ZybsST+fY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-YlzfNNoRPHuWMl6LqaNVfA-1; Thu,
 02 Jul 2026 13:25:22 -0400
X-MC-Unique: YlzfNNoRPHuWMl6LqaNVfA-1
X-Mimecast-MFC-AGG-ID: YlzfNNoRPHuWMl6LqaNVfA_1783013120
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 950071944CF2;
	Thu,  2 Jul 2026 17:25:19 +0000 (UTC)
Received: from p1.redhat.com (unknown [10.22.76.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4486E30030D0;
	Thu,  2 Jul 2026 17:25:10 +0000 (UTC)
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
Subject: [PATCH 2/2] mm/migrate: exclude hugetlb folios from MTHP_STAT_NR_ANON accounting
Date: Thu,  2 Jul 2026 11:25:47 -0600
Message-ID: <20260702172548.37075-3-npache@redhat.com>
In-Reply-To: <20260702172548.37075-1-npache@redhat.com>
References: <20260702172548.37075-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 9THuX-CDQ4uw3LMT6XhQ01pg3ZIRT6J-CKQdl4Yzc6I_1783013120
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__folio_migrate_mapping() increments MTHP_STAT_NR_ANON for the
destination folio when `folio_test_anon(folio) && folio_test_large(folio)`
is true. However, hugetlb folios satisfy both conditions despite having a
completely separate accounting system; they use hugetlb_add_anon_rmap()
which does not touch mTHP stats, and their free path also bypasses the
mTHP decrement in __free_pages_prepare().

This causes MTHP_STAT_NR_ANON to be incremented on each hugetlb
migration without a corresponding decrement, permanently inflating the
nr_anon counter.

Add a !folio_test_hugetlb() check to both places in
__folio_migrate_mapping() so that only actual mTHP folios are counted.

Fixes: 5d65c8d758f2 ("mm: count the number of anonymous THPs per size")
Co-developed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/migrate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d9b23909d716..9fd50ea25d2d 100644
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
@@ -623,7 +624,8 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	 */
 	newfolio->index = folio->index;
 	newfolio->mapping = folio->mapping;
-	if (folio_test_anon(folio) && folio_test_large(folio))
+	if (folio_test_anon(folio) && folio_test_large(folio) &&
+	    !folio_test_hugetlb(folio))
 		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 	folio_ref_add(newfolio, nr); /* add cache reference */
 	if (folio_test_swapbacked(folio))
-- 
2.54.0

