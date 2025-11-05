Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C08299AB5
	for <linux-cxl@vger.kernel.org>; Wed,  5 Nov 2025 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369421; cv=none; b=uR09BjoeTav2FV1baDYKm5+vfmvDi2hL9eP4RwonTDURd8OvZZZH0B4yZSfWwpOy5k34VM81q2DwysaMaExZV2xyNIDqk/xB1OYv/vngn4rKcN2+nsO3aDZFdSGB6FTo4EUznhbdAZsMYQ3U4gDmKyahOK2JZuR0mcjmucfjRzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369421; c=relaxed/simple;
	bh=PZ6fOoCOFzuuftIdxLfo9ZcdanHH16wdQ4uKtiHl2CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4NEVqzrjYnPbPgrluZRfNU4ed39gvclFjS+BmH4tFzJiJhwdbMlaP+o8TfRZL7Y0vP6ISU5pU8t/585W0sJGqswPutGu2h6iHQesmZgx1UWzmvSn/Itv7O4jO36f80/XMYzHBb5worQKwBBZadcGj4KFmJ+Xdzpt+xnWd4p9M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=iVSg+IrK; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="iVSg+IrK"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b144ec3aa8so16549385a.2
        for <linux-cxl@vger.kernel.org>; Wed, 05 Nov 2025 11:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762369418; x=1762974218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pkL4FKIhP6Ehebj2t+yWaZ1SkFSBXZJ6OHio2cMXcNM=;
        b=iVSg+IrKEwZlpjWkNdKQCbDAkVJ3WOZd7S7gDt4Pnw64ffpSbdvOIt2pn/tPYxY5/R
         JW/0FYQG+90AVjkJOFvydK+Gd18lTci9M71A/Oc36c6HXMOXj+1PiNw7VkdUlIBTyWAc
         6LSbd5kEtYMW8j61XfbyRg7QswjD3Efm5Hi4P89pUlhaE6EYRU/zY3aV6224v+g36jmr
         6pIfot7kEFDKfuQHuKsuMOfJNIfANBb4X/Qn8p1IVoCYzh78HWB3Z3CdIQ8PNNysM8c0
         KOpMtOdL3+fk42NFVuNlrEZtVomSD3Mvi3NnVgwshukiH9k4Gpg5rVURPSSEoT1yfmkx
         zssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369418; x=1762974218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkL4FKIhP6Ehebj2t+yWaZ1SkFSBXZJ6OHio2cMXcNM=;
        b=oJgz8tOYhcfLXUHrwQiEZxJsg/tTmsXa4N4aXRr2t8iwKWT08I1mXJAyUxK4hsn8tk
         94tH6MUyXB1zAZ89LOEjF3K4MFQQ9Bfu8wh21BuSqLvb8dLR5J+IYNfmlYrggl8wt83r
         rzqXqH/QMqqeKR/34IUWwkWRhtNpb4EwC8i++gEqgO6HKYOlKQjPACnYrU/FbMSs1S1P
         L51Z1HD0g6g+D7iXEZEvMAtZMCVHX+hkTMXctsn7WZ4y4xkHx9pm+yWef7hbTjulAYjO
         8fqS7MG8qPbMP3Yt7sCy8W4VfgVR8Bv/TUbuHu2PAXGb0fyF7S8EYT4QEMbQwOPVSxrC
         I7kw==
X-Forwarded-Encrypted: i=1; AJvYcCVhDp5IPJ4Mf04ZlHB0lUkXYATIFi634/hesimlcxOixANAydc3URBROkmN7MFBLNLGRWvOFGIkEh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2zuOAcw1V09Z8Rzw1ZLby1KD1QYVY23zZcUNIoLX0MzuGVN5D
	gRZfcVWxabqJHuDs6FCQrxtF0tiM7LnTaMx0Cl0mSbwUkLBXVDp6cF9n6tW9f8Zn0uY=
