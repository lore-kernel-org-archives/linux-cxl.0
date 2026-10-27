Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072434;
	b=eoQyECKthcEKp+XtCZagahfGrnniuIAhdxUn8ZXHEodWB0DNs2x6dVuhFLHCBI89FXca
	 0W99hDVcvYHm4mAHzbJ1NF+/gCnsfakdsQO8fpyqaTcCzenYcfQeD0US4GzUiJrqKLMZ+
	 jG4qMEm6CNahOlsIkrtNNQKoZbAXBLYhIk8h/DZAZrVXze+HpWKEca4NQ6c31rKK1onen
	 JX83QTYJmE07aqPFTdaFq1kltMRPA68hKavteuRqsUvpGmgEXap1V9IqBDXfwiF2Xl/vb
	 KLh1h9btT/yUQ2/1UJ/Yh36T9flpcfRnhGzV4K+VpG9uZA4N0XnB6thaP2ApboFn9Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=cRzqF3pZC9T9+mgqazzI3wB0gyIKv4okDYmmTH+ci9I=;
	b=F1AEQXM61viPoX6AZ2+04MizKsy4R31Ec+1I/UlV9zN2eCExiqPsKNV+sTvTX1GRDC4S
	 2rcwf3UuJRecdv5KQ3iXRNsxrBOBIrvhYEHCsIbWMtOF29eaxMHnAPoH2XKh9Ve4EbORq
	 qB1UCR144LK24zZHrX8ByYtSjfB806UTezGyh9EUqnAtDg/lnC4cgSD1zyR9upMcUrBHg
	 sySNITPUaivgprogYYrFH2qCGtNcJMV1tNH+cvBRcYmtYt1PYu04W8xlK6EseTuqHLtJq
	 OPWOJmqQ2RlixgIHAyBm+CP6XWvfbm+tCvamt5h5f9WzxPncouj1GqvXeBJzruCpmNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=klpxKBx6;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965C8606A31E
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 03:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 965C8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=klpxKBx6
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c315869241fso478335666b.0
        for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 20:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793072432; x=1793677232; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cRzqF3pZC9T9+mgqazzI3wB0gyIKv4okDYmmTH+ci9I=;
        b=klpxKBx6XIdguBPv1gdEeaxX3Q5nBOE0QyQKgI+nQtmFi2e6yyGoD1z99atiOq/X0L
         29MGF1ep4EQ1gv/+055Qkplcqf1YtKuIcCv5aGSKHjEYK3jS7yM9nfCIB9wNkxkiBkUw
         3XYbbVntwybyBZUIqAVzhr/u8Gfrjw4XN/c1wAbiBcjL3VyyvbdMABrMl8JljkCI4HBP
         HDeVnIkL+LtyK7DjLzJaTMJ1PXNZWLEFJCqh4gUIf6KP43zgwJECwGuEgMjpM78oIwbB
         yrbDn8qUsI/PxLnPvbStsGGa4HcTlJR/M8tesdaSKCW5YkmlnkFTtYdIc+MJU/KUH2YX
         ocTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072432; x=1793677232;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cRzqF3pZC9T9+mgqazzI3wB0gyIKv4okDYmmTH+ci9I=;
        b=u7F1T9uA+uMGVr48OEe7BVELVQnAosp/JTre4xGD8z9PHWOKmPtyLs/v+5pBvDcw80
         UqJOeHzuFUsPNWQi8cam8yIdOfewX0/7ECT8F2daMIfFw30QJGtaoKn6rCIyl9epjgsj
         Jxaxuc5SC4fjKioWIiw5TqjG/4X1Rr4CEuNCpETQKVK7M/o1NleXT5G+8OfRAnIIpARw
         dtCLXdyoSyDn+pHrV7AMfuTJxVLeg9sytnHUNrO/Lv1mKvAOyNvwtHCFdxQE1sYDfvjt
         h5SRBMq0NK1rOAxRl3ybmvHVB3UqhwXSM36JBW255w+d0KMZqoje4fasUBbVlDvqAihL
         vOhg==
X-Forwarded-Encrypted: i=1; AKwUvBw409v1g1NhfK1xZrEcuohZdL2m05fixOKmYoxCsb5hhRwcJ4o+ScZdMCLVKP73AEHBOFDaEFmKWh0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIaCuS+UJ3HUo+UMB0wfQ8aS7HkEBRXKDN0Cxr/flsaEtL7oQRd
	fXZWezIkdILRl3ksaDtmNdvqixpU+qJdMACIYw2Jc+zQW+dyhj9KmlGOQZV5Ct5Vb94=
X-Gm-Gg: AYBFou2BUjkLjDSc+VnIc6ab/cF14McNiWHLTCO8z4eROcWZDU0PXNeCXpEce86Hy0T
	qn83EE0lSHLX/FKBP7aqQYLCToHnOfhBhpOBQ4B7jUzUOqfniDcb6EqEplXfmZ46qLkhE26x1GB
	aQTJuzQZgq3Lmc5GPny2C/1VUzIXrE4IrCCaKsMoVexwvd1npyEvl6UkgIU4g/G+TauQeo469i4
	KZ19QMlZ1JLKy2Z2+pZi9FOvbaupkc8+jjgWlL+DNSQ+v+sLIYTxsgiFQ6o+0tjrSSfN9DB+mfs
	iuBTcUw2CTtHfWE7jeyF9hsnGJtTvIFGheNAzxmpOZHa+WW0lPiGNHuNfhsJddY2mc8MyvBJ1SQ
	8G6wY17Re0+XjQIndebzxwvr7aaK82LmXnj9Q1aEhynfF/f1YWhzaMrBXLsEjbkQ2YEpwBJIt90
	lrFh/YMYv7RMiLb4uNxn7CNbYpQdgFOpimS9p6cT/H7jQkg5Od6tKm8uICr5KWJxpnJ7cFTJGge
	zFFifPLP+I9vDQI+KJDGOvPpSD67hjs6OG9k1z8bE/KcQ==
X-Received: by 2002:a17:907:971e:b0:c46:723d:600 with SMTP id a640c23a62f3a-c46bde9f783mr916491966b.41.1793072431944;
        Mon, 26 Oct 2026 20:40:31 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4e784esm379153566b.19.2026.10.26.20.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:40:29 -0700 (PDT)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 26/46] mm/mmu_gather: fix flushing ranges with 4 GiB or
 larger
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-26-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-26-6f74bec9a5bb@kernel.org>
Date: Mon, 26 Oct 2026 20:40:28 -0700
Message-Id: <179307242835.1171062.11616590599815003560.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> __tlb_adjust_range() takes the size of the range which has to be flushed
> as an unsigned int. Its callers, tlb_flush_{pte,pmd,pud,p4d}_range(), get
> and pass an unsigned long. Consequently, a range that is 4 GiB or larger
> gets truncated, possibly to 0.
> 
> On arm64 with hugetlb, a 64k kernel can flush 16 GiB hugetlb PMDs, and a
> 16k kernel can flush 64 GiB PUDs through tlb_unshare_pmd_ptdesc(). So
> at least these two scenarios are affected.
> 
> Fix it by flushing the proper range instead of the truncated one.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: b528e4b6405b ("mm/hugetlb: add tlb_remove_hugetlb_entry for handling hugetlb pages")
> Fixes: 8ce720d5bd91 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> [ david: use two-tab indent, simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price <gourry@gourry.net>
