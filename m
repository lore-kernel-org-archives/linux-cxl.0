Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C07935DA7F;
	Wed, 18 Mar 2026 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820725; cv=none; b=EjKWBziDVvc/JMKLSv8GoGEvbaEGXWOMyV6Wco3C4RHWixxsnn+QA40zzLnoS/hJd8WWxoAT6QRA34QGdvpc7nHjXL0fEeIAv1l3QNg76IOqRg5Zb8k/ZnXFhAsEM9aYdrSDc/QTIYGYD9tCw1qLSFCFWM8HGnwFFeJXRFR+p6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820725; c=relaxed/simple;
	bh=TSz9o5tvOTZ2cq3b3ru2k7TcaEErBWRbUWWJKKC2YWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbXkhNgViDk1fE1m84DVNjrWK30GbHuWRO58MULk/gf7Dr3qqZNQc7Ywzn4FUjoUwYS+WcF9/ptzxdB72+6bJzRY9qITm/sojfH8KxkQeykRXn8s6vbOoVn0we/tTIQiWHR9UPbY+v2SNHlT2f5Hi8r4Muh6AaE7OiH0IVXtJx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4UgzqYJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4UgzqYJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5681C19421;
	Wed, 18 Mar 2026 07:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773820725;
	bh=TSz9o5tvOTZ2cq3b3ru2k7TcaEErBWRbUWWJKKC2YWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g4UgzqYJCE+HF+LMkXzFA+nazQ678pnyMe9kot/PdZix3yF54zqQdRYZYbdnCHxHP
	 iC54hPjuOjwVn8q5/7EPGqd49/GeYZJB3GaKW9KFjaK1sCYLesYMhla+cRMOUUMZqt
	 9LxzG7uG/i67y9x6zfzs8TCWu+g2YfxD3A79sTQGlO54yGSDa7YwwiL5udcvdggDLq
	 wFZRJlGmlKZNArvHlQoxb5dX/AY6JES+5QN3y/Wns35IV9uGc3oI+1wkqdnuWVowkl
	 E3Fsi8iaEWNVeIk1SloYX05eWi0cM5B4Oe4lPytbtcZzhD0/Vtn9EZDdQjWv71jR8B
	 NcBWkAG56+P0g==
Date: Wed, 18 Mar 2026 09:58:37 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 05/14] mm/sparse: remove !CONFIG_SPARSEMEM_VMEMMAP
 leftovers for CONFIG_MEMORY_HOTPLUG
Message-ID: <abpbLRegIPqAuvJU@kernel.org>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-6-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-6-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:43PM +0100, David Hildenbrand (Arm) wrote:
> CONFIG_MEMORY_HOTPLUG now depends on CONFIG_SPARSEMEM_SPARSEMEM. So

                                      ^ typo: CONFIG_SPARSEMEM_VMEMMAP

> let's remove the !CONFIG_SPARSEMEM_VMEMMAP leftovers.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/sparse.c | 61 -----------------------------------------------------
>  1 file changed, 61 deletions(-)

Nice :)

-- 
Sincerely yours,
Mike.
