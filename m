Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640224;
	b=bIS22XZc5vXVm6l4mjNhEre+oRkkRXKJgf9+0ac4Ni0E3xgOIsltlxxYvM3VNXGgMTPJ
	 v0gYE/iAum5IDeqKBkTJd3Edh+HBpejC2gLRSFBSRCbIVP5GBjdJ4XzZBaH8ta4M06Zy9
	 rJPRJeuFZ4QofGYFlrho7fglca3t61FiTt4nT6lkvCe7Ekgxkw8T3ZYcFcrfRKlGDLDjM
	 9u2utZ/Xavahom+f2lG6KxYXBqt6FMNSvZJ9zt7PdV3LjzlMnX5Byn3RgLUH4yqSC61nF
	 /fvANDXstx1B8pWVhZoHFAR+XsBKJcNi2cWLXJIBN60syesamfCRpQYaeS0JExEUcSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Y6oxwUC9/qQIZVXuymnHKur3Vt67CPiMCpmdjljurXM=;
	b=xM2eMRVfE5DBV6PyLlaLktwxFJPzXkXmHFuO0kY9BQMUkOb1trMWvDpd6adf7ii9ryKV
	 KIGd30jZoFVoWXfxqCsqFEAW7SokfWEjZZ4rN1Th2UuyeGxsWyU5C7mT+PL2GbnnNCjyq
	 E6ipe9kkpjpOzYxAZNx0dmDx6nPOhwXQ1tCAQ6wgl8aSOE5kFFeKvofdWsL4OM0ZoWM52
	 5rpgKw3w3v4TQWoDZbT3XDSUdPk4T9gRJjq29MqcJGhnqVRsBXjjKp8A5LTL0Ffbzx7Rb
	 3P4P0FFIm5FpjWxQ+LIuSyN09euRYbhf9P1lXQdtLmcHM723FVArkeD6WR8fSyZ3XZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=XlayBPV+;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2205F60A3835
	for <linux-cxl@vger.kernel.org>; Sat, 14 Nov 2026 07:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2205F60A3835
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=XlayBPV+
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91ecbdf5343so39949026d6.0
        for <linux-cxl@vger.kernel.org>; Fri, 13 Nov 2026 23:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640223; x=1795245023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y6oxwUC9/qQIZVXuymnHKur3Vt67CPiMCpmdjljurXM=;
        b=XlayBPV+6O94G4EvOv/apyiTo3m5/u93nKnLcvDMZ5IZPd0h+zJdRRruMsVEzi3WoC
         z+Si2hEa+Ua87rapVuCjiDYM3x1e6qBeqGGKaT+0sgS14MzxbWyx2Ucw9pF8mizmV1OF
         i/t/Oeuq2KCow2Q0aWnwaQcVV2jadem/GeVnEOD0NFZfkI+oaWFfXNpjKd+lsCUarnli
         6377+lF8LMdQhAtCoZ7vh4YMKQp23DrTIh9X0RMqS66GPLHgLk13lDoRAz5VubUIW3tN
         IQtaAGEJaTre22tDiHAkUzUrRrP/waHscFQx+6pylgrnkPGeI2Z6Qg3IFhDHNBbaaDlL
         nLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640223; x=1795245023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y6oxwUC9/qQIZVXuymnHKur3Vt67CPiMCpmdjljurXM=;
        b=b8ey51J8HAIdoXudDMxU0Zg//koo6EpAiCeFCPxql9rQLUyq7CIcjn6bsiJrVXztXv
         72UiJmBy7dzqRONzCoa7QBJprSTa4eBVoMikx8oMQMz4X+6dDE92Nk1KWoXqGlRbTgi7
         pTZ4YMyy38lq/Ptpj9YVU13x069PhTM44v0IDVwWCD4lYG31mz7gAc1UxUSbrw8WEmft
         S0qvD/uWtcBi6asBlOV6ViY3+Yn7IQR9g/BMlFZrKC77YIuw9FpcorQiSTw7jmRTwSl0
         ijfGXKFEDp4D3beP7REFbej+ofBRd3VZqrhCT8CY7bSGIi1PS8tHcIUit+mTvulLbbtB
         SYJQ==
