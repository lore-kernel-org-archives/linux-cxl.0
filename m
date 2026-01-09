Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA373659E2
	for <linux-cxl@vger.kernel.org>; Fri,  9 Jan 2026 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767978233; cv=none; b=jCmPOl14X1ivVWr/mlW1kCf9DFGIFMWS7JfGU42ut7VAxLVcomeGlwjz4gezR0wNqk46Dcf65IUb9gi0syXKQE70HosTiL82SqJBt6QOXzJTQqv0FvMmmy6IVOPRnowlBv+knUNE2FIRDr7TUTCB1EwnKMYiWgdHnS28tn5FL8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767978233; c=relaxed/simple;
	bh=aXxH8KsFvCOcvxGrWrHWB8GtMC6vSUV/Y2dfp44NGeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyNNr1vyTxI3zmJsT+l8eig3CdBoyMX1KYVzqFK/PaTtwLaYZ9SQifVBxeD8+ItFBy6/0rTkVttmS02Y297S7rk9U8YtE+LSmqq6ucHX1rRaEa3IzCXIgru0+EWXOz2yFcGogSWJJxaVASa8h2eBg4ILPv0CQSqQLH33VEx8Qe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ceboVegt; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ceboVegt"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78fccbc683bso50740457b3.3
        for <linux-cxl@vger.kernel.org>; Fri, 09 Jan 2026 09:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767978230; x=1768583030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oyvnXFALVV85dAj0zPDPAtv4QErhsz/aJNW7Eaaf5yo=;
        b=ceboVegtXCbOvmnNp2QmNW0oW6yOL+fOvMlu7QSUb5OKOXsY4gmoTlqnOdcyGyFOh3
         ljn1LyUtiDHlU3YI87wJgJxraydAh3esLo6vpHOxwYpSYVZ59YcaeAAivzmoGdCcAe/H
         SWqg6sHST3ebJsJblSLiodDIwpcJpflVJLh3gSPSYqqN5y0bYx6WJKiRCWe3F3vxkZi0
         yJeoThQxo+ls5W5NZtwM+I/2nurnTsH+UzRVh7fV9fFvxbBuvFmhu6eWvQNmi8ShWRBJ
         UEW5EHDLVmLx/QXv1eP1ru87TF7xf2jfQJzsUb9jNt/sbJvG1ZS3TcGr5XEHlqieR56t
         C9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767978230; x=1768583030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyvnXFALVV85dAj0zPDPAtv4QErhsz/aJNW7Eaaf5yo=;
        b=eGRa/EXOlngJVHKurH2vrWR11mRnL2wRCvNeGlFmP0unclDyU8czSSIyUXeOGggEGP
         ekzwU0SpSjkWjhNSh1uhjgVGqhbo1QXd4p6kIzhEGH/MXhSe/2xzOV4H3KVXWfu/pzLN
         iPFr06mAZINloWoRMPdUL/Xs5Vp52wh5pMtnjxMZxK49Nty+Tyv2ojSYv1XwfmuZJG/7
         ICpaZZaYjRbgobYV0AaAnquHY4qpoKhMJ9z4u/D/SV6XFsUB9Aur2I+qVS9nJ/C3Cv4+
         M+4g6QzAFQ9bJlhVkYmO1sE3oFaAhYVGYpkE98LBDpzbHVtwArYtJhCudOqGxoQBESdd
         09Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXh+S+xpC90eq/NFVOKikl5dggpLtyP2Lt9Lx/Hw/qbO3ou4vZpve1SE9hib5OTb4wjWgGFvOMekoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj3KUc2ErPkrstBVktAl2uzDPB+pVpkopVXV7w+l36t5Jl5X6p
	g0raRDuj1G1VEdH6wkJhuewE1yWvpCypbb4guULxlWczL4ReDSau+m+zUxpivLmxv9Y=
X-Gm-Gg: AY/fxX4jvMAA6oyqNteikgzwppPKrz2TFXMpPD5BySOJRZONcMpvCOhWavHgp4YOp/7
	2YLa1Kx6mokk8DZ03ANaMbiTlo93I4g5NCcJLBlr9uE7FxECK3peo+xBRyUV/ZEh5ILKxGuNhff
	skcs5uqoyxSYGKOqoNfwbVPp1ftmDa9TmgVcfgqEArIlmb/O3lI6INV2LOgEmrK8fdKKkg41MVe
	X0ujEBU2XCb1RW1cSlr66EPYPF7sDSyeaR80JmMkZwx9fqJ2j7/YvSU6amoaip3JszeAsjNU2Yk
	1C80f4fWRkdzalrIg5tyjsE/8GMMlegJVKNNERB6tghPvFf/+rO/HNmlAiH1ujoWFUmU8nH//14
	TYVQpyOPlF33FKlgKF82+BA468taqFrS6U24WMzw31l1t3Y/u3bd7pD1wWxrX20fdMPXHm7nvJE
	4uBdVilpvrHAvRCcSbTz6h0zdtVaDGcFVWOSw8eXhqwpjISBqsZFCmJ9PeuBGZVLbo3SDUKg==
X-Google-Smtp-Source: AGHT+IG5ur4wn6WRv+wDPnOobb9XgNDN4tAmFs6v5FHNYg3NZYd4D74cNfEP3p2oKp1wSQ0Qs+dvkA==
X-Received: by 2002:a05:690e:4106:b0:63f:9cef:d5f4 with SMTP id 956f58d0204a3-64716ba363dmr7881450d50.36.1767978229938;
        Fri, 09 Jan 2026 09:03:49 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907710632asm77625366d6.24.2026.01.09.09.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 09:03:49 -0800 (PST)
Date: Fri, 9 Jan 2026 12:03:14 -0500
From: Gregory Price <gourry@gourry.net>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, corbet@lwn.net, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, rientjes@google.com,
	shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev, osalvador@suse.de,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 7/8] mm/zswap: compressed ram direct integration
Message-ID: <aWE00tFHjyXnNmtD@gourry-fedora-PF4VCD3F>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <20260108203755.1163107-8-gourry@gourry.net>
 <i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>

On Fri, Jan 09, 2026 at 04:00:00PM +0000, Yosry Ahmed wrote:
> On Thu, Jan 08, 2026 at 03:37:54PM -0500, Gregory Price wrote:
> > If a private zswap-node is available, skip the entire software
> > compression process and memcpy directly to a compressed memory
> > folio, and store the newly allocated compressed memory page as
> > the zswap entry->handle.
> > 
> > On decompress we do the opposite: copy directly from the stored
> > page to the destination, and free the compressed memory page.
> > 
> > The driver callback is responsible for preventing run-away
> > compression ratio failures by checking that the allocated page is
> > safe to use (i.e. a compression ratio limit hasn't been crossed).
> > 
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> 
> Hi Gregory,
> 
> Thanks for sending this, I have a lot of questions/comments below, but
> from a high-level I am trying to understand the benefit of using a
> compressed node for zswap rather than as a second tier.
>

Don't think to hard about it - this is a stepping stone until we figure
out the cram.c usage pattern.

unrestricted write access to compress-ram a reliability issue, so:
  - zswap restricts both read and write.
  - a cram.c service would restrict write but leave pages mapped read

Have to step away, will come back to the rest of feedback a bit latter,
thank you for the review.

~Gregory
