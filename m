Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640228;
	b=x3aorUDeEGZWEB3bphGYyGHDlzkLK5WpKpMRQEzdbb6tc2hJEzFoCXDHN7iZzB340nOf
	 DK+mGnrnDjkkz6FgRLD8pQWyuHICgLIAGBU6lJmAjF4LB/BbTgb6y2mVF31fhG1hNR5/z
	 qOhm94yvTf+H/Wf895VbIoHAi5YBuhN+HZ75foGCyNTplobusyXSYu+hU1zW5m5q3dSTV
	 jQaIOPl5xImM8zT1fT8+hopUiG1gyUFH64xUzGrEeqHTiq19CgA7sQRo2woXt7coqcjMf
	 Z0Q/wKouwm2bsbumbhG3CW7NMC6WGqe7Gr6m8K2ZsI1mSdvIqJ5n7oXuU9KFq9MGwsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ug/CLwAsG6XPyYIr9OCoTcVisBprjwnxP+sIccpst3I=;
	b=RMSqkR742gXlmeJi1afchdYsZ55Y33ZM2WVAfoXGZjzpbZ8ceHIcOmlz7ljCXH6KJiWK
	 Y5kILFjIoF9IGP9b9Fm2/Q9Fz9E2Iu/26XGV/fZp3njL8739un6Se3yV9mB5sT02B8XaQ
	 QiFQM0KA3Uu/Q9XiGTYVOwiSD4y76VTWdph+nJfd5muLgH1diyZzbFf8MiCkVGzr4l/so
	 jFPII6bpKMS+oIInLCo6ZjNRqQEW30hDZRyic122YYEVJvMZ/aVKS0ZZbNdCWFCKQFCxy
	 egovjAVCFHhjOonlmdgG3yCTNrZBd1rF0Z/nEf4cOWsGUgs6M1T7YceEBXHsHfIN0ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=e0f1NE1E;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B10760A6F43
	for <linux-cxl@vger.kernel.org>; Sat, 14 Nov 2026 07:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B10760A6F43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=e0f1NE1E
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91eb449364cso32557766d6.2
        for <linux-cxl@vger.kernel.org>; Fri, 13 Nov 2026 23:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640227; x=1795245027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ug/CLwAsG6XPyYIr9OCoTcVisBprjwnxP+sIccpst3I=;
        b=e0f1NE1Exmdl9VHCTyMwen0H8NFFA5ewM0qJqz9IIPFvpUDfghWuuQsLrxK1SzRsz7
         hUQ5k4c56+KPd+CCYf2/vIqRWl8gHz2BKZUrM5Ij4T2/PSEWok0NnE0FUoNCiSoWO8Mq
         GMGUsUR317UBvVBakiAaXs2gi4djBungqVsPEPVmsCYYKAXaOtbrEV2mN7H/GYUItFZG
         FKQhip0+198HqCVpa7oWo0gCnkVC8uPd0d1wG9uCGO/6pyKs254gzQjdaZ9eM/glICrr
         l+E2ixDmEv243sGYSgL1CoNQGZsrUgbQgXYKwaNyBH+knN+wWZHgnaTTI9p959iurBvU
         zUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640227; x=1795245027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ug/CLwAsG6XPyYIr9OCoTcVisBprjwnxP+sIccpst3I=;
        b=hSpgJQfnLG21fHhXXb3BAkGsIQ/ziOr23zLFFLotHxEl4mBw0Vc/OKYnQE1G/WP+/E
         wjroBLs6dEuRZaLeVMIKzqLllZcyZlYNGxnkTD7U2In3z0iYmIBfaBsBYSbSkImmX5AC
         VgFj01EZq3kUZO5h1SZjLBhp9c6P+lFOLYnbutG3qo/QL2qlVw7hfUcTuS48SK3qfwzg
         ABoqry7dYW+xRueh9el2q2lH43pWKgEY3PgPaEB6iP1YJHc7P7PP4KHBadNhrZbYyksb
         zhQyxodhMukogog3p5SMl9BIZVShEaRfpaA8U9D4iEOVfADtFB/sGReYzYRLNeLt0ZNS
         iggw==
