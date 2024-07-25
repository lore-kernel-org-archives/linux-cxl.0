Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044E2208A5;
	Thu, 25 Jul 2024 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721933362; cv=none; b=tPxPeZ8mTR2Irb5/PmQ1eAofYxHcpmsJFFhHMIl/xMHLazXlUhKGogyYzn7zRxMI1VYqDTSNtpXCoCAeMe4w6sMMfwAxUd8VC6Fbzb3vQqCW1GGGhhVU2fISnTYLg4FPoYEGIxNvuYNcXkmnIp4Oj0JUQM+e6NhihBFaGRSRjxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721933362; c=relaxed/simple;
	bh=+rmmGS5oHsDNMWeejvogZRoRVwq8gR6v9sH9TpIppAA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFWbqbQhKTJOxflut5Hby6u0ItmSd6Vm8fuL4e2fkL8nT0I2VsvSNRjnixUs8ii83ulIkoOWw9UYgrRFkLrdzVEVcfpRkjbkNNxd/ZQWqP3j8Jckf/nN0Xdi71u/kTxeeJsRz6uJptitbUz/fv77ju9snUYnhvC8BVd5bUSOqBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hl7qx6jm; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hl7qx6jm"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so135924a12.1;
        Thu, 25 Jul 2024 11:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721933360; x=1722538160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kLMhi2la1wBRAHdZ5p14tEpxbAYMvWdkbqdovBVCSb0=;
        b=hl7qx6jmlmyV15+Ugh9JCYbRMu6eZ39xcGbT6O2VGvJfHdC6w6bqq9y8J5nKm+ZmsF
         kDWMUWPIPyMfBZ8PsHTAm8aK/IzXjrnN+bYYZdA+asfo6jtk6OVdRgdEa13l9wM/vwAQ
         x00v7PZ+DDeGZ4xx6Q4BzlmuO1/9oViIigDxlIVrWIQ2mpeH5miI2fG0AG+Gb76Zue2Z
         6WWcmXgmS47cNz3JEATzfPbWn9KRZDVEF+McQ300m3Lh5iOBchMfdxHL38bk0VRyI4qW
         DXiFAkv6E2qyRfQNvZw41JOV6cNPT0wN+bQjiDgPUdf940r9iEati1AhqOI++aLkebUg
         2KnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721933360; x=1722538160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLMhi2la1wBRAHdZ5p14tEpxbAYMvWdkbqdovBVCSb0=;
        b=F4D+KK4a+vEYIvRb7CWPc/R8SyFWNzpvvLgMb7RRHLBl8EusVLDpwDVet/KjtAYYQy
         iT5FfOQ0Dd7stxJScEDsWHUzIBGjKpi3hAGZz4L0raf/pp7tNcLBrjqMcMlLGLd0upEc
         SC6T8DtKb/dWXdFnxzHgfud9r7MH7SiS5foSPCiLzezaYnxyHMhNMuKxJ4iwOFarEPBE
         CTAme2kBKazQ1TqKMulzFFPb/6q9mCHKjH/BxJ3YZLvM0+299v+JW95Thj1AfFZTP5hR
         Xfnbe6xaErMWv3vfq/vMfQ2vU1pP3cH4qofzL0E3KQ8eYKmEySHJ9y9AJQUtfIHzrK36
         aLLg==
X-Forwarded-Encrypted: i=1; AJvYcCWJA8JzKQnaCcsqBkmOEcnJGznDV5tJPbFq2Maht1+/j7vS+zCXsxynbxKt85hnPJ/37CDlI0v1fG0n/z2t1RMZtHg41ptD+3+kNw5R0DyvH3HjPBkzE1LAXv5hraFmtkFYHyGdPW1U
X-Gm-Message-State: AOJu0Yx4iJhOIKI9Nq+inmFHc3FjgEJnZgo0UANiB+PWAamLoVmZKCsZ
	1ACvf/8AsJBi2rD9ACkqLG0CvntHdBAoIP0Zh0tgehgc/Y3Y3Xc6
X-Google-Smtp-Source: AGHT+IGJAP1u76GfzLh0MpQasqe8sRnqmxNSnxx+PWnh6mIWWQnWmrCcFQNqvKxPxWM0b4/9sxxbqw==
X-Received: by 2002:a05:6a20:8417:b0:1c0:f677:e98f with SMTP id adf61e73a8af0-1c47b41924bmr3306690637.46.1721933360171;
        Thu, 25 Jul 2024 11:49:20 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:6814:8c88:4aee:e03])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e3d69sm1438587b3a.27.2024.07.25.11.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 11:49:19 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 25 Jul 2024 11:49:01 -0700
To: Terry Bowman <terry.bowman@amd.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	ming4.li@intel.com, vishal.l.verma@intel.com,
	jim.harris@samsung.com, ilpo.jarvinen@linux.intel.com,
	ardb@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yazen.Ghannam@amd.com, Robert.Richter@amd.com,
	a.manzanares@samsung.com
Subject: Re: [RFC PATCH 0/9] Add RAS support for CXL root ports, CXL
 downstream switch ports, and CXL upstream switch ports
Message-ID: <ZqKeHWsZtDb1RKfh@debian>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617200411.1426554-1-terry.bowman@amd.com>

On Mon, Jun 17, 2024 at 03:04:02PM -0500, Terry Bowman wrote:
> This patchset provides RAS logging for CXL root ports, CXL downstream
> switch ports, and CXL upstream switch ports. This includes changes to
> use a portdrv notifier chain to communicate CXL AER/RAS errors to a
> cxl_pci callback.
> 
> The first 3 patches prepare for and add an atomic notifier chain to the
> portdrv driver. The portdrv's notifier chain reports the port device's
> AER internal errors to the registered callback(s). The preparation changes
> include a portdrv update to call the uncorrectable handler for PCIe root
> ports and PCIe downstream switch ports. Also, the AER correctable error
> (CE) status is made available to the AER CE handler.
> 
> The next 4 patches are in preparation for adding an atomic notification
> callback in the cxl_pci driver. This is for receiving AER internal error
> events from the portdrv notifier chain. Preparation includes adding RAS
> register block mapping, adding trace functions for logging, and
> refactoring cxl_pci RAS functions for reuse.
> 
> The final 2 patches enable the AER internal error interrupts.
> 
> Testing RAS CE/UCE:
>   QEMU was used for testing CXL root port, CXL downstream switch port, and
>   CXL upstream switch port. The aer-inject tool was used to inject AER and
>   a test patch was used to set the AER CIE/UIE and RAS CE/UCE status during
>   testing. Testing passed with no issues.

Hi Terry,

Could you share a little more about the qemu test setup?
From what I see, it seems currently qemu can only inject error to
type3 devices, is that true? Or how to do that for port devices?
Do we need a hack there?

Also, is the aer-inject tool you mentioned the one currently in the kernel
or something else?
https://elixir.bootlin.com/linux/v6.10-rc6/source/drivers/pci/pcie/aer_inject.c

Thanks,
Fan


