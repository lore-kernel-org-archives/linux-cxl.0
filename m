Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5732C0286
	for <linux-cxl@vger.kernel.org>; Tue, 28 Oct 2025 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761636494; cv=none; b=d35v9z20L8Lyco2zWiWQROy1//gm+JGeFH/M0TKLr7ZRyeghw9NZHa4M/2G+20VqDahH88plv+V7/PoE4JJsK4veTpL6Vgd5YrIONEmQYQMNuLFhwLUj5SffSlom+4xby/APVtiJrcHKgjOSEwMuThI0ECh8ZZkisRdoUydCZ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761636494; c=relaxed/simple;
	bh=5jvvcHxUgGRqbIUWaLiz/WJRrwTzEZ0ZYpj0wMUTbX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwwvwLffcAhauKbp9w8sPCxkC9ZqUTslE/4LJRyDP0v0O2fUIj/CMqxx9H+64IRfp55HrcIHJxBsGjvcrGvc0lFii/4Vfrnssi12Ei0KJH4b+5Oc/w6seRcWlgQJ1eS5RNMwhzTdM4jbJnmLsqdYHp7NOpdXONC0kRV26UIpihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+mWph9L; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+mWph9L"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-269af38418aso62867755ad.1
        for <linux-cxl@vger.kernel.org>; Tue, 28 Oct 2025 00:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761636492; x=1762241292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nktWl2QE6KyxknjQKQbtrA/rvCmzEXqRlRqq7ZLB0co=;
        b=k+mWph9LAkWqsZBmexAZ96zKggPU0iINXK80GFSGT65DZ6KoFVQtlIA6JfVvModYxV
         mqpjTWIOj1XLh+L3FHcOwwmytBsawFyyijRm4WdOKQxp1GdM8SB5PswxPkyPhVsHdQLC
         Va++92N3s9wJX8UTSl9l+iDbzbeCiznad3oW1o3/MS7hC8fKSC3CMEcihtEyhBuGQCt4
         nEEYC3FE0J9PBJgZgEUMn6xiOftO6CoAnHX6eYCiXeDTEHj7C5yGxpI/IK2hxD7/aC0s
         qWLZ+1yVjz0W7AN2pxcXKqbExNWDoz3Wd84PBookNjcSC/HVxCq1H7Zi1LdE5aApJwWf
         qvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761636492; x=1762241292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nktWl2QE6KyxknjQKQbtrA/rvCmzEXqRlRqq7ZLB0co=;
        b=IPt7u/9/51QEBHg7v3bCYL104sH7sPquAo39m08HnpXrwoGYwlk1Iuu5DmhQMf9MfJ
         vpzmRyo/vZeogHt1VQ9qXZ13Kdkr4L8bNiXXNl6OpRDZMlXYhvZ43qUSfx2SQ9ouR1JW
         V9D+c726yoIH5R7JvYSr4GOh7UU7wpKLp5jm/n01DuzLd44ldtt96/FBa2VQjzpjUqUb
         wfi2lmUQ8DmipGwSuPeHmKCtI/tUDg5LuZNoXm8rF7+iis/EZLt+tXTTPJsEOCCE4oPb
         tnM7P2GusK2qDAnahh3q+/NQhGnlVqkYFQ2a9q8MJzxJBtRndP4gdlZJ4qP7R9EjSDwE
         3dRw==
X-Gm-Message-State: AOJu0YxWEgRY+5MQ0t8GwabQW+rjR6iyYbnPkZmxG34KOiNYrmhpvPDH
	NPXkDmGyJlHbr1xAlCWN9nl+Iv/QoDwOYZUjsDgMlMU2chI/cEf7p73x8cuFwQ==
X-Gm-Gg: ASbGncsobip3eCCrtFLDvV04DFFJAP2J1HADe+jviaziUq18UpXCQmqRy0EeR2J8pWI
	BArGuH1OYqqYRNdlILw9rD3Y0EmdQUWZlRra3Qj0Rw6O9Qt5pslJU2IJ08L0AOr5/zrjCCb97W3
	hNFh8IHOQlzzScQVqOEfRxZhTirLYAkYOnugyDfW+AaUfE9+YOmRLkJXqezsye1s5MQPVlSBR17
	3fWJ9YbeHYfefWkMRnUUsYUv9MTCHtlhJKypaP8FFMlMTkO11vrgtZRxYwggS8YlT46lgt/EjPX
	uV3AjEf5UgF1+u/R7kBC2giz7zvIPtuDRyTMIhZuJkP4JpwJenACp5S8GdrX1Pw7zaudkqjvone
	yZgq6Z9Xu8ICZxNGPfCURXW0rnxehQuQWDfaS1IhxtKNoazJd5KOm2eJzyJQydoqG60CW06TCuJ
	8W0YK4+swlIA/KIA==
X-Google-Smtp-Source: AGHT+IEKTiLgH0R/bRPXbcPiopPoUMdKq0Is+SUv85mcT1iNGvD0tY2fXA7nq6m7Ri3Uue3XCkC79Q==
X-Received: by 2002:a17:902:dac2:b0:27e:ed0d:f4ef with SMTP id d9443c01a7336-294cb51ac17mr34713495ad.41.1761636491819;
        Tue, 28 Oct 2025 00:28:11 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:7224:bdaa:f2c:3fc8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7128e41c01sm9400361a12.23.2025.10.28.00.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 00:28:11 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: akinobu.mita@gmail.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	hannes@cmpxchg.org,
	david@redhat.com,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com
Subject: Re: oom-killer not invoked on systems with multiple memory-tiers
Date: Tue, 28 Oct 2025 16:27:36 +0900
Message-ID: <20251028072736.10455-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022135735.246203-1-akinobu.mita@gmail.com>
References: <20251022135735.246203-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lru_gen_age_node() checks the reclaimability of a node using
lruvec_is_reclaimable() when min_ttl_ms is non-zero, but if min_ttl_ms
is zero, it unconditionally determines that the node is reclaimable.

I think we should still call lruvec_is_reclaimable() to check
reclaimability even if min_ttl_ms is zero.
Otherwise, we'll miss the opportunity to trigger an OOM kill in
lru_gen_age_node(), which will cause the problem I reported.

https://lore.kernel.org/linux-mm/20251022135735.246203-1-akinobu.mita@gmail.com/

The attached patch made the changes mentioned above and worked around
the problem.

---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c922bad2b8fd..e1a88ed4e0b0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4148,7 +4148,7 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 {
 	struct mem_cgroup *memcg;
 	unsigned long min_ttl = READ_ONCE(lru_gen_min_ttl);
-	bool reclaimable = !min_ttl;
+	bool reclaimable = false;
 
 	VM_WARN_ON_ONCE(!current_is_kswapd());
 
-- 
2.43.0

