Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D8F2C21D0;
	Mon, 30 Mar 2026 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907202; cv=none; b=IUnfdNVym+XfbQiD41YrxB7ut/+ctn6bGnr/JChEsumP1GD3YKwWuMuOhl1H0rfU7Pq2Bl27+LzIqehv9FGRc2JtreGQ9Wi8aCRYQZgvG8Mm/9i5MDj1IPRxNUkFtTWB5w/wUwPpQOwDE9Lt7ErfSqke2ZUXJZbrhVuu7MdDx1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907202; c=relaxed/simple;
	bh=p0Ky5bZRAoBg1rNqNR7UMmanDEON+/dh3M7UQ6lJ7YM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AldEy7G4OV8atvu6U+a23sAT9QWYwNG3+1usjB/4QgeZNCnXEGNH1hkgcunrNcL2E3seGKdrc8yzcVz5Fn2sSRAc4pXoSo2KstQVI36UZ2OOe2++bNOmBLDW8Kyi+G6l1GLPCbTq16hD7ahSXvOIfbiUWZ4674roeRwfIzolMZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kuGpwU1l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kuGpwU1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEF4C4CEF7;
	Mon, 30 Mar 2026 21:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774907201;
	bh=p0Ky5bZRAoBg1rNqNR7UMmanDEON+/dh3M7UQ6lJ7YM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kuGpwU1lV3znQxQPn/hdTO0gUyfcsyLhmSKR+/kzzTKoUGn5AW51PjO513mXxYT/K
	 9lK9RDyMmonCpXhvg1RCFHAqpqn4UZ5TzwuQkwt0sxiWulN1rtenubUjzIgUMfrFu7
	 2uaX+DY3wS8tANv4nx/nj2bqComwmPJIuCiMP7WU=
Date: Mon, 30 Mar 2026 14:46:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hao Li <hao.li@linux.dev>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, david@kernel.org,
 osalvador@suse.de, vbabka@suse.cz, joshua.hahnjy@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory_hotplug: maintain N_NORMAL_MEMORY during
 hotplug
Message-Id: <20260330144640.161ca53e94b37b3252de2e95@linux-foundation.org>
In-Reply-To: <23feu42lqvc7iymgaxmnywea7c3qie5vmjm4aijbgdiazwvrcb@mmlxjowgtotv>
References: <20260330035941.518186-1-hao.li@linux.dev>
	<aco0MtqpysMXMZdy@hyeyoo>
	<23feu42lqvc7iymgaxmnywea7c3qie5vmjm4aijbgdiazwvrcb@mmlxjowgtotv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 17:34:21 +0800 Hao Li <hao.li@linux.dev> wrote:

> > > Current users that benefit include list_lru, zswap, nfsd filecache,
> > > hugetlb_cgroup, and has_normal_memory sysfs reporting.
> > > 
> > > Fixes: 8d2882a8edb8 ("mm,memory_hotplug: remove status_change_nid_normal and update documentation")
> > 
> > The Fixes: tag indeed looks correct to me.
> > 
> > By the way, MM needs an explicit Cc: stable@vger.kernel.org for backporting.
> > 
> > Since this commit was introduced in v6.17 and we have v6.18 as LTS,
> > this should to be backported to v6.18.
> 
> I had gone back and forth on whether to add the Cc tag, but I'm happy to
> include it now!

That's OK, I'm very cc:stable-vigilant. Thanks,  I'll get this upstreamed during
this -rc cycle.

I do like our cc:stable patches to include a clear description of the
userspace-visible impacts of the bug.  Two reasons:

- To explain to -stable maintainers why we're requesting the
  backport.  If they care.  Heck, and to explain to me why I'm doing
  this!

- To help out someone who is using an older kernel (there are many)
  who is dealing with a bug report.  They're looking at this changelog
  thinking "hm, I wonder if this patch will fix that bug".  Let's add a
  few words in there to help out with their pattern matching.

So, and not for the first time ;), what are the userspace-visible
runtime effects of this bug?

