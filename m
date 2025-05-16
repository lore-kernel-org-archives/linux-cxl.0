Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91424231856
	for <linux-cxl@vger.kernel.org>; Fri, 16 May 2025 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747439465; cv=none; b=I7DzXOI5ALjUAoeUI5uCc310Lvlaz0wcPXEkaPTZgQD7aJ8e+vQFK0UIeKmzkxyEy/g4xAHjaS6C4e08cqPlE0ZlmVFRIxuxuPdtraMnz6G8ZCbNHybtorTO6WNbQan6yKWVhd15R79uB7W8b2Tmsu+ZXOv6yi8FwmT6KfuLzIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747439465; c=relaxed/simple;
	bh=/hROaLaAFCTzODZWEiUp8c4an3gyu6qLiLxpvaA3JJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bim00ACDAYAkH+6zYF49oWslhfBFDaGNWQMhShY2e9nSWMtPJcrrqTlURn0VRDEpEf3n/EzAuB/Or+Y6S4tpRAzl7GRQiMgB8jgAIxl2VOhvSnwcmU0Z9aAKxxxvxqUxg81TFKFIUvL4dfuYaZ2VUSQv2oV2SYg8LBKU7qsFYmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cImS+Ek5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cImS+Ek5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747439463; x=1778975463;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/hROaLaAFCTzODZWEiUp8c4an3gyu6qLiLxpvaA3JJ8=;
  b=cImS+Ek5ylq85kZhrIDH9tyvDR83rK+tVTjMRdT1kHJ1Cwijwnl+C00g
   +R2RA1lMwinamnjvqP+1QU+SVr0vEdpMNQwCbXW5BZKgkzZv56xgPoDuC
   lXxiCIwnF+uDZYXRXbma7+KFT8b2Dvpow/LGB4vnLL2qPvIyrrFob3Kko
   1P8WOA7JSl37AnUUprrOHG+M0qM/Yi3/JrGYx/OCkqpkjJMjh2kZF3Wq8
   RWJEgjRL7lXjpMEp6EexdKIjJaH8Lwmd/5c60sW7aU/dn7F0gPuNaxI8c
   pXfdFPtQ6lM5+9V5bKq2+AhfbjtizTFjveNQqycDk8oM0cc/pLUiG1lUk
   w==;
X-CSE-ConnectionGUID: JyyfvyFGQUO8b2qvqxnIfQ==
X-CSE-MsgGUID: X0+8YngkSaih8N/0Hr420w==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49121758"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="49121758"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 16:51:03 -0700
X-CSE-ConnectionGUID: hGzq5+3PSS2zBH1W5s2Lxg==
X-CSE-MsgGUID: 5wvJ3gDxR+GcsMJWOQVnng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="138676200"
Received: from mtowner-mobl1.amr.corp.intel.com (HELO [10.125.186.118]) ([10.125.186.118])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 16:51:03 -0700
Message-ID: <ef46edd7-b492-4124-9cf9-0db104175eac@linux.intel.com>
Date: Fri, 16 May 2025 16:50:57 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: cxl <-> udev deadlock?
To: "ruansy.fnst" <ruansy.fnst@fujitsu.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com, sunfishho12@gmail.com
References: <20250514112003.2150272-1-ruansy.fnst@fujitsu.com>
Content-Language: en-GB
From: Marc Herbert <Marc.Herbert@linux.intel.com>
In-Reply-To: <20250514112003.2150272-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-05-14 04:20, ruansy.fnst wrote:
> 
> Now that cxl_wait_probe() has been added[1] to wait for udev queue
> empty, the `udevadm settle` here is no longer necessary.
> 
> [1] b231603 cxl/lib: Add cxl_wait_probe()
> 
> Signed-off-by: Ruan Shiyang <ruansy.fnst@fujitsu.com>
> 
> ===
> Question to Dan:
> 
> I understand how cxl_wait_probe() work, but I have some questions about
> the motivation of adding this function:  Firstly, is it function added
> for simply waiting for new added CXL device been ready before cxl
> command does the actual work?  Just for replacing `udevadm settle`'s
> work?
> 
> Now I am facing a problem that cxl command takes a long time to complete
> when I run it in a udev rule(do some configuration when CXL memdev is
> added).  I found it is caused by this function: waitting for udev
> queue's endding but itself is in the queue.  The cxl_wait_probe()
> function does not seem to allow me to do that.  So, the 2nd question is:
> is it against the spec to run cxl command in a udev rule?

cxl waits for udev which waits for cxl... this looks like an interesting
deadlock!?

When you write "a long time to complete", do you mean "aborted after the
default, 180s udev timeout?"

https://www.freedesktop.org/software/systemd/man/latest/systemd-udevd.service.html

udev is not designed to start long-running processes BUT udev is designed
to communicate with systemd which is the correct manager for all
long-running processes:

https://www.freedesktop.org/software/systemd/man/latest/systemd.device.html

You can find examples on your system like this:

  grep -r SYSTEMD_.*WANT /usr/lib/udev/

Now, I think you are not interested in running anything for _long_. But,
the same technique and indirection should also break the deadlock (if any)
because udev messages to systemd are "fire and forget".

Also, systemd is designed to collect and report logs, exit status
etc. which is very useful when something goes wrong. udev does not
do that.
