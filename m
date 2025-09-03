Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0F432A815
	for <linux-cxl@vger.kernel.org>; Wed,  3 Sep 2025 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921678; cv=none; b=sXPnoQtoS6fy6W9zck9LsotPMwFNm1R4TQtCeo9VeWQ2bL2sUAc+paqo8C4Bwzn66GwimWZLkTom//WB/VTu/E3q0mcFEgpJiSQZhSYyq8S4bA8kXztWnJ4mbCvTub3ZKgGqe5DibmwHWzfZdc4cMAMn55Z1byHcPAEuEsNFuik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921678; c=relaxed/simple;
	bh=UFUyim/vpdH57fhBQtDi1V/uvTcjxeyNNYitmHXJuD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ezlpjpx+9LwCb2B6W6WLWKpCR6JzF78YEu6QvzxSBQahST/g0jCZkE5y/bbUQM6Uw0kzKjQ5x6kyjoWz9mxQC4hQg7C6Q9iNvOfnTaeKIQU6YV8NWFbvmwUqqjqyK2+/Zvqa06azZkqAPQmfVMc/7YLmjRcxLjBwRzL3sA9kibg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gA94TIM3; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gA94TIM3"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-7209bd264f0so13586706d6.1
        for <linux-cxl@vger.kernel.org>; Wed, 03 Sep 2025 10:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1756921675; x=1757526475; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hno4kQ13YJL7dU8EQ1IXVZm3EQ6nHEFUGJPOJ6xwNv0=;
        b=gA94TIM3UnPGkbvJxlRtcfcrpRjuUlh/N65EY96VYM4b7J+kzFYCh5gHRLcYi0tOEv
         ix3Ig4e1fBThfZelvL9gXogCXnggtGNabNXtUsAH+Q7dw+uR2gvV2fUVSLtRlM6LW8/a
         P5xUKdRySxJSEZ2I+DGArslHFaoRuJmoE+Ojs640+wQlBBhpXF3VPZyfdGWsiMmSmgch
         2xoIfDXn59LziamWHoxqTRA1Lovwf4ttKq5q+4Tyg8dSNZWYjM4y/pqkqonex4/K4kO6
         4nuLLvsxJD/8zr8R2CkKnJzyPU6ati6UHCnakyhzZRJfkeRqedjzsp5oguXa/OnLDpyL
         qYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756921675; x=1757526475;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hno4kQ13YJL7dU8EQ1IXVZm3EQ6nHEFUGJPOJ6xwNv0=;
        b=vmufuh4EJFPIER9/W69+JOTMnycHs1Sz21aYC+FDkqnSBMb/PZWkTqTwl04UEtcqtS
         tjXrEBwW09BTe2laPeyhj1KFI2+Gg0ahhcRh0+vjF/rql+sPtMobapLbiZp12gloZYX7
         QWQPle2YwNnrSZP01AGHPx6YC8SPCPZkfULxEwbAoY3+KqJIfQMWdeRJ8e8/hrgXtvXD
         if8+PCHlFS6zQa4rMv4azRt2NG3gC9Ql+iDoRr5rtc1aJVV+pnxS7JzgKUZoNo0WJXqo
         wrNEi5V67rlxNzxV3AW1S9wSlMkTN4ZmgJIwWnK3ChLEsoenRAvmRJqlwF5NIOJhJOD0
         cV6Q==
X-Gm-Message-State: AOJu0YxATzSJxp/F8YeHpPF9L/b4V1ja2iQ2ozk2+08MeEIJ1WXdE6Cn
	dTr6thlQryWKwu7HyDYON/P3ws+0VbvdQOj0SqBaCDulGAspcnZDeNb2NzujEXVVSPDsmYshQJv
	AZFIV
X-Gm-Gg: ASbGncughdpFdVZbPFcW10tyLjd+XQv/X84LT5XbUmeiI7EcT1HteAcroSaUzp4FQbo
	hccJBtkXFZHGn4j3yJd1FHIHEP5hZh6ZDvQrYe6sbPUqOwbtc97nJHfRF3wXp9cbmRcgkBmit2a
	VbyuDyXR55mgE6X2FzrM6YZ8Mc+FfZi24tzSaq2FkHVLBu7an3nDhI3FD574UQknREyxiDRhvqT
	ha086qn0EYqwe4Z2u/Y0jTZCfSfU8Bw6PpW5+ahYPGBJYSAHqHfqysfeeSqSwbGXwh/yuHAqGQ1
	fhlwKKg+4sik2Vj1Hg2JXdr/50A+r4azh4olScDS9zh2cPDpWhcQ50VxNOeSJLzNohQuiIcMm7i
	bOVbfIkVC/RR6CBL5mRZFkq32JcGEtLqPXQJdWc09zLHmyw16T40HTI+fFVn8XfLKO9T4VBJxbw
	5ql3L80XljVYlg
