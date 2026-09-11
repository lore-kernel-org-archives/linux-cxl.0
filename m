Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBD91E5B9A
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 20:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789159081; cv=none; b=TXxgv2CrXj8Q4dmnWYwR4zXO8OzDEK2rPp5Zq3EIINR7J1z5+o4RBQQrvR3+pyWwx1K82J/oVs3u5oLX16PZmmYFL62jT7jzTxXSNYLmLuxzUAtxvlr97ABYCdIkA4VMleg7+AQoJwd2UZhxco6qORMF7t5nKCD9TmkldhIr+9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789159081; c=relaxed/simple;
	bh=5oKMKWJCTS2ZSoWRVj/IqGu5340nFwA1JaHEJOD/A2A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCJ0ajozLcjSAccIJ0W6FC+enBRlQJRYazcw0k9Xyemtu+nT2VNpwA4+Z5lvdhm/RMT/ZsCQl6rg7ge720N7LbYaRpgl98G7vi+6LACYs+tKOH46lpgKkp661wwVIIyx9zvMSMcpoU9JVhFU923N+nnsugFq5arty1A8b62B9X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwRQQUIK; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwRQQUIK"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso1459898a91.1
        for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 13:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789159079; x=1789763879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rO/Biwmgk9MFkzZiFkFrvaI057SIKDa0hFBd5emQIyw=;
        b=RwRQQUIKWKV0/J62D6EhQRYiU25VDmA2hwT+0fRI88QPt4cuzxOvIbfmycNwQFOd/M
         /GP6sUsLISJ52YHMpAJyAPOOOhjJPRXSNSEej0aXgh5PnD9t83EDKmV2hZwGK2qLxXsj
         LvY3lbGksuuFSAr4+g24Q4djw/7nVcVMI52jOAgONjTYE6r70D4uqx+zDRzJq/dnZ+T6
         4jSeDCxoxu/uMd4xf0McxFmOBv4v8AvZDeO5SFBadit5jJNPuarYxMrRUCgQCAvgfKpR
         5caGnbuaNhUd0QFOPGpSwWtNyCPJR/1vPT5oB0r1OUGbCoMtl28O1YlaZjK9AUKvQMvG
         mJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789159079; x=1789763879;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rO/Biwmgk9MFkzZiFkFrvaI057SIKDa0hFBd5emQIyw=;
        b=Grx5kaNgIZ/RhPuItyOqfsT3I3k2tkQMYxUk2HT4PAmVmDTova4V+BukBctl0nTX9H
         92FwQ6s6RWVXSaxCpbC90k/0h68QQaRtyli/JVsMOx+svIpBfX+VoN82xmOm5Pc7Taf+
         HFOhLxy9WvbSnwgkliW14w+SQRbgTq0US8yjG7vuUe8OVfuTJO1EthmRlY5ZX3abTcgT
         6/TwJ7XEuAy+MksBRDU+DbDd02GzjY6rLHNFFwDPbPL5zhcgTb1BIiNXpXMZc4lkl1Nz
         DOWawAPWVVmyLvuN7IDBAsvHSuBrtln6oMGpzi4bnz3+OhxWIDoQ98gtz2+lRPEKPkej
         zWUA==
X-Forwarded-Encrypted: i=1; AKwUvBx3V7HjGGyZRgbbmkRG7fWzUnusYrrz7J+Fo/KkPQS9gv6BTD56oF2FOGQwIHNVJEEuPiybFcgItU0=@vger.kernel.org
X-Gm-Message-State: AFuF++mB3BUriNKYjNQHVMxzcuDtfU8MAua8FP761Z1B4kcPWHZ0YEMH
	1Ypql7r4+/AbfsPsnZXusD0XJ4KbtuW8UaMv4l9udT7kaePGf2SA7OgO
