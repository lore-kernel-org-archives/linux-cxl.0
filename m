Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA07F13E41A;
	Fri, 23 Jan 2026 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769172906; cv=none; b=Pvae3Jo1jn5RO0yWE6zebRIc0S4RMtwq9BKYQiGSYw3n+AZXs4MCHZuRYKqagsXrPBZtLQIXV1qi+GHTFht/2KIahFdaUA2+htEFWpr66UDFwSWD5T1/nKC2N552a0DFcI+MwncGNQi9Dnwv4djLnlXnk9NluhV17OwMaTeaF5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769172906; c=relaxed/simple;
	bh=3Z6XEDjcaclmWARrhrl509YsUVefqzAUyZeSrDsOqak=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjZllMdTdlkqYevd/DxGAixrvWh3v1vwltmILh+Q7XyDxGp46xFRgBZCngUelruISP29oGb0dWLqrvgg4Hfp+SbWX3gm3BYaVR8gq1J0R+geg2aRQDQEFyjy6gKCygPKnnNfVfBkkBImDgMStSYicnMisjP3ZoYSqarnezT4WRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dyHv41433zHnGd2;
	Fri, 23 Jan 2026 20:54:24 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id CD71D40586;
	Fri, 23 Jan 2026 20:55:01 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Jan
 2026 12:55:01 +0000
Date: Fri, 23 Jan 2026 12:54:59 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Neeraj Kumar <s.neeraj@samsung.com>
CC: <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <gost.dev@samsung.com>,
	<a.manzanares@samsung.com>, <vishak.g@samsung.com>, <neeraj.kernel@gmail.com>
Subject: Re: [PATCH V6 00/18] Add CXL LSA 2.1 format support in nvdimm and
 cxl pmem
Message-ID: <20260123125459.00002ac9@huawei.com>
In-Reply-To: <20260123113112.3488381-1-s.neeraj@samsung.com>
References: <CGME20260123113121epcas5p125bc64b4714525d7bbd489cd9be9ba91@epcas5p1.samsung.com>
	<20260123113112.3488381-1-s.neeraj@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)


Trivial comment on the change log.=20

To me this series looks good now.

However, there are some other series touching some of the functions
you modify. E.g cxl_endpoint_port_probe()

I'm not suggesting you rebase on those (Dave might ask for it however!),
but it is probably useful to try a rebase and reply to this cover letter if
there are any significant issues.  There is a lot of code movement going
on so it might just be fuzz.

=46rom the cxl tree, try it on top of the next branch.
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=3Dnext

Thanks,

Jonathan



> Changes in v5->v6
> -----------------
> - Find v5 link at [4]
> - Find v4 link at [5]
> - Find v3 link at [6]
> - Find v2 link at [7]
> - v1 patch-set was broken. Find the v1 links at [8] and [9]
>=20
> [Misc]
> - Rebase with for-7.0/cxl-init
>=20
> [PATCH 01/18]
> - Add Ira RB tag
>=20
> [PATCH 03/18]
> - Use export_uuid() instead of uuid_copy() [Jonathan]
> - Add Jonathan RB tag
> - Add Ira RB tag
>=20
> [PATCH 04/18]
> - Move the assignments at relevant place [Jonathan]
> - Rename lslot to label_slot [Jonathan]
> - Add Ira RB tag
>=20
> [PATCH 05/18]
> - Add Jonathan RB tag
> - Add Ira RB tag
>=20
> [PATCH 06/18]
> - Add Jonathan RB tag
> - Add Ira RB tag
>=20
> [PATCH 07/18]
> - Add Ira RB tag
>=20
> [PATCH 08/18]
> - use export_uuid() to avoid casts to uuid_t * [Jonathan]
> - Add Jonathan RB tag
> - Add Ira RB tag
>=20
> [PATCH 09/18]
> - Add Jonathan RB tag
> - Add Ira RB tag
>=20
> [PATCH 10/18]
> - Initialize struct cxl_memdev_attach variable [Jonathan]
> - Add Jonathan RB tag
>=20
> [PATCH 10/18]
I briefly got confused when using this to see what chagned!
This one is patch 11
> - Its a new patch addition in this series
> - Seperate out renaming of __create_region() to cxl_create_region() [Jona=
than]
>=20
> [PATCH 11/18]
This patch 12.
> - Remove usage of cxl_dpa_free() from alloc_region_dpa() [Jonathan]
>=20
> [PATCH 13/18]
> - Add Jonathan RB tag
>=20
> [PATCH 15/18]
> - Add Jonathan RB tag
>=20
> [PATCH 16/18]
> - Fix wrong name state with region_label_state [Jonathan]
> - Add Jonathan RB tag
>=20
> [PATCH 17/18]
> - Optimize loop matching [Jonathan]
> - Use reverse xmas tree stype [Jonathan]
>=20
> [PATCH 18/18]
> - Add Jonathan RB tag
>
