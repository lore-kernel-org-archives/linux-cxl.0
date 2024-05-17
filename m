Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101CB3612D
	for <linux-cxl@vger.kernel.org>; Fri, 17 May 2024 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715940468; cv=none; b=NUBcymW5CWn4aK864L1UPNhOfd0Zl3AVgvgMm7dv0+W9gDJGON5hnH+U7BEJHn9XnO823CeELTLsiQm4CtI7DjOkKR3yA2D1Ekl4IqZH+CQPRX/oPv6y3dJu9XO7Oi3+bacyM8/at5Lb+XAVnLYfox56CmoQg0npGY58z3lXw34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715940468; c=relaxed/simple;
	bh=/YAkah2KKRsvfkx6B0yBIgiWLf6i4hifHZ5E7vH5zy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfHsO3vmVQ4yPZsXM0MUinB/VV6IlBg8gdYXox6PiOs5Qja8zGs8IVh/uXdD4C93QsSSylhQM7vqIUB+KzRgN/C5e2mSlkim/KEn2qpTe1CeK0Hm2VP+9c/34qH9B27aaAI4w/qZpWGY7PHzOAv6ZcfjQ/zdYgxV7zoaH4eD4ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwD32UZkLEdmup9VAA--.24085S2;
	Fri, 17 May 2024 18:07:32 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwDnVNFRLEdm53MAAA--.953S2;
	Fri, 17 May 2024 18:07:24 +0800 (CST)
Date: Fri, 17 May 2024 18:07:07 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: CXL numa error on arm64 qemu virt machine
Message-ID: <ZkcsS0we4XHPgBIP@phytium.com.cn>
References: <20240508080051.3756934-1-wangyuquan1236@phytium.com.cn>
 <20240508130252.00006367@Huawei.com>
 <ZjyK1tI0TtbAKhmh@phytium.com.cn>
 <20240510181646.000019a1@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510181646.000019a1@Huawei.com>
X-CM-TRANSID:AQAAfwDnVNFRLEdm53MAAA--.953S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAIAWZGX+QD1wABsG
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Ar4xXryruFykGw1kKFWxJFb_yoW8Ar1rpa
	yfKrs8Krs7JFs7XFyxAr1UuFnxAws8Jr4fur1ktryDCwn3Ary2vF1Fgw1j9F48KrZ2grn0
	vw4UZ3Z7G3Z8GaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Fri, May 10, 2024 at 06:16:46PM +0100, Jonathan Cameron wrote:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/cxl-staging.git/log/?h=arm-numa-fixes
> 
Thank you :)
> I've run out of time to sort out cover letters and things + just before the merge
> window is never a good time get anyone to pay attention to potentially controversial
> patches.  So for now I've thrown up a branch on kernel.org with Robert's
> series of fixes of related code (that's queued in the ACPI tree for the merge window)
> and Dan Williams (from several years ago) + my additions that 'work' (lightly tested)
> on qemu/arm64 with the generic port patches etc. 
> 
> I'll send out an RFC in a couple of weeks.  In meantime let me know if you
> run into any problems or have suggestions to improve them.
> 
> Jonathan
>
With the latest commit(d077bf9) in the 'arm-numa-fixes', the qemu virt
could create a cxl region with a new numa node (node 2) just like x86.
At this stage(the first time to create cxl region), everything works
fine.

However, if I use below commands to delete the created cxl region:

`daxctl offline-memory dax0.0`
`cxl disable-region region0`
`cxl destroy-region region0`

and then recreate it by `cxl create-region -d decoder0.0 -t ram`, the
kernel could not create the numa node2 again, and the kernel will print:

[  589.458971] Fallback order for Node 0: 0 1
[  589.459136] Fallback order for Node 1: 1 0
[  589.459175] Fallback order for Node 2: 0 1
[  589.459213] Built 2 zonelists, mobility grouping on.  Total pages: 1009890
[  589.459284] Policy zone: Normal

Meanwhile, the qemu reports that: 

"qemu-system-aarch64: virtio: bogus descriptor or out of resources"

Many thanks
Yuquan

