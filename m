Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF1C14D2BC
	for <linux-cxl@vger.kernel.org>; Fri, 26 Apr 2024 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147248; cv=none; b=XWKX8Bs5j135KbAb0hpMzbCL1W0aZBoPItWmwCer3K3lohwS1JTZ7AFNPNH/GCJTPDnDoNmXYc3W2y+RjQM8boH7zvlmJFbrsH4gT8X+jhQ8UcUWcwxk5eLIIXdIsst8HDXU7ZKPUhrdHJCnDfP2L8np6ioariOoKLThjccKo6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147248; c=relaxed/simple;
	bh=LKmDmVzTGH079ORuqxLX3wUvWTvW43Nzj4yxmpHRcZ4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SsOb273Zoi9lBIx0wYa+qgT7Bm58MPS4RoLDsC8Semp3O8/hDDfWbmv9UtrI2fK5rYJcu73+tqFEYImcCUh5IS+I8e80QJ8UxdWBJkr3/KLRE5h4ElfdERZhCj1fJIFs7WC+tcysJhLIs2FPxZs2O8/f1SU3T7wCC/b+HkLWjPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQy7F0ds9z6D8rB;
	Fri, 26 Apr 2024 23:58:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9AF8D140516;
	Sat, 27 Apr 2024 00:00:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Apr
 2024 17:00:42 +0100
Date: Fri, 26 Apr 2024 17:00:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Markus Armbruster <armbru@redhat.com>, fan <nifan.cxl@gmail.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<jim.harris@samsung.com>, <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan
 Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240426170041.000055fd@Huawei.com>
In-Reply-To: <662a934b2757c_fa7d3294fc@iweiny-mobl.notmuch>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
	<20240304194331.1586191-10-nifan.cxl@gmail.com>
	<87a5livrdr.fsf@pond.sub.org>
	<ZilDz3X5hmda5oNr@debian>
	<87plue9en1.fsf@pond.sub.org>
	<662a934b2757c_fa7d3294fc@iweiny-mobl.notmuch>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 25 Apr 2024 10:30:51 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> Markus Armbruster wrote:
> > fan <nifan.cxl@gmail.com> writes:
> >   
> > > On Wed, Apr 24, 2024 at 03:09:52PM +0200, Markus Armbruster wrote:  
> > >> nifan.cxl@gmail.com writes:
> > >>   
> > >> > From: Fan Ni <fan.ni@samsung.com>
> > >> >
> > >> > Since fabric manager emulation is not supported yet, the change implements
> > >> > the functions to add/release dynamic capacity extents as QMP interfaces.  
> > >> 
> > >> Will fabric manager emulation obsolete these commands?  
> > >
> > > If in the future, fabric manager emulation supports commands for dynamic capacity
> > > extent add/release, it is possible we do not need the commands.
> > > But it seems not to happen soon, we need the qmp commands for the
> > > end-to-end test with kernel DCD support.  
> > 
> > I asked because if the commands are temporary testing aids, they should
> > probably be declared unstable.  Even if they are permanent testing aids,
> > unstable might be the right choice.  This is for the CXL maintainers to
> > decide.
> > 
> > What does "unstable" mean?  docs/devel/qapi-code-gen.rst: "Interfaces so
> > marked may be withdrawn or changed incompatibly in future releases."
> > 
> > Management applications need stable interfaces.  Libvirt developers
> > generally refuse to touch anything in QMP that's declared unstable.
> > 
> > Human users and their ad hoc scripts appreciate stability, but they
> > don't need it nearly as much as management applications do.
> > 
> > A stability promise increases the maintenance burden.  By how much is
> > unclear.  In other words, by promising stability, the maintainers take
> > on risk.  Are the CXL maintainers happy to accept the risk here?
> >   
> 
> Ah...  All great points.
> 
> Outside of CXL development I don't think there is a strong need for them
> to be stable.  I would like to see more than ad hoc scripts use them
> though.  So I don't think they are going to be changed without some
> thought though.

These align closely with the data that comes from the fabric management
API in the CXL spec.  So I don't see a big maintenance burden problem
in having these as stable interfaces.  Whilst they aren't doing quite
the same job as the FM-API (which will be emulated such that it is
visible to the guest as that aids some other types of testing) that
interface defines the limits on what we can tell the device to do.

So yes, risk for these is minimal and I'm happy to accept that.
It'll be a while before we need libvirt to use them but I do
expect to see that happen. (subject to some guessing on a future
virtualization stack!)

Jonathan



> 
> Ira
> 
> [snip]

