Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440D136894B;
	Wed,  9 Sep 2026 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974578; cv=none; b=PprNJnaPh4NFiqqfQM1wFCOA4lyXKdWTqjBK4TO+x5g2XRe4Wrnxljn8Sm0brdHD943EjG6/j1ArMjGOLDRmZjJ57TGz40dbTqSD6kCnFTqSMHWY8NbOue9aGKo9omWEWBFeDWXnJZ7gOGNDhNXIi2hsIKLv4yZ3c/8xr+GdKzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974578; c=relaxed/simple;
	bh=HF7hBvGHI2djh0Q/VjvpofpkXfH6mLt1xAFhu6eQkVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPDa+06Q7LdvZHxmCft+CMfweU+tWBIZ2h2lnVnqgS/0sWesXTTU+shM/0AJMBAnvk7kWrHQsZfb79Wkztob+am6gHvLciORQL3A0MzjiulNZ+NKURAxGsWQ6M0ubntnth8swpouag1VhbDW4xTMxuEXO+JKFNe1J+oV92cTezI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WR7t8OlH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WR7t8OlH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963121F000FF;
	Wed,  9 Sep 2026 17:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788974577;
	bh=APFjnB8AM36hLAYS9rCRFu3o1ig09AcvIwPP4JmZhlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WR7t8OlHQCRXlT5je2S1lLwbE8AzuJZBKD/8FK3wkq5Fir3ksRyBj2zMBwpsqYgrO
	 U1fmgjXiWynIo4WdB1D8oXxw6jHkuOqLmp3ftm/vO2NIg2PmXKxcaIdiJta/knURAY
	 lAceIrP6EZKyszeO0snH+/ydcGLLMI9epoQ78DAygI+dviHOmBB7ucRFFQdtOlnRMf
	 6v9+ScTBkVopWm+GwwJmvyReMTjK/TBNXcEhOranbgn8mtYnWckfC5hQWiY5q5ptFO
	 kZ8O1UE988pLxsCSvlNeDmGAWmfWmiYEJiV/vylICesLReEZxQZK/9HQ63+FWFP6Z3
	 0g5BfbncEglHA==
Date: Wed, 9 Sep 2026 19:22:48 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/12] mm/sparse: move initialization of section metadata
 to sparse_metadata_init()
Message-ID: <aqGV6JDZwfWa-UD7@localhost.localdomain>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-3-008fc8d579fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-3-008fc8d579fe@kernel.org>

On Wed, Sep 09, 2026 at 03:32:56PM +0200, David Hildenbrand (Arm) wrote:
> Let's move the code responsible for initializing sparse metadata (usemap,
> memmap) into a helper. Cleanup the variable while at it (e.g.,
> "map_count").
> 
> Drop the rather obvious code comments.
> 
> No functional change intended.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs
