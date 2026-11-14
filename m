Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640236;
	b=ZpA2Tq8TtFrCY72cX4KuOpjL1uISt8LDxBj53qJhcncxI4YdaCPyMbLoCmgy7DQDtXif
	 eWeUlOvLR4qkPWfDLfm/kKw2IIryghsurHPPGRLpE0A0XnH/iPlDsYdsXzlS5cMeIJ4SG
	 +IzLS7FjcfYtbVzSjNG0dmb13olY3n7tgLHgwAPhFXYzfUXOphS+iHXZ6XbQQqztTFHNG
	 AOJudqpztbvedXcDJG1OWNnzDEKSQQXmXBNTC2Evb5KFgi0hxwlmHJGKTcnT1KHPgny6T
	 7T4748HOLeeCTGtHlU+CW1X5oIoIc9jvt1yDQIzbXZoCMFFei7PKrNLG78A+xGLI4/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LMm4cY2G8/N+lvY6+YyUeSTrUdIgOLxyZozNrk1mUY8=;
	b=OfI1eTIzbax+70/uAkpkkmb4SXlk94+eM00CIFsJpsl/r/9qaavjEczBBDyKlRZFkyr6
	 //SnAZ3sOnxi5iWbP5n/0mftW1dAj6qHqUyIOZX0fKHQNX5j6RrZ0fJj1Z4tQeptfsRdr
	 HQFlFwV31RRCO8/q9prNGzlYYU86NJRTELjid9nYpLBnZHYZLsLCeFaKdoth2Tpw+358Q
	 GOdVfsf48vZ2p5+zGCVAbOCaI9u5NVPAPgJL1zJgp2OTqMisW1OyAqSInPJxul5vf+McJ
	 0aR328beKCXlyO9v/UcxJNqTB2wopqrvBga1XzRalGZoqGEqGUford/L8g5/vd64QHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=NrD2qtKj;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42A3606B411
	for <linux-cxl@vger.kernel.org>; Sat, 14 Nov 2026 07:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E42A3606B411
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=NrD2qtKj
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91e8938fd01so29668506d6.3
        for <linux-cxl@vger.kernel.org>; Fri, 13 Nov 2026 23:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640235; x=1795245035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LMm4cY2G8/N+lvY6+YyUeSTrUdIgOLxyZozNrk1mUY8=;
        b=NrD2qtKjeYgj8rGYN1fwIgSL20IT9bdCQHMOHTKrC9oC+X0gc2vtwbP/0pBFXO/NP0
         HQOX69QwWq4MNb4Li8WvfWTySx3QpG8CmXSfXqHpUcRgG3oSbMC6WqjxDT/m562PtycD
         KuRcCudGGIt3HNVFfi9LLJLq4QR7G6eDIkxjamWnnAZ3uR0790bOBXukHx5SFAIrogr3
         rVV/a3g+hhDNs12AsnzkGTsK4afWNTRGDAIlhg0fF/5oN9rABG187RlzqBsqM/hs+ndi
         B9r6nI/+MN40ZYs8ZXdDilJk4BzjEhxnTnlkpUl5Sv88KAYoSVQ/VQIkHc1QjmG5QWeY
         nXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640235; x=1795245035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LMm4cY2G8/N+lvY6+YyUeSTrUdIgOLxyZozNrk1mUY8=;
        b=ByzSoieKoOh6vc+fCw3AOe1aCVEw8PL8+fGJV4oLufE7F131zNDszfH3szvU//ypOy
         VcNGDBz1lvV6coblIDPOuHq0nt1DRDAR1WNMu5uxqX4uR/FcKgwzPTtcnvY6ow7y7WRf
         Vlem4mGXqDlLK9/asOY5b2w7ueSBJdFCL9O/V8lEhhyZ/zMv7fRY9901w+Gnd0+5r1hs
         fLTWv1zc47drZ9WRnyZ9xvQvBJRBoy/IgEIRQCX0Yej1Mfy5HjDiFp1uQXKbF4TZ4GHD
         3hjd2j9kgDbmrxFPQyub6G+DKSQMOGPgk9QJ56SvK4C8W5VE+O6/RJDU51+OL6zctjEi
         vGuw==
