Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640220;
	b=YNK/AsGzvINEsfq6ogQDBXZ3LoK+fs7ELxC9TPG3yDvMS4Sar+C7Jjxqoe8lswS+MMT1
	 RPeaeKjmt4OJrpztfxaF06TpF2G9/PuuaeHsGy5QTO9dlPEYrAgh8VGi6PI88rME2gF1H
	 My9btqIEoRSwmuKujcUEE5Q7RG+D1pElDs5KZ1SFKnztT9fqdl305QEZr3mkjtCRM0toW
	 hqbyERuTiQQ+F9qNfGbsOosByPlIQGM7mzvAGeGyItGZeDI/cIWPNqRuXvbqzO/lBOkG6
	 FcrBg2XZ3ayFskPd1lvXiRyuBKSCx6YHzc7Drk3Ky535K7yaBQf2OxcaLEOm1JEVDbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KKsqfMs+Khz2jHdLUAmVstaMz+t2qjUPbSjoMCe8lqE=;
	b=gIKJpxnU/SlfMjRRC33MTRhdD4kuWNQobNXOUcIbzJ62NKYGmRplgp6TUG0aQGyLocHg
	 6tiOrwtEmimfR7G6cK3bvYVxcNcTDKt1KMFtegIFbcD3ubfPd/99NM0byQbzgYFNFxJ3q
	 n4H6qylRaqtmL7R2wOq0sVsGyg8YkGu9qheEjSqgL0HOk5cDdtLf7SOMj0GBlpDlSvY8q
	 GA2BAL8anV/VdIDDQA0pjtE8xneu+LqYG1NUYvDDyovfyoMkdG3EFFEBrxQIg7zfyiwCH
	 obmlz53TiNgU/py1iHKhFY/oVDwpM4rlF2qJ9n/ztOmUtnKWJTy1/ySgOLgQmCysqeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=DqwCNYMH;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EC8606A887
	for <linux-cxl@vger.kernel.org>; Sat, 14 Nov 2026 07:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17EC8606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=DqwCNYMH
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91eb53957cbso45071326d6.3
        for <linux-cxl@vger.kernel.org>; Fri, 13 Nov 2026 23:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640219; x=1795245019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KKsqfMs+Khz2jHdLUAmVstaMz+t2qjUPbSjoMCe8lqE=;
        b=DqwCNYMHewOC4msVcjcbomSD/RH/iBIkH1g2hmEJMOaualbLATe3pKbpO0F6X+Ys6j
         XI5ID0YU9Rl5GHP2YBUfgaG11qLowljKPp1L/CE3dS0a7sJ0FEZuYrwPHARVno8an/I2
         fKqYLyHw8DCH+YmeSLrTExiH4Rbiy5ZRGzSoqF1J+HyLIWvHk//8j6jliUzRu9EJ90gV
         bzdYIc2cA9NWG2hMcp+mPZpHos6QTVFNDUkTMHEywINAJzvZ14tVQfxCeMwvw86df8Un
         AilmmGsmKQFnPRbl1anjv+ix9zx5Y28uQSVyExIBRJx781NleEdiHu8g5v6XoaUTedMN
         vgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640219; x=1795245019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KKsqfMs+Khz2jHdLUAmVstaMz+t2qjUPbSjoMCe8lqE=;
        b=mlM2sbgDxRtPKMk/79izsZyTCI48KDTON9sHKInZT+udW3Zyqrt08SKjSXaN3wVZ05
         xWqkemX9kqjDQWgl2oRPogNycvlZawFZZZ79k2cHqQN9x2xH22dPjOvILSIeqLU7Iuxm
         BYLTPSqOjPnlJ/wVeCUahcm6nworvIJzYFWf/SWlpxBOCvIFC+2IIbOEqd6oKurblOzE
         BizNfLWZ0yr8N0+TCIPkQ8NwFdePHvvkZzFK7i0HtSLw4cZAUykZKCGfbepvdEB2tTuM
         7mSDMlsQzAles11LvLQE4AqzlXL9j1atQMDeTUA+//pfqOMIPqPEFM4xqL7xujfGndmD
         QRfg==
