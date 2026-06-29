Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F270388E66;
	Mon, 29 Jun 2026 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782766562; cv=none; b=tRcmZz7phbixgdd6wI85/Ii5wAa4toIIXzmUi1OApTMWZNnj2M/hiY1Ax3Gpglwtuu87u+euW103fgAirG71aIL/BW/xtN8Lt8T4mqYxcf7WdVZA0Ypg4ssuRkSFann6KwK7PCXPHoJ498YUOfkay+s/fQ6Kp6oNQiX9tL0NbG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782766562; c=relaxed/simple;
	bh=/tvg/jN0WToCXtXgDqZ/kuwds2GDUd6tWHDA03ofEXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNtc+Qs1q09kwN/OTAA7dzuMydwAukidGA9Csl/QF7zOVgriH7Srsz41Bmk3jcV1DeB1jJjLWITE4x8w9GWanloZ3PVHPOJO9LGWja4xuLb4+8Sh9RWc1cUENXMRhWW+NLFoaGjG0Mmnd6wG9bzYvYclnYQBdCvezRnYj56Pk+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org; spf=pass smtp.mailfrom=firstfloor.org; dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b=eXLEYbaA; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="eXLEYbaA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
	s=mail; t=1782766558;
	bh=/tvg/jN0WToCXtXgDqZ/kuwds2GDUd6tWHDA03ofEXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eXLEYbaAqXzj/CjiVayX5D85ctAC6z4mLTUp2/1tYuXAIndvl0XPz7qtPphQmGHy1
	 c27SZpdv4xKDPL8QwYAb/COLdJDU4rV0J5XR3F8qAixw9ZsqAKbtnaHCHFAbMqi5Du
	 mrEFjObTcb3WsXHQcH3NxK4z+xOcKZueE56Ud878=
Received: by one.firstfloor.org (Postfix, from userid 503)
	id D8DB35EAB0; Mon, 29 Jun 2026 22:55:57 +0200 (CEST)
Date: Mon, 29 Jun 2026 13:55:57 -0700
From: Andi Kleen <andi@firstfloor.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
	Rik van Riel <riel@redhat.com>, Vlastimil Babka <vbabka@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>, Byungchul Park <byungchul@sk.com>,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: memory-failure: fix HWPoison flag race with
 non-atomic page flag ops
Message-ID: <akLb3WW1nJBaIBwc@firstfloor.org>
References: <cover.1782676497.git.mst@redhat.com>
 <0b5f8b4b-d7dc-4b79-9555-a5b36265f3a9@kernel.org>
 <20260629030657-mutt-send-email-mst@kernel.org>
 <4f5ba5d6-246c-4430-9737-e8dd8e4c5142@kernel.org>
 <20260629092856-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629092856-mutt-send-email-mst@kernel.org>

> > Or if there are actually more performant alternatives that we could use. (I
> > still doubt that using atomics is ok in general)
> 
> Right now I'm thinking of looking at something like stop_machine maybe.

There can be (rare) cases where yoy get a lot of memory errors in a
flood. While memory-failure doesn't need to be particularly optimized,
it shouldn't be excessively slow or impact the rest of the machine.

stop_machine is a big hammer that is likely to violate most of this.

-Andi
