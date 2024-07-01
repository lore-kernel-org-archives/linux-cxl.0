Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C8915FA84;
	Mon,  1 Jul 2024 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842727; cv=none; b=Rae/gYzg2RYN4qNyi/YrdYwW5cjmZDhuW1O7nl5kw4z/m7aPEQt9if+Gn/tIH4AdMBslBLT9pHbmul7fQUSuM/yD9t6YuoN9qajDvnpnh+mLYMfwsE5nzIqvgGJzI3LJy10nOCKK70J7i3R9HrMz35kW1+J1/uAqyDoTWxT7FZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842727; c=relaxed/simple;
	bh=3z7Nyih4klomXUbQ7PdjR2cY+MU5YAkFW2gKQkAGdis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxGh9kWHPkGLr94QLnAOm0TGDC7P/dGz0J6qXMCUjREr6w+2oalSgK7i4gJT9580oxYKMR/M5IfSoIvb1DfsKhNQahSA+ug2JpMz+1xbfBw0Xk0hgAJrzOSwAb3ErelgoP0QPagMT7XLt4G15g7f4mc1E2jmhH0xiI+RPOTwAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IelUclHL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IelUclHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6613BC116B1;
	Mon,  1 Jul 2024 14:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719842726;
	bh=3z7Nyih4klomXUbQ7PdjR2cY+MU5YAkFW2gKQkAGdis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IelUclHLBKmH/CQ1eHdRciWb6yKC9Ex/W+yqaBRUGCDDPmIVbju1SQgHfL+JRC38g
	 1MkB/gtU8Ml9QsNa2gkU9T2l+kaz5vvwT9VBybApM0NYkcCLnRpK2jPu6U+E0TD/fy
	 Z9gMLVGMNITnWZM2G7os5H/nMwDigx+OZ+hpvQP46SLCzNAFsuTFM8g675o0eIJECw
	 hThpLWmk3m5OwJpiwTyEqDqhocPwHRPRucGYu4VdbqvL03whaiAM28TrxJ3Zd2M+4g
	 VCEA9lq/r3uyTm5yE1SyfIDDlJhSaKrYV55DU0h+p/sGm//ELBZn1GttvlBs/jSTCl
	 9V0Ff+2WSjPEg==
Date: Mon, 1 Jul 2024 15:05:21 +0100
From: Will Deacon <will@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Frank Li <Frank.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, imx@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] perf: add missing MODULE_DESCRIPTION() macros
Message-ID: <20240701140521.GF2250@willie-the-truck>
References: <20240620-md-drivers-perf-v2-1-1f88f8a08e48@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620-md-drivers-perf-v2-1-1f88f8a08e48@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jun 20, 2024 at 06:46:09PM -0700, Jeff Johnson wrote:
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

Curious: why do you expand the PMU acronym here, but not for any of the
other drivers? If we're going to add these strings to all the drivers in
one go, then it would good to be consistent.

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

Similarly here, we now have a conflicting expansion of the acronym.

Will
