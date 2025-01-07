Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7966189905
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269189; cv=none; b=UPNwohZbbIoqJ/Xq+mRAcB11h8tyEofST8zEqlnYGjrPvqbIa8xleR5kZ/XzCCfyqLeBugwfp2ZsZqAvQe6WRaMa+96fx+PGd08RXfuts/KJ0tiRwGUN+EgCUYIlsKryIQiZV7blCcIDAohD5EEPYuL/Aa79zNgPOWmt5vQlS40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269189; c=relaxed/simple;
	bh=OD7fLjBzgJvCol+8Oop6voMXAH2wtyr8HiGRUk7YY3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUtTbiqAnYeJs4rDqifOeQvv/f8unGElrmeP6craLCgmzKZ/2YbnzZJ+xM+xbyjaRwQOZzDymEhSmJ2c+oSVcdxfST2h5TaPyXETlATwjHYnJNm4ngzoPe7AlcUNsenwJYwfIJa+d7l6OUlt6b/Br4/p0ClONkl/UiXkDZz9wUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Nmtft64w; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Nmtft64w"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6f7d7e128so1410759185a.1
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 08:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736269186; x=1736873986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mt7WxvlVSNoHvlLP4I52D+d/g/XTQa58yJqTdwgiX2M=;
        b=Nmtft64wgqD96CtyZVDzp8ywoJYL9/Kfag+cdWAYWGuQkbH4KmC70sUhZvHv22JMNd
         BnCCOZ53fDihMTYRKQvOM+zGa1c0T0+1xJ1kOMil1r7U2zbAsxLnR9TDJWRwCc6YnpP5
         Sfi2QTO/tI2rh1bRnOcNpsPDf+BG0hb8u7z8Lr6IdLFV0wudLhzjMjp/0frpmMlEkZvv
         L2QKe+oYYBh7j4VC3B5DR7MtZLb4uVihhZu+bi9b3utSg/m6z5ygG9U0RpG1gXottH4G
         xXco3HVqiV0LK+8iH/j0TxKuyjHDznFQime3Zv2XfocnlqaKBk7Mi8ntNQh28tdT3blU
         SYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736269186; x=1736873986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mt7WxvlVSNoHvlLP4I52D+d/g/XTQa58yJqTdwgiX2M=;
        b=fGq15GzHyVkhaq/L6gulq4UncRGo13cYSERo4L+fPy6/qJtE0S/NWoCWPnBGMXU1fc
         ExnC50iup4PIxf6Rtg0TMRv8tCpo8mnMPC5+9m/Ky4WEjeTR2yaG7+LH3EvFSPVaFmct
         VUXHnhXgt+hF5EWNf4bkxnhPU7uKvFpIhE/MvvBruTJuHNYvKtlAJ2ZdjJ4R5biFIHaa
         S+SyrK733qcRlUygSU9sCbivesN/aGZjgZy7xqkiipa79OZBlXD9McVacpjwP1BkzxBo
         UjFp58xC0HTMShDKQJjliabPOP0Ny0tuYFMniMA/WYLjhDn7GjEy5YcdQwZv+vlMYcOJ
         QvGA==
X-Forwarded-Encrypted: i=1; AJvYcCVB3QDun++j2VnpSpnsbnuFQaBtp77K7/+dG1cqtReoirM5SqYB0xykor2l6E/X5Ip5cQLQ92e/Nb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Z4FlWEUZXKFAOgyPUG8yvc+5KmWkFPGx1o4ThsU3hyfXMu6l
	Uc8nEyXFPohuDAiuek9xm0coxXO0vxJUAGLA7GJkkQwaEeubK6cLCWVs+lD/PD0=
X-Gm-Gg: ASbGncuh7C8o2IoqewXwCp+OVI4ivrNpyIDNVEuHL/m0JSiseb5TZMFWkORjenqlDv/
	W9pNul+yUjJLALn40Sm3Xt7ZE8G8oKAdpO5+wIviw8nFn515tM5OLUt2VjxJXJZqzO4FJuXqvvz
	6w2Um4sfYef8JYXeIO+RuDEQgxBgTQBDAXzmCth31lFOFJFJQ1gjmVK4XqdehXHkordCUsa5Kru
	AXug3dxO94JU1MDX1IK9uezwpK2hNhQNRDtM2bTLN1fU6PPPciF2kaerEn/e2i+j/3lSCwnOU0R
	m6YDYSskEXOFDM9KrxxWJ9To7sCLKTUMY1tRcb4=
X-Google-Smtp-Source: AGHT+IHfm5zIVuyMdrgv+Rk2m27gedpgNh9B/JTICZcvopWvsRg0rdFhornv3nZnKe7mjSHWyAXU4g==
X-Received: by 2002:a05:620a:1d04:b0:7b6:d0be:ca31 with SMTP id af79cd13be357-7bb902fca7emr528177285a.25.1736269185871;
        Tue, 07 Jan 2025 08:59:45 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac4cd53fsm1608171885a.112.2025.01.07.08.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 08:59:45 -0800 (PST)
Date: Tue, 7 Jan 2025 11:59:43 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 07/29] cxl/region: Factor out code to find a root
 decoder's region
Message-ID: <Z31df5TuLsdCvEuh@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-8-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-8-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:09:53PM +0100, Robert Richter wrote:
> In function cxl_add_to_region() there is code to determine a root
> decoder's region. Factor that code out. This is in preparation to
> further rework and simplify function cxl_add_to_region().
> 
> No functional changes.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
... snip ...
>  	 * one does the construction and the others add to that.
>  	 */
>  	mutex_lock(&cxlrd->range_lock);

If the function must be called with the cxlrd range lock held, then the
function should have a comment/contract that states this.

> -	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> -				       match_region_by_range);
> -	if (!region_dev) {
> +	cxlr = cxl_find_region_by_range(cxlrd, hpa);
> +	if (!cxlr)
>  		cxlr = construct_region(cxlrd, cxled);
> -		region_dev = &cxlr->dev;
> -	} else
> -		cxlr = to_cxl_region(region_dev);
>  	mutex_unlock(&cxlrd->range_lock);
>  
