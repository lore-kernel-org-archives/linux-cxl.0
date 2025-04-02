Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2BF38DE1
	for <linux-cxl@vger.kernel.org>; Wed,  2 Apr 2025 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743611789; cv=none; b=jmvUQo7TtomgLs+/wfrwjOu5HFg0k3wEqbZVncaXOAqgigAOb4EE1eViMzr2qQRgEqQ3nKH7QuGmCCBW34OAY0oQNZvW7mlbV4Jbm1CY/dNRZT1h2St5V1jj+eCAsvSTZVf4A0klzRnS+/uULKUatSwqaQIVjMbWhHE+sMMskwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743611789; c=relaxed/simple;
	bh=34RWo3OZXG4EW/mq5LWgaaOz8jn5vGg8raium3usjig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Te7EXVTx/1ZEpgF4MEXOyXiqvY91WsSIfaakAf5aXUtGIhv+rH+Dozh0+wpELVQzV/DvbQs0WELZAF/ccgmieJHniZ3DGOhHB4ZxSR4mc/wX6Xr/3o2LPqWrI8HsDL2GHDtmedM972mHybLFA3lFjoWI9upqavAX/zZ89Dp2p+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZDrUnxqg; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZDrUnxqg"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c59e7039eeso989697885a.2
        for <linux-cxl@vger.kernel.org>; Wed, 02 Apr 2025 09:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743611787; x=1744216587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KgpSBc4bwmCggwElKm6ARy8yOozY36WU1+SeYhhxYVo=;
        b=ZDrUnxqgILxoq6eUAI6AdPgzCAy5l8+pIK2ACEArbQq2MBW0oQR1/GVKG8qAb63OoE
         dJSQBQIqpuMGtaTmRqjaVnt5vVcMO6oGqpWrR8D55C7EIkgwEeNFnzAJ4R/T3wbtRsLm
         /dOm09FegCnJhXnte2fGtCtoH2GzlORPZw+/YwQiXFr5IMQuYZG8MA/geTwEa53zbzVD
         TnyKeWO6JsG9MYBu7LIWA+XWtJ8m8mxn3A3qe3E7gH6Iwtpp/ugyk5VeZSl4SzOE+fbR
         +6zzulgcxIOEjhKLPSSlQ642oCuYiTDIyAiKxYe8QTAX9CQwUcvkGFY/b1kdeNAkV5c5
         lIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743611787; x=1744216587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgpSBc4bwmCggwElKm6ARy8yOozY36WU1+SeYhhxYVo=;
        b=fBf+DVsnHrWP3yIjYi+eWuIPxCk4gu67iNp8oiLJUxe68d9xOwfyEDtX624+MLT1Rh
         /751GHGfyiGw+hlgkh+UQ6PO40bWHxHuwVEc7Pc+zfI2uRIfsqtQOlrXiBNwZ3fxCSlN
         ODz1Kf5h4Gddi2xGQ8pmv9QQmHHv7uKNuckJV1e2dB/8bp4tnOP3QoDjgUhb2QMkcPNc
         OeO4bSpYPYTVcqbywjIzBDZTmQlc8h8m6TIPXN4oJlQHmS9mxF2StKHBetEP9iYlKvDt
         DJUdqQ9bOleYO400Rc0NPZJuDEKWM/lxcKbC5lwW5zwDXXkmWhTwTmiRcA5ORfnoF8+4
         Vv7g==
X-Forwarded-Encrypted: i=1; AJvYcCX5gcdw3X9NtkbfUl41aIU51tEipIYLDDqMXszJN/QaoxS4EtUs0nzhFKR0o5CWdO64tdoLdncCgAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4gi1FfcnVYe8t+uwTYfYGGnGi2+Ne+f6lRyPpuhO53bvpcjbO
	eXiENOA3DMiAtmO6uIICPUVvMFu6ddw2rNcIkCHVltx1zg6LMOR+/TFQSS46F3o=
X-Gm-Gg: ASbGncs/U3QqSa6K2ta+EwVNL4rp+2Dos3d2QVTkSdqSGSOjDOF0xyRfx3Wgbb7QMBX
	OMNuEPqtRDdqKbpjd4f/gYJB3glK3eT6KBso9q2XuXzY8TjS/xz/BdVgga3gRLOU2ZgTPSQNwO8
	Bi6lVhrSF6CdcZcuKwy7VyJsmyZNEK47rw1rgjQsmhYDHTN5JBAaBd3PpsLh1nTMlLTJf9so0Kr
	FQ4kzIIlUjfSqJierI0/etL6pAyUWls3rOlv5WPskZvBRuGbyuzudfzs/WqOARmoL7jcxMbpABO
	yZ+2XTMYCvBQAnX0AEtZU9HZMyxUlglJJL7y26Ghc4rq+5PZ87G2WtDoYKYo4REEggAYAD3+ntX
	Z3HOf2DAWriAwULdt/kmebrkMtTs=
X-Google-Smtp-Source: AGHT+IEI/0jyf6fklqg75GbTJdfuNj+99i5HXBUCPbxpHS67L4ueSNZOE2R7l2jQabFzIRLJMuhBOg==
X-Received: by 2002:a05:620a:3950:b0:7c5:4949:23f2 with SMTP id af79cd13be357-7c6908756d3mr2557731085a.44.1743611786890;
        Wed, 02 Apr 2025 09:36:26 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f779a924sm800564685a.114.2025.04.02.09.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 09:36:26 -0700 (PDT)
Date: Wed, 2 Apr 2025 12:36:24 -0400
From: Gregory Price <gourry@gourry.net>
To: Oscar Salvador <osalvador@suse.de>
Cc: Rakie Kim <rakie.kim@sk.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com, ying.huang@linux.alibaba.com,
	david@redhat.com, Jonathan.Cameron@huawei.com,
	kernel_team@skhynix.com, honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v5 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
Message-ID: <Z-1niNVSTcb9ogzl@gourry-fedora-PF4VCD3F>
References: <20250402014906.1086-1-rakie.kim@sk.com>
 <20250402014906.1086-4-rakie.kim@sk.com>
 <Z-0IlZgYLjogZSZO@localhost.localdomain>
 <Z-1GUrdcOeYQgkE3@gourry-fedora-PF4VCD3F>
 <Z-1axdrOVBYESrXo@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-1axdrOVBYESrXo@localhost.localdomain>

On Wed, Apr 02, 2025 at 05:41:57PM +0200, Oscar Salvador wrote:
> 
> Yes, this callback will be called whenever {online,offline}_pages succeeds, but
> status_change_nid will be != NUMA_NO_NODE IFF the node state changes.
> And you already have the check
> 
>  if (nid < 0)
>     goto out
> 
> at the beginning, which means that all {offline,online}_pages operation that
> do not carry a numa node state change will be filtered out there.
> 
> Makes sense, or am I missing something?
>

Ah, you're quite right.  That was difficult to see on the surface, so
the check in fact superfluous.  No need for an extra version, can just
add a patch to squash and drop it.

~Gregory
