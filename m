Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED35B30DECC
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770332102; cv=none; b=siJ7+7OFMkXYgLAk4fk3K+McwlNSc0XIKyXweamGwNv/glkfsI4TGZUkf1VnWiCMckGlOe9n65ISzFm0Wy6GCMl10cGW3kyUwYP9y6ZZD9wuSXw7b6c8Nh4DRq1h9RrbQIUEguUpFtI4PrkRZ+pZhvtps4Jv80sSI7R7xrqjSvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770332102; c=relaxed/simple;
	bh=boItcuQPa0P7rtROxBS+vgzyrZBuT6Q0VXWu6jJSdcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKaUXwnzhZd+Rv9RkwUuAGFT14o4JoNZbCggpZWD66dXjDPGFwqAHIXEYB3G35I65Qu83wQnszT0AvFqOAKEXQBMIV9mzttqPc5Gh5e+p544xzTIMuH2BEcX0huH5fnPKEBkDLrG0i1iNfpGrP8HrqyK1mwo/+6aX7A3y1DZdmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=i2Xkb9gP; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="i2Xkb9gP"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8951c720496so12118216d6.2
        for <linux-cxl@vger.kernel.org>; Thu, 05 Feb 2026 14:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770332101; x=1770936901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+niK5XW4Vl0cCMjm1xyUaCk78gBXTQ1Zy+h0lbfWr/8=;
        b=i2Xkb9gPa/ucnJC4fWsnrbMkDfxwf9pSBPOKQsd8fFcGb13THpQdUdt2HBo4Q7nsXw
         SE6pMV9fdHIAqL4js2cOyI3Bu+x/RoQlJ1TEAbqHkDhu916vbl0eSjEFvl4AnwEUjxzI
         C7pmnKNkb+WrgX2tldPPxY9puz9/NYqECnCTssrZjHhLEdA11f8+oMRHkU1fqJ/R6W2V
         FhX2DNVw2wYZ6vJqjVFOU9zx+lqSERU/d9AOAtW84VdLp/JsXnzIZS7PEhtKxjhbfh+N
         qQnBs9KgusW0SA0JOij5Pl/TasABM+F08aGFEDFnslcufQTyVwuiR2BhqbY0Sos+1OIN
         /jVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770332101; x=1770936901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+niK5XW4Vl0cCMjm1xyUaCk78gBXTQ1Zy+h0lbfWr/8=;
        b=B3smb9TYbvDoPWs9sTmEPYf8E+2+J9Z8QEbOnxjHH/hyEMjmeWT5z8V9v6zMe3Di5C
         a84Y+ZNbpKwH8CUDxGPFQdofw712EP0bv762fnXriF3E8V1wZgtZKJlgc/V3LTCvJRDH
         VHYVpKjgzhi1qghN95mXWvJOpZFtVbTQRz+Mi5SIzowSsoJZCPG/Iom48NUHbfIOxXhW
         UxKup4MIcRlvaBDNx7tg/1CTDb0CZk7Ecv3tbGda+VT0cUr+LTwnEQiXLxx6KEEgZBZZ
         lZ+NAB5lQB64onHwztBmm1eIzFS429gCi0Hq0zrY4YtIAWKsZ/y331pXX70eSc5IKNTQ
         j8Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXJl6jgkGvWnPdMiKlLSgiSeWsCZtMC5T+/snrbe9iqUyy1CwzixPNBE4KTIalrY8gtfa/hCaMwob0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJeelmrsbylxDTaZTeWFulC1d0lzGd/RiTQfcJPJUeV+q3w+0J
	2sjtLfWTJmu5tJTxk0KyYrxICdgko4KsgVZycdpUz7LP6oTZ6Zxw100+k130oO0/rKNsE4tSnIY
	KEt2X4mk=
