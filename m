Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1155522615;
	Sun, 10 Nov 2024 06:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731219437; cv=none; b=ReqMAueL0d1FIK9PIRX+eJCr59nTV7VMaKahh5QZIr95QcAhNK6Pn1pOvIAlSwCIdwm4k1mE+zoCtNYHN/eqMildUHdDLY6pRd7gjcg8MIMxcbTaqDf/WEpl7Pi82W6Pj/pXQCkJFwcQpvO2k7LUwPSp02QpGZvsr7FpKpr6tgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731219437; c=relaxed/simple;
	bh=fwb62Lj1lAFYosbkNrdTSf5fUePYFTt/62O0i0evxIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LXq/d5GWn2DUqfO5gvUMTFbD4RX3ztVyIKdkV40CLNyRK8xBS9etLXLf8dFHDI/egKRN8z51+NYyfKkMqb8/hxqSS7iAiwhSfw2KRp3sF6LIQTAQ7/ODXw0ilmeriLOmqQO1NsJmxqFmm4CEm+Wdhko3sUjzzhGUkPglJ6u26O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vw+HntJC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vw+HntJC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731219436; x=1762755436;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=fwb62Lj1lAFYosbkNrdTSf5fUePYFTt/62O0i0evxIo=;
  b=Vw+HntJC1rX1Sz8fvchlOOG5eO1a7U2bLjfnqgNJAZWsOdTQNyjZinz0
   oPXeZKpmIcMR8MZXlRmwoIRNYXcJzQsBRiji8XlMZmLgl8RUzAgg7r0uu
   lKjWminK+rp67N0Ur+3l6Ew83YpEugJmsODXKtnDh5DDCdylrP4ksP+3f
   8D2n+g/Z9iCMk8/UB+HKzcLPFw6Uf04ypFNq1zcZpUKWGg1Dt0OQF+kNH
   AnWwiOV2Pb7/B3Xei3B2FV0+/Uf274T/PYRDOLQIhoJp3neX8Q9vWoJhd
   +31GqiqkvciVLE3YaHc6kWlJHJ4MtNr9DoYy4fIhqM+aoVg5y9ZA0jRj9
   g==;
X-CSE-ConnectionGUID: Mq/mbAo3S5WYTcxWGiq4dQ==
X-CSE-MsgGUID: bAiiRXvES2a/fzlz2gmD9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11251"; a="30467807"
X-IronPort-AV: E=Sophos;i="6.12,142,1728975600"; 
   d="scan'208";a="30467807"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2024 22:17:15 -0800
X-CSE-ConnectionGUID: RGSAiD6BRPCGXc13AkPm/g==
X-CSE-MsgGUID: IfihfXWeSaWqbeNUHMB0+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,142,1728975600"; 
   d="scan'208";a="86481033"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2024 22:17:12 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: "Moore, Robert" <robert.moore@intel.com>, "Zhang, Rui"
 <rui.zhang@intel.com>, Dan Williams <dan.j.williams@intel.com>,  Jonathan
 Cameron <Jonathan.Cameron@huawei.com>
Cc: Alison Schofield <alison.schofield@intel.com>,  Dave Jiang
 <dave.jiang@intel.com>,  linux-cxl@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Davidlohr Bueso <dave@stgolabs.net>,
  Gregory Price <gourry@gourry.net>,  Vishal Verma
 <vishal.l.verma@intel.com>,  Ira Weiny <ira.weiny@intel.com>,  Alejandro
 Lucero <alucerop@amd.com>,  Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH] cxl: Rename ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3
In-Reply-To: <672d329119d63_10bb7294cc@dwillia2-xfh.jf.intel.com.notmuch> (Dan
	Williams's message of "Thu, 7 Nov 2024 13:35:13 -0800")
References: <20241104084110.583710-1-ying.huang@intel.com>
	<ZyrUFMutrN_uJvPe@aschofie-mobl2.lan>
	<878qtx6q0d.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<Zy0kt2i9C6eirhPN@aschofie-mobl2.lan>
	<672d329119d63_10bb7294cc@dwillia2-xfh.jf.intel.com.notmuch>
Date: Sun, 10 Nov 2024 14:13:39 +0800
Message-ID: <87a5e762gc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Dan Williams <dan.j.williams@intel.com> writes:

> Alison Schofield wrote:
> [..]
>> > I think so too.  However, I prefer to keep this patch just mechanic
>> > renaming and do these changes in another patch.  Do you agree?
>> > 
>> 
>> I don't know. I was just questioning where and how far the naming scheme
>> needs to change.
>> 
>> Maybe Jonathan, as the Suggested-by, can chime in and move this ahead.
>
> I feel like we are going to be living with the ghosts of the original
> "Type2 / Type3" naming problem for the rest of the subsystem's lifespan
> especially since they were encoded in the ABI and ABI is forever.
>
> I am not opposed to this localized rename in drivers/cxl/acpi.c on
> principal, but in terms of incremental value relative to the thrash, it's
> questionable.
>
> For example changes to include/acpi/actbl1.h need to be chased through
> ACPICA, at which point is this rename really worth it?

I think that it's not too hard to change ACPI tables definition.  Added
Bob and Rui for ACPICA related change.

--
Best Regards,
Huang, Ying
