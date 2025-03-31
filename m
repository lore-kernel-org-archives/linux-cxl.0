Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8281DF748
	for <linux-cxl@vger.kernel.org>; Mon, 31 Mar 2025 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743439994; cv=none; b=Qv3eE2NcpcQtF50FSm4HC6BuV8WadTeZ/St7R+yXQJlgOVjs61FmfYLslk6j9Aq91yCltom7gsulXPYHChdDYDx9g0JM4iMCVStuU/z8y20G2JdLsCxWAITIDyGh0i510H4Fle4OumC2sNHFLLJvqPungevDtJNkHzNQV29jxso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743439994; c=relaxed/simple;
	bh=dGxdrcfn2W7G9AYcMDBtp/foFYPOpu6GpogE5T91uPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/GfY9MDpWLYsAR8MH35B5fTcYkWZL7vcxgVd4Yy54tqdWuncMRPzPUyTM6wCwEiXclJVJZUKaGBzW81JTQz4gubNuCjhQaUaN44j1cr0/53kRYK+/Xkvz8YcoX1mezb0TfOA8koJ3IiVid7kSO8xjNsQXLjj2A2Ioa2ORB7O24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=TBb/Dbyg; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="TBb/Dbyg"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6ecfbf8fa76so53555706d6.0
        for <linux-cxl@vger.kernel.org>; Mon, 31 Mar 2025 09:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1743439991; x=1744044791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AiUKTo61WkrGilNB9SYxNkhCryPehlR+RK/PdoXLPcM=;
        b=TBb/Dbygck0KuU34BkdZ22+mvgrE+EZyDSfQDIlriw0+Xu7da4afwOEh5csp5hlGKI
         8zaPh/Pv11DchGesfJrgQWPd+nu+eU3WIacinKSv7jMz4JhlG8D0LVjOgpHUH0GEjxoj
         vUOT24zVPG4XR2e+hK7AmrwDYSSzcTeM/AVne66uXIVGNykeecq0JcdcG0uBAPuko/rl
         XdWJqYOdUaWuyy+XZf2b5YMIC+DXRIgfQGzuEjyYbByxCoeqxzQiNGjM9TvU7YNfhuB7
         gQgLISjdwcayO+2iTrmYUgKLkQpmOTmEaA7VjktfYKiZhrIY+lVC19qhtr7D5Be0K8R/
         YK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743439991; x=1744044791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiUKTo61WkrGilNB9SYxNkhCryPehlR+RK/PdoXLPcM=;
        b=mmhUpxDNTe3WejKyPwYhcPekdflWTugpg+FLO+K2kdTYxNBBk5XS2P/Wzs7xMHa9gi
         x5H9tXKU6s2a8U20jmXua+om7ETMtAd6rHMugh50TGazYciObkQ/nX7lalhAppXOFaqu
         VpkIuvIPB76O6I5MKPUGklQpt8DLQNaQob/bRpL5aw2WNHpDjoXmtG8ttSNTW9wxTJLr
         OFcFjCbqscC4i7IPiXIt0pAzRORKfS0PPLxSULef7gPzkVSbPiiFdNPi06kFiSYQFGMO
         8gSW6HIkDNJGn7qjf8fNrXgJLIvHpJtReaDUXxU37pgwigQBJ6zp1O2/2L0h31B+oREJ
         Npkg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/ylxBI/nIlguDaAPo8tLLa1sfpQZpJfAelkQBKaZHQQ90qg4nVRhFc8Bg9aHOXNGNGYT80dGPY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWhzNtq03tGfkem+2H3Eu71jGton23XZGSOXZObPvD3BmRko+O
	EYDhflQe83y7LsTSlHfr0YfB3yM/ARSUQOpL4WjNxVm1M6Pn0CrAkrBYoCp6cUI=
