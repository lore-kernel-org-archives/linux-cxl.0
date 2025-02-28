Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4635D8F0
	for <linux-cxl@vger.kernel.org>; Wed,  5 Mar 2025 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741136074; cv=none; b=kDgdq+m6ZQ7vVcV8H08T9PVxR0Inu3o3ei/9BruW3F7T9mt9TLgVSG14oR37Weqy/xGVc0L8A4zOA6NFuSoCA7+nTMurdr7eR1gX6EvLlGsE57YV67JNGWlpWPM6MTxbvkC8DekXRSAQWSSTZo+3AAI/ZW6G3C8a5/cTCNRYFkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741136074; c=relaxed/simple;
	bh=6DvG5C+xHs1ssl+lCMomgsFGEp2hYk3vOZYj4WF9rhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mw15xQD5vhZc6mZV6RulK8Wq0/yukOXp4KsbJxXNVH+EcKLoJcYN07s7uccp3bmH/jkFrBeun3Edn2z1HGmDepYO64vJ9p0hQz+uMtEWa9eUVYqR9YRy3Fb20IagqV7CIyrxaQj+H5ESk+f2ToX0LtTG0W1vAMz+FfyWYy88+28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mnm59adT; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mnm59adT"
Date: Fri, 28 Feb 2025 21:15:03 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741136068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWeh8aeYb/8zWlHFMLkeKceUwq9fh37vLYDryIwrU2w=;
	b=mnm59adTdqij6LWvpFpdtfkIpuV+OS5z3JbjdeMz0fVdK9SIXcaztYgz5lGX+fq1oRszSK
	BccZsqWnbA1nYLU54W89IUVNHxHosYTAI7t4uXHBzBeBoTFRtvNqG2XwKdeVk8d7umjcZb
	Zge4UImWz/w/MnP+8Ctpkut0u8jd2R0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: Re: ndctl cxl test suite fails in arm64 QEMU
Message-ID: <Z8Gox/nWhijHQUWq@vm4>
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

alloc_hpa() calls into core kernel codes and ends up with -ERANGE from get_free_mem_region().
Given it is generic kernel core code, not sure at this moment where I should look for.

Thanks,
Itaru.
 
> 
> Check the dmesg log at the time of the failure. alloc_hpa() may be
> emitting a message.  (In the run_qemu.sh cmdline add '--cxl-debug')
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
