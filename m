Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE57D175AB
	for <linux-cxl@vger.kernel.org>; Fri, 13 Dec 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109396; cv=none; b=D1yCyfXbyD4MGEeIj92ZqR8djMDSOhHAMvMHp+6xKuZIteRq+xMTjaJNulAhesWWfoAtB3SuJ0ylVK+NKjFf7PzEDvr33rgXQO13eCdNAJ952P1mXRkiahjdI18+Z+CRJEKRxol8OCdjQj4f4JsL+I/Y7n2Pc/BLh2yaM0Hn/kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109396; c=relaxed/simple;
	bh=ps7Xh6K7SdM7UaBPb5GuHfLmLFsrXBcCR2VoaCfwOpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMxLghBGwsIvlya3d+BfJgqCEC4fdJm5ahQugoRiHWSZwL2UEj1ovQ88jtW8yIz0koRtPsoZOLs3PruZbryUyPtiuXUfROP4FVZPVByAUBfjSa3dWk+ww2vnAJUdrUg83/4iHEBKPvfYyvzBOe53OgT32bZ5SINgIuk1MJBdv7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qLql/Pg/; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qLql/Pg/"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dae1690c3cso15567326d6.2
        for <linux-cxl@vger.kernel.org>; Fri, 13 Dec 2024 09:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1734109393; x=1734714193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yvehb7JQ1ylQUiL+dTxjA1ix/u6K7M9c7p63b0T+Dgg=;
        b=qLql/Pg/+jtgUYGpYYG7vIzebLVlXu90l69ED6tBuigzHeSqvIrMowYNclrzGmauH8
         jSynjDUKmOv70RVnRpqV///XSvjtHq+mHe6IRXjgEpGR4f17wvUJQKC2y83PD5P78Nai
         5/cL9vbx85z5RVa7qMriu2CxCDOkL0VED7ZcoHzRwSA1JbISRsM03agy2wb6rpFINdeJ
         KeIhfsh5lE5f3hNoHPLdTqhpIaW8k6NhaC3m6ku5vLcKBbOz8j6FHNg/qZMIXsQxPY/y
         Wxp6vttc63GnTAuIJvUqDbjusYcRCD7rXW+mP+FScM4cctZBrlLZjto6b1nCwPGC93dj
         fckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734109393; x=1734714193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yvehb7JQ1ylQUiL+dTxjA1ix/u6K7M9c7p63b0T+Dgg=;
        b=XhIOOJKkKhYHcp53cxorSs55doYOjfNl3BXG5nTey5aVcFYH+wzrhvCoEcmuzeHACZ
         b9mO3gymRY1GHyZhijqIdWncMlbGFRglNqZuAIvDOhigljcq0l9wpmxMBF/vjGWZSzfd
         YfORcKTsyG3UoahElvajwlrYf51KJvCPRaJgf2GcGjUNjhHyQQsHNDOAxfXh4MdGMCif
         Y0r3FQ/AC6IGIsYaKWsC+56MxvFRrPG1KVGWTJtLGTecHoLwsRLre6+A3gXxT8GPHs6x
         CjPGOgmyPWOYDy3KOdC/dXrSK1NJsN7n/+E0STb9hzNH0hxQu4y1prC+VCwuoS85pyGI
         MXnQ==
X-Gm-Message-State: AOJu0YzVbWG7Ebb8JZsu71R2xq012JAASdumX6PNqfQRA19bVbGleDC/
	hriRVq8CHoOmnwdS6Qh5eE2xhXCUx8ezN1nIQlAvlwtO01kzwp6UCCIBSmJ1sNc=
