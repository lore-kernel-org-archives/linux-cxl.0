Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C576137930
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747702825; cv=none; b=EmZKzDHYiEIHQumuYPVIhGjNm3nnebn6VUPqrbIRgncgoM3BnjrBOy6Mqmtr9iehV4artjK5Jo1KWrnGRmJIJufqvFOy+JdLSMPUSimzyUz3BbHKZO22XZfZdQK+steN5my2Uo8eLfry5YPZSHrmR1W29FhOSTuJ/0eNoxYrsdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747702825; c=relaxed/simple;
	bh=RR4EiarutOFph1bwcFRp63laMNPoa6l4Xaq3Z+50e8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CM9Y/JFua/ZgSFWbosP9d94dM+7XR8rCg+taThunC4Z4q7UpZyW7Sv+d93dkzpLDon5qtdjffh1cmA5g9QK1jgFLy6DC1FaBYXbMHp98VA6uYqg7+LjXlBkAYzWxol3cJVcy2GMrETRlxnO/IrhMxUCZcfVcwe2pMSEeJhaeLsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NralWZ1V; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NralWZ1V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747702823; x=1779238823;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RR4EiarutOFph1bwcFRp63laMNPoa6l4Xaq3Z+50e8U=;
  b=NralWZ1VPUQqdM24rfhsWEgGryDI7OPjwDWAZt+qJTP/2HAKkzfkSy9G
   SY3E80QN6NQproqk20beQKT7B40XG/Dtq+kN9tfmEQ7dHdwipmXqtfBpR
   6Dv3QpF3o86yGUxU3/bz/mAMR6zSLtjHdYfUxqSMoxFK7J12WL6XRZd3f
   Afu9zIwIkl/HdDbPTD5aw2izPcQo66iigjTbKWXjqvWF22iGIc12mjnr9
   W7/95j4+giC+lheC0PLy8/jmYhv2Yk47jLNcvodHosl5qtCdk8Om0Kl2Y
   eMczsCihhtDipibSl7+IzK798igDhNook4fatY+TeIIaujvCxjdzHlUV7
   A==;
X-CSE-ConnectionGUID: fbqNZxrSTyW26tV3nSu0WQ==
X-CSE-MsgGUID: uLN1RSNETKG7zWHmAGTtIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49317685"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49317685"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 18:00:22 -0700
X-CSE-ConnectionGUID: Z2x30Zi3TJa8ZMb0PYzePQ==
X-CSE-MsgGUID: 0mBajcSkTp6GHed/MrwX+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139261142"
Received: from agrisant-mobl2.amr.corp.intel.com (HELO [10.125.1.252]) ([10.125.1.252])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 18:00:23 -0700
Message-ID: <d9b62e78-52df-4283-9004-18c0bc01f73a@linux.intel.com>
Date: Mon, 19 May 2025 18:00:19 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/cxl-xor-region.sh: remove redundant waitting
Content-Language: en-GB
To: Dan Williams <dan.j.williams@intel.com>,
 "ruansy.fnst" <ruansy.fnst@fujitsu.com>, linux-cxl@vger.kernel.org
Cc: vishal.l.verma@intel.com, sunfishho12@gmail.com
References: <20250514112003.2150272-1-ruansy.fnst@fujitsu.com>
 <6827d6e591443_4ba8f100f1@dwillia2-mobl4.notmuch>
 <3f7bd5b0-4c1b-4a55-bc9b-2b6e75ab9a39@linux.intel.com>
 <682bba2f9ce2b_1626e100dd@dwillia2-xfh.jf.intel.com.notmuch>
From: Marc Herbert <marc.herbert@linux.intel.com>
In-Reply-To: <682bba2f9ce2b_1626e100dd@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-19 16:09, Dan Williams wrote:
> Marc Herbert wrote:

>> PS: while... waiting for such a fast/no-wait/unstable option, I see no
>> reason why systemd would not work.
> 
> It does not work due to circular dependency deadlock.

I just had a quick chat with Dan about this.

A local, systemd indirection _workaround_ would avoid the
deadlock. systemd is dealing with processes than "hang" by design:
daemons! And with even more complex and difficult processes and
services. udev routinely sends messages and triggers systemd, yet
systemd has never blocked udev in return, no matter what happens.
When you connect a USB printer, udev and systemd start the ipp-usb
process which "hangs" forever. This does not block udev.

On the other hand, in
https://lore.kernel.org/linux-cxl/ef46edd7-b492-4124-9cf9-0db104175eac@linux.intel.com/
I never meant to suggest systemd as a "permanent" solution for every
user of the cxl command! I was only suggesting systemd as a "private"
workaround, part of some specific test suite currently stuck with this
deadlock.

Hope this clarifies.
