Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0F529D291;
	Wed,  9 Sep 2026 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973342; cv=none; b=pj7rzG0CDgfHJs6TA79U46UfXhbzojOgoKkrjgL5DtCg8ieFSI4fZhge09wFfbR3la82ut0sWhjzdGlUM9F9PKTxMaeAOC8ufGkzkSKgu8MUoFmlmAm6opCPX+VQpXZtRDujWIyK67yXaqSDRLgKbLI7iGus1hxTLC1oSJffCJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973342; c=relaxed/simple;
	bh=nRyjr9gAPzzEWH3ZNwWFFh2AvVacwc7h1yyJgn+T160=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Djea6OcPk9zpFATtn3HJHscjHNF1mLx2bWlkI2JfKkc3B1CledvRyzSG3PafihxlbZNN0bzHSRUwAzBgmZpioDeoz1cIUZUVxFMatM9wXqfeyjd47yjDGAcPt7hnuiENxjVDstAA1zM7o3ivzTxwn/LurCllFEPWx1n3t25mZzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvHsEybh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvHsEybh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8C11F000FF;
	Wed,  9 Sep 2026 17:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973340;
	bh=DE9TKoe8bwCUSFbC5qwEZF5hRWO7Ho+OMN9J/HSOi+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BvHsEybhbyBhohT255O8m66DWBprZJ0jHpZJ9nttr9EfnqWParDrLvXM68xOR+ceT
	 adjAKMH8V9z7oUDawSh03tPXtiAkiFv2rMtMIEHmy+4/hsQ9YLvQjTBofwdOi1La8k
	 l6kv4/TGLmc5Dlm5/3Yc3+/1jTE2vH3am+N2xfd/DyQDU0bvFavz5fIi5WMyNnK9Qi
	 8D0qTO1D+YwbX7Dize9bFAE/ROsQpb6Fkel0iR1beFJtEPXy0BMGYUAZZ5SNn8J+GP
	 HgHLrdn6YhpuSD6BBH9uAF713ewDuN163ZtMfdRbEQz+hBIGGnvE6yZ+SUz2yEG3ER
	 cA8EdV8lCN9Mg==
Date: Wed, 9 Sep 2026 19:02:11 +0200
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
Subject: Re: [PATCH 01/12] mm/sparse: move mem_section init to
 sparse_extreme_init()
Message-ID: <aqGREyCqExRFNCQz@localhost.localdomain>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-1-008fc8d579fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-1-008fc8d579fe@kernel.org>

On Wed, Sep 09, 2026 at 03:32:54PM +0200, David Hildenbrand (Arm) wrote:
> Let's just avoid another pair of ifdef inside a function. While at it,
> switch to INTERNODE_CACHE_BYTES by just defining a fallback in cache.h
> as well, given that the x86 variant already provides one.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs
