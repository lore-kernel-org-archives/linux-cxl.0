Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EB01917FB;
	Wed,  3 Sep 2025 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756937113; cv=none; b=e3c7zmhWg2W6a8SPuQzOcSiRt5+BiQfY/7K5V+b1VJOMaN07AI9RVwEYRCgE7O4ALIsqDd1Ik3NexUrBDcG1kQDoZkoo2WURbDGfI1Jnsrq9E3Bxm3syZvBGKDtcHDaC9fhjW3OoReNOgI93ftA/Jlj+OSBlmWKSIc4wSAwv2gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756937113; c=relaxed/simple;
	bh=a0eF62r11TB+IVuGXdIiqQ+xqdJk9AeMgBtqFjJTp8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqHoPXWckziuFP50BXQkGkFs/ydlqX0KuK5VV9e8tmcChVVhfNoQ0AI00/TUxuSfRSYOioYW1rGl+t8bMGeBdN+ZqocHMGJl9qtIohVcXV8FV0X3W0/RczPIDZgWTr4G3b5HlIR29zgZCxvRcJr12rb0cLCwwUUkh/Kw/ehFerQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LkyfDAd1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LkyfDAd1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756937110; x=1788473110;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a0eF62r11TB+IVuGXdIiqQ+xqdJk9AeMgBtqFjJTp8U=;
  b=LkyfDAd1yRu0nmxOfkx0EAA7/TewzSviglTzEKy2HwNAImk4KQ7uNPkJ
   yb6mN+D8mgUWMbrbiXLjsaLgTmYW2qtwiaCZfsK3NaeCeqaOx6yLvxHpD
   UZ/Kpdh5sW0e8UNVWFqtavDcOwL5GBUkZ4LJox1FJPm4uiRCaha9TU3hK
   VfXujotW7pz6Raba6w/g4k2lmc88hDvpqCF01hNSh9ioslmpSxdlnFWJL
   CXyWNO3mJeGqxvqPzvn2r6nZ1lcJNuC6n1oEI8zR6b62YVkYNHkTbJ9ps
   MrX6LETfplDl7wMP75LrpN7R+lz8nErHimPsg2ESoDdY/mQJNpBgZto34
   Q==;
X-CSE-ConnectionGUID: v8YJtbwDRFCSuET5q3xy5w==
X-CSE-MsgGUID: 6I8vdJm6QVC3c0L1Cdcw/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59375629"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="59375629"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 15:05:09 -0700
X-CSE-ConnectionGUID: P+UpPJ31SW6226ksIL7zfg==
X-CSE-MsgGUID: jeGAe48vTTOZIfV5uuNqaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="202653473"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.109.251]) ([10.125.109.251])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 15:05:07 -0700
Message-ID: <7e52cd7c-0de7-4e7d-9a70-f3bb9cd32a52@intel.com>
Date: Wed, 3 Sep 2025 15:05:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cxl: docs/driver-api/conventions resolve conflicts
 between CFMWS, Low memory Holes, Decoders
To: Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ALOK TIWARI <alok.a.tiwari@oracle.com>, Randy Dunlap
 <rdunlap@infradead.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
 Robert Richter <rrichter@amd.com>
References: <20250903131026.1462103-1-fabio.m.de.francesco@linux.intel.com>
 <aLh_SDbWHn_d-1Bv@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aLh_SDbWHn_d-1Bv@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/3/25 10:47 AM, Gregory Price wrote:
