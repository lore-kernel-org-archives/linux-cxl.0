Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D181922E3;
	Wed, 10 Jul 2024 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720615157; cv=none; b=GVIPsrRMcFODFhAErE+tsS3d5oUtMDHAUveeHDv/wh6R/5RHR67BFriVi5qrCmj/loxoul6BQHgUfV2iLndJXp2vMFmSBsourgO1HiOXOfPqmGr82z6uFS2Sgk+UjM3OAbE0ElcEEm/eUaWclqx7glExgcgyCCNVpz9KH12+qOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720615157; c=relaxed/simple;
	bh=s2RaCEI4wR41c3BO5uw81gT6/k/TIddLsTFnZWRBHBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZxhAcSB7b7aGcP94b5HV/u6M32sBWSa3ATGJKoNTJ4Gy4E67scPY4eb2MLnUImJuRjPamlbXFUjzkJyyxmt2OEOv8VZ60Qt/lHYna28Wu/kzz/UUAHe9NPG90x6P2j8EVBdZT1rX7DWgixD9deGRcrcxl2xlDCXantqy27o1SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjxroEH8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjxroEH8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8290C4AF0A;
	Wed, 10 Jul 2024 12:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720615156;
	bh=s2RaCEI4wR41c3BO5uw81gT6/k/TIddLsTFnZWRBHBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gjxroEH8w8w9RPM434seJwV9COaOkd9UmRTwLFwZunjhWQsXf+egnwDlcgSp1oBpk
	 GsUo98wxUcgpJnFogSshO311/In5d/eGoOeN+X4/3Tk4/BKr9rFszXGS1Omx8gUTMv
	 XX+NaEp2Lar8ZT2XkVrDF/Bwk+d9P3RpJvoqIZBte1BoB33qXa8TTdFoU+BtQgs8Vd
	 awfXtekaxXrh8cLPO8MIgM9XDd16Xg9bEgSLO4W9ghIo+oAo1gjrCOji+8g+IbojxB
	 VOIhohZ8bywWK5nq44OMB6PsBQqLLUJ5eHSBo0bOxgDWiyUa938zLHZwFJFCjQzdJc
	 mb5++ndsBuczA==
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Frank Li <Frank.li@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	imx@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] perf: add missing MODULE_DESCRIPTION() macros
Date: Wed, 10 Jul 2024 13:39:05 +0100
Message-Id: <172061307957.623411.17142418937279057988.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240709-md-drivers-perf-v3-1-513275b75ed0@quicinc.com>
References: <20240709-md-drivers-perf-v3-1-513275b75ed0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 09 Jul 2024 15:07:55 -0700, Jeff Johnson wrote:
> With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm-ccn.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/fsl_imx8_ddr_perf.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/marvell_cn10k_ddr_pmu.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm_cspmu/arm_cspmu_module.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm_cspmu/nvidia_cspmu.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm_cspmu/ampere_cspmu.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/cxl_pmu.o
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf: add missing MODULE_DESCRIPTION() macros
      https://git.kernel.org/will/c/42bebc7cca79

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
