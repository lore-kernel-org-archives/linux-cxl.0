Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB527A929
	for <linux-cxl@vger.kernel.org>; Thu,  8 May 2025 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746717172; cv=none; b=pdS4OXlsl1dF0eLCdr4uoX0Z4dW3lJTd+r4rU6E5vGxZA3n2Y0n2R91De97F6ly44wQcYYOWgUoMCkCMic2f4K/kQ0WtBQuWJ6LiJv3e6OIQaDr1lXObm1Xg4zvssuyLP2eFZL8yV/jPJhu+G/iOxeF3um2XaxClSvpH05V4SL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746717172; c=relaxed/simple;
	bh=uatJ3LjI7n/uabCAjuIYn6Er8jrNtyMyLiYlf1tPvgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajoHUKDfWNKAmGzhWORpN8ovebEha0B0EZvHNHZpb04JAwfPgvtA8CVy6+G2reoGXzYPDQXjOXmllr2h6d0Oo5NoA4NT6kXRsZy7c3np5VU56mz+Bgzer6VOOe1aAziJiOnICnd5vGfp36HtcMBei6Fdcw83JEEn3kiL39jCPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ALR3RiSO; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ALR3RiSO"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72ec926e828so347462a34.0
        for <linux-cxl@vger.kernel.org>; Thu, 08 May 2025 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1746717169; x=1747321969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0GcWz7M9jCTD3vQ092kn0pMggWzRsyQcje+pdvcvTyU=;
        b=ALR3RiSOvovQUHBaxwz8WsqF7SzezW8W/FZBo/kj2mq31/wWkptzH0WBqK+FChs0za
         bvL6pFukOeUfKFySaqaX8NadHsBIIuWVko8XLZC+KQQieV1o74vlXpZ09B6EXvovdR7M
         xcdj9dtrEKZ2jCZeFakQCXeN+2AXVwrnVXg2gCLopY9V3IjuFqdlp7kAW/RwyaqQ+RvG
         6343ZXRI1D46mjcxF+jcJB6G1BmDEocYVUFkp869JO3aCnbDDE8jmeNlTJLdC52QJQM6
         hcdEDlRolzllAzdqRTM1e+1FN6+HsIvU5SZjgFalvguztRpj2KzjoiMd4qGAuPWYvING
         XhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746717169; x=1747321969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GcWz7M9jCTD3vQ092kn0pMggWzRsyQcje+pdvcvTyU=;
        b=FhY2EEjuOM+W4A4Uo/ak4L35FTyoJ666ZjGCNB08qDm1vUAOJpt1tE5W4bJnfKPbtn
         F8O5X8y7gbr3bj8zWvxFCafcyzR7Pw23otsK0rZ0fA4p+Re8FCCWvjdlUl3KDc2EokED
         UODtaSEjFHhlrWvzxWcNqjs+lKaXOWliQck6/6RMzZEGqDmmLhyl0t0wvtMPfqgY6Wbh
         tp4v3K1MhYn7Bqd9S0/I2nwNJIOpvaufnwTBl6TttCegSQxqtOqHkKkbfzTpF1lt4f7Q
         m1W4IwkjwsfhIMy7Og4whwYn2a8gA2F64QIXPn4D+FbvjNIXAn2YijAvaOzZ2e153ja4
         ZR8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeh+DGBIo/KtrCDUxW3DXBYAuHeLwcx7XQTjRYCT428ys089DmaL0wxR3qMp+ufn6/Y7Ngi9K4fDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXYiq9TQA8Fe0kL8S/hLwbV/GChoPzGa2hjc2Z6CBYplsDds53
	UntvnuGWFVV6wz73lhIqvOYha1hJmE3Qr3JT6ipq6mLFHx9CHcDA6tunfnQafKOgZYUjQV2Ukul
	O
X-Gm-Gg: ASbGncvclGO18CTM1cqbaCeV1yFRqs2NQ0aNiRHjGkkcTVdH1twyOoLCkKZY/pll/jf
	DKcodhCt9EzfDkX9Y1P+5HVKU3IKdBoPc3n1p8/mWK1D+360nmcE+yYPtuOtsKqRJWuf7cYOl2Z
	ghp11ovwuQP4FUQGxHg9pzTggDDUgWSEo88LDaMfBj7KnnbbOPlMJCRb1RqYDOBVy0gz2R3auUZ
	Uu7dLb1L/nKNirv0jpgFaCgWeF0fySPR6pFGERzz7oKMNo+mXVOpbFKlBGGwG4ga0oqZbzkfHMD
	SbsW4SPJobEsfF4doWStBWIt0OfJ45UuHF+Gx1mVSP5JQdngxs3LVzIQzXt7LeCpMQ83HjcqW7A
	5Sj4IRbZDrmcCUEQ6BjJG
X-Google-Smtp-Source: AGHT+IFrmotMhA/nMZAIEBB7GeHwIixjZIq4w08j6/K6MLvI6ZRzQvIIQBKip5mAFrzBQzYq229QKA==
X-Received: by 2002:a05:6214:e8c:b0:6f5:e0c:b203 with SMTP id 6a1803df08f44-6f5429e89afmr115651736d6.11.1746717158264;
        Thu, 08 May 2025 08:12:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e3a60eaesm705496d6.122.2025.05.08.08.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 08:12:37 -0700 (PDT)
Date: Thu, 8 May 2025 11:12:35 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: joshua.hahnjy@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com, ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com, honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [RFC] Add per-socket weight support for multi-socket systems in
 weighted interleave
Message-ID: <aBzJ42b8zIThYo1X@gourry-fedora-PF4VCD3F>
References: <aBuMet_S1ONS1pOT@gourry-fedora-PF4VCD3F>
 <20250508063042.210-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508063042.210-1-rakie.kim@sk.com>

On Thu, May 08, 2025 at 03:30:36PM +0900, Rakie Kim wrote:
> On Wed, 7 May 2025 12:38:18 -0400 Gregory Price <gourry@gourry.net> wrote:
> 
> The proposed design is completely optional and isolated: it retains the
> existing flat weight model as-is and activates the source-aware behavior only
> when 'multi' mode is enabled. The complexity is scoped entirely to users who
> opt into this mode.
> 

I get what you're going for, just expressing my experience around this
issue specifically.

The lack of enthusiasm for solving the cross-socket case, and thus
reduction from a 2D array to a 1D array, was because reasoning about
interleave w/ cross-socket interconnects is not really feasible with
the NUMA abstraction.  Cross-socket interconnects are "Invisible" but
have real performance implications.  Unless we have a way to:

1) Represent the topology, AND
2) A way to get performance about that topology

It's not useful. So NUMA is an incomplete (if not wrong) tool for this.

Additionally - reacting to task migration is not a real issue.  If
you're deploying an allocation strategy, you probably don't want your
task migrating away from the place where you just spent a bunch of time
allocating based on some existing strategy.  So the solution is: don't
migrate, and if you do - don't use cross-socket interleave.

Maybe if we solve the first half of this we can take a look at the task
migration piece again, but I wouldn't try to solve for migration.

At the same time we were discussing this, we were also discussing how to
do external task-mempolicy modifications - which seemed significantly
more useful, but ultimately more complex and without sufficient
interested parties / users.

~Gregory
