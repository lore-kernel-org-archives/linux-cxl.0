Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015260;
	b=EpzledEIJdDA9Or9HyhJVh+VqgYzvS+eGFNbbZPEpDlR7e0SYSwWGwIx/J9QyaAtQBaD
	 rgkEIw6hDrbPm+vtOudsvJM/rN+C+MJobg1HeW627pv0WTKdE7Y9Uk0KHnghJCn0z0B+1
	 D9ZP06+FT1gvY8+URvdqCRIZYMzSg7tt/joI1ZJI15utfFR1sPhwlBsfihjDFEAxIAxr/
	 +KFwdSld1FXR+8+K22hq+rT5phAqs1ftfJbvjbxQ6uKmnD0jVF/t4AF7im7JA8FUQJoqx
	 F00Yz3RXVqAmk0MJtBKSwRe5hZF5gyrYEERerkpSAGSDUqfmVXTbNn5zHYuUy8h/KJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015260;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=2f1/3qPELFtVfaXBFluo86ffYBKVD1HppO+tx/i4yJA=;
	b=GYieT0uciuuRKuzArTBeuG5dQ/dRIonO32G1f9iUvozWbC7TJqgpcLD756Vv2vv9ZliB
	 ZN9T//H7gljuOcEmA7CqVFsfUOymCQn+B9LB1TpKaoiNh8sBoEX9UTBT8mHrw+66fMH1P
	 o/qmsMxsbfYKfa8bLHQMv3/xmV3HEWrr7UFi/Z68CfrSNWBfSu9XTTRANPo9+hHTaRD2x
	 BGUNY1qbuOxIvAJTqLTX65HnG6D6F+O/B29fiOcXEJtR+fsVL1Im2qWFwLfkmKef8cZUG
	 1ULQWk0HukHvniLJWTVvb6ayYskWYIx5Jh/O4SrVub/ICyCrtH0VYtCWHRn+l77VMvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=RcYjlh9r;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D412960A2603
	for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 15:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D412960A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=RcYjlh9r
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5495d549924so12040561cf.1
        for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 07:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795015259; x=1795620059; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2f1/3qPELFtVfaXBFluo86ffYBKVD1HppO+tx/i4yJA=;
        b=RcYjlh9r4IRGrafd+j2HLcUekeO369jG4cJ8dDVzoBY8gvpxzJeyqK3ozNZlwuaNe+
         dX9eTN+iN1SLvDXv6ZqfqHOE77V1vdoVQpS9x5MRrqE0S7mvRfL6sw/ErTChduS84etH
         nS7jQ1GGdAXlIAaPdld5HxgPrnOoIx1uTeL6PFILkkDVhQvjQ1L/cdSpt//oQ3Sg56BU
         7DACo0lblGCgiebYjG3dsltULlbJRKP6YYtH3AIXL4Ytr8g/kCuFnCukKTYSpuqs6WLs
         H7LrxeAzRj7uQcJe5AdxVin1iIq0eKGTVLMXmX4R0D0sv+hVEZxbt0IeTxFEciavpACF
         rBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795015259; x=1795620059;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2f1/3qPELFtVfaXBFluo86ffYBKVD1HppO+tx/i4yJA=;
        b=zEYSfqGHkkYwowKKZfygzO/157cv9DWS0/9vmidkHG5jLY1XxmKOX6Wm3sjTfbaw73
         jv+UUIpIDQSmMrEjCkZPEQ5BpduHQ69A8yqlRfv1jBMjCLq9DO+2ImIyJ35OLEtlIey6
         mjZbwTDheMOGMlHE2Xv/5ATDakMRm9bpdQn1mR1P1ksESIj2md8Wti9b0VYeRhcJVUo4
         uMf5JUrr/rprCtFOFogvwhQ9DU9V/z/H57RSbYfHMp88R3IAFfM4PVFlI6pFXpJpM830
         9mi37gRelXZLfKNTKK8rFM0Mm7tOoNPqV4X17fVcA92vrUKIVDq6741IUrnO7OkHPNxT
         teSg==
X-Forwarded-Encrypted: i=1; AL+hErEggA5CYW6xcNniHQayuy+L/fp0tDXjQULGDmGzWE/7vqSyqeGHeDVJmwCtYC1bsT7p7lwpMU4vh6I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8obUfHpNYf6coCdryWP3TEtlpmiGl7bLDv2m5G5jYr/jmbqq3f
	+ESU4fgVdRS/no6xhVtNzfBwwqEwdFke1ZhdQF652scu82TLekzL193Pq5iXK+tLOyM=
