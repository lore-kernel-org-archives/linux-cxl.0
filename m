Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC90387375
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 06:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270665; cv=none; b=Y79AW3LEFBqGgT/0Hx1FTA16K1YhmRG/GpDV2NEv28HLnYL0Mx2+kvzmc7sMexywuYmCW1bqNIPh24G4goXMwW4NwPbukaqD58zpbvP6fnBtlHq7T3W/j29Uk5D9LdmfWEAVNo3mkglOY+lGfP6BSuUpnz/gjInXUNlBzlOl4MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270665; c=relaxed/simple;
	bh=FAaotPNKWWFzbdZOjyZynp7KDOop/XRtcNz8KMqF3zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Vd87ldfBXr1tAkAQaidayjOHFMOUxfpLtQPujUoUdSErmkPhdYGft/xEabWVbBHPTeuTcxX/KvikyV34GGkHfgRoaxzACjTP84oPsYkaHVr6nPb4ODq3XY950Yva/+F/A41/paGg8aweXgihsjfFWlym1Q5H4u1FFPmJQ+VdrB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FkkZvj1P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkkZvj1P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784270654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvQD+9gys5Bjr4sehQzMMfeCVCfBYB0aLci2jGBuO4U=;
	b=FkkZvj1PRNi8KKGa3eB+bnTCY0BVZrhfPVN51cF57HE2jWhcK7JmZlIAahk3DvHXbQF+0P
	B4667Tn++gaPBdvpl5zolTMJ+T5W4z+rl+ckwDLMifmtln7eLH5Q6AukRn40lpVwkPTZLc
	3dlPlXV9vE3PL2bWupz5ZMctlZbKQ5Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-Qv6s2ih4Niee3oujVrbRRQ-1; Fri,
 17 Jul 2026 02:44:10 -0400
X-MC-Unique: Qv6s2ih4Niee3oujVrbRRQ-1
X-Mimecast-MFC-AGG-ID: Qv6s2ih4Niee3oujVrbRRQ_1784270648
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C760D1955EAA;
	Fri, 17 Jul 2026 06:44:07 +0000 (UTC)
Received: from p1.redhat.com (unknown [10.22.74.7])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3D3B180036E;
	Fri, 17 Jul 2026 06:43:57 +0000 (UTC)
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
Subject: [PATCH v2 1/2] mm: decrement MTHP_STAT_NR_ANON in free_zone_device_folio()
Date: Fri, 17 Jul 2026 00:44:59 -0600
Message-ID: <20260717064502.1980173-2-npache@redhat.com>
In-Reply-To: <20260717064502.1980173-1-npache@redhat.com>
References: <20260717064502.1980173-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: ezzoPWd7qao9BjUBjS1Byf-igSw4TdEJkj3pGv8t_GM_1784270648
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
Reviewed-by: Zi Yan <ziy@nvidia.com>
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
2.55.0

