Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640250;
	b=BqlT++fxrIKcBdicPO6xJasT9sqZL2jafRXDZ+ED6a0R7prRh+9tYb/wAL0jBHaTtzrf
	 ueNHJVDqFoQwDqHUHM/W/gwT1/XQ2MkD9qySt1vov2KDt0tP4mD0SPjitgx52SDst7OMu
	 B6vJdTrlDYHpp1WCQmAUmLRAWYU99ACaFIB2Ik3gvgED6aewmY0V7JeYRjQ0cq6+3hFsn
	 0e5x4baHCpWeKTnNkpHi77mW70InGw25XcFixKeAB2tI+bSwLXnEnv84Pc8bJpbDOzA31
	 kAIoiJmml1ki0bq9ihb3OKLuW6aqR59vf6rzNqEKP7To4P+ypixVA6tX9Whyx7PXu1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SG9odMntLujN1bfv7U8SkJUk66Dld0t8e7Q+mOyqXTQ=;
	b=dmdigws7ZCwK3LJb3h1QjWFXaLvUuCjsHxQVBz9irLRrCtAL2abwjiP+YSCJcq/kqDiB
	 v9ZGN2Qj3ybe1TJdGCcykRZPozjIceo7zzlFKrHS45DS0GD7BH4vNVNkHnb2Rxz/u8R/T
	 G12dzf3dhRhkSJdjAjva+ssODK3Mb2zyGT7UFYqfae/akzD5dKIBEvK0/Sg3PFD9BZn1W
	 M0PVG1hkEd+jZWzX3pxVWw3al51FYXMYQ353bM84/U5mK2eC8ioJhEhVeOjg83dgWOrEC
	 t9aiSK0V7x5bToE3gcx+F+55fSwWLIV3Q7Z9L5YEyUqJ/I9UotcM2NT+EGLrimvxY5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=nUe3qafv;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E66606CD9E
	for <linux-cxl@vger.kernel.org>; Sat, 14 Nov 2026 07:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3E66606CD9E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=nUe3qafv
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91ea2e29d90so38114876d6.1
        for <linux-cxl@vger.kernel.org>; Fri, 13 Nov 2026 23:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640249; x=1795245049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SG9odMntLujN1bfv7U8SkJUk66Dld0t8e7Q+mOyqXTQ=;
        b=nUe3qafv9syivid2So3rSgvuH7DZPXQ+C2hNnSKPxSgCSgNstQOq5ZauJDPuC8EzGe
         EPc3rvJ8i7VX8Vx4z3rdkuz4b5/v9ZapBbQpvdki/go/ijbQrxbYSU1NDWob3cDW97LD
         LnMvjnQ9of22Wo+EjgkaA7b+zyM2DJPnxYp2a89EeFLotBMzHlXVjFeFCTHrKTeY5NcQ
         91ghXJtB51aOfQmHtaFyRmryRQlu5a3ABAK7+f8sC33jgP5MHGfXKYht3G8gkN0Q90UI
         KipjlM6Ftuf2DaQAouZwIsVVWwkNGIDa3kAx+zcyykQArICxW/XrYq3vejy92XQ0eKEp
         S3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640249; x=1795245049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SG9odMntLujN1bfv7U8SkJUk66Dld0t8e7Q+mOyqXTQ=;
        b=NRjl5C5wQpsgtIUO/M6aJUdRhATXuj5JnkY6shj3QTYhfEamLzGDNWndm4kw9umMUS
         t6qF244reMcL0OxLAtzvoeSqxLen+3urcoIk8AvE3HUmG4lsCW3e5AJLOklUmsLGcmEQ
         CiGMSF/x6N8fxeypJcXgqJkZVCQ1Re3Moi9cV/9fYpO76MdFdnqUb+g5TMLdVFZBMspB
         MPx4HsMYsBBMl1fLNA/aJqmVeQvcOU1ngReXbXgMlp7HiHrneqUKf1P8ao/knHE2W+Lc
         KHja37VXrrp51AuSiMqW19DgTSBbwqja6/ZSNbPTMpkGHpufFQFLQhJkoU0u/pKbzgih
         Dn5g==
X-Forwarded-Encrypted: i=1; AL+hErGEqoHV3vgB4NkIQl8R2QN2shjUKi3EX6G77e4JcW8yLYjEpqgxtF/8HXnARh8TXhDhnnifkoNmBjc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lDELwb5ojFX9n5AoPbGFtLHZtlHmtEzbMY1V5fd6gEvO8ssiT
	/325vkbjnGdsz1tj4doUO+Z3uqlBj2QkksAcwQqiGFGq5zQvolfPnhK70V8R3mYn6fI=
X-Gm-Gg: AYBFou1ELye4otIc1Odd2tFz1xIarXbmu5IV9bWHRUNmrVLoYti9A2PsvJ2CR4xg9cQ
	tJg9SPXLbIQc2HP/MqaJ4BsnQ03BkkKKs4kBjdIhYWrRkASnvggo3DRWtB45b2kdHVucrn4NiEv
	JaOzEmq6lRAuuVrKY/ICIY3tRu1E8fS4qZzvdxVlVK/eUW+N72cd0RVN5Re/vcG4Jsr8Ud2wY4Z
	BwFnp8yd5Rt7UvnXbWaN+14yR+tHm04SCM5d3BTqf/C2oAnLTHtBQ0aJcww4FakaCuGb4VXP6Bh
	Nh08KiCIp9g4j4strQgnPDjRR41lnn3GaKC2oEIOmoXNoV9uCwRD3bod4RUHTkDRGTROrhprfcp
	DdZCqdJdPHcWDef8Z5mO3ify+o4C3xA04q9swdgVRaq8HZX7hW3zgEiH4ze2HfRt8ARrQjAOFNl
	LNoV7131qDV+g+KUuBOUeCadeLYQFjqXzW4cB3KYJF1ZOhae0veHio/Hk8LNmQg9jBNViIv6mQ1
	8Zn2ihZq6e1SNXBqpyxIWOZ5q13SSBWcs8iQhfh+WnOgcxeqAIvbpu7V2nzpe7oNvOTuK60e0wz
	fFznmWyyg0oqnIgm0wGpqf0hso8+RzmnnmA9+GxLVHrsCUBpxY2CdFcF5PWTtzNf7Ejz+pt3IVK
	dGsu0+/uyfp0Xys6r
X-Received: by 2002:ad4:574d:0:b0:91c:913:462c with SMTP id 6a1803df08f44-91f23f211e7mr73834306d6.0.1794640248788;
        Fri, 13 Nov 2026 23:10:48 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:48 -0800 (PST)
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
Subject: [PATCH 21/22] mm/khugepaged: base the recommended min_free_kbytes on common memory
Date: Sat, 14 Nov 2026 02:09:58 -0500
Message-ID: <20261114070959.3490008-22-gourry@gourry.net>
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

set_recommended_min_free_kbytes() reserves two pageblocks per populated
zone to help THP allocations avoid fragmentation. The reserve serves
ordinary allocations, which use only common memory, so count only the
zones on N_MEMORY_COMMON nodes.

Every node with memory is common, so the recommendation is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b4bd29f25c145..fac314b89a234 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -3149,7 +3149,7 @@ void set_recommended_min_free_kbytes(void)
 		goto update_wmarks;
 	}
 
-	for_each_populated_zone(zone) {
+	for_each_populated_zone_state(zone, N_MEMORY_COMMON) {
 		/*
 		 * We don't need to worry about fragmentation of
 		 * ZONE_MOVABLE since it only has movable pages.
-- 
2.53.1-Meta

