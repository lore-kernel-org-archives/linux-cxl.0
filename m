Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016502C11C6
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767906; cv=none; b=SdtiUlMLYs2FYNFM22TjqUCV6q4th2ZvNJlT86uIx4Kqm2Do/KCItpiPZ/t8iePxa+Pt6Up3noTi7VSbGCs5BqzMwPhrpUqEz1yxQkYQQNyhyGzjER4zZA899Z5uYoBy2E6nMlWT2xZE1shH+76noW3zez5t/gH8jumqksh/OL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767906; c=relaxed/simple;
	bh=FA/uzeodDMsdxlfAcUEoENoZYVSjA2bqP/XHSkZsRco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cn5vQ/UKRi0n6c5W+CyMr7oUmeQWwHDSZ5vl5VVcftJPxXnN/bt9JvELzQWBAccMijp9wRXxA6jrvR+08M76F+yYz5oYhAgys3g7gKbBIoNwPQlu9Q/chQoEEumnz+dF69f1its+YcQaeahQzpcvIhPUizpAKUBvRjThinDYVMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DbeJjZgp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbeJjZgp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782767903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bzdqyZy9DNYqylcD+hVN5qW7Qehzih+rIpwh8CvpRNI=;
	b=DbeJjZgpew7Rc0ZNRFtO0wdP4afnC3flngTGfvGEhg8CutKsPqAIajDZBRN02VCZoFoZRw
	mkjT3oaeYKZ4lt21oraYCfTi+ICH8YdkNWFCENUi474qvqLUeLUdycE8hoSUBdNUIr87R2
	gVBfLkcDelqQhoNDFUmc8MA3izt6BSE=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-aIhjAmu8NV65wEKw6v4ZBw-1; Mon, 29 Jun 2026 17:18:22 -0400
X-MC-Unique: aIhjAmu8NV65wEKw6v4ZBw-1
X-Mimecast-MFC-AGG-ID: aIhjAmu8NV65wEKw6v4ZBw_1782767901
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30ca3374c6aso10265551eec.0
        for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 14:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782767901; x=1783372701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzdqyZy9DNYqylcD+hVN5qW7Qehzih+rIpwh8CvpRNI=;
        b=GIREmuRFL+RWxL7uY6FxwyL8UDT5zVDk2rfqpY65dQIi7umr0Z+uAWGh7jtO5Oop6R
         6OChPUcK+fBK5yfWmFcApFTRFUULpmY7fbM3LNOuy0Ld3SUuZQW1eealkotQ3m8TOLGS
         iOOk/Jo2LNmIDs9/IHs9tqJeaPUc+ThjTOlYRVdZ87J8yBgqe4wONN+2q6i7BhVQda9Y
         adqCm0btWm8K32LR0jsMM9pDWOEOKlRRLLO9bWY3+Jsnlgc84+4tAIOxP1VNmOpF2sO9
         pgfYuUOXAGtBFgUfnAUPT9vwtnXnQ8qIaPIOmCm8xvLNWdV2llA9MfYFnfCrm+ns97x5
         PVoA==
X-Forwarded-Encrypted: i=1; AHgh+RrwoT0o2tM6xWNntxVTaIUf96lLqxgSTDq86q4jGgjQPngGH698JvJ4ddl68My5S91TMfyFCGy8zpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzUHJniqtEECJls6mVrK6xTWL9W6l39plgK/cHK3RiOlEdM8vk
	8OUssucMDLM4eA1w6BBUd23XL2GZqTlGIjhBkjiiOQNX31g6REc0yc9vmp5cFbAenjkxLWP7EYF
	EPRjsQrP0uHgJlCeAVJ4soTXuS9JT74aNd18WiaJc/KKtMimr74i/W2tBplPePA==
X-Gm-Gg: AfdE7cmwskao9hfPIKGfsVifBsCmVhWLYOfKzD2As29CEsPNSOkxiE2wT/fteorylxn
	kuY/fxPOw5pcVgRGMeOjatKfc/h8J8qdXAQU9ACVfzKNJ2tq9wxECJFdiuV7Oib3tdHfNWmyBhT
	9a2LDfE3W2bNHVVu051sKhp7hp7riFxvN6I0eQxSgs8dJkEmFSabiOgipME3PuvJv/f4WiX/cWl
	ddkGIAg7vRM8VdAGRaEw7hHrSBv+p9WDC+Te5ECSRI6TY8CocRttaTTaZ0EHyy4tAogYHgWi3o1
	EzJldgNzIwAu0O256jOd5ZoMtcyKuOm34d5QL95MQszDeY8uYtjUC/7wUDmAH17mo6uaeRZ1nHe
	e3r0SkgUX0RkWIGqIqgNZX/pxAgoykjn2
X-Received: by 2002:a05:7300:8b22:b0:30b:9b64:4a3e with SMTP id 5a478bee46e88-30ee121a822mr831115eec.1.1782767900949;
        Mon, 29 Jun 2026 14:18:20 -0700 (PDT)
X-Received: by 2002:a05:7300:8b22:b0:30b:9b64:4a3e with SMTP id 5a478bee46e88-30ee121a822mr831042eec.1.1782767899621;
        Mon, 29 Jun 2026 14:18:19 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5ed29sm1122815eec.1.2026.06.29.14.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 14:18:19 -0700 (PDT)
Date: Mon, 29 Jun 2026 17:17:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andi Kleen <andi@firstfloor.org>
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
Message-ID: <20260629171727-mutt-send-email-mst@kernel.org>
References: <cover.1782676497.git.mst@redhat.com>
 <0b5f8b4b-d7dc-4b79-9555-a5b36265f3a9@kernel.org>
 <20260629030657-mutt-send-email-mst@kernel.org>
 <4f5ba5d6-246c-4430-9737-e8dd8e4c5142@kernel.org>
 <20260629092856-mutt-send-email-mst@kernel.org>
 <akLb3WW1nJBaIBwc@firstfloor.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <akLb3WW1nJBaIBwc@firstfloor.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R5CifpRU1prpsDalf5TT9rRRoQx_q-zPkZSRgYSzjp4_1782767901
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2026 at 01:55:57PM -0700, Andi Kleen wrote:
> > > Or if there are actually more performant alternatives that we could use. (I
> > > still doubt that using atomics is ok in general)
> > 
> > Right now I'm thinking of looking at something like stop_machine maybe.
> 
> There can be (rare) cases where yoy get a lot of memory errors in a
> flood. While memory-failure doesn't need to be particularly optimized,
> it shouldn't be excessively slow or impact the rest of the machine.
> 
> stop_machine is a big hammer that is likely to violate most of this.
> 
> -Andi

We can maybe batch a bunch of these, and do stop machine once?

-- 
MST