X-Gm-Gg: AYBFou1SwS26Z8zQh0YyGFotigi0PUB4UOwDq9tNdYWCTzYFVp4Ks8WNCsmjQuCGZPa
	PL7bYs07wYBliD6pBh5AVzOejY2nABGs9IYkdjvv57oUA9An43VPCGURUqcZ+n/CNBEDhks1jHj
	91J9CoU37Uw82JV1sRTVQJidxkUoIjqKyexBctCkLF0AsOMGfvSX9dEqksXKyLHhAvVuzqNBXTY
	eEeIdP2Q2l/txheMd/ODN3PzUepHUmItvHxXXN8DHdYzmaBoZ7W+0q6BD3uBFbwsACMFxQKCVIm
	SaA3oWTyByMJjf8prNGW3tE9lV7f8QnAAjRnz7KESlV2oV6HJ1l4jkiq57Dn9k5b2i9mjYeGKXE
	4hQRZFz/eOr6MJD7lHVOrnfijNl3w+Pomv0dIEbNeCE8aY5DV8we/gmgCE20XYBqC0cjm/VqgC7
	7I0KqqURwJbL/4GcM3oVIQeFeYl64tKmKI7b8sdmr44KGid7qZc+APlY/UD0mZMx0hE8m7fIPEP
	gnKSLkVpi9cUARE3EOhUCwk23bQlLExruvcI4qaKlnkWi1MgFd9XEoZ+SHIwvZJ08c4SOTbN2+v
	uDfgPyoD0AdCBKqUHYOS2sYbWb/O5SHJ31/dZkP/hq1Vb6Wku84PaglsOn44y61KFlipM0rtJhV
	rmKIHtZ4=
X-Received: by 2002:a05:622a:a0a:b0:55c:66f0:5bf0 with SMTP id d75a77b69052e-55d5a656766mr42047121cf.39.1795015258621;
        Wed, 18 Nov 2026 07:20:58 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921167f4725sm19632976d6.44.2026.11.18.07.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:20:58 -0800 (PST)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 02/22] mm: publish and clear node memory states via
 helpers
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 linux-doc@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-serial@vger.kernel.org, linux-pm@vger.kernel.org, 
 damon@lists.linux.dev, linux-cxl@vger.kernel.org, akpm@linux-foundation.org, 
 david@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
 surenb@google.com, mhocko@suse.com, corbet@lwn.net, 
 skhan@linuxfoundation.org, rdunlap@infradead.org, 
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
 johan@kernel.org, jirislaby@kernel.org, kasong@tencent.com, 
 qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
 baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, yury.norov@gmail.com, 
 linux@rasmusvillemoes.dk, pavel@kernel.org, lenb@kernel.org, 
 hannes@cmpxchg.org, brendan.jackman@linux.dev, ziy@nvidia.com, 
 sj@kernel.org, muchun.song@linux.dev, osalvador@suse.de, 
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
 lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, 
 xu.xin@linux.dev, chengming.zhou@linux.dev, joshua.hahnjy@gmail.com, 
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, matthew.brost@intel.com, 
 byungchul@sk.com, apopple@nvidia.com, rientjes@google.com
In-Reply-To: <av1ZBTpLpJC6DJqA@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-3-gourry@gourry.net> <av1ZBTpLpJC6DJqA@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:20:56 -0500
Message-Id: <179501525661.1206716.17622543796948053737.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 15:53 +0800, Richard Cheng wrote:
> >  	/*
> > -	 * Check whether we are adding normal memory to the node for the first
> > -	 * time.
> > +	 * Publish this node's memory states, including any newly-normal zone.
> > +	 * Hotplug never adds highmem.
> >  	 */
> > -	if (!node_state(nid, N_NORMAL_MEMORY) && zone_idx(zone) <= ZONE_NORMAL)
> > -		node_set_state(nid, N_NORMAL_MEMORY);
> > +	node_set_memory_state(nid, false, zone_idx(zone) <= ZONE_NORMAL);
> > 
> 
> Um, so I am not sure how much cache pressure this will add, I assume it's small ?
> 
> Just want to point out that the old code only wrote these bits for a node's first
> memory. THis now does up to 3 set_bit() calls on node_states[] for every onlined block.
> The result is the same, but node_states[] is __read_mostly. A test-before-set in the helper
> would keep the old behavior, or if you would like to keep it, please address in commit message.
>

Hotplug isn't on a particular hot path, but I can test N_MEMORY before
setting any new state and just early-out.  That would keep the behavior.

-- 
~Gregory

