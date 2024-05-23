Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540A011711
	for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478344; cv=none; b=p33bLcJtgOkxIAUBetM7hIiJwb+5hpw7rJQiyB8T8owaTRMMAKq1PdlnN7rm9EYwtbEB2iMshbzCrmVaqoOkflMKMtG+885cZhKeVGsqKD9uRaXiWJs7iu8LmedN6ryg4+xJBfbiAlY/WvWLKOMusRvo2e8jKumYzjvNy1/JihQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478344; c=relaxed/simple;
	bh=tMZDIAH0fF6Vtw2Ztfr+U1YEgICkYvpqe0RyItbPiJ0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxgdQysjGfW7Xtrzwp8+LT39l6mJrX5H5pkSOsKPmU/Zqc/oW49MkD3O3CxwoTHJSe1UAnhDNaJJGjKlgdYHNTKGGs83SOoxFvCWZWSXAxM/NZMm8C0glfPdHzVPDHD2YqGRxTvThE0s198pxgjujmUVHmY48qj5eHRoN0s0sLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VlXBX0KKbz6JBJc;
	Thu, 23 May 2024 23:28:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7416A140A1B;
	Thu, 23 May 2024 23:32:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 May
 2024 16:32:17 +0100
Date: Thu, 23 May 2024 16:32:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: Markus Armbruster <armbru@redhat.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <gregory.price@memverge.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<jim.harris@samsung.com>, <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan
 Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240523163215.0000146b@Huawei.com>
In-Reply-To: <Zk0wjWL2cbwdF69r@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
	<20240418232902.583744-10-fan.ni@samsung.com>
	<877cgkxzal.fsf@pond.sub.org>
	<Zivk37xBGPsL_yo5@debian>
	<87h6fkob0t.fsf@pond.sub.org>
	<ZjLCS8yJC-OvPsUS@debian>
	<20240520175012.000045fe@Huawei.com>
	<Zk0wjWL2cbwdF69r@debian>
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

On Tue, 21 May 2024 16:38:53 -0700
fan <nifan.cxl@gmail.com> wrote:

> On Mon, May 20, 2024 at 05:50:12PM +0100, Jonathan Cameron wrote:
> > On Wed, 1 May 2024 15:29:31 -0700
> > fan <nifan.cxl@gmail.com> wrote:
> >   
> > > From 873f59ec06c38645768ada452d9b18920a34723e Mon Sep 17 00:00:00 2001
> > > From: Fan Ni <fan.ni@samsung.com>
> > > Date: Tue, 20 Feb 2024 09:48:31 -0800
> > > Subject: [PATCH] hw/cxl/events: Add qmp interfaces to add/release dynamic
> > >  capacity extents
> > > Status: RO
> > > Content-Length: 25172
> > > Lines: 731
> > > 
> > > To simulate FM functionalities for initiating Dynamic Capacity Add
> > > (Opcode 5604h) and Dynamic Capacity Release (Opcode 5605h) as in CXL spec
> > > r3.1 7.6.7.6.5 and 7.6.7.6.6, we implemented two QMP interfaces to issue
> > > add/release dynamic capacity extents requests.
> > > 
> > > With the change, we allow to release an extent only when its DPA range
> > > is contained by a single accepted extent in the device. That is to say,
> > > extent superset release is not supported yet.
> > > 
> > > 1. Add dynamic capacity extents:
> > > 
> > > For example, the command to add two continuous extents (each 128MiB long)
> > > to region 0 (starting at DPA offset 0) looks like below:
> > > 
> > > { "execute": "qmp_capabilities" }
> > > 
> > > { "execute": "cxl-add-dynamic-capacity",
> > >   "arguments": {
> > >       "path": "/machine/peripheral/cxl-dcd0",
> > >       "host-id": 0,
> > >       "selection-policy": 2,
> > >       "region": 0,
> > >       "tag": "",
> > >       "extents": [
> > >       {
> > >           "offset": 0,
> > >           "len": 134217728
> > >       },
> > >       {
> > >           "offset": 134217728,
> > >           "len": 134217728
> > >       }
> > >       ]
> > >   }
> > > }
> > > 
> > > 2. Release dynamic capacity extents:
> > > 
> > > For example, the command to release an extent of size 128MiB from region 0
> > > (DPA offset 128MiB) looks like below:
> > > 
> > > { "execute": "cxl-release-dynamic-capacity",
> > >   "arguments": {
> > >       "path": "/machine/peripheral/cxl-dcd0",
> > >       "host-id": 0,
> > >       "flags": 1,
> > >       "region": 0,
> > >       "tag": "",
> > >       "extents": [
> > >       {
> > >           "offset": 134217728,
> > >           "len": 134217728
> > >       }
> > >       ]
> > >   }
> > > }
> > > 
> > > Signed-off-by: Fan Ni <fan.ni@samsung.com>  
> > 
> > Hi Fan,
> > 
> > A few trivial questions inline.  I don't feel particularly strongly
> > about breaking up the flags fields, but I'd like to understand your
> > reasoning for keeping them as single fields?
> > 
> > Is it mainly to keep aligned with the specification or something else?
> > 
> > Thanks,
> > 
> > Jonathan  
> 
> Hi Jonathan,
> FYI.
> I just sent out the updated QAPI patch with selection policy defined as
> enum and removal policy split out in this thread,
> https://lore.kernel.org/linux-cxl/5856b7a4-4082-465f-9f61-b1ec6c35ef0f@fujitsu.com/T/#m9838d6afda49fb26eb90526eae5550256f5d0f56
Looks good in general, but I have more questions :(
Now we have separate fields, some of them have natural defaults. Maybe
we should provide those and reduce what needs to be passed in?

We will need to do that anyway for any future editions so perhaps
makes sense to do so now?

> 
> Planning to send out v8 on Thursday.
Great.

Jonathan

