Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A7249E5FE
	for <linux-cxl@vger.kernel.org>; Mon, 12 Oct 2026 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821922; cv=none; b=RVn4dbcbzpzB4y5TE6JlUHmZIGRT5w7LA0RWAWpBklv+9R46lCLUpvgG0qcHQiiR2wSt5rI5gwbDqqICXJLX51k74TPD75aX7m4CRYSLXAU5fgvddMi76igD/E+K6+NSca1mnnPNwAFwDuvMihz5VOnBgjXMKgYVZAvB/GFluMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821922; c=relaxed/simple;
	bh=4YpWVz2t7P3nkCK75u6xOdBsc4nHUlNeMIe6NmdDkAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iv58mEVocDYHQEBIZsRQkSA6/9ZozuL/jz3VJLcmv89q7TjF3O47qttdnrXq0MkTTI6mLGqCXTPBuZXr6Lr79P0HX1IPpoqcecD3abI8cX5/OLJj3M/hZEK19lkE1tKl71+CQo/DnDqpc6AcM9ONpo0QjIe82NOxB4yqQbgoA6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LvvoZaG6; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LvvoZaG6"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93cb9e9405fso96446485a.2
        for <linux-cxl@vger.kernel.org>; Mon, 12 Oct 2026 09:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1791821919; x=1792426719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ycCA/46fGP9bMzNSUFEULycpfUfNegmWCSDBNo9iDiA=;
        b=LvvoZaG6fsq8hB0FOotQh35EMoCepkvvzptzfAzU/s1zJC7dhg5PSKIPvRHtUNIUBP
         w9gvhZ87eGhXWdTMd4p/TK1h1+ue4Fr7gFP9EBJo7NiJyYTitoai0dUHr0lFLGA30I4P
         x0LV6t/aKncAdIxJf1RpJN2EUnV8Jc6gOa7sDXczYruPnhnW0AEZTntu47jpBq4qmz65
         XZ29Cj0zf+pzoYW7+Sqi+LWrGr7lNlQ6BbmCinaNxPHEK+0fy08RT5N9oE+GYxegAK2R
         c0TFCts30Tzfsr89JZpBW+/suz2o049I6GsqorKmvKbg1H4thRkP3HGJRwS3IdBsjHZn
         P06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791821919; x=1792426719;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ycCA/46fGP9bMzNSUFEULycpfUfNegmWCSDBNo9iDiA=;
        b=PbcLUsoAqz68NSG3BxmypN18xs+u8WfGX7XkMbWhUWWqnUhCvnBOVWVPff2Yi7E/ZJ
         6s4VYy4j/8+r5EMRbQpw3UHFoWwI++l6eK57vV29yanMVAz007b4t9P5Z2ylW6EUKeGy
         WCVUGv8ljXC3h7Yx38itxZZFtWZKJS5BT0JXZh9cGPJ9EmIa5r/RM5J9hFFgY3kg61DP
         M3qB7Vtgoi08mm4wprg/GxKvIWRuyEdB3shNABSvJTyKn6hlN0nQU7gUl4NZAEfZr3Lj
         CfLbEYqXezFKO3oUiHjOFBmBVfSdUpcaYghaNjmWAYbEGDxiMHLiVyu2SmSz2qObWuvz
         yYeA==
X-Forwarded-Encrypted: i=1; AKwUvBxh5idMt6biGWXzLC0j9htxUYzdQp/S3MfM6YPrA1KaqfbJpIZxfdIaZKZmZ+mghJWVeoc3fREQh4U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLME9zxfGKucjoFI6AYmXhTJ/WpFDGCgKHQCbHasx4VnfqtqRAb
	+tT6KiAssrFbLVX3/l0FY5uN5gTodnMBnfv/RENIKkSlaS7PFQ6Z1WIrP6Fa7Lo6WhI=
X-Gm-Gg: AYBFou33DYz/CqTYffkKM7COhrOv8jb+Y2YmO8Q132nNUTedhH8OlnFZivNlyjwAJ0u
	Wydkqxkw6KhicSSO+Ha0HfmoMdJfB4yx5i9auS0x0/EYrb1+xbEJBoWT+TnI4la9qWS4YqLz4GS
	qFvt+yXwceKiupq556e9ZLyw4HdUGjVF8F1rKouQMnannD+5VU1hIHdy1v3dv5n6woM1ub9SQFG
	eSUWrGH8QVFoptDjpMHLucNqD+t4o/DldvOkE4L+eAQW9FH600GsT9YgNOSQIZPAZlWWn5T9vpP
	uBFn20z8gahq+UinSOrA38c0RsOs5KZq+TuRRGmSswirSkZg44NW30Uzap0vhfHeDl6xKVVvRIP
	miZpV0IE4J6E7HupB5LbY2Ul2teXu/EKNoOVoCsRmnPnYex5r7cRjfKs/E0z5QTPVarwlYgolzM
	pxRPq8U4Y2uhR2BvzTofuDSDRy9m4ivELWRZ2zGvdLIk56aEK2M3DPE9cMFMIh8BZW8aiGborGU
	YG2wdANtPWMcTPKDnF5WkGET0lNyTKuQEFxIX4gRoc/4kigq+OXJ6Q=
X-Received: by 2002:a05:620a:2981:b0:939:6df7:73f1 with SMTP id af79cd13be357-93ebd27484bmr1635268185a.51.1791821918598;
        Mon, 12 Oct 2026 09:18:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50295a7sm20807785a.23.2026.10.12.09.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 09:18:38 -0700 (PDT)
Date: Mon, 12 Oct 2026 12:18:36 -0400
From: Gregory Price <gourry@gourry.net>
To: jianyungao89@gmail.com
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	"open list:DEVICE DIRECT ACCESS (DAX)" <nvdimm@lists.linux.dev>, 
	"open list:DEVICE DIRECT ACCESS (DAX)" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] dax: fix dax_core_init error return code
Message-ID: <as0IMU-uIENTAXSW@gourry-fedora-PF4VCD3F>
References: <20261012151857.22534-1-jianyungao89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012151857.22534-1-jianyungao89@gmail.com>

On Mon, Oct 12, 2026 at 11:18:57PM +0800, jianyungao89@gmail.com wrote:
> From: Jianyun Gao <jianyungao89@gmail.com>
> 
> dax_core_init() mistakenly returns 0 on error paths. Change the
> error return to use rc so the actual error code is propagated
> to the caller.
> 
> Fixes: 9567da0b408a ("device-dax: Introduce bus + driver model")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

