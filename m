Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E804AA03B
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150788; cv=none; b=coYnWcebTT88mP7+07H+b3Bc61yMjS2Q+qBmIARw2KQEbMMMJ4LbOvrb5vgT/GESYXNMpxIxefGfAu4ExuI7HGhZh37kxMzoQERmjPEuSA/AdORfKFm/bL2G6dYHr49INz5CBr3w7ewH8hCq5zX5he8F9+BTsX7xnQLoicrSd3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150788; c=relaxed/simple;
	bh=HSe38Y4a0MAoZUs41Fg+gvsgDYx2NAIMe9nzXpVpXcA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvnIUa/MF43On9LiuTV2HgBUSivlfUntNZHCyFxo58fzVL73uqRqgPRz7SrQ++Q6rGfKTwxL/giX38MD8mt+PZyJFd9MJm6Vv8INeWCLNR7IXX5KqLDP8iHW8o/EbxZZX9KXnBStY9ZIXJJ0Jv+rnYDu6wJBicUim3u3jDWzYl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkFqFrMz; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkFqFrMz"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398c066106cso62422a91.1
        for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 11:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789150786; x=1789755586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DITXeGZ5+i+0YgYXnx+scYL/y86FP3Q/Nf2IKbPEwLQ=;
        b=EkFqFrMzNYinBa8hKg40XXz6uYSR/8FkK5aZ6HzQBLWJxYgpq2iYfVeplBXekD8P72
         zhJ5bUJqP6+/WIcGSclsUNDngEexrxHKdaEyUpZnJYqGQ2DVYrxjA7kQ63Xo0ozp/oFS
         Xy+jURx+ZfofpHH776t12y2ak046IdoTWER6HOHwnwdcArv3vgSjwcxG59WV1aAtySPJ
         trlk4GCwB9U+q6KVE5KVChKAo9Xd7iTtBq/O2rOaTnxApL552nThsRqJNhSKd0n0FK30
         kMpFfx9SK4rR9JyOBEJNMDP5TYHqiYNdnfsGN/5Jo/y7lS84At1HH35bYNBl4HOuSnpX
         Iq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789150786; x=1789755586;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DITXeGZ5+i+0YgYXnx+scYL/y86FP3Q/Nf2IKbPEwLQ=;
        b=phwvoPWkTzJfSGkdrNdT0iZomkLmqNV6AOzlxaFBP05tz9F4s3dUBw57N0jXpbzOwr
         R2Mu6pd8oU0hJUJvoJxIdcWsyv44s5rGzAxMcxxKTCsuOqmmHyiLUZQr5QKz2eoUZFoV
         OFA6N5UuVmTP6wJeeocLh5NmUQHCNDD08hZq5vnt9Evb6t23Qc7CLQl5gMCHDTEQeWP1
         oi0JWM+TUxsuVxF0I2BS+V2PNnXIevohQbjQM5+VMV9HXdDNCKDHsx33lMe4Hr1SGtgW
         k5oOWr1uB9WcSkC76b+lk/h+hse5rlFdtzW4/vlqRVf48VeL9mmB1pGT71o9d/ccb1Oh
         P74Q==
X-Forwarded-Encrypted: i=1; AKwUvBy8exbm9yT+YaLsFkU3yRP4lxgbMLXNjd8f6rCbYRdTjCxwu5dvcn7c0MJKuhvHa8kl2pSCpSo+Bcg=@vger.kernel.org
X-Gm-Message-State: AFuF++nHVC1vjHZoqhm/epF9V/OLRSar7v8jTS0TgK28DUnL9lQWKBJO
	VjXEKBFEpyGktuqrhsCWRLV8ItvQE31zIIjTjnStEhc1SAVfYhqEIie2
X-Gm-Gg: AYBFou1+G9cvBtEdfWdWqJq03U177Ikoo4LlXPAqge2A7fb9B+8tkLdIc2aNgB7urRg
	zWsQefqNpUrkrSZmsGhA1j51S8o33jZe8sK3sgcDIziNXNZusYUFhLPnvGWAznEEk2P0OYdms62
	tkwdChB2HV0smonHsHvZlZOoP/lUV2iP8ajNP/2JrjoXyfR4Kutim8X1ijwWq4MfwHpi2OGhD86
	S8IenoZv9LhDhLoNWQp6VKGd24OzqFz28veJqpsRQiyDZbhqlmr5ccNPtjyAJVHu1Y0ggKNrN/i
	yIbHjwKuE/F/H1R0Xb7Ra0vogu473mno2VUTT1lT7ZLR7TtPfjIB3DVpv6eO+SCdGAn8VztywpU
	Dw9th4EPtsMzEA/YAf75YN7MPzkLWq7GywMz9SrsI3NJf6Ilkzy9COwAfCVF2Xxs01FA/hLWj2p
	OUqkuUVJLw9DjaIbZlcS7M1Q7S94oUkz11OFBVxxSWvkIspr5kLZ+SMSY8Z8yVNvvnqwtRj7Kj+
	NeOUYK21eABSd8hryw1BWrPng==
