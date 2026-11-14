Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640249;
	b=ShMoUOySB+walZ+TMVf5ZSvOvx/VUryhjz93D9C9jYi4i4UtV2vacgXUOL/GxZHXdWi3
	 ybqkFFVVR7s4aUXRK6TANe1uLsrdVQy3jEzjORKNVEeQsdcIvyGnzDdDedh53pFtbH9Df
	 pbQO2fGmMWqfU7zy2MVizZkrj9aay8T32cCnesjDWwf3rXUxtBW3abmfgOCxog9FmzlLC
	 vpOpn77jcbKwxdUyJ3H8fsZql+dmghW5HK8jvPi65LTQ62qT+hGuCPS8hNsosFGHKwD4p
	 GJ5MVBDzxwnaO1uWDg5yTa6A1c6jZPpawLTIr4Y4deNBuITQV0DP35OTeStXKrOFmWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2WARPg/nf2WwBmWaZN6JnUP4gbZP7FMkF0eRnIkIgZ8=;
	b=K14nYEgYo/kq2IcE8ac4ocVbtpXsamNxupqTE0OO77vpnUEhW5bEI7pTDSNYpiwGp9Kv
	 ehNoW7c8aUn2BJ5WOlb9ntwH0JiGO21vq/AWmhMZIB9Jz7vXo4wXNwE/MPjP8dS4CfUkU
	 HsxrSre9NfEBHvh5ULQx2naYborW0ag26tbibuPpI1C7ICE6JeaHjXMPVMHWzqWbw9/LF
	 1DWjqihULWgsMTGGH73Y6vPrNBQsj7+ZMHu8pFJWnXfST83+Ksdi3yJzBoTxTDQzd8+GC
	 X6dYuopvKD44wQhkrDjLpfK7oaT2x/1i5ZPhjn4Vfr7J/DQ2rqZ+CPRCLkl/NFc0O5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=BLBdnt0i;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDEB60A3811
	for <linux-cxl@vger.kernel.org>; Sat, 14 Nov 2026 07:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FDEB60A3811
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=BLBdnt0i
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-94959217274so235902885a.0
        for <linux-cxl@vger.kernel.org>; Fri, 13 Nov 2026 23:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640247; x=1795245047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2WARPg/nf2WwBmWaZN6JnUP4gbZP7FMkF0eRnIkIgZ8=;
        b=BLBdnt0iRNFdOZZN6B0cCDu/hXyt7k9PsSJY3QJCW3ekKrAX8pBPAbkT3WVRuWwYMw
         zSddppBa0D0C7Cm3/JDK/25sp4KjGdI2ObCcZ3l+uuVPtSgiCU952hXfESBUlw1mczJg
         KHLuORDxaFQGrfgG+HMb2PbJ8MbRDgOlPMNKfZQHAiNb7/kvjLe5uSwFHyHGL1c1Wn5u
         n/yf9bUliz7p0g7CF/tctqSCoW6EGDPz3Wmzti2CG/xreKkeI7Dz0p26HxXLxyI8SqoP
         jC1f5E71FBV3WJAhSXNNIB1HwWVEvPiiJHfQHn1hk40/DTFMdowDbXfXF0FkV7eRjWMi
         Jwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640247; x=1795245047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2WARPg/nf2WwBmWaZN6JnUP4gbZP7FMkF0eRnIkIgZ8=;
        b=lAdu9LazKRp7GvMGVUCkiNyc+E9efDJT4JiEOaOh7/+YCQE/hXmSCu+UTWw4ufpVrl
         AyaKmY1G/v64gL7/5m4iFyYw1Hg9NUlKcVA2m2MUJX+kXI6BoEUJtobaLP2C6/BMvETy
         yBpvrB3n66+7BMVUwJ+0Db2ePs1CVx6/TeAS0zzUHhQiIDnsSCMiwEKu5ooBB+GWHlKx
         2mOsKFALJH/hkp7VyY8tyrCP6iaQYRvwMJuu4S3RvxpoYnFvgx0whByMyFlYYUZfmydV
         ZnEsTJ8Z19GCAWxLsONe6LQT84KC1Z9HMI37UhjIIgmae8SmU1IX2RtaRZAdQLmN5Hvt
         mTBQ==
