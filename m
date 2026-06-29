Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EC438910F
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782770106; cv=none; b=KC9/Uu19CKB7JlM6CCvaZ17t0GS2WOvJKod9umAcUq2ajbYLsSVECOc95AeFUYjoNnjXjVGy8pPOEatkzaJzhmmHVrkkse8+YdGquTBS7chmgUh8ZqsJ7Li0otOlyWyA4/Ggk9ylkebahSw03jqCPe9GA1ZrDcU4yqOzU8plTuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782770106; c=relaxed/simple;
	bh=VDgDSJO8CDIoGqsrXHZc0Od+PLCr4QGMmZyVL5BpI8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=r2ZZ/5KgzGiSQuXkxg8jYNyv5DNPnbLtBYRymKy/vo53Y499V1x5PRk+WqUjD39MIyQ1ykTBuaqyFYvNcQqeyAzNAxThp4ZHnL8Qgqnb4/9Oi6Qa8cyzESfmwv8rEEa6RJvnRNw46Oy8VQztoXO6z4+AZ25urolPkZNpMxwyBqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQdRyOaD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQdRyOaD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782770104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q/gDMLrONl6W06ywIXxs1piiNp16Y2gD10Hb0jLylf0=;
	b=IQdRyOaD5xdl7DJBsyXxpkThX0YBrMeYj5bvWZ0HhVVhEhNLNiD9WBBOvNcSScKRuiJNzj
	XD/DD37XuF7JWSMc6Et4PdAr2ygxAybWRUsdM3mnBqVqJszaWGgiThII0lcZqvTlRcYdyP
	MFvLUZG1cMm1TciXvOJNms4UrkMxrbY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-6Kakl5FFNBO2pbgIEwFbtQ-1; Mon, 29 Jun 2026 17:55:01 -0400
X-MC-Unique: 6Kakl5FFNBO2pbgIEwFbtQ-1
X-Mimecast-MFC-AGG-ID: 6Kakl5FFNBO2pbgIEwFbtQ_1782770100
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4924207e640so31791445e9.3
        for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 14:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782770100; x=1783374900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/gDMLrONl6W06ywIXxs1piiNp16Y2gD10Hb0jLylf0=;
        b=G6pl1Sca+/9AVHhGaMpfRqMddhh0xg56fM/rfeRCxkYEFt3SQe7NGpOlc/vCfcn6c9
         1hI/Zw4SJuoZ6XZh+JcgqE91b/b15j/tB3IGP885Z69FhUG4Jn/ZZFJPsRyu/ZrBd+/k
         kB2eXSnzMVeQMJQeNc5e6mCM5ZLejlskU32MUw2UaEkAhBRprfJXbSUwEoxolc91yGN+
         9Znkhp3TNP3hccTM0oiCkH2C3iypIlQmFp1HYC6acI1CHfY8wjNIou7MpDVb7dVQRgV8
         EI7eOtUY/7w/99UVV0HxLMNH0/o68+mselZF8P3QHzv/p4ARXwDPF6wwnb2uCf3xP4BT
         AkgQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Z767Y9pRZq2PabO940ucjt2BHOcUSbhHgUxJU1wfc8fJe2rivuxR/4UYjXKEP6O6EvbE16qqobU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNf7VtaryvRG8fodZqYV+vpCWdF/RR84c+Jta3IbDVkBCEolZv
	QkJpfWDSQ7U5MM2+OpEpjqWl7+XcrRJ4VAp8DnhtH6MnYuJu5O/GiyT0tERUlhFn/ZlxRa+P31r
	uT1J69dRuwhB3P8pEr13kHPyZrGEimRdxh/5e5rRw7cO/AhhdarNMXi1WzxmQdg==
X-Gm-Gg: AfdE7cl2uBEtxHenBfcOKVfYJly6QhRBVNUXMlELXD+G+t6PknoHu50azBACJUBSIA/
	H78Y9SVpMeX2A+s5kbZdzcjEuUVkZfCfk9eNjBYAS2pBJd+2u2TmsGsdCTYz1B4/egGxEhJcxBQ
	cUeHjo+ffCoJC1HWCF3CSyb2tpcqjhPJyOCm3I3q/nc3Z/5x5NC8FLcZ3g0GwIrJVgeFHqQXyPY
	KZkeSPJAWOyZGYmRcw6wmZSAvDU34Mk2kIFcldfEvTmazei5ytueC/8GIgaXR0Jy4UcnFIXvvCx
	Pg3q2CpBNm0bd5R49+cXjk9YwRU4nkJ+IU4zMP0ViZGWK4nYhCVY3uM5dSGo6dNLPpoT7e53UqA
	2V7nTwTtOCIHxl8rS8H+0IZs+z97qsafZ
X-Received: by 2002:a05:600c:46c9:b0:493:b24e:649b with SMTP id 5b1f17b1804b1-493b827c8ccmr19350185e9.6.1782770100193;
        Mon, 29 Jun 2026 14:55:00 -0700 (PDT)
X-Received: by 2002:a05:600c:46c9:b0:493:b24e:649b with SMTP id 5b1f17b1804b1-493b827c8ccmr19349615e9.6.1782770099527;
        Mon, 29 Jun 2026 14:54:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8c7b82asm18608955e9.8.2026.06.29.14.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 14:54:58 -0700 (PDT)
Date: Mon, 29 Jun 2026 17:54:54 -0400
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
Message-ID: <20260629175149-mutt-send-email-mst@kernel.org>
References: <cover.1782676497.git.mst@redhat.com>
 <0b5f8b4b-d7dc-4b79-9555-a5b36265f3a9@kernel.org>
 <20260629030657-mutt-send-email-mst@kernel.org>
 <4f5ba5d6-246c-4430-9737-e8dd8e4c5142@kernel.org>
 <20260629092856-mutt-send-email-mst@kernel.org>
 <54c8cbee-9b26-458c-93ba-5aa594f5d1e8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <54c8cbee-9b26-458c-93ba-5aa594f5d1e8@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: amDRbYFj9XPdKmrjYE4Q4_81z-VB_OYjL6FyFH3Vvfc_1782770100
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2026 at 11:22:11PM +0200, David Hildenbrand (Arm) wrote:
> [...]
> 
> > 
> > And again, I'm really not sure fixing a theoretical race when memory
> > is failing is worth slowing the world by 0.1-1% for.
> > 
> 
> Fully agreed.

Let's say, we just send every bad page through MF machinery X times,
and hope the chances of a race are reduced enough not to matter.
WDYT?


> I was hoping RCU was cheaper (I mean, we were once told that RCU
> read side locking is essentially for free ... well in some configs :) )

It seems to be, just not to the level where you stick this around
each memory allocation.


-- 
MST

