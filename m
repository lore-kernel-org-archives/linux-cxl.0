Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031AD60263
	for <linux-cxl@vger.kernel.org>; Mon,  4 Mar 2024 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573755; cv=none; b=HrViWuOJCXedsNVImolxObl6byBvkEoXZyAxBImVn+CpEY5gKgMQXeFsXDBLsPpOB5yCLCa1HEDoKSkkYZJ1MKu2m6WDVKu2xQix0Q8DGkF604w9+m9eYD0yjYFwliMWpzLa7GnUovbKj2kMLwf4UADffarZ+GfGvcSax1VthyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573755; c=relaxed/simple;
	bh=CJmPTk46KMj+fWdS88MNpJdQqIMkENVZWY8Lu5otFJc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJlwyIu9bexKr4BGUDxzUiyhXzBuwIZsvs4BadcumEgeIvD4XoOBDvf1fvd+33dMq7nS0K3IoyjzSQs6qaZIzVFhQbL7TBmI02+CpbVczEYaOfK0qxut3GpjPqvwX9j8HZC4qKTtK8iE2jNFscwN5oS3P22FHNhCRitCjcdYZvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFJ6Ftcu; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFJ6Ftcu"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-608cf2e08f9so51264657b3.0
        for <linux-cxl@vger.kernel.org>; Mon, 04 Mar 2024 09:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709573753; x=1710178553; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=49d9IAE1DJB4fKfr/UgeNRcP4hLs0HGBVdcf75tkwvk=;
        b=mFJ6FtcunPGXQC8K4W/32tzp829LC3OXvlgcqXOw17t+O//0cez3uImHCaJDEDri//
         llf+Fb6xzTljf8GLUVyI6bpsMkaAnYIzo0Fy0RD1rwi803joYvjKbFsSWvFnPPzaKt8b
         ZBsEkSa5knq7lyeMf391cwNb8Zcbr6cVlnFjjxJRkzEZwYP/0DwhO3BKXpLf3eyliOnD
         Lo5+ExOnidGY5F9zuQ/GH1wIIoN9TXdNQS6r4+mtN4TPQF2pa+tV83hbxhjtyX8gLFWr
         A1BvlpA3iwLa27YAvrJdnbk5+Rkw0wFKoxrU6FjO/8O/EpdSxiDqnbzAj+KWb+TxvjNR
         u8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709573753; x=1710178553;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49d9IAE1DJB4fKfr/UgeNRcP4hLs0HGBVdcf75tkwvk=;
        b=aZs2QTgMWnHj6sZeLd5l5CA9dNBlPcPLRbHHqlb1SOxhZamBrC96lUKQyzcCsxQjjM
         F8yWkFPSPTZhiL0H0WWZ45REr4DSspZZIKJQwh6rpEphCpCQMBX8eF/2d9ria+5ImlY+
         mhxQnrB/mS22jCrM5xi7botsWW0ectqe/cp/ebpQPjYr8mAkvOwgxCv7rRV8UHdf6Arv
         q6c7OsQz7U20gP39VSWNGuiGjTuXU+qAeeNPvbFeUA5K4TsUfbu/OP9jYRqQENdwE7sK
         iwKAm+s1eHDmb3obp4UaBCpNL5JYCKAElWCX8u7w07IGkFs+F2B0cZnD0KqR1aTLYXC3
         3DOA==
X-Forwarded-Encrypted: i=1; AJvYcCWVx0n384yj3taP044R0nu3lhs5aF9Lrg30IsN/AadfdU4GraSM983jJwfHDzueQ/l50KNkBcd+fqdJ9A7KrQgeK5tWVPNJJRiJ
X-Gm-Message-State: AOJu0YxNvB8CkkOsPmd+nBGjVcs/4s3bnUJckm1nlrSA2atkmln4Fivx
	8oa3OtY0jpmJr4nV6uskBapaKpkkWIsOEWSuIFBThMZzLMyQ4uBf
