Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB76B25DB15
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746022130; cv=none; b=KyAY1GwrCzWjWfNPetfYutpj6AbJ11fDLMZb7g+d4HgUr5XSviB49gWGlkL0ip7Wvfqx7yk4CP4twy7nuSWxHSRNnv95UBmmz8gXvTaIQjX2BxV8UI/u/W2mgxYUBuf+X8ZAUKcQEQW0fyu4kUOPlLlra0HyWEVf2mEoD3XvVzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746022130; c=relaxed/simple;
	bh=nKrVXdFYKMFM9Hem9wdZl/eLQy0Q5+LZKJyIDlAU+yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTvmFYhPPLFHgJnC9B8sPX24ESxE4whKHvnE/ajcwNyC0Lf9N+bGQkpz5fCosMJlYv1owHTBYU/3irvoRKzTWfaTuadN67hskmPxi7pif4YlgyGTDzfROs52HJ0G31iyRQnYR1S20EkJ/jc++9/1ae4Vj2FP4AosUyswkfWetcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tgM3DU7V; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tgM3DU7V"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-476ac73c76fso85272521cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 07:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1746022126; x=1746626926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M07YW4+B8fPuXiIo1oP46Lyh2gl/rW1yV/4vvxhVFu0=;
        b=tgM3DU7V/yiErgPmL3sYrc+/gJcBnmdQtqLpiG5ZzpUTO4nB0qhB97tO4t1AeFFjxE
         Uz0RBwvu4FnogpjCgKsXAux8lCljr0Egzz71oPfl4J5uQJM2HUxurHhxlVQBPOb4wEXw
         rlCG3TSL4wm1BaZ2GTXB6rh4n6G6ThCHfOEJPpFeYLouR6QUYZrR7L1aNhSQnjPEEHma
         W1l0fSz4lUnA4INQMUYFEv9jLTS1Kh54xg+/Dyw5YrYCNbx9qLcVJS/0S69kHlC9gowK
         8Uc6FUkfRWkmd0ud/GHUP1HYVyHr/nZ5O2DFbWE3TOkDUYtts1NrXF33PPtETZWEewaF
         iTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746022126; x=1746626926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M07YW4+B8fPuXiIo1oP46Lyh2gl/rW1yV/4vvxhVFu0=;
        b=UvW5l1BYBiYPZYrv9XLg6J4YMCQYZ/LHHwvPkZz/1JVqwg7SEMp+KWWdUMcIHpNmjX
         MOyuxNDZMZr/wrSig64rJ484hqCX8pVwsAow0v7nYWmfN3DuZxg/9nghWo/d3SJeTYXP
         5x+1YX58WzT3PMShjl73O2kQf4VWXnm4b1h/ybfYzsIQwDw1pKnIj7e4P3+6v0GUgxop
         2RjXVN0IlNgTt+ihW/6bbDuMS1DdaHH9DERwhQxlj7Bem+yU76tdN/NHbdBjyvPq10Kd
         Xfz1g3zyxXPSIP5vsdsBCe4rlJo667npN3qOlcMzCKRssrQaNvYbXVLMlCK8WHMN2MBq
         Quyw==
X-Gm-Message-State: AOJu0Yz3wT7gnV/ZPmUY+WGlCMmMqNt3hcVuhzNAEoOjVNkT8pyd1WVP
	J2RvW96x5Ke4cPNBzG3dHESGylkNuFkjiye+iHevZFlkXHCxAQXObrq9nTgeXYE=
X-Gm-Gg: ASbGncuoLMlxD9ZOcNzEaZzyTeShEXM4XYktKC9xar+Fm9dExFHvQbYgwmWi7MH4ENc
	2WHK+8z5XRmjRqySfGIBi1ShlWqo2Pkt8CEh5DiM1UxVTTFMLOe0+72usxJDsHbzEkmqjIQXvYm
	j+9FnR7srVAwLeuFqF6raZxerXFM0AyZp6IsT4oQb3dR4OePlrPHMUOnNyHb50UMwntAQOH3qto
	Nm+Cal/0OPmnRNDgTPsWMQzya9efbZRG42xNZNGsDALG5o4lvMEJXRyYsHkVsQSFU8U3gZOMqZd
	WFu5JtDUSKmMGeA9K3e13GzxkPtFTKQQfvWiz9p1DMaKBcN8mdGRoCJbvIayRjwPHpmv0gF+Dj2
	uco/pkrmWJJ2pHS8IxFwLODQ=
X-Google-Smtp-Source: AGHT+IGv0sXD0ASi/qBfVsdcjg2k+/HQRGhRXeFIhGMFVJWk3UVygxCgFNpA8YzRL2WI7xwLxkotqQ==
X-Received: by 2002:a05:622a:1b16:b0:476:9017:bbf1 with SMTP id d75a77b69052e-489c5701716mr54622501cf.46.1746022126427;
        Wed, 30 Apr 2025 07:08:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7ab516sm91730101cf.38.2025.04.30.07.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 07:08:46 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:08:43 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [RFC PATCH 02/17] cxl: docs/devices - device reference and uefi
 placeholder
Message-ID: <aBIu63MPnZ0bGyIp@gourry-fedora-PF4VCD3F>
References: <20250430001224.1028656-1-gourry@gourry.net>
 <20250430001224.1028656-3-gourry@gourry.net>
 <87o6wdltic.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6wdltic.fsf@trenco.lwn.net>

On Wed, Apr 30, 2025 at 06:32:27AM -0600, Jonathan Corbet wrote:
> Gregory Price <gourry@gourry.net> writes:
> 
> > Add a simple device primer sufficient to understand the theory
> > of operation documentation.
> >
> > Add carve-out for CDAT with a TODO.
> >
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >  .../driver-api/cxl/devices/device-types.rst   | 169 ++++++++++++++++++
> >  Documentation/driver-api/cxl/devices/uefi.rst |   9 +
> >  Documentation/driver-api/cxl/index.rst        |   2 +
> >  3 files changed, 180 insertions(+)
> >  create mode 100644 Documentation/driver-api/cxl/devices/device-types.rst
> >  create mode 100644 Documentation/driver-api/cxl/devices/uefi.rst
> 
> I'm glad to see all this documentation!  One little nit...
> 
> > diff --git a/Documentation/driver-api/cxl/devices/device-types.rst b/Documentation/driver-api/cxl/devices/device-types.rst
> > new file mode 100644
> > index 000000000000..e8dd051c2c71
> > --- /dev/null
> > +++ b/Documentation/driver-api/cxl/devices/device-types.rst
> > @@ -0,0 +1,169 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Devices and Protocols
> > +#####################
> 
> If you could stick with the section markup conventions we have
> established in Documentation/doc-guide/sphinx.rst, I'd appreciate it.
>

Will do, mostly wanted to get it out for content first. Will give it
a once over for formatting now.

~Gregory
