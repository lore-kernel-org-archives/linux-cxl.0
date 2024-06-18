Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376E747A74;
	Tue, 18 Jun 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730400; cv=none; b=ZpneulcMR5V8R5oHMO/XVWY9Wvmsw+c67KnW1rlTMLf0z+ygvzck0CkX2DPXhIU2sXZgBUoNCFwZphG6vx2358NwsdD1HiLj3S6jjFDmczMNQfsnMkBDJqP/nvXrfz/4R29mTm9o1Fkr1me+F5cU/b19IfRz7R3XyDVbIVYtM4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730400; c=relaxed/simple;
	bh=/cGqt0hi46gWUxkv2mtXgQydqEiLLDCK98sOAwQLRTM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7fnj68Rt2fVBorR/LD5q17Tu3Nbef4k4zkVL93qb0puiYGItCiuiOezAa4oE0Es0xFHYmtmiQDLGIjDsRkpT60aFInBlLEyTIH4WJ85sNhLfdunxN0941kd3kut4CSvv1iNgN6+UKifvJWyGcvLQ5thAoVu/90cqJP2Zl6Jrs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W3Y766kYTz6K6BB;
	Wed, 19 Jun 2024 01:06:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6625D1406AC;
	Wed, 19 Jun 2024 01:06:28 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 18 Jun
 2024 18:06:27 +0100
Date: Tue, 18 Jun 2024 18:06:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
CC: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Frank
 Li <Frank.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Yicong Yang <yangyicong@hisilicon.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <imx@lists.linux.dev>,
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] perf: add missing MODULE_DESCRIPTION() macros
Message-ID: <20240618180627.00007668@Huawei.com>
In-Reply-To: <20240611-md-drivers-perf-v1-1-c001bae6da5c@quicinc.com>
References: <20240611-md-drivers-perf-v1-1-c001bae6da5c@quicinc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 11 Jun 2024 11:31:06 -0700
Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

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
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # for CXL PMU

