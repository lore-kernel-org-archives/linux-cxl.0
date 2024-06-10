Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B8B78297
	for <linux-cxl@vger.kernel.org>; Mon, 10 Jun 2024 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718015143; cv=none; b=ORw8suTqC7COCzERP5vMv3KdcicINkjhAylg7nXtkRdWep8YO7SIrSbsYykPAbBXrtta+1lG60QKAHqt3gDqwibVn4H4K6lQ0qt6B4xNbaPT9hQa2ShSoX0zqX0f0NLIs2fp14+9pXG85IZ4Nzk+sAMVybM0syX/AGkbaVEsjR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718015143; c=relaxed/simple;
	bh=TTHxVNuV6lbfxeOWn+x//6BQuKqjNkf00oATJ6FfblM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYqtLcyn7e4yASJHVKgVxBmhRAIDK4H94bjXesX3pHLSpFu2gVADUOV2Zd9xS+r3Hq07tTBHQvkD1xFv7ILC7cBC72vWx/4A3ycoUFJorY1svzkLo+tj4jABGDLwqEuOyEbpQ+5eVWcKyJfXjjVEhEW6G1zqgJZQymwk7lfs2zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VySb76VV6z6K98Y;
	Mon, 10 Jun 2024 18:24:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F2231400D4;
	Mon, 10 Jun 2024 18:25:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 10 Jun
 2024 11:25:37 +0100
Date: Mon, 10 Jun 2024 11:25:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5] cxl/region: check interleave capability
Message-ID: <20240610112536.0000003e@Huawei.com>
In-Reply-To: <OSZPR01MB6453B7063C3425B8824EDEA38DFA2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240524092740.4260-1-yaoxt.fnst@fujitsu.com>
	<20240605141631.00006b54@Huawei.com>
	<OSZPR01MB6453B7063C3425B8824EDEA38DFA2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
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


> >   
> > > +	 * interleave bits is 0, there is no interleaving, the following
> > > +	 * check is ignored.  
> > 
> > If the interleave is 3 there is no interleave?  That seems an odd statement
> > perhaps make that comment more detailed.
> > My understanding is that it's just more complex and all bits are relevant.  
> yes, but it is difficult to describe the interleave bits. 
> In the SPCE " 8.2.4.20.13 Decoder Protection ",  only when IW < 8, it called 
> [IG + IW +7: IG+8] as IW bits.
> but when IW >= 8, what is the IW bits definition? 
> 
> In my opinion:
> if IW = 8, all the bits of HPAOFFSET[51:0] is used,  so the IW bits is none.
> if IW >8, the bits [IG+IW-1: IG+8] of HPAOFFSET is not used, so the IW bits should be  [IG+IW-1: IG+8],

I'd just add a note that things are more complex for multiples of 3 and
drop the 'no interleave' comment.
It's an early validation function to give more useful feedback than
the current no feedback. I'm not sure it needs to be perfect in catching
issues as long as we don't think it will give false rejections of valid
parameters.
