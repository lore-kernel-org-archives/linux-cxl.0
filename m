Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17942777F3
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768256784; cv=none; b=CE0YGOPOJAyk2ogEfmpYwqyn8qJ0b5fYMvw6VPHYIJHD6ayDx5ZnUHC/ciV5YJydOQAH3J8hsWLznaBiLjAX+7NonP048pu5xjVQfUG34leLeGpxofKTQfrev46sk8qiGRAPyLS+Jm7NNPtTycecM71Xa/lpaayYLJf+xU+dFJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768256784; c=relaxed/simple;
	bh=LFqfRia1aFDxtE8pe5ufY4bLvxdEW1nRZBND0cZUK+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIjqBbJSmoO+8hgAI6SGNMvhSgPsR/5iDEZBgVN6noARGM3w9awcL8OyW1zt6MBaW4fWSdWvOPNBmfLz8g0lTGMWIpSCFZkr/4l/AyjGjtcYK3pgEaJTtUkUvMxJSHwtDWMV6TSN4/hFkd6iPpOlvfXy7yiRoc9c0zr0mhinO8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NmheOZsl; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NmheOZsl"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c0d16bb24dso655633985a.0
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 14:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768256782; x=1768861582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0HIJtUdzLo6UAxmstYGGT1hVT+kl4apAoIWbX1tUYg=;
        b=NmheOZslRAw+K/6T91fKIakjblMX9/4EUKA6Y98qzqQn7I6AYqGV8Ndd4vuPhp1C4E
         T/Y2hQ7ZkCrtIPbg7Yo7QppEg7AjhLhKF5JEQZY5VSNo5W6AbkO8+scUpR2oU4mxclEp
         Fo3d6kF9qjfyGzgXLeScKkasF0q4k4/sUoSs7TBK7Qb+gjyX4w1OaziWa/qgwi+JFA4c
         9oFyot+OZcuFBvqfWZkjq9xw7NY2aWe5Gyc+Rvf63gWKDuUSWwy6yXvJUtijVKBkTteW
         sBB+AdtAsbkrLV0DwRwmQZbrnHHuGLJT63FEi2Hdgr3d3KKbp212qtStT2GChUJtdagc
         aOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768256782; x=1768861582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0HIJtUdzLo6UAxmstYGGT1hVT+kl4apAoIWbX1tUYg=;
        b=hLnOX9BKGUbhTbxs0EwD5mBDj7SVIahsuuh9aoRVkFx+WcGPHeZrOiYVvYgdnCfA51
         oXkk/imPxJeZ+FF2Lc7C84LL26Z1o7+kqRXOv3LWu25w4uDQ5jEiXogJeokCVwkHO1ou
         QTeThITgnI28miXxr2GLpe5ltSuUSXVNOzL5y94LbwC+EArumksZ7ctA4NHR9yW+sQJR
         NQJf5ODaxdG3iFVJRWaHLE3JzHUx5+So1Zpg4ehIWv1KWUPr9JGZ3IUU4EmXtdzJKnwo
         dKL22YJyH9jiLCh7w6NsRBl7ESwRET9BTdHgeCCeOzVxU2OHrNaihtpVjcC0yUG3HuEi
         X99Q==
X-Gm-Message-State: AOJu0YzLdDk5yC8TJN0PK0osVWQf+kc6j0CSnyiBhP0BKzl96IT969Qt
	JgdtE59DgmSl69TTzZJIB/Y+x16OgwgQ7MiZiPrmvgysmsBJP9wgl2OpiNCjRzGd7bM=
X-Gm-Gg: AY/fxX7wG3o7W1Z7K/Ssm757TjS0TI+ZB5QnXREOwfxOubU3DI8A6qws29yqQ8eoMhE
	5BzZjt2PcWTq3C2X+GGUsYGdkbgKe/Va/5jHGuPGnarQgl7xS2711ARQUEcu6rSjGjIekRmp7OL
	o7Gby1ETKVJwCSVawef+csB/ZbbegO7QaxHarhpG03aZoUqM9vKTy3dtJFym6psd+d4W6zE6aQY
	UrnTptqbalRYjoXxkBEss45lD+dmF3uSoIagLvELGxlX3nYddFKR6AHOcqY1lhFL3v74gn0v1v2
	HY3i9b1WHa4kpPQzm/+QWd/yolsT2IKbY74RATJCGgS23GHvY/7FVguiEyo9YJ/ZHUapi6zxnX/
	w7Vud96BTK9Xdq4Pr69K4jmLNd1TroCsBdLebpxglVxa74s9MT02T+/2EN2qojP0xO31IEXi5su
	UUCDCEINcBPW/KKBb/yK1LSpbGHl5bzRjOFFmUlf3gn7zA79HO9SW1WREl5t1EZxfBsGx13A==
X-Google-Smtp-Source: AGHT+IHk1aoANIt88i5L8dSCPa+r2XZ4h7ZPKstDPzG10jSmeYgm62jYRTsTRAqmr1Ba1tS2Q4X8qA==
X-Received: by 2002:a05:620a:f84:b0:8b2:772b:5f65 with SMTP id af79cd13be357-8c38938491dmr2170419685a.22.1768256781654;
        Mon, 12 Jan 2026 14:26:21 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f532bc3sm1595083485a.45.2026.01.12.14.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 14:26:20 -0800 (PST)
Date: Mon, 12 Jan 2026 17:25:47 -0500
From: Gregory Price <gourry@gourry.net>
To: dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com
Subject: Re: [PATCH 1/6] drivers/cxl: add cxl_memctrl_mode and region->memctrl
Message-ID: <aWV06x8AnB-C6I1j@gourry-fedora-PF4VCD3F>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-2-gourry@gourry.net>
 <696560c0979e0_20718100b8@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <696560c0979e0_20718100b8@dwillia2-mobl4.notmuch>

On Mon, Jan 12, 2026 at 12:59:44PM -0800, dan.j.williams@intel.com wrote:
> Gregory Price wrote:
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -42,6 +42,8 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
> >  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
> >  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> >  		   u64 dpa);
> > +int cxl_enable_memctrl(struct cxl_region *cxlr);
> 
> This is a "probe" operation not an "enable" in terms of runtime ABI and
> presentation that starts decorating the region. In that respect it also
> is not a "control" as much as an "operation model / driver". So no need
> for a "control" concept, i.e.:
> 
> s/CXL_CONTROL_{NONE,AUTO,DAX}/CXL_DRIVER_{NONE,AUTO,DAX}/
> s/enum cxl_memctrl_mode/enum cxl_region_driver/
> 

Ack.

> ...otherwise there is nothing in this proposal that makes me want to
> abandon the traditional meaning of a "driver" probing a "resource" in a
> certain way to make it usable with the rest of the kernel.
> 
> Rest of this looks fine. With that fixup if we are going to have a set
> of different region driver modes then the directory can be:
> 
> drivers/cxl/core/region/

Mostly I imagine we'll end up with at least 5-6 of these, and the
directory makes it clear for any new comers "This is what you must do if
you want a new region".

but if folks would rather have it directly in core/ then `git mv...` 

either way, ack.

~Gregory
