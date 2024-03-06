Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9360F5DF1D
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737108; cv=none; b=oeeiort6id6Ixy9Tqkf6NKLohjdkq43RoG9I8UNBPFw9kmq/2E2HHlkDFLeDmmOZiN9dsfEvIdHl6hTdU9PYa2gMxqhxSYA3EzU3l5uC/BGfo2I3h4rA98jEJlITLtc7ARykKIIhPxFrjIIQoq686nWwI7iGxUO3A+Bcjyb23qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737108; c=relaxed/simple;
	bh=8xEGWgreU7mf+tbvnw8cS5ihC7lnADfy4Dcl+gE17PE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAN4f0e9MszzHP8XJMTBCjZQveOaylfXGdPLnp9837sWWejUskVka5SWZNrLRa9T5VqU1Vpgrc8XhjNT8efLIZvZ+iysHSc5V56CxMjBC3yW6aJ17Qwl+z//wW0vhFAXvUImnaPGFZAMnODZr2vHbMzrq0E63LBsi7V08FjFxfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tqb691fKtz6K62Z;
	Wed,  6 Mar 2024 22:53:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 79DFD140DDC;
	Wed,  6 Mar 2024 22:58:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 14:58:23 +0000
Date: Wed, 6 Mar 2024 14:58:23 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>, Fan Ni
	<fan.ni@samsung.com>
Subject: Re: [PATCH v4 08/10] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Message-ID: <20240306145823.000028ee@Huawei.com>
In-Reply-To: <ZeFR_Z9nInhyf-W_@debian>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
	<20240221182020.1086096-9-nifan.cxl@gmail.com>
	<20240226180417.00004dc4@Huawei.com>
	<Zd00YhCejwN6NuU6@debian>
	<20240227103909.00002a92@Huawei.com>
	<ZeFR_Z9nInhyf-W_@debian>
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

...

> > > I cannot find anything specific to this in the specification either.
> > > Since we have already detected the case where the extent range across
> > > multiple regions, the only case we need to capture here is one/multiple
> > > portions of an extents getting released and causing extent overflow.
> > > I think we can handle it after we introduce the bitmaps (PATCH 10) which
> > > indicates DPA ranges mapped by valid extents in the device.
> > > 
> > > With that, The release workflow would be
> > > 
> > > 1) detecting malformed extent lists; if passed
> > > 2) do cxl_detect_extent_overflow {
> > >     delta = 0;
> > >     make a copy of the bitmap as bitmap_copy;
> > >     for each extent in the updated_extent_list; do
> > >         if (extent range not fully set in the bitmap_copy)
> > >             return error;
> > >         else {
> > >             if gap at the front based on the bitmap_copy:
> > >                 delta += 1;
> > >             if gap at the end based on the bitmap_copy:
> > >                 delta += 1;
> > >             delta -= 1;
> > >             // NOTE: current_extent_count will not be updated in the
> > >             // loop since delta will track the whole loop
> > >             if (delta + current_extent_count > max_extent_count)
> > >                 return resource exhausted;
> > >             update bitmap_copy to clear the range covered by the extent
> > >             under consideration;
> > >         }
> > >     done
> > > 
> > > }; if pass
> > > 3. do real release: in the pass, we will not need to detect extent
> > > errors;
> > > 
> > > Does the above solution sound reasonable? If so, do we want to go this
> > > way? do we need to introduce the bitmap earlier in the series?  
> > 
> > Yes, something along these lines should work nicely.
> > 
> > Jonathan  
> 
> Hi Jonathan,
> I updated the code based on your feedback and now we can process extent
> release request more flexible.

Excellent!

> We can now support superset release (actually it can do even more,
> as long as the DPA range is coverd by accepted extents, we can release).
> 
> I have run following tests and the code works as expected,
> 1. Add multiple extents, and removing them one by one, passed;
> 2. Superset release: add multiple extents with continuous DPA ranges, and
>    remove all of them with a single release request with an extent covering the
>    whole DPA range, passed;
> 3. Partial extent release: add a large extent and release only part of it,
>    passed;
> 4. Partial+superset release: add multiple extents,and release it with some
>    leftover with one request with an extent. For example, add extents [0-128M]
>    and [128M-256M], release [64M-256M]. Passed;
> 5. Release extent not aligned to block size, failed as expected;
> 6. Extents have overlaps, fail the request as expected;
> 7. Extent has uncovered DPA range, skip the extent as expected;
> 
> The only limitation is that for superset release case, if we find
> part of its DPA range is still pending to add, while the other is
> accepted, we reject it through QMP interface.

I think that is a reasonable limitation as we don't expect people
to do that crazy on QMP side.   Maybe long term we'll want a
'release all' type command (I'm thinking virtualized device usecases)
but we can deal with that later.

> 
> The latest code is https://github.com/moking/qemu/tree/dcd-v5.
> 
> The main changes are in the last three commits. 
> Btw, in the last commit, I introduce new QMP interfaces to print out
> accepted and pending-to-add list in the device to a file "/tmp/qmp.txt",
> do we want it? If yes, I can polish it a little bit, otherwise I will
> keep it for my own test purpose.
Ah. I missed this mail and replied directly.  That needs a rethink
as the thread has concluded I think. I'll carry it on my tree, but not
look to upstream it.
> 
> I will test more and send out v5 if the above looks reasonable to you.
> 
Sorry for slow reply - I'm a bit behind with mailing lists.
Great you sent it out in the meantime.

Jonathan
