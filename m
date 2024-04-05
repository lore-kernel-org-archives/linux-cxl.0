Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3FC16C439
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315554; cv=none; b=GrWGvObjR3Av2U1kE1+Y8iTLMqRg86Aano+MkMcvotgVJLgOhiTztxH8QogJ7pn/dhOVBtpxLoiQjnQ4EWF5iIT+A1vrAXUaAy75o2UMIrUXRWvsOkCCUwqT2lHNjr4eSMWD9rpy+0ccEp05dEMNcFN1kE6aHNl01ZacG5OcbuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315554; c=relaxed/simple;
	bh=V9LdeNHZYLG1Br6Ln8Q5/rHgoBVRaqySQPB/JTe0MN8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJ/Me9sGXYrTqWfeTzW2V5H7+EFdLIse8lw3hDSCgkanC3VDkMHmTWKBVmWAldfG9FImaHTSxHJe08nm1Je3+5IEwZnwJISzBSpsaKkBobz1yJ1JdNzg7OUTw4Q0c8VAtV63gPMZI9T9Ul8Fmwf7uYlKTAemlXAJjU6QDxs9pN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9wlW4sQ8z6JB86;
	Fri,  5 Apr 2024 19:11:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D509140C98;
	Fri,  5 Apr 2024 19:12:28 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 12:12:28 +0100
Date: Fri, 5 Apr 2024 12:12:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: =?ISO-8859-1?Q?J=F8rgen?= Hansen <Jorgen.Hansen@wdc.com>
CC: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "gregory.price@memverge.com"
	<gregory.price@memverge.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"a.manzanares@samsung.com" <a.manzanares@samsung.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>, "wj28.lee@gmail.com"
	<wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 08/12] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Message-ID: <20240405121227.000069d7@Huawei.com>
In-Reply-To: <9e4207aa-be50-40ca-9fda-30e4fabf6e98@wdc.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
	<20240325190339.696686-9-nifan.cxl@gmail.com>
	<9e4207aa-be50-40ca-9fda-30e4fabf6e98@wdc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 4 Apr 2024 13:32:23 +0000
J=F8rgen Hansen <Jorgen.Hansen@wdc.com> wrote:

Hi J=F8rgen,

> > +static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> > +                                          uint8_t *payload_in,
> > +                                          size_t len_in,
> > +                                          uint8_t *payload_out,
> > +                                          size_t *len_out,
> > +                                          CXLCCI *cci)
> > +{
> > +    CXLUpdateDCExtentListInPl *in =3D (void *)payload_in;
> > +    CXLType3Dev *ct3d =3D CXL_TYPE3(cci->d);
> > +    CXLDCExtentList *extent_list =3D &ct3d->dc.extents;
> > +    uint32_t i;
> > +    uint64_t dpa, len;
> > +    CXLRetCode ret;
> > +
> > +    if (in->num_entries_updated =3D=3D 0) {
> > +        return CXL_MBOX_SUCCESS;
> > +    } =20
>=20
> The mailbox processing in patch 2 converts from le explicitly, whereas=20
> the mailbox commands here don't. Looking at the existing mailbox=20
> commands, convertion doesn't seem to be rigorously applied, so maybe=20
> that is OK?

The early CXL code didn't take this into account much at all. We've
sort of been fixing stuff up as we happen to be working on it. Hence
some stuff is big endian safe and some not :(

Patches welcome, but it would be good to not introduce more cases
that need fixing when we eventually clean them all up (and have
a big endian test platform to see if we got it right!)

Jonathan
