Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFD62561D6
	for <linux-cxl@vger.kernel.org>; Wed, 26 Feb 2025 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607652; cv=none; b=iaNJoTzora96/oEHm/5EDIqdZLzAPANJSqWEjZGFTZ3kXG7R9q1KfRoR525j3+QQgMccld/y5I+vRe4FjMHBhaH3D1BltC7GyJsMgTAZxYE/uHy65itJuR8xqlh6YaQ4/FRskviLcVjen7Gfz62Ysw1VWmuT6FW3zLAfcPm0Lzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607652; c=relaxed/simple;
	bh=dcm+ETNVtmA/WYGg2gNwvpq5i28IO9C5g89U3kn7D0I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FKNH1bxtxfRBQcnWUtLyLrk7T1Nz3bdbdekT08eRRWoWM4HVxnk3lLD67EDr0rfObXwWLtHuYMC9ZHtWiMqhM4KHrgFEOjGlEwX3/AWM1BoqaouDOv86xNsd2k6zUONnCsYuNDub+3bMGAnmUET5xcVA4g43ymgMe6HInRiWuy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y7YQ+SX3; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y7YQ+SX3"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740607647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lQ4AGSalYh+hETuox+eE+LFUu/Gd8ek6p1w1jAQ7WA=;
	b=Y7YQ+SX3bo2P8oC93QDo/Gu8CN0kF5RiCYDEpe+PegEDyXbZRtwj14OZHGtGZSxkxD0eYv
	MXsuIIfklsKR4b+fCgk/8yh6wJigcK45blnjnNw+sk16zcJeXiOQ5eSuaTAofkwZa0Z/pp
	jCjegzL/J8M/lsLIKrnvf9JP4YrREeM=
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: ndctl cxl test suite fails in arm64 QEMU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <Z79hPyNMymvM9Hlp@aschofie-mobl2.lan>
Date: Thu, 27 Feb 2025 07:07:13 +0900
Cc: Marc Herbert <Marc.Herbert@linux.intel.com>,
 linux-cxl@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD7BD8C3-7BB7-47E6-A296-D7939A322B27@linux.dev>
References: <43568B03-6832-4EB1-BF46-EF0F176509E2@linux.dev>
 <9b1492d7-ffa8-4d61-a101-4fa9c2d71ae3@linux.intel.com>
 <AD05AE2B-9AA4-4E60-AEF7-705281368838@linux.dev>
 <Z75IpiYqA1sylXYx@aschofie-mobl2.lan>
 <CE9B21EB-B7D5-4E40-901C-306689C4B4FA@linux.dev>
 <Z79hPyNMymvM9Hlp@aschofie-mobl2.lan>
To: Alison Schofield <alison.schofield@intel.com>
X-Migadu-Flow: FLOW_OUT



