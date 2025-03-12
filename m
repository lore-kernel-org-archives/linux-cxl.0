Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7882E1ACEB0
	for <linux-cxl@vger.kernel.org>; Wed, 12 Mar 2025 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807999; cv=none; b=lCloIDo/VdB1i+JUvMAdrIAvDSIl0intXf3jpnUOPL9g5CQeO57tbzxAXQR10ZSczevTy9V98a8tIouRep3RrpsHYANSo22o0X/kUKTU6dyDR9aVeju4bZGnhKMil0HP9m7ZUD3dxhhuEA3lyC4uCpUzVp94vRS0/boB+pisnWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807999; c=relaxed/simple;
	bh=76T8NNNNn0Adxoh38qDdyHZqJcE1/kXuzYRX2EWQJXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Set5TQA+UibJRWFp5Mb73TNuiXNvxWJSDJZUMSLr7KczKuWRKOfEwd1v8oGFQz4bNz//M/Z4hxw0kitdf3yK4zZ5syaNzJ1UB5k04Dl3+lxphwrex+SJEMZaUuRshmkihzkh/XQJOwPnXkAGC4lk7DE1rZRCdN8tdESt0TK7bRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AjRGJycW; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AjRGJycW"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ddcff5a823so2513506d6.0
        for <linux-cxl@vger.kernel.org>; Wed, 12 Mar 2025 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741807995; x=1742412795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4lSj5k8zELNyNV8ADskYGKCYpCr2239a+4acaXM4eO0=;
        b=AjRGJycW066PM/cLKYVosD1gxbu7DkVpdNrXSetoBusVX7viVhthVuujiHrHjg5GfY
         u026KUjj5i6Vow9oqOMn/zaqUlwf9aVRmLvvSIHVU07YfQkE4fumDbiGvaHZqADF0vP5
         G3C+AAO7smv/jCjyWTRf9963rDMoBLMM3zTX+geWOOL7aC+lJ0NTq+EEl81NTgPoRyso
         a4d2nbKRSUM+67yk7qlGVZIIDo7MUQC+BpYUa4zlZXKAgwgLQzNusqAuu+l8hynv0BOd
         gFApnhCMhz4Q4LqO6BwZWwY9Ij8S9IO7rDqu1BUx7xLpt3wiyEJVHzmtdEHLas5BigW3
         mwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741807995; x=1742412795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lSj5k8zELNyNV8ADskYGKCYpCr2239a+4acaXM4eO0=;
        b=XCrmc05+BrQeoupImKWbjx7WrUGI3NwXNH7AXVuwI+BFfMBpAPGLdVWLxls81/Nnfw
         OHY82JRUQA/Of+ep1ROpnK9sNBjxjQq6JntIlTresn6UkLXzpyJPfMkL7Ksjo/8vM8Rn
         FfePAtYYffroy4fFuYcUCodUOzRGwt/xu47lBBZHgCsjt1hZOsVRgtRksr5Ew2TEpll0
         qVT8ukbiE8sFuNT6YYMfQ4kix0NE9tBqd3aJWwvTdhwTdagQxxRcLFw4iLGIwX77pXEN
         2wC+o2as0hXaXYUjP+oAh2Bt4jSKL6A2Bj/qyMLVqLK+hq0hQ75rScmb50j/kw1EXB19
         mMaw==
X-Forwarded-Encrypted: i=1; AJvYcCU7oI8JNbQGphbLtw6l+elpkgBKZQ5FVsP0GbxigBEUgrjyqKhK5eXbnNxVNzLqDWfRx6HNTFSSvlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDHSdioSfIB1Z2k1YETKhIb9s7cDm5rcsTEVhN7tL8eGjpOZ15
	qZYmhlweUxPFFdfWnOeE5jjv76aF6d//mRbVdpvBM9eM/TTVuJzpFN+8iHWZKes=
