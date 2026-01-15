Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E3F1EF09B;
	Thu, 15 Jan 2026 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501139; cv=none; b=Ykmk9jOl7va7Ru+eZWndSebJcD17gyje5zUNJWS5v+BsjGTH1eZG5rkKye1Ap2RRGX8CYBto6tTuO+IgTyxypKr4b8OYimn98NWDjCaPbPzCALmy4JsTOHDjGJARt8NNQeVj8c3Z6bJqoGSsKfygG6F3GEfy5KDlb9AdRx6pjxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501139; c=relaxed/simple;
	bh=OoxN+wiYLUXA84AAEzLFYI4Crg2HGDqLMAG7AyG/Wk0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p0dYQKRwDQ4+gbUgSfmfOH77iDNmBrHU5H3o6j791kgAeeHJGivaP6uRWr9wGT0lbTEjsb96BYgmbDlOWslH7SkeVHvJmLMtUfa0wR32qtHTZcEEXXMSeiFcNmTmydLJA+GoumIkmqz8oxMr7fTW6v74IEBGEIFSFVBwpertqqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=e814AiMP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e814AiMP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2EDC116D0;
	Thu, 15 Jan 2026 18:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768501139;
	bh=OoxN+wiYLUXA84AAEzLFYI4Crg2HGDqLMAG7AyG/Wk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e814AiMP04MGQQdvcF/eHiGR3mf/DMRLiaDPWrPEkG74cX3rRLhEga06ol//9OChC
	 vkULXBUpl0DbaS8P8n8lV4PmH+yaM1LyzgRYvkc1THr/VqmymRuJ47mo/jn4h8uQVB
	 1kwCMTpAMOChF+x4dKZrsq1Dv3Akpd17X8oldoso=
Date: Thu, 15 Jan 2026 10:18:58 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Cui Chao <cuichao1753@phytium.com.cn>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mike Rapoport
 <rppt@kernel.org>, Wang Yinfeng <wangyinfeng@phytium.com.cn>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID
 of CFMW
Message-Id: <20260115101858.85fd7b8e837c1c92a4fdc5f0@linux-foundation.org>
In-Reply-To: <9132054c-3017-4af0-84e0-e4359b0794a6@phytium.com.cn>
References: <20260106031042.1606729-1-cuichao1753@phytium.com.cn>
	<20260106031042.1606729-2-cuichao1753@phytium.com.cn>
	<20260108094812.8757ce3ad8370668eaafb29c@linux-foundation.org>
	<9132054c-3017-4af0-84e0-e4359b0794a6@phytium.com.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 17:43:02 +0800 Cui Chao <cuichao1753@phytium.com.cn> wrote:

> When a CXL RAM region is created in userspace, the memory capacity of 
> the newly created region is not added to the CFMW-dedicated NUMA node. 
> Instead, it is accumulated into an existing NUMA node (e.g., NUMA0 
> containing RAM). This makes it impossible to clearly distinguish between 
> the two types of memory, which may affect memory-tiering applications.
> 

OK, thanks, I added this to the changelog.  Please retain it when
sending v3.

What I'm actually looking for here are answers to the questions

  Should we backport this into -stable kernels and if so, why?
  And if not, why not?

So a very complete description of the runtime effects really helps
myself and others to decide which kernels to patch.  And it helps
people to understand *why* we made that decision.

And sorry, but "may affect memory-tiering applications" isn't very
complete!

So please, tell us how much our users are hurting from this and please
make a recommendation on the backporting decision.
