Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793074945;
	b=F5wJ+pRh85sW/rjL9V7RPZsIyR3WhMFa71HjNCh2VI9jovFGVdTfd4GP1s5UGMeh9P3v
	 AnKtK7gk4pe/FDW8+KFLm7f1fw+AWr62Zn1fyYf+luTXHZXhhjtLzDPIxHsrODb4VhM9A
	 TQE/33vMoJWgN3aBl+Q/fO88eoXErK0cwWkMvB4Lv/gBd531IIW6nuO79cdbDvJMThQ18
	 PAvvSiF4C4dH4LyW98l3lIwgBOk47Jdg7yqenC6fJzkz5dMsRQ/0z+gdS5uiCcNU3lfhS
	 BOysLQetfAbfJS50sRm64Im8xOF1BPJjM1RsD0TFdIqaTNlRuCj5bOv/a9cSe49FJRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793074945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=O/I0LmBFR7uBLBrLDEFm/yc+s/I6APM2Icy/EDbK9iQ=;
	b=J0BFzTNiQxoG3pjep4IlO3A0YEeN8ThtrWbq9abRjJLhk+PIh+wMyMP5qQfO5P9I5oc3
	 QpH2jlEumkdpWpjncri1W/h5kTTwlsACrS1SS+jHCFygUVJrnj5c/hSPz33R5PkKk5g42
	 YM+HMmEcBCwKO0mJx/e3eup/SGUgw1eGuSBTch6DXxQNjuupyyh57+e0xBRcdheoj325/
	 c371xDlatuXxn7Wct5egj9YP7Ho2fAUfggNadhDRtKRovZJHcixKzuz58hQHnb7e2MjlE
	 vvrcGK/qTnLCT7Ya5MF9En+NkH3az4ZE13DUYOjtpAcde/Kotza+y7gueh3jy3PHGtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Uh1dDRxG;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF86606A32E
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 04:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FF86606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Uh1dDRxG
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91b89c6caffso29635736d6.2
        for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 21:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793074944; x=1793679744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O/I0LmBFR7uBLBrLDEFm/yc+s/I6APM2Icy/EDbK9iQ=;
        b=Uh1dDRxG255t8FsdHTDn6DBOQan/CFITNS+SJISOlJdP3PwYjGv3T8ELkvvXQqFNGl
         xnHyMYbjZ6K+jnitvhsJoeGAbAT3fzxUgjR+gVXxz7uBoEYQi78NHoXaFlWZJIC5+ntl
         AGRIr/A6FGmmCBDilwfZ9rn8hCkAXnsmtoHnZ4Tfmw/e231yLueV38JEGEi892tHROMY
         AcLHbdyRJ7MBMSEWYiYmU0fRZs8UvG8+24vw9eLjyYth0iQAeBptkJochELEdv/7Nnki
         CkWWBOU+GiTtCb7wc341KP45BJwnYweMQKBAH2lSkGS0Bf9sONRg6PIQ1WNgNercipnk
         hBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793074944; x=1793679744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O/I0LmBFR7uBLBrLDEFm/yc+s/I6APM2Icy/EDbK9iQ=;
        b=m46OZmBdFyVZd/edTgfXtzxZnjAs198k5cO6SevRJ95wfB7wNJqhEgkSxeWpIVoJHA
         ysQ4r6+IW9NJAglrPxmrfAV6KFvHq6X4i5nTCh4x9PGztL6Vy0LlZdANJqfktIDr4IC/
         XUt6K0NA6DFSzVck6ihZ7puXWbiDH6QON1yG1Tyzpd2HjXBGYvh7RB5m4f/E4L35w1W8
         HFi+4k1BNC9EoRjNREyftD2L5ZQ7wiJ7RRb2dyvRXw+5Izi9D7T8GmmYEg03BVH9bhSi
         v5kcJb0ZQEeWY2i4LnLXruUhLqHynOB38rJYWsf3tkSmpLmmj33ajLtpKhpaW7bvdK7/
         4VWQ==
X-Forwarded-Encrypted: i=1; AKwUvBzOE6HglmGMNCT/B93rM9FXvdXIofsBPr2U5HA4mPdhyTvJbdV14OCu1M0AogTPGjC//ygvvXVQvNk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLS+4pFkWwDyFYvTv9dX/Y5C5Z2qDZGjV3zThlYnJ4YHO+g24BV
	ep7l8KGqFpO8uwjToURlVbL8tXONtfhoQNwDE81/xfBM/XNWvYMdZ2/EGq9sDgn2sZryYxvTORg
	mRoJGDyc=