X-Gm-Gg: ASbGncsC4ndQUVFvCo3cIXW9vHmYXGqlh0e2LbvIXlzp/IUpzUcV1EDA2boX/Vt0aZ9
	H8p8uItw1tMfVl5io3kyqGXn+0f8XYdnYRs6WwDtk+5dyqZdkiJSipYRcKKZw9qmwZCAYpy3yjv
	yZAArTGCL+k1nt9YIE0bIVAsnY+R1LUMI46Ufaa0f0O74WjMCmmmoiQRxgcIt4qeO4yyHmIWtL4
	FJqJDsfJbf47ZwhAhRNBOF9mOMl1f7M+zSzAG6RFSDpghzZ+Z7kA+1t3TjEDwI4/MW2/E/g1L6w
	Fe6mlc5SNN8SESRviHbB+opTSfvM55ZNX7FbqopGRxrQijFg6S6k9P4CAcB+EV4K8IXTQ5p3Fsy
	265bUHhTCo1+sma6nmEVq4og708Q=
X-Google-Smtp-Source: AGHT+IE8Wv9W2LFd3SjqsjDb1ASTUBm3QlDnMDYoy+21dIVTqr1Ac3ElC6HUJGyQiIjvs6vR9X715A==
X-Received: by 2002:a05:6214:29ef:b0:6e8:9d00:3d71 with SMTP id 6a1803df08f44-6e90063cdc2mr301059276d6.21.1741807995269;
        Wed, 12 Mar 2025 12:33:15 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7185065sm88409476d6.124.2025.03.12.12.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:33:14 -0700 (PDT)
Date: Wed, 12 Mar 2025 15:33:12 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Junjie Fu <fujunjie1@qq.com>, qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org, viacheslav.dubeyko@bytedance.com,
	zhitingz@cs.utexas.edu, svetly.todorov@memverge.com
Subject: Re: CXL memory pooling emulation inqury
Message-ID: <Z9HheFFgOdGE9BcW@gourry-fedora-PF4VCD3F>
References: <20230215151854.00003e34@Huawei.com>
 <tencent_E9F3F01E0D2303378E16505CE4CF208AA908@qq.com>
 <20250312180543.00002132@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312180543.00002132@huawei.com>

On Wed, Mar 12, 2025 at 06:05:43PM +0000, Jonathan Cameron wrote:
> 
> Longer term I remain a little unconvinced by whether this is the best approach
> because I also want a single management path (so fake CCI etc) and that may
> need to be exposed to one of the hosts for tests purposes.  In the current
> approach commands are issued to each host directly to surface memory.
>

Lets say we implement this

  -----------         -----------
  |  Host 1 |         | Host 2  |
  |    |    |         |         |
  |    v    |   Add   |         |
  |   CCI   | ------> | Evt Log |
  -----------         -----------
                 ^ 
	    What mechanism
	   do you use here?

And how does it not just replicate QMP logic?

Not arguing against it, I just see what amounts to more code than
required to test the functionality.  QMP fits the bill so split the CCI
interface for single-host management testing and the MHSLD interface.

Why not leave the 1-node DCD with inbound CCI interface for testing and
leave QMP interface for development of a reference fabric manager
outside the scope of another host?

TL;DR:  :[ distributed systems are hard to test

> > 
> > 2.If not fully supported yet, are there any available development branches 
> > or patches that implement this functionality?
> > 
> > 3.Are there any guidelines or considerations for configuring and testing CXL memory pooling in QEMU?
> 
> There is some information in that patch series cover letter.
>

The attached series implements an MHSLD, but implementing the pooling
mechanism (i.e. fabric manager logic) is left to the imagination of the
reader.   You will want to look at Fan Ni's DCD patch set to understand
the QMP Add/Remove logic for DCD capacity.  This patch set just enables
you to manage 2+ QEMU Guests sharing a DCD State in shared memory.

So you'll have to send DCD commands individual guest QEMU via QMP, but
the underlying logic manages the shared state via locks to emulate real
MHSLD behavior.
                     QMP|---> Host 1 --------v
               [FM]-----|              [Shared State]
	             QMP|---> Host 2 --------^

This differs from a real DCD in that a real DCD is a single endpoint for
management, rather than N endpoints (1 per vm).

                                  |---> Host 1
                [FM] ---> [DCD] --|
		                  |---> Host 2

However this is an implementation detail on the FM side, so I chose to
do it this way to simplify the QEMU MHSLD implementation.  There's far
fewer interactions this way - with the downside that having one of the
hosts manage the shared state isn't possible via the current emulation.

It could probably be done, but I'm not sure what value it has since the
FM implementation difference is a matter a small amount of python.

It's been a while since I played with this patch set and I do not have a
reference pooling manager available to me any longer unfortunately. But
I'm happy to provide some guidance where I can.

~Gregory
