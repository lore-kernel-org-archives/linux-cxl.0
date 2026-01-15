Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB2D3C1FCD
	for <linux-cxl@vger.kernel.org>; Thu, 15 Jan 2026 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498039; cv=none; b=cU8bHwPTLqViMjRQoZ9+UqpezLOvy0JZ/adxUXhsRJwKcmmuDxl5LVXftx2TPVkfsGyh19CAqwusiFF5831fqMVzfuBLVCTV9wpFz7t2UGDP2jDiaRU72jmy8xq4qTcWVDlps+4cpqyTH7d8m5iaOLNa8vNqo1VxBi5+3Llxa5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498039; c=relaxed/simple;
	bh=3UGXrZkeYXLx8IoVJrtniFV8BFbMiKk7p6uPdTyK/0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lo19aIWQneKj97EPXTWG/CrQU4flGeM+VPgnP1fIJs4UsAejhJWiHA2LJT+Wdjlfsgc3D0ysPsaM5Wq+vmkMjoex2UKPxGj1IwqoqPMJIxK7mTGhhu4Zm90lD5Ln8rpIhLASH+CDIWrpXIj3YmXMujWMOxuDMVmCOB6GKe0vBWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=YEhU+4Ug; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="YEhU+4Ug"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88a3bba9fd4so13055976d6.2
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jan 2026 09:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768498037; x=1769102837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9FK61OSEd0UmY2wqnN+WlOD2t6xQO8MJ1jOlEc9XBMg=;
        b=YEhU+4UglXlQQlfuFffLzOxZF1W221ljq75jkYmrgBTttcp18/A9wRTucjN8uHZtlg
         ECvh9hd6KBcOEx5heMRX5nNm9jvWUip0I/pctmUUaMroCrdAqRq5x6SccwevxqlziUcX
         +/H3LgzsFU/oXZERrYrlk9fp5ZgtSrDK7Q00NJ/t2elprpDeGFR6002oruyaRiElcG5d
         sUAF/nbeMvK1ehey4jpZKskRdfYrstJtw2//Isjg4oQ2OxNVZwAyWwQEvJPHttBKAazQ
         AW4x6bPH1/49pR8zfHAOhwzWWvy5zr4cmG3+34Ds4SsQxIP76DcO9Ic4xLpCdBW617IF
         5soQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768498037; x=1769102837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FK61OSEd0UmY2wqnN+WlOD2t6xQO8MJ1jOlEc9XBMg=;
        b=Y8hORjlqzz7GqKcE+NxjA35+4lN2t1dp/o5krJ0JfKb+32mGJIODdBE5JmOX1LLftY
         uktd2vSGd5+rMS+RSAsz+2vFQHFl09vvLFoRU71jFTaeiC5uMOtwFNC6hYpaqRsbcZCu
         Xjhyu+2yTgbYwnaOb2aS1K7ZgmR08O4nw9DL0a0apyYS/+Uwvvn+Qf/XmRtbBHNMBUWF
         K8nGcGdBSiDDXaKkvhAT3+LOoAc1F01i5qAC4lnHOTkNwFDWwSFnSoQGye/gExHRI9Id
         qKOc7i9TRZgnaGRl5TlFUWxc4B877lXDamYfN6IPE5/KLDuS9YEFZGFjnUr3gNZqC0uM
         Cgbg==
X-Forwarded-Encrypted: i=1; AJvYcCVZt9UqCM3MaDvekEaNqk/Ru6a0IIU+/eQNzkLiWY+KksRQp3iPv8TgF7fenNZ49ujAxlshbPPaF8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY+JJXmtfx1xsarw5o30VxB4qtkvbKWvLLjPaLr7rFyA52uvTq
	s9KAHy5LQo92Q+gYY1XOvqNKFshXlHRjWSgd8rTluE8GVn0dq8l61twFdrdRzSuVcfw=