X-Google-Smtp-Source: AGHT+IE3DUAH5SuCKalB5QdXYLGfxv8xiTKi9q/Z3pLebmewcUhJt8pJp4dEXgo5SHNnWmRnWYY6NQ==
X-Received: by 2002:a81:a54a:0:b0:608:fa36:1c27 with SMTP id v10-20020a81a54a000000b00608fa361c27mr9465551ywg.23.1709573753025;
        Mon, 04 Mar 2024 09:35:53 -0800 (PST)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id w84-20020a814957000000b006096dafea6fsm2667802ywa.62.2024.03.04.09.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:35:52 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 4 Mar 2024 09:35:50 -0800
To: =?iso-8859-1?Q?J=F8rgen?= Hansen <Jorgen.Hansen@wdc.com>
Cc: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"gregory.price@memverge.com" <gregory.price@memverge.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"a.manzanares@samsung.com" <a.manzanares@samsung.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	"nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v4 02/10] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Message-ID: <ZeYGduNSn4WGzOz5@debian>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-3-nifan.cxl@gmail.com>
 <8a141940-86fd-43c8-8834-a25b0d1e79fe@wdc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a141940-86fd-43c8-8834-a25b0d1e79fe@wdc.com>

On Mon, Mar 04, 2024 at 12:40:18PM +0000, Jørgen Hansen wrote:
> On 2/21/24 19:15, nifan.cxl@gmail.com wrote:
> > CAUTION: This email originated from outside of Western Digital. Do not click on links or open attachments unless you recognize the sender and know that the content is safe.
> > 
> > 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Per cxl spec r3.1, add dynamic capacity region representative based on
> > Table 8-165 and extend the cxl type3 device definition to include dc region
> > information. Also, based on info in 8.2.9.9.9.1, add 'Get Dynamic Capacity
> > Configuration' mailbox support.
> > 
> > Note: decode_len of a dc region is aligned to 256*MiB, divided by
> > 256 * MiB before returned to the host for "Get Dynamic Capacity Configuration"
> > mailbox command.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >   hw/cxl/cxl-mailbox-utils.c  | 110 ++++++++++++++++++++++++++++++++++++
> >   include/hw/cxl/cxl_device.h |  16 ++++++
> >   2 files changed, 126 insertions(+)
> > 
> 
> [snip]
> 
> > 
> >       /* No separation for PCI MB as protocol handled in PCI device */
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 3cf3077afa..6df7fecdf1 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -422,6 +422,17 @@ typedef struct CXLPoison {
> >   typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
> >   #define CXL_POISON_LIST_LIMIT 256
> > 
> > +#define DCD_MAX_REGION_NUM 8
> > +
> > +typedef struct CXLDCDRegion {
> > +    uint64_t base;
> > +    uint64_t decode_len; /* aligned to 256*MiB */
> > +    uint64_t len;
> > +    uint64_t block_size;
> > +    uint32_t dsmadhandle;
> > +    uint8_t flags;
> > +} CXLDCDRegion;
> > +
> 
> To be consistent with the naming of extents, and functions defined later 
> on, shouldn't this be CXLDCRegion (DC instead of DCD)?
> 

I was also thinking about it and a bit lazy to make the change until
someone points out. Now I have a good reason to make the change :-).
Thanks.

Fan

> >   struct CXLType3Dev {
> >       /* Private */
> >       PCIDevice parent_obj;
> > @@ -454,6 +465,11 @@ struct CXLType3Dev {
> >       unsigned int poison_list_cnt;
> >       bool poison_list_overflowed;
> >       uint64_t poison_list_overflow_ts;
> > +
> > +    struct dynamic_capacity {
> > +        uint8_t num_regions; /* 0-8 regions */
> > +        CXLDCDRegion regions[DCD_MAX_REGION_NUM];
> > +    } dc;
> >   };
> > 
> >   #define TYPE_CXL_TYPE3 "cxl-type3"
> > --
> > 2.43.0
> > 
> > 
> 
> Thanks,
> Jorgen
