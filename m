Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A3B18A934;
	Mon, 19 Aug 2024 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091496; cv=none; b=PQ8anTaulJk9kmBlcsrLJQZZlG9ItXE5GsoEnpuRix8ZmJZ2mWRbdrpANiwL9EBmwue4sPJc1wVCjTsFAC/Sl9NF3j+h9GKJ8p832su7RYTEI9TSAU3RAgTYt3YCmUySFCD/Qv2kz4JIs81sh9Hf5csfWGCyF62tc3q7tbCQpxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091496; c=relaxed/simple;
	bh=EWOZyibOW+wIExVAMS5SDctag1MIP4HuSTQODw8wl2I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCeIX45Tw1n+7qlWHK5rPMYZ0dveWBvz5HnRSB1ulNQyHr03GtiiBB3dPwggEVnFZZLSXrHW6ndQm247tDDlCQGolVQnClLbkW3tWGcx4CznZqVML0/D143B6lA8nD6Wx6hLi1jNmrrNUQkMpzv/PxpIblJ30kq6HemaeZImw9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gY2OFHCa; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY2OFHCa"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e116ec43a4aso4905302276.0;
        Mon, 19 Aug 2024 11:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724091494; x=1724696294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AGaYa1Q8KPOcvDV/p8Nmwra1mvJ7inGUNSlMYUWHzO0=;
        b=gY2OFHCa98zEQCazwHoe3bldrsLC1RByHg6wTPJ9ENQlBa/635Ah7SJ17Ga/neeE1M
         VH3SeaFJXRst8KxrTDwsG6lTdDyF2hf6iHsS6xAt3ukMITtovBRAfxF2JJ6FJ4s0BLiP
         bvY6OWWbWN0rUofN5YxQa7VB0jVARRrjEnYeWhtSZEiPCfS5DcMau/QDVe0xq4fVuRtl
         oB4uvBjtNqILo/9Ib3xSw3VKds7GMBU6Zg2dj8bepmujkGrCKurAHcRbB68RMFQBboAX
         hj+gYAV5yMhEYBXBKTN+iTIg4Sa12xrLKPGMA+WZ+kihE/BFSBOtiDWkpvrXLZRckqnk
         MlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724091494; x=1724696294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGaYa1Q8KPOcvDV/p8Nmwra1mvJ7inGUNSlMYUWHzO0=;
        b=JAhmpHHN6RnYYQQn2p05on/5xfKAfx3kUD2KiYvp67nyBUKU++mZ2UnatJKAQ6NE4s
         ZrJSyXKIIT6unBSQq2BMFPCau1KSmH3ouM6VNk3PfD8apCAgwdShWltx5UoaGXPTtvgb
         O9Mff8CIPIj+k3R9zwpX9jvn+JvWYJlazJNADZGcRqWKtwePZv8DAg2Oc5TCyNo6gvju
         /Rp685/8xq5Unwz+reV9d8Rs6UlJ4FYufsCnFjCpZzKDiz913tDCbdjWj3gS5uN0Rj9B
         EpVTdGlDX3KerdkBhgCFMyk0uOs41JvoWMosdrlAwafIDmfRSdm1Adif8618t4a5w+Bw
         VVLg==
X-Forwarded-Encrypted: i=1; AJvYcCXoa/6BAEXDqjYvLSeKSPET1PQOmZAnjZK1f4yHOjPoFGBHZd9GzoJWNxpkuA++ZS1aHI40HbM4XiHs/w6z55px8UtMxw/zTT5gUS6P54wlKJLt9Y0ibTp1UcGThcO52yH93nkkUiKe
X-Gm-Message-State: AOJu0YzA0+mhPw3EZLbTxlo10grNTiRPFz2CJLnIdl7lJBzrJnhShHtp
	QNAM2c+f35JTrBfyBg0EYVdLPumLnQ+PWmcsodCQ/npOjaPlbhhr
X-Google-Smtp-Source: AGHT+IFTQcrX/ZqxE31X+8Bo8Q8GGk4HsqH57l96fLkavexRAW5f2wDZWpd956d6VC05s+DphvKhMw==
X-Received: by 2002:a05:690c:17:b0:698:bde0:a2dd with SMTP id 00721157ae682-6b1b70c4806mr148329977b3.7.1724091493684;
        Mon, 19 Aug 2024 11:18:13 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9cd7a548sm16670207b3.87.2024.08.19.11.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 11:18:13 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 19 Aug 2024 11:17:54 -0700
