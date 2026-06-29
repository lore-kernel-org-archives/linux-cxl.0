Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FF138B14C
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782765866; cv=none; b=M+ym4+kZnP/j+lJYJ9PdwUCtKsMtW0/oBVReCEaGNONOFzs//JwVkvgTwecohADxtGoP9vjq3/VeyVIlrx8MCVPDOY2DSwY/zkkgm5VfJBqyoxVqU57aSGQNdvnXzWUB9sJh363BNW9Iw073IkfG+OrnJoYeeiQvIjJ/Zjy/mMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782765866; c=relaxed/simple;
	bh=8vU9Enikwm2aJC0sPAErMK2X1JZkxrkRDio+9c/Jiwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fXj1ABaFCCLB3kfnke08NBlzFDx+5AGaG3lEOGt9XqAE9if915eSSItyv20S7e7v9CCxBDUmVsKW9fNZzvVYyhNifgyNtVvYStamseRJkuTRTwjyflNs5dRBaclYOAiiwyls9Wd/5mkWTUcop9Gzv05bS53HEy2KvPOwXve0HLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XmAyMmMw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmAyMmMw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782765864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TOQpLe5g2es+HuSRD8vnoaoM9ObrVUNQWd1XrTtB+E4=;
	b=XmAyMmMwmftSK49Agi47OtWX5GZNhuw9l6LW1rjMEa2OwC2biKy2S2MgT337avMjg2md1Q
	/cF/zPPWGsZhPcO1fbhfw+J02HOtkB9TEuVHA9smdE6+YAlValOUS63tmp6Tq62+sJGvE0
	DD30B9PZ3OAdl/qUK3b0tvJPYMEHxmc=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-_01V1ChOP2SYfZ3de9YGOA-1; Mon, 29 Jun 2026 16:44:23 -0400
X-MC-Unique: _01V1ChOP2SYfZ3de9YGOA-1
X-Mimecast-MFC-AGG-ID: _01V1ChOP2SYfZ3de9YGOA_1782765862
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30ec59471a3so1271018eec.0
        for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 13:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782765862; x=1783370662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOQpLe5g2es+HuSRD8vnoaoM9ObrVUNQWd1XrTtB+E4=;
        b=WPQ0CB6bv1Q2I3GWX0kt/Tkr2NIIKaZaPOmkSl6i4B1+2MDoDbckIF3jMPO5lEefJM
         q1iHCk+aWF3IiNQ5FEEocPxCdwuJ7A80DJWHCeA4UBkfHnm/KxDdYUktJjlLk6iLI+fv
         SPH1+WcPwChYKPNiEoYXnTT7tjEx2c6G4TrSHEt7Xc4E7YM6IaVx2fs/+l+J8yGX3gkD
         0pgoYPAK/0W4JpNgeJY0R5h+T3pxfMuSQlKDw1qQoX6IN00rMEWUzXEOYSC6xkQUzZml
         L4kMXbNP77yptx1LYBUyDxIeP3zLj3qteB2tRmY3m+5LwtV1L/xG1ejjGMoJUGt9J/Ro
         2YgA==
X-Forwarded-Encrypted: i=1; AHgh+RpslBXduAt40wGruVJRX0kyi2OiCY9RMXBiKhaO5S1nKq7ic0eygMUzQ080b09fZIrusOAnBITdixQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKFUMyA8QxMjWLatrltW97SlIcprTEFhy5pJmbj9qROMKg6gNx
	jY6sbI8GawB+U10Q4f5ekM241yzdXH9GRHhtHLu7boWyOxXp0LL3jfHwDW0+NWh/6okKNA/vd8R
	G0+Qua2xeJHoZq02AUfGHpZNlCrMTAqApzx26YzzMWU5ft26vY0lrqfjyMsfy/g==
