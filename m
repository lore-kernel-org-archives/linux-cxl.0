Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992BD1F4726
	for <linux-cxl@vger.kernel.org>; Mon, 21 Oct 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521054; cv=none; b=HiMuf5ORKmS9vfTHCI6Tcdi/hie22Oz3jqEH6EsVvgZe6pwy3zkNPsiNazj62Gh5P4qr4057n0hwru3CQBxGyCsc8E//He93HHKTr9vuTPfsUGYV9YYM9P6+GD8pbsLE6hkOrfEqZdz6BmPKXBS+q/qHah3CsgBdH2FCuyf75gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521054; c=relaxed/simple;
	bh=Sc+LN0q5i2NE0szrVmCew0GsCYed27xDCGnWqY8FI94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7ymYrFw5fU6/RIdtRxFHX0LABt1kSgrzJf9UBaveMPsviaaNF3CNGFQhY55ZJBkhVI0O86gnyS7Jf16PLrr6fXUBamZHRe5dsE/OeFcHCfa2dXc1N3c/jIjkFypYZ+VCG0oIpV5cZhyr5ua44hUzWq5ehsBclJ8wKKpO4jyeB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S++tiTE4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S++tiTE4"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so44748345e9.0
        for <linux-cxl@vger.kernel.org>; Mon, 21 Oct 2024 07:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729521050; x=1730125850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01UFQeoMaQXOKGoXP/aAgtirn32Uahy6q9T6LIQy8Dg=;
        b=S++tiTE431Qwy4wN6bQ8bmebX0/CaZz/ZgiAsv4iOiAR2CP27fv81XN6EifJbm05UF
         +ikH+lQpomW8cse52aRP+C++ots0S5MDWvyC1yDnQshtmAklHxYBmzROabCUR1RcSofN
         FzkMTgBVTty7GuSzVDhu/YLc7E5/VAKECWcFglveRA4wSBfiEQzI4fLpq5lBjhhSIZJF
         FSyvQqDq66ghjdjR9moj95RJ4BeHspTvKTGyATUYmnEdTuooCh0JHip9URKaHz+ZJesE
         BHvTPlvh5twtwoopGKWMXiXH2p/9VLoyjWlin2ZSfAQMtA2JDY+DIKVEB440aMC8p8Cu
         Og8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729521050; x=1730125850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01UFQeoMaQXOKGoXP/aAgtirn32Uahy6q9T6LIQy8Dg=;
        b=kECAu1PCDjKwQc7E0itBsq7dQdEo818svNmWJ2xz6iMuVCjFEtisDbt2VWZ0j7VbGu
         ChbLaOaSawTRSS4wmyfra3EvP9uVIw5vrTghPR1+gEqahCj75u/bMqH0EJSGSazFUV2C
         rpILP3d3VBGeP07MVY6DgAws/mFxUWTrewLAJ6prH9xodXsxofxrsd8NvHJwkyJhGBDj
         kolDizu8iIx/7tcPBLIJ06GW0FUHVWWb1xNwT2TqNgn2zP5kQz2xFYiuin5God1dFvo6
         YvGljftP7ouCkfC7WuBaADiKuQ64rApwx8y71kPymYBqT5pK5AZ15tEhjuGaSH1USQMz
         TSsA==
X-Forwarded-Encrypted: i=1; AJvYcCW6Q+8OO6gksxMRtUdAonQ2lOm23hsNlFlnaGV9pwM3jKaQCgqhUTkEekkyIOohuDu52xX5WjiwJ7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqImfv5XizXyydPswDfTf9Q1D9N7RhwLE+IeO56me2cbc067IN
	r1UY1Ht0siDoPd9WdszGvUtQceQYHz1IqNbkcVI8vM1Hvx1aeB8yBRg1lZNyWII=
X-Google-Smtp-Source: AGHT+IH5q0AIFqMdR5coKdz2cq1P+rp1fIewB2UgY9rBZlltXHaxuFtusgQqQIeQbHmDdhyYGy2ZbA==
X-Received: by 2002:a05:600c:4e12:b0:430:5887:c238 with SMTP id 5b1f17b1804b1-43161628886mr98311715e9.11.1729521049783;
        Mon, 21 Oct 2024 07:30:49 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c3046sm59115665e9.35.2024.10.21.07.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 07:30:49 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:30:47 +0200
From: Petr Mladek <pmladek@suse.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <fan.ni@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/3] printf: Add print format (%pra) for struct range
Message-ID: <ZxZll3-NZreHlRaI@pathway.suse.cz>
References: <20241018-cxl-pra-v1-0-7f49ba58208b@intel.com>
 <20241018-cxl-pra-v1-2-7f49ba58208b@intel.com>
 <6712bf8240b8d_10a03294a6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <6715c14e9bbf6_747d6294ed@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6715c14e9bbf6_747d6294ed@iweiny-mobl.notmuch>

On Sun 2024-10-20 21:49:50, Ira Weiny wrote:
> Dan Williams wrote:
> > Ira Weiny wrote:
> 
> [snip]
> 
> > > diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> > > index 14e093da3ccd..e1ebf0376154 100644
> > > --- a/Documentation/core-api/printk-formats.rst
> > > +++ b/Documentation/core-api/printk-formats.rst
> > > @@ -231,6 +231,19 @@ width of the CPU data path.
> > >  
> > >  Passed by reference.
> > >  
> > > +Struct Range
> > > +------------
> > > +
> > > +::
> > > +
> > > +	%pra    [range 0x0000000060000000-0x000000006fffffff]
> > > +	%pra    [range 0x0000000060000000]
> > > +
> > > +For printing struct range.  struct range holds an arbitrary range of u64
> > > +values.  If start is equal to end only print the start value.
> > 
> > I was going to say "why this special case that does not exist for the
> > %pr case?", but then checked the code and found it *does* do this for %pr.
> > So if you're going to document this special case for %pra might as well
> > update the documentation for %pr too.
> > 
> > Alternatively, drop the new %pra documentation for this corner case as
> > accommodating the U64_MAX size range case is arguably a mistake in the
> > caller.
> > 
> > Either way, just make it consistent.
> 
> I've dropped the special case in the documentation.

I would actually prefer the opposite and update the %pr documentation.

The behavior might be surprising and people should beware of it,
for example when writing a parser for the output.

Best Regards,
Petr
