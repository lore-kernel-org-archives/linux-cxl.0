Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CED2CA6
	for <linux-cxl@vger.kernel.org>; Tue, 25 Mar 2025 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742897719; cv=none; b=uvDpzPIt46OYcMFHtVPyIpCUvu+wIdDqoafLzl2kCe9SfCmgzEUkgeUo16EKhTt5+jIwb15cGZ2WJ+Ocif7/DPpAjvJX8fF2NqVMRnHwFR03qaagQEsTa6YuT61r7Y5HgUWKkzLMh6p5TYSpTKAGXH4rywnzwbH2yoVHpJeBZnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742897719; c=relaxed/simple;
	bh=4iPFTXe+L6jziIEnF83Q4jrEpgEtykq3pb9PYGpmcME=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kXqRF8t8yigL/u9Wzbexlck3RuHxOGs/9Lb6XLkUbQD05ufCs/kESxKsHjWKON7vsY8CPnztm4q/753ALD9u4SDFEj9JhJnU/BBeHYmlGyPFaok+HLDyguqUk2UOxxXI5VUb0szVlBNFxKyF2ZsLYtu8eqbh5aCystncd7sOYis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WyigAgM6; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WyigAgM6"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742897714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I7slmv3tk1IMeSIKAwJUElSlb3+YrO7DlGquM5zYbks=;
	b=WyigAgM61tfB53pHOUDpDvSkVVGsSbU0aua7jm4x48mxoJl1a375djy3YKMfZh61hK/qPg
	LkdfP9b1rPqp/AiTgyloMV7AnHrx7a4Ct/zshG/LbsbNnxCLszS4IYgEr+w+jJsF5fmU7l
	BnWIOjoWSt0FzCcQXDjy9djeyjXSVQg=
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: ndctl cxl test suite fails in arm64 QEMU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <20250313091126.000040db@huawei.com>
Date: Tue, 25 Mar 2025 19:14:47 +0900
Cc: Alison Schofield <alison.schofield@intel.com>,
 linux-cxl@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C7FF28D4-FFBD-4279-B107-7461B0C9A68B@linux.dev>
References: <43568B03-6832-4EB1-BF46-EF0F176509E2@linux.dev>
 <Z75G2UKmx7G59u7P@aschofie-mobl2.lan> <Z8HJbMkV6mzikTI8@vm4>
 <4135507A-DECD-4944-8B39-737A7C90D40A@linux.dev>
 <20250313091126.000040db@huawei.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Migadu-Flow: FLOW_OUT



> On Mar 13, 2025, at 18:11, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>=20
> On Fri, 7 Mar 2025 10:44:23 +0900
> Itaru Kitayama <itaru.kitayama@linux.dev> wrote:
>=20
>> Hi Jonathan, Alison,
>>=20
>>> On Feb 28, 2025, at 23:34, Itaru Kitayama <itaru.kitayama@linux.dev> =
wrote:
>>>=20
>>> On Tue, Feb 25, 2025 at 02:40:25PM -0800, Alison Schofield wrote: =20=

>>>> On Tue, Feb 25, 2025 at 01:09:57PM +0900, Itaru Kitayama wrote: =20
>>>>> Hi,
>>>>>=20
>>>>> Has anyone noticed the ndctl cxl test suite failures I reported =
below on arm64, QEMU emulation?
>>>>>=20
>>>>> https://github.com/pmem/ndctl/issues/278
>>>>>=20
>>>>> I=E2=80=99m using Jonathan=E2=80=99s latest CXL capable QEMU [1], =
and the latest CXL kernel [2]. =20
>>>>=20
>>>> Hi Itaru,
>>>>=20
>>>> Looking at region.c:size_store() it seems that alloc_hpa() is =
failing.
>>>> (kstrtou64 is arch independent and it works for me with same script =
&
>>>> value)
>>>>=20
>>>> Check the dmesg log at the time of the failure. alloc_hpa() may be
>>>> emitting a message.  (In the run_qemu.sh cmdline add '--cxl-debug') =
=20
>>>=20
>>> dynamic debug reported this (kernel is without kaslr, today's =
cxl/next):
>>>=20
>>> [  193.267649] device: 'region4': device_add
>>> [  193.267931] bus: 'cxl': add device region4
>>> [  193.268284] cxl region4: bus: 'cxl': __driver_probe_device: =
matched device with driver cxl_region
>>> [  193.268333] cxl region4: bus: 'cxl': really_probe: probing driver =
cxl_region with device
>>> [  193.268401] cxl_region region4: no default pinctrl state
>>> [  193.268482] cxl_region region4: probe with driver cxl_region =
rejects match -6
>>>=20
>>> does the above show the region4 was not added properly? The sysfs
>>> entries are there after the out of range failure. =20
>>=20
>> The driver/cxl/core/region.c=E2=80=99s size_store() triggers a =
sequence of:=20
>>=20
>> alloc_hpa()
>> alloc_free_mem_region()
>> get_free_mem_region() // with flags set to 0, retruns -ERANGE
>>=20
>> While I am looking at the resource core code, do you think this is =
caused by the old firmware I am using
>> when booting QEMU built off of your CXL topic branch? Suggestions are =
welcome.
> Unlikely as I don't think there have been any relevant changes in edk2 =
for
> a long long time.

