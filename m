Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322971E1DE7
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829414; cv=none; b=EeJUOtHP0VKD6lc2THLBYeiPMIw99IPXOaDL/3Pk/vWf5WoVeBrchO2v5JVc6J2Y8gNvPtm938HLCCMPYaj5KW/bgZOc9DEEauBr7PSeQuiCBlLR3Oq/+eZ7DBFvxZ1V0C0ebnBZveFfhG74SmaohAkzzovtKSEnRJknWmQ5w5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829414; c=relaxed/simple;
	bh=UcvleXs0gtRq66DG3komO37ks+Oqnv/1Ck1dY2JB4Fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzoOU7mpKopFXE9Q4a20kW8ne6KYcoWmFf9F8/E5ApNE9yfdlzTyN3Gp/Q2ISNQx+i8LLdqNtCismzB9UBSg2vBkYWobXo77i++jTDMBcdIypMhdbwyzI/azalH7DdSP3CzCFZASpLLYBbu1c4l/6dS1JdHNRS/KftQBjly3usc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/ACQeov; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/ACQeov"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749829413; x=1781365413;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UcvleXs0gtRq66DG3komO37ks+Oqnv/1Ck1dY2JB4Fs=;
  b=Q/ACQeovCwzezc7UXLJizXOic43XM+5ZJnhost7NAZ0LGlNLDjMPnw1x
   8J9BYUsgUbdThP3po+Exj/dHydcVTzwKHGbUNospQQXOUzDyg9eRS/0bX
   ya5ZAZduglWP+rQ+3zfCuBES6Kj6oDxHPKb9o9F+GBOaTH7V8ywzKV5eq
   C23PVlJbwaTjxoHOwXvHAcuzCGa6BPagIQXskinar1Wr4LY5kuVnS1rGo
   Pl7bimCnQrmgbyfNFgMhh7lACJJU3B9gzX05i6NzB6cusQRk4uW/eT57E
   0lctumr605Vguye+NPKOyhKLGuxZQYkx5xQJpsbBUkiZLBoHoM+ZcxLto
   A==;
X-CSE-ConnectionGUID: DhHpGOS2QMu79CBcTaPGuA==
X-CSE-MsgGUID: s1DY7OUwQGCpXd0eaUfQtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="52033001"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="52033001"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 08:43:32 -0700
X-CSE-ConnectionGUID: m/i5e8XOSwynl9jJ/bsuBQ==
X-CSE-MsgGUID: n6l5RpD7SUqme2rSGg+3eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="151675431"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.111.232]) ([10.125.111.232])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 08:43:31 -0700
Message-ID: <945da654-8648-49f9-8ed0-99c165d90198@intel.com>
Date: Fri, 13 Jun 2025 08:43:30 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] cxl: Delay HB port and switch dport probing until
 endpoint dev probe
To: Gregory Price <gourry@gourry.net>, Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 Alejandro Lucero <alucerop@amd.com>,
 Jonathan Cameron <Jonsathan.Cameron@huawei.com>,
 Li Ming <ming.li@zohomail.com>
References: <20250521183443.3828320-1-dave.jiang@intel.com>
 <aDm3zR2LkC3joLFL@rric.localdomain>
 <ff8ec7f0-6cae-4c1b-973d-c126ce60435a@intel.com>
 <aEBp30k03GP46eBd@rric.localdomain>
 <026e7506-b248-43bb-9118-5e3c3d817c90@intel.com>
 <aEK4hx6wNkpvYK9K@rric.localdomain> <aExAezx8lmYIQ5GK@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aExAezx8lmYIQ5GK@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/13/25 8:15 AM, Gregory Price wrote:
> On Fri, Jun 06, 2025 at 11:44:39AM +0200, Robert Richter wrote:
>>> I'm trying to understand your pain point WRT to why ordering is
>>> necessary. Is it somehow breaking your user tooling? I'm not sure I
>>
>> The expectation is broken in a way that Port in the LnkCap no longer
>> matches with numbers in the target_list attribute and with dport%d.
>> But I don't know of tools that break here.
>>
> 
> Maybe just expose a given port's "real" port ID as portN/target_id?
> 
> The issue is that async probe breaks sysfs object numbering in general,
> and so "N" and "ID" don't have an intrinsic relationship.  I imagine we
> should fix anything that assume this relationship exists - rather than
> try to retain that relationship.
> 
> That gives a more formal search mechanism for ports based on a target_id
> and better naming.  (I don't actually care what we call it)

I'm currently doing testing. But so far it seems possible to do dport allocation at a later point as Robert suggested when the downstream port should be valid and we don't need a separate virtual id. We'll see if I hit anything weird. It's working for me on qemu, but cxl-test needs some massaging still.

> 
> ~Gregory

