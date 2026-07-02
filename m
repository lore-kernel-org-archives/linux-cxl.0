Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52847353A71
	for <linux-cxl@vger.kernel.org>; Thu,  2 Jul 2026 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013120; cv=none; b=E8C5IxFk1ehZnAYcQSaxp7KwgE3n6ECorp/cP+8Q1jpWlSOxAdjylVOUba1327LasbYF9HcnuaVHIjaM56BTm6oC5oiGKPfoIa9Ou3nkPfcIUGEv83FCP73J5uP+uRhX/YbKw2c8PuITaAPsFlWLf3P+4+ZQVDCKY4Ndw5UWzU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013120; c=relaxed/simple;
	bh=Lwm2BMgNFAAQZ+E/pzU93lcyt1p3KF43Ex1TQaq48J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=oet5JOjavq/Ec+0KFZNpDAoRS0IfgJrcRXBBJPmiX8979RcBjEYWDTHHEqT0H/RrlZ6qCxC8j5ao30T9F/GO/Vb3TWDpSYb8MskpEK3P9gVQXq8szhSb6/6CIFOnAcIc5FqvbdmtJ2ZT1n27R8vcvwDDvf0bPxW72cR2PmeAboI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z3mboY43; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3mboY43"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783013118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rpsz4g3zxC6WA/xxJCnqVHrdcGnie/XC58606CgCcjE=;
	b=Z3mboY43menYsUYwZDs3Ty8Q23dEdhn9i9yZh0tPdJfnMnE09GHlfLkw4j+tpNEvQD/sIk
	zq+/I/dQNGHi1g0K/CPl/+qd6PD/X4sFdWt5AjokPP8o4oqhMWOElZ3PPXfspsKXJ2MkMX
	H7HPol7Ni3oFUfSnaWgXPQlw1i6eLNw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-PFauOJgUMLqtjKwlVRLQbg-1; Thu,
 02 Jul 2026 13:25:12 -0400
X-MC-Unique: PFauOJgUMLqtjKwlVRLQbg-1
X-Mimecast-MFC-AGG-ID: PFauOJgUMLqtjKwlVRLQbg_1783013110
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F19621879595;
	Thu,  2 Jul 2026 17:25:09 +0000 (UTC)
Received: from p1.redhat.com (unknown [10.22.76.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E25943002D2C;
	Thu,  2 Jul 2026 17:25:00 +0000 (UTC)
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
Subject: [PATCH 1/2] mm: decrement MTHP_STAT_NR_ANON in free_zone_device_folio()
Date: Thu,  2 Jul 2026 11:25:46 -0600
Message-ID: <20260702172548.37075-2-npache@redhat.com>
In-Reply-To: <20260702172548.37075-1-npache@redhat.com>
References: <20260702172548.37075-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: YK6H1msfIcL_g8OXjsBg6LP9xYYYFy3yP3Lfi6PcoQ0_1783013110
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When a zone device folio is mapped as anonymous, folio_add_new_anon_rmap()
increments MTHP_STAT_NR_ANON. The corresponding decrement lives in
__free_pages_prepare() in page_alloc.c, but zone device folios are freed
via free_zone_device_folio() which never calls __free_pages_prepare().
This causes nr_anon to remain permanently elevated after zone device
folios are freed.

Add the missing mod_mthp_stat() decrement to free_zone_device_folio()
so that the counter is properly balanced.

Fixes: 5d65c8d758f2 ("mm: count the number of anonymous THPs per size")
Co-developed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/memremap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memremap.c b/mm/memremap.c
index 81766d822400..accba23aef28 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -425,6 +425,7 @@ void free_zone_device_folio(struct folio *folio)
 	mem_cgroup_uncharge(folio);
 
 	if (folio_test_anon(folio)) {
+		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, -1);
 		for (i = 0; i < nr; i++)
 			__ClearPageAnonExclusive(folio_page(folio, i));
 	}
-- 
2.54.0

