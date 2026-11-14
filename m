Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640238;
	b=MSifbCWYKVV7lsJlhYNlT7ALq0QhnVmy+LYlwHqnljDoD2b6mqUPQFU3Bcs/3530mg6X
	 QK7ByH00EGhFEqxw5fhguP2UYjTSyv62H5zPtGdAqVaZrSskQBejUg85yEgz5lsT4jOij
	 gxoX2mnlaA+cuNcb1oZa0RGRGJdS+AECnkAd0S0pZzdunA9p/3tdDPL6Bj6t/LphFrMnb
	 QOkW5rV8DSY4gQig2AJVf5apt5wydzk2aD3c5/JOmHAwM+jPihkHpSSfqZnTBOlenYeOo
	 z+vSAscWfB+ZxQTaLeT8YPhplcx2V4fQmGc+OMO6TIeCDAlrPu5P9OH5/ktQRnCb7PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kuOKXOl2seY2nuHPa7QaSgImf7rgxxNJypl2yP4/rNE=;
	b=YGcf3L7KU8cy0fYvVLxd/Xxv0Ff85dQrrC1hY3CmYHaGsgrXvGDIClSy984hTHPhRze7
	 aFqWFULtn3rQdqm62L4Ha+bWOvAIPR6FflLSKC6oCUeEWUnSQK/pAe1rselGipC6mFeCz
	 Zxu6RDsCUxcCkyUh0zr5F6kvEbS0FJ0yWhK8Rfi73sbf3f54pJmvUfqjFSjnIwXlVk2/r
	 XM9JOXu5EQ7sPZkCPXHpfslPT5Ctqt5fDhSuZO9C2O15opV92NG2xL7eGV3yZ1IqpzkXW
	 LHhsHyI3RmeGNAKypL9BVdb799MHg3G3N6PaLbceuvof2VLS57rj0Hh+oyZmKOKbBGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=SHqBm5if;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96093606B42D
	for <linux-cxl@vger.kernel.org>; Sat, 14 Nov 2026 07:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96093606B42D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=SHqBm5if
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91f332a4b2eso5815356d6.0
        for <linux-cxl@vger.kernel.org>; Fri, 13 Nov 2026 23:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640237; x=1795245037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kuOKXOl2seY2nuHPa7QaSgImf7rgxxNJypl2yP4/rNE=;
        b=SHqBm5ifuCi19eDdU6VNqfmX84OjLjh+oaxxPBrlTMKU80mySufaDtPUSv6TTq+zz3
         +Co78G47v6fONadDGxWKcNGUQvCgSrwXJFg8TppF+aZFOOUhKhDRDlDN+xaZiBXJsiWL
         7noGrim9jrxIISpyaZ75eU1EtKup7BugNNCXeDRghcA0y55HF5VFSXgx+LF7yGQw43gl
         GLL3BdlC928/BgZG2pu06rv3+OF8ZRWEogeefHb19bWYkkkKNU3yHRNuGBA6IGU7rTay
         OtcyhxTBnFmqdGbB+seDvJevG79lSnyMnw54BDiFQvk2elI7rbEALpd9fiaBlOif5Kem
         3c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640237; x=1795245037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kuOKXOl2seY2nuHPa7QaSgImf7rgxxNJypl2yP4/rNE=;
        b=o13pL/3tN0O4z2rOJvsp+NPnZJjwHcSlWB+Xct8E9zEhB4MQJEsbVsXDfmonhOOblM
         wC3R1Er4QNqnxc2378wRnW9Gf8jEdrTF18Fk5mX5BJ75OHVKacMWv73vuMvkfrPajDeO
         5D26fhd/PrcasQkPzOyvBIMEIYueXQ+D6/ztz2nBKrmW5PYEXvI7n2wDC0C2IhDD5/Uj
         TlyKNPAaE8/83FotogHbOM5I9hW1zcdwlqnC7nW0ovQEHdvVqxNnBtBEpeRt3aWWvGqB
         2TGRABR+F/LR73sdosUF2CSAXHXWA6uVeWmEx8dOZLlfe9qjzRdRjBWYrZ+aYNsLQtHx
         E3PQ==
