Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FC03FE640;
	Thu,  1 Oct 2026 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790884472; cv=none; b=YvilaeXbePQ/BAOuP1OC1pFMyRtZOrspa9+KSus26VHDQytKD6g86tPt7rtfaVS6f4nYdDCMDZjvOFI29Ok/8y33e4uoANmzYsEi+bPdiClxHgVIxoC4CJ6e3jwso989f29lah6l+9nkwOkpWvReTEi5jdvzkm5NtfsP9gILPWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790884472; c=relaxed/simple;
	bh=JYsLFYkjS6dJGw7qaZ/s+NGEWfI90Kyj+IKVnHzStHo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RsQgs7rXGJECqsAzpt770fdV64g+oGGHtcRryiIy6oqsm8NJqoShMT7JYVxyLvFJFLnEwrgygqHODeGAMrfJACIYsCu01+ZJz+/A/kThigQjV0+m3xQ8WA3fV5Ot6KSHdN2e54drS14RCJ9ULlyhluEugN/vaZKdddAIOVdtDS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rn4SXaRf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rn4SXaRf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8211F000FF;
	Thu,  1 Oct 2026 19:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790884469;
	bh=CsO3dVP1rE+OXCdeZb4O5Da9+5kdAsDL/2r4hLTyU8s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Rn4SXaRfH10u05A1D534ERpHxsGPtlfHGQ8PzRHITyxtpP/uikYQkO09ypRCLYgST
	 YfOfWe4sNz2CXWcjUG1pHw+CCoiohUzP3ZPApImQ62ccxVNqkhf26WGRzsJTY+1KM9
	 UD3FfzjSVnIIwRwwbbKX3U046OXTD7XmT1UO3tAZcIBIqW4+PCDsxdbKI5droVnIhY
	 1AqzOSjGqeR+xgHfR6j1Lou4x3pbCOUpGHtkVFhfimbOoty4/pphs3J0ljfEVfJMxm
	 /UJ5m47BhEh5Q08HqOsyQQLrUm/wL7iUyJluUoozQiSGreDcPwJKrv2X897dnEhd6U
	 XSX7SFGj/8DRw==
From: David Hildenbrand <david@kernel.org>
To: david@kernel.org, osalvador@suse.de, Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260930160432.5564-1-lance.yang@linux.dev>
References: <20260930160432.5564-1-lance.yang@linux.dev>
Subject: Re: [PATCH 1/1] mm/memory_hotplug: fix missing rollback in
 __add_pages()
Message-Id: <179088446708.3427.17462740264114406030.b4-ty@b4>
Date: Thu, 01 Oct 2026 21:54:27 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

On Thu, 01 Oct 2026 00:04:32 +0800, Lance Yang wrote:
> __add_pages() returns on a sparse_add_section() failure without removing
> the sections already added in the same request.
> 
> For memremap_pages(), the failed range is not counted in pgmap->nr_range,
> so memunmap_pages() skips it. The sections already added in that range
> retain their vmemmap mappings and subsection bits. Retrying a
> section-aligned range can then fail with -EEXIST.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: memhp-7.4.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/1] mm/memory_hotplug: fix missing rollback in __add_pages()
      https://git.kernel.org/mm/core/c/c31bb839

-- 
Cheers,

David

