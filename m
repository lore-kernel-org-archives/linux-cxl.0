Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F6F2E64A
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738776262; cv=none; b=M81iGdFEDJfAP+M7BUH2pL3nBddKnMLzUyJgZul0AT1O+4wJZO0Lont/Rx6IqONUafPINEuPbKM84gMgX6n79zK8SZh4wy1c038KHqb/V+Gp/AScXWmTfzLI5vuL/VFqLXWBBogbmz4SREslGKznloBCVZkKnoMIqVsssMqM9NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738776262; c=relaxed/simple;
	bh=1l/vnqRQ31dL5CJbfFtSWw+VTE1MJGH66B3+NhLCFeQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyE5TJKU6see1wxRPuZt3wFmg2lDPwiwM8iiZVT6Ub8+hcfVpp2d9XUJkYTOxXipbZElqnffGIP9j0fMWhYAWhMBJ7BQ0UdqNVvTAdQiRjuGQSRGV4ew8JDsnxMZXAGvKxCFOM0N7T5P2LqJaLUL0zK0GLJWnomAKxQEKi5iyGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yp6Wr3rCVz6J9St;
	Thu,  6 Feb 2025 01:23:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CBA8140593;
	Thu,  6 Feb 2025 01:24:16 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Feb
 2025 18:24:15 +0100
Date: Wed, 5 Feb 2025 17:24:14 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <ajay.opensrc@micron.com>, <fan.ni@samsung.com>, <john@jagalactic.com>,
	<emirakhur@micron.com>, <ajayjoshi@micron.com>, <sthanneeru@micron.com>,
	<ravis.opensrc@micron.com>, <arramesh@micron.com>, <tmmulgund@micron.com>,
	<linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/cxl: Support aborting background commands
Message-ID: <20250205172414.00007486@huawei.com>
In-Reply-To: <20250205044749.xoo73gewwjahxj6k@offworld>
References: <20240813221255.179200-1-dave@stgolabs.net>
	<20240827163357.0000228e@Huawei.com>
	<jdipjanthgt6atlksngodxjevfb5d43d5rshtxqxxwruszqa3e@vctljs77lg4e>
	<20241022180030.00004f68@Huawei.com>
	<20250203150706.00000e23@huawei.com>
	<20250205044749.xoo73gewwjahxj6k@offworld>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 4 Feb 2025 20:47:49 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Mon, 03 Feb 2025, Jonathan Cameron wrote:
> 
> >On Tue, 22 Oct 2024 18:00:30 +0100
> >Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >  
> >> On Mon, 21 Oct 2024 20:23:46 -0700
> >> Davidlohr Bueso <dave@stgolabs.net> wrote:
> >>  
> >> > On Tue, 27 Aug 2024, Jonathan Cameron wrote:\n  
> >> > >No comments inline and LGTM. I'll queue it on my tree and push
> >> > >that out on gitlab sometime soonish.  
> >> >
> >> > I don't see this picked up, which is a good thing atm. While testing
> >> > the kernel side, I noticed the following is needed, will send a v2
> >> > with it folded in.  
> >>
> >> Currently just on my cxl-2024-10-15 branch of gitlab.com/jic23/qemu.
> >> I'll pick up your v2 and replace that.  
> >
> >Hi Davidlohr,
> >
> >Did I miss v2, or still to send?  
> 
> Ah, thanks for the reminder, I had forgotten to send it out.
> 
> Actually, considering you have been carrying v1 for a while now,
> would it not be cleaner/better just rebasing the diff and sending you
> that instead of a whole new v2? Otherwise, I'm not sure what to do
> when working on your latest 2025-01-24 branch.

Pick point where I'm carrying it and post a patch based on the
next commit up.  Just let me know you've done that and all
should be good.

Jonathan


> 
> Thanks,
> Davidlohr

