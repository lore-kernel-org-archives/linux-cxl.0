Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9DC26E159
	for <linux-cxl@vger.kernel.org>; Wed, 26 Feb 2025 22:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607468; cv=none; b=JPWwDL2GE5Prac/Mp+NPMFiFxJ0oC8wKaeRqQ6gR2K/4cSKF7SY888PY1FOpAfxA+SUjk9sbTH4lYM9Ew0+d+AFcAJDsWndkcuQjEYlPq1dFb6UQWjVYw538mIKSVDDAwdWPKnagn8E7qAYDOnDtSQHH9R+K8kJG64feTyFx2SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607468; c=relaxed/simple;
	bh=bLyrbov8+zRYlQa3M/+RRf4zL5eOrTluiENrQ5nP4zc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=keXp5CQfl3VLtrTQT1hgmsnVFzHai6EjT4Np6qcKWNzNERvuuTOf3EpDjG9OfPDEGTNNnKDFgI0vH+8yf47m0lZweAGfkIg+dcITg1HTLEm+FX+oS89+U/oGIFY8MN8g0gIr3cJmy7Bx7cvfJmyDOsKJi57G9P3mzDIHaZdOTZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RpQ3pkcU; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RpQ3pkcU"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740607463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6dfyRTWsWpLA8hvTpouFjm+/DTpFQvRv08YR4HcXM4Q=;
	b=RpQ3pkcU21UuVNdWGlqRMSxwX6z4n4HA6l8c7cJ6YY7u2EI7ilZ3NfUqXwZtVi+Mim/Vo3
	aD+gfcKelVMEIy+zYIFQ4P4BXlkjPgrKfqDQDwQxEmUaaNWzzo+H+dbZFJBFgBFnYXC9K6
	v7sfoD8qnZO7BlBfZVCm2bgsexnlpP8=
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: ndctl cxl test suite fails in arm64 QEMU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <8b538927-6825-4e01-a24b-f58b93631829@intel.com>
Date: Thu, 27 Feb 2025 07:04:07 +0900
Cc: Marc Herbert <Marc.Herbert@linux.intel.com>,
 linux-cxl@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <98DAF41D-01E0-4594-B8C9-D8FF046FA19C@linux.dev>
References: <43568B03-6832-4EB1-BF46-EF0F176509E2@linux.dev>
 <9b1492d7-ffa8-4d61-a101-4fa9c2d71ae3@linux.intel.com>
 <AD05AE2B-9AA4-4E60-AEF7-705281368838@linux.dev>
 <8b538927-6825-4e01-a24b-f58b93631829@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
X-Migadu-Flow: FLOW_OUT

Hi,