> On Wed, Sep 03, 2025 at 03:10:10PM +0200, Fabio M. De Francesco wrote:
>> Add documentation on how to resolve conflicts between CXL Fixed Memory
>> Windows, Platform Low Memory Holes, intermediate Switch and Endpoint
>> Decoders.
>>
>> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
>> ---
>>
>> v4 -> v5: Fix grammar and syntactic errors (Dave)
>> 	  Spell out CXL, OSPM, on first use (Dave)
>> 	  Rewrite a few sentences for better clarity (Dave)
>> 	  Talk about SPA vs HPA and SPA's relationship to CFMWS (Dave)
>> 	  Adjust a table for htmldocs output (Bagas)
>> 	  Use bullet list (Bagas)
>> 	  Correct the CFMWS[1] HPA range to not overlap CFMWS[0] (Robert)
>> 	  Correct the CFMWS[1] HPA range to the NIW*256MB rule (Robert)
>>
>> v3 -> v4: Show and explain how CFMWS, Root Decoders, Intermediate
>> 	  Switch and Endpoint Decoders match and attach Regions in
>> 	  x86 platforms with Low Memory Holes (Dave, Gregory, Ira)
>> 	  Remove a wrong argument about large interleaves (Jonathan)
>>
>> v2 -> v3: Rework a few phrases for better clarity.
>> 	  Fix grammar and syntactic errors (Randy, Alok).
>> 	  Fix semantic errors ("size does not comply", Alok).
>> 	  Fix technical errors ("decoder's total memory?", Alok).
>> 	  
>> v1 -> v2: Rewrite "Summary of the Change" section, 3r paragraph.
>>
>>  Documentation/driver-api/cxl/conventions.rst | 118 +++++++++++++++++++
>>  1 file changed, 118 insertions(+)
>>
>> diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
>> index da347a81a237..f5ccb5c3b7b9 100644
>> --- a/Documentation/driver-api/cxl/conventions.rst
>> +++ b/Documentation/driver-api/cxl/conventions.rst
>> @@ -45,3 +45,121 @@ Detailed Description of the Change
>>  ----------------------------------
>>  
>>  <Propose spec language that corrects the conflict.>
>> +
>> +
>> +Resolve conflict between CFMWS, Platform Memory Holes, and Endpoint Decoders
>> +============================================================================
>> +
>> +Document
>> +--------
>> +
>> +CXL Revision 3.2, Version 1.0
>> +
>> +License
>> +-------
>> +
>> +SPDX-License Identifier: CC-BY-4.0
>> +
>> +Creator/Contributors
>> +--------------------
>> +
>> +- Fabio M. De Francesco, Intel
>> +- Dan J. Williams, Intel
>> +- Mahesh Natu, Intel
>> +
>> +Summary of the Change
>> +---------------------
>> +
>> +According to the current Compute Express Link (CXL) Specifications (Revision
>> +3.2, Version 1.0), the CXL Fixed Memory Window Structure (CFMWS) describes zero
>> +or more Host Physical Address (HPA) windows associated with each CXL Host
>> +Bridge. Each window represents a contiguous HPA range that may be interleaved
>> +across one or more targets, including CXL Host Bridges.  Each window has a set
>> +of restrictions that govern its usage. It is the Operating System-directed
>> +configuration and Power Management (OSPM) responsibility to utilize each window
>> +for the specified use.
>> +
>> +Table 9-22 of the current CXL Specifications states that the Window Size field
>> +contains the total number of consecutive bytes of HPA this window describes.
>> +This value must be a multiple of the Number of Interleave Ways (NIW) * 256 MB.
>> +
>> +Platform Firmware (BIOS) might reserve physical addresses below 4 GB where a
>> +memory gap such as the Low Memory Hole for PCIe MMIO may exist. In such cases,
>> +the CFMWS Range Size may not adhere to the NIW * 256 MB rule.
>> +
>> +The HPA represents the actual physical memory address space that the CXL devices
>> +can decode and respond to, while the System Physical Address (SPA), a related
>> +but distinct concept, represents the system-visible address space that users can
>> +direct transaction to and so it excludes reserved regions.
>> +
>> +BIOS publishes CFMWS to communicate the active SPA ranges that, on platforms
>> +with LMH's, map to a strict subset of the HPA. The SPA range trims out the hole,
>> +resulting in lost capacity in the Endpoints with no SPA to map to that part of
>> +the HPA range that intersects the hole.
>> +
>> +E.g, an x86 platform with two CFMWS and an LMH starting at 2 GB::
>> +
>> + +--------+------------+-------------------+------------------+-------------------+------+
>> + | Window | CFMWS Base |    CFMWS Size     | HDM Decoder Base |  HDM Decoder Size | Ways |
>> + +========+============+===================+==================+===================+======+
>> + |   0    |   0 GB     |       2 GB        |      0 GB        |       3 GB        |  12  |
>> + +--------+------------+-------------------+------------------+-------------------+------+
>> + |   1    |   4 GB     | NIW*256MB Aligned |      4 GB        | NIW*256MB Aligned |  12  |
>> + +--------+------------+-------------------+------------------+-------------------+------+
>> +
>> +HDM decoder base and HDM decoder size represent all the 12 Endpoint Decoders of
>> +a 12 ways region and all the intermediate Switch Decoders.  They are configured
>> +by the BIOS according to the NIW * 256MB rule, resulting in a HPA range size of
>> +3GB.
> 
> This whole thing just clicked for me.   It wasn't immediately clear that
> there were 2 issues until you made the edit to the chart above.  Now it
> clicks that Window 0 is not 12-way aligned AND there's a size mismatch.
> 
> It might be helpful to just spell it out more explicitly like so:
> 
> """
> This creates 2 issues which lead to a failure to construct a region:
> 
> 1) A mismatch in region size between root and any HDM decoder.  The root
>    decoder will always be smaller due to the trim.
> 
> 2) The trim causes the root decoder to violate the (NIW * 256MB) rule.
> 
> This change allows a region with a base address of 0GB to bypass these
> checks to allow for region creation with the trimmed root decoder
> address range.
> 
> This change does not allow for any other arbitrary region to violate
> these checks - it is intended primarily to enable x86 platforms which
> map CXL memory under 4GB.
> """
> 
> 
> It may also be important to point out that this configuration is
> actually safe from the perspective of linux - so long as the platform's
> MMU is configured to respect the root decoder rules.  Said better:
> 
> 
> """
> Despite the HDM decoders covering the PCIE hole HPA region, it is
> expected that the platform will never route address accesses to the CXL
> complex because the root decoder only covers the trimmed region (which
> excludes this).  This is outside the ability of Linux to enforce.
> """
> 
> 
> If other people think this isn't worth spelling out and i'm just being a
> stickler for wording / clarity, then ignore me.

