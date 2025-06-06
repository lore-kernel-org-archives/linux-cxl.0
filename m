Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8153125DF
	for <linux-cxl@vger.kernel.org>; Fri,  6 Jun 2025 00:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749169727; cv=none; b=lJETtU6r9XRcaTLjD8tR7Lr9Tg+Aoul6IK+7pmokM+/Xa12DvbH0Xh517xb9T2agS1um4CnDAqLfb0vvRufIBeBY837D/5HtMTElvhoCRupsSuAuRL20dzNuXxrNum2vT0BfMqvEhamyv7RBjiprgVya6jUD2FToGsECyyzWRCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749169727; c=relaxed/simple;
	bh=gnEwdszCdw8pdyoPwWQ8YHseMTvuWJ+/3Et8J9YYx+c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdvbHpum0YSjtGYfMe1FrZyjdekUmRyrst0kEZH5MfujhAPbGZbTZXNyoPt5Uj7L+vWkN6BI3ui5b+0nLZx6V/7ntIyBS1smPj7SXKbCZQLEQEIUV9Hy1zrjc6PBggtO9cTKoRG5H2Z+s6R1rV9CfDq6Vbt5GCzfSCFywYGi5iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3Zjt9ox; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3Zjt9ox"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b200047a6a5so2304759a12.0
        for <linux-cxl@vger.kernel.org>; Thu, 05 Jun 2025 17:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749169725; x=1749774525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i3TxrRqR0I76iLnt2ucZkJXg4dmyNRw//DeN8cjiWKA=;
        b=V3Zjt9oxUoR+JHjHvj8waiX5zNKeBQ8DoYxiqswvXcv7UrldQ0TGHLTIqg8FOhet/X
         1+eRE5bTucq1ISi9lnwJgXO3+/X65l/k/1HyS0aoTWqqAx1xT2kKKKfNAl0G3Kd9+avG
         pll7rFbwk6z8LtglWaNR9N3Wyp7jyOcEVXfaLQmgBmFtXklEEnm4lWI7X/0nIZTTv+2+
         dPLIQfzF3NkU8CDVkoliatxenfRiuEkWtYlc2cTlKAwk5IbFfkoQch6Hw71x4EAGOQUg
         0U1Jv0YiPLlNDH/JT7w8Z6ftgepv4QH0k0IXbt/qtG0JsTJHGet1ia8cOeDjWrAOJ861
         Cq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749169725; x=1749774525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3TxrRqR0I76iLnt2ucZkJXg4dmyNRw//DeN8cjiWKA=;
        b=RjXY8e+opPARsCI+PjZeoMMdvfcyqODJCgelcBaaYNfxFuBSkypeqI6b7awnCLa6xp
         M/FUzy/MfQxDYpss7DM7dpGEMReNao1cuBi92TBJkilw85JdRvrNmKVNU+D9ErFGnEa1
         O3ccmpdhBfochsre7cbJrMuDTEyosfOpZm1LYJVYc3bb3Ad2q9EmK0fjtQd57IZ0oAmj
         Ww37Vm7nl1CTfRGRb8tjzwUBIxJScQQ5nU3hZRvugvUtNM1ftxZGZYd5dDBsle6xif8C
         KpohqcBa92/uyGhFuEz0NLX/RcYbiAjRJ8WMzSR4G2pGrPNMpRLjXfNtvQ6/rOw9Ibu7
         BqFA==
X-Forwarded-Encrypted: i=1; AJvYcCXwtSymPYiil4tuHOLvswiDpI59HTNf0epy/fgMLHzDIWfqxLL0WZMiKdD6vtAjS7XzbSMotwKK0fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwVIRyhMj7Wr89mly99blpe5MZ1BfBjUzAzkiCPUJUZwV6n7A7
	u7jWm6kdjlS3hYB4G1jXpreQ60S9s3Y3DnGzeWWNIOPFroa0tg0qw5TI
X-Gm-Gg: ASbGncudOynpPjBqo0zNTF7sler0rnGbs9aopBNth7zBoxmwH4Yd1CqbCruqeRkVgwD
	RODX5MPRxNB4m0civBprV0dafpmcK529+z9dVaqIEVgmS7WcV/kGvaa85LEXbqOgm2jpwFs2BK9
	qynghAtJ3my3llslPjzf9Was7M8TEIKK87E8Su+iOm0yzCxSHYJeLY3oulMi7yeqU1N0/OHpisa
	UaBbESTZMKrOKK6vp3TkpZuTeXeu91nFIpr1hW9HX1mzudAfWLdh6uOp+KN08sDzyENa/aoZXGq
	lWLl852K4sl4CtaNhWa+pnAt0eWAQWiiyErPQtdbdejGLgTO56paq79BAUXKLyCUPB/GWKTLWkJ
	LeUdbfIES/jHu