> On Feb 27, 2025, at 4:30, Dave Jiang <dave.jiang@intel.com> wrote:
>=20
>=20
>=20
> On 2/25/25 3:37 PM, Itaru Kitayama wrote:
>> Hi Marc,
>>=20
>>> On Feb 26, 2025, at 2:08, Marc Herbert =
<Marc.Herbert@linux.intel.com> wrote:
>>>=20
>>> On 2025-02-24 20:09, Itaru Kitayama wrote:
>>>>=20
>>>> Has anyone noticed the ndctl cxl test suite failures I reported =
below on arm64, QEMU emulation?
>>>>=20
>>>> https://github.com/pmem/ndctl/issues/278
>>>>=20
>>>> I=E2=80=99m using Jonathan=E2=80=99s latest CXL capable QEMU [1], =
and the latest CXL kernel [2].
>>>>=20
>>>=20
>>>=20
>>> Hi,
>>>=20
>>> Sorry I wanted to spend more time and share a more detailed answer =
and
>>> of course I got side-tracked.
>>>=20
>>> Do you have CONFIG_RANDOMIZE_MEMORY on?
>>>=20
>>> If yes then please try this either this:
>>>=20
>>> cd kernel
>>> ./scripts/config -d CONFIG_RANDOMIZE_MEMORY
>>>=20
>>> ... or this:
>>>=20
>>> --- a/run_qemu.sh
>>> +++ b/run_qemu.sh
>>> @@ -681,6 +681,7 @@ build_kernel_cmdline()
>>> "initcall_debug"
>>> "log_buf_len=3D20M"
>>> "memory_hotplug.memmap_on_memory=3Dforce"
>>> + "nokaslr"
>>> )
>>> if [[ $_arg_gdb =3D=3D "on" ]]; then
>>> kcmd+=3D(
>>=20
>> I chose the kernel configuration change and rebuilt the kernel, =
modules installed, then finally cxl_test kernel module installed on the =
emulated system, but I got worth results (occasionally, the kernel OOPS =
as well):
>=20
> There's a known lockdep false positive that can trigger and cause =
cxl_test to fail. Does the kernel OOPS go away once you disable lockdep?

Instead of disabling lockdep, pulling cxl next this morning, so far made =
the spurious error go away.

Itaru.

>=20
> DJ
>=20
>>=20
>> Log of Meson test suite run on 2025-02-26T07:32:24.101461
>>=20
>> Inherited environment: LANG=3DC.UTF-8 LS_COLORS=3D'' =
TERM=3Dxterm-256color =
PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/=
bin MAIL=3D/var/mail/root LOGNAME=3Droot USER=3Droot HOME=3D/root =
SHELL=3D/bin/bash SUDO_COMMAND=3D'/usr/bin/meson test =
cxl-region-sysfs.sh' SUDO_USER=3Drealm SUDO_UID=3D1000 SUDO_GID=3D1000=20=

>>=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1/1 =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> test:         ndctl:cxl / cxl-region-sysfs.sh
>> start time:   22:32:24
>> duration:     0.71s
>> result:       exit status 1
>> command:      NDCTL=3D/home/realm/projects/ndctl/build/ndctl/ndctl =
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
>> ----------------------------------- stdout =
-----------------------------------
>> test/cxl-region-sysfs.sh: failed at line 40
>> ----------------------------------- stderr =
-----------------------------------
>> + trap 'err $LINENO' ERR
>> + check_prereq jq
>> + command -v jq
>> + modprobe -r cxl_test
>> + modprobe cxl_test
>> + rc=3D1
>> ++ ./cxl/cxl list -b cxl_test -D -d root
>> ++ jq -r '.[] |
>>  select(.pmem_capable =3D=3D true) |
>>  select(.nr_targets =3D=3D 2) |
>>  .decoder'
>>  Warning: no matching devices found
>>=20
>> + decoder=3D
>> + readarray -t mem
>> ++ ./cxl/cxl list -M -d
>> ++ jq -r '.[].memdev'
>>  Error: switch `d' requires a value
>>=20
>> usage: cxl list [<options>]
>>=20
>>    -d, --decoder <decoder device name>
>>                          filter by CXL decoder device name(s) / class
>> + readarray -t endpoint
>> ++ ./cxl/cxl reserve-dpa -t pmem -s 268435456
>> ++ jq -r '.[] | .decoder.decoder'
>>=20
>> usage: cxl reserve-dpa <mem0> [<mem1>..<memn>] [<options>]
>>=20
>>    -b, --bus <bus name>  Limit operation to the specified bus
>>    -v, --verbose         turn on debug
>>    -S, --serial          use serial numbers to id memdevs
>>    -s, --size <size>     size in bytes (Default: all available =
capacity)
>>    -d, --decoder <decoder instance id>
>>                          override the automatic decoder selection
>>    -t, --type <type>     'pmem' or 'ram' (volatile) (Default: 'pmem')
>>    -f, --force           Attempt 'expected to fail' operations
>>=20
>> ++ cat /sys/bus/cxl/devices//create_pmem_region
>> cat: /sys/bus/cxl/devices//create_pmem_region: No such file or =
directory
>> + region=3D
>> ++ err 40
>> +++ basename /home/realm/projects/ndctl/test/cxl-region-sysfs.sh
>> ++ echo test/cxl-region-sysfs.sh: failed at line 40
>> ++ '[' -n '' ']'
>> ++ exit 1
>> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>>=20
>>=20
>> Summary of Failures:
>>=20
>> 1/1 ndctl:cxl / cxl-region-sysfs.sh FAIL             0.71s   exit =
status 1
>>=20
>> Ok:                 0  =20
>> Expected Fail:      0  =20
>> Fail:               1  =20
>> Unexpected Pass:    0  =20
>> Skipped:            0  =20
>> Timeout:            0  =20


