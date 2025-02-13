Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C8D28A2BF
	for <linux-cxl@vger.kernel.org>; Thu, 13 Feb 2025 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471238; cv=none; b=Vv7jawQqvDd9xxp9/FjJvFGxYe5V1X8OTFSV663rnEINih7Pshp5Rmp8l73LX4OQwLCI6RDf/grOVzocXCZlQhD0rwAY9mxgyTf83hRnDMxb/Su/MxDj+tDI6gdWurYrlG1COKJgicGptqlzKWu9nf8m8pnCpcERc2J5kB5kLwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471238; c=relaxed/simple;
	bh=LIpjt27x/BARksXQpxNfhGtaEe/+cQMCrFwMOh3tgTM=;
	h=Message-ID:From:Date:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPt+1/SgdP1VU8UrKScoo0ZLZm844lNFeK7cTvhEmOOcuCmMrCXd0u3oufvXToX1g1QKoXD81+L+oNnjqV3iJT+vD22JFksK2eh2SJxmXBhodZaqyAMFtKgYVuyyJFWkitga+vFPgVOuOFw///6yuWrckPU/T1st/a9at3Lo2Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rv6tZ0Jr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rv6tZ0Jr"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f48ebaadfso24651285ad.2
        for <linux-cxl@vger.kernel.org>; Thu, 13 Feb 2025 10:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739471236; x=1740076036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cmghmuCnhycAkjWOUuCwMZFMKLZ5v7aidKalfucPC10=;
        b=Rv6tZ0Jr6TJ41HF4mz/ZdlrH6U8or5z1PfiCOhf9Mqzn9Td7T9vqL8iN8GyTzgnIqR
         AP5i7ZLtyyprwaYyQdaY/Tb6Vjfsm4X3g8JAx9KhHa3X8KIIV096ep+I1/hgLMejfhmn
         XQgDrf+oKe2aQWhj6e07s6iXLC4zI+cELxGnRp4Q9vkYV/RNJCPYX8XjoE0+LEqAGh+M
         i6jEnCwcAbb75OsGgb5rsPxBsZ7XgGl52+36HrsSuSXleFoCV5PM5yiz4SJnx0chpE92
         6KDcN1U94QhsJibl0wFp+ejXMYtW9bKmKJjgtVrDA/SAhX4O9FPrn4sAn1gKV8clWPBk
         VyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739471236; x=1740076036;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmghmuCnhycAkjWOUuCwMZFMKLZ5v7aidKalfucPC10=;
        b=GgTmd8Pvsa1Vt/6Rlt7whULoWWIvFaU47zJ4Czlnuwdu3wFMOZQEeZhlfgHN1g/Smt
         8TKQikdx2+dKwlYQFIZnnWFn3ogCU6rU9Hyn8vW9pQ8DIABRDF8nmkq2KMWbCa4UBdfB
         R5GxSfULtNLeZzB4n80w21sqfymej1jQOTi4Sbu0QvX4LNRUfa9VPHmCw1JlOnoUOl1A
         BBg8rEipXDusd66MkqJd91Rvr6R57hcU6Og5wmvoP2KP5KbqObLomb7zfsbQ8aZXIEzk
         0iFYu5AR0bgUVbcSZ6hbpBmGM0KIM7pJRkuNWl+vCVDReQykwVFtIUdjPWTEovfcQ15H
         NP0A==
X-Forwarded-Encrypted: i=1; AJvYcCXWlQigczSuzWSw6ayPoB2HTyX05feHictT/3k82E+t4rLOAzNAn09kc2ArCJLxPQ5LNFdkx9nBY8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVkMyk3YEhzx2UQ5gbrk/MCJi6xDQQaK7wpuyja4OsSjrhvc5A
	a5fS/92g5JoSdOzhvGdURBD1CToafAHw7bhZ0N8DouJBxmWwJXWnyuFMMw==
X-Gm-Gg: ASbGncuUNBeIgsrpOcUj/HNOAdYaAXi63zt2YH0SENrQzhgXD6oJf3lPmSl2xj7C6pT
	LDBGA9N9q3Q7o539rd03p/jsBziGYcI76q14jATy9BN7J1At7g6suLs52JllK1RchuOF14Vhr/y
	ZR0BMcR8OKZfWKVQo896XgaIeS3t2lzUOuwl0AJnrmv7YXC/cvdOpLX11UQuz7ja/pB3fiUwd1Q
	j2BxcDGJc3tE324e61Tf9U20mGsb2DrgBe1F3q7Ekw1dC8NJqDcdgP9vW/NwGLizFbHFi4n97cV
	B/keqOVC4FsT9MRLvA2gzd/rDxxc91owgKQPwCfrGeA=
X-Google-Smtp-Source: AGHT+IHHVKOSijGgzkJb8J/7oWAd13hrPMDbDrXhsTaZtvB9ikRLLiNjtVxpFMg94MGeoTtCDznDcQ==
X-Received: by 2002:a17:902:d502:b0:206:9a3f:15e5 with SMTP id d9443c01a7336-220bbc67fbemr141122475ad.32.1739471236605;
        Thu, 13 Feb 2025 10:27:16 -0800 (PST)
