Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D7830F94D
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784613844; cv=none; b=P/2Hr38tuoVTb8PN//duef7jlFf4RIjEiiNlS5fSdjzBXEUFQOTyXY62ChPa6yxyjKjnhU5J//bWndemKBoezlNGV+Zmz1K5hvjQXlnPoCPLZUmCpzBKl2ymFlYXvGLQMB/Sx1Xt5ZG6jlMIPt3AcltuTZ6Z2yP6Fp1aoUOqOsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784613844; c=relaxed/simple;
	bh=89r97nTfubMfnuCmQsSwwFIx+dmitDh/O327rPI9Lpk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yx1qmvuCsOvbMR4yhpRbMk6ESn48UEdqhQy8pyusR7n37avi9JYy6/+99FWl6cum1aokYTzA41BdvHxdborIQpGsgVOQzA7Kzq095B+j9SNpRHTavZuDoWhZAVGRyLLwoZxtYIkCHu39l1GiBGsvF/JRhcN3TtWzBOhTsxCFlxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUXAbxCT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUXAbxCT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188271F00A3A;
	Tue, 21 Jul 2026 06:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784613843;
	bh=oN0qcQIhYHW17rHJAwoT+FD/AYCrDP2SUXmX77ZAvis=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EUXAbxCTn/RYMfYCfxJjUBWQaL9MzdZNF/1OXC/GWSzC7AxBm4XN3YEd3voG0sp7o
	 vQVtoaFSC++1C4DNu5XVFF30C8nFWEwqpOzUqZX3A31X6fHaJMcCz9qrOckxiBjMhm
	 RAlMHSwbDArcZyg5cMF/VZo5CBxKY6E/YrQKe1o+CnTIHcfhUL/f5AvogqmDH895Qe
	 9Cxeq6A3VE8f63NruYqxZ/kLjh7kS9MXfUcsZh+FwvbK80CpXTkuryIJNWQBMbBp4x
	 2qJ3gVR4LKzMaZcV6i5AXpd+RzG11LT68/YOvKImGZSMy9lVjQBydYSOuBMp68LVE0
	 heoj+KBJPYN+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/region: Reject delete of a provider-locked region
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260721055131.20935-1-icheng@nvidia.com>
References: <20260721055131.20935-1-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 06:04:02 +0000
Message-Id: <20260721060403.188271F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] A Time-Of-Check to Time-Of-Use (TOCTOU) race condition in `delete_=
region_store()` allows userspace to bypass the `CXL_REGION_F_LOCK` protecti=
on, leading to orphaned hardware decoders.

Pre-existing issues:
- [High] Userspace can bypass `CXL_REGION_F_LOCK` restrictions and tear dow=
n region software state by manually detaching targets via `targetN` sysfs a=
ttributes, leading to orphaned hardware decoders.
--

--- Patch [1]: [PATCH] cxl/region: Reject delete of a provider-locked regio=
n ---
commit 447746e2d3844401b6bdd5604c498e319f1e7719
Author: Richard Cheng <icheng@nvidia.com>

cxl/region: Reject delete of a provider-locked region
   =20
delete_region_store() destroys a region object without checking
CXL_REGION_F_LOCK, unlike commit_store() which refuses locked regions
with -EPERM. This patch gates delete_region_store() on CXL_REGION_F_LOCK.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 578622240401d..cfc9622c93095 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2894,6 +2894,9 @@ static ssize_t delete_region_store(struct device *d=
ev,
>  	if (!cxlr || !sysfs_streq(buf, dev_name(&cxlr->dev)))
>  		return -ENODEV;
> =20
> +	if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
> +		return -EPERM;
> +

[Severity: High]
Is there a Time-Of-Check to Time-Of-Use (TOCTOU) race condition here?

The CXL_REGION_F_LOCK check is performed without holding synchronization
like the region rwsem, leaving a window open before unregister_region()
completes.

If userspace writes to delete_region while concurrently writing to targetN
to attach a target, delete_region_store() could check the lock flag before
it is set.

Then unregister_region() calling device_del() can block in kernfs_drain
until the concurrent target attachment finishes and sets CXL_REGION_F_LOCK.

Once resumed, the software region would be destroyed with the lock flag
set, skipping the hardware reset. Could this sequence recreate the exact
orphaned hardware decoder state this patch intended to prevent?


[Severity: High]
This is a pre-existing issue, but does a similar bypass exist in
store_targetN() when userspace manually detaches targets?

If a root user writes \n to a targetN sysfs attribute of a locked region,
store_targetN() calls detach_target() which eventually reaches
__cxl_decoder_detach(). This software teardown path lacks an F_LOCK check.

Because cxl_region_decode_reset() deliberately skips the hardware reset
for F_LOCK regions, the software state is dropped while the hardware
decoders remain committed.

The user could then write 0 to the size attribute, freeing the physical
memory while it is still actively decoded by hardware.

Should store_targetN() or __cxl_decoder_detach() also be gated by
CXL_REGION_F_LOCK to prevent userspace from tearing down the software
state of locked regions?

>  	unregister_region(cxlr);
> =20
>  	return len;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721055131.2093=
5-1-icheng@nvidia.com?part=3D1
