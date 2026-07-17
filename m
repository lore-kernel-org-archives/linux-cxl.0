Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B082D3C4577;
	Fri, 17 Jul 2026 06:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270816; cv=none; b=BisurkWdP2igJf0qM/RnGiokYK9AbVoPOKmue5GDv7UZ9ejnzYOJgB+8UVp9vv1Dkk/Gwwf+3vWCRAdo8K4F7ahyDr73OCNMUAa3LNPHZ+8Tawkhxn6S6KDoQN3eJ7kus8HOooNejncWhSwIiA32XXGPbMFP057qH4h+R4j/RGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270816; c=relaxed/simple;
	bh=YCvfqyyQpofXhnfj+3OQoK2LnKGLsuSK+bQvg5w0PDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzwZC/NiMfED9dBv7iNk1RRF2VX8G761EvNNHdebSp4aWbadsSbsBPo99KrBYgbJkHSDu3v/SIQBoxeO4i+qbg805vAZC+72WiwEBPoKW9hfClb1w3kIZhZE+5wOEEFhyAJ2EhyPPoGGw1uJt9eAqBUTnXtx0KHtr3ihriY+Qmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBafwYvE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBafwYvE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4AA1F000E9;
	Fri, 17 Jul 2026 06:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784270806;
	bh=JKXbEP5sSqxrG6do/l3oqh6oY1qmcTSdJKyv4PfqhKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BBafwYvEfSE6hpwsOqF2/uaWrqE+TQsBipAX8MMY3Sxwh4bSvGC3p4Eu8kg4ZvNCE
	 lKJFaFU06pnCW3itM/r9962FcWJwYEbfhK1Yvg6e7tkc6b6o68VMUrw3s35hBNSA+W
	 45UhoMH21d5wNPwebHBLMel3uHZ7WSmgBxquf3nlKK8NSbnIIHF7Dju5RDgExyemws
	 3D0AALeeX6qoxwQv1xWSmkf6Tx+xkjLB8hFcih7BkCG5wF8xmIV4//8CKTi7Zdcqcl
	 mxtYENbDaBMFbPdVLnwDw93Xc7NLAu8DapgwQ5e7afjD8//sKH3mp7+6C0it7XLCOF
	 lWxLc5t/rimCw==
Date: Fri, 17 Jul 2026 09:46:39 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Hongfu Li <hongfu.li@linux.dev>
Cc: david@kernel.org, osalvador@suse.de, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hongfu Li <lihongfu@kylinos.cn>
Subject: Re: [PATCH] mm: add missing alloc_percpu() NULL check in hotplug init
Message-ID: <alnPz-r76FU6t5Uc@kernel.org>
References: <20260717052938.58447-1-hongfu.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717052938.58447-1-hongfu.li@linux.dev>

On Fri, Jul 17, 2026 at 01:29:38PM +0800, Hongfu Li wrote:
> From: Hongfu Li <lihongfu@kylinos.cn>
> 
> No NULL check is done for alloc_percpu() when initializing per-CPU
> nodestats. Allocation failure leads to NULL pointer dereference
> during later memset.
> 
> Make function return int, check alloc_percpu() result and return
> -ENOMEM on error. The caller chain already propagates this error
> correctly.

I already applied a fix from Gregory:

https://patch.msgid.link/20260701221613.2818148-1-gourry@gourry.net

It'll be unstreamed soon.
 
> Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
> ---
>  include/linux/memory_hotplug.h |  2 +-
>  mm/memory_hotplug.c            |  3 ++-
>  mm/mm_init.c                   | 14 +++++++++++---
>  3 files changed, 14 insertions(+), 5 deletions(-)

-- 
Sincerely yours,
Mike.
