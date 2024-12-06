Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733791D515D
	for <linux-cxl@vger.kernel.org>; Fri,  6 Dec 2024 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510347; cv=none; b=OemzpRp93pL+6Bk0EU6NcQMeivM2g0F3sUQvHZBYIsrsni3guP2WRSlY4nb58W8cBu6g3X07GY4cQqBEb1y6uxT343FqXJqfHMi+rlys91TMK7wibW8s0vGD8o5N022EddhrKFs7e8dv9yQxRrKi7gtni+MuV2iv+FnuneibMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510347; c=relaxed/simple;
	bh=fHQ9FZOAz/oqx2orPJ4AKd6uRjQ1J8jwnh5hoyUgvP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uR6l9MjKBh/xH5LvvpYtFIkV91EPPuSxHg0j3lVM7m87meQVXmG3Keh/BqxIFhpNYnKyws35z7BObtgKqXNnYskl3x/aD27025OU1SMdX6WBjxn7Cn1OY8TIT8CY0Y4ztp+Mz+QieEolasU9nv5RHhrQhnwRonyCSITmCulJjo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNfPwap3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNfPwap3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733510345; x=1765046345;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fHQ9FZOAz/oqx2orPJ4AKd6uRjQ1J8jwnh5hoyUgvP8=;
  b=eNfPwap3A6udCJ/E2gR6IDRC7BBlmmjPqhZMOLNJfSow5cDZpZy5rSHp
   rEhxfQntcbH/WCziL8ZKPxnBsN4A3rR5X7EoIaUX0Vvv4/o8AlYF2+XGQ
   ofsXsK3ABKBUZ2IGkuL6dPUYPgvt6lCzo3YHP24vUxG62OgmbQpsH8DKP
   bp/ymw74Lqbt6VexfD75BX8isk9wGltmQxM0YD+JEfVmfk68KrlNGRjtN
   D3uVfB1/zEsGQ3LqdXOFvWActEvJwMxpVO57qJkhNnsSvKupMsdxLU9uk
   VbS4xRhkip1ySiLCFEP31Ayj7GXREd7AQ79PJCi0lO32qz2FTJXPHCzqs
   g==;
X-CSE-ConnectionGUID: JBTd0H+OTUWDe9MG7LPhJA==
X-CSE-MsgGUID: u4PVyIOPRRy8G4kfZCf/QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="33999836"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="33999836"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 10:39:05 -0800
X-CSE-ConnectionGUID: 0ZTz8G3xRYCh1bputLVtqw==
X-CSE-MsgGUID: q9UsVG89S7mZRrh1jeVEFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="98541918"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.242]) ([10.125.108.242])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 10:39:04 -0800
Message-ID: <49ec1992-8b45-4281-aabb-781e1e8ec1dd@intel.com>
Date: Fri, 6 Dec 2024 11:39:03 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 11/20] fwctl: FWCTL_HW_INFO to return hardware
 information
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-12-dave.jiang@intel.com>
 <67528c573b189_25073294db@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <67528c573b189_25073294db@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/5/24 10:32 PM, Dan Williams wrote:
> Dave Jiang wrote:
>> Add an optional ioctl FWCTL_HW_INFO to pass command specific information
>> to user space. An array of 'struct fwctl_command_info' will be returned
>> from the ioctl. These commands are send to the driver via FWCTL_RPC call.
>> The command info struct contains the command id, the related hardware
>> opcode, input and output size for the command, and the effects the command
>> has if it's a write command.
> 
> Maybe this made more immediate sense to Jason, but I do not see why CXL
> needs a FWCTL_CMD_HWINFO when FWCTL_CMD_RPC can just convey the GET
> SUPPORTED FEATURES payload?

That is because I wrote the code with intention of supporting the existing chardev commands in addition to features. If we are only supporting feature commands fwctl, then we can drop this and make things simpler.

So heads up for Jason, we can drop this common ioctl.

DJ

> 
> Now, if we ever want to support more commands outside FEATURES, I expect
> that will need to look like synthetic "feature" that the driver
> publishes to fit it into the existing paradigm.
> 
> In other words CXL tools are already going to need to have knowledge of
> feature payload formats, why does fwctl need to package it up in another
> form?
> 
> If, for example, I was looking to support GET TIMESTAMP over CXL fwctl,
> which I am not, I would say that would be a synthetic Linux Kernel CXL
> feature UUID that gets documented and synthesized and fwctl core is none
> the wiser.