X-Received: by 2002:a17:90b:380a:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-39d9bd63e1bmr8345250a91.8.1789150785735;
        Fri, 11 Sep 2026 11:19:45 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95424fccsm6161078a91.10.2026.09.11.11.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:19:45 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Sat, 12 Sep 2026 03:21:01 +0900
To: Jonathan Cameron <jic23@kernel.org>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	alison.schofield@intel.com, dave.jiang@intel.com, gourry@gourry.net,
	icheng@nvidia.com, ming.li@zohomail.com, vishal.l.verma@intel.com,
	dave@stgolabs.net, benjamin.cheatham@amd.com,
	Ira Weiny <iweiny@kernel.org>, Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 6/8] cxl/mem: Configure dynamic capacity
 interrupts
Message-ID: <aqRGjbwEE2C5-zpz@cxlqual>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-8-anisa.su@samsung.com>
 <20260908231414.427c677d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908231414.427c677d@jic23-huawei>

On Tue, Sep 08, 2026 at 11:14:14PM +0100, Jonathan Cameron wrote:
> On Tue,  8 Sep 2026 03:15:10 -0700
> Anisa Su <anisa.su887@gmail.com> wrote:
> 
> > From: Ira Weiny <iweiny@kernel.org>
> > 
> > Dynamic Capacity Devices (DCD) support extent change notifications
> > through the event log mechanism. The interrupt mailbox commands were
> > extended in CXL 3.1 to support these notifications. Firmware can't
> > configure DCD events to be FW controlled but can retain control of
> > memory events.
> > 
> > Configure DCD event log interrupts on devices supporting dynamic
> > capacity. Disable DCD if interrupts are not supported.
> > 
> > The DCD event log is not drained here. cxl_event_drain_mask() reports
> > only the logs the driver can service, and the DCD bit is added by
> > the patch introducing DCD event handling. Until then a DCD interrupt
> > wakes the event thread, which finds no log it owns and returns.
> > 
> > Care is taken to preserve the interrupt policy set by the FW if FW first
> > has been selected by the BIOS.
> > 
> > Based on an original patch by Navneet Singh.
> > 
> > Signed-off-by: Ira Weiny <iweiny@kernel.org>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> > Tested-by: Junhee Park <jh9934.park@samsung.com>
> > Tested-by: Heesoo Kim <habil.kim@samsung.com>
> > 
> 
> One minor thing inline.  Otherwise LGTM.
> 
> Jonathan
> 
> > ---
> >  drivers/cxl/cxl.h    |   4 +-
> >  drivers/cxl/cxlmem.h |   2 +
> >  drivers/cxl/pci.c    | 124 ++++++++++++++++++++++++++++++++++++-------
> >  3 files changed, 109 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index cab8ce39f465..d6e02bd0cf50 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -192,11 +192,13 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
> >  #define CXLDEV_EVENT_STATUS_WARN		BIT(1)
> >  #define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
> >  #define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
> > +#define CXLDEV_EVENT_STATUS_DCD			BIT(4)
> >  
> >  #define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
> >  				 CXLDEV_EVENT_STATUS_WARN |	\
> >  				 CXLDEV_EVENT_STATUS_FAIL |	\
> > -				 CXLDEV_EVENT_STATUS_FATAL)
> > +				 CXLDEV_EVENT_STATUS_FATAL |	\
> > +				 CXLDEV_EVENT_STATUS_DCD)
> 
> See below. I think this define has become a bad idea, making things
> more confusing rather than simpler.
> 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 7b754af2168d..1ea505b1f40e 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -510,11 +510,23 @@ static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
> >  	return true;
> >  }
> >  
> > +/* Event logs the driver drains: standard logs when native_cxl */
> > +static u32 cxl_event_drain_mask(struct pci_host_bridge *host_bridge)
> > +{
> > +	if (host_bridge->native_cxl_error)
> > +		return CXLDEV_EVENT_STATUS_ALL & ~CXLDEV_EVENT_STATUS_DCD;
> 
> This seems a little backwards.    Better I think to just list the logs that
> are supported. There are other logs coming and I think we'd want to opt into
> them deliberately like you are doing for DCD rather than have them caught
> by the _ALL define.
> 
> 	if (host_bridge->native_cxl_error)
> 		return CXLDEV_EVENT_STATUS_INFO | CXLDEV_EVENT_STATUS_WARN |
> 		       CXLDEV_EVENT_STATUS_FAIL | CXLDEV_EVENT_STATUS_FATAL;
Applied.

Thanks,
Anisa
> > +
> > +	return 0;
> > +}
> 
> 