+1 for me on the additional clarifications from Gregory.

DJ

  
> 
> I'm ok with this as written if you think additional edits are a step too
> far.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> 
>> +
>> +The CFMWS Base and CFMWS Size are used to configure the Root Decoder HPA range
>> +base and size. CFMWS cannot intersect Memory Holes, then the CFMWS[0] size is
>> +smaller (2GB) than that of the Switch and Endpoint Decoders that make the
>> +hierarchy (3GB).
>> +
>> +On that platform, only the first 2GB will be potentially usable, but Linux,
>> +aiming to adhere to the current specifications, fails to construct Regions and
>> +to attach Endpoint and intermediate Switch Decoders to them. The several points
>> +of failure are due to the expectation that the Root Decoder HPA size, that is
>> +equal to the CFMWS from which it is configured, has to be greater or equal to
>> +the matching Switch and Endpoint HDM Decoders.
>> +
>> +In order to succeed with construction and attachment, Linux must construct a
>> +Region with Root Decoder HPA range size, and then attach to that all the
>> +intermediate Switch Decoders and Endpoint Decoders that belong to the hierarchy
>> +regardless of their range sizes.
>> +
>> +Benefits of the Change
>> +----------------------
>> +
>> +Without the change, the OSPM wouldn't match intermediate Switch and Endpoint
>> +Decoders with Root Decoders configured with CFMWS HPA sizes that don't align
>> +with the NIW * 256MB constraint, and so it leads to lost memdev capacity.
>> +
>> +This change allows the OSPM to construct Regions and attach intermediate Switch
>> +and Endpoint Decoders to them, so that the addressable part of the memory
>> +devices total capacity is made available to the users.
>> +
>> +References
>> +----------
>> +
>> +Compute Express Link Specification Revision 3.2, Version 1.0
>> +<https://www.computeexpresslink.org/>
>> +
>> +Detailed Description of the Change
>> +----------------------------------
>> +
>> +The description of the Window Size field in table 9-22 needs to account for
>> +platforms with Low Memory Holes, where SPA ranges might be subsets of the
>> +endpoints HPA. Therefore, it has to be changed to the following:
>> +
>> +"The total number of consecutive bytes of HPA this window represents. This value
>> +shall be a multiple of NIW * 256 MB.
>> +
>> +On platforms that reserve physical addresses below 4 GB, such as the Low Memory
>> +Hole for PCIe MMIO on x86, an instance of CFMWS whose Base HPA range is 0 might
>> +have a size that doesn't align with the NIW * 256 MB constraint.
>> +
>> +Note that the matching intermediate Switch Decoders and the Endpoint Decoders
>> +HPA range sizes must still align to the above-mentioned rule, but the memory
>> +capacity that exceeds the CFMWS window size won't be accessible.".
>> -- 
>> 2.50.1
>>

