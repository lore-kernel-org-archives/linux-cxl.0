Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A9213C81B
	for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747865263; cv=none; b=rqRRx1eaMWIXLcbHCyfZb3xeMaQjbZ+ufjps/rKWPADwzYyNGTIlclsyM7CMDxBysw1XQaNSCc8f2RicomgltbjGOjYLMrEySP7Rz4EL62HDUwWGiskf24D4V8kwkPBMSKi2iacpDryaILmYFZxYuqB8B1jqdM+/crwUFvpteGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747865263; c=relaxed/simple;
	bh=4CNOnvMTXwbvJE5Axi4lmZQe3Q6s6pFTASSznYhVyMA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mJZSOmKB35jYUqvh+aXYPOho3qB9piwTYLrjm6yRc/4Vv9mKPCZTkwsx2LRNE6WbucxyOE4QemH1VxmcyYtrIcNHz92iQg1ksgwdQLezr6N6AbqftE4ekrJt6WrEakiVoEr2z8nw9vdVnTA+LLxY5nKCZAW4QtukIsbrsJ80GtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CqyDfhzn; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CqyDfhzn"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747865257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1vLkAUBDYK3sNFDLMY9liH8VgjHaEs3+UBhEp1Fq4WI=;
	b=CqyDfhzncjx2qOGH7QMBE0DnkKIhKwClintTwwFWVE+TnqtLWS+6MDhn88rB16i6ShxHFw
	nNnV+ztdFclH6SXino4FyJ0yl9GhiU4rDA+ReldED4TmO0ikGoJVzyf2poOeL7WAyhRuBE
	7ZU4WiTDGzJYiGZeVVveCFxr4dqdYc8=
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v13 5/5] qtest/cxl: Add aarch64 virt test for CXL
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <20250521185231.00005e4a@huawei.com>
Date: Thu, 22 May 2025 07:07:17 +0900
Cc: qemu-devel@nongnu.org,
 Fan Ni <fan.ni@samsung.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 mst@redhat.com,
 linux-cxl@vger.kernel.org,
 linuxarm@huawei.com,
 qemu-arm@nongnu.org,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <277C5799-872A-4A63-887B-92540FD63DDB@linux.dev>
References: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
 <20250513111455.128266-6-Jonathan.Cameron@huawei.com>
 <D9E503CC-1271-4008-9975-9BAEC7A33376@linux.dev>
 <20250519135413.000026b4@huawei.com>
 <5CCC3C8C-7348-4409-9964-8367C8FC1C1E@linux.dev>
 <20250521185231.00005e4a@huawei.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Migadu-Flow: FLOW_OUT



