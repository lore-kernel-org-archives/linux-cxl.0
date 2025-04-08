Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1900B23AD
	for <linux-cxl@vger.kernel.org>; Tue,  8 Apr 2025 04:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744087666; cv=none; b=XZq7oPkeBbkbGhCE89Vm60NjwwG8DBA5fQJ11vGGgR7F75k6f5qJ2wgoPiJt6hv8pi6JfxKYugdkRkiGcWX1dnMLSfgIWQzyV6BW8dKgmqHPE4x7xBOfLgTVdGCzsKT/WvkSbU517gUOQhwx089kM6AG6tQFAqVxgxKyEcuBW6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744087666; c=relaxed/simple;
	bh=GuLjcVnDVQ0AeQ9zt5C1VHrJ7U9tVdJmAivhmoaHxzE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elw5iwKWZpb1hT2jrpbqeX9y4SdfqCK2MP5XU6jfJxjChFjC50t2VnTsZY+SH9GlZZgNxraQqQDlLcTjpt71grEYCx8QfBafEWDS5N0zwS5iBiE66EnTtqgrtoSy6LcGugTsakX2HirfaW9SK2D57wUko6NBd5GjcL+rOsLPmUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9aX8hwy; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9aX8hwy"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3018e2d042bso3413773a91.2
        for <linux-cxl@vger.kernel.org>; Mon, 07 Apr 2025 21:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744087664; x=1744692464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wXvizl6RATbEjTOKl0CCRHeoPrumOttIJFNv6HPEZ9M=;
        b=k9aX8hwy1vjQCwCeeGX6LJw5v+8Z91o0x36qXwiRd0/5WpfjIOm8AN8A/E+dIdeC9L
         0Wg+X2mxI7qWSsa9PHhHHZNjnrFRB8mRdC+6nlQN4Lpn4AMGpuCClEbhKed8cDwNevxY
         iCPPV4xk+lLyCW3iipj1NTtJddLK+ZPJUvJUMImoXGn7U5CXtzVVJfWNduEY69ZrRJBq
         uIfySDmLz796PrGKyna75bTRCLZ9/yhyf+vvATlAwDcMm75/WTYBWegOEcP5w8LOy84z
         gEzMAUtffIwzavKmC9dTx32oGQ8S2QENt9zm2JTx+F5R5lv4yHN6JQUU3vwJ3i8KTCzQ
         qNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744087664; x=1744692464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXvizl6RATbEjTOKl0CCRHeoPrumOttIJFNv6HPEZ9M=;
        b=u/fd73weXFZvYcxOyF5/CS1WtCCR+Jb8SsHpPF2zo8stTp8khOm02Xt9Yf1lGHzn2w
         y5v8Bd6M1fGi+U9Hc8aVTsqYY2+vw+aGnyeUnTnbLG/KE48GXTtu7K+fKHYHQV/PfEb3
         8HqikTZ7l5ZAaSr/rBY5LVgdaymMVqFuuotG+0MnEJhsIrCpOxqKzY1J+xppIETtXknS
         dZ/tFEEsXn+8J+efzjPZnGy/dNmYgjKm9t1/T7sDoDOadxyOsUvpIlkwMbTMLUrcqMnm
         KWpzRGjvyqZMrfBBn4HQO2Xg/oOUaXXdAbMlP0R7zh4l30MDsxJWMxrZacw7luYFJd+r
         29Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVbgoNjP5FRb2s6DXblJgYJ9/7W0V0SB1hkhisXLhX5fmwTXBI0zuSyE6EPlJePVItq71asS2wxZiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvGJOvDM6Rq6Bb7g+4gqK6ssEi7gymzaptt6KCcjPGZbSyFAHf
	E4qdZVdvstsmEHHBsToJOA9O848V8vFUJmQZYZH+ctfOznJibDef
X-Gm-Gg: ASbGnct2HDI/EeHDmpeFEonIbeoEStSAHuHk/GzO1UZvQ+EqPfgelsq9+Hl4WIlm2Vv
	1fhQCVKuaOEMh/Xo2F7t4q3SGQrdrPOcEzN5p1Ut9jebH8/xoFnArHj3ZiVo63GaYai4LMqGQjj
	6SvtW6KYt+01YkkSTDjqVrnTUfWbCju31cpb7w1hieCmrojGKiPn62f9ByJF6aNnRAhX7rm4DqB
	1hBTzTKLV+1gOcoCjbkQYEXDudpr832QXbjBn6tLqjTtZW7bVCkX5ejscQZmca4WoW+MzrmcjfG
	lHNf/Cf+xS02maAYn309Gv03XqBWvjo0J7kwx+4F
