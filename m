Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAF434A77D
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770231199; cv=none; b=CqHUjWSqwVDPkEegWL7udi5hcTWVRrt/RpYFqp5Qz5z3uCMa+202Oo4ZBmo8aF8i3PddZt33DEvqbJUrVU0p+dPwOL3IZ9m6rzpEhGUKipL/VKWzbvqA/n/yKHztID9CjsM2NvnJrxiKkfkmaQrTSZBLkfZhOgU4p4BmtyFUFfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770231199; c=relaxed/simple;
	bh=8NZrnCyGxgIyFgBhQIH24fDsIVh/tj3zfFyvb43nBZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J13MnJJQNDyi5UZKAa14EeAPcRdWYd/ss25kWE1fi5sPTQFje2pPzW+B7qzdgBq/cLp59E8OHYfsYEKcLYhR8jfBCGacMyAjorbHw4W7LAhLMpUGU3a4RgegxPy6nWaL97sS4AwDn3gXFbvpoSXk4KYCLH6MvJc7uBSqFC+w+8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=mMRQuO/b; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="mMRQuO/b"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50146483bf9so1805511cf.3
        for <linux-cxl@vger.kernel.org>; Wed, 04 Feb 2026 10:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770231198; x=1770835998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzI0FVTkG9+TFoyxK3GOdlcG286KX76a4+kWovvefOY=;
        b=mMRQuO/bI4O2PkQBU7Azwdpt+YQmLGR+dzlm+oiC+ft2T80oyoagXx0Ur0OiUnTk9A
         phCY4fI+G/Zcl8eRdp19+4JJBW0p4sbKMb/155vrePtvxlLk/R1Fp7NwUqYIxe31OTpN
         Fc7XqTYrEe+5+jDyd2WlDN5ek6v5RHrk+m4qToBrWPDUwJMKe1NemmXs3HNmcPOQ1AbA
         YEB7XPlvfZ6P8SItjTJAhdHQ2JgoI9cDnFFhPrkQXZjnXjPukzVJDoJCrFxOPJGSPZGr
         F+qtDpYn0EOATWjQlVSBRVsqW0pKufqgNzBzFLesOtPY8rYW/62zvEiDm1RQpeOwfNeW
         qvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770231198; x=1770835998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzI0FVTkG9+TFoyxK3GOdlcG286KX76a4+kWovvefOY=;
        b=hC7qivbqQ397vo4pRzMHrmZsXD6/GYMqToyrxoSLoevjiZWK1aMlHu4bWda0ZTsJyY
         odAHPeWmKu2GqYSoGRoIen77xDgXVBtJY5SPK3ZlKFAiVhGC0ioGC/vOd07U6s4NbswR
         DgFKDQIUGtxhkTJ08JeV0JSBPn7F0ifF43d382H35+Gro3nnjtP1lhCPQWevAyCDgmg/
         THXaHKZIg5djx6xk43D7lpognLywWVMkD5H+wlLRIL2s6y6Cn4MuXjDfK3dOyrzpHFc+
         mirmo6KBWY38JaCn5w/xW7puGD8U9kJOSK+Kf9FPKl8EtYS9yPAwjG8ZQ5yUZrckORm6
         +cAA==
X-Forwarded-Encrypted: i=1; AJvYcCXLyS6UaxTpXO2OupPbquudF++cB4svK1XJRLZUXH/1Ip6Mi8YPXF9ufW+DrgjZ3GVArQ1t7oTcuf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi1oCRWLkGT7foLxFEWM/aS0ARCRszECumGDoU3nSZ8X/HJl3m
	Sl0i1z0IGLdjP2l2rHzs38pvEOlOOuzpO9CiBzz8EdudApcTxPYzwB7E6zZBY2ml4C0=
X-Gm-Gg: AZuq6aKj+6G99qMHHd4F7sv1RKEEB2EdGITUUt2aDVKiw/0FIqQ0lM+kg1p3wZ4b+1Z
	yfkSu41LKjiw21m9FYxRYE0DkeyLD4d7RitP5wZOg9V/fisK+qGHfz5STXQNnOCaKzHWXUtjRpp
	Ax0BlI/AN8VXc2jr5dYVxFXPJVK6UvaBJ5e/1fydbbLAdCf3+6rD1tex3FEjIrS1aNtNG1Pg3T/
	wTQsuRu+EZH3F6ovZbrFMsobyalCDL101bCLH/L+embz/03u3AZbTavWdVbNQ3Au4qnyYwjYZut
	1fDaECVANX1jEEopAAPVG9A3kSt0gkGdfvy9s1sab2UqckqDTcWbi9qmj3tdCEMUUnHeCBxA9XX
	WXz1wDjGQdEfuC3soLhKQUW1ff+z7o9oAxgo8WM6pzoar1/8oVTfYekje9/WRn7Yt8pKi0HkTF8
	XAPo408TR9vusw3t9Vql8AjqT236Dm6ORG6Z/XBLIlZb+/5I9s3rA1altf8gflk1g8d4PhMtM8y
	N7QxRZJ
