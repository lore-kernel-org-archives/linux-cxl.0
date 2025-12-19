Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026BA329E74
	for <linux-cxl@vger.kernel.org>; Fri, 19 Dec 2025 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154732; cv=none; b=rRkFpyRzed2QLO142eIehDJCor9ZcbOankwYbd0QKfBjcn1AL0VqZlKJXrwUA3vo1lrzSwiQVBiWd1EJmeXhZkr7HSWae8q+piRQ3+Z+awXJplMrKTdNb/5BEoht8DkpglHCEGE8ubI1LfU7TPqGnsGKmbLb/B5Z6TWIVgMDKIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154732; c=relaxed/simple;
	bh=ADWK1K6u6t0CaWFJITvqzw+3tp6y+TaCRw5mAd3q2gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdC3gw/QGzQQ857qneqffs6u4mhYdlllYKGt93csrkm6fAcKURTpU+o2YxHO3xp3qhsgfniC3ueY7dkdXGbINOsMrYfCv6Xp06YEgbhAWCfIpp7wriay81VFFlHFbkpI+BM5+Lg1lFmETdXO4BBRk1bRyZlKzAahLbs+bHbWJ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gNDdAWLp; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gNDdAWLp"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-88a26ce6619so17900066d6.3
        for <linux-cxl@vger.kernel.org>; Fri, 19 Dec 2025 06:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1766154729; x=1766759529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ivd5VUDwxKrJjsOzp1+SZHitpb44btNy0UY1qm1oXXk=;
        b=gNDdAWLpTkL4yzLz4kJEKfQZiQ04pNofmdooFUhwckx3MWcSeUkw67hsz5q4w83T3E
         u2IPd1JsLAuI6zYH1TnyTsLCOuFIkunOb3tbvCKnFouEtyhOY3vFKSXB5ugyQs7NpeFo
         w3s+GpsPfxDiajzMU7NbnWR2+X9UDUm+L6JEt+/5qWmvzQY9dJwr5a6ePtILcjlXDuWk
         IL5uBNqNwlbgWtM1nq61Ubu5fYEhI4VyXFupZAlOXa6iDxPJr4QOK5Vf66O82m9s+UZi
         QGvMUJZMEnTQ02ZK/bE8v8Ag/GlsYIvjkVzhKEMaYWDQGAhV3vtS4oQ2Zt7DIlTrvFDx
         Ihbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766154729; x=1766759529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ivd5VUDwxKrJjsOzp1+SZHitpb44btNy0UY1qm1oXXk=;
        b=lojVL9sYQzos8uitJl87mYmoMSsEhJG27G7zzkO0vK3Z22/VUK3jo6DPOthhevUfds
         YoJhPDKNu+b1Gj6+d6mW5wfkNfIx8jXET8XJ4vaumZoynV2q2EcwMT0tWkDHwV7mmuSN
         dqYKFaKU+qHp1N4zeSwTtxfmVyfeltZ9GZU6S/JSOaBFBgjT9ja3Tnz+O+4dtZsv0soF
         6xXJ6HLC6z4IrYKuDvXuvx9+QN2GhjIy0zuQG3JSpLDr3INvK4rcaNjqiPQBKqSr3t7F
         LkBl8zW6qn2Bi0p5bj5menO5RL8nVqL/NsL+vG7eIaUQyMCbqPhxQxoAYF4tsbVmgxdK
         E/sQ==
X-Gm-Message-State: AOJu0YxP515cH8QaP00LABLKE8W58qTL4uyMyuw6rak7GojtU9/YM6Cz
	6GnYFSzzBi3rBcXbdzestHp0lXidVus8In9qJUrZCmfXPlVoaJoIlBS44DQ2Vw7kJjc=
X-Gm-Gg: AY/fxX5EhGPyD+op0c37ykzrHWhByz2M8GjsjfifZQOGvTFAcC2yA0yPe/yx4AzdTti
	1S+Mg6ixzjTVYpLvazckPDW0hpoGGX3cewa035+U+Du8WhDGyI1ym0fdX57bzIfTQFIdoz7iPoi
	8F9Bf9Ba/1akBNSSaQ6BAqv10t+RA//qrFa7Pjcen9edaZPfP1W514ur+40XrjwvZxQwjS38kB4
	EtGVFK9Hzl1DWzg/+sDo7IDWMKbcQHUiVorSYwJuw//fwEMvZzZ7MYWxIHIpN9D3tryO6bApsGX
	ELW9GYXjPMuoleI/DrRsYXSOvKmGP3cRY4g13bpPaBwCdV0KoZTOqIJ5fiQnVT/4cQ3xRRHkCns
	TqViWV2OJjeS5SXrLqcJnQLsVs631QTw2AD7xGcq7QT+8Ez/n3jB1t6hBQLlagZPldr/7cSHj6D
	SK8TkgX8C0hkJ6bn5T4qLhNMiZ32IhxRHxWIErT5iK5iSGWiEjgLpxj/Y63IqyEfn2F8Y0xA==
X-Google-Smtp-Source: AGHT+IHFFb9WYMCs70KCnwOLuU8Gjvo2loQhh9U7/SRr9OdjbdGz6to5W9XjQQ2TooWYSjdCemC3fg==
X-Received: by 2002:ad4:5003:0:b0:88a:347c:4117 with SMTP id 6a1803df08f44-88d85bae7c9mr33202336d6.19.1766154729462;
        Fri, 19 Dec 2025 06:32:09 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d997aeef5sm20208696d6.27.2025.12.19.06.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 06:32:09 -0800 (PST)
Date: Fri, 19 Dec 2025 09:31:32 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, corbet@lwn.net
Subject: Re: [PATCH v2] Documentation/driver-api/cxl: device hotplug section
Message-ID: <aUVhxIJzGiiGs9ee@gourry-fedora-PF4VCD3F>
References: <20251218170747.1278327-1-gourry@gourry.net>
 <20251219105518.00005ca6@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219105518.00005ca6@huawei.com>

On Fri, Dec 19, 2025 at 10:55:18AM +0000, Jonathan Cameron wrote:
> On Thu, 18 Dec 2025 12:07:47 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> > +
> > +Multi-Endpoint Memory Device Present at Boot
> > +--------------------------------------------
> > +A hot-plug capable CXL memory device, such as one which presents multiple
> > +expanders as a single large-capacity device, should report the maximum
> > +*possible* capacity for the device at boot. ::
> > +
> > +                  HB0
> > +                  RP0
> > +                   |
> > +     [Multi-Endpoint Memory Device]
> 
> So this is the weird switch as end point thing?   Maybe a reference.
> My guess is these will go away as switch and memory device vendors catch
> up with the spec, but maybe I'm wrong.
> 

I guess I just don't want to dictate the innards of a multi-endpoint
memory device.  It *really really* implies there must be some kind of
switch inside - but that switch might not even be runtime programmable
or discoverable (basically all the settings get locked on boot and it
becomes passthrough).

If you'd rather just not have this section at all, I'm ok with that.
The switch case below this covers the base case for a switch-based
device where everything is programmable.

> > +              _____|_____
> > +             |          |
> > +        [Endpoint0]   [Empty]
> > +
> > +
> > +Limiting the size to the capacity preset at boot will limit hot-add support
> > +to replacing capacity that was present at boot.
> 
> 
