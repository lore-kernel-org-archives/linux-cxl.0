Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933263B4EAC
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782852600; cv=none; b=US+GDJcMuJmPZEha5YAmxvJjO19Bz3IG6CHKqqPZbiBy3udgc/MMxftytFvVmy6/jyPZWU33zg/X9zQBr51v9QI2x5Sxj2TDx1j3Y6h00p6YUfGnLlgJebCEpmGbJhNZa13Un5k65coTRL/siheH2Tj0kh/TMAWWI08B4TVHH7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782852600; c=relaxed/simple;
	bh=Wd8MVIID6egOQqXxF5kZm/fnU/lM8+Fwn+B3zFc66p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xwz3UK0WVfvOSGz7Z9JRHPHL+AFUpblui96QRKYxinNPFPNfrmbQKPj9fNq0WyFmBQrw5G1YD9WDRk/Z9cwkQUS5U2K//yZCZveggMun7PHsYBaXxadJ6UXFupyu6D/8DxRxLPYCtFzy+ZWPN1Gp4Mgq1U/v3+DjX5e7+Nh5sI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brfMe9pB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brfMe9pB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782852599; x=1814388599;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wd8MVIID6egOQqXxF5kZm/fnU/lM8+Fwn+B3zFc66p8=;
  b=brfMe9pBwmjcO86lJ4lgFaZ2j/erqYmn0gU3j9ZWHQhEP3V9ZvmWJF/X
   pD51xYx/3EK096tig4UxXGILakTRSCBTbnDkkk/UiSel0WgNDwt8X2A6Y
   QXuH5dw0cAD2VEhPxTO8WiPLQHshT3CvQsTnqRuOsq3vYDGtum8yHliid
   nH7lPz7O5e0NNy8aJBSgMT7x8rCNE9QP5jtO0TzRjVzyHDwpwNMqj9IJx
   puCP+FB2TENghlIe9PKE8SJGE52TLa5F2zEiUZWGaPqd4EqlSKfXy20it
   R5Qe8vJocvuYwKZeyKwHBp7E4G5YJHqwQp46A8m+hWH2yrB7Yl7BqbbwM
   g==;
X-CSE-ConnectionGUID: 9d3N5VtdRRap8Xd8eQTtdw==
X-CSE-MsgGUID: wA1PaIpQSGC9gyP/mi2TrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="106367515"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="106367515"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 13:49:58 -0700
X-CSE-ConnectionGUID: ZgHBlqISQqeOV4SJu2MesQ==
X-CSE-MsgGUID: 4Z1R9TfwQuSz9XDB1I6iLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="252485741"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.254]) ([10.125.109.254])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 13:49:57 -0700
Message-ID: <8eef5e14-4b02-422a-9d17-fa0a189c9335@intel.com>
Date: Tue, 30 Jun 2026 13:49:56 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v30 0/2] Type2 device basic support
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org, djbw@kernel.org
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260629183727.51502-1-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260629183727.51502-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/29/26 11:37 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> This series adds the last bits for allowing a CXL Type2 driver to obtain
> a CXL region linked to the device HDM decoders committed by the BIOS.
> 
> For the sake of merging those changes and the driver using them, this
> version only adds the changes without a client. A later series will
> include sfc netdev driver as the client.
> 
> Changes from v29:
> 
>  - Only cxl core changes.
> 
> Changes from v28:
> 
>  - patch 1:
>         fix doc (Ed Cree)
>         fix error path (Sashiko)
> 
>  - patch 3:
>         removing extra + char (sashiko)
> 
>  - path5:
>         remove stray change (Ed Cree)
> 
> Changes from v27:
> 
>  - patch 1: make driver probe failing if error in efx_cxl_init (Dan)
>  - patch 4: add unmapping if error after efx_cxl_init (Dave)
>  - patch 4/5: move cxl_pio_initialised from patch 4 to patch 5 (Dave)
> 
> Tested in the cxl_for_7.3 branch.
> 
> 
> Alejandro Lucero (2):
>   cxl: Support Type2 cxl regs mapping
>   cxl: Support dpa without a mailbox
> 
>  drivers/cxl/core/core.h   |  2 ++
>  drivers/cxl/core/mbox.c   | 51 +----------------------------
>  drivers/cxl/core/memdev.c | 67 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/pci.c    |  1 +
>  drivers/cxl/core/port.c   |  1 +
>  drivers/cxl/core/regs.c   |  1 +
>  drivers/cxl/cxlpci.h      | 12 -------
>  drivers/cxl/pci.c         |  1 +
>  include/cxl/cxl.h         |  2 ++
>  include/cxl/pci.h         | 22 +++++++++++++
>  10 files changed, 98 insertions(+), 62 deletions(-)
>  create mode 100644 include/cxl/pci.h
> 
> 
> base-commit: 9b1e70e8f9ec4b5c6ce7fa774a0023bb6894c686

Applied to cxl/next
96ddf1af34f5 cxl: Support dpa without a mailbox
2c599da8231f cxl: Support Type2 cxl regs mapping


