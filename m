Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995CA367
	for <linux-cxl@vger.kernel.org>; Fri,  8 Mar 2024 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902794; cv=none; b=CROmW30YGyne/0MQLVjnWpWDyabRfwAWhh1EaY/2CTpqOGDp5yd1USwvHI63GLxxZ2BzIfqjeC0pX/hz93Xaxxzme0H57ERg+XNknwyWPf9zPEj/1dK5uvRCqjuswj5LyfTVHZJmKhV80zvoqPvgQ6fJgS/c4qw/ETj81HsdMWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902794; c=relaxed/simple;
	bh=RlenQBPkFljys8LsXWerywqY98bBzfrzhz2VR+hQ3vM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f84ZEUMf5umYcTT72eYGQj8KHQka26r4nEqrbKINDedrPHr8/X0zs8qe9Hu6E6iSamXoAgAn/MQppctlaKhTuUI2e/IOqYhL+T4DsZpfIZON8kISTbpA9dH7joX6mc5OdlE2Zxm2aXTKFN+3Lv61RNF011D9Xa6qS+g3b2hcjng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TrmTp4HS7z6JB4K;
	Fri,  8 Mar 2024 20:59:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C900141105;
	Fri,  8 Mar 2024 20:59:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 8 Mar
 2024 12:59:34 +0000
Date: Fri, 8 Mar 2024 12:59:33 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <Terry.Bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<qemu-devel@nongnu.org>
Subject: Re: Enabling internal errors for VH CXL devices: [was: Re:
 Questions about CXL RAS injection test in qemu]
Message-ID: <20240308125933.000053f8@Huawei.com>
In-Reply-To: <20240308020134.3146734-1-wangyuquan1236@phytium.com.cn>
References: <20240308020134.3146734-1-wangyuquan1236@phytium.com.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 8 Mar 2024 10:01:34 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> On 2024-03-07 20:10,  jonathan.cameron wrote:
> 
> > Hack is fine the relevant device with lspci -tv and then use
> > setpci -s 0d:00.0 0x208.l=0
> > to clear all the mask bits for uncorrectable errors.  
> 
> Thanks! The suggestions from you and Terry did work!
> 
> BTW, is my understanding below about CXL RAS correct?
> 
> >> 2) The error injected by "pcie_aer_inject_error" is "protocol & link errors" of cxl.io?
> >>    The error injected by "cxl-inject-uncorrectable-errors" or "cxl-inject-correctable-error" is "protocol & link errors" of cxl.cachemem  
> 
> Many thanks
> Yuuqan
> 
Yes.  Note the two CXL errors are actually communicated via AER uncorrectable / correctable internal
error combined with data that is available on the EP in the CXL specific registers.

Jonathan
