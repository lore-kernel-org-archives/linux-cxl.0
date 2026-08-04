Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE414734EC
	for <linux-cxl@vger.kernel.org>; Tue,  4 Aug 2026 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785859258; cv=none; b=beg0xGlyzdqL9uShys9+cosILCyfJ7y1//bQ07RYNAoVg+HoVW1pkXzz+hVRxUdUnCRCuJFSxkEg01Hdkqe/0B00nujvD26lr7MC7EdXOUvI2QAWt32f3iMvZS9myFvSmx3YwzuL8SscHKJHyjK+4oiASQWJFJ7f394Cly9tT6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785859258; c=relaxed/simple;
	bh=LZRF7XvkTJh5mVX/xE5sHCqUfQy1DFUWTGiWnGs02HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOyvzpbDiDUBYiOmnJPwOTZURb3zh9bFPOqRMk79LEm658+nwsjH6WofY1RaqFYSwDhCEOJZSqA8CLGkNT5JsT6uNhei92tnVWBQiiWLEqzWA4wk9OdFL378qeVfwnkge6JMjGKr1ZTU2pGnBEGgsa/WF/BivfgXWeDbtEhg4PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QCoD4kU4; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QCoD4kU4"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e57a753f9so350685a.2
        for <linux-cxl@vger.kernel.org>; Tue, 04 Aug 2026 09:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785859255; x=1786464055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gIywxDE/xXwcJzhaWMUxRZtRSyfvUoSn8AJ9dIdrl7c=;
        b=QCoD4kU47fC6tnc+jOaXR/ahRnI1YI5tag82KpGA3+v6mv3fgijGxVpMKfNN1NI2mF
         kR7UVvsGSYrlj3/WrOznluJmHqIh8FI0sHivv2WcLE49cQyz067vAjVldgTgz+SmeOdD
         ANrd1YaqzBbI65ha8MSWrWLMuAOq9mXS+9bQLJ05m11JJZSY4Y79atthHeKIIRORzxO4
         tErbm3AEd+m3BsWiouwz8JdIrGq9RwtU2yS8pp3jX6Ep0nHlITeWJ6KzgiZxfnKuQEJE
         hR9+1S0zUxHR1u6ZyXS96iVPnVoCjs9Kmq6L/nenhXxyYeFH+fGIG8fHzEheP+b7tsIe
         brbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785859255; x=1786464055;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gIywxDE/xXwcJzhaWMUxRZtRSyfvUoSn8AJ9dIdrl7c=;
        b=Uxu1GjPLHFx5YtiNUhtcK+OlHjQU6Pm9JhxbJg5ENRYiVrzd/n0KCQd6Ajea/80QA/
         kdJsGEitFz4MxE2biB7RxsTKQ0LM9SaRNgQPwCo68jCQLXrPemNGJQxpzw8XP/APMzBO
         6vEC3+ouglaqQqZ1+85zmBquOvpZ+vydviE1WrQOOLIfzKJhiRm+xPVE+U2d8uneDTj5
         77LW2/3x/MDi7zNh36n/l6dDJ2xoaJdGK3uzRR7IMiyPUEbNInpnT4uhGEFop9EPBOym
         /iXT8+hDjAVq6dxiq+piA7NCBWLiKm4mckQezoY6YDmEYBLv876ktDLVsLzUxKjyjiys
         Hjyw==
X-Forwarded-Encrypted: i=1; AHgh+RoDeI91Mb63/7I16qXXpZbU0ULEdxr089z0d3J4v/SodToavKJVEnY17Wqmhmdl8xN1Kfuvi4maHIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtq655SENwN1m7fmtSQMWCHZmzDTiCLt2MEW+LYzXIT0ClrZY/
	pS2NzgZWdVkrnG8s6jvYK99n/rXGGWrg1AwBuP5k6T8j8qfY9kaxWw4DueyuaaCUmwQ=
X-Gm-Gg: AR+sD11gG2hlDql5FZHgPzB4M+KhEgRnOhX8LSIyWOd8RYd276XXl9sGaWiE/YGOptL
	p7sB/mAnNPER1mJglDrSrZWZpKRRJNPQWtk/1490Ut9OiUnROoMPU3PgnLoTgljpQmVD/bSFjiv
	RdLGUMnxv+/TKqrdcKfUkAy6UoOsIeos5m0WG366p8AmPflpNbImHy2TU90nqlGTlIWj0brE86g
	7xNszFqFGLPPKethxnd8XiMF7ZbEhzjBZKCf+VhQ+JxmColnMbogr8fEto0f4XdTwsuxRnbWtht
	DLQ8v4tFeI01jmQkMPC8aHp0tpubZ+c3mmJvH8J3NBm9jPjDf6Ce8fure6u1KiDnBDiddYLM20K
	8LyTmt2x9SJ5a+HRbzuFNVGMBysJAb5hifnuKAysiyZikBUB8HRJ9F8xydTpfxQJ6REUHtAnPwZ
	VIt0yad5r9EpRHoFaiIMdxQ1qggGPmqSr2hqTzXWprKKqU0Q8zQJEPyJHu1xSsKIJVCG1thfYik
	WXpbKz5GwKFAeie/WjpPC7mxL1eDW7o95rR5yCuSCMF
