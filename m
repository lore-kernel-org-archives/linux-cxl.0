Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E1E1A723
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270276; cv=none; b=nli5Db4Qpwt456O97TMIEjuly+5sunxNOAx51g5m2866iJSjIHRc8NFhCZcfkHr7Rs8vWIxSDNmsMSYTzoWv2AQAEjhdj/sSpRbD1c3XjAxataKVAWEvaA+daC0w+BgO9/Z1DA+aUbINoR1SUJD8EYglYc3O+5vmm18ONfktokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270276; c=relaxed/simple;
	bh=N21FOKsOOdHcwSW5OTecF2mubN9EPTmx21krlKS/yd4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHWOl13rWEE32a1Ve6EoZ5Yfa0SiyQo5LQas5u2ZKVwZdocndQga1SLdln0lhIdCAXmRPiX94rUVVbLBmHla9o+iU9G9bscc+SBJSAYzkdea1XdFWbbyjH1wl/ivuYaz0oFlxmncziKqAto0GQyU6UY8P/ypiEj/elO8fOnegl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TLx2F2t8Zz6JBFG;
	Fri, 26 Jan 2024 19:54:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C898140B55;
	Fri, 26 Jan 2024 19:57:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 11:57:50 +0000
Date: Fri, 26 Jan 2024 11:57:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
	<fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>, Ira Weiny
	<ira.weiny@intel.com>, Huai-Cheng Kuo <hchkuo@avery-design.com.tw>, "Dave
 Jiang" <dave.jiang@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Stefan Hajnoczi <stefanha@gmail.com>,
	<linuxarm@huawei.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
	<philmd@linaro.org>
Subject: Re: [PATCH 09/12] hw/mem/cxl_type3: Fix potential divide by zero
 reported by coverity
Message-ID: <20240126115750.000027e6@Huawei.com>
In-Reply-To: <ZbGjFiKKPhC_uiOF@debian>
References: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
	<20240124124100.8218-10-Jonathan.Cameron@huawei.com>
	<ZbGjFiKKPhC_uiOF@debian>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 24 Jan 2024 15:53:58 -0800
fan <nifan.cxl@gmail.com> wrote:

> On Wed, Jan 24, 2024 at 12:40:57PM +0000, Jonathan Cameron wrote:
> > Fixes Coverity ID 1522368.
> > 
> > Currently error_fatal is set if interleave_ways_dec() is going to return 0
> > but we should handle that zero return explicitly.
> > 
> > Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >   
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> 
> > ---
> > Note this is a stop gap until a more complex HDM decoder verification series.
> > ---
> >  hw/mem/cxl_type3.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 1b92a065a3..24211703c6 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -794,8 +794,12 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
> >          }
> >          if (((uint64_t)host_addr < decoder_base) ||
> >              (hpa_offset >= decoder_size)) {
> > -            dpa_base += decoder_size /
> > -                cxl_interleave_ways_dec(iw, &error_fatal);
> > +            int decoded_iw = cxl_interleave_ways_dec(iw, &error_fatal);
> > +
> > +            if (decoded_iw == 0)
> > +                return false;
I've obviously been lax in running checkpatch.
Brackets needed for qemu style here. I'll add them for v2

Jonathan

> > +
> > +            dpa_base += decoder_size / decoded_iw;
> >              continue;
> >          }
> >  
> > -- 
> > 2.39.2
> >   

