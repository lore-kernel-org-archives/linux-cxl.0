Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77213CFF62
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782776092; cv=none; b=VqcfrVdpkA5DqrYsqh5sXg7hJvMz+sRbQuUzTpy8DR2sdG4G1DN0XVX7NBSfoFmqAjui5x3BYyKiTg4kvG60iiSHW0F4N9uyr5VV2PNlyKGWP71nwWQWb+vZ52+CLhWuXvHKYjyEvmxCAxIEoeInzKGPK1eD/TDgDcQ+qwtAK18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782776092; c=relaxed/simple;
	bh=eBOriRVqv06ZV925cJw2JevW7qsclpJkSvxYs2d0/R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rGGTpcqvfxIlvHO5WtaGZHby2p1FRwP84Uj47NzRgPDOseeWlIS6BkkM52lB0nw+J9RStZ76TSpVw8SBO9Yz9MhhIaWRKD1PcdG4xqrNMy53L+8T9+zKUCmNQsh+OdLB7Tm9nqUOPsLRIsUExl4AS+ySfxgpv1TjJsySXs7/4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WdlFHOsa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdlFHOsa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782776089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tx9bcHWuZ8oC4m9hNe2V4W31Y648brgxhiWHI5yWr0k=;
	b=WdlFHOsaPrw+Ujv5LIKdl44ScOjuRz2Jdhbxz+ATYH35oIvn7iaHVCmaogvgYbF9UCd5PV
	tVGDqINGO4zrS8DO+gsRwpXLm7raLOS8OKS6jjooEkSFR4bOm5AcsPhLtmvDp7y55LZSs2
	212uJL3+1Q5atl0fIemYO2cM1mkH1y8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-KqaxYLz6PiGPmA8Ui1Y1bg-1; Mon, 29 Jun 2026 19:34:46 -0400
X-MC-Unique: KqaxYLz6PiGPmA8Ui1Y1bg-1
X-Mimecast-MFC-AGG-ID: KqaxYLz6PiGPmA8Ui1Y1bg_1782776085
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47248bd8bc0so1512174f8f.1
        for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 16:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782776085; x=1783380885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tx9bcHWuZ8oC4m9hNe2V4W31Y648brgxhiWHI5yWr0k=;
        b=jbOQb50t6/OwWD+5dN2n4ImYSDRelhUcho2f/uXH3NC0emyqvEtA7wuLbjLmrstbCS
         e8l67H2kzwnjztQw4ra2asgwOxb22tsBQfkQOxHs/miAyJGMhjW/x4MNakXlevtD7S/0
         nmAk6ToUFwIzPA33lkRBgtXjGEqleQYiHCZkLsuFNwa+nHAyItYiLzOyShL2RYw4PTb6
         5Bb+47qgFOc3LRQEPaeEr6Y3NsMUGugd9kWRICBW4G4ZxmzVLFbFrP0xiG1RQM9NFyMT
         uQdxLBCnz5qUi6LHvlReefGemW4CFn7X4+xSudlI18MEOisiLSswGhgsVxVcg4hnG2tg
         Gbxg==
X-Forwarded-Encrypted: i=1; AHgh+RpZdJL4M/C7vZd/dM0y/zTrr7fbIrXhwA21QWoA+LQXveN29sMe+hL/nUrszPa4Dd3oGWbgIUFWxeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXcTncKvbOL50fAyC/K9cdl7PbhLO1+U17O4SWyJjoPopXf89z
	RgPIEbpUAz6PKWhcZEF6jGFqcb46UsX8i8U1YM4kDFIcFS90r41n4p4aUU/6/qQcIm/SGiH/Scj
	BaxyHYHZozj14WhtcD6pTSXJsp8np6ztnJE2SFjJm+UASdVcCU5pYlLbFiOpYhw==
X-Gm-Gg: AfdE7ckx/ZqYwWpMXdHawClbirHlLRs8MQoZq2AOF8TDIlLkJ9+ByD8PCW2+8W41O8e
	mp+QipEzeG6B3pHsZLXSDUvBfWY4hKCYgHTM4g0vf0mj9QMB6vIXFKKodW7gUy8WWOehzD97X3Z
	6ngJG4kmByYfYxbA6nzL1gOw4iy7AmpYOy33LW0B5kPu7p5jR25Cw/gLQ+Tjio9IyzKhog0ub7p
	Y9WMOXiTaMgbCQwThX9/YjXQ8hFKug51hYC3eqahgglZw1wC+Rls6DJqGU4xFVkn3bFzzcMzPoF
	WGdcfon9Rjku9n6HdNlLeFN464HcScz7KTzwwAzu0J9z0ujT9DE7gSdY3SLozYbDlbLBjrQfUjL
	GnYeOJql6iXoy1lFKPp0n2N6yCxJPkan3
X-Received: by 2002:a05:6000:1789:b0:472:7ded:66ac with SMTP id ffacd0b85a97d-475505f51c3mr1799207f8f.7.1782776084914;
        Mon, 29 Jun 2026 16:34:44 -0700 (PDT)
X-Received: by 2002:a05:6000:1789:b0:472:7ded:66ac with SMTP id ffacd0b85a97d-475505f51c3mr1799165f8f.7.1782776084447;
        Mon, 29 Jun 2026 16:34:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4618sm2067879f8f.9.2026.06.29.16.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 16:34:43 -0700 (PDT)
Date: Mon, 29 Jun 2026 19:34:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andi Kleen <andi@firstfloor.org>,
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
Message-ID: <20260629193347-mutt-send-email-mst@kernel.org>
References: <cover.1782676497.git.mst@redhat.com>
 <0b5f8b4b-d7dc-4b79-9555-a5b36265f3a9@kernel.org>
 <20260629030657-mutt-send-email-mst@kernel.org>
 <4f5ba5d6-246c-4430-9737-e8dd8e4c5142@kernel.org>
 <20260629092856-mutt-send-email-mst@kernel.org>
 <54c8cbee-9b26-458c-93ba-5aa594f5d1e8@kernel.org>
 <0a309ed3-378e-4d88-95a0-65bf47c5496d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0a309ed3-378e-4d88-95a0-65bf47c5496d@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v5NIPuJ8PQLHMONUA2FLXhVzfmUS6rqR980VKGNjHow_1782776085
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2026 at 11:43:32PM +0200, David Hildenbrand (Arm) wrote:
> On 6/29/26 23:22, David Hildenbrand (Arm) wrote:
> > [...]
> > 
> >>
> >> And again, I'm really not sure fixing a theoretical race when memory
> >> is failing is worth slowing the world by 0.1-1% for.
> >>
> > 
> > Fully agreed. I was hoping RCU was cheaper (I mean, we were once told that RCU
> > read side locking is essentially for free ... well in some configs :) )
> > 
> > The question if we could optimize it reasonably enough ...
> > 
> >>
> >> From what I saw in my testing, if we allocate 4k pages
> >> it's hidden by the overhead. With hp and thp it's measureably
> >> worse than rcu on !preempt config.
> > 
> > ... for example, by doing the rcu read lock + unlock around the
> > 
> > 	for (i = 1; i < (1 << order); i++) {
> > 
> > loop on the alloc path. But I suspect it's not going to make that much of a
> > difference.
> > 
> > I concluded, similar to Andi, that stop_machine() is too big of a hammer.
> > 
> > I wonder if something could be built out of preempt_disable() and sync SMP
> > calls. hmm :(
> 
> Scrap that, shouldn't work I think ...
> 

Wait a sec, what about call_rcu_tasks? Use that and re-check the bit is
still set?

-- 
MST