> On Feb 27, 2025, at 3:45, Alison Schofield =
<alison.schofield@intel.com> wrote:
>=20
> On Wed, Feb 26, 2025 at 08:53:12AM +0900, Itaru Kitayama wrote:
>> Hi Alison,
>>=20
>>> On Feb 26, 2025, at 7:48, Alison Schofield =
<alison.schofield@intel.com> wrote:
>>>=20
>>> On Wed, Feb 26, 2025 at 07:37:58AM +0900, Itaru Kitayama wrote:
>>>> Hi Marc,
>>>>=20
>>>>> On Feb 26, 2025, at 2:08, Marc Herbert =
<Marc.Herbert@linux.intel.com> wrote:
>>>>>=20
>>>>> On 2025-02-24 20:09, Itaru Kitayama wrote:
>>>>>>=20
>>>>>> Has anyone noticed the ndctl cxl test suite failures I reported =
below on arm64, QEMU emulation?
>>>>>>=20
>>>>>> https://github.com/pmem/ndctl/issues/278
>>>>>>=20
>>>>>> I=E2=80=99m using Jonathan=E2=80=99s latest CXL capable QEMU [1], =
and the latest CXL kernel [2].
>>>>>>=20
>>>>>=20
>>>>>=20
>>>>> Hi,
>>>>>=20
>>>>> Sorry I wanted to spend more time and share a more detailed answer =
and
>>>>> of course I got side-tracked.
>>>>>=20
>>>>> Do you have CONFIG_RANDOMIZE_MEMORY on?
>>>>>=20
>>>>> If yes then please try this either this:
>>>>>=20
>>>>> cd kernel
>>>>> ./scripts/config -d CONFIG_RANDOMIZE_MEMORY
>>>>>=20
>>>>> ... or this:
>>>>>=20
>>>>> --- a/run_qemu.sh
>>>>> +++ b/run_qemu.sh
>>>>> @@ -681,6 +681,7 @@ build_kernel_cmdline()
>>>>> "initcall_debug"
>>>>> "log_buf_len=3D20M"
>>>>> "memory_hotplug.memmap_on_memory=3Dforce"
>>>>> + "nokaslr"
>>>>> )
>>>>> if [[ $_arg_gdb =3D=3D "on" ]]; then
>>>>> kcmd+=3D(
>>>>=20
>>>> I chose the kernel configuration change and rebuilt the kernel, =
modules installed, then finally cxl_test kernel module installed on the =
emulated system, but I got worth results (occasionally, the kernel OOPS =
as well):
>>>=20
>>> Yikes.
>>>=20
>>> What is your ndctl --version
>>=20
>> I=E2=80=99m using GitHub=E2=80=99s latest.
>>=20
>>>=20
>>> What is your run_qemu cmdline?
>>=20
>> Unfortunately, it is x86 centric, at this moment it=E2=80=99s hard to =
use.
>>=20
>>> I think you said kernel is cxl/next ?
>>=20
>> Yes, I did.
>>=20
>>>=20
>>> The simplest one when I intend to use cxl-test is:
>>> run_qemu.sh --git-qemu --cxl-test --cxl-debug -r kmod
>>=20
>> Instead, here are the options I use when emulating on arm64:
>>=20
>> /home/itaru/projects/qemu/build/qemu-system-aarch64 \
>>         -M =
virt,virtualization=3Doff,pflash0=3Drom,pflash1=3Defivars,gic-version=3D3,=
cxl=3Don,acpi=3Don -m 16384 \
>>         -cpu max \
>>         -smp 2 \
>>         -accel tcg \
>>         -nographic \
>>         -display none \
>>         -kernel $HOME/projects/linux/arch/arm64/boot/Image \
>>         -append "root=3D/dev/vda rw acpi=3Dforce" \
>>         -drive =
format=3Draw,if=3Dnone,file=3D/home/itaru/ubuntu24.img,id=3Dhd0 \
>>         -device virtio-blk-pci,drive=3Dhd0,serial=3D"dummyserial" \
>>         -nodefaults \
>>         -device virtio-net-pci,netdev=3Dnet0 \
>>         -netdev user,id=3Dnet0,hostfwd=3Dtcp::8024-:22 \
>>         -blockdev =
node-name=3Drom,driver=3Dfile,filename=3Dedk2-aarch64-code.fd,read-only=3D=
true \
>>         -blockdev =
node-name=3Defivars,driver=3Dfile,filename=3Dqemu-arm64-efivars.test \
>>         -object =
memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-path=3D/tmp/cxltest.raw,s=
ize=3D256M \
>>         -object =
memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/tmp/lsa.raw,size=3D=
256M \
>>         -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
>>         -device =
cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=3D2 \
>>         -device =
cxl-type3,bus=3Droot_port13,memdev=3Dcxl-mem1,lsa=3Dcxl-lsa1,id=3Dcxl-pmem=
0 \
>>         -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G \
>>         -serial mon:stdio \
>>         -device virtio-9p-device,fsdev=3Dshr0,mount_tag=3Dshr0 \
>>         -fsdev local,security_model=3Dnone,path=3D/home/itaru,id=3Dshr0=

>>=20
>> Thanks,
>> Itaru.
>=20
> Hi Itaru,
>=20
> I am able to reproduce your original issue on x86. It occurs, like =
Marc
> suggested, when RANDOMIZE_MEMORY is enabled. (The nokaslr kernel param
> disables both RANDOMIZE_BASE and RANDOMIZE_MEMORY in x86.)
>=20
> Poking around arm64 related configs, it doesn't have a direct =
equivalent
> to RANDOMIZE_MEMORY. Maybe ARM64_MODULE_PLTS or =
RANDOMIZE_MODULE_REGION_FULL,
> both of which seem to affect how modules are loaded into memory are=20
> causing the problem.
>=20
> Are you familiar with those, able to try those out?

I did disable as much as I can see those address randomizations in the =
arm64 config, and now I get:

[  333.304967] cxl_mock_mem cxl_mem.0: probe with driver cxl_mock_mem =
failed with error -95
[  333.337294] cxl_mock_mem cxl_mem.1: probe with driver cxl_mock_mem =
failed with error -95
[  333.353640] cxl_mock_mem cxl_mem.3: probe with driver cxl_mock_mem =
failed with error -95
[  333.384297] cxl_mock_mem cxl_mem.4: probe with driver cxl_mock_mem =
failed with error -95
[  333.402259] cxl_mock_mem cxl_mem.6: probe with driver cxl_mock_mem =
failed with error -95
[  333.483253] cxl_mock_mem cxl_mem.9: probe with driver cxl_mock_mem =
failed with error -95
[  333.520117] cxl_mock_mem cxl_rcd.10: probe with driver cxl_mock_mem =
failed with error -95
[  333.617582] cxl_mock_mem cxl_mem.2: probe with driver cxl_mock_mem =
failed with error -95
[  333.669481] cxl_mock_mem cxl_mem.5: probe with driver cxl_mock_mem =
failed with error -95
[  333.711813] cxl_mock_mem cxl_mem.7: probe with driver cxl_mock_mem =
failed with error -95
[  333.745580] cxl_mock_mem cxl_mem.8: probe with driver cxl_mock_mem =
failed with error -95

Itaru.

>=20
> --Alison
>=20
>>=20
>>>=20
>>>>=20
>>>> Log of Meson test suite run on 2025-02-26T07:32:24.101461
>>>>=20
>>>> Inherited environment: LANG=3DC.UTF-8 LS_COLORS=3D'' =
TERM=3Dxterm-256color =
PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/=
bin MAIL=3D/var/mail/root LOGNAME=3Droot USER=3Droot HOME=3D/root =
SHELL=3D/bin/bash SUDO_COMMAND=3D'/usr/bin/meson test =
cxl-region-sysfs.sh' SUDO_USER=3Drealm SUDO_UID=3D1000 SUDO_GID=3D1000=20=

>>>>=20
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1/1 =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> test:         ndctl:cxl / cxl-region-sysfs.sh
>>>> start time:   22:32:24
>>>> duration:     0.71s
>>>> result:       exit status 1
>>>> command:      NDCTL=3D/home/realm/projects/ndctl/build/ndctl/ndctl =
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
>>>> ----------------------------------- stdout =
-----------------------------------
>>>> test/cxl-region-sysfs.sh: failed at line 40
>>>> ----------------------------------- stderr =
-----------------------------------
>>>> + trap 'err $LINENO' ERR
>>>> + check_prereq jq
>>>> + command -v jq
>>>> + modprobe -r cxl_test
>>>> + modprobe cxl_test
>>>> + rc=3D1
>>>> ++ ./cxl/cxl list -b cxl_test -D -d root
>>>> ++ jq -r '.[] |
>>>> select(.pmem_capable =3D=3D true) |
>>>> select(.nr_targets =3D=3D 2) |
>>>> .decoder'
>>>> Warning: no matching devices found
>>>>=20
>>>> + decoder=3D
>>>> + readarray -t mem
>>>> ++ ./cxl/cxl list -M -d
>>>> ++ jq -r '.[].memdev'
>>>> Error: switch `d' requires a value
>>>>=20
>>>> usage: cxl list [<options>]
>>>>=20
>>>>   -d, --decoder <decoder device name>
>>>>                         filter by CXL decoder device name(s) / =
class
>>>> + readarray -t endpoint
>>>> ++ ./cxl/cxl reserve-dpa -t pmem -s 268435456
>>>> ++ jq -r '.[] | .decoder.decoder'
>>>>=20
>>>> usage: cxl reserve-dpa <mem0> [<mem1>..<memn>] [<options>]
>>>>=20
>>>>   -b, --bus <bus name>  Limit operation to the specified bus
>>>>   -v, --verbose         turn on debug
>>>>   -S, --serial          use serial numbers to id memdevs
>>>>   -s, --size <size>     size in bytes (Default: all available =
capacity)
>>>>   -d, --decoder <decoder instance id>
>>>>                         override the automatic decoder selection
>>>>   -t, --type <type>     'pmem' or 'ram' (volatile) (Default: =
'pmem')
>>>>   -f, --force           Attempt 'expected to fail' operations
>>>>=20
>>>> ++ cat /sys/bus/cxl/devices//create_pmem_region
>>>> cat: /sys/bus/cxl/devices//create_pmem_region: No such file or =
directory
>>>> + region=3D
>>>> ++ err 40
>>>> +++ basename /home/realm/projects/ndctl/test/cxl-region-sysfs.sh
>>>> ++ echo test/cxl-region-sysfs.sh: failed at line 40
>>>> ++ '[' -n '' ']'
>>>> ++ exit 1
>>>> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>>>>=20
>>>>=20
>>>> Summary of Failures:
>>>>=20
>>>> 1/1 ndctl:cxl / cxl-region-sysfs.sh FAIL             0.71s   exit =
status 1
>>>>=20
>>>> Ok:                 0  =20
>>>> Expected Fail:      0  =20
>>>> Fail:               1  =20
>>>> Unexpected Pass:    0  =20
>>>> Skipped:            0  =20
>>>> Timeout:            0  =20


