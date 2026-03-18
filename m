Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB90A39526C;
	Wed, 18 Mar 2026 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824072; cv=none; b=BuLxxTrXtf8jq66RTip4D0lYvp/mjUI8kt6wKKU8Flm4eg+V8DU4mLPVXx5yOQNl6Xol1jeqxdAI6IgyuBEoiRjmN3lVXueOqbGbPeS2bQtqRUKVMdK9wFXOxz6ve1lPtwUgcRAzpYNnl0IRrljdTAx3r3D9JBEkUzdDD6p3a5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824072; c=relaxed/simple;
	bh=JSANhBrI2HAH9lxhnIO6pJDDCpJuA14LafX1GypTuSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/A9KVOnv6T7JLNRwry+aNRlvl+9MewSpe9/vOmzXI85kVm8oqE7tc9uCsygF/asnkXBYKhz/dqv3Q6EDmQHHcNVrkpjCPgeTznbsfa1zwe3+oIdBuNTRD3WN0++RXPVARnMJtdb01QOvPJN5Gsb2wi3LcYHz79aBmRMZ9MXFm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ixm5qREE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ixm5qREE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB52C19424;
	Wed, 18 Mar 2026 08:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773824072;
	bh=JSANhBrI2HAH9lxhnIO6pJDDCpJuA14LafX1GypTuSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ixm5qREEy738mLJYRkrJGQTu7eQjZTx+BVITP+UR8VfgktM9BHCR8h58zh2pF8fYY
	 AftnKJHHDPC4nT6b4pUKaPpPMKA4DyPZi8lFvQvcjXoEj4pY55YbxwsPRVhlLub+4a
	 w8JenOZvD+wAFtRIghG1DAlWD+rSkwqVXZW8QeAAM12/G1bQl9ZMDtBqhQ6YhO1QlH
	 ZnUM9kx840rWYkU7rkbfV/05QqwnJ8bpO6C7a+S26s7xUh986FfI4V5qfIld8bX4tS
	 /Z2kZV2/JGu0jO04HXcZ7wn+Nq0WcJkAN0dMChcmdxJFwoiETOLkUJKL0BBodL+dNN
	 QCpBKbUuWqJeQ==
Date: Wed, 18 Mar 2026 10:54:25 +0200
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
Subject: Re: [PATCH 12/14] mm/sparse: move sparse_init_one_section() to
 internal.h
Message-ID: <abpoQWT0kY2Ybx98@kernel.org>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-13-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-13-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:50PM +0100, David Hildenbrand (Arm) wrote:
> While at it, convert the BUG_ON to a WARN_ON, avoid long lines, and merge
> sparse_encode_mem_map() into sparse_init_one_section().

... merge sparse_encode_mem_map() into its only caller
sparse_init_one_section().

> 
> Clarify the comment a bit, pointing at page_to_pfn().
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/mmzone.h |  2 +-
>  mm/internal.h          | 22 ++++++++++++++++++++++
>  mm/sparse.c            | 24 ------------------------
>  3 files changed, 23 insertions(+), 25 deletions(-)

-- 
Sincerely yours,
Mike.
