Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD0C385D8E
	for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780124835; cv=none; b=QnHkv3tecvZzM90lETYZrK9w2Z4Vk26oSfwOhGwlXq1etROailKyTwFRT8Fuq0ZT40TjBJnK5xUY/zM5uneME8ibUWFWjKivvCpJW/jHeXT4JZZ7O/xFFBw1YzDjvqGZaJrd1xG2RrJpSoiugbgD3343cu0E/874jsEeHv1Fu3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780124835; c=relaxed/simple;
	bh=F91dfvq8Wah1bzf6BIEHBl3HSgTsKB9AizK2g94hAhc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLddr2KP4R3tP6JZZSYA6WVEEkX4sU7jxuIUcI53LXn1qnj/x0HSMbGibVCCuUZnbDi2mJBmdKQ/PuCZoBALk1Kljglskqg2exg2xS9nHqxwAJn/HVns74lupwYt/FFeAHigpsyhPMdCRmA5hDqvXtXxT+nH7+ng6lfhV6bldZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VncZPbCJ; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VncZPbCJ"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-304545f5206so11914801eec.0
        for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 00:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780124833; x=1780729633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Om8vzyQy0h1ms6+E4uwwkVPBBpvGc4QDtMw8QpW1Ahc=;
        b=VncZPbCJkBZ2m5uJvPQSJg3Jty2LivJMwTZad7Rs+RjafDRXM816Xd30yWEutjJ02Y
         UOyRhmQjgOz8622DjYmfGv+DJrwNiAulmN0Z5e95GhXZn2mYMJ2pkFc2C14tZLHWE+iR
         ny1DvKxEgUJ94Calr1xU1lWwlXp+fu2r3+CONGDiJK1PWMt3n3g3qpxri/7t9+zkuj+C
         Z+yH98rU5aWgbB4q/OZRRfyDyNZOYaFhlzFoZT4vZT2qbJ6mssfLwOYYJcDLzLmYTLoO
         MbVjy073OiS9V0leaLUbepaKed+5rhmdguGHa/lg/PM2i77a/2sx97tiHByZqURRucw1
         eNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780124833; x=1780729633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Om8vzyQy0h1ms6+E4uwwkVPBBpvGc4QDtMw8QpW1Ahc=;
        b=h92L7Xvx8Pi/vYfjOCCbQsbGHUmutO/jD4DlMQikPksvyF7WaAodYH+isstyh1t8vv
         om+dWEehimUQsFARY8pcT5o8Ms2jVXr5bRzIVw4VRWS9mKAWANp7jsW7pNrsypakM30g
         KfQ1UAK0AK6A01twyfyPQpXIVwp5BN9UrQF4am4aay9vMMEy4O5P4dBBtzUlMlePJYjm
         UQ+IwUEj/MuTivZK8KBFBwlN+LXzekIJ+YqsSG0i8uUrFkTD6ZyKqlKyi/UYzWc2DCeV
         AGlCXcg6HSkbHreX/M5TOf/i5T+c9AVRgYoWhNJGM6eKCoTjOxs8Uj6uj1AoCo4XqfKl
         eQMA==
X-Forwarded-Encrypted: i=1; AFNElJ+z9un0wpnLYUfGcfzPLJkV0gARPnyA5rEJszzhdHf/mkKUjmueTCVERxA2dwITAHQXrGwtzvF0+WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKqdI1lAF7JZtMF9j+IQXK8C6udlAEvYp0rgqXaPPeGGr7ELe0
	JjTexPmoRM3yo0Sp9o0NDuYrDJdKg6eqct4YHYf7zCyuM8dapfaS4OzD
X-Gm-Gg: Acq92OFh3a9FAKWOimGJOU0K8tb79NV1Dfw+0GFxEukZ1lsCAKPf34980yWVBjJGXL4
	ptTWUFhbBB7Xx2+KcXjHjFKR2iSKrs6wJrtYlh2OsVSziGWOJqvG5FgFD6uRyiVez+LBjPmi/j9
	eU0zh8Il+FJDrRrahHpTxyEC4t2tuSA93NLD2MhILuQPQEsCiy3/10ucQbxztc5/YdNu3FbZQ3A
	uX/fSDJhDP9wVpYAc8Iv5PwW8+SnGZwfU4tKzsn2a0DAyUxNcc8/vKqyNl8iRzf4VOh5pNpwKk6
	/I2AUyws31kcnkNiB0pRxL97FMf6ffUcBGdcEsGxsqHrQkwov4LJ5O4DDteb3UQK3A1Pgoo8oqZ
	xw5bdtixpDK4I6oy3kM4i0eL/3JgTjE0obZC4Mfe536y3h/7W+X1HZ9+w1N8Kr5SxVUS3h/9c+s
	iiSMFPSltjjeYPn46OMPdqE908DS3Av2Cn33K9cyn7ybip7jPtMBIiLU0qTCSdiR+SCu9j6MPLX
	RyE+yg4lPnpCX/60g==