X-Gm-Gg: AfdE7cno3qsLP7rwaMaj9t3deHXpm/GNhnXK+fyr/7Z9kXL2cfEkIotJDWzaY6kroEK
	p+z/ku1MC89jN9G9FGz19owrgNyEVo8rkt4ScsCVigOdq2tDxb6wK8+xg5MEiVX/++YkQFxuHjP
	JwJTnuP/dfgiCzqKhHDsTEwA1pVLx+W1B625sUFnwTIq1KSbvC3tS7HfsRLBeMZrIaUO3TdSkhJ
	AGxIHjgn6rcG1oxbIPCOv3+qhHXcLZ0H1VQxP5XA+W8w6AT0VYLrR61o0jOacGNwK7UMYCbdfLB
	txTR21MfJdjr9Y0LMMCnI3H6zG3RE9OyBof9iYLV4QcCzlzvHzyqBfkRupkHSPPQ7ympKwxYAM7
	79QnF6nSR4nd0ocO3tt4V4ziSrqYHSpq1
X-Received: by 2002:a05:693c:8948:20b0:30c:ab96:7307 with SMTP id 5a478bee46e88-30ee18ba288mr436358eec.22.1782765861527;
        Mon, 29 Jun 2026 13:44:21 -0700 (PDT)
X-Received: by 2002:a05:693c:8948:20b0:30c:ab96:7307 with SMTP id 5a478bee46e88-30ee18ba288mr436310eec.22.1782765860825;
        Mon, 29 Jun 2026 13:44:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5e4dcsm857053eec.5.2026.06.29.13.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 13:44:20 -0700 (PDT)
Date: Mon, 29 Jun 2026 16:43:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org,
	Miaohe Lin <linmiaohe@huawei.com>,
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
Message-ID: <20260629164258-mutt-send-email-mst@kernel.org>
References: <cover.1782676497.git.mst@redhat.com>
 <akHUboUaYi-OJHFu@firstfloor.org>
 <20260629033608-mutt-send-email-mst@kernel.org>
 <20260629043417-mutt-send-email-mst@kernel.org>
 <akKjOG6iFhGNTFYC@firstfloor.org>
 <20a5dfd4-b3c7-450a-8a70-08d0345aade4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20a5dfd4-b3c7-450a-8a70-08d0345aade4@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x_p2r0nrNNNAm-ziapNXy6sULYUrcmYVczotaI-638M_1782765862
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2026 at 07:04:25PM +0200, David Hildenbrand (Arm) wrote:
> On 6/29/26 18:54, Andi Kleen wrote:
> >> However, this was a basic test, when allocating 4k pages. With 2M hugepages:
> >>
> >>                                    insns/iter    cycles/iter
> >>      -------------------------------------------------------
> >>        base                       20758 +/- 12.5   191208 +/-1946.6
> >>        rcu                        20785 +/-  3.7   197108 +/- 132.1
> >>        atomic                     20727 +/-  6.4   204591 +/- 160.2
> >>
> >>        rcu vs base                  +27 (+0.13%)     +5900 (+3.09%)
> >>        atomic vs base               -31 (-0.15%)    +13383 (+7.00%)
> >>
> >> and even with THP:
> >>
> >>                                    insns/iter    cycles/iter
> >>      -------------------------------------------------------
> >>        base                       27220 +/-  2.8   192151 +/- 483.3
> >>        rcu                        27248 +/- 30.1   194159 +/-2746.6
> >>        atomic                     27186 +/-  3.2   200526 +/- 746.2
> >>
> >>        rcu vs base                  +28 (+0.10%)     +2008 (+1.04%)
> >>        atomic vs base               -34 (-0.12%)     +8374 (+4.36%)
> >>
> >>
> >> needs more thought.
> > 
> > Well the alternative is to not bother with RCU, but just wait a bit and
> > check if the bit stuck and repeat if needed. While that could in theory
> > livelock it is extremely unlikely (especially if you add a bit of randomization 
> > to the sleep)
> 
> We discussed that a bit already. Hypervisors make it fairly unpredictable how
> long you would actually have to spin.


Way I see it, this is not the issue. The issue is it does not fix the
race:


CPU1:

read flags

CPU2:

test and set

test and set #2 - sees it is set

CPU1:

write flags clearing the bit




> -- 
> Cheers,
> 
> David