Received: from asus. (c-73-189-148-61.hsd1.ca.comcast.net. [73.189.148.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5364669sm15385295ad.86.2025.02.13.10.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 10:27:16 -0800 (PST)
Message-ID: <67ae3984.170a0220.36b6de.8cb0@mx.google.com>
X-Google-Original-Message-ID: <Z645erpowZDDVt1E@asus.>
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 13 Feb 2025 10:27:06 -0800
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
	chenbaozi@phytium.com.cn, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/1] mem/cxl-type3: Add a default value of sn
References: <20250211022413.80842-1-wangyuquan1236@phytium.com.cn>
 <20250211022413.80842-2-wangyuquan1236@phytium.com.cn>
 <20250211092655.00004310@huawei.com>
 <Z62akRdahoGqHN5x@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z62akRdahoGqHN5x@phytium.com.cn>

On Thu, Feb 13, 2025 at 03:09:05PM +0800, Yuquan Wang wrote:
> On Tue, Feb 11, 2025 at 09:26:55AM +0000, Jonathan Cameron wrote:
> > On Tue, 11 Feb 2025 10:24:13 +0800
> > Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> > 
> > > The previous default value of sn is UI64_NULL which would cause the
> > > cookie of nd_interleave_set be '0' and the "invalid interleave-set
> > > -cookie" failure in label validation.
> > Hi Yuquan,
> > 
> > Maybe we should harden the nd_interleave_set code to fail
> > to set the cookie in the event of no serial number. That is a
> > device not compliant with the spec, but none the less it is not
> > implausible with test devices etc.
> > 
> Thanks for your suggestions :)
> 
> I have send patch 'cxl/pmem: debug invalid serial number data' trying to
> fix this problem. Welcome more comments to guide me!
> 
> link: https://lore.kernel.org/linux-cxl/20250213064008.4032730-1-wangyuquan1236@phytium.com.cn/T/#t
> 
> Here I have another question about labels. It seems like current kernel
> only deals with nvdimm namespaces labels and leaves cxl region labels to
> do. Therefore, for some dynamically-created cxl pmem regions, users have
> to re-create these regions manually. Does it means CXL drivers could not recover
> a cxl region by cxl region lables now?.

As you mentioned, region label is not implemented in current kernel, so
I do not see a way to recover a region with region label as it is not
persisted to the LSA of the device.

Fan
> > > 
> > > As many users maybe not know how to set a unique sn for cxl-type3
> > > device and perhaps be confuesd by the failure of label validation,
> > > so this defines '1' as the default value of serial number to fix the
> > > problem.
> > 
> > That magic value is specifically chosen to be 'undefined' to trigger
> > clean handling of the failure and not provide the serial number
> > capability. 
> > 
> > If you have multiple devices and provide a 'valid' default then
> > there are circumstances in which the device will be seen as a multiheaded
> > single device attached to two places in the PCI topology.
> > 
> > So I'm not keen to change this.  Ideally we'd have made this a required
> > parameter from the start, but we didn't and doing so now would result
> > in a backwards compatibility problem.
> > 
> > So I think this is kind of a 'won't fix' situation on the qemu side.
> Ok, I see.
> 
> Maybe we could modify the Example command lines in docs/../cxl.rst to remind
> users to add this parameter. Is this feasible?
> 
> > 
> > Jonathan
> > 
> > > 
> > > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> > > ---
> > >  hw/mem/cxl_type3.c | 17 ++++-------------
> > >  1 file changed, 4 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > index 0ae1704a34..a6b5a9f74e 100644
> > > --- a/hw/mem/cxl_type3.c
> > > +++ b/hw/mem/cxl_type3.c
> > > @@ -310,12 +310,6 @@ static void ct3d_config_write(PCIDevice *pci_dev, uint32_t addr, uint32_t val,
> > >      pcie_aer_write_config(pci_dev, addr, val, size);
> > >  }
> > >  
> > > -/*
> > > - * Null value of all Fs suggested by IEEE RA guidelines for use of
> > > - * EU, OUI and CID
> > > - */
> > > -#define UI64_NULL ~(0ULL)
> > > -
> > >  static void build_dvsecs(CXLType3Dev *ct3d)
> > >  {
> > >      CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
> > > @@ -856,12 +850,9 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
> > >      pci_config_set_prog_interface(pci_conf, 0x10);
> > >  
> > >      pcie_endpoint_cap_init(pci_dev, 0x80);
> > > -    if (ct3d->sn != UI64_NULL) {
> > > -        pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
> > > -        cxl_cstate->dvsec_offset = 0x100 + 0x0c;
> > > -    } else {
> > > -        cxl_cstate->dvsec_offset = 0x100;
> > > -    }
> > > +
> > > +    pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
> > > +    cxl_cstate->dvsec_offset = 0x100 + 0x0c;
> > >  
> > >      ct3d->cxl_cstate.pdev = pci_dev;
> > >      build_dvsecs(ct3d);
> > > @@ -1225,7 +1216,7 @@ static const Property ct3_props[] = {
> > >                       TYPE_MEMORY_BACKEND, HostMemoryBackend *),
> > >      DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
> > >                       HostMemoryBackend *),
> > > -    DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
> > > +    DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, 0x1),
> > >      DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
> > >      DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
> > >      DEFINE_PROP_LINK("volatile-dc-memdev", CXLType3Dev, dc.host_dc,
> > 
> 
