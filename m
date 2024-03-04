Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A175612E9
	for <linux-cxl@vger.kernel.org>; Mon,  4 Mar 2024 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573504; cv=none; b=ZD0FsjwBOv1M8LmgPWbSLFtRBBlPhkM+qqZ1DHWv5tyRWQkXARNgyohSUy0OfKvJsW2BAH480P4YnfBMmDO20INygXSqvOuIKETj/t/s/Xw8e0JecE+hYHcM+LPr4pB/4Nvme9Pl/qSqToP5k9Bm++pRv5ZsyDzUhQ+HT4rVoCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573504; c=relaxed/simple;
	bh=2YnB//uS/0L+Hacq+WuTaNRZBL0/vBLmD/NWnpKuMlM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Amwncs0/XK+2/5q1lCbsk7GqZC5FUsOYDmwobasczVHFdbz1hNE5U5YGXJRDvis7yAysOaSpAHfD+wCS4qSejzeB/sOBGzUYWmt1eN9jXxqXFaU9+rEa6T3vJY9O9o6BMPKFruHCtvCr7MNMQ9ra5yqFpr8gVCsoBtFNTWuCpkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUeZy2Uh; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUeZy2Uh"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbed179f0faso4046322276.1
        for <linux-cxl@vger.kernel.org>; Mon, 04 Mar 2024 09:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709573501; x=1710178301; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z3Qx+aXmPP8v8jU0J6qHwTML1uLCWv1nNAU++flyM4A=;
        b=eUeZy2UhCDYM053uI5l6uJ4snFlXxBy5+lmkbYhJfOpGY5ZP+zJebVKDj4x+r+rmgu
         0bLim4kL/tnEW22bAcIJZ7jGeT0EzO54/CFaxD60HMXO+HwbPB9TlRzZI0fzkjaVqbR/
         0kSgnzUkH8nLmUtNTwNL1MuDYXj4aQtumhukH3BUmmdSQFxTVGqvnv7WHURql0vaPzDY
         zaRu+Oa5lZSgqDzGhmoFV2EO7DUfKLv4jWtxBxuCBU1zxvJiHub70uMpgXNZl4sGkfsK
         PlXM2VIPwa1qDkHr7B/W2OdmtdOOtQX3Sb1Vauy4QgvUKRrLYQCFpiLriKs1fIx4k0Dl
         lVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709573501; x=1710178301;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3Qx+aXmPP8v8jU0J6qHwTML1uLCWv1nNAU++flyM4A=;
        b=BEUjtyOkwKuJp3r0GUmdlz3GCXtQ3Ej9B0JNdcmS1SX56SmcT7Y9/IFqIWgEyzUuLE
         PnVtEeoHwD2fvMeO13KR6dfj/ZCsfS7Y+4MFZfeM+u4Bm9BpBq7BCI/ECfSlRJ9tjuN6
         7rvVKKlHbx1PdHsnu47yx6bCLXRtTOSy9Bbz/lcE7Ih6Wtmp/+a4mnybIhYQiLrXuMNY
         V0aqJQA066hxV6C/63S9mKiUTdf+grwGqDkqF5A1B1nIEccuiU+rwadO//0xLRREYijj
         hULNp4pkGAPtl9gdaMyqoYEgh+fNgrEAclAodSnz0RjTd0hPGaaLHc5jPYT0dR0rmBcR
         vU0w==
X-Forwarded-Encrypted: i=1; AJvYcCUIqgl5t/TcY37xruIoRQEJ0ztPGT+j2G5PtjeU8UVTYIH1HvrwSB5YvG8WqRg3Vbj5BZAx1lnCXFyTrLjLizrU/rrscFxIkFvR
X-Gm-Message-State: AOJu0Yz58GFg7PFkzL9TU4imep9OVkZZyxBnSZFoZbUVnCZpJ3bX6F7W
	R66eW7t0cLP4ofQUTT2j/iXJmo9QGbVNqTP6o4OtyslffTx17EH4dDPg0wAp
X-Google-Smtp-Source: AGHT+IFxHkWJmBV7rK8mGrDaT2BHHaRIeh/zkdGUMy66EQvXNr9iBaUJpu1ucf+VcMJPbfZ2Q0/8mQ==
X-Received: by 2002:a05:6902:1815:b0:dc2:2ae4:d639 with SMTP id cf21-20020a056902181500b00dc22ae4d639mr124971ybb.20.1709573501320;
        Mon, 04 Mar 2024 09:31:41 -0800 (PST)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id y3-20020a25dc03000000b00dcda3959006sm2345648ybe.33.2024.03.04.09.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:31:41 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 4 Mar 2024 09:31:25 -0800
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
Subject: Re: [PATCH v4 04/10] hw/mem/cxl_type3: Add support to create DC
 regions to type3 memory devices
