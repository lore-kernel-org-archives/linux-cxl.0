Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66A02D73BD
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 05:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775884158; cv=none; b=UIeSkJ4xMf5j5LFOV7lRTO78xgpXz6TiLOz/bU6Ua/1FLMRLB6so88tt911/n5GbsvucOEj8a1DVqJKbkR0WR1D2y4dqltPyE5MXDK4SP4jnxqTXGdWKwsuSbcQ2wN7Ek2Kc+W1mTe/eHvas7X2Vh8nXgZmmHcnoQ8ac5GQuzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775884158; c=relaxed/simple;
	bh=tTLfxWzUWt8F3Cp4GPDJCl5DR7hUWhAcP3sdQa1XDiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCBiTna/1hciED4NwROOM6KKq8V5Wkls4mmnZqIkOgrXRwqtI8bWYZD84+F815nbXqTzfRn1uZP1oCJb3HPavIxyNC/TXz0gDq51srOCjfBxWpZZOEaTmJPVjzJ7aFYW+gXJQ9+ZI3VnzBbkQ8mcuhR6ZkXaPIqbsL2PaiSEu9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=EcjL6MnN; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="EcjL6MnN"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899d6b7b073so26431906d6.2
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 22:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1775884156; x=1776488956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LnPixhfaUhNyQ4OjatQAQp1qsz8FPPMw3JjLj6a1Ycw=;
        b=EcjL6MnNsXC0vvYLNpkzA6/An7Acn2hfzPbSlXoGPf5ikdPXhybDshvAVEApW1GKVq
         1g8ukFgmvKdvN9+COumL+z9/Ib1sceNLG61z4dbR+jp7gI3qP426EnHsEhYu25i9o8/0
         6IgTPXMIFydSO6IIwT1EgC9Qwxr4V94AlcalYHKZ2gufYEIkgcp7JhyKuHeCR/2hFJJO
         E37agmqv+MobrZRUpZpQLemJXJ2P6I1VSLWH+FpKWCL5f2JewtMxi/j0YR6Dje3DBk+J
         foOIBWYOf7i/J2HMGS9sgZYLNjcZVPWryPtR4q9OFikhCj9ZCzVIxF/e98Tp25Degxdn
         +rOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775884156; x=1776488956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnPixhfaUhNyQ4OjatQAQp1qsz8FPPMw3JjLj6a1Ycw=;
        b=oMt1n9URWVrpw4EN26YoU8zwrTvkXRIhWcD6VkTLmcVRuH9lGYl76L9Mib8Cgf0FFv
         j+TiCz+JZ5jjj4y9CX0JmPQfI9U+clEeZLeDE/l50q/s9zDgOMlnTjEwkdnCO3ua8ZVv
         GBvsBGgFICzgqtMrpUwCYs7o88ZQrGUMI/L7rZ+Kncyc4a7PxA/cKg2Ualhxue5TIUZ6
         T1lP9p/LJx12b9IDs7hmGyuL3B83lH8rkDOjoOkNAyH/Ky3xCB31lHqFa6JOcVj8FSvF
         HfXz/TxY+WYYGWzKcDvknBB6hF+7WSxdjMCRgphJHQFC53eL/E3nXBOdJ2gHP9VLTwE+
         nlmw==
X-Gm-Message-State: AOJu0YynICor9a3oDl3bBE6BzIjQRjwZiirf9NnZ2l4xxE0BV8MPxxKY
	ykBtovpfAIWWtIrUkD3YZ+jsaD83xRiYF8+q262ZcztGoCvzWhXQnrg4Jjr8FyNjV8g=
X-Gm-Gg: AeBDieuyHpZ0j3OeA8KxTJqYPMAPjjmTK7SL8Ghp4MZUlqKoURkBmuHLmKR0NgzbE7o
	+mO18VWFYqOsfz2nezmjuryfvC2ghjxUTaj0Ul8ve2RWdpR+JkVIK5L9ddiJJ+lZ0OAr1kL6Oi8
	3gY2BFQBSoCk8JtMgNxdQGX65Wpl29mfk+rpWIXliEuxyi73yndrnSCSN6KftZsF6DlN+UAz+M+
	/NnRLSE0chtF4uTjwlqEyUeumuIfoUpTVQ3nJql8DIV7g2uWBe1CaotzrrxzQ871Ki14SOnodQf
	rCmttH/lFwp7wlItzi9gwZuWmlnR1Fg7hyLmY9NfEieYT2Nr4JBu0e9MtSIpdIQCV3cz7OEEE3R
	GzBPwZa+KPEj/5nogEZUeT+nFfDi+TcCQeTz5/kxAzeHdGRCHk9/1c9vmLF2F/lU7i2Yia4lACm
	5AnVyOy907ZrNsF6HqhJz+J65Q959xw36K+7Ko7OYkpin/uwo+falrZq0BKkB8PL0Ao4dFvOjtj
	A8caEzouO8F
X-Received: by 2002:a05:6214:2601:b0:8a0:7c8:4098 with SMTP id 6a1803df08f44-8ac86157f1bmr95391296d6.6.1775884155794;
        Fri, 10 Apr 2026 22:09:15 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-243-150.washdc.fios.verizon.net. [71.191.243.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84c4acd5sm38932846d6.23.2026.04.10.22.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 22:09:15 -0700 (PDT)
Date: Sat, 11 Apr 2026 01:09:13 -0400
From: Gregory Price <gourry@gourry.net>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH v5 2/3] cxl/core/region: move dax region device logic
 into region_dax.c
Message-ID: <adnXeR7rOEByIg6n@gourry-fedora-PF4VCD3F>
References: <20260327020203.876122-1-gourry@gourry.net>
 <20260327020203.876122-3-gourry@gourry.net>
 <admPeJv7mjDZPhJv@4470NRD-ASU.ssi.samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <admPeJv7mjDZPhJv@4470NRD-ASU.ssi.samsung.com>

On Fri, Apr 10, 2026 at 05:02:00PM -0700, Anisa Su wrote:
> > +
> > +	cxlr_dax->hpa_range.start = p->res->start;
> > +	cxlr_dax->hpa_range.end = p->res->end;
> > +
> > +	dev = &cxlr_dax->dev;
> > +	cxlr_dax->cxlr = cxlr;
> 	cxlr->cxlr_dax = cxlr_dax;
> 
> Running into segfaults without this ^

This should have been a purely non-functional change (the code is just
moving from A to B without changes).

That would mean the original code should run into this too unless I
mucked up the move.

~Gregory
