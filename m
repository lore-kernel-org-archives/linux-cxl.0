Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802842874F7
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747773528; cv=none; b=oo3q1nkHGJ7RAnj8zFf7/1kQXN/QPX02UOXmz11ksx2YX9mI6q/Rna1aCxly7VRuwC1szAkkGv15J+Gjz5gUEGeoAgEalJHxysF5n7Gj8cv3+OFfv7Q7EvpkSid1uIHCWRLfjiBIehGzrn/ofBQDpWNkZRolQUoUPl4YoBqyUo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747773528; c=relaxed/simple;
	bh=OXhZKqSQ55Rl/Jf5ZrmapVTr/ntUkC/rCwPe0B6puxU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AijMTLXsGQukhNbrvBCbC4pL0GH2TMUQPbvVavQg4WjPWIQ9cWOHGrq6b28t7OKVw2lbh3eVZfYhtNiDdOoqiuMjYAzNuxGiKcof7gzTgrZpEYokGacTpq1q5gS8jU0uSaBs2/37TkEhT/3tYD1Mmb1h0zZupnYUuba+L8FJEyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q99WFAhU; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q99WFAhU"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747773521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlC0TODa7KxYUpfpU68321KNCp6H6FT3J7MnALnUViM=;
	b=Q99WFAhUM4c9CvOUBZ9CEYtfHJgTzvdjDRM8TVre/iZalux4nGAiMJQXSEMr6/NeJLtSYy
	VNgLjCb7/Xp9aFDFLoaaAQRAosNW22/ChM2umYCctjTh8RPhMsHNYcgUJu9jQ1BThTu3Rn
	5qvYmN7YE9Jgq1Pv4LkGF3zvpmJOO4o=
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v13 5/5] qtest/cxl: Add aarch64 virt test for CXL
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <20250519135413.000026b4@huawei.com>
Date: Wed, 21 May 2025 05:38:21 +0900
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
Message-Id: <1BAB6FA9-F65A-41F4-ADC7-BE3F23E71AA0@linux.dev>
References: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
 <20250513111455.128266-6-Jonathan.Cameron@huawei.com>
 <D9E503CC-1271-4008-9975-9BAEC7A33376@linux.dev>
 <20250519135413.000026b4@huawei.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Migadu-Flow: FLOW_OUT

Jonathan,

> On May 19, 2025, at 21:54, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>=20
> On Thu, 15 May 2025 18:04:18 +0900
> Itaru Kitayama <itaru.kitayama@linux.dev> wrote:
>=20
>>> On May 13, 2025, at 20:14, Jonathan Cameron =
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
>>> index 7daf619845..361000267a 100644
>>> --- a/tests/qtest/meson.build
>>> +++ b/tests/qtest/meson.build
>>> @@ -258,6 +258,7 @@ qtests_aarch64 =3D \
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
>> ~/projects/qemu/build$ meson test qtest-aarch64/cxl-test
>> ninja: Entering directory `/home/realm/projects/qemu/build'
>> [1/8] Generating qemu-version.h with a custom command (wrapped by =
meson to capture output)
>> 1/1 qemu:qtest+qtest-aarch64 / qtest-aarch64/cxl-test        OK       =
       0.17s   1 subtests passed
>>=20
>> Ok:                 1
>> Expected Fail:      0
>> Fail:               0
>> Unexpected Pass:    0
>> Skipped:            0
>> Timeout:            0
>>=20
>> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com =
<mailto:itaru.kitayama@fujitsu.com>>
>>=20
>> Jonathan, would you push your branch this series applied? I manually =
applied your series no issues though.
>=20
> I'm reluctant to push a 'normal' staging CXL tree whilst we have the =
TCG
> issue outstanding (which is in mainline).
> I can probably push one with a name that makes it clear we know it =
will
> crash under some circumstances though. I'll aim to get that done later =
this week.

Okay, and understood.

>=20
> After talking to Richard Henderson I'm going to spin some images etc =
to
> make it easier for him to replicate that TCG issue.
>=20
> Thanks for reviews.

The comments are from Zhijian.

Itaru.

>=20
> Jonathan
>=20
>>=20
>>=20
>=20

