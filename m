Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474506;
	b=nUY4MwpeQVegPYOBseItr+T/E4A13xIELjs9Ch82CD4h3Jxo5CSRZ3oQ09ds51zuzPnw
	 Om8zi3adG1CLhtfCI1rsLOQeMEW5/ql2vvVDKIwAN/hZRiEvGArQcsuJ7zeyGr4EiAgZI
	 Z3VXTmR+dpcRwtcrwc4SnBQiLLdrALC4oJW7h89/h5xMJv0xUMe4AujMMen2o+gNTuYYb
	 4VRZ6dMTjG8j7RBceAYCVTPph42RC6vewm8WBjslbYZg4x7wfHXyro03gChNfhx2qbbL4
	 pNZCa9OVIzWXNNaeb7C4MUSTPVOqKoYd4lBE9qjVMrjeTmoLJ5ohHYAqCriX1AM7FxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474506;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=sT5JORa4hluQX/UGABU9ltevF9DMtn7AClnTuZFBi64=;
	b=mQH1DaW0tmiA2X/mkFNlrUzSbzBdMkEs3uvitdrwX7jx2AcYr/WQ3zfmLOcQzza+zb7D
	 DGm4/een6romcsXW5ENxI84Mh+/8ovaq6OfSXoNdOLwhd8+8dNx8i71d1jJYihmRrWL5h
	 BOfW1jG2Wd0LYh4RIOomlb4x915ci0K+lARp8RvpAHEWhx9oT1bo7trbJ7ltSexpMfXOo
	 RApD5O36aKpm+GP6Hzx1H5w1t91Box4NC5wtuigC/id0t3fnukKohi7O5jjpG/q0jsTr7
	 ydYMZs5GELUvbXQKFOWBag+buUAjJsdS52SCfA7ogPyRQwtVvLi8/df7Jkbj6tmdWEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dK91/CBD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DADB606A889;
	Thu, 12 Nov 2026 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dK91/CBD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4979C1F00A05;
	Thu, 12 Nov 2026 09:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794474506;
	bh=sT5JORa4hluQX/UGABU9ltevF9DMtn7AClnTuZFBi64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dK91/CBDUKHnx4fnxpXkYT6g6EjYNWdbEfh28QaH4eiXnsV7Q65lDqVP7CnvE/zD7
	 3PL8LPJSkPlTXKqXQzkgMcC6n9oadyiqPqaJ9OF34qhg86EiHvtApGY8+jOLYvnrYx
	 qly7FN3cuvvW7NQV/qLx8+0BJlyHWHjTc5Iar9JQ0rKVKYAR9Bfm8GlYty1323KO0S
	 J04aUVbMlpTo5op0oUgccIMziBFU87+0zggpYiSVWSQCj2jUOHloi27gGFT/Nd/ysB
	 QdHoyqzJDffQdW6oAxuFCBOd4NijXG9eV0U6VyzlVUDPyQwZO+dbO9y81oIC2gPQRL
	 gbnVwvLiJ/FEA==
Message-ID: <a6da0f9b-c292-471e-8bf6-5f67b735591a@kernel.org>
Date: Thu, 12 Nov 2026 10:04:51 +0100
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/5] mm/memory-failure: Add a pre-online poison
 registry
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>,
 Breno Leitao <leitao@debian.org>
Cc: Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Richard Cheng <icheng@nvidia.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Oscar Salvador <osalvador@suse.de>, Kiryl Shutsemau <kas@kernel.org>,
 Harry Yoo <harry@kernel.org>
References: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
 <20261010162017.62506-4-shaikhkamal2012@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261010162017.62506-4-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/26 18:20, Shaikh Kamaluddin wrote:
> A frame can be known bad before its backing memory is onlined. A CXL
> Type-3 device retains poison as DPA-based Media Error Records and can
> report those records through GET_POISON_LIST after a reboot, kexec, or
> device hotplug.
> 
> CXL poison can be retrieved while a region is being prepared, before
> dax/kmem calls add_memory_driver_managed() for the range. At that point
> there is no initialized struct page on which memory_failure() can
> operate. The poison information must therefore be retained until the
> corresponding pages pass through memory initialization.
> 
> Add a registry of sorted, nonoverlapping poisoned PFN ranges. Each
> registration represents one owner and its independently managed memory.
> For example, a CXL region registers the poisoned PFN ranges translated
> from its device poison records and receives an opaque handle for that
> range set. A second CXL region receives a separate handle for its own
> ranges.
> 
> The owner uses its handle to remove exactly its registration after the
> associated memory can no longer enter the allocator. Removing one CXL
> region's registration does not affect poison ranges registered by
> another region.
> 
> Keep each registered range set immutable and protect the registration
> list with RCU. This keeps allocator-side lookups lockless while allowing
> a registration to be removed safely after an RCU grace period. A later
> patch will consult the registry before initialized pages are released
> to the buddy allocator.
> 
> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> ---

Oh no, another source of poison information. That doesn't sound like a good design.

-- 
Cheers,

David
