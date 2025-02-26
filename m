Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B1A258CC8
	for <linux-cxl@vger.kernel.org>; Wed, 26 Feb 2025 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556998; cv=none; b=s6atAKDwKKupeRmtcVmzdtQ6s7FtSWvefbFPaAjyy3qeiLKHJR//rJatBxXYU9yLI8oSS4O/M5uAX0WdtFKbpKcDJFBaycaFZlDWssvxVnzRUGHHu3M/s9/A6rYshbArUg2pfzyzMcmEk5G+H7MFAK8xrlDfL5qMA4JWmoDLLTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556998; c=relaxed/simple;
	bh=rxr1qoxCQ9jJWFe8+/DwWWDmQZWPIpdnrpwLq4L305E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OUX3oZrmQ7JX6HgyAU1EQ8FIbDQLtDvPBUOBTWZV2wxWmMP/7Oiy8FnWHWNIVuAz5e0uaNECw7BxNLX1iuvFBVkndYmIjph94DaX5DxB5LQpau/rSN0OR2n2jg2Gtu5E7yukI2v7PDOwZOpNHVmLTiMhXybzEJ9hV/OLX8v/Nqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CGMVvIze; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CGMVvIze"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740556991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QeZXd/tp6RR9QoZbl8RaqpKkcilzfuHcJLwvqA/zgO8=;
	b=CGMVvIzet+jIySJnsB+kwQFJAt4QY8sYnTpmHLeRlTz61tG1BTX6q3jAraLM2Jhu+9RMue
	h+/5yABzFopeDpJFirTUZYdXiWM0BEIbwUPUTXRu7CUsM/OyvJQZmHv0pZKz/3CRFU/eSx
	VBbLAhpzlPssCQ/ocYFyCcrSNIzrbUA=
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: ndctl cxl test suite fails in arm64 QEMU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <9b1492d7-ffa8-4d61-a101-4fa9c2d71ae3@linux.intel.com>
Date: Wed, 26 Feb 2025 17:02:44 +0900
Cc: linux-cxl@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EF2816D5-9476-45F8-9114-79B9FDD7F7BA@linux.dev>
References: <43568B03-6832-4EB1-BF46-EF0F176509E2@linux.dev>
 <9b1492d7-ffa8-4d61-a101-4fa9c2d71ae3@linux.intel.com>
To: Marc Herbert <Marc.Herbert@linux.intel.com>
X-Migadu-Flow: FLOW_OUT

Marc,

> On Feb 26, 2025, at 2:08, Marc Herbert <Marc.Herbert@linux.intel.com> =
wrote:
>=20
> On 2025-02-24 20:09, Itaru Kitayama wrote:
>>=20
>> Has anyone noticed the ndctl cxl test suite failures I reported below =
on arm64, QEMU emulation?
>>=20
>> https://github.com/pmem/ndctl/issues/278
>>=20
>> I=E2=80=99m using Jonathan=E2=80=99s latest CXL capable QEMU [1], and =
the latest CXL kernel [2].
>>=20
>=20
>=20
> Hi,
>=20
> Sorry I wanted to spend more time and share a more detailed answer and
> of course I got side-tracked.
>=20
> Do you have CONFIG_RANDOMIZE_MEMORY on?
>=20
> If yes then please try this either this:
>=20
>  cd kernel
>  ./scripts/config -d CONFIG_RANDOMIZE_MEMORY
>=20
> ... or this:
>=20
> --- a/run_qemu.sh
> +++ b/run_qemu.sh
> @@ -681,6 +681,7 @@ build_kernel_cmdline()
> "initcall_debug"
> "log_buf_len=3D20M"
> "memory_hotplug.memmap_on_memory=3Dforce"
> + "nokaslr"
> )
> if [[ $_arg_gdb =3D=3D "on" ]]; then
> kcmd+=3D(

I do wonder if in x86 this is enabled, some of the cxl test cases are =
supposed to fail?

Itaru.=20=
