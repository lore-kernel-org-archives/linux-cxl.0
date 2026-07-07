Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38AC3AEF46
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jul 2026 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783456036; cv=none; b=aym5sPC6CfqoLe4uaqA/sWl1h3oJwel2P4WC6+FM8n9qgpWQJdn368MUTin6ADPo309hXf74FHYCujPadCzWbn1edT9HA6PEJWsryVLXmhJ7h1/DOg71CaEotMNP+/C9+qS2BetUf9QwLtlB6QrQkZJMFfCqwifg3i/UHOGRVrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783456036; c=relaxed/simple;
	bh=5/7xvkA62UlrZAA43XZs85dJD1Nu8HIVqzyRsaeTlX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=vASuWW1Rr7I/A3h3y6i2omR6clxRbUyZwfl8BbZQCZICRKYiFo9WN6w338i5v0wrNINeV5ZVeU61qwo5t7xYzfvUIdEVopra8/GXZQONdP/lu/ByFpCuXPWnMRPPpTCacyKp9ywBb5Gb5QfjAm5OK1hsUmChd4++RG0AreZ3hAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JX2X0+QW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JX2X0+QW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783456034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NAVMhqlCwglZDQHNAKH6+ZrmFJJ54m+xXUdMMc8GRc8=;
	b=JX2X0+QWZc1YC9YALEj/G/xSrthheO80C5UdHJP2TC+U3WfvMbWS4k3fK5kjyQ7dqK0ow5
	aW9Sx1uys1XUjFR476Y5ghi4tqwSzZzNin7Z8NbnwhBo7/acGTOQ7ahwXxT4lUqt0I0xdc
	kdbI9Tje5/YiEor5ouW7xF3IFQuSMWs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-K76str8yP0apRNLkM219GQ-1; Tue, 07 Jul 2026 16:27:11 -0400
X-MC-Unique: K76str8yP0apRNLkM219GQ-1
X-Mimecast-MFC-AGG-ID: K76str8yP0apRNLkM219GQ_1783456030
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47132f8a98aso22192f8f.1
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jul 2026 13:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783456030; x=1784060830;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NAVMhqlCwglZDQHNAKH6+ZrmFJJ54m+xXUdMMc8GRc8=;
        b=S12v3OBjTowRvlkTybcPGnf/guAw7/2hpu3Bu+y0n4gilCrqRhvoPXX4cE4+dbui+5
         ndKU0cELLZi9MA/UMJq9Zwd/lW9w+1H21Sv8pH6M5w0TzBHg3thaLJT5rHqWDWmgVNC4
         Q43vPL0n8T2KS+OwWaASR5jaDTr8/K1uWbBJGXov9dGfTnvRZXu/bT8QXcYnjWwS+tWS
         opNmakhq5eFucKhkc5cUeWSj9nTSSQjy0UA+YM54Z8QUxTZ4iZl5+IeeNUNysTgGeymE
         lAaq6SUjx2zfYlrWdgFw7i0wsGxibDT6rieRCK+QxvAWwENr3O8CQsBkI6fc44bs+6Ju
         BFbg==
X-Forwarded-Encrypted: i=1; AHgh+RpaG6RkGMZKZAHHFVXlLLEC8v2tjF8qLKk3E90Nl4RcDo/ok/WgGBhQ1CeRwuUYyOOaifHVkQeXuwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzW5bkBcDL74QVjyXt7XCvK6o59Ekw3jeUjKYLzbtCm8jPPwZW
	iJlIJibZg9QSPjB4WJXMhyp6ftWN6EExorMpT6yjGehJANjHdcu7bhqhdZnUCeL7eHnwIARziGL
	y/nJLTkbxuvE6iYDdYGvP+qU7gZz3dufVYrlhoohDf1qg89Ox+JO6DTV2DHqphQ==