X-Gm-Gg: AYBFou2xdtp3D6e/CAYxEWSyGiqh1xlxnn1XdVkFk+L6y9zsTH9gREJFkjFSWm/vff3
	3AlZBoMmsAs/Bk+qPJfpDpNmbhAAKA1Q0Pb3M5dECl+BAmbqE4TzGSjDFFzgRPLlgt+sK+9uk7s
	4HVgB+EIS6UDlEyMX2BgZWL1haOt1zg3jiCpNKdRh3FW0UNCZ2JZVwPBEBb82zfDt22t3l5M1qp
	0D95nlKzgZXETHZpTWuaM57XjnC4bQmYe4VZt+yHmzNWBYRJ2tlJxvW2aOKWwbzOXS6HpnFJjFB
	qY1qqCQGV6nsqY/vxPBlBxkvjkaV79KlLVbuHKA4jjfAVAa1YvbbhjI1IHExmlUbgolEPx08irw
	INRPVOhWzHcAqiS12BA/Zun9cR8Wyv1eNarju2dYchsJh1j8ivem39eOuT2wSbQVJwUguR1Irrs
	H5ZXGmgWih94UH0AO2lNRwdCIBE3E2zLt0VEHYK5AnrGrN8lIV7+JBlo/z0JiwxhFMvObSE4/ZQ
	LQd+qT8rRIMZZjV7zRXhyXWMeYmqgGsV9gjXc2rFN2kv2s+vek5Aw/2kHqH1IiVDLjgPQXL1vwn
	Fd9kDsTOGV3M4Zn915M5rzWNi8fwJHr+8xxG3PAPXg==
X-Received: by 2002:a05:6214:800a:b0:91c:60e8:a8aa with SMTP id 6a1803df08f44-91c60e8a8c1mr69350086d6.49.1793074944062;
        Mon, 26 Oct 2026 21:22:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd01cdsm91139676d6.7.2026.10.26.21.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 21:22:22 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	rppt@kernel.org,
	osalvador@suse.de,
	muchun.song@linux.dev,
	iamjoonsoo.kim@lge.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH 4/6] mm/page_alloc: don't undo another isolation in alloc_contig_range
Date: Tue, 27 Oct 2026 00:22:02 -0400
Message-ID: <20261027042204.3741307-5-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027042204.3741307-1-gourry@gourry.net>
References: <20261027042204.3741307-1-gourry@gourry.net>
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

An alloc_contig_range() that overlaps a block going offline can leave
the offline spinning until it gets a signal, holding the device hotplug
lock.  When isolation fails, alloc_contig_frozen_range() undoes it over
the whole range, clearing the offline's MIGRATE_ISOLATE too:

  CPU 1 (offline_pages)               CPU 2 (alloc_contig_range)
  start_isolate_page_range()
    blocks are MIGRATE_ISOLATE
                                      start_isolate_page_range()
                                        -EBUSY on CPU 1's blocks
                                      undo_isolate_page_range()
                                        blocks are MIGRATE_MOVABLE
  test_pages_isolated()
    never succeeds again

start_isolate_page_range() fails only on a block someone else isolated,
after undoing its own, so this undo only ever clears another caller's.
Return directly, as before alloc_contig_range() went pageblock granular.

With offline_pages() parked after isolating a DIMM block and a 1G
hugetlb allocation made over it, the offline on base still loops 30s
later in 4 of 4 runs:

  offline_pages+0x5b2/0x1570
  memory_subsys_offline+0x17e/0x470
  device_offline+0x250/0x340
  state_store+0x88/0x110

With this patch the allocation still fails, and the offline completes in
3 of 3 runs.

Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 55d3fc4b307f5..bb3c7e95f2ed4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7396,9 +7396,13 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
 
+	/*
+	 * On failure this has undone its own isolation, and any other
+	 * isolated blocks in the range belong to someone else, e.g. offline.
+	 */
 	ret = start_isolate_page_range(start, end, mode);
 	if (ret)
-		goto done;
+		return ret;
 
 	drain_all_pages(cc.zone);
 
-- 
2.53.0-Meta

