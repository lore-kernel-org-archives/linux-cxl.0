Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3265947AF75;
	Thu, 10 Sep 2026 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789043683; cv=none; b=UwBB4Igau6JnXElaU4CXXtPBnLS/OAS+O6nGNsmnL00HMJ7CrUPmUJkvydKQk6v2t1gyFqq23oHz7QpxLxmiPOUvIygjSR/mRR6dcMow4KRwxBOfwXqyvHc4H+GaAy1V1Qtkbars1MPxlFiBzer74MoBO2mvecrxajAvyL7lTZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789043683; c=relaxed/simple;
	bh=ChddhQotsbrIy0k+r3zzQv+yQcJdOBPkumOrQGjH3XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kztAVd4odUOhc/5a4No9vU5WAAzHyGPIPilR3o4W0Gm8D9qx9tWtpfb0m6FYaU/E+WJVTQKG9JhAvjn72xfvz4BGvor5zKYBEUuX9ba/rGLESpM75JvTUeIMloCWnxRiYkd8ZlP9CHwVPuHHL/rePMJjtoy0yzwApt/KEiN6Bx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrFIE8gQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrFIE8gQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47F51F000FF;
	Thu, 10 Sep 2026 12:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789043681;
	bh=1SToql/8RNL0QlmyNgNcbyVZRZMo9Nm92xz+B5aj5Gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RrFIE8gQ7v84NTuotjDRyD4tILIQT2Xsh0Vj0Z2rUTS0mgBEtCl4Bfoh9OtwAOtYX
	 JHI8mutv1t8pRR/3neCq9NATaX1TSG1Suwzd/YioG04M14L0D9jyLWRWi8/6Le8Gv7
	 B7w7t+KVS6jsJ7COZ0ZXMrU4QRGT0egmnSffh59Ku6fhEN/GPddK9f+4ktcTkM2Hfn
	 gt05++xZK63kz7ZjI4siNm7jLaB462ptROeRyxUaluAcOWGgrExWNM2yUW9dNdghxb
	 BDDqN1Lu+ht4w98wVCZ299xiwY7jctune3HZrRxX8XACFaIeLrr84Xeldkurkbp/3i
	 QzX1z3taLHBJg==
Date: Thu, 10 Sep 2026 14:34:32 +0200
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
Subject: Re: [PATCH 10/12] mm/sparse: remove flags parameter from
 sparse_init_one_section()
Message-ID: <aqKj2Fgq9MOL8caF@localhost.localdomain>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-10-008fc8d579fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-10-008fc8d579fe@kernel.org>

On Wed, Sep 09, 2026 at 03:33:03PM +0200, David Hildenbrand (Arm) wrote:
> Unused, let's remove it.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs
