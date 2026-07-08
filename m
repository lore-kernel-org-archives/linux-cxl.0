Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F060721ABB1
	for <linux-cxl@vger.kernel.org>; Wed,  8 Jul 2026 13:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516136; cv=none; b=BhsdIdf/FH35rNR/NgwPo81SYnVBNJSwqN4baNzhU9OF8m+G5NrqiAGx1Vd8EHKnN4nPLVrH/1QhCprEww7JkODzbQLRH4qmvgg4VbKE5n1kZHSW58pgDd8DG1RUY7KJpzt8hXqUmX3qSTMXa1GtUV4Fv7j1UbomT9I509cQiec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516136; c=relaxed/simple;
	bh=slzcngurpvijPvfNkGNfZu5oYV2DsjS057qVvK8Udik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SLWwLdAXRelzibU5N+Ri95SE2Z04aYoaBAXlWywPE8vB1VX+HMuYscZR8A8pGfpexboKc0d/ycvv3K5xQtm2nDE0mDS/FmuNzkpeuBJBxfQ5COT28UAu8IwUNPvIMxNmOfivTClXhjKikkUY52BW89/FaeY8qgtGloXx6NLaDDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TfDNKzrK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TfDNKzrK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783516134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+rX2CKg5FhtAMYxFR8MmaCVN8SdzuEUH8feY2iANJc=;
	b=TfDNKzrKQ1bS+vwFHUpRelbYRByd4nl4D9A+b4zrcKZoZzkzQGx2skqTAckn+Wq7vapKWD
	GlZiLyqowYVOapRob7qvqJBgw7jeTY+Fo3ym6L+ocR+Sb6AbO4JM+USwxSm2um2y3uQ8c6
	1ijjdhbSkccoFMs82/xJgjW039TY1qw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-QhI76a1ZMbqcyczlad-FFw-1; Wed, 08 Jul 2026 09:08:52 -0400
X-MC-Unique: QhI76a1ZMbqcyczlad-FFw-1
X-Mimecast-MFC-AGG-ID: QhI76a1ZMbqcyczlad-FFw_1783516128
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-46fb9079a04so438826f8f.3
        for <linux-cxl@vger.kernel.org>; Wed, 08 Jul 2026 06:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783516128; x=1784120928;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U+rX2CKg5FhtAMYxFR8MmaCVN8SdzuEUH8feY2iANJc=;
        b=jilFayCyrNtBb4uWEfDDE9RaIfbBTtY/89kjesRuOcdBXgD2/z53cZAta+AJh727RO
         L65XJoK9hq7xWnTk1rfODihpcMC6OZu7OTLQburpJimeoIai9BB4Ao8iDNrnR3t9evfb
         8VGb0YAjYzGowElN4gSMaBO/OaYp+s8x/iqAWc1pI6AOgrQM7RRVmXAYXhUNHeS2F8Cs
         n2tB0EaydgxT3UhzOAn3ouQm3y4Jr8jwQq/mnwhP71kq75TGB0amtbT0A03DngzsQdUH
         sTRVpk8yuG4p8xc4pPcBmOaO/i+1jvwVbtZAotSFshagUgTmfGTnQTxeqXhB/U8Jv+yd
         2YZw==
X-Forwarded-Encrypted: i=1; AHgh+RpNdkeH8M+DToJC74kyZY8McKZVnqFUWf1zrCIpSenrE6QVoob04N4G6PLn+cguJJSXaG64cBCCmfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBtDynqoafkjyW/wP9LIf2U+6BppJza9CcwMRicJN5SIWLayue
	4j3WDl17QU6lhZSuhB0d22xLTkyPLY/VLrrNQEVtozcVc/d79x9GNoaMy8oGjLpPbzx6QXs9MpM
	OxD3E0Gu9ARDBoRKzeh56WQBidJKg7iWgAZnfpZ2k40dPcUyXdbEx1xI70+FGag==
X-Gm-Gg: AfdE7cnMJ15NCCf7G/Apd9mSKHs8voNAFoONfJD3Y25YKoU6IzTMitIK85Q6UbNN0xL
	goIKpJx1iLL+ye+MowoPbRm6hORMGfLBXLqWgPkGK9/ScYZF1ufisyRHXiekdnF0Wx2VHoKhx6C
	COZ+Y7wgQu6/8iZihZnEA8AcNBpCWiZRzlfvGCgxv98UIsv9aH6sDbYVNfYSaqV5/v81Z2+tJwN
	ZIwlxMiaOz4lojYUjdFEX+rDtm5AaPzZwjGC/Yw7TkIrwh+SEn6GmArdcFjrw3WK6icIIm8f7qv
	/JSO3XGN9C4HZT3sMa35Hw1MFewMjJbb69CQ+geSG4VE85PX6l88NL4ugJrpmnDIIt6YWAbKMb7
	7h7WhdjoyKG4XoM/rBwZi5y96//4ZnrsO
X-Received: by 2002:a05:600c:8284:b0:493:c8cf:27bd with SMTP id 5b1f17b1804b1-493e68642c1mr25878095e9.19.1783516127929;
        Wed, 08 Jul 2026 06:08:47 -0700 (PDT)
X-Received: by 2002:a05:600c:8284:b0:493:c8cf:27bd with SMTP id 5b1f17b1804b1-493e68642c1mr25877715e9.19.1783516127480;
        Wed, 08 Jul 2026 06:08:47 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f294a6sm259459405e9.1.2026.07.08.06.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 06:08:46 -0700 (PDT)
Date: Wed, 8 Jul 2026 09:08:42 -0400
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
Message-ID: <20260708090739-mutt-send-email-mst@kernel.org>
References: <cbab829a-3e65-4b4f-a2e2-704e88a611a0@kernel.org>
 <f6d8354c-2f79-4a48-934c-cbeb335765e2@kernel.org>
 <20260630174852-mutt-send-email-mst@kernel.org>
 <2f884bfa-3cd5-4fba-8aa4-c2e68890ab64@kernel.org>
 <20260701041112-mutt-send-email-mst@kernel.org>
 <d2ce93d9-c3d8-4915-a511-d08eb2c1b374@kernel.org>
 <20260701043024-mutt-send-email-mst@kernel.org>
 <c03ec696-d635-4c7f-8c77-89a439d9135b@kernel.org>
 <20260707155658-mutt-send-email-mst@kernel.org>
 <6ec8f683-77c7-4ddd-830c-030a3d984715@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6ec8f683-77c7-4ddd-830c-030a3d984715@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OQ1Fd3eZ9S2JnQJmw6S2sBrwVrja7EbbPgrKgtsACo4_1783516128
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 08, 2026 at 02:03:21PM +0200, David Hildenbrand (Arm) wrote:
> On 7/7/26 22:27, Michael S. Tsirkin wrote:
> > On Wed, Jul 01, 2026 at 10:36:31AM +0200, David Hildenbrand (Arm) wrote:
> >> On 7/1/26 10:33, Michael S. Tsirkin wrote:
> >>>
> >>> what do you think ;) post it?
> >>
> >> As RFC please :) [and if it's AI generated, obviously properly reviewed and
> >> reworked by you]
> > 
> > I spent a bit poking at it, and it's hairy.
> 
> What I thought ...
> 
> > The issue is that we have calls to both set and clear bits.
> > When we record them in a side side structure so they can be retried,
> > we have to carefully record both sets and clears and their order and make sure
> > they do not bypass each other. So if there's set already in the
> > structure, we need to take it out of structure and only then add a clear.
> > 
> > It gets very hairy because we want to set from NMI.  So now we can have
> > clear in the data structure and set from NMI bypasses that. Now what?
> > And set from NMI can't be 100% safe anyway as we discussed ...  Kinda
> > reduced my motivation to try and make this reliable at all.
> 
> Maybe we should just really keep it as broken as it currently is. It's not
> really worth our time fixing basic design flaws ... given that we didn't have
> any report about these races so far :/
> 
> I mean, sure, if it's easy, ... but it sounds like getting more and more complex.
> 
> -- 
> Cheers,
> 
> David

Right. Either we do the RCU thing or let it be. But then I'm uninclined
to even bother with fixing other weird behaviour I see there.

-- 
MST

