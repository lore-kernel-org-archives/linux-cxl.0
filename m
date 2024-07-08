Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8407E56C;
	Mon,  8 Jul 2024 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439833; cv=none; b=E8iHQ6W+v9jXVs5ehVJdqBx90RcIIyHNSWm2++quxYPGmHuVHqvUH4YPZdJDFuDyIxpizhdid7UMomOrHqcrs/wwHdZ8gihu4OPMnIrwebHnMYjf2V9vat0P41afmtXbOxlE8Z4BLnCB7nsWaZU+TdV7K8KY88b6k9XymqAeNs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439833; c=relaxed/simple;
	bh=BTVqtRoqBiMT7TmYf0E1RNhYJ/Rx2jW4ev3SgIlcX94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0elBDw1T/hqWIZvb9k2i085iDtGuinnnSyro4FPRZSluo/ovIzKUv9NKXTwXW492+3X0phkOowZB1AucUi10hAQz7ZdWnfjP2NRJhc1jkwfshJWlkMIMrq81YZIZ2QuGm2uuVd5jruytIn81u0GKxue5QrNYNqQ5EJ4iRCzDI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sT6Tsgh0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sT6Tsgh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAE0C116B1;
	Mon,  8 Jul 2024 11:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720439833;
	bh=BTVqtRoqBiMT7TmYf0E1RNhYJ/Rx2jW4ev3SgIlcX94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sT6Tsgh07pJROr8oru58JD/L03h0+t3wg9bFnty8ES53I5GMc6kr9ZM7MO1vweWIp
	 UgBf1O/9NCkjUMZzhSrfmoJb6eri/BknEYDOkUW8Yh15j433czhvXNrmHn1vlSZwiY
	 22FLGRfZMbs0/PkVLrDogzKBl2W8G9avqdqvCa0VLjThlDH8oHV/1GbDwXzGH0Ytx+
	 bmgZmPPXatFAlaSgNhJupAxW70KNMwKzCLc8z1RBXwlUqrte7ki/SO4V4pzsRHN+FU
	 bCR+3UESRafcp8+ro/JdlgfADAgaKyQ5TIZkfcMjcBys168S6XIE7rH9qYUOF/n5S7
	 JjjT0yFPmOYWg==
Date: Mon, 8 Jul 2024 12:57:07 +0100
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
Message-ID: <20240708115707.GB11771@willie-the-truck>
References: <20240620-md-drivers-perf-v2-1-1f88f8a08e48@quicinc.com>
 <20240701140521.GF2250@willie-the-truck>
 <aac18765-4278-4ce0-a0f9-d249ba1d6872@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aac18765-4278-4ce0-a0f9-d249ba1d6872@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jul 01, 2024 at 08:38:02AM -0700, Jeff Johnson wrote:
> On 7/1/2024 7:05 AM, Will Deacon wrote:
> > On Thu, Jun 20, 2024 at 06:46:09PM -0700, Jeff Johnson wrote:
> >> diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> >> index 5b84b701ad62..0dea47e48ac5 100644
> >> --- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
> >> +++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> >> @@ -417,4 +417,5 @@ static void __exit nvidia_cspmu_exit(void)
> >>  module_init(nvidia_cspmu_init);
> >>  module_exit(nvidia_cspmu_exit);
> >>  
> >> +MODULE_DESCRIPTION("NVIDIA Coresight Architecture PMU driver");
> >>  MODULE_LICENSE("GPL v2");
> >> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> >> index 1f93a66eff5b..8b6ce9ea5a55 100644
> >> --- a/drivers/perf/cxl_pmu.c
> >> +++ b/drivers/perf/cxl_pmu.c
> >> @@ -972,6 +972,7 @@ static __exit void cxl_pmu_exit(void)
> >>  	cpuhp_remove_multi_state(cxl_pmu_cpuhp_state_num);
> >>  }
> >>  
> >> +MODULE_DESCRIPTION("CXL Performance Monitoring Unit driver");
> > 
> > Similarly here, we now have a conflicting expansion of the acronym.
> 
> I'll make them consistent in the MODULE_DESCRIPTION()s.
> Do you have a preference for expanding or not expanding?

PMU is a terrible acronym, so I probably prefer expanding it unless it
causes problems.

Will