To: Terry Bowman <Terry.Bowman@amd.com>
Cc: fan <nifan.cxl@gmail.com>, dan.j.williams@intel.com,
	ira.weiny@intel.com, dave@stgolabs.net, dave.jiang@intel.com,
	alison.schofield@intel.com, ming4.li@intel.com,
	vishal.l.verma@intel.com, jim.harris@samsung.com,
	ilpo.jarvinen@linux.intel.com, ardb@kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yazen.Ghannam@amd.com, Robert.Richter@amd.com,
	a.manzanares@samsung.com
Subject: Re: [RFC PATCH 0/9] Add RAS support for CXL root ports, CXL
 downstream switch ports, and CXL upstream switch ports
Message-ID: <ZsOMUi_dMhakCkit@fan>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <ZqKeHWsZtDb1RKfh@debian>
 <6db43744-1d92-482a-852f-8d43efa55b74@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6db43744-1d92-482a-852f-8d43efa55b74@amd.com>

On Mon, Aug 19, 2024 at 11:21:01AM -0500, Terry Bowman wrote:
> Hi Fan
> 
> On 7/25/24 13:49, fan wrote:
> > On Mon, Jun 17, 2024 at 03:04:02PM -0500, Terry Bowman wrote:
> >> This patchset provides RAS logging for CXL root ports, CXL downstream
> >> switch ports, and CXL upstream switch ports. This includes changes to
> >> use a portdrv notifier chain to communicate CXL AER/RAS errors to a
> >> cxl_pci callback.
> >>
> >> The first 3 patches prepare for and add an atomic notifier chain to the
> >> portdrv driver. The portdrv's notifier chain reports the port device's
> >> AER internal errors to the registered callback(s). The preparation changes
> >> include a portdrv update to call the uncorrectable handler for PCIe root
> >> ports and PCIe downstream switch ports. Also, the AER correctable error
> >> (CE) status is made available to the AER CE handler.
> >>
> >> The next 4 patches are in preparation for adding an atomic notification
> >> callback in the cxl_pci driver. This is for receiving AER internal error
> >> events from the portdrv notifier chain. Preparation includes adding RAS
> >> register block mapping, adding trace functions for logging, and
> >> refactoring cxl_pci RAS functions for reuse.
> >>
> >> The final 2 patches enable the AER internal error interrupts.
> >>
> >> Testing RAS CE/UCE:
> >>   QEMU was used for testing CXL root port, CXL downstream switch port, and
> >>   CXL upstream switch port. The aer-inject tool was used to inject AER and
> >>   a test patch was used to set the AER CIE/UIE and RAS CE/UCE status during
> >>   testing. Testing passed with no issues.
> > 
> > Hi Terry,
> > 
> > Could you share a little more about the qemu test setup?
> > From what I see, it seems currently qemu can only inject error to
> > type3 devices, is that true? Or how to do that for port devices?
> > Do we need a hack there?
> > 
> > Also, is the aer-inject tool you mentioned the one currently in the kernel
> > or something else?
> > https://elixir.bootlin.com/linux/v6.10-rc6/source/drivers/pci/pcie/aer_inject.c
> > 
> > Thanks,
> > Fan
> > 
> Sorry for the late response.
> 
> I used AMD RAS injection for testing HW root ports.
> 
> I used QEMU and the legacy aer-inject userspace tool to test switch ports (USP/DSP).[1] 
> I added a couple test patches to set the AER UIE/CIE because the tool doesn't support 
> injecting UIE or CIE bits. I used a test patch for assigning the RAS status as well.
> 
> Regards,
> Terry
> 
> [1] - https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git/about/
> 

Hi Terry,
Thanks for the reply. I was able to do aer error inject through the aer
inject kernel module and the user space tool. 
Trying to exercise the code in this patchset.

Fan

