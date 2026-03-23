Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9D3242D7B
	for <linux-cxl@vger.kernel.org>; Mon, 23 Mar 2026 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280880; cv=none; b=ToDNxCHKfUTVmvEFKitzgCNfyZw8eSEgEMCaOSKLQDmnKXH8nvXZ52kMeeoY87of8slXXfEmfkqfkG+3r73JK589GIPEv7f3AU5HqYdh5KuhXxASSzYLoz36/po0yn10LXuyHleNQ6SHqIx8ciCbI6HMlXVG65l9bGAXV9oNuhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280880; c=relaxed/simple;
	bh=dwMid6ZP6PriB1TT0tK20NMNB0nX3hjNyjvX9cZ4wL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pctxUhL2LR8KVGe8qrnOMMXfrN/Mg+5oFiV87qcmd0HF1xP60y4ZcyAA3/W2AzyMd3qIiSfbYfEhZdQ1us84zfrqJ2f1W9fyboVs81RBfBbqwqDa5UBobOslW5utTP5UQAelSMWu5Rbak4kAk9YwuT1cul/qlNSB0IMiHzezJrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lha3xEw8; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lha3xEw8"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89a07f66f4eso50443256d6.1
        for <linux-cxl@vger.kernel.org>; Mon, 23 Mar 2026 08:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774280876; x=1774885676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3logLKLl3DJkwVNGyAWufMZ0Vki4GuIuYSglYbdEm38=;
        b=lha3xEw8jHyglePgV1Dm9SbFvj0yLY+WeEhIgAJBImsBD+Wngn3G96lEY5RSDXI8YZ
         EfELxR1CEuviZNwqmWwa/1ipVZdbC383m5TpOJEMagfDFmqFuZhly5ePIuTkmDXKr7s1
         ivyI7PVd5jVbS5ZeEa5Kx6fXQwXBmzp6e+gPFNHL0+SChGjUtULVNFogvaMaAQqOaEfv
         7x9PnwrMHfrYyxoHF1hjmSeB1C9CcnIeHqHepnGTu39LFWw9m64CZRPEpMobvQgOKqyw
         0v+h8IxVWDa3mRFYPtmx5l9TAPpV8+HMZIEKdZILniAYB2NwjFX8OGUNgwRpUe/4XTkI
         VYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774280876; x=1774885676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3logLKLl3DJkwVNGyAWufMZ0Vki4GuIuYSglYbdEm38=;
        b=jTKy+CfYk2F1z4raJ+hUmqpzHLdb4z3pHmD7nwTwjUzEmPSGBdkciBx8IkSTJeAdeh
         e7NogUcbWKzLJSnHlr7ICVr+2ydM6JWSit3EiHHvUbs9YGewQcP1LvKjqAcpWopKYS0K
         xvB5jZHcOBqlgMJXdcTg0/4GaWtn5rejCll0foaUBKzN3wdweF9alfczQ5FqWPa4g0Mc
         Yo6XnsUDYQQkb0AQX8pXCVzlP+WmrgYHsKGDvGqnOVRY+5ToHrro45t0mfWW8WHmfl97
         nAgQXwj60bTZkXiLFjrcqPFStERX8RbpSfyVUeEdcPZ1hOuspHg499lL+cSlHQgn6698
         nE4w==
X-Gm-Message-State: AOJu0YycsqEj+avyD+7HT5KRs//rdRdSictagLta1XEXnh0IMaUAJVtM
	90ocRTH/x/umzK8aTuIkCBadi6ShZeqrjEBtOChkRujfk7xbqWDs2RgLrSsV7j5kdxQ=
X-Gm-Gg: ATEYQzwyyOgAfo132gQgmdYqgnhNba9eYjQxQe+pLwoVXVHS//1fMUlQYZFdUvHiSHL
	NyUWcqfPJURZrWP/JGQYCJ7zE85SIPzpsvwpFh28nA4Zt8aZp102eqRnDEZzLRniu8pGMTk7t0W
	n6kWMBKXV4RzGmifxk9NguhErc5uEVOmwDtOP4A9vanVjvvLoSmrIbhChGv8Aq27AR8OwWn+g2a
	hOMBDn3/PP3SvlVvKjmpuBNordIx0dNhUVS5copC8sPdEAqVDAyoDs6j/wIvFkgYsA+H9dYh1Mi
	4H16fJLD1eixt5PxfLkKAM3N6O7e2jnLLInVcbOGWbMcrM96OdKuxBuF1oaEF7/x5PC15u4o/Yk
	lKB/pfhwh69c6VRkQ1lREY8e5fbkkG7DKsbAOaEuFYrvMMZD2ZyxfpxrvJlcj/g71mcB/suaBeo
	RYJo7gB56ukFcKr5puZNg6fietZTgGXlgJSh6LeMQKjuiwMI2O+8kx9iaWJKf+66xEl7jYavnkZ
	HUj
X-Received: by 2002:ad4:5ae4:0:b0:89c:5a3f:15a1 with SMTP id 6a1803df08f44-89c85ab28ecmr204408626d6.58.1774280876371;
        Mon, 23 Mar 2026 08:47:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (158-94-182-130.mclarenap.oninferno.net. [158.94.182.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c8521311esm91737436d6.7.2026.03.23.08.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:47:55 -0700 (PDT)
Date: Mon, 23 Mar 2026 10:47:51 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH v4 1/3] cxl/core/region: move pmem region driver logic
 into region_pmem.c
Message-ID: <acFgpwOgw5glyHsY@gourry-fedora-PF4VCD3F>
References: <20260322131638.3636725-1-gourry@gourry.net>
 <20260322131638.3636725-2-gourry@gourry.net>
 <20260323150847.00002e6a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323150847.00002e6a@huawei.com>

On Mon, Mar 23, 2026 at 03:08:47PM +0000, Jonathan Cameron wrote:
> On Sun, 22 Mar 2026 09:16:36 -0400
> Gregory Price <gourry@gourry.net> wrote:
> 
> > +	scoped_guard(device, &cxl_nvb->dev) {
> > +		if (cxl_nvb->dev.driver)
> > +			rc = devm_add_action_or_reset(&cxl_nvb->dev,
> > +					cxlr_pmem_unregister,
> > +					cxlr_pmem);
> > +		else
> > +			rc = -ENXIO;
> As an example. If we happen to take this path... Where is the device_add() undone?

In many other parts of the code, device_add is not rolled back either
"for reasons", and - depending on who you talk to - this is
intentional... for debugging?

I dunno, but the "hanging objects on failure" thing is common throughout
cxl/ - :shrug:

~Gregory