X-Gm-Gg: AYBFou0HHeQ819bAMNrvde8ZBby6sVcot2geI6WK3SSLghn0ooa9RXm+jeU7VNXoGgA
	VAAhZklQcabqTRZpr9WWwPwr+BMoZsOCrj3G2vFvAEFG+oEu5LVSeT8qMix2YG59Fs79y8jKVST
	/p9hpgGlrq/wof72ZDErdi4gSbOrCI5v0ZDBc3rnHuw3mObgVUFTaVhTiEYBvyzCFyH8jBQ6K3G
	yyCDeRLuuA7FMk8USSc45OvInsy1dbZ3ll0OIUfPBF3UWMF8Yu7mV3A9hGysBRiA/O2P/8xVxfX
	fVtf6uWZ4oiFhXFvv1r+lyi4/X66T/Kl6Qp9OQqVMAnAw9x0Kcm0LnjCC+9p2M30V7+gPnj1Bpo
	bhQ2f3kPbyKfHTqlqH61EbgkGQiU2TpvWTKWHsvxPQKKDE0o07oW2a1yM6z31eaRMes4JbIpMLx
	0gmPkJVqXzHVKmk8q3Lf35CcZOhTc4ZOL1PIuHVNGQH5KMfh/BWQcjr5TFStDZes9K1bmMTloxy
	+53VkCBglFu9P3v4swhTMELD68g5N7yXpab
X-Received: by 2002:a17:90b:2689:b0:398:9bd1:3211 with SMTP id 98e67ed59e1d1-39d9c21eb06mr9404231a91.18.1789159079235;
        Fri, 11 Sep 2026 13:37:59 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d98e5c630sm7117581a91.6.2026.09.11.13.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:37:58 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Sat, 12 Sep 2026 05:39:15 +0900
To: Jonathan Cameron <jic23@kernel.org>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	alison.schofield@intel.com, dave.jiang@intel.com, gourry@gourry.net,
	icheng@nvidia.com, ming.li@zohomail.com, vishal.l.verma@intel.com,
	dave@stgolabs.net, benjamin.cheatham@amd.com
Subject: Re: [RESEND PATCH v13 8/8] Documentation/cxl: Document DPA partition
 layout and ordering rules
Message-ID: <aqRm8zEHPcGTwZhj@cxlqual>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-10-anisa.su@samsung.com>
 <20260908231700.1a8d53ec@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908231700.1a8d53ec@jic23-huawei>

On Tue, Sep 08, 2026 at 11:17:00PM +0100, Jonathan Cameron wrote:
> On Tue,  8 Sep 2026 03:15:12 -0700
> Anisa Su <anisa.su887@gmail.com> wrote:
> 
> > DC Partitions complicate DPA ordering. Add a DPA Partitions section to
> > cxl-driver.rst describing spec-mandated and Linux requirements for the
> > layout.
> > 
> > Suggested-by: Gregory Price <gourry@gourry.net>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> A couple of minor potential tweaks.  Otherwise LGTM
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> > 
> > ---
> > New patch in v13.
> > ---
> >  .../driver-api/cxl/linux/cxl-driver.rst       | 38 +++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> > 
> > diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> > index dd6dd17dc536..f0742d6c86c3 100644
> > --- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
> > +++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> > @@ -181,6 +181,44 @@ A Memory Device is a discrete base object that is not a port.  While the
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
> > +Linux follows the static precedent anyway for the partition it maps: the
> 
> Maybe "Linux chooses to only support...
> 
I went with "Linux chooses not to support gaps between static and
dynamic capacity: the first DC partition must begin..."

> > +first DC partition must begin at the DPA immediately following static
> > +capacity -- after pmem, after ram on a device with no pmem, or at DPA 0 on
> > +a device with no static capacity at all.
> > +
> > +Currently, only one dynamic partition is supported. A device may report up
> > +to eight (CXL r4.0 Table 8-346); Linux configures the first and exposes it as
> > +`dynamic_ram_1`.
> > +
> > +Support for additional dynamic partitions may be added if devices appear
> > +that need it, which is what the `dynamic_ram_1` name leaves room for.  Until
> > +then a device offering more than one is still usable, just not in full.
> I'd drop this last paragraph. Predicting the future is tricky, even with a may.
> Hopefully anyone realises that if something is needed Linux doesn't support
> they should propose patches to add it!
> 
Agreed, dropped this paragraph.

> Jonathan

Thanks,
Anisa
> 
> > +
> >  Port Relationships
> >  ~~~~~~~~~~~~~~~~~~
> >  In our example described above, there are four host bridges attached to the
> 