I am trying to run the run_qemu.sh script which is maintained by the =
Intel CXL folk with:

$ qemu=3D$HOME/projects/qemu/build/qemu-system-aarch64 run_qemu.sh =
--roots ~/ubuntu24.img -r none --no-cxl --no-kvm  --hmat

and I get:

mkosi 12
/home/itaru/projects/qemu/build/qemu-system-aarch64 -machine =
virt,accel=3Dtcg,nvdimm=3Don,hmat=3Don -m 8192M,slots=3D4,maxmem=3D40964M =
-smp 4,sockets=3D2,cores=3D2,threads=3D1 -display none -nographic -drive =
if=3Dpflash,format=3Draw,unit=3D0,file=3D/home/itaru/edk2-aarch64-code.fd,=
readonly=3Don -drive =
if=3Dpflash,format=3Draw,unit=3D1,file=3D/home/itaru/qemu-arm64-efivars.te=
st -drive file=3D/home/itaru/ubuntu24.img,format=3Draw,media=3Ddisk =
-device e1000,netdev=3Dnet0,mac=3D52:54:00:12:34:56 -netdev =
user,id=3Dnet0,hostfwd=3Dtcp::10022-:22 -snapshot -object =
memory-backend-ram,id=3Dmem0,size=3D2048M -numa =
node,nodeid=3D0,memdev=3Dmem0,initiator=3D0 -numa =
cpu,node-id=3D0,socket-id=3D0 -object =
memory-backend-ram,id=3Dmem1,size=3D2048M -numa =
node,nodeid=3D1,memdev=3Dmem1,initiator=3D1 -numa =
cpu,node-id=3D1,socket-id=3D1 -object =
memory-backend-ram,id=3Dmem2,size=3D2048M -numa =
node,nodeid=3D2,memdev=3Dmem2,initiator=3D0 -object =
memory-backend-ram,id=3Dmem3,size=3D2048M -numa =
node,nodeid=3D3,memdev=3Dmem3,initiator=3D1 -numa =
node,nodeid=3D4,initiator=3D0 -object =
memory-backend-file,id=3Dnvmem0,share=3Don,mem-path=3Dnvdimm-0,size=3D1638=
4M,align=3D1G -device nvdimm,memdev=3Dnvmem0,id=3Dnv0,label-size=3D2M,node=
=3D4 -numa node,nodeid=3D5,initiator=3D1 -object =
memory-backend-file,id=3Dnvmem1,share=3Don,mem-path=3Dnvdimm-1,size=3D1638=
4M,align=3D1G -device nvdimm,memdev=3Dnvmem1,id=3Dnv1,label-size=3D2M,node=
=3D5 -numa dist,src=3D0,dst=3D0,val=3D10 -numa dist,src=3D0,dst=3D1,val=3D=
21 -numa dist,src=3D0,dst=3D2,val=3D12 -numa dist,src=3D0,dst=3D3,val=3D21=
 -numa dist,src=3D0,dst=3D4,val=3D17 -numa dist,src=3D0,dst=3D5,val=3D28 =
