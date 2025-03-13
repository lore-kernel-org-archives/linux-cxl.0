Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4E92698AE
	for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881826; cv=none; b=onYMP1WsOFBvCVVNnnpL3wGKe6qNpyQPfxg6V6FW6J+HWveeaxLYDFyoKLJJgx1sbE4DJZfMYTMy9eweBP4s4uPxX5JHVl/6mysHPpdC7XRTggQJYgXbVEeLsp3eXKXOo6/65nOhlTC/2Vfl2yvG/F1TgIQ0/KYa+SjwxQKHT+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881826; c=relaxed/simple;
	bh=NTwKdweeXghmMb8e5gqNnBO78ci15QwSO8R0xG0Qo5U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxLTFyO7IcugE3ZwnFl+2NqpLuK7a9XMNTjxz4ct+SbPmh33EGdYH38KK+bu4Aew+WSyO0Kpjb8TcMwVeizE83BU2wlqC9R6tWJ/YwiVNoDFAvjujaVyVgqQPTdojFC8UBFxm4lsmMzwHgqZoPWHApBU+77LQPn7JrzTpL8Pr1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2woZiJZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2woZiJZ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-301302a328bso2428128a91.2
        for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741881822; x=1742486622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sIkb5arOEkqODDz9dzsL9/lmEx2EyxAguJsBahIivbs=;
        b=I2woZiJZNXqgMeeMFuDe21Ipg9bBevisTkOscolfeoNAhYsfulthYEPoYC64x43Qda
         5ZeD3nRIGwLHbVxrJLbEESwps7VbSh83FzYOmRXsfXiKyhtpzjxGi/qddNUxL+JnYOpc
         c0yRvENy2hfLD7iWXHPr6rOSupS6b+76+LumG2xz1LmUWfEPk5GGauJ/JhttMoUCpzGA
         skH+XJ5R1s1W0U5zeanm0gLmMjk/IicPZ3Lv1vvhai9lBgRDGlCykVuqQbo0jIRyvLJ2
         G+qqyUCXU6MMA9fDalvE9l2TRb28GAZZjS4z9U8xN6DlEEbspmHL6i6wOIGH5utNY2AL
         EQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741881822; x=1742486622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIkb5arOEkqODDz9dzsL9/lmEx2EyxAguJsBahIivbs=;
        b=EzGwM+DJl/QPMWA5HRicGnwSvSlhTv592kOBwF8xImrGtOLNYdYWBClPkbUapkK6IO
         +Xa+fL8P9ioQIbsmHISG6512X8Obx1mvCJVGZicabsKp1ZNx4hffXlrZSeMh8C2TyYVR
         6zYXS5MBAIs54+z3XCD5XotnP8Ibp+dT+9qNQQUHwDOmuVfAWMZb25WWCf5hvbQWvWJ0
         swI+H0RUnMx2lLiJ8ZMctv/SzvpfqLmlfjRuMPHM3otTdNJlKu9izo8hWJt/aGvtrcu4
         I3avQvV/lHoAaCP1KmTILecTAmiNcWEZqZpK/Onw3rrDLTZsiVe8H1uuCeuaEwXuhiNg
         /HPg==
X-Forwarded-Encrypted: i=1; AJvYcCXXxso1gjOH64sq9ydl1TpAQnQ4/Ek5fvsK2yWhgNJa1nNA5iqvMx+9WAdRTDrg2Q6b6l6Ql/4jHoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIHFwvIuv5szV9AyiefuJR1e7EUAmuEQW++ttrJC4v21UBb6Uq
	RaxAT/WLQqbYv2HaVFUPe2wbItQQayuQ6rMo55ZkEixyTMTxBoz8
X-Gm-Gg: ASbGncsafjmGGtS9FWEcWXppVP0tiLJhf287bYmnhY50m7DkulVtsgG3L/LXmNkA8hz
	mYpRTod8u+QUz9Dad1QPO9CY4vu0SD0Th2QRNDNTCVkt5DZEvx4dxdUWzidTU3E35pvjq7jdNjD
	fK3lzc3xtJMclpiwGUTYCk5kdE12hAr586Sz7A5Dxv3OagNALEfxtRea4IC+o1ki0v3twwBOOfu
	aJ39+mxsApkb+FjLxtnwnrIJVXc9aPw3tX18NH4XLXd9qDwP7L3FnGU3ZCV2j2OtBBgO2BuOC9S
	jiSDQJ28kPoMghqJE7UT1u9aiC1xZY3DwQl3uyURWgyvVo+I+g==
X-Google-Smtp-Source: AGHT+IFUWruZuGkMW1jbmnyjoZN66WwgopSQq4sJ/Fn8+F7Mq8lCY19EnN8b/20bLhsAxbkUdjfqew==
X-Received: by 2002:a17:90b:2802:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-3014e861a2dmr108612a91.18.1741881821778;
        Thu, 13 Mar 2025 09:03:41 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:1e89:f144:8d88:9d5c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30138b3b2bdsm1688969a91.5.2025.03.13.09.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:03:41 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 13 Mar 2025 09:03:37 -0700
To: Gregory Price <gourry@gourry.net>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Junjie Fu <fujunjie1@qq.com>, qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org, viacheslav.dubeyko@bytedance.com,
	zhitingz@cs.utexas.edu, svetly.todorov@memverge.com,
	a.manzanares@samsung.com, fan.ni@samsung.com, anisa.su887@gmail.com,
	dave@stgolabs.net
Subject: Re: CXL memory pooling emulation inqury
Message-ID: <Z9MB2bl2mUXjgetJ@debian>
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

We have recently discussed the approach internally. Our idea is to do
something similar to what you have done with MHSLD emulation, use shmem
dev to share information (mailbox???) between the two devices. 
> 
> Why not leave the 1-node DCD with inbound CCI interface for testing and
> leave QMP interface for development of a reference fabric manager
> outside the scope of another host?

For this two hosts setup, for now I can see benefits,
the two hosts can have different kernel, that is to say, the one served
as FM only need to support for exmaple out-of-band communication with
the hardware (MCTP over i2c), and do not need to evolve with what we
want to test on the target host (boot with kernel with features we care).
That is very important at least for test purpose, as mctp over i2c
support for x86 support is not upstreamed yet, we do not want to rebase
whenever the kernel is updated.

More speficially, let's say, we deploy libcxlmi test framework on the FM
host, and then we can test the target host whatever features needed to
test (DCD etc). Again the FM host does not need to have dcd kernel support.

Compared to qmp interface, since libcxlmi already supports a lot of
commands and more commands are being included. It should be much more
convinient than implementing them with qmp interface.

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
