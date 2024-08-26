Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8D7183CD3
	for <linux-cxl@vger.kernel.org>; Mon, 26 Aug 2024 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678636; cv=none; b=BVWFUmXfUUmIxp3iPIAG9BA7sdlMMS/WrvkPBEg/L0nNRGwgL7lJJr4qTy8zPZvDnk2vcdkSRfhdYC6srWsG1payYD8sdSpmqiPkAwfB8tCBnIMnLitzc8oqX44ZCOHHxKFe37JR+8H4mHk8iGqeOkaCGZerv5iLEtj+wA3I3S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678636; c=relaxed/simple;
	bh=jeztrx2wemey1pVY0c62bFmR4t/EoPdY6f0cjjxFm3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHdqFhMxQgLg1YDBoYdYh8TMKa+w9xplzmXRK01aOJmfQuMZYkIJbRqnEeMHiKkFXSrzsrMEKteZvAnyygHJ5mIIJRKvTxnVSX6Os//t4b0vw8hQrH0DPYmVQSx7H0iVouuG8S4Oxciejd9eLv5Vl74OrlWMuQhOOGuMKmxj4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Idkm4azm; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Idkm4azm"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53349ee42a9so5060862e87.3
        for <linux-cxl@vger.kernel.org>; Mon, 26 Aug 2024 06:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724678632; x=1725283432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IQCe7McW9E8hf61lrcG6VB7x1ye3Lq6gKShLHGG32KE=;
        b=Idkm4azmAAv0OlQT098UhA2YN2r/QCXeuSiG+8tpEoLTUag1bQzyHOZW9eH9Ndyss1
         M6FfNmt/ldaX+xjNd1V7yfIwr1yzlFp9tbaRBMj/nnZ6jnmofi5tDJz3OOqWZYeyqyA3
         ny2DvMDCFImTRnnT2VCLZCvkjNp8Np/z3spOS9QG45n5a9DBIlmBL5WQCHfEt692Mi6C
         H7bK/MxdCIjEnLt2S6tYTQARhtOH84jlZwmotNzDpkDmzv/M29RXRNpFX+Ile4sEhz0l
         SGKJ7VyBaLuYHP7+I2V9IPxSWgPcT9ZRCwz2QtZ2Ja9hEvN02c6QrxVnOSkXnKnA19qU
         FTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724678632; x=1725283432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQCe7McW9E8hf61lrcG6VB7x1ye3Lq6gKShLHGG32KE=;
        b=S4O2D11CxOJJPY6VpH8eeFV+klBGU48rfJvKLJoRkeM1VGBn5XWnlLVcHRDzYhYah3
         6c0AsxF8JF43IOXm1ZEmszPMwCtZbMGhV73Aae3FS6xytr1GoZEDX1ePbAJO9aIPv1E4
         Ms6rXniq/hNvuDmNxfPNBYvcDeViu4GRu4Y9EM+pQOqHPWaHh+zDSTuHkhM4zUGJE63R
         4nOQVZegMtzhv4e4OIigx2Uo2eY6kKgmaUpgEqhiAnQHvyvGPK/clJHc/GVkQuzq2wrU
         yzftQ3X1CxSTvGQH83YPyitykrzIkmqyiv01PLqtRTHB12JuQLbzSwHGR1ksYZBcxdxU
         YCzw==
X-Forwarded-Encrypted: i=1; AJvYcCURFx5oiQqwwkraWyzx8/6e4jhwGFW6wy41+WRLC0JhHUUa6ImNSbXor4zFBEj+A0wudpBtYh6ovCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU+Ed4GkROn0HCcWafr3L3FLPTYp2wlNPuQ4MWHwjQ4xA95AXl
	vZna17iLx/RV8oc6Y5ffbOcGR9uFo71nEqHfa9mJkfVX14jWMCV2berEOAFK1tQ=
X-Google-Smtp-Source: AGHT+IHb9h8+cB84cqvegDS1MyMJPEFI1QyTGHUhHtl3xRFQzxT2+gqbftjjzsxNnZRT1RRhuK0Sgg==
X-Received: by 2002:a05:6512:3d24:b0:533:44a3:21b9 with SMTP id 2adb3069b0e04-534387681d2mr6366176e87.1.1724678632351;
        Mon, 26 Aug 2024 06:23:52 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f436330sm665305066b.112.2024.08.26.06.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 06:23:52 -0700 (PDT)
Date: Mon, 26 Aug 2024 15:23:50 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	nvdimm@lists.linux.dev
Subject: Re: [PATCH v3 02/25] printk: Add print format (%par) for struct range
Message-ID: <ZsyB5rqhaZ-oRwny@pathway.suse.cz>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-2-7c9b96cba6d7@intel.com>
 <ZsSjdjzRSG87alk5@pathway.suse.cz>
 <66c77b1c5c65c_1719d2940@iweiny-mobl.notmuch>
 <Zsd_EctNZ80fuKMu@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsd_EctNZ80fuKMu@smile.fi.intel.com>

On Thu 2024-08-22 21:10:25, Andy Shevchenko wrote:
> On Thu, Aug 22, 2024 at 12:53:32PM -0500, Ira Weiny wrote:
> > Petr Mladek wrote:
> > > On Fri 2024-08-16 09:44:10, Ira Weiny wrote:
> 
> ...
> 
> > > > +	%par	[range 0x60000000-0x6fffffff] or
> > > 
> > > It seems that it is always 64-bit. It prints:
> > > 
> > > struct range {
> > > 	u64   start;
> > > 	u64   end;
> > > };
> > 
> > Indeed.  Thanks I should not have just copied/pasted.
> 
> With that said, I'm not sure the %pa is a good placeholder for this ('a' stands
> to "address" AFAIU). Perhaps this should go somewhere under %pr/%pR?

The r/R in %pr/%pR actually stands for "resource".

But "%ra" really looks like a better choice than "%par". Both
"resource"  and "range" starts with 'r'. Also the struct resource
is printed as a range of values.

> > > > +		[range 0x0000000060000000-0x000000006fffffff]
> > > > +
> > > > +For printing struct range.  A variation of printing a physical address is to
> > > > +print the value of struct range which are often used to hold a physical address
> > > > +range.
> > > > +
> > > > +Passed by reference.

Best Regards,
Petr