> On May 22, 2025, at 2:52, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>=20
> On Wed, 21 May 2025 16:38:10 +0900
> Itaru Kitayama <itaru.kitayama@linux.dev> wrote:
>=20
>>> On May 19, 2025, at 21:54, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>>>=20
>>> On Thu, 15 May 2025 18:04:18 +0900
>>> Itaru Kitayama <itaru.kitayama@linux.dev> wrote:
>>>=20
>>>>> On May 13, 2025, at 20:14, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>>>>>=20
>>>>> Add a single complex case for aarch64 virt machine.
>>>>> Given existing much more comprehensive tests for x86 cover the
>>>>> common functionality, a single test should be enough to verify
>>>>> that the aarch64 part continue to work.
>>>>>=20
>>>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>> ---
>>>>> tests/qtest/cxl-test.c  | 59 =
++++++++++++++++++++++++++++++++---------
>>>>> tests/qtest/meson.build |  1 +
>>>>> 2 files changed, 47 insertions(+), 13 deletions(-)
>>>>>=20
>>>>> diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
>>>>> index a600331843..c7189d6222 100644
>>>>> --- a/tests/qtest/cxl-test.c
>>>>> +++ b/tests/qtest/cxl-test.c
>>>>> @@ -19,6 +19,12 @@
>>>>>   "-device pxb-cxl,id=3Dcxl.1,bus=3Dpcie.0,bus_nr=3D53 " \
>>>>>   "-M =
cxl-fmw.0.targets.0=3Dcxl.0,cxl-fmw.0.targets.1=3Dcxl.1,cxl-fmw.0.size=3D4=
G "
>>>>>=20
>>>>> +#define QEMU_VIRT_2PXB_CMD \
>>>>> +    "-machine virt,cxl=3Don -cpu max " \
>>>>> +    "-device pxb-cxl,id=3Dcxl.0,bus=3Dpcie.0,bus_nr=3D52 " \
>>>>> +    "-device pxb-cxl,id=3Dcxl.1,bus=3Dpcie.0,bus_nr=3D53 " \
>>>>> +    "-M =
cxl-fmw.0.targets.0=3Dcxl.0,cxl-fmw.0.targets.1=3Dcxl.1,cxl-fmw.0.size=3D4=
G "
>>>>> +
>>>>> #define QEMU_RP \
>>>>>   "-device cxl-rp,id=3Drp0,bus=3Dcxl.0,chassis=3D0,slot=3D0 "
>>>>>=20
>>>>> @@ -197,25 +203,52 @@ static void cxl_2pxb_4rp_4t3d(void)
>>>>>   qtest_end();
>>>>>   rmdir(tmpfs);
>>>>> }
>>>>> +
>>>>> +static void cxl_virt_2pxb_4rp_4t3d(void)
>>>>> +{
>>>>> +    g_autoptr(GString) cmdline =3D g_string_new(NULL);
>>>>> +    char template[] =3D "/tmp/cxl-test-XXXXXX";
>>>>> +    const char *tmpfs;
>>>>> +
>>>>> +    tmpfs =3D mkdtemp(template);
>>>>> +
>>>>> +    g_string_printf(cmdline, QEMU_VIRT_2PXB_CMD QEMU_4RP =
QEMU_4T3D,
>>>>> +                    tmpfs, tmpfs, tmpfs, tmpfs, tmpfs, tmpfs,
>>>>> +                    tmpfs, tmpfs);
>>>>> +
>>>>> +    qtest_start(cmdline->str);
>>>>> +    qtest_end();
>>>>> +    rmdir(tmpfs);
>>>>> +}
>>>>> #endif /* CONFIG_POSIX */
>>>>>=20
>>>>> int main(int argc, char **argv)
>>>>> {
>>>>> -    g_test_init(&argc, &argv, NULL);
>>>>> +    const char *arch =3D qtest_get_arch();
>>>>>=20
>>>>> -    qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
>>>>> -    qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
>>>>> -    qtest_add_func("/pci/cxl/pxb_with_window", =
cxl_pxb_with_window);
>>>>> -    qtest_add_func("/pci/cxl/pxb_x2_with_window", =
cxl_2pxb_with_window);
>>>>> -    qtest_add_func("/pci/cxl/rp", cxl_root_port);
>>>>> -    qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
>>>>> +    g_test_init(&argc, &argv, NULL);
>>>>> +    if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =
=3D=3D 0) {
>>>>> +        qtest_add_func("/pci/cxl/basic_hostbridge", =
cxl_basic_hb);
>>>>> +        qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
>>>>> +        qtest_add_func("/pci/cxl/pxb_with_window", =
cxl_pxb_with_window);
>>>>> +        qtest_add_func("/pci/cxl/pxb_x2_with_window", =
cxl_2pxb_with_window);
>>>>> +        qtest_add_func("/pci/cxl/rp", cxl_root_port);
>>>>> +        qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
>>>>> #ifdef CONFIG_POSIX
>>>>> -    qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
>>>>> -    qtest_add_func("/pci/cxl/type3_device_pmem", =
cxl_t3d_persistent);
>>>>> -    qtest_add_func("/pci/cxl/type3_device_vmem", =
cxl_t3d_volatile);
>>>>> -    qtest_add_func("/pci/cxl/type3_device_vmem_lsa", =
cxl_t3d_volatile_lsa);
>>>>> -    qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
>>>>> -    qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4", =
cxl_2pxb_4rp_4t3d);
>>>>> +        qtest_add_func("/pci/cxl/type3_device", =
cxl_t3d_deprecated);
>>>>> +        qtest_add_func("/pci/cxl/type3_device_pmem", =
cxl_t3d_persistent);
>>>>> +        qtest_add_func("/pci/cxl/type3_device_vmem", =
cxl_t3d_volatile);
>>>>> +        qtest_add_func("/pci/cxl/type3_device_vmem_lsa", =
cxl_t3d_volatile_lsa);
>>>>> +        qtest_add_func("/pci/cxl/rp_x2_type3_x2", =
cxl_1pxb_2rp_2t3d);
>>>>> +        qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4",
>>>>> +                       cxl_2pxb_4rp_4t3d);
>>>>> #endif
>>>>> +    } else if (strcmp(arch, "aarch64") =3D=3D 0) {
>>>>> +#ifdef CONFIG_POSIX
>>>>> +        =
qtest_add_func("/pci/cxl/virt/pxb_x2_root_port_x4_type3_x4",
>>>>> +                       cxl_virt_2pxb_4rp_4t3d);
>>>>> +#endif
>>>>> +    }
>>>>> +
>>>>>   return g_test_run();
>>>>> }
>>>>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>>>>> index 7daf619845..361000267a 100644
>>>>> --- a/tests/qtest/meson.build
>>>>> +++ b/tests/qtest/meson.build
>>>>> @@ -258,6 +258,7 @@ qtests_aarch64 =3D \
>>>>> (config_all_accel.has_key('CONFIG_TCG') and                        =
                    \
>>>>>  config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? =
['tpm-tis-i2c-test'] : []) + \
>>>>> (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 =
: []) + \
>>>>> +  qtests_cxl +                                                    =
                              \