X-Gm-Gg: AfdE7ckN/RZDZRFSX5gq9Xh4yQ5GFN/hQehKYYXTZvCA8FjYre7Xs66l89hCcyZdyS1
	jY8uERIZ8JcqbZYCjbuxZ+7jywHItPKdFZZ4XPdfWmW5XC2baZlMGsxUUeHwX/BP3n3wxlloo3B
	qHQ/8PjPu+mtCoCCqghlnubrqAlF5g0DCXwclh+YSAayDeE54qNcJ3Io/WjP8NxK0sgjekyCPeB
	yBKG89uK+2h5K1RJqDTaiExIZUjGYrDDOMnbylJxR6ob/LXvAI9uBGuOAbYykPgWGJ/tmj6Ap05
	0hT6VrETMFisO2x2yQhbnWyCT9anaaKFERPYSgIbkBYe24o1B2NgRk4czBgfFyfjM7vTMFkyT2M
	MjNyOCDUYJNPlVfSwACcQBO9mBZSno2kf
X-Received: by 2002:a05:600c:5292:b0:493:c10c:22f0 with SMTP id 5b1f17b1804b1-493df08cd64mr79673205e9.20.1783456029711;
        Tue, 07 Jul 2026 13:27:09 -0700 (PDT)
X-Received: by 2002:a05:600c:5292:b0:493:c10c:22f0 with SMTP id 5b1f17b1804b1-493df08cd64mr79672845e9.20.1783456029187;
        Tue, 07 Jul 2026 13:27:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d910sm35459713f8f.6.2026.07.07.13.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 13:27:08 -0700 (PDT)
Date: Tue, 7 Jul 2026 16:27:04 -0400
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
Message-ID: <20260707155658-mutt-send-email-mst@kernel.org>
References: <54c8cbee-9b26-458c-93ba-5aa594f5d1e8@kernel.org>
 <20260629174225-mutt-send-email-mst@kernel.org>
 <cbab829a-3e65-4b4f-a2e2-704e88a611a0@kernel.org>
 <f6d8354c-2f79-4a48-934c-cbeb335765e2@kernel.org>
 <20260630174852-mutt-send-email-mst@kernel.org>
 <2f884bfa-3cd5-4fba-8aa4-c2e68890ab64@kernel.org>
 <20260701041112-mutt-send-email-mst@kernel.org>
 <d2ce93d9-c3d8-4915-a511-d08eb2c1b374@kernel.org>
 <20260701043024-mutt-send-email-mst@kernel.org>
 <c03ec696-d635-4c7f-8c77-89a439d9135b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c03ec696-d635-4c7f-8c77-89a439d9135b@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: prUTqWeB3UKRc6NeAm3kfPBlpXH2J6M9bCh6utyEugs_1783456030
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2026 at 10:36:31AM +0200, David Hildenbrand (Arm) wrote:
> On 7/1/26 10:33, Michael S. Tsirkin wrote:
> > On Wed, Jul 01, 2026 at 10:26:26AM +0200, David Hildenbrand (Arm) wrote:
> >> On 7/1/26 10:18, Michael S. Tsirkin wrote:
> >>>
> >>> So on this idea. It might not matter. What I had in mind is:
> >>> 1. run the current logic
> >>> 2. add page to a list of pages to check, then invoke e.g. call_rcu_tasks
> >>>    (or call_rcu_tasks_rude) maybe
> >>> 3. in the callback, recheck and if poison cleared, go back to 1
> >>> 4. otherwise everyone will see the bit set, remove from list we are done
> >>>
> >>> it seems to not regress anything, and for the rare race, we set
> >>> the bit eventually.
> >>>
> >>
> >> So test-and-set (and friends) would also have to check the data structure that
> >> remembers bit to set/clear (and possibly update the data structure).
> >>
> >> That does seem doable. Do you have a prototype?
> > 
> > what do you think ;) post it?
> 
> As RFC please :) [and if it's AI generated, obviously properly reviewed and
> reworked by you]

I spent a bit poking at it, and it's hairy.
The issue is that we have calls to both set and clear bits.
When we record them in a side side structure so they can be retried,
we have to carefully record both sets and clears and their order and make sure
they do not bypass each other. So if there's set already in the
structure, we need to take it out of structure and only then add a clear.

It gets very hairy because we want to set from NMI.  So now we can have
clear in the data structure and set from NMI bypasses that. Now what?
And set from NMI can't be 100% safe anyway as we discussed ...  Kinda
reduced my motivation to try and make this reliable at all.


> -- 
> Cheers,
> 
> David