X-Gm-Gg: AZuq6aIk4YqNdALCzC953c+2vN4ue598jY5QFe9AA+TmE1FIrhudfGCYzrspMIcvOAW
	ro5k2Cq+n57mGA5KGBKulliWwNppq9ev0QklLapbfsYlzM7/a0MOgnxZhJYh8xEOhqPi2wZkrr8
	EkfmS5O0gbwr6TSrmxKwRibMVPWbTLnrhNSw6laoRL6mHoUursslsR6S3QmDqq/kcJ2CiMz7f/x
	N3T4IkMOaY8Av7ed4i1o6qphdtfOzse8J5yqzBVU5Iops/zaN4AB5KSABydQIyNxVpxYsLsrzsc
	Lb7som2EGONHhztvtBmFBLBjZhC6OHd3r7nfKWPqdJqIgKSHS6JloCL70JbNAgNNSqo+Kchwv8N
	3slvtA3Hyiqe6JA49RtJEZP6LqmwXU5/x08TrDr8jayGcGqq4O2YEXBEq691U/SPzaniTnyC1F2
	H2rEkQoCqAPbiG1lxV9SPsvXRLHFYZli/nKtdkeYghFs6TmzVsSVieuLKnO6Nm2twLXzCHXg==
X-Received: by 2002:a05:6214:1ccf:b0:888:6f8d:8e93 with SMTP id 6a1803df08f44-8953c850e3bmr12540536d6.21.1770332100709;
        Thu, 05 Feb 2026 14:55:00 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c055458sm5312626d6.38.2026.02.05.14.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:55:00 -0800 (PST)
Date: Thu, 5 Feb 2026 17:54:58 -0500
From: Gregory Price <gourry@gourry.net>
To: dan.j.williams@intel.com
Cc: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
	linux-cxl@vger.kernel.org
Subject: Re: RFC: CXL Isolation Support
Message-ID: <aYUfwvYOZLN01G0H@gourry-fedora-PF4VCD3F>
References: <b4f7a760-5cf4-4343-8f7e-9698ba435fa4@amd.com>
 <69810708cf7df_55fa10055@dwillia2-mobl4.notmuch>
 <75eb28c0-e696-470f-8cee-c47bae6ee15d@amd.com>
 <698511207f721_55fa10016@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698511207f721_55fa10016@dwillia2-mobl4.notmuch>

On Thu, Feb 05, 2026 at 01:52:32PM -0800, dan.j.williams@intel.com wrote:
> Cheatham, Benjamin wrote:
> > On 2/2/2026 2:20 PM, dan.j.williams@intel.com wrote:
> [..]
> > > I am interested in the isolation for CXL accelerator discussion. I am
> > > not interested in muddying through isolation for the general memory
> > > expander use case without engagement from deployment use cases.
> > 
> > I can't remember any internal discussions about using isolation for only accelerators so
> > I'll need to check and see if that's something we're interested in.
> > 
> > As for the memory expander case: would something like the N_PRIVATE
> > node set Gregory sent out [1] be enough to change your mind on this?
> > It doesn't provide the same guarantees as a type 2 set would, but it
> > does limit the usage of CXL memory to be more like type 2 memory.
> 
> It is not clear to me that can provide the guarantees needed to make
> isolation useful. It is still fundamentally a core-mm services
> capability. That effort is not well served if it needs to handle the
> constraint of: "consider that at any moment this entire node starts
> throwing poison, the system needs to stay alive through that event".
> 

fwiw N_MEMORY_PRIVATE would only guarantee the kernel won't dish the
memory out to any random user - it doesn't say anything about what
the enlightened services *do* with that page.

The driver is ultimately responsible for ensuring page usage is fit for
reliability situations like a link going down.

e.g. It's on the driver and services to use MCE-safe access patterns
if it intends to access that page's data from a kernel context.

An enlightened service might still call, for example:

  /* migrate N_MEMORY_PRIVATE to N_MEMORY */
  migrate_pages(memory_node, private_pages, ...)

  /* migrate N_MEMORY to N_MEMORY_PRIVATE */
  migrate_pages(private_node, memory_pages, ...)

With a couple of helpful callbacks.  (migrate should be MCE-safe since
it can take requests from userland, for example).

I think if the type-2 pattern looks like the ZONE_DEVICE coherent
pattern, then if ZONE_DEVICE provides any amount of isolation /
reliability benefit we would expect the same of private nodes.

Except with the bonus that you don't need to write an allocator or
migration code of course :]

~Gregory
