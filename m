Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640246;
	b=W8J1SEQ3HqiUU3oZ/4n8nAE8LTDdmt6E8FkOwXIITVsH5EZaNt28Q2pFHLGX/x9emdot
	 SmpQGTF/quJB3siWUNZE2A5YCt9/53mnQzLme7y2cRV4LdMVUNbXb8RNBOxUqH0fjIG4Z
	 /Y0370H+RvgdK91dq344fGDrkFEulP+iSoSSLlkfcXsRm0N/C1GqS3b3oIXEY/3pScN3i
	 NZdbJKocF5NJzluac1Mkp7MqjAkREG6wAsg/xH+x/tTFUKep/beM8bDP9GoV95Duu28ph
	 rsaGHF8X51I50wj2q2SOIIc6AN1YuBFvuA7D5WGzrSn1gtr+XmaFkSLzlbHE8jFO36A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YEak+iwgBd7H+tAUDcNraVIKxkIkqE3kGPmkcYQNtnc=;
	b=mUqGqe2qz+Kso4ddCQX+rlEAaR+iczf+0hjbH1pMFcV2597PR8xZW5BCH6uLu1eO76aa
	 zmVWPFwsuml+VjVvYSXHR+a3DbqRK3qenwcsPEblbsDxtbT5JdESYbgPqDa/8vCJaNZPm
	 fbZBi1mcYA6GFOF63WrAF6JssYww4/aZxPGTb/B8vW3epz+p2xeqoNW7uT9YhE+X4yFpc
	 V1DLhXbdzn76UXP3TIZBNI85J7bEuSraXS0cMdeho4H2aPlkjvVnnymmWNiyw8G4/lfZT
	 Dw3ifQxNLiQJKDhl3FEg1qYH7OXBiAVxWaM6+vxRukNGNw4g4283YF2eMGmKs+jofQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=vA6Z457O;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC948606C0F7
	for <linux-cxl@vger.kernel.org>; Sat, 14 Nov 2026 07:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC948606C0F7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=vA6Z457O
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91ea5600c9cso37049896d6.1
        for <linux-cxl@vger.kernel.org>; Fri, 13 Nov 2026 23:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640245; x=1795245045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YEak+iwgBd7H+tAUDcNraVIKxkIkqE3kGPmkcYQNtnc=;
        b=vA6Z457OaKIInkkgqCLFmLHWy8VkPxMPUJrmpqeT4EKmn4j55dJGJtm+KTlKszz4wA
         UVrXxbHJUqTl2q4EWTfsddFD0AVrEgctyu7/vealCMDaACIsjVaRi6fltMovNlc/ghTa
         MZxX0LaX68Na8PnWlYi+EO7zzd8dcS8Jgcy5MuKBon/qrGxyjrHOWRez095sA3iW/r3i
         BnupImPHFtuPKI6KKpj+dxkyO29yAsiGaFeOIXhXHt/49b+fLZ6RmF7WRM1rxS8LQxHZ
         Z3iuplIcBrJiSL7Vvv0lbDuimSfZhQq6LtlRDtpKViJ9Yo9UH/x4VBFOcBISh0iqvNYA
         6IsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640245; x=1795245045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YEak+iwgBd7H+tAUDcNraVIKxkIkqE3kGPmkcYQNtnc=;
        b=PtnJ5/H3DWKKsZMB//WwaGrDH5GUrPWUOaCoso1PZ3fNvCRvGXe+VpkOBDMpUCBENO
         y16SEdOolLMYP41Pz4TCq25e7jkBI3fBSj2VO/tP6g0Abaws/cK4upeN4g7EJLV/jpI+
         hfOXGDvpozm8pGzWsHsOBH0a+w5YuT2fpuANVyxlogtBi5BJSzjXjmefbCK/pw3IFCK/
         rL3trUCp6BKbujdLxuK4XruL4Wb07cIixfr9NZ6LjQA7t5Ak3lNwcKesisb42aI+QQ23
         lMDKPDH28mHlHhe7tEzUCdt2DjsptblBDTqhGlsfe44A2+/NlZ4BNska/CqRGH87/mMA
         57tw==
X-Forwarded-Encrypted: i=1; AL+hErFAnrCKEKCVIp/HF8HR2EvtkNhlPrZLYcI8h7skIrrSJkcy2zua8YK3W9wbBsSKa4wxrkGC0fw0ObM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BGhjVNDmYsfyELw7b88eyLiQPql8cjj0NyWDuuzzK3DJnubDv
	29trFKMJRM0/JGqEYBewyXeP0ncaVUHmj6PCzMN99oKiPMU+RsnZbyN1g3pkZYYzqQI=
X-Gm-Gg: AYBFou3184jKlAlCQnEKxNL13tfdPwNv8lqk2W6Y8H6l6BPe5MUHeLqvuUWkLJH4JkI
	/zyjiAmw4yjSADpYHWN0hjgLeV3XwLV+Us3Cx6LmOTSlUeBkHkLiGDTv0NBz8xEdxK90mMKHfo8
	Vonzo+sYfietDu8XN3NvyN0/KO8MVLuCbvO6Tjfsn/R5aurgAP3XRTuypJ8VgOgmZRxkmOmroA9
	BXESUn8bwO06+c9F4JI94500KR3QkOTp025ALeinzW6ShHX7nc1tNS6ycZWJ3JglzGXF30iRmnM
	kF/wpOMNm8ttQMUrBg3aPHRr3+l2Sg8aFC04NBGeWe+q388zKUWYzzHc4Ho886HlLN7hIUOI/H1
	GxMi0uWSuG1PM9zkkYhN83Y4/rwCIjS+bhMQg8OdtOHmxdiaY+Pv6zIVP7snAHgMFHAx0bbpsjl
	tJKw4av+1Xwj8frK7Ai6VQSMWxnLpjohH2M4zatXeavG3NRv658xcKxED7zOqSMNQpI5I+RWz8B
	ruRBQwED1+T9B+cQPQZOXDYzH4Iyxli2KKQ9WIAcwv4PJkpOagqoJtZS5fMnM8Y05aaJA8FuPAB
	b9IOX5JHLXq6mVSAyzGdjJPIaKDtBGbBnBax3xvEvnaIkTdRhfKEp5NuNWjkX0UsjjbWkhsAiVz
	DVGC9oR/Id1hEkD8=
X-Received: by 2002:a05:6214:2f93:b0:91e:b7fd:8ce7 with SMTP id 6a1803df08f44-91f2425d524mr70448086d6.28.1794640244861;
        Fri, 13 Nov 2026 23:10:44 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:44 -0800 (PST)
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
Subject: [PATCH 19/22] mm/migrate: restrict move_pages() destinations to common memory
Date: Sat, 14 Nov 2026 02:09:56 -0500
Message-ID: <20261114070959.3490008-20-gourry@gourry.net>
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

move_pages(2) places user memory on a node the caller picks. As with
memory policies, the destination should be general purpose memory.

Reject a destination outside N_MEMORY_COMMON with -ENODEV, exactly
the same as a node without memory is rejected today.

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 28a8d7734735b..fed910c9ba9ee 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2400,7 +2400,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		err = -ENODEV;
 		if (node < 0 || node >= MAX_NUMNODES)
 			goto out_flush;
-		if (!node_state(node, N_MEMORY))
+		if (!node_state(node, N_MEMORY_COMMON))
 			goto out_flush;
 
 		err = -EACCES;
-- 
2.53.1-Meta