X-Gm-Gg: ASbGncssaxGvFdIlOQ0FfPUHH5Bk+50czii9BVtqIX7FY5QhRVYBSuti8AURflhohLm
	cP0qGReNRQn8Kyh2GOm78fvl6wWZzNnwwAvt1Qs0UmKkrqz3J3uc3s0rcFRqrQhzFvUA/muz4X1
	AhgrQobY4Ir9+CCm4lxLeWbqrOi4eoEif+pXYZzhE3hDocM0CXVcLtaQM0Rf+wXwh+IUJLKPCg2
	Lb3Xv6xjJLpgkZZuUluQHd4TV0VrYk1K9d4gpw4Q0NZCfsvQI3I0vY36E/36ZaHGUjn1K67X5QX
	TnKdQVWXYZ7jEVHvUqMSovdZjoQiU4/iSSzUcn+ZlQ==
X-Google-Smtp-Source: AGHT+IElG1B0JsUnGJaX3PpOMBAAYk2Z+SJ3uUSInxF8Upb7SrmcY2cGXNlYVjG21ITjK/DdYIdtjw==
X-Received: by 2002:a05:6214:5293:b0:6d8:883c:384e with SMTP id 6a1803df08f44-6dc8ca53fe5mr60559326d6.16.1734109393082;
        Fri, 13 Dec 2024 09:03:13 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8e65389dcsm85398766d6.36.2024.12.13.09.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 09:03:12 -0800 (PST)
Date: Fri, 13 Dec 2024 12:03:02 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
	svetly.todorov@memverge.com, nifan.cxl@gmail.com
Subject: Re: [PATCH RFC v3 3/3] mhsld: implement MHSLD device
Message-ID: <Z1xoxtKOOmewrgIg@PC2K9PVX.TheFacebook.com>
References: <20241018161252.8896-1-gourry@gourry.net>
 <20241018161252.8896-4-gourry@gourry.net>
 <20241212174016.0000002a@huawei.com>
 <Z1s-4oPjHPFpnnnK@PC2K9PVX.TheFacebook.com>
 <20241213161836.000073d6@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213161836.000073d6@huawei.com>

On Fri, Dec 13, 2024 at 04:18:36PM +0000, Jonathan Cameron wrote:
> On Thu, 12 Dec 2024 14:52:02 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> I don't think anyone is going to do 2MiB granularity on a real device
> (or at least not for bulk capacity) so the necessary data may not be that large.
> Obviously the cost of updating it will be higher, but meh, that's not that
> common an operation.
> 
> > 
> > >  and we can have
> > > richer info.  Having to chat to each qmp interface independently works fine is
> > > also a bit more complex than I think we would eventually want.
> > >   
> > 
> > This is a small component in someone's fabric manager that translates their
> > requests into QMP commands.  Whatever we ultimately decide on, the complexity
> > here is about the same.
> 
> It's the qmp commands to a bunch of different qemu instances pretending to be one
> Multi Head device.
> Sure we can insert a proxy to act as that one, but then we more or less
> have an external process mediating that.
> 

I'm not against changing this, I just think it's going to increase complexity
for little value.  

I personally like the idea of keeping it the way it is and slapping a small
proxy on top that emulates the "out of band" interface to the device - but
all it does behind the scenes is send out a QMP command (that already exists)
to a guest that registered itself with the proxy.

This separates the complexity of implementing FMAPI functionality and the
complexity of how an individual instance of QEMU go about handling
add/access/remove semantics for DCD events.

The annoying thought experiment here is when someone wants their in-band
host interface to have access to the FMAPI

great now i've made myself grumpy
 
> > 
> > > Having a solution in place though will make it much easier to move towards
> > > an eventual upstreamable solution. This is a great place to start from!
> > > 
> > > Jonathan
> > >   
> > > > +/*
> > > > + * We limit the number of heads to prevent the shared state
> > > > + * region from becoming a major memory hog.  We need 512MB of
> > > > + * memory space to track 8-host ownership of 4GB of memory in
> > > > + * blocks of 2MB.  This can change if the block size is increased.  
> > > 
> > > I'm lost what makes up that size?
> > >   
> > 
> > I think the math is wrong here, we may have calculated based on
> > a larger capacity.  I need to go back and look at how we came to 512MB.
> 4TB maybe?
> 
> Jonathan

Yeah that's probably what it was.  I think that's what I was basing it off of
at the time.

~Gregory