X-Received: by 2002:a05:622a:30a:b0:4ed:df82:ca30 with SMTP id d75a77b69052e-5061c0c6e77mr51937561cf.13.1770231197960;
        Wed, 04 Feb 2026 10:53:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fa87841sm244327485a.16.2026.02.04.10.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 10:53:17 -0800 (PST)
Date: Wed, 4 Feb 2026 13:53:15 -0500
From: Gregory Price <gourry@gourry.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v9 00/19] DCD: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <aYOVm6PVfmQdZvlI@gourry-fedora-PF4VCD3F>
References: <20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com>
 <aYEHmjmv-Z_WyrqV@gourry-fedora-PF4VCD3F>
 <698270e76775_44a22100c4@iweiny-mobl.notmuch>
 <aYNh-m8BEiOHKr9h@gourry-fedora-PF4VCD3F>
 <6983888e76bcc_58e211005e@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6983888e76bcc_58e211005e@iweiny-mobl.notmuch>

On Wed, Feb 04, 2026 at 11:57:34AM -0600, Ira Weiny wrote:
> Gregory Price wrote:
> 
> TLDR; I just don't want to see an explosion of 'drivers' for various
> 'policies'.  I think your use of the word 'policy' triggered me.
> 

Gotcha.  Yeah words are hard.  I'm not sure what to call the difference
between the dax pattern and the sysram pattern... workflow?

You're *kind of* encoding "a policy", but more like defining a workflow
i guess.  I suppose i'll update to that terminology unless someone has
something better.

> > - sysram : preferably doing direct hotplug - not via dax
> >            private-ram may re-use this cleanly with some config bits
> 
> Pre-reading this entire email I think what I was thinking was bundling a
> lot of this in here.  Put knobs here to control 'policy' not add to this
> list for more policies.
> 

yup, so you have some sysram_region/ specific knobs
	sysram_region0/online_type
	sysram_region0/extents/[A,B,C]


> >
> >
... snipping out virtio stuff until the end ...
> 
> But for sysram.  No.  It is easy enough to assign a tag to the region and
> any extent which shows up without that tag (be it NULL tag or tag A) gets
> rejected.  All valid tagged extents get hot plugged.
> 
> Simple.  Easy policy for user space to control.
> 

Of what use is a tag for a sysram region?

The HPA is effectively a tag in this case.

An HPA can only belong to one region.

> > 
> > I would need to think this over a bit more, I'm not quite seeing how
> > what you are suggesting would work.
> 
> I think you set it out above.  I thought the sysram driver would have a
> control for N_MEMORY_PRIVATE vs N_MEMORY which could control that policy
> during hotplug.  Maybe I'm hallucinating.
> 

I imagine a device driver setting up a sysram_region with a private bit
before it goes to hotplug.

this would dictate whether it called
   add_memory_driver_managed() or
   add_private_memory_driver_managed()

so like

my_driver_code:
   sysram = create_sysram_region(...);
   sysram.private_callbacks = my_driver_callbacks;
   ... continue with the rest of configuration ...
   probe(sysram); /* sysram does the registration */

Since private-memory users actually have *device-defined* POLICY (yes,
policy) of some kind, I can imagine those devices needing to provide
drivers that set up that policy.

example: compressed memory devices may want to be on a demote-only node
         and control page-table mappings to enforce Read-Only.

(note: don't get hung-up on callbacks, design here is not set, just
       things floating around)

But in the short term, we should try to design it such that additional
drivers are not needed where reasonable.

I can imagine this showing up as needing mm/cram.c and registering a
compressed-node with mm/cram.c rather than enabling driver callbacks
(i'm learning callbacks are a mess, and going to try to avoid it).

> Summary, it is fine to add new knobs to the sysram driver for new policy
> controls.  It is _not_ ok to have to put in a new driver.
>

Well, we don't have a sysram driver at the moment :P

We have a region driver :]

We should have a sysram driver and split up the workflows between dax
and sysram.

> I'm not clear if sysram could be used for virtio, or even needed.  I'm
> still figuring out how virtio of simple memory devices is a gain.
> 

Jonathan mentioned that he thinks it would be possible to just bring it
online as a private-node and inform the consumer of this.  I think
that's probably reasonable.

~Gregory
