Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A2D209660
	for <linux-cxl@vger.kernel.org>; Wed, 11 Dec 2024 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914432; cv=none; b=f9mEk4XlFNrK30i8uCyRtY1X0FJyG4w2TDyKM/fRgfaDeMc9duSRieUR/oCb+WhAL9s0yLwhn2LlFCNbdmagTVuhHpsED+QIlNecw+EVXt0e4nooZykOrFLBWJNLnThX9T9nWVih/OZttqoST8ZwEppZVvmoFpR1z8aTUn1J4Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914432; c=relaxed/simple;
	bh=PC0sfIx0898vB3f7C5CVxprMMSGSCtCElaKZtQVWoxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4U5xNUoG28xq+y2tRG8tcV1Vbx/uOzevlgQHbvozZkhix9mee1u4CXLgN9PKvMqcy0r4S1gzWzyBspT1TxXUqufhcikm8KiwQJnefb8AQERFECN3C+scdzNtRGLlefkQZooujHDWB1CbJxhKGTVnrUjatqR1iN7LuEjwLss+sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDHz28mb1lny6t2CA--.17251S2;
	Wed, 11 Dec 2024 18:53:26 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwBnvnolb1lnX2VnAA--.3931S2;
	Wed, 11 Dec 2024 18:53:26 +0800 (CST)
Date: Wed, 11 Dec 2024 18:53:25 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Dan Williams <dan.j.williams@intel.com>, jonathan.cameron@huawei.com
Cc: linux-cxl@vger.kernel.org
Subject: Re: [RFC PATCH] cxl: Support Global Persistent Flush (GPF)
Message-ID: <Z1lvJWHYJFucba5I@phytium.com.cn>
References: <20241205082101.1193038-1-dave@stgolabs.net>
 <6758d309c9ddb_10a08329414@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6758d309c9ddb_10a08329414@dwillia2-xfh.jf.intel.com.notmuch>
X-CM-TRANSID:AQAAfwBnvnolb1lnX2VnAA--.3931S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAQAWdYm48FbwABsQ
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Cw4kuF4DGFyfGFW5Kw13twb_yoW8Kw43pF
	WUKa4kAFWqqFyxCwn7Zw1UWayrCa97Jay5Jr98J340krn0kFn29r4Iqayj9a4xAw1fK3Wj
	qF4aq3saqF1DuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Tue, Dec 10, 2024 at 03:47:21PM -0800, Dan Williams wrote:
> Davidlohr Bueso wrote:
> 
> Hi Davidlohr, thanks for this:
> 
> > Add support for GPF flows. It is found that the CXL specification
> > around this to be a bit too involved from the driver side. And while
> > this should really all handled by the hardware, this patch takes
> > things with a grain of salt.
> > 
> > - Dirty shutdown is not handled, and puts the responsibility on the
> > Admin to deal with any GPF failure - otherwise the kernel will just
> > keep using the device upon next boot. Hence no SetShutdownState DIRTY
> > upon memdev probe (and no need for clearing upon successful flush).
> > 
> > - As such, the driver will only update port timeouts throughout the
> > decode hierarchy, upon device probing and hot-remove. These timeouts
> > can be over-specified, particularly T1. Set the max and rely on
> > devices to minimize GPF response times to avoid the worst case wait
> > times that those timeouts imply.
> > 
> > - Energy budgeting is not supported.
> 
> The missing detail for me is why are the defaults likely to be broken
> such that the kernel must get involved in setting them, and how does
> the kernel determine they are broken?
> 
> It is unfortunate that the specification does not recommend default
> values for this, or even an implementation note about what system
> software is supposed to do with these registers.
> 
> Can you say a bit more about the end user visible effects when the
> timeouts are violated? Because the critical enabling from my perspective
> is timeout detection (notifying the sysadmin), not timeout setting. 
> 
> A policy for setting the timeouts makes sense, but I am not sure that
> the kernel should pick "max" as a default policy. Especially when max is
> 80 seconds which is already longer than lockup detectors would tolerate.
> Likely anything over 30 seconds the kernel should be active complaining
> about something being broken. If a configuration needs more time that
> likely needs a user policy override mechanism.
> 
> This would be consistent with what we did for mailbox initialization
> timeouts. Pick a "kernel reasonable" default and provide an override for
> outlier cases.

Hi, list

Except GPF flows, could we use cxl pmem as a special nvdimm device in kernel
including using ADR mechanism? As the cxl_pmem module would bridge the cxl
pmem device from cxl subsystem into the nvdimm subsystem.

Many Thanks
Yuquan

