Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CCD143748
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 01:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741311905; cv=none; b=JGgHRSc9SO6jbajmoQmLktQWJzSb88NmKmcKYFdPZWYPVvpx/DNRN9dZU31CuIija71RfUpJ1Igpq8BmsA4cQvIbQrb/jL4IsfLyrQGOC0BaWoBtGS+nelgXM9c3eo43o8RGAr6F0J/BngHE83lsjpcW34qijvKGSB0ySYpC/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741311905; c=relaxed/simple;
	bh=iQRwdXWwOkqudGH6CLUUMRxPEb7i4/3wmKSEvV5Uk8M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RFtDK4eTW+EYrKBDKGROxbPM9UutaJTyWsWPImr9tMFfvFKMM2gL7/mSwO082fyGMtE4+7jWAGNCPZOugc31DRDWAaI6W5GSl1T1IoeTTnIMYLZ9DIqnTvEy/Eq1SD6hePhhWOtNNu/gAPTd1FSY8DfdC7ZECP8dOQsRHlDhnq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TZjjf+gs; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TZjjf+gs"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741311900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t2bFMbfMVXDYoGzv6lqjOkbH2mDLTHmTH76icIt/9qA=;
	b=TZjjf+gs6e7iSFwZLvxXGeKsdFqrnSMxPtCCdeOYrmzl5aRoRTk7QWztCii2nM+vfyK4qi
	5nUCVLCmWH9dWZkCkxvnNJIKZn4fOvPkXQWvNkwGc87JlbsLk+kYDUmpJehWkxnU6djUOb
	Ln78K624MbO/GDzkE2FnVgNRV19Ys/U=
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: ndctl cxl test suite fails in arm64 QEMU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <Z8HJbMkV6mzikTI8@vm4>
Date: Fri, 7 Mar 2025 10:44:23 +0900
Cc: linux-cxl@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4135507A-DECD-4944-8B39-737A7C90D40A@linux.dev>
References: <43568B03-6832-4EB1-BF46-EF0F176509E2@linux.dev>
 <Z75G2UKmx7G59u7P@aschofie-mobl2.lan> <Z8HJbMkV6mzikTI8@vm4>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>
X-Migadu-Flow: FLOW_OUT

Hi Jonathan, Alison,

> On Feb 28, 2025, at 23:34, Itaru Kitayama <itaru.kitayama@linux.dev> =
wrote:
>=20
> On Tue, Feb 25, 2025 at 02:40:25PM -0800, Alison Schofield wrote:
>> On Tue, Feb 25, 2025 at 01:09:57PM +0900, Itaru Kitayama wrote:
>>> Hi,
>>>=20
>>> Has anyone noticed the ndctl cxl test suite failures I reported =
below on arm64, QEMU emulation?
>>>=20
>>> https://github.com/pmem/ndctl/issues/278
>>>=20
>>> I=E2=80=99m using Jonathan=E2=80=99s latest CXL capable QEMU [1], =
and the latest CXL kernel [2].
>>=20
>> Hi Itaru,
>>=20
>> Looking at region.c:size_store() it seems that alloc_hpa() is =
failing.
>> (kstrtou64 is arch independent and it works for me with same script &
>> value)
>>=20
>> Check the dmesg log at the time of the failure. alloc_hpa() may be
>> emitting a message.  (In the run_qemu.sh cmdline add '--cxl-debug')
>=20
> dynamic debug reported this (kernel is without kaslr, today's =
cxl/next):
>=20
> [  193.267649] device: 'region4': device_add
> [  193.267931] bus: 'cxl': add device region4
> [  193.268284] cxl region4: bus: 'cxl': __driver_probe_device: matched =
device with driver cxl_region
> [  193.268333] cxl region4: bus: 'cxl': really_probe: probing driver =
cxl_region with device
> [  193.268401] cxl_region region4: no default pinctrl state
> [  193.268482] cxl_region region4: probe with driver cxl_region =
rejects match -6
>=20
> does the above show the region4 was not added properly? The sysfs
> entries are there after the out of range failure.

The driver/cxl/core/region.c=E2=80=99s size_store() triggers a sequence =
of:=20

alloc_hpa()
alloc_free_mem_region()
get_free_mem_region() // with flags set to 0, retruns -ERANGE

While I am looking at the resource core code, do you think this is =
caused by the old firmware I am using
when booting QEMU built off of your CXL topic branch? Suggestions are =
welcome.

Itaru.=20

>=20
> Itaru.
>=20
>>=20
>> Sounds like Marc is on to something and maybe the KASLR is known
>> to cause this problem.
>>=20
>> Thanks for posting to this list and send any further questions or
>> comments. Happy to have you using run_qemu.sh and the cxl tests!
>>=20
>> Alison
>>=20
>>=20
>>>=20
>>> [1] https://gitlab.com/jic23/qemu/ cxl-2025-02-20
>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/
>>>=20
>>> Thanks,
>>> Itaru.