X-Gm-Gg: ASbGncvmPNVCQV5Wq6O/GbYPRRCE7ua4UgN0cMZZhqK6j554fUCneYjwGOd4lLjUcER
	OkzU0c4QS8jTKip0lC2nI59bMkjLVV3h7466atBPV+iDSjZYY8rSBIAsjcR8Td9zoOpf2jPZfAm
	mAAhSwzIlpED6l0OnN0FL9BTwiYTrrTwWdzuRePNJcP5X0r7JBhhL3tBbg/lE/Yqb4+B93SYK31
	75Iy2IZ0uypW2Vl6974J5gBJ30/D2N1DLUnlrUsEs9ulO+V4zIiG1f1xMAPK6ecQmloP3fTwLwJ
	644UnujtUek31R/kjyKNtmuwFqHrL7P/yk/BAmg+7LcwiXATRQggThnbTjkDok3CmuDXqyqEHyI
	75UUgfKpn6DTiy7baMDIOjDNNWFsv0vxS0UfaISAX2qBYhSG2GdeoU6nnkE8oBa5zHJCUkI2XHV
	kalGiz6A4mXl3EQ+KtDMSsn3XGcDLyn9zrDse9jJlrvlvXWpoSWj382LkEi3k=
X-Google-Smtp-Source: AGHT+IE5V/WtcWnffysPIf/k2M0HgfBpWIauzXvLJZtWgsovo179L03Km10ymeu7JR1a7HWgRpdnqA==
X-Received: by 2002:a05:620a:2a10:b0:89a:3233:db11 with SMTP id af79cd13be357-8b220afee3cmr496686485a.81.1762369415363;
        Wed, 05 Nov 2025 11:03:35 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235809f79sm20649785a.47.2025.11.05.11.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:03:34 -0800 (PST)
Date: Wed, 5 Nov 2025 14:03:31 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND v13 17/25] cxl: Introduce cxl_pci_drv_bound() to check
 for bound driver
Message-ID: <aQufg2Nfq8YqkwHl@gourry-fedora-PF4VCD3F>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-18-terry.bowman@amd.com>
 <aQuOiK8S31w44pYR@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQuOiK8S31w44pYR@gourry-fedora-PF4VCD3F>

On Wed, Nov 05, 2025 at 12:51:04PM -0500, Gregory Price wrote:
> On Tue, Nov 04, 2025 at 11:02:57AM -0600, Terry Bowman wrote:
> > CXL devices handle protocol errors via driver-specific callbacks rather
> > than the generic pci_driver::err_handlers by default. The callbacks are
> > implemented in the cxl_pci driver and are not part of struct pci_driver, so
> > cxl_core must verify that a device is actually bound to the cxl_pci
> > module's driver before invoking the callbacks (the device could be bound
> > to another driver, e.g. VFIO).
> > 
> > However, cxl_core can not reference symbols in the cxl_pci module because
> > it creates a circular dependency. This prevents cxl_core from checking the
> > EP's bound driver and calling the callbacks.
> > 
> > To fix this, move drivers/cxl/pci.c into drivers/cxl/core/pci_drv.c and
> > build it as part of the cxl_core module. Compile into cxl_core using
> > CXL_PCI and CXL_CORE Kconfig dependencies. This removes the standalone
> > cxl_pci module, consolidates the cxl_pci driver code into cxl_core, and
> > eliminates the circular dependency so cxl_core can safely perform
> > bound-driver checks and invoke the CXL PCI callbacks.
> > 
> > Introduce cxl_pci_drv_bound() to return boolean depending on if the PCI EP
> > parameter is bound to a CXL driver instance. This will be used in future
> > patch when dequeuing work from the kfifo.
> > 
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > 
> > ---
> 
> This commit causes my QEMU basic expander setup and a real device setup
> to fail to probe the cxl_core driver.
> 
> [    2.697094] cxl_core 0000:0d:00.0: BAR 0 [mem 0xfe800000-0xfe80ffff 64bit]: not claimed; can't enable device
> [    2.697098] cxl_core 0000:0d:00.0: probe with driver cxl_core failed with error -22
> 
> Probe order issue when CXL drivers are built-in maybe?
> 

I've narrowed it down to:

Works
-----
CONFIG_CXL_BUS=m
CONFIG_CXL_MEM=m

Fails
-----
CONFIG_CXL_BUS=y
CONFIG_CXL_MEM=y
or BUS ^ MEM

this commit moves pci -> pci_drv.o and moves it ahead of cxl_mem into
cxl_core into core, but note the comment in the Makefile:

# Order is important here for the built-in case:
# - 'core' first for fundamental init
# - 'port' before platform root drivers like 'acpi' so that CXL-root ports
#   are immediately enabled
# - 'mem' and 'pmem' before endpoint drivers so that memdevs are
#   immediately enabled
# - 'pci' last, also mirrors the hardware enumeration hierarchy

~Gregory
