Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D879D4D100
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jan 2024 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kytYBOnG"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d4414ec9c7so21762785ad.0
        for <linux-cxl@vger.kernel.org>; Wed, 10 Jan 2024 09:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704907868; x=1705512668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tzDNvjK6D71YuTCJZMKM5pI+L8TrbMzJbidP9fMagr0=;
        b=kytYBOnGSyjVqlz0/p5EgDRXK5GP1iJ4pFmloGaZcffQGRvaQfvQ/AlwzaPdJslBeh
         rkaKGImev/gKbq4vQ0+lJq4vL9etr2u0ci5dUGXC2vE7RTJvc6o1SnG8lsoGCb+rfc0m
         M5TUg0lMOp8KJL/rjKdd5m8DJCBomGufSiLi/XsFX3s0cEqDiEi6tN/FKBZhed9w06lx
         Nk+s8v+BMghx06q5br3VIzm6cfhPlcDIx7TbDfsKepIwFJj7SU3TQRaTJPTdccVtYjoo
         2U7P9xPIKlvE7m1f4YI0ZiVyHO8e9B8c5DxoKbYa26n3UAKqVsww9nl8DmQ5xThc+Se7
         GMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704907868; x=1705512668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzDNvjK6D71YuTCJZMKM5pI+L8TrbMzJbidP9fMagr0=;
        b=s14cQm0KxygReLfwV/GFsJSmbB8FGNZYm/rUhd5WirCg238sd0ns9nC3gTzxej0vgr
         g2tIVSolPfTphdNex2mxwusaUBTt3zoztxRktOIdhiU4VDgdx1GpXvMl/cVYn8GWU5Dh
         5Za2Z1uRrHXZH24ue0cVaKJTZdGjogr8nFJWzIfSC0Gzq8yFo7WE8UlhjhBybkia1MDK
         3kmtMQRvRWDpb9O5UHJ0fPuI/o3QgAO0jpF6jeUJHjgo2yBvoAF0Z/bfgs/aKyoKJZnj
         g0kNDmUQUPhFmiyPpzZgzzX4HzRmEVkViODAPA5pgndcHesUV0i2m1ga90ZL1MOnuuaK
         jcqw==
X-Gm-Message-State: AOJu0YyMx/5SMWUgLTHgY81/qyENl360Py2NaqnC8/n/MqihI1KcUT51
	GkFU446oLYBDkwFQ4WXmM8M=
X-Google-Smtp-Source: AGHT+IHztGsjsbtNJJFyYnofH9Np74pNcJKNH7eKGOgC2UmfzXzHYw3Kgm3nTP5NnkIsObZ9txXtlA==
X-Received: by 2002:a17:90b:fd8:b0:28d:add8:b68a with SMTP id gd24-20020a17090b0fd800b0028dadd8b68amr1010481pjb.84.1704907868410;
        Wed, 10 Jan 2024 09:31:08 -0800 (PST)
Received: from debian (c-71-202-158-162.hsd1.ca.comcast.net. [71.202.158.162])
        by smtp.gmail.com with ESMTPSA id px8-20020a17090b270800b0028dc4b598b7sm1452936pjb.55.2024.01.10.09.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 09:31:08 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 10 Jan 2024 09:30:52 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
	"Michael S . Tsirkin" <mst@redhat.com>, linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/4] hw/cxl: fix build error in cxl_type3_stubs.c
Message-ID: <ZZ7UTB8FziAglemJ@debian>
References: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
 <20231222090051.3265307-2-42.hyeyoo@gmail.com>
 <20240109174026.00000760@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109174026.00000760@Huawei.com>

On Tue, Jan 09, 2024 at 05:40:26PM +0000, Jonathan Cameron wrote:
> On Fri, 22 Dec 2023 18:00:48 +0900
> Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> 
> > Fix build errors in cxl_type3_stubs.c due to a the incorrect definition
> > of the qmp_cxl_{add,release}_dynamic_capacity functions.
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Fan, this one needs squashing into your
> hw/cxl/events: Add qmp interfaces to add/release dynamic capacity extents
> patch in the DCD series. I'll do that in my tree, but just wanted to
> make sure you noticed this so we don't end up reintroducing it again by
> accident!
> 
> Thanks Hyeonggon,
> 
> Jonathan

Hi Jonathan,
Thanks for the notice. I missed this series. 

I checked the last patch set I sent out in Nov., 2023, there is no issue
there.

https://lore.kernel.org/linux-cxl/20231107180907.553451-9-nifan.cxl@gmail.com/

So the following patch is actually not needed, maybe Hyeonggon's work
was based on some of your local branch which does not have the latest DCD
work.

Thanks,
Fan

> 
> > ---
> >  hw/mem/cxl_type3_stubs.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> > index 1b54ec028c..d913b11b4d 100644
> > --- a/hw/mem/cxl_type3_stubs.c
> > +++ b/hw/mem/cxl_type3_stubs.c
> > @@ -68,14 +68,14 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
> >      error_setg(errp, "CXL Type 3 support is not compiled in");
> >  }
> >  
> > -void qmp_cxl_add_dynamic_capacity(const char *path,
> > +void qmp_cxl_add_dynamic_capacity(const char *path, uint8_t region_id,
> >                                    CXLDCExtentRecordList  *records,
> >                                    Error **errp)
> >  {
> >      error_setg(errp, "CXL Type 3 support is not compiled in");
> >  }
> >  
> > -void qmp_cxl_release_dynamic_capacity(const char *path,
> > +void qmp_cxl_release_dynamic_capacity(const char *path, uint8_t region_id,
> >                                        CXLDCExtentRecordList  *records,
> >                                        Error **errp)
> >  {
> 