>>>>> ['arm-cpu-features',
>>>>>  'numa-test',
>>>>>  'boot-serial-test',
>>>>> --=20
>>>>> 2.43.0
>>>>>=20
>>>>=20
>>>> ~/projects/qemu/build$ meson test qtest-aarch64/cxl-test
>>>> ninja: Entering directory `/home/realm/projects/qemu/build'
>>>> [1/8] Generating qemu-version.h with a custom command (wrapped by =
meson to capture output)
>>>> 1/1 qemu:qtest+qtest-aarch64 / qtest-aarch64/cxl-test        OK     =
         0.17s   1 subtests passed
>>>>=20
>>>> Ok:                 1
>>>> Expected Fail:      0
>>>> Fail:               0
>>>> Unexpected Pass:    0
>>>> Skipped:            0
>>>> Timeout:            0
>>>>=20
>>>> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com =
<mailto:itaru.kitayama@fujitsu.com>>
>>>>=20
>>>> Jonathan, would you push your branch this series applied? I =
manually applied your series no issues though. =20
>>>=20
>>> I'm reluctant to push a 'normal' staging CXL tree whilst we have the =
TCG
>>> issue outstanding (which is in mainline).
>>> I can probably push one with a name that makes it clear we know it =
will
>>> crash under some circumstances though. I'll aim to get that done =
later this week.
>>>=20
>>> After talking to Richard Henderson I'm going to spin some images etc =
to
>>> make it easier for him to replicate that TCG issue. =20
>>=20
>> While QEMU (the kernel is built off of cxl branch) boots fine and =
lspci shows CXL devices as shown:
>>=20
>> root@localhost:~# lspci -mm
>> 00:00.0 "Host bridge" "Red Hat, Inc." "QEMU PCIe Host bridge" -p00 =
"Red Hat, Inc." "Device 1100"
>> 00:01.0 "SCSI storage controller" "Red Hat, Inc." "Virtio block =
device" -p00 "Red Hat, Inc." "Device 0002"
>> 00:02.0 "Ethernet controller" "Intel Corporation" "82540EM Gigabit =
Ethernet Controller" -r03 -p00 "Red Hat, Inc." "QEMU Virtual Machine"
>> 00:03.0 "Host bridge" "Red Hat, Inc." "QEMU PCIe Expander bridge" =
-p00 "Red Hat, Inc." "Device 1100"
>> 00:04.0 "Host bridge" "Red Hat, Inc." "QEMU PCIe Expander bridge" =
-p00 "Red Hat, Inc." "Device 1100"
>> 35:00.0 "PCI bridge" "Intel Corporation" "Device 7075" -p00 "Intel =
Corporation" "Device 0000"
>> 35:01.0 "PCI bridge" "Intel Corporation" "Device 7075" -p00 "Intel =
Corporation" "Device 0000"
>> 36:00.0 "PCI bridge" "Huawei Technologies Co., Ltd." "Device a128" =
-p00 "" ""
>> 36:00.1 "Serial bus controller [0c0b]" "Huawei Technologies Co., =
Ltd." "Device a123" -p00 "Red Hat, Inc." "Device 1100"
>> 37:00.0 "PCI bridge" "Huawei Technologies Co., Ltd." "Device a129" =
-p00 "" ""
>> 37:01.0 "PCI bridge" "Huawei Technologies Co., Ltd." "Device a129" =
-p00 "" ""
>> 37:02.0 "PCI bridge" "Huawei Technologies Co., Ltd." "Device a129" =
-p00 "" ""
>> 37:03.0 "PCI bridge" "Huawei Technologies Co., Ltd." "Device a129" =
-p00 "" ""
>> 38:00.0 "CXL" "Intel Corporation" "Device 0d93" -r01 -p10 "Red Hat, =
Inc." "Device 1100"
>> 3a:00.0 "CXL" "Intel Corporation" "Device 0d93" -r01 -p10 "Red Hat, =
Inc." "Device 1100"
>> bf:00.0 "PCI bridge" "Intel Corporation" "Device 7075" -p00 "Intel =
Corporation" "Device 0000"
>> bf:01.0 "PCI bridge" "Intel Corporation" "Device 7075" -p00 "Intel =
Corporation" "Device 0000"
>> c0:00.0 "PCI bridge" "Huawei Technologies Co., Ltd." "Device a128" =
-p00 "" ""
>> c0:00.1 "Serial bus controller [0c0b]" "Huawei Technologies Co., =
Ltd." "Device a123" -p00 "Red Hat, Inc." "Device 1100"
>> c1:00.0 "PCI bridge" "Huawei Technologies Co., Ltd." "Device a129" =
-p00 "" ""
>> c1:01.0 "PCI bridge" "Huawei Technologies Co., Ltd." "Device a129" =
-p00 "" ""
>> c1:02.0 "PCI bridge" "Huawei Technologies Co., Ltd." "Device a129" =
-p00 "" ""
>> c1:03.0 "PCI bridge" "Huawei Technologies Co., Ltd." "Device a129" =
-p00 "" ""
>> c2:00.0 "CXL" "Intel Corporation" "Device 0d93" -r01 -p10 "Red Hat, =
Inc." "Device 1100"
>> c4:00.0 "CXL" "Intel Corporation" "Device 0d93" -r01 -p10 "Red Hat, =
Inc." "Device 1100=E2=80=9D
>>=20
>> but the cxl-list command takes 5-10 minutes to return the =
information. I=E2=80=99ll test with your qtest minimalist setup to see =
if the system is loaded. Am I seeing the TCG issue you mentioned?
>=20
> I don't think so. That should only matter if the memory is hotplugged =
in
> as normal system RAM.
>=20
>>=20
>> root@localhost:~# cxl list -M
>> [
>>  {
>>    "memdev":"mem10",
>>    "ram_size":2147483648,
>>    "ram_qos_class":42,
>>    "serial":11,
>>    "numa_node":0,
>>    "host":"cxl_rcd.10",
>>    "firmware_version":"mock fw v1 "
>=20
> So this seems to be with both some emulated devices from qemu command =
line
> and CXL test at the same time.=20
>=20
> I replicated a similar setup and not setting a significant delay
> (half a second maybe?)  So not sure.
>=20

Good news. And I confirm that the cxl-list command returns a list =
quickly with older cxl/next kernel(s).
I am still in the process of bisecting trying to narrow down the bad =
commit.

Itaru.

> I did notice that there is a bug in qemu though which has surfaced
> for some reason in the kernel log (it dates all the way back to=20
> origin CXL support series). In=20
> include/hw/cxl/cxl_pci.h
> #define REG_LOC_DEVSEC_LENGTH is 0x24 and it should be 0x1C
>=20
> That results for me in a kernel log entry about a bar not being
> big enough for a huge offset (which is random data coming from
> somewhere in text I think).
>=20
> Seems unlikely to trigger your issue, but you never know!
>=20
> Jonathan
>=20
>=20
>>  },
>>  {
>>    "memdev":"mem5",
>>    "pmem_size":1073741824,
>>    "pmem_qos_class":42,
>>    "ram_size":1073741824,
>>    "ram_qos_class":42,
>>    "serial":6,
>>    "numa_node":1,
>>    "host":"cxl_mem.5",
>>    "firmware_version":"mock fw v1 "
>>  },
>>  {
>>    "memdev":"mem1",
>>    "pmem_size":1073741824,
>>    "pmem_qos_class":42,
>>    "ram_size":1073741824,
>>    "ram_qos_class":42,
>>    "serial":2,
>>    "numa_node":1,
>>    "host":"cxl_mem.1",
>>    "firmware_version":"mock fw v1 "
>>  },
>>  {
>>    "memdev":"mem6",
>>    "pmem_size":1073741824,
>>    "pmem_qos_class":42,
>>    "ram_size":1073741824,
>>    "ram_qos_class":42,
>>    "serial":8,
>>    "numa_node":1,
>>    "host":"cxl_mem.7",
>>    "firmware_version":"mock fw v1 "
>>  },
>>  {
>>    "memdev":"mem3",
>>    "pmem_size":1073741824,
>>    "pmem_qos_class":42,
>>    "ram_size":1073741824,
>>    "ram_qos_class":42,
>>    "serial":4,
>>    "numa_node":1,
>>    "host":"cxl_mem.3",
>>    "firmware_version":"mock fw v1 "
>>  },
>>  {
>>    "memdev":"mem4",
>>    "pmem_size":1073741824,
>>    "pmem_qos_class":42,
>>    "ram_size":1073741824,
>>    "ram_qos_class":42,
>>    "serial":5,
>>    "numa_node":0,
>>    "host":"cxl_mem.4",
>>    "firmware_version":"mock fw v1 "
>>  },
>>  {
>>    "memdev":"mem0",
>>    "pmem_size":1073741824,
>>    "pmem_qos_class":42,
>>    "ram_size":1073741824,
>>    "ram_qos_class":42,
>>    "serial":1,
>>    "numa_node":0,
>>    "host":"cxl_mem.0",
>>    "firmware_version":"mock fw v1 "
>>  },
>>  {
>>    "memdev":"mem2",
>>    "pmem_size":1073741824,
>>    "pmem_qos_class":42,
>>    "ram_size":1073741824,
>>    "ram_qos_class":42,
>>    "serial":3,
>>    "numa_node":0,
>>    "host":"cxl_mem.2",
>>    "firmware_version":"mock fw v1 "
>>  },
>>  {
>>    "memdev":"mem7",
>>    "pmem_size":1073741824,
>>    "pmem_qos_class":42,
>>    "ram_size":1073741824,
>>    "ram_qos_class":42,
>>    "serial":7,
>>    "numa_node":0,
>>    "host":"cxl_mem.6",
>>    "firmware_version":"mock fw v1 "
>>  },
>>  {
>>    "memdev":"mem8",
>>    "pmem_size":1073741824,
>>    "pmem_qos_class":42,
>>    "ram_size":1073741824,
>>    "ram_qos_class":42,
>>    "serial":9,
>>    "numa_node":0,
>>    "host":"cxl_mem.8",
>>    "firmware_version":"mock fw v1 "
>>  },
>>  {
>>    "memdev":"mem9",
>>    "pmem_size":1073741824,
>>    "pmem_qos_class":42,
>>    "ram_size":1073741824,
>>    "ram_qos_class":42,
>>    "serial":10,
>>    "numa_node":1,
>>    "host":"cxl_mem.9",
>>    "firmware_version":"mock fw v1 "
>>  },
>>  {
>>    "memdev":"mem12",
>>    "ram_size":268435456,
>>    "serial":0,
>>    "host":"0000:c4:00.0",
>>    "firmware_version":"BWFW VERSION 00"
>>  },
>>  {
>>    "memdev":"mem11",
>>    "ram_size":268435456,
>>    "serial":0,
>>    "host":"0000:c2:00.0",
>>    "firmware_version":"BWFW VERSION 00"
>>  },
>>  {
>>    "memdev":"mem14",
>>    "pmem_size":268435456,
>>    "serial":0,
>>    "host":"0000:3a:00.0",
>>    "firmware_version":"BWFW VERSION 00"
>>  },
>>  {
>>    "memdev":"mem13",
>>    "pmem_size":268435456,
>>    "serial":0,
>>    "host":"0000:38:00.0",
>>    "firmware_version":"BWFW VERSION 00"
>>  }
>> ]
>>=20
>> Getting this shouldn=E2=80=99t take minutes, even with the emulator I =
think.
>>=20
>> Itaru.
>>=20
>>>=20
>>> Thanks for reviews.
>>>=20
>>> Jonathan


