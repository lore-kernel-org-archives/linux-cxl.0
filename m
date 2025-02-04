Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF9A20B80D
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667303; cv=none; b=cYcvYFem9K0jJk08bS4/quZWqDrDkqCjRxxrJZxSuUl0ZOPeHNj2EHLluHeDmYNrsH4HPOEtNok3ScRyGY4qXnbg8/aJcGl5krsJ+suceKM/W9mhcxgGEqvW0faVddIR1U/QW6ro5yVWAD0tB9NAdGNEUj/a3levnRwRK7L4FiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667303; c=relaxed/simple;
	bh=HbGSzhd3f6t9yLh1zspPmRUS6E/WwAp4SJuAEXjgRM8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LiS2Y2jNvlJyIGPPJ3E8hs7nbx7sr+L246SNsI9OkThlKOGYmroDkAAlEqdtiEJyuWshW3xTuAwl1QniTvxpafBTerGdSt5bwmHsrgiQTOwgCPJT2PtZECLfIfKLs1xZxFqmYnCjhFMM8xQr33NqKNnAMPXkUfXlW1DWAvPulGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CLDth2BZ; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CLDth2BZ"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738667296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fu/GVtqvZ9rYS8IsVZvLcxgstzPj1tjXtyzGOWk1exg=;
	b=CLDth2BZS0h6g/qpEiX4CtKzqw95LE4bBoPH0lZK9W6EmjX9qB8efnd0nv29EFlkAkaiMI
	qPY9n8oLjYthVvRGJ0hUN1rFSTB1Y1UtWS1GCMsA1Yk0IWIad6d3YJpZxQUNfEUu9Nrbmq
	jZVPNxJH+6vFhQ+nBTXxyj5j8jZP4Z4=
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [RFC PATCH v12 qemu 2/2] qtest/cxl: Add aarch64 virt test for CXL
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <20250204092944.00004d3c@huawei.com>
Date: Tue, 4 Feb 2025 20:07:53 +0900
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
Message-Id: <769E9340-B09C-4432-BAC8-D178CE2C7EE3@linux.dev>
References: <20250203173040.145763-1-Jonathan.Cameron@huawei.com>
 <20250203173040.145763-3-Jonathan.Cameron@huawei.com>
 <4AEA1355-C6E8-4A9D-8652-607FEBD7EE03@linux.dev>
 <20250204092944.00004d3c@huawei.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Migadu-Flow: FLOW_OUT



