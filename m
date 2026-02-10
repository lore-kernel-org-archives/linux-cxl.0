Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A612288CB
	for <linux-cxl@vger.kernel.org>; Tue, 10 Feb 2026 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770763576; cv=none; b=Sa62imttabFqxl34sOmUvCVt6omFeV+Jp2bFnXYgLFD8A/t5KtBtPvyJv7RLQM5poWdQjeqvGZG8zS4hdqfebRvb9b80PWqbWWxLjX86Wh30imktZ4fEqI7fwgkqwraRAyKCpexBBAeIaItc1MUxW+nmhhmw4y08bXwcfTaOcbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770763576; c=relaxed/simple;
	bh=CPGQPaje8gblTWNJtq5gtGeBe1bPwkPz8bv/h0t2vSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7Ll1Q/u2XciiRxCPP7HQlC+7aipV/AvFSePThknitKptqyUeKRplrD78IklrCXCVkPPYNpKQ/kT6fG1dB4Ia0dQbSL7I4DAGZQGpy8oKASfwaGqqvD0GDxh5i4Lg+kmfrHiCimXVRZUCeNstV4c6KxrYWbt4+XsWcHOySkRi3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=iU/G+Gb4; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="iU/G+Gb4"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c7146b0854so639446185a.2
        for <linux-cxl@vger.kernel.org>; Tue, 10 Feb 2026 14:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770763573; x=1771368373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5vzF0xMlrc4ZBcBHeJiM1IhDw4s5yfnZKGmLV7zXEg=;
        b=iU/G+Gb4q05u77c6OENIJg6LbRiF5k7D87rCxJs5DLrKpXSDwQaxh2exYM0xG7foDk
         VAV7ubL10TXloLFgsPwwNGJAGb0vUtEnH1R4pGl5mrXqbtTf0aEU6AdJNHCbR1ch8jux
         DkVh2AKgTS+Nq8hXwCtFJepzqqdXSSMyV7kOSvTLSNGFOSnPe8M1J+MwReF86XeS7Akr
         mLMVIc0PBB1SqzYVRXS/CVXFQaaxEGnKPGDMJ4mIZvdqXGryVgJ9tJvv2yKRWZRVjqu0
         /W9ScFrbrQ4pvNAEoK2h0LWcY+KR7bDIKxQwKOV3pDS0mL6V1xM6QVmpCGegxW+yYK67
         noWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770763573; x=1771368373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5vzF0xMlrc4ZBcBHeJiM1IhDw4s5yfnZKGmLV7zXEg=;
        b=uYIgn/RACbwy62JPEVi89e7SVGzvNVPpe/AJRbW80F9qrbA88z5KltSylduoZx3VqD
         1pCNNuL7cq3Sl1x+JttgOJf5N44QNDKWBzrLnQ9x2SHdZzN7orBQyWJzLXbxcOpfpwKY
         RcMFW6IYWaZSQnrTiR0vPX2jraPTNOWiWqDsuugvOSOd1O0dgOm4tmwxIla2vRIxWBO2
         9jliy49wEaH0xYz/6UAFmNc1ngKCPhsYWQ/4eXyvY+StRUh+USptU654qifi/HpKGGZV
         Jb2DfMHlr68PnUY0ACgypd0jUAjjTQs/LxRTNl7yxE+HVjx5umnzOpkSYorXL8Id4rDW
         f+uQ==
X-Gm-Message-State: AOJu0YzV5mdXjzc0cfJS3Mqw104ee1yzyCvH6jS2LINk+AmmyOYBRDoM
	xp9fZEu2iMtERNigumiRaPk3xbzz59EPzW5OYROEICQKrNp4ZF5hVkcDgnrVXfbezXc=
X-Gm-Gg: AZuq6aItzNljFxrnppEpu+a6zWwoFc0bgWa1ghNaq4xUg6M+0x6Dq6+99NTdTJTRpLr
	ACvrne8Nk2MLyIVdRhYJOvtUYxnFx1Y3Jxi5aDWj1uFt8l68uk3p3cwv8TWWMg7B9qCQbsWbEds
	IMnsPYbBk+93muI0UuOfjL6BBEzas1WzRPlb8UL+USPQ2edibdX5RtevFP9WjE2huYogxCkZeZS
	pMjCe2Qj18Y5BxqUq9XujGLiiKSvvsjYWps4Y9LLTg5Ka6/jTM03kmTytNShxo3cgppY4EppPtw
	Q2Jm/ZRcnjb5VATK+OmLHrqvkGgcEvtEmjlMCUNvT4ABjvFu6ZJuTo9sP+XxRf5L4KeKp8GBipw
	ivTaOI6tTDNt7mnDeeQQt9nnA+jSN4jXJ6XWVImYNf8UQdkcKm6t72bvT9s2VQYR+BcdggqOJDZ
	oIJgs0AvmFSSTq16MOdyQsSPIFlyxGaqd7ndttxPo28dM2GZ4djK8lTamez5fOOWnBZtmuEpFlx
	mfKWKz2FA==
X-Received: by 2002:a05:620a:d88:b0:8b2:1ee9:dcfb with SMTP id af79cd13be357-8cb1f6b3433mr508026385a.8.1770763573426;
        Tue, 10 Feb 2026 14:46:13 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc7ff1csm311656d6.3.2026.02.10.14.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 14:46:12 -0800 (PST)
Date: Tue, 10 Feb 2026 17:46:11 -0500
From: Gregory Price <gourry@gourry.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH] cxl/memdev: fix deadlock in cxl_memdev_autoremove() on
 attach failure
Message-ID: <aYu1M75-tV8-TLAC@gourry-fedora-PF4VCD3F>
References: <20260210154320.1748223-1-gourry@gourry.net>
 <698b8a8620f2a_dce1110074@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698b8a8620f2a_dce1110074@iweiny-mobl.notmuch>

On Tue, Feb 10, 2026 at 01:44:06PM -0600, Ira Weiny wrote:
> Gregory Price wrote:
> > 
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index af3d0cc65138..c0de767b24fb 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -1098,19 +1098,22 @@ static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
> >  	 * return. Note that failure here could be the result of a race to
> >  	 * teardown the CXL port topology. I.e. cxl_mem_probe() could have
> >  	 * succeeded and then cxl_mem unbound before the lock is acquired.
> > +	 *
> > +	 * Check under device_lock but unregister outside of it, as
> > +	 * cxl_memdev_unregister() will also take the device lock.
> >  	 */
> > -	guard(device)(&cxlmd->dev);
> > -	if (cxlmd->attach && !cxlmd->dev.driver) {
> > -		cxl_memdev_unregister(cxlmd);
> > -		return ERR_PTR(-ENXIO);
> > +	scoped_guard(device, &cxlmd->dev) {
> > +		if (cxlmd->attach && !cxlmd->dev.driver)
> > +			break;
> > +
> > +		rc = devm_add_action_or_reset(cxlmd->cxlds->dev,
> > +					      cxl_memdev_unregister, cxlmd);
> 
> This kind of threw me...  Won't this deadlock if
> devm_add_action_or_reset() fails as well?
> 
> Need to use devm_add_action() and drop out of the guard on failure.
> 

lol i pointed out that this patch was a claude recommendation on the
initial report - didn't look to hard because it fixed this specific
deadlock with:

	if (cxlmd->attach && !cxlmd->dev.driver)
		break;

so yeah, easy enough to fixup.

I can either v2 or Dave if you want to just make the oneline change
before pull let me know

~Gregory
