Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430041DEFE7
	for <linux-cxl@vger.kernel.org>; Mon, 21 Apr 2025 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745250043; cv=none; b=EK6Imbby35zL/tY0eR9GAbyysUX+Af4lXAy6de9GOzzIBi/M1b3isC/c7FOrMQgh9RSSQMsyl65XnsfZ8lyPXyQbzLRjqSe56nwjOgg+daipvQChN9VOctDUki6MQoMYr/6UZlHNxqQlZOlYTkUN0JRCUz7EQ4EjHEeAPvpy7LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745250043; c=relaxed/simple;
	bh=IiLvJJ37OTQQUEiR3EROW1nZchaoEUdT0B+nDMa1kMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFKcvLEIKU+4QE2sH9YYV3hTy0AmfmO8VeLVRanNNujWiI9Bj3T+7iLfvI3hHCaQQPdz+c4I8BKkgojkTIG/CIqcmo1fl2aQblugVUpe6MxUXo1rwPTEfk+l3yCIvSwDof0Aa7e2Ujhj3EV7uDlu+pIKTJMKkhCG12RU45SPpis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VBManInV; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VBManInV"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4767e969b94so82639251cf.2
        for <linux-cxl@vger.kernel.org>; Mon, 21 Apr 2025 08:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745250040; x=1745854840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TvgLfiKKsaR0lvedRaSvPBJ6EaaTxZxcc606nli4GKY=;
        b=VBManInVGgjS9RJf0VPXK9x5oqG47AKKu2FjsYGYrdTUuiL7ETexopi/yK6WDwkHOu
         IjMELVEhevkcsRSqxYkoDj1/UwAMqv7dLWESKP+a+HwBQOdknhHHieiWqMHJYuEl7/Cb
         qsJfR6KoIVLZ4KULHww+f/T4+EADGSuYpe50l3dIxxKm0IUSi/yWHsxY/z/SpT+2b+XI
         Nd1Rv99KotFedSlz4Yle+aIDdj1eu2o2Ugi99+fsKSXwp27IM5xQ9rCJMRBTb+veHfFG
         JN4XRfhKNS/rgenO44U29egdQLOTxpZpHD0REtJ6RXMgiSpbS7ODy/+PUjUDawp3v49R
         K/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745250040; x=1745854840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvgLfiKKsaR0lvedRaSvPBJ6EaaTxZxcc606nli4GKY=;
        b=tFyVdcyaykxS20Pk0CWPOvtVtTcfSXFNKhjiOYJjWVo71WTXEYPrlBaAYcb0lwjHn5
         LL4AdqkrRyNd4QKpyDUd5lUma9ewJKjMxEyFi9unTjp9aAyEuf33LHXJsWQGnVApGxpV
         EUQfIkq+zQvhYU5JV1H/3y7Hw1nbn0EJdaDshlR4ZgbI+zbwaTBJ/tLONAQK6Hk9N2ky
         uLFG6fiskvuLXPsakpqpp42lSAKdR09Gwqerhs55uUIslyW2L72I7x3yyUF3Ui4pQp5e
         W9KxI+imB3GmtE6SvxQLlTbw4Tyql2AxEMlTRi5UfZwqiIJzWdy+f/yPMTFjHz6WIHUC
         fMRg==
X-Forwarded-Encrypted: i=1; AJvYcCV4hgEcQOm5vitKf8zr5r2ziD049Q0c5cBkQcKnzBXv3sCQF3bVWEQeItnnqvk+KPOts69UEq/K7jA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9qKw1mCtCzzo4bHBCkty1OlfQEtkK5ZVd9KAG0nm2Hm7rQMCB
	krJ4/AigC5ekVMIjIsII8xOlIdLVHxCjoQJuUuD+64r1Yikb1AMLNujJxhzNu+M=
X-Gm-Gg: ASbGncsqUw/D15+nciyJ7gZJn+tRi86ASz+gYVYea0v8T+YIeXiJayHU2E0oQa+idbs
	fs4xk5TmTxFKadyU8SkILHVu/bGN1c6EA4ZJ+jpinl4aTnPEANC1z81ecq1wJxalajT+APa64PE
	iI56d1DgucPlBKXJUCo4dPVuU8HJPawNpuNjny9aAGRn1bsE63VChihuzbrBwR6sZa7mwQ3AR84
	GOjuC+KYaj94CpcHeDbys3nHZbr4+m12zytXmk4C9mWzHh4aO6R1QP3SGqfkHmskFRj2pXcgjVP
	WqDrvcDLqz9YR2k1Vcxezts5Z93acRz5Wpo0fVRXYpWnaKuhsKrlXce1Lj477lbAg3gAktCKl5l
	1t9wuFH3xwTEIx4K351FvBtw=
X-Google-Smtp-Source: AGHT+IEriEJEZS0gOlBzm+PXLfyxKYQEYEx/1ljqMJSy+Pa69NFaoSuShDtmGBW3KaG5XQ9x3mdyhg==
X-Received: by 2002:a05:622a:589:b0:476:8e88:6632 with SMTP id d75a77b69052e-47aec3cc09amr192130171cf.29.1745250040134;
        Mon, 21 Apr 2025 08:40:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c3b4b9sm43366401cf.18.2025.04.21.08.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 08:40:39 -0700 (PDT)
Date: Mon, 21 Apr 2025 11:40:37 -0400
From: Gregory Price <gourry@gourry.net>
To: Li Ming <ming.li@zohomail.com>
Cc: Purva Yeshi <purvayeshi550@gmail.com>, huang.ying.caritas@gmail.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH] cxl: core: Initialize eiw and eig to fix potential
 uninitialized use
Message-ID: <aAZm9eVsEnQvDvrD@gourry-fedora-PF4VCD3F>
References: <20250419203530.45594-1-purvayeshi550@gmail.com>
 <3b412741-4fda-4285-b1bb-80c89f0fcf38@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b412741-4fda-4285-b1bb-80c89f0fcf38@zohomail.com>

On Sun, Apr 20, 2025 at 06:43:37PM +0800, Li Ming wrote:
> On 4/20/2025 4:35 AM, Purva Yeshi wrote:
> > Fix Smatch-detected issue:
> >
> > drivers/cxl/core/region.c:1292 check_interleave_cap()
> > error: uninitialized symbol 'eiw'.
> > drivers/cxl/core/region.c:1297 check_interleave_cap()
> > error: uninitialized symbol 'eig'.
> > drivers/cxl/core/region.c:1299 check_interleave_cap()
> > error: uninitialized symbol 'eig'.
> >
> > Smatch reports possible uninitialized usage of these variables if
> > the helper functions ways_to_eiw() or granularity_to_eig() fail to
> > assign values under certain conditions.
> >
> > Initialize the eiw and eig variables to zero when they are declared
> > in check_interleave_cap() to prevent potential use of uninitialized
> > values.
> 
> I also met them during checking cxl drivers code with code inspection tools. But they are not real issues, because both iw and ig are checked before calling check_interleave_cap(). That means check_interleave_cap() will always get a eiw and a eig correctly.
> 
> they are checked in cxl_port_setup_targets() in auto-assembly case, otherwise checked in interleave_ways_store() and interleave_guranularity_store().
>

unlikely, but things can change and if we know about this now we should
just fix it to avoid someone tripping over it in the future

~Gregory
