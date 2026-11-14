Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640218;
	b=G49AC0d2s+mYIbRnonAWaxKn8fCfPuYoP4KSv+mpt8mMa6ftzs6ZdOBYKTSQ/nfaNw7k
	 dBdIGCI2Qjs6SUqs6u16eePzh3roTwPDYxTORp2ftTdPidaU0Vmj4vpAdP9P0RC+9dDbJ
	 6YrT74Z57+xPII4H/AzcauYdR70ZENHrYPkykEB/3UAUbtgCEID2jmZh/64dkIGJoK9jA
	 sbSMhlWO375vRBWDME9HjobImwU036cWfhcZSFOKKop4GFguPeo8TMP4sQaLvwgPXUU8E
	 Xf9h5ls+/CR2TVmJdlWV7WCX5PVsDOpfWav5QdHA3nCpioIyixPmGLs1ZyS7Nh2Tdlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pld+EM/EXNXxfgZubwvob88FbJ3qDEqFg5eLGFwAxrw=;
	b=N02I4C98pQA8yiZtDPvXRr7AtJN1OEktny524mBT4xKhJU7q/qtU9Hle9peVyMz3Vls0
	 ynJ5dESEsSNkbdFP+WaOM6vS2KYqu44MuQcvZFt80k0vSQIj85aAe+VSdRsPobhEzmL55
	 FJBH+SIW9b1reMiu2tTxmIKjUCBz1uWEqLVVApchyH7EeHctQteUITx8YaIeIa791Zqwb
	 zPvEjrOw9oL4yGNaUvyf0vWQypAUYLkdfuH3lRNlI1Gn2iXgxy5EMUPzFjIb2abJM/aB3
	 kXWvi7T7Cl+wb595OQToMg7s2F0tCZR54ZDZKrv49hF3jgtAru8S4Nzy73K9gSkSzmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=fZh2cb1L;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F1E60A3807
	for <linux-cxl@vger.kernel.org>; Sat, 14 Nov 2026 07:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14F1E60A3807
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=fZh2cb1L
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91e7fc8265aso35589086d6.0
        for <linux-cxl@vger.kernel.org>; Fri, 13 Nov 2026 23:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640217; x=1795245017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pld+EM/EXNXxfgZubwvob88FbJ3qDEqFg5eLGFwAxrw=;
        b=fZh2cb1LiTzSJJuOnufVWdO5uqn8qMfsQjZkSDcuVrcFCC3Nz081OmFdRyBdfcDXeK
         PtqCPeoNuyEztLDVFQOTRjF70fsbDa/YamFvNQf9kWWfHaCXg82Zwzsa4UJu71zJVFbz
         DrH38E4lxwMsJRxFci+ewX/0oAPjtdvLPYZ5VTYhAzrtXdl3mrASJNk9oDZMBuGQX7J4
         pZnpsmYLNfNkHHM8PmVTtoIUGhudURHAF6PdA0hZAdyipbVro6zJupwZRkdKN0fw+Q0d
         ORi4tocZDqoL6xebdcxuIfScFZIYh9Xs4P3jbWKeSHPO5JkBm9C1FtrFtA0lJ4W59m0I
         fNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640217; x=1795245017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pld+EM/EXNXxfgZubwvob88FbJ3qDEqFg5eLGFwAxrw=;
        b=ZHiOOIPFJVw3KQBrqJ31oTgDy/aStmES2hrn4uJF9lSjct2mLPBOyrIachj+NL7Had
         LWaHt7amrww/GV0xiTMtgfAaOBQyta9SZxesXSSdLOxvwobumbS+pFbhS1SjfCM0OEpU
         8mPrCcAWaWna3NkNMmEybOIUYa/UJPTTIRr6i194Wf9isANhf2yu8WRy3u+DHOt1M5S1
         iB3SGOC0dLVurtdZkCQSxwoOAkBb6jmbf5CvsfOVsCnyuviFTjx4urn1ZWXarUEOfDfz
         ILsF+GyFDnj+RSEbYJyu3N4cETY8ZnwZdyR0mG1hYgaag/06Fb9AlH1F0Npt3ckJLI3o
         ZfzA==
X-Forwarded-Encrypted: i=1; AL+hErFmjiI/DdGiVEjHwDMuDkF2tGNKHirH/OpognZunQX+o1fUe72S6J7+D/1nn6ZrRYcP6+qyfaj8h1A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9Y+cSeuHf2xJpy7pFHOwQWfb5u7G7WgE6/dAJqeSAl7TL7HA6
	tu0LDNIBPEji0dh15JH2bNIx1GxzOju3TJuwg+/8PTzbdwL06+qd1xLrF6igqNX6/4U=
X-Gm-Gg: AYBFou3AWyGsr6EF1ZBK625TCqifKZ/qbcj23agASnaDU6abzfojkjNXUSjKZZzH9ix
	blJzVmGo9FyRVri8rt3ukvFEiSiD7qfNt7o4havcY0qDsv40aPmTELEv4StATgfL6SVbRXlKImW
	IhUUkSE7NUvfbjglUkdwY7BFc+d+WixDEZuEPumtVr1vJW4TdELgiAh/8qKb+ZqqJBSlHX325u+
	XNKuziJXITTte5qMKq22AqV0aYibH6TYeqZzDWukvAmERqsIKlxb7JHk2QohXcBCrMEfRHpEFSw
	AyDYJpDlZYCIudN2TgswQUMK8jOMyN71F3U1J4DEGn6+13ypx7j42cCmhKk6NhtthtrVO1//3tJ
	PKZEK6zNwzTtVFCtjAzwQSDKUQNFcaqDA5e5NjaLM+VOmnrfu2tYpP2YdrXPxT9VrdGJVa6dt0c
	FwA/FPrUMcR/4sBMlVkdNTOMD0Gg0yjqT/vFNEqdD9Xp98PiUj/hWjsXxrxCAniqxTBTQ8bHBlN
	laq4I80vxuyzsrF9ai+JHTYWMak9cYl0ADwEU+2yfi9G0yN/0uuDtLBUgog532B7yj11lmJNXnp
	CZqWykKDKHackhaBDg/DZ2y5umZz+YIl7/lNvABx33NlxN6X5vhZYhWpaVI+UGYxE/Uas9rkdV5
	i+oaVjW/TOfeRX2n4uoOLt0AVH+l9BGiDb6tM
X-Received: by 2002:a05:6214:6347:10b0:91e:cf4d:f868 with SMTP id 6a1803df08f44-91f2420f9c3mr56246926d6.22.1794640216984;
        Fri, 13 Nov 2026 23:10:16 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:16 -0800 (PST)
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
Subject: [PATCH 06/22] mm: base hash distribution on common memory nodes
Date: Sat, 14 Nov 2026 02:09:43 -0500
Message-ID: <20261114070959.3490008-7-gourry@gourry.net>
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

hashdist is useful when large kernel hash tables can be allocated across
multiple NUMA nodes. The tables come from ordinary allocations, which
only N_MEMORY_COMMON nodes serve.

Count N_MEMORY_COMMON nodes when applying the single-node optimization.

All memory is common as of now, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mm_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index b4c4dba93652d..0c076bf5bf380 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -685,7 +685,7 @@ __setup("hashdist=", set_hashdist);
 
 static inline void fixup_hashdist(void)
 {
-	if (num_node_state(N_MEMORY) == 1)
+	if (num_node_state(N_MEMORY_COMMON) == 1)
 		hashdist = false;
 }
 #else
-- 
2.53.1-Meta

