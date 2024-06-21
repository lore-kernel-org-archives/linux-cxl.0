Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC41171068;
	Fri, 21 Jun 2024 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964989; cv=none; b=Dk9r/iFeb6M584HiKBEOPy8P636x+B9FtWwtH0JxpbzIzWINAD9bsfb1awyties8waGZGa4AMDrz7FnjIn03dI+tHlBgOqW3AQVVBUQvc+D/qyGKIsJtmRPki6SnbTDzJL6kKybZ10GOeT2Yyyoph02L/V+Z7mPFonpgLU5be18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964989; c=relaxed/simple;
	bh=tvFkEouXFKKtc7kniYd3ifcNhvOpKScmMlR6pCekqn0=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WmljYqYxDfZtKORhIs5eMtinJEVH/unOblUjth4EdhrSRSFKFR13auVprXDXUlkw2vICIc3DUdULIgDjLNohzY/EsBwdvfvokt8K24h7WHqXFClT1fXWdU8mSedpfcKxLDDsSXkMnBQa/ujxt0lJmAOHqh/6/SAVq+ItfSFLrt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4W5Cny0SG2z1SCyb;
	Fri, 21 Jun 2024 18:12:06 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 851E618001C;
	Fri, 21 Jun 2024 18:16:23 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 21 Jun 2024 18:16:22 +0800
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <imx@lists.linux.dev>,
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] perf: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Frank Li <Frank.li@nxp.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Yicong Yang <yangyicong@hisilicon.com>
References: <20240620-md-drivers-perf-v2-1-1f88f8a08e48@quicinc.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <6d9e17f7-80e6-e616-d3b8-719de73875f3@huawei.com>
Date: Fri, 21 Jun 2024 18:16:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240620-md-drivers-perf-v2-1-1f88f8a08e48@quicinc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/6/21 9:46, Jeff Johnson wrote:
> With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm-ccn.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/fsl_imx8_ddr_perf.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/marvell_cn10k_ddr_pmu.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm_cspmu/arm_cspmu_module.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm_cspmu/nvidia_cspmu.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm_cspmu/ampere_cspmu.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/cxl_pmu.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro to all
> files which have a MODULE_LICENSE().
> 
> This includes drivers/perf/hisilicon/hisi_uncore_pmu.c which, although
> it did not produce a warning with the x86 allmodconfig configuration,
> may cause this warning with arm64 configurations.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> Changes in v2:
> - Updated hisi_uncore_pmu.c description per Yicong Yang
> - Link to v1: https://lore.kernel.org/r/20240611-md-drivers-perf-v1-1-c001bae6da5c@quicinc.com
> ---
>  drivers/perf/arm-ccn.c                   | 1 +
>  drivers/perf/arm_cspmu/ampere_cspmu.c    | 1 +
>  drivers/perf/arm_cspmu/arm_cspmu.c       | 1 +
>  drivers/perf/arm_cspmu/nvidia_cspmu.c    | 1 +
>  drivers/perf/cxl_pmu.c                   | 1 +
>  drivers/perf/fsl_imx8_ddr_perf.c         | 1 +
>  drivers/perf/hisilicon/hisi_uncore_pmu.c | 1 +
>  drivers/perf/marvell_cn10k_ddr_pmu.c     | 1 +
>  8 files changed, 8 insertions(+)
> 
> diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
> index 86ef31ac7503..65f4882531db 100644
> --- a/drivers/perf/arm-ccn.c
> +++ b/drivers/perf/arm-ccn.c
> @@ -1561,4 +1561,5 @@ module_init(arm_ccn_init);
>  module_exit(arm_ccn_exit);
>  
>  MODULE_AUTHOR("Pawel Moll <pawel.moll@arm.com>");
> +MODULE_DESCRIPTION("ARM CCN (Cache Coherent Network) driver support");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/perf/arm_cspmu/ampere_cspmu.c b/drivers/perf/arm_cspmu/ampere_cspmu.c
> index f146a455e838..426b3cfcb52e 100644
> --- a/drivers/perf/arm_cspmu/ampere_cspmu.c
> +++ b/drivers/perf/arm_cspmu/ampere_cspmu.c
> @@ -269,4 +269,5 @@ static void __exit ampere_cspmu_exit(void)
>  module_init(ampere_cspmu_init);
>  module_exit(ampere_cspmu_exit);
>  
> +MODULE_DESCRIPTION("Ampere SoC PMU (Performance Monitor Unit) driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index c318dc909767..c21c564840d6 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -1427,4 +1427,5 @@ EXPORT_SYMBOL_GPL(arm_cspmu_impl_unregister);
>  module_init(arm_cspmu_init);
>  module_exit(arm_cspmu_exit);
>  
> +MODULE_DESCRIPTION("ARM CoreSight Architecture PMU driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> index 5b84b701ad62..0dea47e48ac5 100644
> --- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
> +++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> @@ -417,4 +417,5 @@ static void __exit nvidia_cspmu_exit(void)
>  module_init(nvidia_cspmu_init);
>  module_exit(nvidia_cspmu_exit);
>  
> +MODULE_DESCRIPTION("NVIDIA Coresight Architecture PMU driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 1f93a66eff5b..8b6ce9ea5a55 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -972,6 +972,7 @@ static __exit void cxl_pmu_exit(void)
>  	cpuhp_remove_multi_state(cxl_pmu_cpuhp_state_num);
>  }
>  
> +MODULE_DESCRIPTION("CXL Performance Monitoring Unit driver");
>  MODULE_LICENSE("GPL");
>  MODULE_IMPORT_NS(CXL);
>  module_init(cxl_pmu_init);
> diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
> index 1bbdb29743c4..a6683b38315c 100644
> --- a/drivers/perf/fsl_imx8_ddr_perf.c
> +++ b/drivers/perf/fsl_imx8_ddr_perf.c
> @@ -850,4 +850,5 @@ static struct platform_driver imx_ddr_pmu_driver = {
>  };
>  
>  module_platform_driver(imx_ddr_pmu_driver);
> +MODULE_DESCRIPTION("Freescale i.MX8 DDR PMU driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> index 6392cbedcd06..0ac5182a5e45 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> @@ -537,4 +537,5 @@ void hisi_pmu_init(struct hisi_pmu *hisi_pmu, struct module *module)
>  }
>  EXPORT_SYMBOL_GPL(hisi_pmu_init);
>  
> +MODULE_DESCRIPTION("HiSilicon SoC uncore PMU driver framework");

Reviewed-by: Yicong Yang <yangyicong@hisilicon.com> # for HiSilicon PMU

>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
> index e2abca188dbe..94f1ebcd2a27 100644
> --- a/drivers/perf/marvell_cn10k_ddr_pmu.c
> +++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
> @@ -763,4 +763,5 @@ module_init(cn10k_ddr_pmu_init);
>  module_exit(cn10k_ddr_pmu_exit);
>  
>  MODULE_AUTHOR("Bharat Bhushan <bbhushan2@marvell.com>");
> +MODULE_DESCRIPTION("Marvell CN10K DRAM Subsystem (DSS) Performance Monitor Driver");
>  MODULE_LICENSE("GPL v2");
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240611-md-drivers-perf-5d834208964d
> 
> .
> 