X-Forwarded-Encrypted: i=1; AL+hErEnj6Yatp0B5QmPFtn2Bp+VFAuL8GQu4VvV5j9pKI8sD9KlW5oknm8+2GNe3EQgbDPqLw6/LuEZC9M=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZtyThJzf2otFh7pXVboKEMPKfcncMiX+I+lqHXWmvSL9INghq
	1PGxS0WJ0FzElEpSxGSLf259GmXoVh5BcclsHK3IAqyLS13O6u90Q0w4N6UuTEXlEfU=
X-Gm-Gg: AYBFou14OtV1vEpYlvvGnHWnAyTM+FYSwEnIdPGxcXZyuvcylmyDPhs7YGezLJVgoxd
	Wzcf/e7jlK/JW1r3XjA9RN+hG/tf1RYPqcWqKdpWcnqiuBrnKaf25eY77etCmf98KMKxDHmzB8D
	nJ+wMAqJB/s918cgEpGwDGtaXl9mXbteevF/BUdpXwGKKpd2Ki6xGfIXnOQL7RTSm8DlfnVsUDL
	EC5h2lq1Km5lppbES+lQycV6/y0w26myBOjHCE6m5C5SgyzQ8xgvUpnAiXKagu4OJqY0cfeFZmU
	Jl2VQcb8Kj8510FQ8E14mZuaHIT1RUWui7exMG2dCc7x+lXhQmISVKkCOn/g99yy6JEEVclbtzX
	nJFsNbTmrwPvox0PeOiHnNFNJEs/JZ6lnvEnfzGdhF8bCWSYXXRcO0iwEjtPcRt6WQuelx1+HmV
	ZPzmJD6Gawo8+7Ba4a9ANythlwlz7fBPFSGUdD13xf0/6YHwb6TT8orbtDcn6odbfF2Sa+/wnv1
	U+4Js1VxJ/x9VZVnlvrxhScL/oVl+9Uh51b+cRGwW7AbzD3mpwv+024EjR8Dx8NlRuVmPufpHRU
	aw+5TS7ZRYF2WjarAf6GolkDnRCEHTlUOz+gkEE4GflQjl3GoMz25JzfjyYDvcK3XfXCid89A9R
	GgYJvoU73igKAQmI=
X-Received: by 2002:a05:6214:1d2a:b0:91f:17be:7c90 with SMTP id 6a1803df08f44-91f2424c199mr78511936d6.55.1794640234508;
        Fri, 13 Nov 2026 23:10:34 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:34 -0800 (PST)
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
Subject: [PATCH 14/22] mm/page_alloc: count common memory nodes for kswapd recovery
Date: Sat, 14 Nov 2026 02:09:51 -0500
Message-ID: <20261114070959.3490008-15-gourry@gourry.net>
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

When a zone recovers above its high watermark, free_frozen_page_commit()
clears a hopeless kswapd state if more than one memory node exists,
since allocations could then have fallen back to another node without
triggering direct reclaim here.

Only common memory provide fallbacks, so count N_MEMORY_COMMON nodes.

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 580feeb608b7a..6d98e213460a9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2949,7 +2949,7 @@ static bool free_frozen_page_commit(struct zone *zone,
 		 * kswapd work again by resetting kswapd_failures.
 		 */
 		if (kswapd_test_hopeless(pgdat) &&
-		    num_node_state(N_MEMORY) > 1)
+		    num_node_state(N_MEMORY_COMMON) > 1)
 			kswapd_clear_hopeless(pgdat, KSWAPD_CLEAR_HOPELESS_PCP);
 	}
 	return ret;
-- 
2.53.1-Meta

