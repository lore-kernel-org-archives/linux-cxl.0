Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE04224F6
	for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750905255; cv=none; b=PRDZ0T2syxMIkWZ70Zvu8NnXZdwqgUEieRUm5dqtflkBafGN0zzqs4bBmoJOcNsnGLLRzPmLW9MAWMKS+wmzT05OpHEuK29QicuNPOI9hfdBoalvhYKyiyDFtEes3WBoEQgjat2aXAbXyjdcq8biyNs8nNTHta3u1XtP5gmkn1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750905255; c=relaxed/simple;
	bh=tp3RuSbClKBszheSfY6U3aaB+10HmxYH6YoGGcTMGWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0nZMwaZc8vmccpmDgyU7+y3pqxjzt81Uzqvge/dToY5vpobMpBsj1eGIYP4anoH7E2Pzl+hKXA9TT3qIpkT7mLktoPpVHtCEuvc0mqBJxqyXIB43Su3B1SB7bhz5aC7qdsItydGYAugLawDZOsC6tBjtjLbkd1RzUg2TrATeiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NZblTC2C; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NZblTC2C"
Date: Thu, 26 Jun 2025 11:33:58 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750905247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RjL5hT4l8Yh+/iydgPaThwMUOJfmrbIQqeQkawidg3Q=;
	b=NZblTC2CwDxjpBOUo/smyeyW4p/s/xQM0cZNU3bhk8nEJPj51xI3RDAjLsUW56weR0+pJb
	as5CH3O8uEJl8Q+7uwXsGwr6u1qCNbgP2hVitGd+UU/1cqojW4r2rzci35r02Fq99PIeJh
	MoP2Pl6z6qUbsWB5nmHEVTrSexTN3OM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
	Peter Maydell <peter.maydell@linaro.org>, mst@redhat.com,
	Zhijian Li <lizhijian@fujitsu.com>, linuxarm@huawei.com,
	linux-cxl@vger.kernel.org, qemu-arm@nongnu.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH qemu v16 5/5] qtest/cxl: Add aarch64 virt test for CXL
Message-ID: <aFyxljLgpYXxiSn3@vm4>
References: <20250625161926.549812-1-Jonathan.Cameron@huawei.com>
 <20250625161926.549812-6-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625161926.549812-6-Jonathan.Cameron@huawei.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 25, 2025 at 05:19:26PM +0100, Jonathan Cameron wrote:
> Add a single complex case for aarch64 virt machine.
> Given existing much more comprehensive tests for x86 cover the
> common functionality, a single test should be enough to verify
> that the aarch64 part continue to work.
> 
> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v16: Update to bring improvements made to other tests (Peter Maydell).
>      I'd failed to notice when rebasing this over time that the
>      other tests had undergone various improvment and I should have
>      updated this one as well.
> ---
>  tests/qtest/cxl-test.c  | 58 ++++++++++++++++++++++++++++++++---------
>  tests/qtest/meson.build |  1 +
>  2 files changed, 46 insertions(+), 13 deletions(-)
> 
> diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> index a600331843..8fb7e58d4f 100644
> --- a/tests/qtest/cxl-test.c
> +++ b/tests/qtest/cxl-test.c
> @@ -19,6 +19,12 @@
>      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
>      "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
>  
> +#define QEMU_VIRT_2PXB_CMD \
> +    "-machine virt,cxl=on -cpu max " \
> +    "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
> +    "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
> +    "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
> +
>  #define QEMU_RP \
>      "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
>  
> @@ -197,25 +203,51 @@ static void cxl_2pxb_4rp_4t3d(void)
>      qtest_end();
>      rmdir(tmpfs);
>  }
> +
> +static void cxl_virt_2pxb_4rp_4t3d(void)
> +{
> +    g_autoptr(GString) cmdline = g_string_new(NULL);
> +    g_autofree const char *tmpfs = NULL;
> +
> +    tmpfs = g_dir_make_tmp("cxl-test-XXXXXX", NULL);
> +
> +    g_string_printf(cmdline, QEMU_VIRT_2PXB_CMD QEMU_4RP QEMU_4T3D,
> +                    tmpfs, tmpfs, tmpfs, tmpfs, tmpfs, tmpfs,
> +                    tmpfs, tmpfs);
> +
> +    qtest_start(cmdline->str);
> +    qtest_end();
> +    rmdir(tmpfs);
> +}
>  #endif /* CONFIG_POSIX */
>  
>  int main(int argc, char **argv)
>  {
> -    g_test_init(&argc, &argv, NULL);
> +    const char *arch = qtest_get_arch();
>  
> -    qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
> -    qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
> -    qtest_add_func("/pci/cxl/pxb_with_window", cxl_pxb_with_window);
> -    qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window);
> -    qtest_add_func("/pci/cxl/rp", cxl_root_port);
> -    qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
> +    g_test_init(&argc, &argv, NULL);
> +    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> +        qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
> +        qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
> +        qtest_add_func("/pci/cxl/pxb_with_window", cxl_pxb_with_window);
> +        qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window);
> +        qtest_add_func("/pci/cxl/rp", cxl_root_port);
> +        qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
>  #ifdef CONFIG_POSIX
> -    qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
> -    qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
> -    qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
> -    qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatile_lsa);
> -    qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
> -    qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4", cxl_2pxb_4rp_4t3d);
> +        qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
> +        qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
> +        qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
> +        qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatile_lsa);
> +        qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
> +        qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4",
> +                       cxl_2pxb_4rp_4t3d);
>  #endif
> +    } else if (strcmp(arch, "aarch64") == 0) {
> +#ifdef CONFIG_POSIX
> +        qtest_add_func("/pci/cxl/virt/pxb_x2_root_port_x4_type3_x4",
> +                       cxl_virt_2pxb_4rp_4t3d);
> +#endif
> +    }
> +
>      return g_test_run();
>  }
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 8ad849054f..42e927b32a 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -261,6 +261,7 @@ qtests_aarch64 = \
>     config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
>    (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
> +  qtests_cxl +                                                                                  \
>    ['arm-cpu-features',
>     'numa-test',
>     'boot-serial-test',

The v16 series was applied cleanly against the master today and did 
meson test qtest-aarch64/cxl-test it went ok.

Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>

Thanks,
Itaru.


> -- 
> 2.48.1
> 
