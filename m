Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35871D88BE
	for <linux-cxl@vger.kernel.org>; Fri, 21 Mar 2025 04:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742532808; cv=none; b=EeYonruicdXz9iIXrM2ows4F3pntfKaFxBdjYuAdasWr3FJY99u5llUw+yTcAMTV3C59zVVss6F2Ril3clNJCIv92V5jccoD8RtVah+UgdkuX0BqhzqVIn3Fy5OkUi6wUm/V46HCLxn6na2XdgbPj0ArwppS+9cOEgIULJEgT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742532808; c=relaxed/simple;
	bh=8wjCsg0Dy294/vzOad6sb69pancKfSE93bXBiKtMzyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WByrdf1I2tVrrweNQvp3VpwatX3agRtQ4TFNAMadvv03EFmcZCj3q2qaYPUVvgKAJpX3e+iRde0bLD95wmShN6K7mWArT0lahqbj2V8eR7ix4q4glKEDIszcZjKrXhjQrkAcATs2EJp/yFkJDl5FxXBqm151UwegXvc3rc6qw8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jkMc9QBy; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jkMc9QBy"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e8f254b875so14088846d6.1
        for <linux-cxl@vger.kernel.org>; Thu, 20 Mar 2025 21:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742532805; x=1743137605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nbzLWCTpNb9s8l8woW8btRsfZA3DuSpJz7B/kKMTLr4=;
        b=jkMc9QByfL6lp4W3YYEK2k3zGZNFg2hc6BhghRqIgIXJSqLR3TxpTokS4FFUqfRD9/
         QDUYkd0LDNJ+r5heTGk0XtNcli20mH9jRNfFRPWWDc+DIz6WMZIcXcsDJr+EYN0ykfCt
         VjqoZM4IAHBGSk4Ng6Wk1/O9Wrj+/Gj9khRJszxKGxqt3FI3bCHqG4ZYoJlM2kO/bBgR
         w908d3voUPKImFboN21p7hme75kBiVAgF1qZ6C/kFgSeq8N+Ot16rwpaeb1MrngK5/h9
         W2DrXaBUhwi9Vr3b7slPdSLYh/FtrTRoYN2IQR+Dn9x4sN01T/vqpEG32npYy/A74ab8
         IeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742532805; x=1743137605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbzLWCTpNb9s8l8woW8btRsfZA3DuSpJz7B/kKMTLr4=;
        b=mSjl+6TiV3UCUbSCgk7tWNSa1okgsIbi9aG87mboSTVBc/mhoj0PYVq/3567CySUpN
         L9kEPCuGjGkuChALTf2eMYZJWcjCp4yLXHKi24mi8zglixsR0ZHNZ5/l6I0QR6O9UG6M
         sXnXVmLVs5OHL9Fq3W8fUpo+VDzdETVi3wWYjBv1sJUZ5DM0StpC42qvyD/C5o07NPjw
         4Gz+Rvs6KQOdPboIEWRbIZiJxj5HiUmUjrKvA91H5pH7xh55wUQFv5s8TWXJkMX/3Dpp
         bRyTjfP03XNZbvt70FTVeYO+udCOYYSqErzDxf/+ItQSv26op8NnU2/xhl7D+jovXEQb
         m+0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCuJzafL9skNem6wxx6NwEKM/FRg0hvoxYUkHRctLiKaXSZC70IoEkpjAl7hLG6i13k+Pj0nYS7YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF5w71Yb7TKLYGMNrZ2VKZwcSS4pG739ntx4qQWq4BAAm8rV7Y
	bFQUlU4rgA4/rn/SPW4o7CONUbsKVgLFK6Quc0RuiFTQdYTcV8i3v1x6Z3oxCLs=
X-Gm-Gg: ASbGncu+ZgQdAbWl9oKWVbTq4beJworzSZs1h3EgjNzqZKqWm1fmzQOxfkuQSaoAfaN
	0o5Mn0jx3cgYpmENxdhEx+AFOy4stYv9ey0vI6ATqVG7OvhR8HksfTsUOXNF0hwlp6RXp08YPAt
	AqCrboGb+s2dFnhr56v5E8XHgZlFklqpAdfglJGw+rBRdS0s8pm3bWJofnekvDDfFq/Myar8L4B
	e8WZXOf3I6WCf3yuSSm2ixe57e99ttHa7XeP2iNnnBEzB7WB2ipAp4Z0MB1n6TZzuhJoe1BIwMb
	rjWCbKPNQOnufkEtu+9qBeF/Mfk38A1MnvPrsnQeF6iZsK4I3hev6RthfC+KpmX+BMWrmD2NK84
	s/eP3CN5jjr4BRIDGlW9K8/x9WHU=
X-Google-Smtp-Source: AGHT+IGVL/LUMypx3aMhAzZdqNqW3DtQ7i5EEKUs3LjZvTQziSUDTdQgaVCU0DtLDh9wUbOPLCMkLA==
X-Received: by 2002:a05:6214:20c8:b0:6e1:6c94:b5c5 with SMTP id 6a1803df08f44-6eb3f26e984mr33048466d6.4.1742532805513;
        Thu, 20 Mar 2025 21:53:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef1f5d8sm6903586d6.45.2025.03.20.21.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 21:53:25 -0700 (PDT)
Date: Fri, 21 Mar 2025 00:53:23 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, david@redhat.com,
	Jonathan.Cameron@huawei.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v3 1/3] mm/mempolicy: Fix memory leaks in weighted
 interleave sysfs
Message-ID: <Z9zww6ClrqH7lFom@gourry-fedora-PF4VCD3F>
References: <Z9xJdP29XEz6CljB@gourry-fedora-PF4VCD3F>
 <20250321043701.928-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321043701.928-1-rakie.kim@sk.com>

On Fri, Mar 21, 2025 at 01:36:55PM +0900, Rakie Kim wrote:
> 
> Patch 1 and Patch 2 are closely related, and I believe that both patches
> need to be combined to fully support the functionality.
> 
> Initially, I thought that Patch 1 was the fix for the original issue and
> considered it the candidate for a backport.
> However, upon further reflection, I believe that all changes in Patch 1
> through Patch 3 are necessary to fully address the underlying problem.
> 
> Therefore, I now think it makes more sense to merge Patch 1 and Patch 2
> into a single patch, then renumber the current Patch 3 as Patch 2,
> and treat the entire set as a proper -stable backport candidate.
> 
> I'd appreciate your thoughts on this suggestion.
> 
> Rakie
> 

All of this is fine, but it doesn't fix the bug in LTS kernels :]

It would be nice to do that too, since you identified it.
~Gregory