X-Received: by 2002:a05:7300:6da3:b0:304:3c33:7ad6 with SMTP id 5a478bee46e88-304fa4c7c30mr1461412eec.11.1780124833070;
        Sat, 30 May 2026 00:07:13 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c3121sm3461204eec.5.2026.05.30.00.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 00:07:12 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Sat, 30 May 2026 00:07:11 -0700
To: Dave Jiang <dave.jiang@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@groves.net>, Gregory Price <gourry@gourry.net>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v10 06/31] cxl/port: Add 'dynamic_ram_a' to endpoint
 decoder mode
Message-ID: <ahqMnx5sTWj96-y3@AnisaLaptop.localdomain>
References: <cover.1779528761.git.anisa.su@samsung.com>
 <58e5e5007cd11e0b8e65016f126144f187badb39.1779528761.git.anisa.su@samsung.com>
 <e504359a-ff13-4ad1-a74c-337ede7f11c6@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e504359a-ff13-4ad1-a74c-337ede7f11c6@intel.com>

On Wed, May 27, 2026 at 05:01:44PM -0700, Dave Jiang wrote:
> 
> 
> On 5/23/26 2:43 AM, Anisa Su wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Endpoints can now support a single dynamic ram partition following the
> > persistent memory partition.
> > 
> > Expand the mode to allow a decoder to point to the first dynamic ram
> > partition.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Need Anisa sign off
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> Just update kver and dates below.
> 
Updated!

Thanks,
Anisa
> > 
> > ---
> > Changes:
> > [anisa: rebase]
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 18 +++++++++---------
> >  drivers/cxl/core/port.c                 |  4 ++++
> >  2 files changed, 13 insertions(+), 9 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 3d95c325f6e0..c604c7ca6432 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -358,22 +358,22 @@ Description:
> >  
> >  
> >  What:		/sys/bus/cxl/devices/decoderX.Y/mode
> > -Date:		May, 2022
> > -KernelVersion:	v6.0
> > +Date:		May, 2022, May 2025
> 
> A later date
> 
> > +KernelVersion:	v6.0, v6.16 (dynamic_ram_a)
> 
> 7.3 maybe?
> 
> DJ
> 
> >  Contact:	linux-cxl@vger.kernel.org
> >  Description:
> >  		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
> >  		translates from a host physical address range, to a device
> >  		local address range. Device-local address ranges are further
> > -		split into a 'ram' (volatile memory) range and 'pmem'
> > -		(persistent memory) range. The 'mode' attribute emits one of
> > -		'ram', 'pmem', or 'none'. The 'none' indicates the decoder is
> > -		not actively decoding, or no DPA allocation policy has been
> > -		set.
> > +		split into a 'ram' (volatile memory) range, 'pmem' (persistent
> > +		memory), and 'dynamic_ram_a' (first Dynamic RAM) range. The
> > +		'mode' attribute emits one of 'ram', 'pmem', 'dynamic_ram_a' or
> > +		'none'. The 'none' indicates the decoder is not actively
> > +		decoding, or no DPA allocation policy has been set.
> >  
> >  		'mode' can be written, when the decoder is in the 'disabled'
> > -		state, with either 'ram' or 'pmem' to set the boundaries for the
> > -		next allocation.
> > +		state, with either 'ram', 'pmem', or 'dynamic_ram_a' to set the
> > +		boundaries for the next allocation.
> >  
> >  
> >  What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 0c5957d1d329..a7f71f36531f 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -128,6 +128,7 @@ static DEVICE_ATTR_RO(name)
> >  
> >  CXL_DECODER_FLAG_ATTR(cap_pmem, CXL_DECODER_F_PMEM);
> >  CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
> > +CXL_DECODER_FLAG_ATTR(cap_dynamic_ram_a, CXL_DECODER_F_RAM);
> >  CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
> >  CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
> >  CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
> > @@ -222,6 +223,8 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
> >  		mode = CXL_PARTMODE_PMEM;
> >  	else if (sysfs_streq(buf, "ram"))
> >  		mode = CXL_PARTMODE_RAM;
> > +	else if (sysfs_streq(buf, "dynamic_ram_a"))
> > +		mode = CXL_PARTMODE_DYNAMIC_RAM_A;
> >  	else
> >  		return -EINVAL;
> >  
> > @@ -327,6 +330,7 @@ static struct attribute_group cxl_decoder_base_attribute_group = {
> >  static struct attribute *cxl_decoder_root_attrs[] = {
> >  	&dev_attr_cap_pmem.attr,
> >  	&dev_attr_cap_ram.attr,
> > +	&dev_attr_cap_dynamic_ram_a.attr,
> >  	&dev_attr_cap_type2.attr,
> >  	&dev_attr_cap_type3.attr,
> >  	&dev_attr_target_list.attr,
> 
