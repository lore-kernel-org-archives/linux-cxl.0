Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E5221C9F3
	for <linux-cxl@vger.kernel.org>; Tue, 25 Feb 2025 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523112; cv=none; b=UtP/XHeH38K+1k+foIJKe3JjtMwPUhnftN8eyzBvHpd5mwEAqqKRk7e1P9i9vOyH9L3FJOdNG5wiDwg2E1uNHTUI/16JAorOQxVBNzlChWP3poBwnbg4ZOirQjFS8t/S2gf8Mj8yS0a9cGX6x8CW0pMAaZ6lMtR2rnf2bOpgpB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523112; c=relaxed/simple;
	bh=WRlxvNkrXXC6BN+wmlHD+lbgIJJtXn7AV6xabzo5c6E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=N+e3H0r9j8QTE5Qnh9piTxQiRkqxdR87TxBQvmOuhj+rEKk21gWksb3qwUgTbgIfy7BJfc4vg1kgu331yDtsx3AXO4WO3MsTyevuoO+iuCWKauC7uzU/BqjxpqaVuta0UR5QKSiNg2V4uNlPZ6j8fb04gn8DOe4/k0MheteiMhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AfsLZAjN; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AfsLZAjN"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740523104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n1N4b1ub+wBeR9joFWPtCNeogvtFrDoR42IEdIln/+g=;
	b=AfsLZAjN2Mcd3sS/+kswOpBWdXTRn6GjWVE11WjRldhh0IqeQJeXg6VkDhIrskMiWT50L3
	IZct/caVJatGYjsIPutubq0DKWz+3oKVxG/WjC7O9QbwX5sCjEgUpaLCmpsgjFo4fIzik7
	eZqrKtnbgnXzfPIb2z9H9Fp7XhirNiA=
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
Date: Wed, 26 Feb 2025 07:37:58 +0900
Cc: linux-cxl@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD05AE2B-9AA4-4E60-AEF7-705281368838@linux.dev>
References: <43568B03-6832-4EB1-BF46-EF0F176509E2@linux.dev>
 <9b1492d7-ffa8-4d61-a101-4fa9c2d71ae3@linux.intel.com>
To: Marc Herbert <Marc.Herbert@linux.intel.com>
X-Migadu-Flow: FLOW_OUT

Hi Marc,

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

I chose the kernel configuration change and rebuilt the kernel, modules =
installed, then finally cxl_test kernel module installed on the emulated =
system, but I got worth results (occasionally, the kernel OOPS as well):

Log of Meson test suite run on 2025-02-26T07:32:24.101461

Inherited environment: LANG=3DC.UTF-8 LS_COLORS=3D'' TERM=3Dxterm-256color=
 =
PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/=
bin MAIL=3D/var/mail/root LOGNAME=3Droot USER=3Droot HOME=3D/root =
SHELL=3D/bin/bash SUDO_COMMAND=3D'/usr/bin/meson test =
cxl-region-sysfs.sh' SUDO_USER=3Drealm SUDO_UID=3D1000 SUDO_GID=3D1000=20=


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1/1 =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
test:         ndctl:cxl / cxl-region-sysfs.sh
start time:   22:32:24
duration:     0.71s
result:       exit status 1
command:      NDCTL=3D/home/realm/projects/ndctl/build/ndctl/ndctl =
DAXCTL=3D/home/realm/projects/ndctl/build/daxctl/daxctl =
TEST_PATH=3D/home/realm/projects/ndctl/build/test =
UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:pri=
nt_stacktrace=3D1 =
ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1 =
MALLOC_PERTURB_=3D29 =
MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:prin=
t_stacktrace=3D1 DATA_PATH=3D/home/realm/projects/ndctl/test =
MESON_TEST_ITERATION=3D1 =
LD_LIBRARY_PATH=3D/home/realm/projects/ndctl/build/daxctl/lib:/home/realm/=
projects/ndctl/build/ndctl/lib:/home/realm/projects/ndctl/build/cxl/lib =
/bin/bash /home/realm/projects/ndctl/test/cxl-region-sysfs.sh
----------------------------------- stdout =
-----------------------------------
test/cxl-region-sysfs.sh: failed at line 40
----------------------------------- stderr =
-----------------------------------
+ trap 'err $LINENO' ERR
+ check_prereq jq
+ command -v jq
+ modprobe -r cxl_test
+ modprobe cxl_test
+ rc=3D1
++ ./cxl/cxl list -b cxl_test -D -d root
++ jq -r '.[] |
  select(.pmem_capable =3D=3D true) |
  select(.nr_targets =3D=3D 2) |
  .decoder'
  Warning: no matching devices found

+ decoder=3D
+ readarray -t mem
++ ./cxl/cxl list -M -d
++ jq -r '.[].memdev'
  Error: switch `d' requires a value

 usage: cxl list [<options>]

    -d, --decoder <decoder device name>
                          filter by CXL decoder device name(s) / class
+ readarray -t endpoint
++ ./cxl/cxl reserve-dpa -t pmem -s 268435456
++ jq -r '.[] | .decoder.decoder'

 usage: cxl reserve-dpa <mem0> [<mem1>..<memn>] [<options>]

    -b, --bus <bus name>  Limit operation to the specified bus
    -v, --verbose         turn on debug
    -S, --serial          use serial numbers to id memdevs
    -s, --size <size>     size in bytes (Default: all available =
capacity)
    -d, --decoder <decoder instance id>
                          override the automatic decoder selection
    -t, --type <type>     'pmem' or 'ram' (volatile) (Default: 'pmem')
    -f, --force           Attempt 'expected to fail' operations

++ cat /sys/bus/cxl/devices//create_pmem_region
cat: /sys/bus/cxl/devices//create_pmem_region: No such file or directory
+ region=3D
++ err 40
+++ basename /home/realm/projects/ndctl/test/cxl-region-sysfs.sh
++ echo test/cxl-region-sysfs.sh: failed at line 40
++ '[' -n '' ']'
++ exit 1
=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


Summary of Failures:

1/1 ndctl:cxl / cxl-region-sysfs.sh FAIL             0.71s   exit status =
1

Ok:                 0  =20
Expected Fail:      0  =20
Fail:               1  =20
Unexpected Pass:    0  =20
Skipped:            0  =20
Timeout:            0  =20