X-Google-Smtp-Source: AGHT+IGAVZX+c8IiZ+XorJqKNinf2SYtFMck9goldWy6wMCdHIljZCqp5TIab+gCOeTnMCwOs1yRhg==
X-Received: by 2002:a05:6214:c48:b0:70d:f51b:470b with SMTP id 6a1803df08f44-70fac7da87bmr177347796d6.14.1756921674599;
        Wed, 03 Sep 2025 10:47:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16e418sm32601236d6.4.2025.09.03.10.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 10:47:54 -0700 (PDT)
Date: Wed, 3 Sep 2025 13:47:52 -0400
From: Gregory Price <gourry@gourry.net>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v5] cxl: docs/driver-api/conventions resolve conflicts
 between CFMWS, Low memory Holes, Decoders
Message-ID: <aLh_SDbWHn_d-1Bv@gourry-fedora-PF4VCD3F>
References: <20250903131026.1462103-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903131026.1462103-1-fabio.m.de.francesco@linux.intel.com>

On Wed, Sep 03, 2025 at 03:10:10PM +0200, Fabio M. De Francesco wrote:
> Add documentation on how to resolve conflicts between CXL Fixed Memory
> Windows, Platform Low Memory Holes, intermediate Switch and Endpoint
> Decoders.
> 
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
> 
> v4 -> v5: Fix grammar and syntactic errors (Dave)
> 	  Spell out CXL, OSPM, on first use (Dave)
> 	  Rewrite a few sentences for better clarity (Dave)
> 	  Talk about SPA vs HPA and SPA's relationship to CFMWS (Dave)
> 	  Adjust a table for htmldocs output (Bagas)
> 	  Use bullet list (Bagas)
> 	  Correct the CFMWS[1] HPA range to not overlap CFMWS[0] (Robert)
> 	  Correct the CFMWS[1] HPA range to the NIW*256MB rule (Robert)
> 
> v3 -> v4: Show and explain how CFMWS, Root Decoders, Intermediate
> 	  Switch and Endpoint Decoders match and attach Regions in
> 	  x86 platforms with Low Memory Holes (Dave, Gregory, Ira)
> 	  Remove a wrong argument about large interleaves (Jonathan)
> 
> v2 -> v3: Rework a few phrases for better clarity.
> 	  Fix grammar and syntactic errors (Randy, Alok).
> 	  Fix semantic errors ("size does not comply", Alok).
> 	  Fix technical errors ("decoder's total memory?", Alok).
> 	  
> v1 -> v2: Rewrite "Summary of the Change" section, 3r paragraph.
> 
>  Documentation/driver-api/cxl/conventions.rst | 118 +++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
> index da347a81a237..f5ccb5c3b7b9 100644
> --- a/Documentation/driver-api/cxl/conventions.rst
> +++ b/Documentation/driver-api/cxl/conventions.rst
> @@ -45,3 +45,121 @@ Detailed Description of the Change
>  ----------------------------------
>  
>  <Propose spec language that corrects the conflict.>
> +
> +
> +Resolve conflict between CFMWS, Platform Memory Holes, and Endpoint Decoders
> +============================================================================
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
> +- Fabio M. De Francesco, Intel
> +- Dan J. Williams, Intel
> +- Mahesh Natu, Intel
> +
> +Summary of the Change
> +---------------------
> +
> +According to the current Compute Express Link (CXL) Specifications (Revision
> +3.2, Version 1.0), the CXL Fixed Memory Window Structure (CFMWS) describes zero
> +or more Host Physical Address (HPA) windows associated with each CXL Host
> +Bridge. Each window represents a contiguous HPA range that may be interleaved
> +across one or more targets, including CXL Host Bridges.  Each window has a set
> +of restrictions that govern its usage. It is the Operating System-directed
> +configuration and Power Management (OSPM) responsibility to utilize each window
> +for the specified use.
> +
> +Table 9-22 of the current CXL Specifications states that the Window Size field
> +contains the total number of consecutive bytes of HPA this window describes.
> +This value must be a multiple of the Number of Interleave Ways (NIW) * 256 MB.
> +
> +Platform Firmware (BIOS) might reserve physical addresses below 4 GB where a
> +memory gap such as the Low Memory Hole for PCIe MMIO may exist. In such cases,
> +the CFMWS Range Size may not adhere to the NIW * 256 MB rule.
> +
> +The HPA represents the actual physical memory address space that the CXL devices
> +can decode and respond to, while the System Physical Address (SPA), a related
> +but distinct concept, represents the system-visible address space that users can
> +direct transaction to and so it excludes reserved regions.
> +
> +BIOS publishes CFMWS to communicate the active SPA ranges that, on platforms
> +with LMH's, map to a strict subset of the HPA. The SPA range trims out the hole,
> +resulting in lost capacity in the Endpoints with no SPA to map to that part of
> +the HPA range that intersects the hole.
> +
> +E.g, an x86 platform with two CFMWS and an LMH starting at 2 GB::
> +
> + +--------+------------+-------------------+------------------+-------------------+------+
> + | Window | CFMWS Base |    CFMWS Size     | HDM Decoder Base |  HDM Decoder Size | Ways |
> + +========+============+===================+==================+===================+======+
> + |   0    |   0 GB     |       2 GB        |      0 GB        |       3 GB        |  12  |
> + +--------+------------+-------------------+------------------+-------------------+------+
> + |   1    |   4 GB     | NIW*256MB Aligned |      4 GB        | NIW*256MB Aligned |  12  |
> + +--------+------------+-------------------+------------------+-------------------+------+
> +
> +HDM decoder base and HDM decoder size represent all the 12 Endpoint Decoders of
> +a 12 ways region and all the intermediate Switch Decoders.  They are configured
> +by the BIOS according to the NIW * 256MB rule, resulting in a HPA range size of
> +3GB.