> > 
> >>  
> >>   An AMD platform with the AMD RAS error injection tool was used for
> >>   testing CXL root port injection. Testing passed with no issues.
> >>
> >>   TODO - regression test CXL1.1 RCH handling.
> >>
> >> Solutions Considered (1-4):
> >>   Below are solutions that were considered. Solution #4 is
> >>   implemented in this patchset. 
> >>
> >>   1.) Reassigning portdrv error handler for CXL port devices
> >>   
> >>   This solution was based on reassigning the portdrv's CE/UCE err_handler
> >>   to be CXL cxl_pci driver functions.
> >>   
> >>   I started with this solution and once the flow was working I realized
> >>   the endpoint removal would have to be addressed as well. While this
> >>   could be resolved it does highlight the odd coupling and dependency
> >>   between the CXL port devices error handling with cxl_pci endpoint's
> >>   handlers. Also, the err_handler re-assignment at runtime required
> >>   ignoring the 'const' definition. I don't believe this should be
> >>   considered as a possible solution.
> >>   
> >>   2.) Update the AER driver to call cxl_pci driver's error handler before
> >>   calling pci_aer_handle_error()
> >>
> >>   This is similar to the existing RCH port error approach in aer.c.
> >>   In this solution the AER driver searches for a downstream CXL endpoint
> >>   to 'handle' detected CXL port protocol errors.
> >>
> >>   This is a good solution to consider if the one presented in this patchset
> >>   is not acceptable. I was initially reluctant to this approach because it
> >>   adds more CXL coupling to the AER driver. But, I think this solution
> >>   would technically work. I believe Ming was working towards this
> >>   solution.
> >>
> >>   3.) Refactor portdrv
> >>   The portdrv refactoring solution is to change the portdrv service drivers
> >>   into PCIe auxiliary drivers. With this change the facility drivers can be
> >>   associated with a PCIe driver instead fixed bound to the portdrv driver.
> >>
> >>   In this case the CXL port functionality would be added either as a CXL
> >>   auxiliary driver or as a CXL specific port driver
> >>   (PCI_CLASS_BRIDGE_PCI_NORMAL).
> >>
> >>   This solution has challenges in the interrupt allocation by separate
> >>   auxiliary drivers and in binding of a specific driver. Binding is
> >>   currently based on PCIe class and would require extending the binding
> >>   logic to support multiple drivers for the same class.
> >>
> >>   Jonathan Cameron is working towards this solution by initially solving
> >>   for the PMU service driver.[1] It is using the auxiliary bus to associate
> >>   what were service drivers with the portdrv driver. Using a CXL auxiliary
> >>   for handling CXL port RAS errors would result in RAS logic called from
> >>   the cxl_pci and CXL auxiliary drivers. This may need a library driver.
> >>
> >>   4.) Using a portdrv notifier chain/callback for CIE/UIE
> >>   (Implemented in this patchset)
> >>
> >>   This solution uses a portdrv atomic chain notifier and a cxl_pci
> >>   callback to handle and log CXL port RAS errors.
> >>   
> >>   I chose this after trying solution#1 above. I see a couple advantages to
> >>   this solution are:
> >>   - Is general port implementation for CIE/UIE specific handling mentioned
> >>   in the PCIe spec.[2]
> >>   - Notifier is used in RAS MCE driver as an existing example.
> >>   - Does not introduce further CXL dependencies into the AER driver.
> >>   - The notifier chain provides registration/unregistration and
> >>   synchronization.
> >>
> >>   A disadvantage of this approach is coupling still exists between the CXL
> >>   port's driver (portdrv) and the cxl_pci driver. The CXL port device's RAS
> >>   is handled by a notifier callback in the cxl_pci endpoint driver.
> >>
> >>   Most of the patches in this patchset could be reused to work with
> >>   solution#3 or solution#2. The atomic notifier could be dropped and
> >>   instead use an auxiliary device or AER driver awareness. The other
> >>   changes in this patchset could possibly be reused.
> >>
> >>   [1] Kernel.org -
> >>   https://lore.kernel.org/all/f4b23710-059a-51b7-9d27-b62e8b358b54@linux.intel.com
> >>   [2] PCI6.0 - 6.2.10 Internal errors
> >>
> >>  drivers/cxl/core/core.h    |   4 +
> >>  drivers/cxl/core/pci.c     | 153 ++++++++++++++++++++++++++++++++-----
> >>  drivers/cxl/core/port.c    |   6 +-
> >>  drivers/cxl/core/trace.h   |  34 +++++++++
> >>  drivers/cxl/cxl.h          |  10 +++
> >>  drivers/cxl/cxlpci.h       |   2 +
> >>  drivers/cxl/mem.c          |  32 +++++++-
> >>  drivers/cxl/pci.c          |  19 ++++-
> >>  drivers/pci/pcie/aer.c     |  10 ++-
> >>  drivers/pci/pcie/err.c     |  20 +++++
> >>  drivers/pci/pcie/portdrv.c |  32 ++++++++
> >>  drivers/pci/pcie/portdrv.h |   2 +
> >>  include/linux/aer.h        |   6 ++
> >>  13 files changed, 303 insertions(+), 27 deletions(-)
> >>
> >>
> >> base-commit: ca3d4767c8054447ac2a58356080e299a59e05b8
> >> -- 
> >> 2.34.1
> >>
