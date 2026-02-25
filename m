Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B9026B2D7
	for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983744; cv=none; b=hKqFQQmDD/czhjDLScNpmaQxhSctK8VB01+PH/jBwK0ASuJZ8r+3NhipdaKIr+VwZQM10hqkT/OS/pGg2Jv1JSAeu90B3yv88te0G8KY92f+w8rDyHE9yvnWUn9pv90YCqt3BumVtZ4QPAdDl9KyO54r3lhiLYoxI3oUMXRJPwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983744; c=relaxed/simple;
	bh=AfqOJ+f8iBpn2YeRECTiS3swxHGChpe1lX4CMkSixnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAZlnE4O9IhP+f6MV0IHT1a8J8wriRHZpMdJWKQbVa7ViSiDIRAnhkOQ8iWJVv5tPAhEVjr/2gtGgw/a4q70wbxi0+Gbup/XL9WAVPwrGPUkqjSLjKirVkxISqPKZlP2liGavaWp5kj4jN6yTKqAIEuHIQy3uQW3qAl/F57rRl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Lli8sPs5; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Lli8sPs5"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8cb4097794dso617809885a.3
        for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 17:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771983742; x=1772588542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3/UfaKnNpfKgE4L3AOtdGDMjVf1tkYmuqP6fF21iRas=;
        b=Lli8sPs5sDBKepHgZQrxbi2AzMZM1E5XOYkF0Ak3GlOB9lfpZPPKcW3OpB45GOFYWa
         Tw56AXqufs1CAMEZ67DF3frs6n/BwaXSRNbPzIf88j+iN9/yfOmmwJOTc9bVlmz3MYKF
         xSIWBr52tdLTI9W+JIAiL25cpFbBI3jlW3v2V8ufp7JTralXs/90LS9fprcSVAQbi4fb
         dFwsXJFuwGXBbCt5DARoLbxr3KrUzsCvJ3exPZwRFj8VIBaFi71YPX7cqfQ41SGO0DSd
         u+dmGaAJa+FnOpSaZtXGc4jGw7EYtmGmhrb+jOnYHkX6JRrSQtNeaLcLct1shEi3CSax
         XspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771983742; x=1772588542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/UfaKnNpfKgE4L3AOtdGDMjVf1tkYmuqP6fF21iRas=;
        b=U0bVxuHJhvW5iKfgR4Z2fQqRFYXt26PYiXbuQ9bWLLo50EiQ49ACWcs6Ulw18GJhin
         gCn4emebTxxjodhLH0JpRGZblgjVWTtcpTZH10jgBnfnwGH/fuDL03Ca5bhgkQjF6Els
         hXIkF2OWhK4QtLE18uGXZpDBpW9fmr9oJ1kU7818EtQpi0C0U2skUXVsKWUpARDldhpV
         xKp8FmfJDjhFokJs9kq0/R1X28GGshKCQ+9b6NzGKzg+WwAPSJCHgv+SSATl15Kb1jXG
         eosF+QANa4zF8EGuK3mfB+nF9rZUyS0v99W8BecZC2SVMovUbyZEhfa6/TFpUkCxnYEl
         hLBw==
X-Gm-Message-State: AOJu0YzjS0tvq8h2l9xE9f3liOPZBEBvg/AnmjvS/tN2Ww7pAnke8cYj
	lF+g0Il5dVq1t9GFrQ2mLuTW7JxUB5v+VrWleN7h6XnHUjoyqiEq7XuoJ+hBFeOkiCI=
X-Gm-Gg: ATEYQzwvXkb3tLup1S+nhu4gI0bargJ3l1Rc/bPhaTX2f+wF+Hg4LFBewUcnoDGbksm
	yEh4O4QFOB+bREuLYpc1GKnB/Q8ZxAqxZpSK+xj1mxZ8AqfcGmlb1zYj1SVLVq6ytKESfuPFGaa
	ptrPOCtchJFUZwQEH3W19qrSv0ImSPpf34sHEPP/zMF9O/ISPrgmlAdE8YwOLeHx7WN2IOR3v16
	ZIGzPk2Z5cJBi8Oa7W2Kyy3aJvoNysBEUXzaStT04u3yNu4UmvCk0AJRVSTbbvTaAM0b52bpJ1s
	lhrUNCLf1+nM4L+6JV/fANDDmoo5t+FZvuMxQl61Gaimnesgk/dMS1cBrdlB2X4mk9wPCWgOmCd
	PAPVzcCdmcAe285MGXwrds8mC3Qczc3J6DV87tmzUY2MWdrHG3jWc4xd5DhUYbz8lRPCJ6N86wl
	KX2NdeEZXqJvzfPwFh+caEyjZOaFWuK5s7vVpaZ4Tql7/4D/vzkwyemiNk2CV1fCDPrYlOH3ij7
	n2mv51SYjjNk3PSJnNr
X-Received: by 2002:a05:620a:1a9e:b0:8c6:ed6b:5865 with SMTP id af79cd13be357-8cb8c9474f6mr1895796485a.0.1771983742404;
        Tue, 24 Feb 2026 17:42:22 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899ac09e78esm23847046d6.34.2026.02.24.17.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 17:42:22 -0800 (PST)
Date: Tue, 24 Feb 2026 20:42:20 -0500
From: Gregory Price <gourry@gourry.net>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH 1/2] cxl/region: fix region leak when attach_target fails
 in cxl_add_to_region
Message-ID: <aZ5TfEeqULEGXo4N@gourry-fedora-PF4VCD3F>
References: <20260221043013.1420169-1-gourry@gourry.net>
 <aZk_9iYMh2QPYNDz@gourry-fedora-PF4VCD3F>
 <87347db6-6838-4a60-ad1c-037f526f16b6@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87347db6-6838-4a60-ad1c-037f526f16b6@amd.com>

On Tue, Feb 24, 2026 at 04:15:33PM +0000, Alejandro Lucero Palau wrote:
> 
> On 2/21/26 05:17, Gregory Price wrote:
> > On Fri, Feb 20, 2026 at 11:30:12PM -0500, Gregory Price wrote:
> > > cxl_add_to_region() ignores the return value of attach_target().  When
> > > attach_target() fails (e.g. cxl_port_setup_targets() returns -ENXIO),
> > > the auto-discovered region remains registered with its HPA resource
> > > consumed but never reaches COMMIT state.  Subsequent region creation
> > > attempts fail with -ENOSPC because the HPA range is already reserved.
> > > 
> > > Track whether this call to cxl_add_to_region() created the region, and
> > > call drop_region() on attach_target() failure to unregister it and
> > > release the HPA resource.  Pre-existing regions are left alone since
> > > other endpoints may already be attached.
> > > 
> > > Signed-off-by: Gregory Price <gourry@gourry.net>
> > BAH - disregard this patch, it uses drop_region which is introduced by
> > Alejandro here:
> > 
> > https://lore.kernel.org/linux-cxl/20260201155438.2664640-20-alejandro.lucero-palau@amd.com/
> > 
> Feel free to add it to this series. I have started to send individual series
> as you know but the part changing the region creation will require more work
> than the already sent.
> 
> About this fix, it looks good to me, although I have to admit I'm a bit lost
> after following the discussion Allison points to. If we want to keep the
> state of failure for forensics, not sure if the debugging/tracing or default
> error info in this case will be enough.
> 
> In any case:
> 
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> 

Yeah i don't quite follow the want to keep the objects around, it seems
to cause more issues than it solves - but then i also don't think this
is going to be a particularly common problem

~Gregory
