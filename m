Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C3B1FA14E
	for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857091; cv=none; b=cCPbrwMVd4lwmbs4Lm/p8Ujrtt3WwM/QhzKbb0RCsWK7XYEpkAMdFYLmLWVOrJ2lR8YEAbxHnGbBGNN9HS6ca5XDwMqs1hrXr/BRt0wiUuY9e5i7Lz+/dyzhQ/NcN40br6kXTVsWs9daHEXLClmhiW0RZnLPfbYcXSgG4MaSvxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857091; c=relaxed/simple;
	bh=lcDtcf2tk1grIuVwkC66XWaNiJ0lE+tWdRycEcMyPyk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3McqVd0pYq8TwtoX/aRHVYp2+kW+mipVC/aiiq21GF6We6kluvcqvTaGw/Id9JijgEqjvc1t0WRF/+at6utQ6oHJlENVjUYtTN49n17wpJYlOxkBRlyRMaBNUSfr/uXpUlLgPJjM4amqZZX0ZFVnTo6So4EHYzj5u/SgECLb/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZD1pQ3qy9z6J6pH;
	Thu, 13 Mar 2025 17:06:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C87A7140A70;
	Thu, 13 Mar 2025 17:11:25 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Mar
 2025 10:11:25 +0100
Date: Thu, 13 Mar 2025 09:11:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
CC: Alison Schofield <alison.schofield@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: ndctl cxl test suite fails in arm64 QEMU
Message-ID: <20250313091126.000040db@huawei.com>
In-Reply-To: <4135507A-DECD-4944-8B39-737A7C90D40A@linux.dev>
References: <43568B03-6832-4EB1-BF46-EF0F176509E2@linux.dev>
	<Z75G2UKmx7G59u7P@aschofie-mobl2.lan>
	<Z8HJbMkV6mzikTI8@vm4>
	<4135507A-DECD-4944-8B39-737A7C90D40A@linux.dev>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 7 Mar 2025 10:44:23 +0900
Itaru Kitayama <itaru.kitayama@linux.dev> wrote:

> Hi Jonathan, Alison,
>=20
> > On Feb 28, 2025, at 23:34, Itaru Kitayama <itaru.kitayama@linux.dev> wr=
ote:
> >=20
> > On Tue, Feb 25, 2025 at 02:40:25PM -0800, Alison Schofield wrote: =20
> >> On Tue, Feb 25, 2025 at 01:09:57PM +0900, Itaru Kitayama wrote: =20
> >>> Hi,
> >>>=20
> >>> Has anyone noticed the ndctl cxl test suite failures I reported below=
 on arm64, QEMU emulation?
> >>>=20
> >>> https://github.com/pmem/ndctl/issues/278
> >>>=20
> >>> I=E2=80=99m using Jonathan=E2=80=99s latest CXL capable QEMU [1], and=
 the latest CXL kernel [2]. =20
> >>=20
> >> Hi Itaru,
> >>=20
> >> Looking at region.c:size_store() it seems that alloc_hpa() is failing.
> >> (kstrtou64 is arch independent and it works for me with same script &
> >> value)
> >>=20
> >> Check the dmesg log at the time of the failure. alloc_hpa() may be
> >> emitting a message.  (In the run_qemu.sh cmdline add '--cxl-debug') =20
> >=20
> > dynamic debug reported this (kernel is without kaslr, today's cxl/next):
> >=20
> > [  193.267649] device: 'region4': device_add
> > [  193.267931] bus: 'cxl': add device region4
> > [  193.268284] cxl region4: bus: 'cxl': __driver_probe_device: matched =
device with driver cxl_region
> > [  193.268333] cxl region4: bus: 'cxl': really_probe: probing driver cx=
l_region with device
> > [  193.268401] cxl_region region4: no default pinctrl state
> > [  193.268482] cxl_region region4: probe with driver cxl_region rejects=
 match -6
> >=20
> > does the above show the region4 was not added properly? The sysfs
> > entries are there after the out of range failure. =20
>=20
> The driver/cxl/core/region.c=E2=80=99s size_store() triggers a sequence o=
f:=20
>=20
> alloc_hpa()
> alloc_free_mem_region()
> get_free_mem_region() // with flags set to 0, retruns -ERANGE
>=20
> While I am looking at the resource core code, do you think this is caused=
 by the old firmware I am using
> when booting QEMU built off of your CXL topic branch? Suggestions are wel=
come.
Unlikely as I don't think there have been any relevant changes in edk2 for
a long long time.

Jonathan

>=20
> Itaru.=20
>=20
> >=20
> > Itaru.
> >  =20
> >>=20
> >> Sounds like Marc is on to something and maybe the KASLR is known
> >> to cause this problem.
> >>=20
> >> Thanks for posting to this list and send any further questions or
> >> comments. Happy to have you using run_qemu.sh and the cxl tests!
> >>=20
> >> Alison
> >>=20
> >>  =20
> >>>=20
> >>> [1] https://gitlab.com/jic23/qemu/ cxl-2025-02-20
> >>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/
> >>>=20
> >>> Thanks,
> >>> Itaru. =20
>=20
>=20
>=20