X-Forwarded-Encrypted: i=1; AL+hErFJr3hYOaxWjvC9CDluVt0O6roIZ8ILmFbzBoaQ4iu5yFMhyEoYVzUWM1CWkarOeLVz1ipJH0gIkLI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lYjLo7MT416dHwu+mcFC7oCcfgm3xIpzPoNdG9D78RZQiQMBQ
	pgVGu9lQdgyOsDv6Yw19yCnJUll38iQ8Mi6xFUPLo4l4VWAwsVa0fzdc5yTXgxaeJmc=
X-Gm-Gg: AYBFou3FNi1Yz8//5OpEf+Vp0M4iVE+vnlDLA5C0VO6iC2wOG3ebnEogw6I6DQO59g2
	SRUO33vc56mZxcZCoXY+NkgFEe+YF/1BOYCXUi1/WNDKFFOBlBcGyerLgn3+A2bGi+MnDQjHN1b
	RRZhpa8oBIom/uCJCBhNuqjLitvrvMm9/3HoQHbCLlnt3++MBnqZs5vs8E+i/vXC2+FzupkNVYP
	W+XoWhjCupKytIy1TlT3VI2BfOolLD1nwYk1DTLM4gvaat/YJcNe8UbQCVYV2BT2A5ZREgffyMN
	eqM/J3k9iNV6AsNXZY9ZrtxuLLgUuh0axaM3o4Ogii6InudMLOW2f6HCSRR0ttparecAqArF4Jq
	u9gwHUQx5uAnl1usbbokGtyawKIdR7Igl479kHdiNhQXjhlFCCTtpYsgYiZV/sfiuSOU98QYgQx
	VBr2ElIK+Puwp96fTHZYHiHEu4TksVc8UpjPiB2TrOMwiUxzfWuKqXp792Kixw4368kL5fpBxce
	EQe63FYKv2vLrC3giY6jHt5DqJQnebsnvPpUCIvEd2kM2MUaw/8NdjeqHOOYrWRGiy/wrzQs9K6
	LHnxW4vR3SgCti424iPOgw3ClP1TY1DVIcEb5eCtWcBYjaBOvyhYev3wLpAMRqF2Sgw7n2QuTQ5
	LugyMBpziYvO/Lxk=
X-Received: by 2002:a05:620a:801c:b0:93e:c12c:fbb7 with SMTP id af79cd13be357-9494bc76c5amr813866785a.68.1794640246800;
        Fri, 13 Nov 2026 23:10:46 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:46 -0800 (PST)
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
Subject: [PATCH 20/22] PM: hibernate: size the image from common memory
Date: Sat, 14 Nov 2026 02:09:57 -0500
Message-ID: <20261114070959.3490008-21-gourry@gourry.net>
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

hibernate_preallocate_memory() and enough_free_mem() count the free
pages of every populated zone as room for the hibernation image, but
the pages used to store the image can only come from common memory.

Count free pages only in zones on N_MEMORY_COMMON nodes.

The image metadata estimate is a separate sum.  The bitmaps track the
page frames, and every zone's frames are tracked (regardless of node),
so that sum still needs to be calculated for all populated zones.

Every node with memory is common, so hibernation is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 kernel/power/snapshot.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index d5dba0e50b2eb..8aeb086a3fd3d 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1866,8 +1866,10 @@ int hibernate_preallocate_memory(void)
 	saveable += save_highmem;
 	highmem = save_highmem;
 	size = 0;
-	for_each_populated_zone(zone) {
+	for_each_populated_zone(zone)
 		size += snapshot_additional_pages(zone);
+	/* Image pages come from ordinary allocations. */
+	for_each_populated_zone_state(zone, N_MEMORY_COMMON) {
 		if (is_highmem(zone))
 			highmem += zone_page_state(zone, NR_FREE_PAGES);
 		else
@@ -2011,9 +2013,10 @@ static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
 	struct zone *zone;
 	unsigned int free = alloc_normal;
 
-	for_each_populated_zone(zone)
+	for_each_populated_zone_state(zone, N_MEMORY_COMMON) {
 		if (!is_highmem(zone))
 			free += zone_page_state(zone, NR_FREE_PAGES);
+	}
 
 	nr_pages += count_pages_for_highmem(nr_highmem);
 	pr_debug("Normal pages needed: %u + %u, available pages: %u\n",
-- 
2.53.1-Meta

