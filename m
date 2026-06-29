Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A55262D0B
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782770424; cv=none; b=hF1pZutRMqM81UkXALfyDztGyaPPO1jC1ymBjSUMqqplWlfuHLQxcEJr/LGiG7/Ab6/Xnk717gpe2mBrr+Rxx58SLm2S8JLizjwtjUJTKB0DsL8dJilqduaObGWgk8mr7odRU6kNHJ3iW/HaloSSRda3iu5UHkTuSPGXuoH08Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782770424; c=relaxed/simple;
	bh=HCpseHZmmX9DHnFPoVhhbk+KBaEoLnFYtLlrwjf2+fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FA3YvOO+WuNczIPijyL1edF51lNFNOg+zDXtlLFI8JNUp/u4FgjFYxzIsS7pgkVF5NZH8ro0/CgFkY/xqXtsGJx6LxWYhVLreS65pAiQ0nodoZYYTmyG8btmEwvaG0Fy0GslXie8S5/EZFfoirekxOBythFDOqrA6tw5aWY01Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKrup0tm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKrup0tm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782770422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iiFXeMjHNJpp99quRxVQ4oRrHIqTG7TQuzkulOWcPj0=;
	b=RKrup0tmuDNBTouDAw5s4eWHTuj3gsczGlCZ+gpIBVbHyeu2wZl57IxKxnPsujEmTgIkxy
	i/aIEr0qiFRShQHag/orANdEOB91BAoCIsOj/HoG9a38Bw7/rrUC8Vi5wmQ+KKs/Pj6pUp
	19OrvzHOLUnlPwjS+ufoWECF6f13x4A=
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com
 [74.125.82.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-Kk4HaZshNkOR4anpfr23Lw-1; Mon, 29 Jun 2026 18:00:21 -0400
X-MC-Unique: Kk4HaZshNkOR4anpfr23Lw-1
X-Mimecast-MFC-AGG-ID: Kk4HaZshNkOR4anpfr23Lw_1782770420
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-138acbc0e69so18080253c88.0
        for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 15:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782770420; x=1783375220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiFXeMjHNJpp99quRxVQ4oRrHIqTG7TQuzkulOWcPj0=;
        b=fE7qk5oaNgqoo9GZZ2u4DAqO8MN9IAzugGAzclIxrz2yAarQ5nDbK1fX+Bxq0lYPs7
         7GeQ7W/UZBlMya7FQAFEwk7NyvSnZIPoqEJvTl373Q61CCvmjTN/5ogzvFjxtTnHdEGn
         S+qOMNl7Hl2jJ/OO+1tl9c/pL4oqpTxA/Lbu3CbqE+ozAX5jUaX/irmnpTqSGRcsxeDL
         iWtAfYdEIDq/Z1E03bEilt7DdnEMJtg8eJdvRuj4/7zgQpP4vyk4dFr0mBfB08KdnIiU
         rwEDUJDclUpLu5K8IuqVOwH+ktmJvZm5YNjOaNkWbFPUgG9pGXJ9Va6eWvEivEuuGlh8
         bTpA==
X-Forwarded-Encrypted: i=1; AHgh+Rr5FF3Gf/KjSpWefSbr6lan8Z0U3pW8IyELVP0nxYGYHwlfYtnHOg7Gvm8pG1aHQZ5QmLCb7/eNXpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW4hiJp7f+6LfjMJOfWB1aSjnnxNgykH5CDObdpAdsJxyrifC5
	xRpdPV7YrlSu8pMxyGOcSzpO/IOgLrJR+/+5XkGKAqjdQTAIhvUq9D+4nutF4upNv8ERuaMGpci
	N8YWyKLtSTy9EznAynis/eS/HQsO/n87jbOE0QkQY2Vjbnmw8O+GLCgT9QtFPVw==
X-Gm-Gg: AfdE7cnM2/KWVLdbOR2jgosBntp/ISN8js5qB93vsmDarRy0EzcGgSS/HvOn77v0EnU
	tvFeakAc3/Xb2aE6X/ZFgRFRJyohQvyrIAwM40T4P/f1feAlvIJEiW5FPS11w1sfyfzHglw/cc1
	ObuS5+l0KYHGwFAlNnq7yNmBfWd+QSDrK5mcKa721Myo7iWlroC7I0Cfn4nhzvvxXHetvl9OlHt
	czbBrS8tFsCmjyP0RwBmbeEmfPUUdIzd3lAC7643mnq5Dd9Yjs+Ah/9CH4dRiSZ3xs01lQB+5Af
	mKkkVJ/20AL5ZnAAZJQB1tS4Z46W0Kg2VzMXBahlWseHqNVMZTc//DDgAMeOPdUhghwGysAyPWa
	13WV2p+S2z70SD+OBz8H6b3olgjreD+Ul
X-Received: by 2002:a05:7300:2141:b0:30c:1865:d9e0 with SMTP id 5a478bee46e88-30ee12287a4mr843057eec.16.1782770419915;
        Mon, 29 Jun 2026 15:00:19 -0700 (PDT)
X-Received: by 2002:a05:7300:2141:b0:30c:1865:d9e0 with SMTP id 5a478bee46e88-30ee12287a4mr843010eec.16.1782770419124;
        Mon, 29 Jun 2026 15:00:19 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2fc12e7sm1126539eec.8.2026.06.29.15.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 15:00:18 -0700 (PDT)
Date: Mon, 29 Jun 2026 17:59:55 -0400
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
Message-ID: <20260629175638-mutt-send-email-mst@kernel.org>
References: <cover.1782676497.git.mst@redhat.com>
 <0b5f8b4b-d7dc-4b79-9555-a5b36265f3a9@kernel.org>
 <20260629030657-mutt-send-email-mst@kernel.org>
 <4f5ba5d6-246c-4430-9737-e8dd8e4c5142@kernel.org>
 <20260629092856-mutt-send-email-mst@kernel.org>
 <akLb3WW1nJBaIBwc@firstfloor.org>
 <20260629171727-mutt-send-email-mst@kernel.org>
 <akLmILr-cbl8Eqq-@firstfloor.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <akLmILr-cbl8Eqq-@firstfloor.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _YvKgc6uCjq88DOzlq5MRjuHF0Ok4S-4KOq8KaoolvY_1782770420
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2026 at 02:39:44PM -0700, Andi Kleen wrote:
> > We can maybe batch a bunch of these, and do stop machine once?
> 
> If you add a long delay you increase the risk that the machine or
> the critical process dies because there is an unrecoverable or
> process killing AR access before the page can be off lined.

Well nothing prevents us from opportunistically running the MF machinery
once first of all.

No regression then?

We then add it to a batch and once the batch is full we do stop machine
and reprocess them again.

Hmm?




> 
> (BTW that's a problem even with the RCU approach, the cure might be
> worse than the disease)
> 
> If you don't add a long delay you would do a lot of stop machines
> on a flood, likely bringing it to a halt, even though other sockets etc.
> might still be fine.
> 
> -Andi