-numa dist,src=3D1,dst=3D1,val=3D10 -numa dist,src=3D1,dst=3D2,val=3D21 =
-numa dist,src=3D1,dst=3D3,val=3D12 -numa dist,src=3D1,dst=3D4,val=3D28 =
-numa dist,src=3D1,dst=3D5,val=3D17 -numa dist,src=3D2,dst=3D2,val=3D10 =
-numa dist,src=3D2,dst=3D3,val=3D21 -numa dist,src=3D2,dst=3D4,val=3D28 =
-numa dist,src=3D2,dst=3D5,val=3D28 -numa dist,src=3D3,dst=3D3,val=3D10 =
-numa dist,src=3D3,dst=3D4,val=3D28 -numa dist,src=3D3,dst=3D5,val=3D28 =
-numa dist,src=3D4,dst=3D4,val=3D10 -numa dist,src=3D4,dst=3D5,val=3D28 =
-numa dist,src=3D5,dst=3D5,val=3D10 -numa =
hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Daccess-lat=
ency,latency=3D5 -numa =
hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Daccess-ban=
dwidth,bandwidth=3D2000M -numa =
hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Daccess-lat=
ency,latency=3D20 -numa =
hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Daccess-ban=
dwidth,bandwidth=3D1000M -numa =
hmat-lb,initiator=3D0,target=3D2,hierarchy=3Dmemory,data-type=3Daccess-lat=
ency,latency=3D10 -numa =
hmat-lb,initiator=3D0,target=3D2,hierarchy=3Dmemory,data-type=3Daccess-ban=
dwidth,bandwidth=3D1500M -numa =
hmat-lb,initiator=3D0,target=3D3,hierarchy=3Dmemory,data-type=3Daccess-lat=
ency,latency=3D20 -numa =
hmat-lb,initiator=3D0,target=3D3,hierarchy=3Dmemory,data-type=3Daccess-ban=
dwidth,bandwidth=3D1000M -numa =
hmat-lb,initiator=3D0,target=3D4,hierarchy=3Dmemory,data-type=3Daccess-lat=
ency,latency=3D30 -numa =
hmat-lb,initiator=3D0,target=3D4,hierarchy=3Dmemory,data-type=3Daccess-ban=
dwidth,bandwidth=3D1000M -numa =
hmat-lb,initiator=3D0,target=3D5,hierarchy=3Dmemory,data-type=3Daccess-lat=
ency,latency=3D40 -numa =
hmat-lb,initiator=3D0,target=3D5,hierarchy=3Dmemory,data-type=3Daccess-ban=
dwidth,bandwidth=3D500M -numa =
hmat-cache,node-id=3D0,size=3D10K,level=3D1,associativity=3Ddirect,policy=3D=
write-back,line=3D64 -numa =
hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Daccess-lat=
ency,latency=3D20 -numa =
hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Daccess-ban=
dwidth,bandwidth=3D1000M -numa =
hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Daccess-lat=
ency,latency=3D5 -numa =
hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Daccess-ban=
dwidth,bandwidth=3D2000M -numa =
hmat-lb,initiator=3D1,target=3D2,hierarchy=3Dmemory,data-type=3Daccess-lat=
ency,latency=3D20 -numa =
hmat-lb,initiator=3D1,target=3D2,hierarchy=3Dmemory,data-type=3Daccess-ban=
dwidth,bandwidth=3D1000M -numa =
hmat-lb,initiator=3D1,target=3D3,hierarchy=3Dmemory,data-type=3Daccess-lat=
ency,latency=3D10 -numa =
hmat-lb,initiator=3D1,target=3D3,hierarchy=3Dmemory,data-type=3Daccess-ban=
dwidth,bandwidth=3D1500M -numa =
hmat-lb,initiator=3D1,target=3D4,hierarchy=3Dmemory,data-type=3Daccess-lat=
ency,latency=3D40 -numa =
hmat-lb,initiator=3D1,target=3D4,hierarchy=3Dmemory,data-type=3Daccess-ban=
dwidth,bandwidth=3D500M -numa =
hmat-lb,initiator=3D1,target=3D5,hierarchy=3Dmemory,data-type=3Daccess-lat=
ency,latency=3D30 -numa =
hmat-lb,initiator=3D1,target=3D5,hierarchy=3Dmemory,data-type=3Daccess-ban=
dwidth,bandwidth=3D1000M -numa =
hmat-cache,node-id=3D1,size=3D10K,level=3D1,associativity=3Ddirect,policy=3D=
write-back,line=3D64
qemu-system-aarch64: -device =
nvdimm,memdev=3Dnvmem0,id=3Dnv0,label-size=3D2M,node=3D4: memory hotplug =
is not enabled: missing acpi-ged device

QEMU is built off of your latest update, and I could not find the =
acpi-ged device what do I do?

Thanks,
Itaru.

>=20
> Jonathan
>=20
>>=20
>> Itaru.=20
>>=20
>>>=20
>>> Itaru.
>>>=20
>>>>=20
>>>> Sounds like Marc is on to something and maybe the KASLR is known
>>>> to cause this problem.
>>>>=20
>>>> Thanks for posting to this list and send any further questions or
>>>> comments. Happy to have you using run_qemu.sh and the cxl tests!
>>>>=20
>>>> Alison
>>>>=20
>>>>=20
>>>>>=20
>>>>> [1] https://gitlab.com/jic23/qemu/ cxl-2025-02-20
>>>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/
>>>>>=20
>>>>> Thanks,
>>>>> Itaru. =20


