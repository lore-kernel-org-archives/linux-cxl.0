Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6FC3E2759
	for <linux-cxl@vger.kernel.org>; Tue,  5 May 2026 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967161; cv=none; b=eJNbAWWEnJ5ScLs3fAD/F6GZ3+L334C3/w7qIS13maysRVjnD065UfDoX+/Hw9mU8LNhDimSInOq4OhU2+yeTJ5QTNHFlc9IWagGHN8XC91HrJDFk7HXuGREAajmbOnOPi1uD0qWZPplni45le8oyGE1yrhFY7PM5R2qTwYTosY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967161; c=relaxed/simple;
	bh=nHnlIoIYgby//JTQJ23HCL1ahPlq53pZkc5FnZs96GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1MW33Rb7HhD22V8jUFYDQbzVV+amayfTSuox0xLHkDlxP/MHs3ISQ0076UpZ3vS3PBHlEAuNNKMw/K7z8Vz+/L+uBtE+vxoutD9IvxZz3v4FPFl5rH9rziylobzZG+L5zS5RWYoAUqMd2HPmae5MDvQdmKAU7t0WUvgK4jXaKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=RCxXV9LX; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="RCxXV9LX"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so2729575f8f.0
        for <linux-cxl@vger.kernel.org>; Tue, 05 May 2026 00:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1777967152; x=1778571952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pZn9gNDq1rFBKVWAUdRINblw7hBlw9EDaJdQ6N5Sg9E=;
        b=RCxXV9LXriGz7JRe2657MNsE9158pU5CsAEXPaH9YbbRZ/cfEQ97T8nzjxqQjQr5Tn
         cDofYN/4NWz7D6fQ0XyKzFFVvPjtjBQlZHA3QbOgUBs8QtP4K+9gf8/fsKCBnqxH/TK1
         X4iWCPRpvJFKG+JvKL9st/yXEg+fRWRqnYMnJfGqCpTSaO/ibNLdZvUcr1bkSbuQZ/RT
         XYonchiGOgElt7+ZCAfg5bUasPzSmjsXzu+ZyL8JwvG44CpBF5GENiDxbTsee6+s0d9g
         jADSjFrbF2OEvx3nBUEynYfZo0W1FQcf3mu4y0whLlt21Yk+xCcDIIosGizPIqBT7eUF
         77FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967152; x=1778571952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZn9gNDq1rFBKVWAUdRINblw7hBlw9EDaJdQ6N5Sg9E=;
        b=X9E6R2WznoeM4YjjTCBVet+Is6+uXNqXpavmM7ntJuBiS7YWRjlzcFh9lx85SFPu48
         oMKNu4cvSrLXdWgXT0BZ9Nregi4o2VVgjr4tg/lF7GgPm0AwTyoco7aQtHkVclx1hARz
         6AMUjJ+I/EPNL28fsz+d4YuyctfUcqwbh0iZnjVgQ1TguOjhBBYFuCqNi2vUf6WyTVJW
         OER0FDzWtQPqV3PM/KeMVtMKUJMo+1ltCdkLYSXK3ywZiLMmygfHwi+QIaG9fLcdI95U
         6ie2oNbRbbfPBjip8tMT1wT43gPFW0b7+41lr1oPNSw48hLO2C9nBVFNU2W3kJLeL6BO
         BuOA==
X-Forwarded-Encrypted: i=1; AFNElJ8QbXmfnWD+CRGQ5WoxRZuOaOXMtXlOQIL5hUSDBxNOOuFmYqzf1V8iqaXLc3W7Y4p3heyzxx+Gabc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBVkUl2q6fpyO1HHNGjPLqO8Ky7yCpTscOKsaZGSHfTwnleIi4
	zCwbl4xCTzdu7SpcdrjizYz/4PKGdIawSbl3eE8gtUWlD4eH1AC06CFyf7oN0KkxXrw=
X-Gm-Gg: AeBDieuG2DFamuu2yjCpdqfR+QeoTRIEYCKT2NaZduJ7EfWBpFXN+3kd+80sToVw4t8
	+915CUp4N4lRkTy3Pd3nGbVE5OGqwK3ttWZJULEJQ6z21cyFZZzVzcbMPTiFR/H7cOhJwrwvGBC
	0FhqE8/r3M2ARg1+mAITV3BJZVX4VmC1lpHN84yPRY4VaK9NI63ovHETFujiMEnofjQAd19tEBW
	WA5Ylr0VITKMhgyFbGn66Sf80guKtpnr+H60tvu0mT1epDksXrDpAVuuwDXrLAtAZgwHEE8cmk3
	c+XJme9MQPINAf6WbeMPvAKDrd9lHPgCNMdXQ3KnnbBShLWSJN8tvHOsDwJJ80c3c5Q5vO+SRIx
	EQVIuIEmmzEmX36MKnMDEDn+Jb4DZ9IxkU7Ok0BdxsUJxJkSus9j8zl/WBd3K8BT0ED7RJTPpZ0
	HCJKI7mGR5ijQKnzYlbY1wEdVH5/DoXbAo0a8xc/+85KlB
X-Received: by 2002:a5d:5d87:0:b0:44a:2f78:e873 with SMTP id ffacd0b85a97d-450041b08d5mr3594275f8f.17.1777967152279;
        Tue, 05 May 2026 00:45:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055d36dacsm2455028f8f.32.2026.05.05.00.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:45:51 -0700 (PDT)
Date: Tue, 5 May 2026 08:45:41 +0100
From: Gregory Price <gourry@gourry.net>
To: Arun George/Arun George <arun.george@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com,
	gost.dev@samsung.com, arungeorge05@gmail.com, cpgs@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <afmgJcFUjQLYxkb5@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <CGME20260427123800epcas5p1e1a2fed257091b31e2e6c3a7d1b0c2b0@epcas5p1.samsung.com>
 <1983025922.01777297382206.JavaMail.epsvc@epcpadp2new>
 <ae_i9IlIndumJWN3@gourry-fedora-PF4VCD3F>
 <1891546521.01777455002601.JavaMail.epsvc@epcpadp1new>
 <afIKxG5mJZE6QgpR@gourry-fedora-PF4VCD3F>
 <1891546521.01777901881625.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1891546521.01777901881625.JavaMail.epsvc@epcpadp2new>

On Mon, May 04, 2026 at 06:38:54PM +0530, Arun George/Arun George wrote:
> On 29-04-2026 07:12 pm, Gregory Price wrote:
> 
> But I see this 'write budget' (budget in terms of number of write 
> operations that can be handled by the device, not capacity) to be 
> provided by the device in control plane; not by the workloads in the host.
> 

In the scenario i'm talking about, a "write budget" is defined as a
number of pages that are allows to be mapped writable in the page
tables at any given time.

>   1) We can modulate the write budget depending on the actual 
> compressibility in the device (and so workloads data). We don't have to 
> do estimation based on the workloads.
>

Barring the device causing backpressure to increase latency and slow
down writes, modulating a write budget doesn't actually do anything
useful.   Once a page is mapped writable - the CPU is free to write to
that page uncontended.

I think a write budget is "doable" but maybe a bit optimistic for an
MVP.  There are many corner cases to handle, and I would prefer to see
that as an experimental optimization.

>   2) We don't have to do the capacity modulation - as in ballooning or 
> shrinker.
>

You still need capacity modulation in some way to respond to drops in
compression ratio.

~Gregory