Message-ID: <ZeYFbeYrJfQR7sNn@debian>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-5-nifan.cxl@gmail.com>
 <ebab98e4-aa07-4aa6-84ec-768f6432e2f4@wdc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebab98e4-aa07-4aa6-84ec-768f6432e2f4@wdc.com>

On Mon, Mar 04, 2024 at 01:10:37PM +0000, Jørgen Hansen wrote:
> On 2/21/24 19:15, nifan.cxl@gmail.com wrote:
> > CAUTION: This email originated from outside of Western Digital. Do not click on links or open attachments unless you recognize the sender and know that the content is safe.
> > 
> > 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > With the change, when setting up memory for type3 memory device, we can
> > create DC regions.
> > A property 'num-dc-regions' is added to ct3_props to allow users to pass the
> > number of DC regions to create. To make it easier, other region parameters
> > like region base, length, and block size are hard coded. If needed,
> > these parameters can be added easily.
> > 
> > With the change, we can create DC regions with proper kernel side
> > support like below:
> > 
> > region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> > echo $region > /sys/bus/cxl/devices/decoder0.0/create_dc_region
> > echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> > echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> > 
> > echo "dc0" >/sys/bus/cxl/devices/decoder2.0/mode
> > echo 0x40000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size
> > 
> > echo 0x40000000 > /sys/bus/cxl/devices/$region/size
> > echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
> > echo 1 > /sys/bus/cxl/devices/$region/commit
> > echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> > 
> > However, we cannot really read/write to the DC regions due to lack of
> > 1. host backend and address space setup for DC regions;
> > 2. mailbox command support for adding/releasing DC extents.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >   hw/mem/cxl_type3.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 40 insertions(+)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 244d2b5fd5..c61cd2b5ac 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -567,6 +567,40 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
> >       }
> >   }
> > 
> > +/*
> > + * TODO: dc region configuration will be updated once host backend and address
> > + * space support is added for DCD.
> > + */
> > +static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
> > +{
> > +    int i;
> > +    uint64_t region_base = 0;
> > +    uint64_t region_len =  2 * GiB;
> > +    uint64_t decode_len = 2 * GiB;
> > +    uint64_t blk_size = 2 * MiB;
> > +    CXLDCDRegion *region;
> > +
> > +    if (ct3d->hostvmem) {
> > +        region_base += ct3d->hostvmem->size;
> > +    }
> > +    if (ct3d->hostpmem) {
> > +        region_base += ct3d->hostpmem->size;
> > +    }
> 
> You could use memory_region_size() here instead of accessing field directly.
> 
> Also, it doesn't look like there is any enforcement of hostvmem and 
> hostpmem being a multiple of 256MB, so region_base isn't necessarily 
> aligned to 256MB either. This probably should be fixed separately for 
> vmem and pmem, such that they check the size similar to what you do, as 
> the existing code also assumes that they are multiples of 256MB.

Yeah. I will update the code and add check here to make sure the region
base is aligned with 256MB.

Fan

> 
> > +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> > +        region = &ct3d->dc.regions[i];
> > +        region->base = region_base;
> > +        region->decode_len = decode_len;
> > +        region->len = region_len;
> > +        region->block_size = blk_size;
> > +        /* dsmad_handle is set when creating cdat table entries */
> > +        region->flags = 0;
> > +
> > +        region_base += region->len;
> > +    }
> > +
> > +    return true;
> > +}
> > +
> >   static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> >   {
> >       DeviceState *ds = DEVICE(ct3d);
> > @@ -635,6 +669,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> >           g_free(p_name);
> >       }
> > 
> > +    if (!cxl_create_dc_regions(ct3d, errp)) {
> > +        error_setg(errp, "setup DC regions failed");
> > +        return false;
> > +    }
> > +
> >       return true;
> >   }
> > 
> > @@ -930,6 +969,7 @@ static Property ct3_props[] = {
> >                        HostMemoryBackend *),
> >       DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
> >       DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
> > +    DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
> >       DEFINE_PROP_END_OF_LIST(),
> >   };
> > 
> > --
> > 2.43.0
> > 
> > 
> 
> Thanks,
> Jorgen
