Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8C74F85CC
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632386; cv=none; b=OscYnNx+orJE/ynywUYLlJmjU6zln6Girrj/5jFVoFg3oZWvoK5+BUt2XLawUezNLhxDZEFw/1KzNSg8mKazR/c3VHuzg6UKfuziUzjBvVBZ9xST3jqGAQx5VxGn98Vv5FVDs22Vfb7nt6+EI/1qVPiZ5hrZK4l++MDC1Z3WQgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632386; c=relaxed/simple;
	bh=vVyo1j08mYh7DYXyQ06mBS/NbsBsdj1GdZx+lMLOB1E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBzPiApFXgbVxIy2ciJMPtSRgdJm+M/DXg2NmTIUwQ1gbTYpTNUBn3HREnyWJdbsAF+4xbK36TsLlRVKmKybnOoGkzce/T21v18vGzu95I2Oww4wPojcI4/7LLE5zbAZqTWLWWaZD0YNUIpIW05Va8TSIzKYYDvhnAsKiUeAH6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHgnWlYT; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHgnWlYT"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66fb93aee5eso3791089d50.1
        for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 14:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790632383; x=1791237183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SRF7B4EW3GAD1ucl0VIA268iRxmAftV67/A9sM8LOIU=;
        b=LHgnWlYTZVHCQ35/PI2VmG5acFxR/3fzNukqPeFf8gVioz5HxRpxapdRLeeH8OIoGd
         IFNnKVJ861zlf0/JvdICmWYSPbhvynKpqYG/rQsBIQq0Yl9843ed+fBg828qhxlR1VnI
         5AWD7mL/g/gXLcRbUq5mp9YyH2w7f4haMysep2z4oKU5VsxGXSaMLIDqK3BjH6kcGgVF
         Em/CFbTfGIivEUWpGJzhDJTp/AWvyweqtWRIGJ2pPzn3C4925XWL3cMYQL/vaZzp3oBa
         aKKrHQMcmZWsZLNp52FXUd1xfeCUgbrsOQHQ1aOsABlAa+JW7SCvH7+7H9vw/CA1gyfO
         OT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790632383; x=1791237183;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SRF7B4EW3GAD1ucl0VIA268iRxmAftV67/A9sM8LOIU=;
        b=GZA8rR9gvr6gOTAh/sIBTSw+2oi0AmjmR0COAwIxoj0jRd/C8AEX8qRzs4uUIuqEYk
         uSCwPC3CPGuIRsY5L+YNMv0AiglY34W4GMY1mxISv2Z4/3yJBuMs6Wc2ml05ai9wVMGR
         bpd3KhAghkj1fFkAZO9DQ6JoW7NmfZVE5zXCMSfPz5+EDFFQCUk3WrkHukzm0J1k9COK
         PWWpkwnnlsQhAOc0HeGkaP58kR7rQWYMOjEWMysGRw/g7Ci4oG948bTYFyP0tcMbbMK8
         3GtHKxTo+XAVtAeB6mbhbergvX6K0LqvDFGpqkMg4oWlkyGjVRkJ2HgH7/REXJVA0E4F
         IyBQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdHoD8ioTqHObGwkk5JgILhROK41e6wO8Q6NTepl/8fRRVFkn62HJpFR/Uw4lrVDJy5OpcX1lJlyU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRyBQ+drfmWHLiWjNEUGTtisLez/upQw9Lht4U72UDF/KXXWKB
	YVkbqDgH4qvcI4ekV5djng+A4NW08BkIIJSpp4BKg62P8c9BsBhcvvCGXj4bgw==
X-Gm-Gg: AYBFou2kbwuIX9GKfiU1fZTcppx7a0Pru1vwX0Nx7Cp/ko9yWb06EbU6NO7vdpXVM07
	jdiBaiyPRFspUFZr98Am1nBUjy1SSLZyZbaSt0Aezd9S3RMis6Q1iX9icWkPRVQMLgsINFioRKC
	xVgnQXqa8MMfTE9TmvQfraV3v5XasZEZcICKeO13ZORdlxhwsshJlMiilG5hIFQaCkuXHb31M0Q
	18lx3FxaHtaOHLJp2PSv/+z3yX0WCjfB/k7qcmiU2cjZlcKN2ab2l4MXkc1SNkjmd+Fj8l0Fjqt
	UprurO2KQnOGfJx1KyQrmnb4mP+PjABmDOyOjQypLDWYlWe2lhPmD411UOfg7kn9YcKIm6xTGZh
	sJIuHqF7SibNee5t426ypIWBUxiLOl2BBx7O9uudqBVSBiGrZ9hlxjOINHmEVxnXturTLqlCbbz
	MOFoqu7+KXJD/in48BS3uyOc68xKKYCP06ssPzNemG3549LMlRb26s9y/+SDy5WfavDM5CpzMPn
	VsL4P6HNlKLcq8n/xjjLaxuVrmGCS6XxolCK4Ima0/9doncJ9A5oWxCtmMD
X-Received: by 2002:a05:690e:1c05:b0:675:45c6:80c2 with SMTP id 956f58d0204a3-67545c68e88mr1771349d50.92.1790632383502;
        Mon, 28 Sep 2026 14:53:03 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6755f26183fsm506207d50.18.2026.09.28.14.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 14:53:03 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 28 Sep 2026 14:53:00 -0700
To: Dave Jiang <dave.jiang@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v14 8/8] Documentation/cxl: Document DPA partition layout
 and ordering rules
