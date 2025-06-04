Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364D728ECC6
	for <linux-cxl@vger.kernel.org>; Wed,  4 Jun 2025 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047568; cv=none; b=CVd8JARSI94WsG/4SgPBfZI5BcZSoHyVpcEpuXMznQxNs2l+ONcL7oJUMbg3EmFtfky/RyfvW+JYSE2L47wwTgZ79uo71nzNG5CQNySe/L+CZNurzxSQp1UQ8QlTCyHCwB3KJny3+JB08Qg3/gjy/aF3jKu2XuprTMqIxwC8uDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047568; c=relaxed/simple;
	bh=9z8QudQWghDp5WMpvA3iQs3K28eMZKlUjQsez2q3whw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJTa5c9XnE59UcZufonaNSW9m410U4lnK6EWEC9l22nfa0KP9zZHTOAIZW+kcbvPYgIuHB3rzlv0TYMQpIRNHUpdpwMC7hC+o0+FrpUnmHIXVAbM6fIEa7djRcZlHDku2xvTu8k4lK0qHMr+v409+VaCfWHwo2kdb3LFDV9TQDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bC95n2HQGz6K99W;
	Wed,  4 Jun 2025 22:32:29 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E2E71400D9;
	Wed,  4 Jun 2025 22:32:42 +0800 (CST)
Received: from localhost (10.203.177.99) by frapeml500003.china.huawei.com
 (7.182.85.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 4 Jun
 2025 16:32:41 +0200
Date: Wed, 4 Jun 2025 15:32:37 +0100
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
	<peter.maydell@linaro.org>, <mst@redhat.com>, <linux-cxl@vger.kernel.org>,
	<qemu-arm@nongnu.org>, Yuquan Wang <wangyuquan1236@phytium.com.cn>, "Itaru
 Kitayama" <itaru.kitayama@linux.dev>, Philippe =?ISO-8859-1?Q?Mathieu-Daud?=
 =?ISO-8859-1?Q?=E9?= <philmd@linaro.org>, Alireza Sanaee
	<alireza.sanaee@huawei.com>
Subject: Re: [PATCH v14 5/5] qtest/cxl: Add aarch64 virt test for CXL
Message-ID: <20250604153051.0000190c@huawei.com>
In-Reply-To: <20250528110726.226389-6-Jonathan.Cameron@huawei.com>
References: <20250528110726.226389-1-Jonathan.Cameron@huawei.com>
	<20250528110726.226389-6-Jonathan.Cameron@huawei.com>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500003.china.huawei.com (7.182.85.28)

On Wed, 28 May 2025 12:07:26 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Add a single complex case for aarch64 virt machine.
> Given existing much more comprehensive tests for x86 cover the
> common functionality, a single test should be enough to verify
> that the aarch64 part continue to work.
> 
> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v14: Tags only.
> ---
>  tests/qtest/cxl-test.c  | 59
> ++++++++++++++++++++++++++++++++--------- tests/qtest/meson.build |
> 1 + 2 files changed, 47 insertions(+), 13 deletions(-)
> 
> diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> index a600331843..c7189d6222 100644
> --- a/tests/qtest/cxl-test.c
> +++ b/tests/qtest/cxl-test.c
> @@ -19,6 +19,12 @@
>      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
>      "-M
> cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G
> " +#define QEMU_VIRT_2PXB_CMD \
> +    "-machine virt,cxl=on -cpu max " \
> +    "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
> +    "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
> +    "-M
> cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G
> " + #define QEMU_RP \
>      "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
>  
> @@ -197,25 +203,52 @@ static void cxl_2pxb_4rp_4t3d(void)
>      qtest_end();
>      rmdir(tmpfs);
>  }
> +
> +static void cxl_virt_2pxb_4rp_4t3d(void)
> +{
> +    g_autoptr(GString) cmdline = g_string_new(NULL);
> +    char template[] = "/tmp/cxl-test-XXXXXX";
> +    const char *tmpfs;
> +
> +    tmpfs = mkdtemp(template);
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
> -    qtest_add_func("/pci/cxl/pxb_x2_with_window",
> cxl_2pxb_with_window);
> -    qtest_add_func("/pci/cxl/rp", cxl_root_port);
> -    qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
> +    g_test_init(&argc, &argv, NULL);
> +    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> +        qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
> +        qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
> +        qtest_add_func("/pci/cxl/pxb_with_window",
> cxl_pxb_with_window);
> +        qtest_add_func("/pci/cxl/pxb_x2_with_window",
> cxl_2pxb_with_window);
> +        qtest_add_func("/pci/cxl/rp", cxl_root_port);
> +        qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
>  #ifdef CONFIG_POSIX
> -    qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
> -    qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
> -    qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
> -    qtest_add_func("/pci/cxl/type3_device_vmem_lsa",
> cxl_t3d_volatile_lsa);
> -    qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
> -    qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4",
> cxl_2pxb_4rp_4t3d);
> +        qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
> +        qtest_add_func("/pci/cxl/type3_device_pmem",
> cxl_t3d_persistent);
> +        qtest_add_func("/pci/cxl/type3_device_vmem",
> cxl_t3d_volatile);
> +        qtest_add_func("/pci/cxl/type3_device_vmem_lsa",
> cxl_t3d_volatile_lsa);
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
> index 43e5a86699..3145c7b5fb 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -259,6 +259,7 @@ qtests_aarch64 = \
>    (config_all_accel.has_key('CONFIG_TCG') and
>                     \
> config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ?
> ['tpm-tis-i2c-test'] : []) + \
> (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 :
> []) + \
> +  qtests_cxl +
>                            \ ['arm-cpu-features',
>     'numa-test',
>     'boot-serial-test',

Hi Jonathan,

This patch does not apply on the latest master anymore. I think did a
few days ago though. Not sure what's wrong.

Thanks,
Alireza
