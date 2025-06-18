Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2FB2EA722;
	Wed, 18 Jun 2025 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750262089; cv=none; b=KdiSwkrljPvzfZQ52aXl9aizY695fL0sFKCUL35Eysj79lqaXngWPX7DoQNL5aE8EpYkmiTMTAOHR5ucjfOFMaKi0F6dC//xX73nz8olYWdkZPidlec5Iha8M9lBr1ZLBsENb7Xkbi9tGjGT34JIvR1bhXY9zh66f/Hqxiqm2qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750262089; c=relaxed/simple;
	bh=TYaOw3OLDyqbZg3cuyh2IX2/ry9fRgGfv8K/aPYKEhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKE7hJ8mCatJuD1BSnei6lzE+YoQY8hcvN0l2T8FFmNemna+nuzB3NFF4vX2V1P7TuDzFhch6UBeGeQxV+iv1Q9ddNEDfemDAVQVuYAvNwxbx6eJe27WPI6fZ4gwyZ0JJUWbGqQbmnl/WXRXUfCfQoedLJA4Ojhr7HET9aUiHMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U84FsccZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U84FsccZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=1qG6PR93pp9WWpgSqxBn8+x0PtdRPsOLjdcV/Rd6xCw=; b=U84FsccZheRvwYINiEx/F8+LGA
	nmwbjbqqO8d0LogCtGNe80XO3xllfmuS/inpkmgDJ+6/shnpNES5SODMVjIBvC8JOUYcMELjF2SV6
	ipWD4N3I7CjVqrBlQ/oPQ2utQJaccfl6jUm0oel2++zdwsNEuXfP+2S4/1eALmzo3vznEONrfjOqV
	BWAwPGOMXSjOvApG3fBIP4dUlQ1QkyngVcgu3+PgezzZI8Ai6J/O7gyLN7VzbrmRHeMug8jZCPz3P
	wTjiokE32up81HzZ1Roqpn5BpLq2DpXA+ZrgFRTyzV5E+sOlGYHy13RK46fFXquF8eFRUsuj9wuJI
	cYTcEa/w==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRv7X-000000048sw-3fhM;
	Wed, 18 Jun 2025 15:54:40 +0000
Message-ID: <34fcdfb0-e32c-4eb3-8afe-49c34dcab2c3@infradead.org>
Date: Wed, 18 Jun 2025 08:54:35 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: docs/driver-api/conventions resolve conflicts btw
 CFMWS, LMH, ED
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250618151710.1001847-1-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250618151710.1001847-1-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 6/18/25 8:17 AM, Fabio M. De Francesco wrote:
> Add documentation on how to resolve conflicts between CXL Fixed Memory
> Windows, Platform Memory Holes, and Endpoint Decoders.
> 
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  Documentation/driver-api/cxl/conventions.rst | 85 ++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
> index da347a81a237..acf2523ae799 100644
> --- a/Documentation/driver-api/cxl/conventions.rst
> +++ b/Documentation/driver-api/cxl/conventions.rst
> @@ -45,3 +45,88 @@ Detailed Description of the Change
>  ----------------------------------
>  
>  <Propose spec language that corrects the conflict.>
> +
> +
> +Resolve conflict between CFMWS, Plaftform Memory Holes, and Endpoint Decoders
> +=============================================================================
> +
> +Document
> +--------
> +
> +CXL Revision 3.2, Version 1.0
> +
> +License
> +-------
> +
> +SPDX-License Identifier: CC-BY-4.0
> +
> +Creator/Contributors
> +--------------------
> +
> +Fabio M. De Francesco, Intel
> +Dan J. Williams, Intel
> +Mahesh Natu, Intel
> +
> +Summary of the Change
> +---------------------
> +
> +According to the current CXL Specifications (Revision 3.2, Version 1.0)
> +the CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> +Physical Address (HPA) windows that are associated with each CXL Host
> +Bridge. Each window represents a contiguous HPA range that may be
> +interleaved across one or more targets, some of which are CXL Host Bridges.
> +Associated with each window are a set of restrictions that govern its

                               is

> +usage. It is the OSPM’s responsibility to utilize each window for the
> +specified use.
> +
> +Table 9-22 states the Window Size field contains that the total number of

                                           contains the total number of

> +consecutive bytes of HPA this window represents and this value shall be a
> +multiple of Number of Interleave Ways * 256 MB.
> +
> +Platform Firmware (BIOS) might reserve part of physical addresses below
> +4 GB (e.g., the Low Memory Hole that describes PCIe memory space for MMIO
> +or a requirement for the greater than 8 way interleave CXL regions starting
> +at address 0). In that case the Window Size value cannot be anymore
> +constrained to the NIW * 256 MB above-mentioned rule.
> +
> +On those systems, BIOS publishes CFMWS which communicate the active System
> +Physical Address (SPA) ranges that map to a subset of the Host Physical
> +Address (HPA) ranges. The SPA range trims out the hole, and capacity in the
> +endpoint is lost with no SPA to map to CXL HPA in that hole.
> +
> +The description of the Window Size field in table 9-22 needs to take that
> +special case into account.
> +
> +Note that the Endpoint Decoders HPA range sizes have to comply with the
> +alignment constraints and so a part of their memory capacity might not be
> +accessible if their size exceeds the matching CFMWS range's.
> +
> +Benefits of the Change
> +----------------------
> +
> +Without this change, the OSPM wouldn't match Endpoint Decoders with CFMWS
> +whose Window Size don't comply with the alignment rules and so all their
> +capacity would be lost. This change allows the OSPM to match Endpoint
> +Decoders whose HPA range size exceeds the matching CFMWS and create
> +regions that at least utilize part of the decoders total memory capacity.
> +
> +References
> +----------
> +
> +Compute Express Link Specification Revision 3.2, Version 1.0
> +<https://www.computeexpresslink.org/>
> +
> +Detailed Description of the Change
> +----------------------------------
> +
> +The current description of a CFMWS Window Size (table 9-22) is replaced
> +with:
> +
> +"The total number of consecutive bytes of HPA this window represents. This
> +value shall be a multiple of NIW*256 MB. On platforms that reserve physical
> +addresses below 4 GB for special use (e.g., the Low Memory Hole for PCIe
> +MMIO on x86), an instance of CFMWS whose Base HPA is 0 might have a window
> +size that doesn't align with the NIW*256 MB constraint; note that the
> +matching Endpoint Decoders HPA range size must still align to the
> +above-mentioned rule and so the memory capacity that might exceeds the

                                                              exceed

> +CFMWS window size will not be accessible.".
> 
> base-commit: a021802c18c4c30dff3db9bd355cacb68521f1aa

-- 
~Randy