X-Gm-Gg: ASbGncuwfa6S+KdG4Gwjkdqe/H3rj4FCDNPIElAmWn4XySwPp/k5yzvwFiVAk4FuLLs
	RHKu0K6BwzF9EyblQ5GJIUj9vIJU8jK7QPzK/2MstPyi7S6EOrsGiDbQ2VHu2eIrMuReBe3wR7X
	+y0hL3FpJEFCQdWsvMBS01i7JEP7sQf1G5siOKmbkrjQKrF9O4AOXbu4OlUv24fy/jRn9ADqnun
	NLlshAnp4Ugjnm0v102AvAFnZZT3UXtOVAnRRUpYoMv8FRjufoHwlng9LcL5tM2DkcBGJVtUBI1
	2ItrS/mph4n/OrvmKFu+3DtPZUOtcenhyYV9Uf98N3k=
X-Google-Smtp-Source: AGHT+IFd+qsosdQQtA0DsjOuFOjNzDgnTDzOhpn2WIRyqS+ggjdGBL/fAbxW/5YG2w4V0Rf+gmk9vg==
X-Received: by 2002:a05:6214:1d2e:b0:6d8:846b:cd8d with SMTP id 6a1803df08f44-6eed627129bmr126446056d6.30.1743439991034;
        Mon, 31 Mar 2025 09:53:11 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eec9797218sm48420876d6.110.2025.03.31.09.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 09:53:10 -0700 (PDT)
Date: Mon, 31 Mar 2025 12:53:06 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, chengming.zhou@linux.dev, sj@kernel.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	gourry@gourry.net, willy@infradead.org,
	ying.huang@linux.alibaba.com, jonathan.cameron@huawei.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	minchan@kernel.org, senozhatsky@chromium.org
Subject: Re: [RFC PATCH 0/2] zswap: fix placement inversion in memory tiering
 systems
Message-ID: <20250331165306.GC2110528@cmpxchg.org>
References: <20250329110230.2459730-1-nphamcs@gmail.com>
 <2759fa95d0071f3c5e33a9c6369f0d0bcecd76b7@linux.dev>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2759fa95d0071f3c5e33a9c6369f0d0bcecd76b7@linux.dev>

On Sat, Mar 29, 2025 at 07:53:23PM +0000, Yosry Ahmed wrote:
> March 29, 2025 at 1:02 PM, "Nhat Pham" <nphamcs@gmail.com> wrote:
> 
> > Currently, systems with CXL-based memory tiering can encounter the
> > following inversion with zswap: the coldest pages demoted to the CXL
> > tier can return to the high tier when they are zswapped out,
> > creating memory pressure on the high tier.
> > This happens because zsmalloc, zswap's backend memory allocator, does
> > not enforce any memory policy. If the task reclaiming memory follows
> > the local-first policy for example, the memory requested for zswap can
> > be served by the upper tier, leading to the aformentioned inversion.
> > This RFC fixes this inversion by adding a new memory allocation mode
> > for zswap (exposed through a zswap sysfs knob), intended for
> > hosts with CXL, where the memory for the compressed object is requested
> > preferentially from the same node that the original page resides on.
> 
> I didn't look too closely, but why not just prefer the same node by
> default? Why is a knob needed?

+1 It should really be the default.

Even on regular NUMA setups this behavior makes more sense. Consider a
direct reclaimer scanning nodes in order of allocation preference. If
it ventures into remote nodes, the memory it compresses there should
stay there. Trying to shift those contents over to the reclaiming
thread's preferred node further *increases* its local pressure, and
provoking more spills. The remote node is also the most likely to
refault this data again. This is just bad for everybody.

> Or maybe if there's a way to tell the "tier" of the node we can
> prefer to allocate from the same "tier"?

Presumably, other nodes in the same tier would come first in the
fallback zonelist of that node, so page_to_nid() should just work.

I wouldn't complicate this until somebody has real systems where it
does the wrong thing.

My vote is to stick with page_to_nid(), but do it unconditionally.

