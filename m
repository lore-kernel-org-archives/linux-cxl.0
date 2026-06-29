Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B4B3BADBC;
	Mon, 29 Jun 2026 21:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782769188; cv=none; b=BJ6Ku9zsJOgFxtQvVNKOgCyKEW9HSttsKRf2ohiu9aC7a2Vfj+jqd+bneVUGQOrrMZBg6+EsHQuKtnsfOO8LDCA4CBNiDjUytaTOnPAcUH5plrr340UmahVGYKXxc87yH0T/G2HzZJeNtv18N4VHju2Sekc86B6fgbZBE+OvObY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782769188; c=relaxed/simple;
	bh=GuD/79X0nu+YRen9n8+wn7LNbblRnFofv0JTsLWRR/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/KaZm5E7K6qfowJGv7ZBlqdmTPVw7XQoCidMmr+jiKSEUVmQAsMSXkQWPFpwsoLWU60mu+k/pKpzMENOPHgiRIEJRydun1DQmx02Pb25ER+xHs6q2Uk/j9QT3O6JFOfSAbkk54vSBg+/EKKfHkoDLVISzg2vVvQmznXs1I6Xcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org; spf=pass smtp.mailfrom=firstfloor.org; dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b=n7Bmh5y0; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="n7Bmh5y0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
	s=mail; t=1782769184;
	bh=GuD/79X0nu+YRen9n8+wn7LNbblRnFofv0JTsLWRR/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7Bmh5y0b+kjd2mujWpov7y2xuJ79H/44+QKszlr+nZr0pY1nfMZGPqsRbUenWECG
	 sbTrns9Ime6+53Yq/0+yDnD83ha/tpZd+MosNzgbW3VRHeT1wM3wDIIxCP3RJ9EYzi
	 ErmVboyVsPdisyNSLj57X6aRL8Q938T9S2jDkCYs=
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 0D0455EAB0; Mon, 29 Jun 2026 23:39:44 +0200 (CEST)
Date: Mon, 29 Jun 2026 14:39:44 -0700
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
Message-ID: <akLmILr-cbl8Eqq-@firstfloor.org>
References: <cover.1782676497.git.mst@redhat.com>
 <0b5f8b4b-d7dc-4b79-9555-a5b36265f3a9@kernel.org>
 <20260629030657-mutt-send-email-mst@kernel.org>
 <4f5ba5d6-246c-4430-9737-e8dd8e4c5142@kernel.org>
 <20260629092856-mutt-send-email-mst@kernel.org>
 <akLb3WW1nJBaIBwc@firstfloor.org>
 <20260629171727-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629171727-mutt-send-email-mst@kernel.org>

> We can maybe batch a bunch of these, and do stop machine once?

If you add a long delay you increase the risk that the machine or
the critical process dies because there is an unrecoverable or
process killing AR access before the page can be off lined.

(BTW that's a problem even with the RCU approach, the cure might be
worse than the disease)

If you don't add a long delay you would do a lot of stop machines
on a flood, likely bringing it to a halt, even though other sockets etc.
might still be fine.

-Andi