>  
>   An AMD platform with the AMD RAS error injection tool was used for
>   testing CXL root port injection. Testing passed with no issues.
> 
>   TODO - regression test CXL1.1 RCH handling.
> 
> Solutions Considered (1-4):
>   Below are solutions that were considered. Solution #4 is
>   implemented in this patchset. 
> 
>   1.) Reassigning portdrv error handler for CXL port devices
>   
>   This solution was based on reassigning the portdrv's CE/UCE err_handler
>   to be CXL cxl_pci driver functions.
>   
>   I started with this solution and once the flow was working I realized
>   the endpoint removal would have to be addressed as well. While this
>   could be resolved it does highlight the odd coupling and dependency
>   between the CXL port devices error handling with cxl_pci endpoint's
>   handlers. Also, the err_handler re-assignment at runtime required
>   ignoring the 'const' definition. I don't believe this should be
>   considered as a possible solution.
>   
>   2.) Update the AER driver to call cxl_pci driver's error handler before
>   calling pci_aer_handle_error()
> 
>   This is similar to the existing RCH port error approach in aer.c.
>   In this solution the AER driver searches for a downstream CXL endpoint
>   to 'handle' detected CXL port protocol errors.
> 
>   This is a good solution to consider if the one presented in this patchset
>   is not acceptable. I was initially reluctant to this approach because it
>   adds more CXL coupling to the AER driver. But, I think this solution
>   would technically work. I believe Ming was working towards this
>   solution.
> 
>   3.) Refactor portdrv
>   The portdrv refactoring solution is to change the portdrv service drivers
>   into PCIe auxiliary drivers. With this change the facility drivers can be
>   associated with a PCIe driver instead fixed bound to the portdrv driver.
> 
>   In this case the CXL port functionality would be added either as a CXL
>   auxiliary driver or as a CXL specific port driver
>   (PCI_CLASS_BRIDGE_PCI_NORMAL).
> 
>   This solution has challenges in the interrupt allocation by separate
>   auxiliary drivers and in binding of a specific driver. Binding is
>   currently based on PCIe class and would require extending the binding
>   logic to support multiple drivers for the same class.
> 
>   Jonathan Cameron is working towards this solution by initially solving
>   for the PMU service driver.[1] It is using the auxiliary bus to associate
>   what were service drivers with the portdrv driver. Using a CXL auxiliary
>   for handling CXL port RAS errors would result in RAS logic called from
>   the cxl_pci and CXL auxiliary drivers. This may need a library driver.
> 
>   4.) Using a portdrv notifier chain/callback for CIE/UIE
>   (Implemented in this patchset)
> 
>   This solution uses a portdrv atomic chain notifier and a cxl_pci
>   callback to handle and log CXL port RAS errors.
>   
>   I chose this after trying solution#1 above. I see a couple advantages to
>   this solution are:
>   - Is general port implementation for CIE/UIE specific handling mentioned
>   in the PCIe spec.[2]
>   - Notifier is used in RAS MCE driver as an existing example.
>   - Does not introduce further CXL dependencies into the AER driver.
>   - The notifier chain provides registration/unregistration and
>   synchronization.
> 
>   A disadvantage of this approach is coupling still exists between the CXL
>   port's driver (portdrv) and the cxl_pci driver. The CXL port device's RAS
>   is handled by a notifier callback in the cxl_pci endpoint driver.
> 
>   Most of the patches in this patchset could be reused to work with
>   solution#3 or solution#2. The atomic notifier could be dropped and
>   instead use an auxiliary device or AER driver awareness. The other
>   changes in this patchset could possibly be reused.
> 
>   [1] Kernel.org -
>   https://lore.kernel.org/all/f4b23710-059a-51b7-9d27-b62e8b358b54@linux.intel.com
>   [2] PCI6.0 - 6.2.10 Internal errors
> 
>  drivers/cxl/core/core.h    |   4 +
>  drivers/cxl/core/pci.c     | 153 ++++++++++++++++++++++++++++++++-----
>  drivers/cxl/core/port.c    |   6 +-
>  drivers/cxl/core/trace.h   |  34 +++++++++
>  drivers/cxl/cxl.h          |  10 +++
>  drivers/cxl/cxlpci.h       |   2 +
>  drivers/cxl/mem.c          |  32 +++++++-
>  drivers/cxl/pci.c          |  19 ++++-
>  drivers/pci/pcie/aer.c     |  10 ++-
>  drivers/pci/pcie/err.c     |  20 +++++
>  drivers/pci/pcie/portdrv.c |  32 ++++++++
>  drivers/pci/pcie/portdrv.h |   2 +
>  include/linux/aer.h        |   6 ++
>  13 files changed, 303 insertions(+), 27 deletions(-)
> 
> 
> base-commit: ca3d4767c8054447ac2a58356080e299a59e05b8
> -- 
> 2.34.1
> 
