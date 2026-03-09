Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465BF27467F;
	Mon,  9 Mar 2026 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079823; cv=none; b=a4j89ClYX10bbx/CDIdxhY71iT2uYhjD6vjIo1CVv0S3jhqR+ObGbWF8bDLTwnkekLb6bPSrkIQkzg+I5E3MQhvWUlYalbW3a/eKhQLoN6dUuy4gWa9jYe3eXaSmGExxS4uW4vFVNpd4+tjiVtwuXXpucUfEQDPtc4YdytwfohE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079823; c=relaxed/simple;
	bh=8oM++Hd7Hu52eLQQfeqsfFKE5wVpbTLfz7pYGkCEGpo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4sjvDKyX61goZWq7i7pokBYQvy4GHDu8ns8hAmcPqDhhV4dkgaEr6R95Pl76Wwd/g/PbZDLWMS7u/busstK8x3qnYnMRjxWLQtbyjJYV/yCsvFdEMCAlBM29/yNgdhb3Sg+eup98WJ/KWpYld+xBdjborDyyg7ixEc4nfdYd24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fV4m006XCzJ46XL;
	Tue, 10 Mar 2026 02:09:36 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 50F394056A;
	Tue, 10 Mar 2026 02:10:19 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 18:10:18 +0000
Date: Mon, 9 Mar 2026 18:10:17 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Sungwoo Kim <iam@sung-woo.kim>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Ben Widawsky <bwidawsk@kernel.org>,
	<daveti@purdue.edu>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Fix a race bug in delete_region_store
Message-ID: <20260309181017.000010e0@huawei.com>
In-Reply-To: <CAJNyHpJLeyWDKBEgrH+ouK1XZM91f9zabmFcHHnmcKC3y__sCg@mail.gmail.com>
References: <20260308185958.2453707-2-iam@sung-woo.kim>
	<20260309120053.000031cc@huawei.com>
	<CAJNyHpJLeyWDKBEgrH+ouK1XZM91f9zabmFcHHnmcKC3y__sCg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 9 Mar 2026 13:56:33 -0400
Sungwoo Kim <iam@sung-woo.kim> wrote:

> On Mon, Mar 9, 2026 at 8:00=E2=80=AFAM Jonathan Cameron
> <jonathan.cameron@huawei.com> wrote:
> >
> > On Sun, 8 Mar 2026 14:59:58 -0400
> > Sungwoo Kim <iam@sung-woo.kim> wrote:
> > =20
> > > A race exists when two concurrent sysfs writes to delete_region speci=
fy
> > > the same region name. Both calls succeed in cxl_find_region_by_name()
> > > (which only does device_find_child_by_name and takes a reference), and
> > > both then proceed to call devm_release_action(). The first call atomi=
cally
> > > removes and releases the devres entry successfully. The second call f=
inds
> > > no matching entry, causing devres_release() to return -ENOENT, which =
trips
> > > the WARN_ON.
> > >
> > > Fix this by replacing devm_release_action() with devm_remove_action_n=
owarn()
> > > followed by a manual call to unregister_region(). devm_remove_action_=
nowarn()
> > > removes the devres tracking entry and returns an error code. =20
> >
> > Naive question (or just me being lazy).  Why can't we take the
> > write lock on cxl_rwsem.region? =20
>=20
> Thanks for your review. I've just tested your suggestion, but it
> caused an ABBA deadlock:
>=20
> task 1:
> create_pmem_region_store
>   __device_attach()         ...dev_lock()
>     cxl_region_can_probe()  ...lock(cxl_rwsem.region)
>=20
> task 2:
> delete_region_store()       ...lock(cxl_rwsem.region)
>   unregister_region()
>     device_del()            ...dev_lock()
>=20

Thanks for chasing that down. (I was indeed just being lazy!)

Let's wait a few days to get inputs from others on this.

One horrible option would just be to have a single purpose lock to
serialize handling writes to the sysfs file. I don't much like
that solution however!

Thanks,

Jonathan

> One way to avoid a deadlock might be to not add an additional lock.