X-Google-Smtp-Source: AGHT+IHJ2jl8VbiUC6NnzGN5Sh1yW+WlVtPUlc6ZoqCLMf0g5TGQqXpf36rMCLvfwE57/UDB0SUD9w==
X-Received: by 2002:a17:90a:d650:b0:305:2d27:7ba5 with SMTP id 98e67ed59e1d1-306a4822f9cmr18912924a91.6.1744087664260;
        Mon, 07 Apr 2025 21:47:44 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb8e88esm10029666a91.41.2025.04.07.21.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 21:47:43 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 7 Apr 2025 21:47:41 -0700
To: Gregory Price <gourry@gourry.net>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Junjie Fu <fujunjie1@qq.com>, qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org, viacheslav.dubeyko@bytedance.com,
	zhitingz@cs.utexas.edu, svetly.todorov@memverge.com
Subject: Re: CXL memory pooling emulation inqury
Message-ID: <Z_SqbdVE9znpRjtp@debian>
References: <20230215151854.00003e34@Huawei.com>
 <tencent_E9F3F01E0D2303378E16505CE4CF208AA908@qq.com>
 <20250312180543.00002132@huawei.com>
 <Z9HheFFgOdGE9BcW@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9HheFFgOdGE9BcW@gourry-fedora-PF4VCD3F>

On Wed, Mar 12, 2025 at 03:33:12PM -0400, Gregory Price wrote:
> On Wed, Mar 12, 2025 at 06:05:43PM +0000, Jonathan Cameron wrote:
> > 
> > Longer term I remain a little unconvinced by whether this is the best approach
> > because I also want a single management path (so fake CCI etc) and that may
> > need to be exposed to one of the hosts for tests purposes.  In the current
> > approach commands are issued to each host directly to surface memory.
> >
> 
> Lets say we implement this
> 
>   -----------         -----------
>   |  Host 1 |         | Host 2  |
>   |    |    |         |         |
>   |    v    |   Add   |         |
>   |   CCI   | ------> | Evt Log |
>   -----------         -----------
>                  ^ 
> 	    What mechanism
> 	   do you use here?
> 
> And how does it not just replicate QMP logic?
> 
> Not arguing against it, I just see what amounts to more code than
> required to test the functionality.  QMP fits the bill so split the CCI
> interface for single-host management testing and the MHSLD interface.
> 
> Why not leave the 1-node DCD with inbound CCI interface for testing and
> leave QMP interface for development of a reference fabric manager
> outside the scope of another host?

Hi Gregory,

FYI. Just posted a RFC for FM emulation, the approach used does not need
to replicate QMP logic, but indeed we use one QMP to notify host2 for a
in-coming MCTP message.
https://lore.kernel.org/linux-cxl/20250408043051.430340-1-nifan.cxl@gmail.com/

Fan

> 
> TL;DR:  :[ distributed systems are hard to test
> 
> > > 
> > > 2.If not fully supported yet, are there any available development branches 
> > > or patches that implement this functionality?
> > > 
> > > 3.Are there any guidelines or considerations for configuring and testing CXL memory pooling in QEMU?
> > 
> > There is some information in that patch series cover letter.
> >
> 
> The attached series implements an MHSLD, but implementing the pooling
> mechanism (i.e. fabric manager logic) is left to the imagination of the
> reader.   You will want to look at Fan Ni's DCD patch set to understand
> the QMP Add/Remove logic for DCD capacity.  This patch set just enables
> you to manage 2+ QEMU Guests sharing a DCD State in shared memory.
> 
> So you'll have to send DCD commands individual guest QEMU via QMP, but
> the underlying logic manages the shared state via locks to emulate real
> MHSLD behavior.
>                      QMP|---> Host 1 --------v
>                [FM]-----|              [Shared State]
> 	             QMP|---> Host 2 --------^
> 
> This differs from a real DCD in that a real DCD is a single endpoint for
> management, rather than N endpoints (1 per vm).
> 
>                                   |---> Host 1
>                 [FM] ---> [DCD] --|
> 		                  |---> Host 2
> 
> However this is an implementation detail on the FM side, so I chose to
> do it this way to simplify the QEMU MHSLD implementation.  There's far
> fewer interactions this way - with the downside that having one of the
> hosts manage the shared state isn't possible via the current emulation.
> 
> It could probably be done, but I'm not sure what value it has since the
> FM implementation difference is a matter a small amount of python.
> 
> It's been a while since I played with this patch set and I do not have a
> reference pooling manager available to me any longer unfortunately. But
> I'm happy to provide some guidance where I can.
> 
> ~Gregory
