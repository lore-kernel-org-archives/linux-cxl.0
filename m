Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E51D13665A
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jul 2024 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172450; cv=none; b=FfF4pTyYptBYb6ZsBfGpgKkt3JbjY/egAt2Hb1KKTd6d6iaS+Pvi5i+VBJ8spHj4fS5RtdYQu+TpE/PAHPyhQD7zVAS1m9TcAU3BtxeZ63ZN7oCobFHaQd7pTfH7S20a+TtFJjlO/0pW0l5jl+cB0yzLb3f89lVCeaBrvxQyVRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172450; c=relaxed/simple;
	bh=l43EIErU4RzXzT6FBxmRI/yXqkC5oJ9TSmkjNKv2BmA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIN9ZqeNliR5UdFWxCb+Xpj47dDLvYsiGKkOzIaP1cElo6jT1c5nDMyQgyLy+Rrd7qnktGmZYYSHltIt7KV+HylgaEUpwTaGUVyvaVXGQHZct6xPvt8CD+85vTKV1DA6Wx/S1LdVV9jbfDf22kKJlSGuXoCOJBl8Xkk+SbLeMBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFpQS5W5Zz6JBSv;
	Fri,  5 Jul 2024 17:40:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F9BE140B38;
	Fri,  5 Jul 2024 17:40:44 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 5 Jul
 2024 10:40:44 +0100
Date: Fri, 5 Jul 2024 10:40:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: Zhao Liu <zhao1.liu@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "Markus
 Armbruster" <armbru@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>, "Zhao
 Liu" <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH 1/3] hw/cxl: Get rid of unused cfmw_list
Message-ID: <20240705104043.000023fb@Huawei.com>
In-Reply-To: <eb397f41-9a81-4b1f-a1ed-7f0b99b42b30@fujitsu.com>
References: <20240702143425.717452-1-Jonathan.Cameron@huawei.com>
	<20240702143425.717452-2-Jonathan.Cameron@huawei.com>
	<5ffea576-0b87-46c1-b4dc-e09bd253805e@fujitsu.com>
	<ZodXMPef9bIROG5u@intel.com>
	<eb397f41-9a81-4b1f-a1ed-7f0b99b42b30@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 5 Jul 2024 02:29:34 +0000
"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:

> On 05/07/2024 10:15, Zhao Liu wrote:
> >> There is a new user for cfmw_list now
> >> https://lore.kernel.org/qemu-devel/20240704093404.1848132-1-zhao1.liu@=
linux.intel.com/
> >>
> >> So I think we should drop this patch. =20
>=20
> > Hi Zhijian,
> >=20
> > I'm not a "real" user and that bug was originally found by code reading.
> >=20
> > So that fix won't block your drop. =F0=9F=99=82 =20
>=20
>=20
> "hw/cxl: Get rid of unused cfmw_list" is no longer needed.
>=20
>=20
>=20
> >=20
> > And I think the fix is worth being laned before cfmw_list gets dropped,
> > for being able to port backwards to stable QEMU. =20
>=20
> Your fix[0] requires CXLState.cfmw_list, and I think CXLState.cfmw_list w=
as designed for *get* purpose
> but got mistake at that time.
>=20
> [0] https://lore.kernel.org/qemu-devel/20240704093404.1848132-1-zhao1.liu=
@linux.intel.com/
Ok.  Michael, please ignore this one as the lack of use is result of anothe=
r bug.=20
I hadn't gotten to that fix yet, so missed the connection.

The rest of this series is unrelated.

Jonathan

>=20
>=20
> >    =20
> >> On 02/07/2024 22:34, Jonathan Cameron wrote: =20
> >>> From: Li Zhijian<lizhijian@fujitsu.com>
> >>>
> >>> There is no user for this member. All '-M cxl-fmw.N' options have
> >>> been parsed and saved to CXLState.fixed_windows.
> >>>
> >>> Signed-off-by: Li Zhijian<lizhijian@fujitsu.com>
> >>> Signed-off-by: Jonathan Cameron<Jonathan.Cameron@huawei.com>
> >>> ---
> >>>    include/hw/cxl/cxl.h | 1 -
> >>>    hw/cxl/cxl-host.c    | 1 -
> >>>    2 files changed, 2 deletions(-)
> >>>
> >>> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> >>> index 75e47b6864..e3ecbef038 100644
> >>> --- a/include/hw/cxl/cxl.h
> >>> +++ b/include/hw/cxl/cxl.h
> >>> @@ -43,7 +43,6 @@ typedef struct CXLState {
> >>>        MemoryRegion host_mr;
> >>>        unsigned int next_mr_idx;
> >>>        GList *fixed_windows;
> >>> -    CXLFixedMemoryWindowOptionsList *cfmw_list;
> >>>    } CXLState;
> >>>    =20