> On Feb 4, 2025, at 18:29, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>=20
> On Tue, 4 Feb 2025 14:16:19 +0900
> Itaru Kitayama <itaru.kitayama@linux.dev> wrote:
>=20
>> Jonathan,
>>=20
>>> On Feb 4, 2025, at 2:30, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>>>=20
>>> Add a single complex case for aarch64 virt machine.
>>> Given existing much more comprehensive tests for x86 cover the
>>> common functionality, a single test should be enough to verify
>>> that the aarch64 part continue to work.
>>>=20
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>> tests/qtest/cxl-test.c  | 59 =
++++++++++++++++++++++++++++++++---------
>>> tests/qtest/meson.build |  1 +
>>> 2 files changed, 47 insertions(+), 13 deletions(-)
>>>=20
>>> diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
>>> index a600331843..c7189d6222 100644
>>> --- a/tests/qtest/cxl-test.c
>>> +++ b/tests/qtest/cxl-test.c
>>> @@ -19,6 +19,12 @@
>>>    "-device pxb-cxl,id=3Dcxl.1,bus=3Dpcie.0,bus_nr=3D53 " \
>>>    "-M =
cxl-fmw.0.targets.0=3Dcxl.0,cxl-fmw.0.targets.1=3Dcxl.1,cxl-fmw.0.size=3D4=
G "
>>>=20
>>> +#define QEMU_VIRT_2PXB_CMD \
>>> +    "-machine virt,cxl=3Don -cpu max " \
>>> +    "-device pxb-cxl,id=3Dcxl.0,bus=3Dpcie.0,bus_nr=3D52 " \
>>> +    "-device pxb-cxl,id=3Dcxl.1,bus=3Dpcie.0,bus_nr=3D53 " \
>>> +    "-M =
cxl-fmw.0.targets.0=3Dcxl.0,cxl-fmw.0.targets.1=3Dcxl.1,cxl-fmw.0.size=3D4=
G "
>>> +
>>> #define QEMU_RP \
>>>    "-device cxl-rp,id=3Drp0,bus=3Dcxl.0,chassis=3D0,slot=3D0 "
>>>=20
>>> @@ -197,25 +203,52 @@ static void cxl_2pxb_4rp_4t3d(void)
>>>    qtest_end();
>>>    rmdir(tmpfs);
>>> }
>>> +
>>> +static void cxl_virt_2pxb_4rp_4t3d(void)
>>> +{
>>> +    g_autoptr(GString) cmdline =3D g_string_new(NULL);
>>> +    char template[] =3D "/tmp/cxl-test-XXXXXX";
>>> +    const char *tmpfs;
>>> +
>>> +    tmpfs =3D mkdtemp(template);
>>> +
>>> +    g_string_printf(cmdline, QEMU_VIRT_2PXB_CMD QEMU_4RP QEMU_4T3D,
>>> +                    tmpfs, tmpfs, tmpfs, tmpfs, tmpfs, tmpfs,
>>> +                    tmpfs, tmpfs);
>>> +
>>> +    qtest_start(cmdline->str);
>>> +    qtest_end();
>>> +    rmdir(tmpfs);
>>> +}
>>> #endif /* CONFIG_POSIX */
>>>=20
>>> int main(int argc, char **argv)
>>> {
>>> -    g_test_init(&argc, &argv, NULL);
>>> +    const char *arch =3D qtest_get_arch();
>>>=20
>>> -    qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
>>> -    qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
>>> -    qtest_add_func("/pci/cxl/pxb_with_window", =
cxl_pxb_with_window);
>>> -    qtest_add_func("/pci/cxl/pxb_x2_with_window", =
cxl_2pxb_with_window);
>>> -    qtest_add_func("/pci/cxl/rp", cxl_root_port);
>>> -    qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
>>> +    g_test_init(&argc, &argv, NULL);
>>> +    if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D=
 0) {
>>> +        qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
>>> +        qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
>>> +        qtest_add_func("/pci/cxl/pxb_with_window", =
cxl_pxb_with_window);
>>> +        qtest_add_func("/pci/cxl/pxb_x2_with_window", =
cxl_2pxb_with_window);
>>> +        qtest_add_func("/pci/cxl/rp", cxl_root_port);
>>> +        qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
>>> #ifdef CONFIG_POSIX
>>> -    qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
>>> -    qtest_add_func("/pci/cxl/type3_device_pmem", =
cxl_t3d_persistent);
>>> -    qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
>>> -    qtest_add_func("/pci/cxl/type3_device_vmem_lsa", =
cxl_t3d_volatile_lsa);
>>> -    qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
>>> -    qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4", =
cxl_2pxb_4rp_4t3d);
>>> +        qtest_add_func("/pci/cxl/type3_device", =
cxl_t3d_deprecated);
>>> +        qtest_add_func("/pci/cxl/type3_device_pmem", =
cxl_t3d_persistent);
>>> +        qtest_add_func("/pci/cxl/type3_device_vmem", =
cxl_t3d_volatile);
>>> +        qtest_add_func("/pci/cxl/type3_device_vmem_lsa", =
cxl_t3d_volatile_lsa);
>>> +        qtest_add_func("/pci/cxl/rp_x2_type3_x2", =
cxl_1pxb_2rp_2t3d);
>>> +        qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4",
>>> +                       cxl_2pxb_4rp_4t3d);
>>> #endif
>>> +    } else if (strcmp(arch, "aarch64") =3D=3D 0) {
>>> +#ifdef CONFIG_POSIX
>>> +        =
qtest_add_func("/pci/cxl/virt/pxb_x2_root_port_x4_type3_x4",
>>> +                       cxl_virt_2pxb_4rp_4t3d);
>>> +#endif
>>> +    }
>>> +
>>>    return g_test_run();
>>> }
>>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>>> index e60e92fe9d..f5e7fb060e 100644
>>> --- a/tests/qtest/meson.build
>>> +++ b/tests/qtest/meson.build
>>> @@ -257,6 +257,7 @@ qtests_aarch64 =3D \
>>>  (config_all_accel.has_key('CONFIG_TCG') and                         =
                   \
>>>   config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? =
['tpm-tis-i2c-test'] : []) + \
>>>  (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 =
: []) + \
>>> +  qtests_cxl +                                                      =
                            \
