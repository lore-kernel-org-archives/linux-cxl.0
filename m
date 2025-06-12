Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972691DF751
	for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749746044; cv=none; b=G37CRvDp2fFeiPJRCY99syE5ggKnIEw6UmYP0uHMsMQqHn023TSSVkMG6tvBHo+DJokwxfi8ejIstEt3m0HbAYInue839TkJ8sUtNSChfTkI8mN32MCHpU6AL63jhIeEo8UNkEx5J2NcSVGOn9WZMl1vd+QATOrDtmLRS6QxWr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749746044; c=relaxed/simple;
	bh=BVDKwG6E1QlzvE8iJ6Epx/bATYDi9HRphxdS01nc2ws=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPD5uprf1Yn+MjFjmZuyTa6wtvjcr3hrizF5P22kbTw95c/Ktc1tLt6XzAMVGrR59dc68VIB3X6OGYsxTEHcK/JPCHTvL6/BBSTZWGJHN2S7K8WhQPs3td+MjyWZI+bn/zFGeBMoKMeE0j++90c+8aFI0C3Od0eFy1ICuDgvXis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ7Pn1zlTz6M52S;
	Fri, 13 Jun 2025 00:33:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B09414038F;
	Fri, 13 Jun 2025 00:33:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Jun
 2025 18:33:58 +0200
Date: Thu, 12 Jun 2025 17:33:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, <mst@redhat.com>,
	Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama
	<itaru.kitayama@linux.dev>, <linuxarm@huawei.com>,
	<linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
	<philmd@linaro.org>, Alireza Sanaee <alireza.sanaee@huawei.com>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v15 0/4] arm/virt: CXL support via pxb_cxl
Message-ID: <20250612173357.00002f31@huawei.com>
In-Reply-To: <CAFEAcA9CuQWL2b63+XCe+vZCGR7hRSx8SkTR0LDa+Ra1Z5ur7w@mail.gmail.com>
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
	<CAFEAcA9CuQWL2b63+XCe+vZCGR7hRSx8SkTR0LDa+Ra1Z5ur7w@mail.gmail.com>
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

On Thu, 12 Jun 2025 17:04:32 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 12 Jun 2025 at 14:43, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > v15:
> >   - Split the address map calculations and mmio setup into separate
> >     functions in patch 2, allowing v14 patch 3 to be dropped as not
> >     x86 and arm make the same calls.  Note I felt this was a sufficient
> >     change to trigger dropping tags. (Zhijian Li)
> >   - A few other minor tweaks.
> >   - TLB issue mentioned in v14 now fixed upstream so dropped reference
> >     in this cover letter.
> >
> > Thanks to Itaru Kitayama and Zhijian Li for testing + reviews.  
> 
> Hi Jonathan -- I forget where we are on this. Do you think this
> series is OK to go upstream at this point, or is there still
> stuff you're iterating on here ?  (Put another way, should I
> review it and consider queueing it?)

Hi Peter,

Please do review + consider queuing it.  The recent changes have
just been tidying up based on reviews and before that it was just
the switch over to sysbus devices for the CXL Fixed Memory Windows.
That was mainly because I need that for other stuff and I think
you suggested it a few years back so I thought it might make you
happier with this :)

Thanks,

Jonathan

> 
> thanks
> -- PMM