X-Forwarded-Encrypted: i=1; AL+hErFdWu4MjmsABDkZ4od4+amzFHWgSlpMPoMnVqhsom2Hj373Bv4Xvt25DwSGFLvwReQ5L5Fd4z+iQQU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Q4Lq8zm8p8beFnqxMtuYLT+8NxMW+AvbYFBxtX1SauWe2Ukcr
	UAO1WdOj+OBAq44HEFqIasDpaNcIpmhBVrT8VjsL7x3pKWfWnWqdLtPLTYw7Mv1iSJk=
X-Gm-Gg: AYBFou1TDBdrxu+/3141+0PL0DpDy/rJavZ0qHJDbpBhM+hpsF7aE4oS4YFrSVOtoz0
	V9rZTlbIYtwGlxhEAleySSK5iyYQhbGecp8faFfqcLa1BWXz8cMwKORFNHizjaCE28CrNImRFM+
	Samt0VPqN09d+Fhd3uqBgqZVVQ94A+ye6T8lnwTLftbZpTG9mYjBLH5SNqywO6yG0utsxLlfF6E
	KBrfdQ2px326CyR3Cd/SOMxhsBfIIQJZ4LVp6qkNydTr/6nCR43EWXjyqVHNkmqZUb1lf7jsOQP
	MY4uXQW1hr3BBvShG3eYv34+DLY0YCLWoELLIiUSqSj2lZZQA8MIh1SmtoH98NGqDb1FRVRV1w3
	tGlkH9XIyp6jwAxH6tM/Yz+ZKZDDFNOsH03ImmRk6W5zStyyYmaWyi7ustav5rY/YCIArOW5s+y
	XGNzvr3l+Q+mTj0QxCRG1w53D+jz5kmx8I9W3I8LEzDTnlbgisVQAdwykoHGLyNhL7opW9flPK0
	trxdavv7Z6KIeJrm+98ZWAhrtLLHC2+wpeSfAWg2tZjjxISdnuVJ6ao4IOMQTupfPVoSSwl8wVW
	K9YB4Yaw7Q9qmKTQ5Qkx++SPPmiJZbdPotEw7EuSJzIGJBgNmtDf0yqz0cCal+ypGfc4uDMG8lO
	Wy780eJndHmAGefw=
X-Received: by 2002:a05:6214:2462:b0:91f:3182:e94e with SMTP id 6a1803df08f44-91f3182ea72mr35908656d6.8.1794640223087;
        Fri, 13 Nov 2026 23:10:23 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:22 -0800 (PST)
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
Subject: [PATCH 09/22] mm/ksm: restrict merging to common memory
Date: Sat, 14 Nov 2026 02:09:46 -0500
Message-ID: <20261114070959.3490008-10-gourry@gourry.net>
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

KSM is an opportunistic MM service and should leave memory outside
the ordinary memory pool alone - as it already does for ZONE_DEVICE
folios at each acquisition point.

Use folio_is_common_memory() at those same sites, which still rejects
ZONE_DEVICE folios.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/ksm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 623a2cdb39242..25b2c2f944862 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -831,7 +831,7 @@ static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
 
 	folio = folio_walk_start(&fw, vma, addr, 0);
 	if (folio) {
-		if (!folio_is_zone_device(folio) &&
+		if (folio_is_common_memory(folio) &&
 		    folio_test_anon(folio)) {
 			folio_get(folio);
 			page = fw.page;
@@ -2571,7 +2571,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned lon
 				goto not_found_unlock;
 			folio = page_folio(page);
 
-			if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+			if (!folio_is_common_memory(folio) ||
+			    !folio_test_anon(folio))
 				goto not_found_unlock;
 
 			page += ((addr & (PMD_SIZE - 1)) >> PAGE_SHIFT);
@@ -2595,7 +2596,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned lon
 			continue;
 		folio = page_folio(page);
 
-		if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+		if (!folio_is_common_memory(folio) ||
+		    !folio_test_anon(folio))
 			continue;
 		goto found_unlock;
 	}
-- 
2.53.1-Meta