>>>  ['arm-cpu-features',
>>>   'numa-test',
>>>   'boot-serial-test',
>>> --=20
>>> 2.43.0
>>>=20
>>=20
>> In Ubuntu 22.04 LTS, cxl-test applied on top of today=E2=80=99s QEMU =
upstream master branch cxl-test fails:
>>=20
>> $ ./tests/qtest/cxl-test
>> # random seed: R02S2a8b02df7b32b79d086ce22f7f8ebeab
>> 1..1
>> # Start of aarch64 tests
>> # Start of pci tests
>> # Start of cxl tests
>> # Start of virt tests
>> # starting QEMU: exec qemu-system-aarch64 -qtest =
unix:/tmp/qtest-568421.sock -qtest-log /dev/null -chardev =
socket,path=3D/tmp/qtest-568421.qmp,id=3Dchar0 -mon =
chardev=3Dchar0,mode=3Dcontrol -display none -audio none -machine =
virt,cxl=3Don -cpu max -device pxb-cxl,id=3Dcxl.0,bus=3Dpcie.0,bus_nr=3D52=
 -device pxb-cxl,id=3Dcxl.1,bus=3Dpcie.0,bus_nr=3D53 -M =
cxl-fmw.0.targets.0=3Dcxl.0,cxl-fmw.0.targets.1=3Dcxl.1,cxl-fmw.0.size=3D4=
G -device cxl-rp,id=3Drp0,bus=3Dcxl.0,chassis=3D0,slot=3D0 -device =
cxl-rp,id=3Drp1,bus=3Dcxl.0,chassis=3D0,slot=3D1 -device =
cxl-rp,id=3Drp2,bus=3Dcxl.1,chassis=3D0,slot=3D2 -device =
cxl-rp,id=3Drp3,bus=3Dcxl.1,chassis=3D0,slot=3D3 -object =
memory-backend-file,id=3Dcxl-mem0,mem-path=3D/tmp/cxl-test-WdBn4X,size=3D2=
56M -object =
memory-backend-file,id=3Dlsa0,mem-path=3D/tmp/cxl-test-WdBn4X,size=3D256M =
-device cxl-type3,bus=3Drp0,persistent-memdev=3Dcxl-mem0,lsa=3Dlsa0,id=3Dp=
mem0 -object =
memory-backend-file,id=3Dcxl-mem1,mem-path=3D/tmp/cxl-test-WdBn4X,size=3D2=
56M -object =
memory-backend-file,id=3Dlsa1,mem-path=3D/tmp/cxl-test-WdBn4X,size=3D256M =
-device cxl-type3,bus=3Drp1,persistent-memdev=3Dcxl-mem1,lsa=3Dlsa1,id=3Dp=
mem1 -object =
memory-backend-file,id=3Dcxl-mem2,mem-path=3D/tmp/cxl-test-WdBn4X,size=3D2=
56M -object =
memory-backend-file,id=3Dlsa2,mem-path=3D/tmp/cxl-test-WdBn4X,size=3D256M =
-device cxl-type3,bus=3Drp2,persistent-memdev=3Dcxl-mem2,lsa=3Dlsa2,id=3Dp=
mem2 -object =
memory-backend-file,id=3Dcxl-mem3,mem-path=3D/tmp/cxl-test-WdBn4X,size=3D2=
56M -object =
memory-backend-file,id=3Dlsa3,mem-path=3D/tmp/cxl-test-WdBn4X,size=3D256M =
-device cxl-type3,bus=3Drp3,persistent-memdev=3Dcxl-mem3,lsa=3Dlsa3,id=3Dp=
mem3  -accel qtest
>> qemu-system-aarch64: -audio: invalid option
>> socket_accept failed: Resource temporarily unavailable
>> **
>> ERROR:../tests/qtest/libqtest.c:550:qtest_connect: assertion failed: =
(s->fd >=3D 0 && s->qmp_fd >=3D 0)
>> Bail out! ERROR:../tests/qtest/libqtest.c:550:qtest_connect: =
assertion failed: (s->fd >=3D 0 && s->qmp_fd >=3D 0)
>> ../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU =
process but encountered exit status 1 (expected 0)
>> Aborted (core dumped)
>>=20
>> Do I need set env vars when execute this test?
>=20
> I've just been running it with make check-qtest and not seeing =
anything similar.
>=20

Ah. `make check-qtest` rather than directly executing the binary made =
the updated cxl-test finished with other 26 =E2=80=9COk=E2=80=9D test 1 =
Skipped for aarch64

Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com =
<mailto:itaru.kitayama@fujitsu.com>>

> I'm not sure what infrastructure qtest puts round these but I guess it =
sets
> up that socket.
>=20
> Jonathan
>=20
>=20
>=20
>>=20
>> Itaru.