This whole thing just clicked for me.   It wasn't immediately clear that
there were 2 issues until you made the edit to the chart above.  Now it
clicks that Window 0 is not 12-way aligned AND there's a size mismatch.

It might be helpful to just spell it out more explicitly like so:

"""
This creates 2 issues which lead to a failure to construct a region:

1) A mismatch in region size between root and any HDM decoder.  The root
   decoder will always be smaller due to the trim.

2) The trim causes the root decoder to violate the (NIW * 256MB) rule.

This change allows a region with a base address of 0GB to bypass these
checks to allow for region creation with the trimmed root decoder
address range.

This change does not allow for any other arbitrary region to violate
these checks - it is intended primarily to enable x86 platforms which
map CXL memory under 4GB.
"""


It may also be important to point out that this configuration is
actually safe from the perspective of linux - so long as the platform's
MMU is configured to respect the root decoder rules.  Said better:


"""
Despite the HDM decoders covering the PCIE hole HPA region, it is
expected that the platform will never route address accesses to the CXL
complex because the root decoder only covers the trimmed region (which
excludes this).  This is outside the ability of Linux to enforce.
"""


If other people think this isn't worth spelling out and i'm just being a
stickler for wording / clarity, then ignore me.  

I'm ok with this as written if you think additional edits are a step too
far.

Reviewed-by: Gregory Price <gourry@gourry.net>

> +
> +The CFMWS Base and CFMWS Size are used to configure the Root Decoder HPA range
> +base and size. CFMWS cannot intersect Memory Holes, then the CFMWS[0] size is
> +smaller (2GB) than that of the Switch and Endpoint Decoders that make the
> +hierarchy (3GB).
> +
> +On that platform, only the first 2GB will be potentially usable, but Linux,
> +aiming to adhere to the current specifications, fails to construct Regions and
> +to attach Endpoint and intermediate Switch Decoders to them. The several points
> +of failure are due to the expectation that the Root Decoder HPA size, that is
> +equal to the CFMWS from which it is configured, has to be greater or equal to
> +the matching Switch and Endpoint HDM Decoders.
> +
> +In order to succeed with construction and attachment, Linux must construct a
> +Region with Root Decoder HPA range size, and then attach to that all the
> +intermediate Switch Decoders and Endpoint Decoders that belong to the hierarchy
> +regardless of their range sizes.
> +
> +Benefits of the Change
> +----------------------
> +
> +Without the change, the OSPM wouldn't match intermediate Switch and Endpoint
> +Decoders with Root Decoders configured with CFMWS HPA sizes that don't align
> +with the NIW * 256MB constraint, and so it leads to lost memdev capacity.
> +
> +This change allows the OSPM to construct Regions and attach intermediate Switch
> +and Endpoint Decoders to them, so that the addressable part of the memory
> +devices total capacity is made available to the users.
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
> +The description of the Window Size field in table 9-22 needs to account for
> +platforms with Low Memory Holes, where SPA ranges might be subsets of the
> +endpoints HPA. Therefore, it has to be changed to the following:
> +
> +"The total number of consecutive bytes of HPA this window represents. This value
> +shall be a multiple of NIW * 256 MB.
> +
> +On platforms that reserve physical addresses below 4 GB, such as the Low Memory
> +Hole for PCIe MMIO on x86, an instance of CFMWS whose Base HPA range is 0 might
> +have a size that doesn't align with the NIW * 256 MB constraint.
> +
> +Note that the matching intermediate Switch Decoders and the Endpoint Decoders
> +HPA range sizes must still align to the above-mentioned rule, but the memory
> +capacity that exceeds the CFMWS window size won't be accessible.".
> -- 
> 2.50.1
> 