X-Gm-Gg: AY/fxX7oZCtKi6fPvLiz1QBQJNkuyWj1MKpCkzNa7oviddzST4/YPD+5IjO/R5ySod7
	V8/aJ3XowFY3I8200aktjXlMRW+mZO5n/ZjebatYYmceJSzMAv68gziOtLBk9/V6Ndd69ORviqZ
	bOVwVDgQFwFyLTgqgWuIemKA6wSdJyzGx284Z6dMjGzKXbv+B+/XkTRwt3WerKcSa85DL/FnbMp
	Jgzwuk87D7merFKz6A4P28AhPAL6ZF0Rce8iZt4akXy9o1pqDZc3awa20oX0PD3OfbFartehc+O
	2gc3S+qpFic6wGRRU/9YunulzvkP0WUTgdXrR7xCHlG27nrH8M3QJpWt20KEC1F5yFwdDM7Xjh5
	NE6W5WWhNonCN6vUC3grySwYXMUd182u7E2R9pbqnizj4Oyacp+gLUAZXTi87JiOr3jUIwh3gqs
	BktRSimF87f3gCskXstI4K/MJimdiz46AODiM4EBWFWzRPy/2auh0gawXQrebxnhRVIMUNyA==
X-Received: by 2002:a05:6214:4007:b0:889:b6f1:1f30 with SMTP id 6a1803df08f44-8942dbf5199mr2798016d6.18.1768498036628;
        Thu, 15 Jan 2026 09:27:16 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077253305sm219364246d6.41.2026.01.15.09.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:27:14 -0800 (PST)
Date: Thu, 15 Jan 2026 12:26:41 -0500
From: Gregory Price <gourry@gourry.net>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, corbet@lwn.net, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, rientjes@google.com,
	shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev, osalvador@suse.de,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 7/8] mm/zswap: compressed ram direct integration
Message-ID: <aWkjUXpyLEJyc-C0@gourry-fedora-PF4VCD3F>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <20260108203755.1163107-8-gourry@gourry.net>
 <i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>
 <aWF1uDdP75gOCGLm@gourry-fedora-PF4VCD3F>
 <4ftthovin57fi4blr2mardw4elwfsiv6vrkhrjqjsfvvuuugjj@uivjc5uzj5ys>
 <aWWEvAaUmpA_0ERP@gourry-fedora-PF4VCD3F>
 <fkxcxh4eilncsbtwt7jmuiaxrfvuidlnbovesa6m7eoif5tmxc@r34c5zy4nr4y>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fkxcxh4eilncsbtwt7jmuiaxrfvuidlnbovesa6m7eoif5tmxc@r34c5zy4nr4y>

> > For the first go, yeah.  A cram.c would need special page table handling
> > bits that will take a while to get right.  We can make use of the
> > hardware differently in the meantime.
> 
> Makes sense.
> 
> I just want to point out that using compressed memory with zswap doesn't
> buy us much in terms of reclaim latency, so the main goal here is just
> saving memory on the top tier, not improving performance, right?
>

Yeah first goal is to just demonstrate such an accelerator can even work
as a top-tier memory saving mechanism.  But hard to say whether reclaim
latency will be affected appreciably - won't know until we get there :]

I'm totally prepared for this to be a science experiment that gets
thrown away.

> > 
> > I will probably need some help to get the accounting right if I'm being
> > honest.  I can't say I fully understanding the implications here, but
> > what you describe makes sense.
> > 
> 
> Yeah it's counter-intuitive. Zswap needs to charge less than PAGE_SIZE
> so that memcg tracking continues to make sense with reclaim (i.e. usage
> goes down), but if zswap consumed a full page from the system
> perspective, the math won't math.
> 
> Separate limits *could* be the answer, but it's harder to configure and
> existing configuration won't "just work" with compressed memory.
>

I think you are right. I am also inquiring whether individual page
compression data is retrievable.  If so, then this actually should be a
trivial integration.

If not then this is probably ending up on the cutting room floor and
going straight to a full cram.c implementation.

~Gregory