X-Forwarded-Encrypted: i=1; AL+hErEp8SvRrH+hhF7qZiYxWPPj8z1FSZF58W9jKWkGjRznB1QYGAh8TPJldOSPuQuvl/nVAajDERLDhBo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TzyOJEQwBa6OYk6z+ud/Wjvrx1iWsPAtou7p+gbegG4KWHmd8
	Ndi9rV8GgSFJOzTXyBougTHSu4PPUSjXF8ZyNtoHiR+j+VWSO4jMlloBYAANznibkqE=
X-Gm-Gg: AYBFou2pEWWHMpauv+dz0iVJwH7E3GVfSchrroH6UHHWhHEad4bw0gcX0aB9yw8BVDT
	3nis2V92Ael7Zz6GOb7SI9L2IRkjochEBlhlz9vPox5sHu9ikYnof6xqMsWZ6yz+fEtvqaLpw1X
	aIConfN5kCvP6YYaOzZXTZqSkSb/sEOO5UiZyC4dYBv9nwYWvyX6NzdqV97hwrQRGt1/OoloB+N
	PwOstV4d08bpyzg7habgVlodTf7WHZNFoqtDFHOVhNubRZo3evWN90kxe9WMr5hVSGSnCL6InMz
	WvLn4jBrpnyWRTtq96hl6pDB+Mun3OwWnjuyIo9X9SL0YP5MhUmNxYNusvOIw34C+Q75kZoEt4W
	ipVXevImUJ/0BVpwPpcA9FdEdOPb22YZBBT/VvpFdRqigJ91l0b8n2BnHDUXiSRAgBwgGcJMblY
	s/VAYtpLTzUYxS/+44MCiQzOC45q09Qud2a3zZnbVZPG82AUx9YI0KSQL92dTpg8HdpeukLiz3r
	FR2yfoN+fdcbv1yUVJW2y/1eXs+dc9eYjaAXEXdgZRxMUdPdpPsPys9SPKfvUdRu+iCVKp87bqr
	fbX74gUkODWYWh9qWg2dgUmQpq2OXDFGuAT1JAea0HCNdm5iCfvh+itEbrzlb1/KZPlPmgJRamH
	fKY/ZEqv6+bQTbLM=
X-Received: by 2002:a05:6214:3b85:b0:91c:15ce:66ce with SMTP id 6a1803df08f44-91f24194ac5mr80511276d6.11.1794640236685;
        Fri, 13 Nov 2026 23:10:36 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:36 -0800 (PST)
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
Subject: [PATCH 15/22] mm/oom_kill: compare OOM constraints against common memory
Date: Sat, 14 Nov 2026 02:09:52 -0500
Message-ID: <20261114070959.3490008-16-gourry@gourry.net>
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

Ordinary allocations reach only common-memory zonelists. Compare policy
and cpuset constraints against N_MEMORY_COMMON, so nodes outside it
neither make an otherwise global policy appear constrained nor inflate
the constrained capacity.

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/oom_kill.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 5d48bd862c27b..1ec22bdad1fd4 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -274,9 +274,9 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 	 * get_page_from_freelist().
 	 */
 	if (oc->nodemask &&
-	    !nodes_subset(node_states[N_MEMORY], *oc->nodemask)) {
+	    !nodes_subset(node_states[N_MEMORY_COMMON], *oc->nodemask)) {
 		oc->totalpages = total_swap_pages;
-		for_each_node_mask(nid, *oc->nodemask)
+		for_each_node_mask_state(nid, *oc->nodemask, N_MEMORY_COMMON)
 			oc->totalpages += node_present_pages(nid);
 		return CONSTRAINT_MEMORY_POLICY;
 	}
@@ -289,7 +289,8 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 
 	if (cpuset_limited) {
 		oc->totalpages = total_swap_pages;
-		for_each_node_mask(nid, cpuset_current_mems_allowed)
+		for_each_node_mask_state(nid, cpuset_current_mems_allowed,
+					 N_MEMORY_COMMON)
 			oc->totalpages += node_present_pages(nid);
 		return CONSTRAINT_CPUSET;
 	}
-- 
2.53.1-Meta