X-Google-Smtp-Source: AGHT+IHhXDTTL9IQxG6AeE/7Rhc+nTeeWJszgfYp5mAP+Tad2iQqBJ0bjydFNuMUl8FB8KiS/+Y1pg==
X-Received: by 2002:a17:90b:1a8b:b0:30e:9b31:9495 with SMTP id 98e67ed59e1d1-3134cfc9fd0mr624175a91.9.1749169724848;
        Thu, 05 Jun 2025 17:28:44 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603506d4dsm1778845ad.235.2025.06.05.17.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 17:28:44 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 6 Jun 2025 00:28:42 +0000
To: Anisa Su <anisa.su887@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jonathan Cameron via <qemu-devel@nongnu.org>, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 00/10] CXL: FMAPI DCD Management Commands 0x5600-0x5605
Message-ID: <aEI2OqYwgTLw4KsY@deb-101020-bm01.eng.stellus.in>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250520143947.00000337@huawei.com>
 <20250530152655.00007132@huawei.com>
 <aD3jkRBHmbdc9QmD@deb-101020-bm01.eng.stellus.in>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD3jkRBHmbdc9QmD@deb-101020-bm01.eng.stellus.in>

On Mon, Jun 02, 2025 at 05:46:57PM +0000, Anisa Su wrote:
> On Fri, May 30, 2025 at 03:26:55PM +0100, Jonathan Cameron wrote:
> > On Tue, 20 May 2025 14:39:47 +0100
> > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> > 
> > > On Thu,  8 May 2025 00:00:56 +0000
> > > anisa.su887@gmail.com wrote:
> > > 
> > > > From: Anisa Su <anisa.su@samsung.com>
> > > > 
snip 
> > Anisa,
> > 
> > Ideally I'd like to get the majority of this upstream once you post
> > a v3.  To do that I'd like to break the dependence on mctp_i2c in patch 2.
> > These commands are equally valid via a switch-cci (and that path to the
> > fm owned ld_mctpcci is already upstream).
> > 
> > If you could send it as two series. One of which sits on upstream and
> > doesn't include the i2c_mctp part and the other of which is applied once
> > that support is available in my tree that would be great. I'll squash
> > the i2c_mctp part into the patch that adds support for that in the
> > first place.
> > 
> > I'll deal with rebasing needed for other command introductions etc.
> > 
Hi Jonathan,

I applied the v3 patches (which are based on ToT master) on your latest
published branch cxl-2025-03-20 + Fan's patch fixing dc extent tracking
and then edited the first patch to add the i2c_mctp stuff and rebased
the remaining patches on top.

Would it be easier for you if I send you those?

Let me know, thanks!
Anisa

> > There are just enough open questions in this series that I haven't done
> > this rework directly (though I did start doing it - hence the missing
> > include note in one of the patches).
> > 
> > Thanks,
> > 
> Sounds good, will do :)
> 
> Thanks,
> Anisa
> > Jonathan
> > > 
> > > Jonathan
> > > 
> > > 
> > > 
snip
> > > > Anisa Su (10):
> > > >   cxl-mailbox-utils: Move opcodes enum to new header file
> > > >   cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
> > > >   cxl/type3: Add dsmas_flags to CXLDCRegion struct
> > > >   cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region Config
> > > >   cxl_events.h: Move definition for dynamic_capacity_uuid and enum for
> > > >     DC event types
> > > >   hw/cxl_type3: Add DC Region bitmap lock
> > > >   cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
> > > >   cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
> > > >   cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
> > > >   cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release
> > > > 
> > > >  hw/cxl/cxl-mailbox-utils.c   | 649 +++++++++++++++++++++++++++++++----
> > > >  hw/cxl/i2c_mctp_cxl.c        |   6 +-
> > > >  hw/mem/cxl_type3.c           |  41 ++-
> > > >  include/hw/cxl/cxl_device.h  |  24 ++
> > > >  include/hw/cxl/cxl_events.h  |  15 +
> > > >  include/hw/cxl/cxl_mailbox.h |   6 +
> > > >  include/hw/cxl/cxl_opcodes.h |  72 ++++
> > > >  7 files changed, 724 insertions(+), 89 deletions(-)
> > > >  create mode 100644 include/hw/cxl/cxl_opcodes.h
> > > >   
> > > 
> > > 
> > 
