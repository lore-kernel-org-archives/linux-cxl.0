Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423CE2E3373
	for <linux-cxl@vger.kernel.org>; Wed,  5 Mar 2025 03:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143775; cv=none; b=j3axv0Q3MzbCSqG7qd6ghnqzuFIlG3gEIJxczwED0pzO25J35Yxx4e6KMao//5dra5pNt3c8MJxPOdayS2nQGTrc/X1cUbqA0uvxkMAZuXfMvTKUSnSpZYMbyY2BjZVl7Z8Jr83JpTWWj+lrdXAeC7rf8Vt+n43I8m8xLDvS6Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143775; c=relaxed/simple;
	bh=K6jt3wzMFLT3jlV0wBp2sUyoPB9MlW2hWmHwQUJIoiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gkr8rZvTMlft3SqIBu0669t6tz3NEq6fVIFK0lxY9xB8xjwg/Cph4FzTAvNV+tf6sIhsxJCjLKAjHTcOLcCrAptsB9TXNqMYCVHbrjce48f2SU4HYs4ndf9SQzd381/NjXermnlHN29Br4eR8bkfThhXgxpWuVEoyyqYQ8/chcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sOYJDsCK; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sOYJDsCK"
Date: Fri, 28 Feb 2025 23:34:20 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741143771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbrTyCFDWkF1ScjEyLPxk8vj9qEf7CIATcFB/uGANvI=;
	b=sOYJDsCKFd6klEZx8q9nC6vkGVE2avnSnaOLYKZKa6GdkeXezIZ3wOz9CjOnCAwAcsvNB4
	DyZ9Hbh1zpmeKw7HULWCuwJ7WBxjO8LHhAg2fgKOoe/CVXL1nOb73dRRmghS3+brMV+5u+
	OCZ76dFKIFO0xD9T9OKEVjptxfNbhcU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: Re: ndctl cxl test suite fails in arm64 QEMU
Message-ID: <Z8HJbMkV6mzikTI8@vm4>
References: <43568B03-6832-4EB1-BF46-EF0F176509E2@linux.dev>
 <Z75G2UKmx7G59u7P@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z75G2UKmx7G59u7P@aschofie-mobl2.lan>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 25, 2025 at 02:40:25PM -0800, Alison Schofield wrote:
> On Tue, Feb 25, 2025 at 01:09:57PM +0900, Itaru Kitayama wrote:
> > Hi,
> > 
> > Has anyone noticed the ndctl cxl test suite failures I reported below on arm64, QEMU emulation?
> > 
> > https://github.com/pmem/ndctl/issues/278
> > 
> > I’m using Jonathan’s latest CXL capable QEMU [1], and the latest CXL kernel [2].
> 
> Hi Itaru,
> 
> Looking at region.c:size_store() it seems that alloc_hpa() is failing.
> (kstrtou64 is arch independent and it works for me with same script &
> value)
> 
> Check the dmesg log at the time of the failure. alloc_hpa() may be
> emitting a message.  (In the run_qemu.sh cmdline add '--cxl-debug')

dynamic debug reported this (kernel is without kaslr, today's cxl/next):

[  193.267649] device: 'region4': device_add
[  193.267931] bus: 'cxl': add device region4
[  193.268284] cxl region4: bus: 'cxl': __driver_probe_device: matched device with driver cxl_region
[  193.268333] cxl region4: bus: 'cxl': really_probe: probing driver cxl_region with device
[  193.268401] cxl_region region4: no default pinctrl state
[  193.268482] cxl_region region4: probe with driver cxl_region rejects match -6

does the above show the region4 was not added properly? The sysfs
entries are there after the out of range failure.

Itaru.

> 
> Sounds like Marc is on to something and maybe the KASLR is known
> to cause this problem.
> 
> Thanks for posting to this list and send any further questions or
> comments. Happy to have you using run_qemu.sh and the cxl tests!
> 
> Alison
> 
> 
> > 
> > [1] https://gitlab.com/jic23/qemu/ cxl-2025-02-20
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/
> > 
> > Thanks,
> > Itaru.