X-Forwarded-Encrypted: i=1; AL+hErEHcuR5IFZ792FrhTPD1BdZgg6pN/ZtB2nrvhK7kiVRYvq0ITlhdB2GFUgs+ynyJRb7mM6bIJ+tz/4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0T+4kNvBiom6pTVteOp612vVWmxA0VXyJTgBqUH6eIofhv64E
	pbcroyjQdfdpK5b0LcCLtCv/EI/bl0PbofVuKHVTNJm/BnznMEQzLbQ1d67/YVwQZQw=
X-Gm-Gg: AYBFou3dH/P7uLycAWWunReDSwzY0XJxdSUm7UWavE3hgavkVF+RIbOzEFdXEJhRWND
	Psmz1rhsTCI+B7cuqW9QY47uNfwB//+xB3XIZNDfrxywOK9rkQIRnyQD9JNrbwb9Dk6uuVeFadX
	PhBU6HKV7WUX4iOpPU+CdGaEFklXyx3Mg5cNubruhRtnL2wPi4fA0uDypPGQCcTbTEHDz7nkSV2
	aJET1dOV9cOQyr24y/LRZu5Rr/SrRV//5hesB3O2jBd4fUyYpZ8zZJigC0jqzITfj30zyQ3/Q9E
	Za0T84yq3zSDB493Q+wzZ0G7bzIuy+caJmnxEopPfzK6qlMuZF57EZm9wj4oK7NA2aEhgtiMYm0
	vt9gnFiSUgzuyF2adsHLlJZxRQZE+fdX6DL9NOLBbqPwFxiVDDR2W4jFnatTmhJzUZnWghxmyqS
	2tzEZJ7MnHcGkJGluRLquHRyB1YwzSZq9tygTUhQAkEJl1QHM5IFuByiq/KNtcQLJnn93B1+nxI
	Rj8T6FNog9O74j1MArdjHdTSSbjtmovgAFWe6A3t7Ct/XOu4a68qo4G7jIIrkRmFlEerYfz9is/
	JVkMV0EgHIlWdalCTlhtqglYeSBBFb70Cla4gJbbQsl1Rp2sZ4VTvIgb+h2sR3qOJ1nitTXLY+W
	hf7HuyFe0snJoNrk=
X-Received: by 2002:a05:6214:dc1:b0:91f:1bc7:b779 with SMTP id 6a1803df08f44-91f24251f4dmr78714166d6.56.1794640227399;
        Fri, 13 Nov 2026 23:10:27 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:27 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	johan@kernel.org,
	jirislaby@kernel.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	pavel@kernel.org,
	lenb@kernel.org,
	hannes@cmpxchg.org,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	sj@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	apopple@nvidia.com,
	rientjes@google.com
Subject: [PATCH 11/22] mm/mempolicy: don't NUMA-hint folios outside common memory
Date: Sat, 14 Nov 2026 02:09:48 -0500
Message-ID: <20261114070959.3490008-12-gourry@gourry.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114070959.3490008-1-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NUMA balancing scanner installs PROT_NONE only on folios that
balancing may migrate.

folio_can_map_prot_numa() already skips ZONE_DEVICE folios. Skip folios
outside the common memory pool (N_MEMORY_COMMON) as well. Do not inject
hint faults on those folios or migrate them.

Convert the zone_device check to a common memory check (which includes
the zone device check explicitly).

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 662ab420fe03c..619970f0eb954 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -863,7 +863,7 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
 {
 	int nid;
 
-	if (!folio || folio_is_zone_device(folio) || folio_test_ksm(folio))
+	if (!folio || !folio_is_common_memory(folio) || folio_test_ksm(folio))
 		return false;
 
 	/* Also skip shared copy-on-write folios */
-- 
2.53.1-Meta

