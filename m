Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9AC149C64
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749835062; cv=none; b=Z0c6s0gO6YZSVyxF+F/2enEW9jdLcI/EyNVhMTztVhFosFoUpIiB3qL2E9P1/UCqxIpJ17I1lPVktwQG6al9RWWg/4Npc6VU9FQ53D48iDNAATwPSqFxCm4+zFAoxcVtf9FtcvEv5a8Mng57JFtwJREsjRsev6JEvS7KybkCJec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749835062; c=relaxed/simple;
	bh=OpH62wlamRZ82ZXATpFl4Y6yEBGJxZ7lzcqRt20TUcc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swS9Vk90LH6aWIffjoQ8bKpQLQYFy3bSgj6iObFZpt9uaj4EWxDN9Nmb28K4rHMx177FqM7DhZKcXE6jyVl0jkNmldVe5vT/vlWRePTHxexKjV7b9q8sob4Ziw54iSemW9h59dk7+bQWfkE0H0EvWVn9sGrLBK0Lyw65SCaD3cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJmKf5XBnz6M4sr;
	Sat, 14 Jun 2025 01:17:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 439BC140277;
	Sat, 14 Jun 2025 01:17:38 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Jun
 2025 19:17:37 +0200
Date: Fri, 13 Jun 2025 18:17:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, <mst@redhat.com>,
	Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama
	<itaru.kitayama@linux.dev>, <linuxarm@huawei.com>,
	<linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
	<philmd@linaro.org>, Alireza Sanaee <alireza.sanaee@huawei.com>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v15 2/4] hw/cxl: Make the CXL fixed memory windows
 devices.
Message-ID: <20250613181736.000063e5@huawei.com>
In-Reply-To: <CAFEAcA_ZbAnUS4Ufa+jsOgj6aeRS5JHJP=scw6d0qXd3NNtqdA@mail.gmail.com>
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
	<20250612134338.1871023-3-Jonathan.Cameron@huawei.com>
	<CAFEAcA8eC9TpGyrMARRUWs4q1o7LACD03zLAwPnTRU+m98LrWQ@mail.gmail.com>
	<20250613140954.000013f5@huawei.com>
	<CAFEAcA_ZbAnUS4Ufa+jsOgj6aeRS5JHJP=scw6d0qXd3NNtqdA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 13 Jun 2025 17:08:28 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 13 Jun 2025 at 14:10, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > For these specific devices (the fixed memory windows) there isn't
> > any state as they are representing fixed configuration of the system.
> > The state is all in the host bridges and beyond. I'll add
> > a comment as you suggest.
> >
> > Currently CXL emulation is completely broken wrt to migration and
> > there are some known issues for reset as well. Both are on the list
> > of things to fix. Migration is less important as the only current use
> > for this stuff is running software stack test cases and for that
> > migration isn't currently of interest - that will change for some
> > of the virtualization related work that is just getting started.  
> 
> That's OK as long as something somewhere is registering a
> migration-blocker so there's a useful error message if the
> user ever tries it.
:(

Michael asked for us to fix that a while back and I forgot.

Will sort that out shortly.

J
> 
> -- PMM

