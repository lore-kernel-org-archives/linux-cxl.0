Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550ED29DB88
	for <linux-cxl@vger.kernel.org>; Mon, 17 Nov 2025 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763400202; cv=none; b=GyFcUG1w04J8rviw0uQgeHIO8EI1o53EAhooUW/6QEB1aOoQ7GpXFAI07hVKZWdb485KjYlHgAg9vvsUg0VYKjbLBy78PhJPxcJgPe7ZMb2jBEDwAmBfDYnNrGOTrzFCQoPSpsOlxqhA8Dh0w2b1KTfYj4XDt6pjU+8PezqOKXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763400202; c=relaxed/simple;
	bh=DcF+mtUkLCta7BB0IhgluQ0mrEwuGNBLuuOdpn2rEBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGuLWQ+eGNj6bEvUwCk8/LX/NhGqhWPRRBOjUSbIikply+NOMyZFDqGaLNopCvdLln3cuG+X1wp+n0myi+jCWiGsBtJVCBpXjQb5kpJU36kO46VJo32YHGjSPTAdYQo8EkR1yvjXqC2ioQ9hNYEkoYt735ttx71vzamscaB2kfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jpItD3uu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jpItD3uu"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47755de027eso32128255e9.0
        for <linux-cxl@vger.kernel.org>; Mon, 17 Nov 2025 09:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1763400198; x=1764004998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lu+6cnu1qButzW44m7BEqIZyPFtZnUU5pUSJ+AtHLBs=;
        b=jpItD3uu0PLNMOQmOFseN3jmgmSjK3/6B8kJlVno7JE1zi4TlYQsYaNM/ncF6EHuqK
         YbywHq+ELJ/QKi6sTW3x41Q6gFmx4CJr0zC5bgbnC+EXuZX0/SRZvERvRy8rB+afdxjM
         XvPx2VJ3TauExLhyicHQuE9Lvrhvv6SI15LIHWhFVzYMzIJNXG7NQutLi9ZMg3zQaKWX
         O5XfgdQI/JH9m7G+5oGcORMWHvl+bV+pPgFLOOJM5mST6hRG68gBrC4iwl4U0jmPgsjU
         hNSY2Egdq8W5au1wudlUTEgups1G/hi/hkLv9gfVUc4DBsfJZBhLP+1VqJ5cRMQbseIJ
         gvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763400198; x=1764004998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lu+6cnu1qButzW44m7BEqIZyPFtZnUU5pUSJ+AtHLBs=;
        b=r/sMk77i2JrPFtvd20FFdoOTe2xPvOKfTiAfZs8OJkCMxnjc/Bl5LYoJskK7gxu3eL
         VRSUq7/847iIzZVtRT6E6iwsxLh0T8cTWcujqMd+tPNULW4tg1Mj1rM+7bSQe6G1Nj2K
         ovOJxsB1IyOCbltCyvxsq0NJLjThQ94TxlZ9iw9wP24PH2xVDnO80dvSr3As+PqmlsJI
         JUDtSPe4uy3YL7P5IeAgae/sVnsWmPXjb8aVnhJNrSYKDC5Eaqrr8EjvWJbvfA7zxiWb
         ygwaywQXXwRFEaSsB0X1QTL6NOYWZt2NBHmQ8bu5cwmxUQo1o9lOOjFJfjuKGe783IFM
         Imyw==
X-Forwarded-Encrypted: i=1; AJvYcCWByGKURLYdhBI7TSevwUVeL+detisPSZwvyv8IS80wAo/+Bezu2GiWH5I+rrqxVFI7K2pPbuMUC9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr4rk3dY8/t6CFqMJiHm/dLu3n4l5eRhLS9Jk7hkkl4EiFXDUb
	vZ94B8SevBfrjb0U4WlQ1QBlsSQAvnMSAAFI94Ma9WKT94cRClUDw58SQS3GysqXftg=
X-Gm-Gg: ASbGncs/jnutismKW532QjPLR5w4AL7Gluat4rDY1+aVU8Ao7zUo6OACgELYg6l99lQ
	giZD4ctFfVliYDoRVuVlEcTB5h10ab3kwqQXLdEWk66F2GSRZ0Euy36N+IRd1uN/Yw2Ya7uqy+8
	v9Scvya6+xbBWVnj8/7KbAA3XXYYTdGbkiLiKJh212lxB3yOnOw0wTGLnUzbgcOuJbR+qlvNZIH
	dNf4fMQHvSG/5PLKQylPvxaJnBRrqGHiAuqT/V/egQu3ibdhuO8Rs2ztNCqU/QtivYPn/k7mzLf
	v5qmCaXu/rtEIPXoiI16nqUcrsezdIGvHjQVvs0GZexATijfEo6MffdLPvjGsmhkjYmES5qws5K
	0eKQRu+j7BeBtuCEb/DBtXQNhDpuVbg0BNPmCYWNOYgz8Zpt+Ruq3xoQBp+NLs+rZCYWKitJgEQ
	YkYGXn711G
X-Google-Smtp-Source: AGHT+IEQvjfeTYX3OgKPKJ19MA+p76DDh2uqndjk7m70WHzzEQZxUSf6OpYVBbgQOz2i6gSauFue8w==
X-Received: by 2002:a05:600c:1986:b0:477:28c1:26ce with SMTP id 5b1f17b1804b1-4778fe41be4mr118976935e9.7.1763400198391;
        Mon, 17 Nov 2025 09:23:18 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::7:392e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47798dd2e8fsm63855275e9.7.2025.11.17.09.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:23:17 -0800 (PST)
Date: Mon, 17 Nov 2025 11:23:15 -0600
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 00/14] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
Message-ID: <aRtaAwa1k39kPQgN@gourry-fedora-PF4VCD3F>
References: <20251103184804.509762-1-rrichter@amd.com>
 <aQonCRITOLOH0cG3@aschofie-mobl2.lan>
 <aRtAap0NsNElyKEy@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRtAap0NsNElyKEy@rric.localdomain>

On Mon, Nov 17, 2025 at 04:34:02PM +0100, Robert Richter wrote:
> On Tue, Nov 04, 2025 at 08:17:13AM -0800, Alison Schofield wrote:
> 
> > > Documentation of CXL Address Translation Support will be added to the
> > > Kernel's "Compute Express Link: Linux Conventions". This patch
> > > submission will be the base for a documention patch that describes CXL
> > > Address Translation support accordingly.
> 
> I am aware of the lack of documentation here and am preparing a patch
> for this. Though, I hope the patch descriptions are clear and
> descriptive on their own.
>

If it would help, I can take a quick run at this doc this week, unless
you already have a draft.  Let me know if I can help.

~Gregory