X-Received: by 2002:a05:620a:a189:10b0:930:f271:6784 with SMTP id af79cd13be357-934a0ab819amr2203775585a.38.1785859241734;
        Tue, 04 Aug 2026 09:00:41 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908800ae043sm4255856d6.40.2026.08.04.09.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 09:00:41 -0700 (PDT)
Date: Tue, 4 Aug 2026 12:00:39 -0400
From: Gregory Price <gourry@gourry.net>
To: Anisa Su <anisa.su887@gmail.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Fan Ni <nifan.cxl@gmail.com>, Li Ming <ming.li@zohomail.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Ira Weiny <iweiny@kernel.org>, Benjamin Cheatham <benjamin.cheatham@amd.com>, 
	Wonjae Lee <wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, 
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [PATCH v12 2/8] cxl/mem: Read dynamic capacity configuration
 from the device
Message-ID: <anIMLnbG_KmRfjv6@gourry-fedora-PF4VCD3F>
References: <20260731084901.1512819-1-anisa.su@samsung.com>
 <20260731084901.1512819-3-anisa.su@samsung.com>
 <anENkWO2G5tdPtNb@aschofie-mobl2.lan>
 <anGtDPQ41N-SGQFG@AnisaLaptop.localdomain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anGtDPQ41N-SGQFG@AnisaLaptop.localdomain>

On Tue, Aug 04, 2026 at 02:12:44AM -0700, Anisa Su wrote:
> On Mon, Aug 03, 2026 at 02:52:17PM -0700, Alison Schofield wrote:
> > On Fri, Jul 31, 2026 at 01:48:07AM -0700, Anisa Su wrote:
> > > From: Ira Weiny <iweiny@kernel.org>
> > > 
> > > Devices which optionally support Dynamic Capacity (DC) are configured
> > > via mailbox commands.  CXL r4.0 section 9.13.3 requires the host to issue
> > > the Get DC Configuration command in order to properly configure DCDs.
> > > Without the Get DC Configuration command DCD can't be supported.
> > > 
> > > Implement the DC mailbox commands as specified in CXL 4.0 section
> > > 8.2.10.9.9 (opcodes 48XXh) to read and store the DCD configuration
> > > information.  Disable DCD if an invalid configuration is found.
> > > 
> > > Linux has no support for more than one dynamic capacity partition.  Read
> > > and validate all the partitions but configure only the first partition
> > > as 'dynamic ram 1'.  Additional partitions can be added in the future if
> > > such a device ever materializes.  Additionally it is anticipated that no
> > > skips will be present from the end of the pmem partition.  Check for and
> > > disallow this configuration as well.
> > 
> > Hi Anisa,
> > 
> > "Additionally, it is anticipated that no skips will be present.." sounds
> > woogedy. The paragraph starts with a Linux limitation of only one partition.
> > and next mentions skips. Is that a Linux implementation rule, a spec
> > rule, or something else?
> > 
> 
> Sorry for the lack of clarity. The commit message has been revised to
> make it clear that DPA gaps between partitions are a Linux rule. The
> spec permits a gap: the DC region base is device assigned and only has to be
> 256MB aligned (r4.0 Table 8-347). It now reads:
> 
>     Linux has no support for more than one dynamic capacity partition. Read
>     and validate all the partitions but configure only the first partition
>     as 'dynamic ram 1'. Additional partitions can be added in the future if
>     such a device ever materializes. Linux additionally requires partitions
>     to be contiguous. Therefore, check for and disallow any gap between the
>     end of the pmem partition and the first DC partition, as well as gaps
>     between the remaining DC partitions.
> 

Is this limitation something we expect to ever change, or is it
something like "The spec doesn't disallow it, but basically there's no
good way to reason about this otherwise"?

Where reasonable, we should try to work the "Linux opinion of how this
should work" into the CXL docs in-tree so it's clear where we put
constraints in where the spec does not.

~Gregory