Message-ID: <arrhvCTbdD7va7Wm@4470NRD-ASU.ssi.samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-9-anisa.su@samsung.com>
 <9ffddb3d-9b22-4fe4-b355-bbad82f4b8aa@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ffddb3d-9b22-4fe4-b355-bbad82f4b8aa@intel.com>

On Mon, Sep 21, 2026 at 03:02:49PM -0700, Dave Jiang wrote:
> 
> 
> On 9/18/26 1:30 PM, Anisa Su wrote:
> > DC Partitions complicate DPA ordering. Add a DPA Partitions section to
> > cxl-driver.rst describing spec-mandated and Linux requirements for the
> > layout.
> > 
> > maturity-map.rst breaks the DCD entry into sub-items so the map shows
> > what this series lands: partition enumeration is [1], event handling
> > and DC-backed DAX regions remain [0] until the follow-on series enables
> > them. The parent stays [0]; nothing is usable yet.
> > 
> > Suggested-by: Gregory Price <gourry@gourry.net>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> > Changes:
> > [jonathan]: drop paragraph describing "support for additional
> > dc partitions may be added later..." to avoid predicting future work in
> > documentation
> > [davidlohr]: add DCD sub-items to maturity-map.rst so a multi-step
> > upstreaming shows users what is there and sets expectations.
> > ---
> >  .../driver-api/cxl/linux/cxl-driver.rst       | 35 +++++++++++++++++++
> >  Documentation/driver-api/cxl/maturity-map.rst |  4 +++
> >  2 files changed, 39 insertions(+)
> > 
> > diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> > index dd6dd17dc536..eb4de2a9a9af 100644
> > --- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
> > +++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> > @@ -181,6 +181,41 @@ A Memory Device is a discrete base object that is not a port.  While the
> >  physical device it belongs to may also host an `endpoint`, the relationship
> >  between an `endpoint` and a `memdev` is not captured in sysfs.
> >  
> > +DPA Partitions
> > +~~~~~~~~~~~~~~
> > +A memory device presents its capacity as one flat `Device Physical Address`
> > +(DPA) space divided into `partitions`, which Linux lays out in a fixed
> > +order::
> > +
> > +  DPA 0                                                     end
> > +  +---------------+---------------+---------------------------+
> > +  |      ram      |     pmem      |       dynamic_ram_1       |
> > +  +---------------+---------------+---------------------------+
> > +  part[0]         part[1]         part[2]
> > +
> > +Part of that order is required by the CXL specification and part of it is a
> > +Linux choice.
> > +
> > +The `ram` and `pmem` order is mandated.  CXL r4.0 section 8.2.10.9.2.1 "Get
> > +Partition Info" (4100h), Table 8-310, mandates that volatile capacity starts
> > +at DPA 0 and pmem starts at the DPA immediately following it.
> > +
> > +Dynamic Capacity partitions only need to be 256MB aligned according to
> > +CXL r4.0 section 8.2.10.9.9.1 "Get Dynamic Capacity Configuration"
> > +(opcode 4800h), Table 8-347. So a device could leave a gap between ram/pmem
> > +(static) capacity and its first DC partition, or between one DC partition
> > +and the next.
> > +
> > +Linux chooses not to support gaps between static and dynamic capacity: the
> > +first DC partition must begin at the DPA immediately following static
> > +capacity -- after pmem, after ram on a device with no pmem, or at DPA 0 on
> > +a device with no static capacity at all.
> > +
> > +Currently, only one dynamic partition is supported. A device may report up
> > +to eight (CXL r4.0 Table 8-346); Linux configures the first and exposes it as
> > +`dynamic_ram_1`. Gaps between DC partitions are not checked, since only the
> > +first is used.
> > +
> >  Port Relationships
> >  ~~~~~~~~~~~~~~~~~~
> >  In our example described above, there are four host bridges attached to the
> > diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
> > index 282c1102dd81..fefd31899229 100644
> > --- a/Documentation/driver-api/cxl/maturity-map.rst
> > +++ b/Documentation/driver-api/cxl/maturity-map.rst
> 
> Maybe hold off this commit for when everything goes in? Otherwise it's weird that there's documentation but no code.
> 
On Patch 2 and 8 from v12, which add the dynamic_ram_1 partition and enforce
that there is no gap between static capacity and dynamic, I received feedback
that it's not clear whether this is from the spec or a Linux rule: 

patch 2:
https://lore.kernel.org/linux-cxl/anIMLnbG_KmRfjv6@gourry-fedora-PF4VCD3F/

patch 8:
https://lore.kernel.org/linux-cxl/anFCdsSo6dvxfFrZ@aschofie-mobl2.lan/
> > @@ -150,6 +150,10 @@ Memory-pooling
> >  * [1] Hotplug of LDs (via PCI hotplug)
> >  * [0] Dynamic Capacity Device (DCD) Support
> >  
> > +  * [1] DC partition enumeration / configuration (Get DC Config, CDAT DSMAS, event interrupts)
> > +  * [0] Extent add / release event handling
> > +  * [0] DC-backed DAX regions
> 
> I would just update maturity map once when the entire DCD code is in.
> 
I received the feedback from v13 that if the DCD series is going to be split up,
"the maturity map should indicate what is there and help users understand and set 
expectations."

https://lore.kernel.org/linux-cxl/20260908102124.2231730-2-anisa.su@samsung.com/T/#me40889025337fdd9584182bf80cc6dbca45aec9d

But I could squash this with the documentation commit at
the end of the full series? https://lore.kernel.org/linux-cxl/20260625112638.550691-32-anisa.su@samsung.com/

Thanks,
Anisa
> > +
> >  Multi-host sharing
> >  ------------------
> >  
> 