X-Forwarded-Encrypted: i=1; AL+hErHbwi0KToVkO5b4w+0gDU9SaICyjep0nY78KkFk3GsJfpU63su20GjFPK1+z5nrY1E7Mr++FzluFSI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DsnNY4mQNTrBNY59TKYFzgBGqq3SuYH9Uw0blC+SKajUx9rug
	u/G+oU7cKTue0vkcJMMuxL3jrT/m8HMoeP6UYykBkvl/V0VT2nBuvMLT2vL/PUtz5pY=
X-Gm-Gg: AYBFou35EeGzOrHxR1X628Vqh2IKn59y1TLCtRV600mwmvZTJTsfrFtM+VOVIynt9XA
	hT2wFMaQzEezJdcga+bo8Rvk2kYP/2hcgDd0jGptjDOUKGqu4iCemzwi77IGNW17Z09cbbN2ksg
	MTz14OcaaTeBAeKDk5VmdDd05HVTFR7kfGN2sCb3WJ0iIr+RsodDgI8PMXDsZjAN1iXflMMS0VJ
	X/pCPlW++IiWes66x/ghZhghImWDLq0bJ5e5GLqI5JoWR4EDWAIPaQo4Moky9fxWgyFfBVd1IW0
	BeSmk715viY3Bw00smQkTGxKhToaZmQU857xF6YGYx2BgEDzL6R3toxYdpSsd31Kc5oxh3ey+FC
	UuFOKR4uzZoHw3W9MvXONFhvtCnIelKBjJFjmC069KOf63bLmGb7yaGMtcZWrDN+E0dAPQtizrJ
	4QSHocZcpcq30lzlyq3ba3Fw6TfaJGeGUUi0jViwqqL0qRZYQYLIyXFG1HEvXQ7DzKgXrc1W98/
	ua5cR8ZYnkBOl/76O7psLZxgvpnIviQKhsZnz8O3cl7SETRc2Fz2XQqEGvC32IFVjZw8N/CHQob
	jBTT8BGpFKhOf8xMVidc9cFwIhJzeBdLhUcqj7Ev1tJtHL8Cle4fBR0zKQRxJ0iy1MAEpye8Cej
	5mRtespbCbDkT68E=
X-Received: by 2002:ad4:5d68:0:b0:91e:a6e7:b445 with SMTP id 6a1803df08f44-91f241e127bmr84458226d6.9.1794640218986;
        Fri, 13 Nov 2026 23:10:18 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:18 -0800 (PST)
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
Subject: [PATCH 07/22] mm/memory_hotplug: migrate offlined pages to common memory
Date: Sat, 14 Nov 2026 02:09:44 -0500
Message-ID: <20261114070959.3490008-8-gourry@gourry.net>
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

do_migrate_range() / alloc_migration_target() is only capable of
allocating memory on N_MEMORY_COMMON nodes. The destination nodemask
presently starts with N_MEMORY and removes the source-node.

In the current code, if the destination mask becomes empty, the source
node is restored to allow migration during partial offlining.

Consider this configuration:
  Node0 = N_MEMORY_COMMON
  Node1 = N_MEMORY, not N_MEMORY_COMMON

Node 1 keeps the destination mask non-empty, despite being unreachable.
This leaves migration with no usable destination because the source
node is not an eligible allocation target.

Restrict the hot-unplug migration target-list to N_MEMORY_COMMON so it
reflects the nodes the allocator can reach.

All memory is common at this point - behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/memory_hotplug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 490f400498f14..29ff2c46499b3 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1904,7 +1904,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		folio_put(folio);
 	}
 	if (!list_empty(&source)) {
-		nodemask_t nmask = node_states[N_MEMORY];
+		nodemask_t nmask = node_states[N_MEMORY_COMMON];
 		struct migration_target_control mtc = {
 			.nmask = &nmask,
 			.gfp_mask = GFP_KERNEL | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
@@ -1919,9 +1919,9 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		mtc.nid = folio_nid(list_first_entry(&source, struct folio, lru));
 
 		/*
-		 * try to allocate from a different node but reuse this node
-		 * if there are no other online nodes to be used (e.g. we are
-		 * offlining a part of the only existing node)
+		 * try to allocate from a different common node but reuse this
+		 * node if there are no other common nodes to be used (e.g. we
+		 * are offlining a part of the only common node)
 		 */
 		node_clear(mtc.nid, nmask);
 		if (nodes_empty(nmask))
-- 
2.53.1-Meta

