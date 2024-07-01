Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BA9376E7;
	Mon,  1 Jul 2024 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848321; cv=none; b=Dv9jDx8mOl4BI0yWQhdZvL+fdUX77rDvNvtV08IdDn22971q15BHrVKFsmbQE6wbdRz4ksumTd5HrGq70tozMtDIqok4iB7dGNs3swE0U4Xvmzgp2rrhmhS2iQKKquKM3ax5rMmjRVqSc4YUhneeAW4DAgNNgspSkYDWNmMacGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848321; c=relaxed/simple;
	bh=qGZSUpncTlrSVUhF9e8WztlZO/H62XIR+WPrDBCFjoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sa5DoeJo2qNzip/k/92hvWC9mG2qbEBl1vd+JDqdLjFu1RNt6FXynpsEuFl9CP5Oetu1GCGtdBFy0MBSH5SOiigrjH3wBzom1PIw7wxl9TfrpM3JBSsbegavhX6IM52MqxVU313Q+szrnPguriIfS7wOOp4zQfl8XT197xYhbCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eA9wc509; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eA9wc509"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4619pLsX006850;
	Mon, 1 Jul 2024 15:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WQNu3HGwsBvw34NNAmVNukSruR+Bp7trDgkn2Im5fCM=; b=eA9wc509jjj1vmb7
	eJA99ekbRO0RoJQiYpvDmWq9Ty9eAd4uA5A6oyYD/804DzfK11z0Bxey24jAVPyT
	o+HPf31DGemAFOSYWJzQydDMB30D8ldG4qsVSE+25DS0F6L6ghVbHknsSafL3n+M
	J+7A530TrI5vtQ5GXPK32JzgeO3QPK9BtkKZGfbxzySYxQ0LrmzCr2S3IWEROc8V
	fZH+AZesPQbdTlUdvRsBfi8Y+I4r24MagnDUBBG9Ag6TO3Sl7A+GowtMGQzfALDh
	WcWVzccrNxpXU6YulGeg9V/3x8LDAoAyl4HSK77SM4uNKsrnbvUBxupBRJCeuNXg
	2Q+NaQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4027mnmyw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 15:38:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 461Fc4Ff017655
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Jul 2024 15:38:04 GMT
Received: from [10.48.245.148] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Jul 2024
 08:38:03 -0700
Message-ID: <aac18765-4278-4ce0-a0f9-d249ba1d6872@quicinc.com>
Date: Mon, 1 Jul 2024 08:38:02 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf: add missing MODULE_DESCRIPTION() macros
To: Will Deacon <will@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron
	<jonathan.cameron@huawei.com>,
        Frank Li <Frank.li@nxp.com>, Shawn Guo
	<shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix
 Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <imx@lists.linux.dev>,
        <kernel-janitors@vger.kernel.org>
References: <20240620-md-drivers-perf-v2-1-1f88f8a08e48@quicinc.com>
 <20240701140521.GF2250@willie-the-truck>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240701140521.GF2250@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BbcI1LKTv-uvKs_nmSQ5TkuqOvGmHLkU
X-Proofpoint-GUID: BbcI1LKTv-uvKs_nmSQ5TkuqOvGmHLkU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_15,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010120

On 7/1/2024 7:05 AM, Will Deacon wrote:
> On Thu, Jun 20, 2024 at 06:46:09PM -0700, Jeff Johnson wrote:
>> With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm-ccn.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/fsl_imx8_ddr_perf.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/marvell_cn10k_ddr_pmu.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm_cspmu/arm_cspmu_module.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm_cspmu/nvidia_cspmu.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm_cspmu/ampere_cspmu.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/cxl_pmu.o
>>
>> Add the missing invocation of the MODULE_DESCRIPTION() macro to all
>> files which have a MODULE_LICENSE().
>>
>> This includes drivers/perf/hisilicon/hisi_uncore_pmu.c which, although
>> it did not produce a warning with the x86 allmodconfig configuration,
>> may cause this warning with arm64 configurations.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>> Changes in v2:
>> - Updated hisi_uncore_pmu.c description per Yicong Yang
>> - Link to v1: https://lore.kernel.org/r/20240611-md-drivers-perf-v1-1-c001bae6da5c@quicinc.com
>> ---
>>  drivers/perf/arm-ccn.c                   | 1 +
>>  drivers/perf/arm_cspmu/ampere_cspmu.c    | 1 +
>>  drivers/perf/arm_cspmu/arm_cspmu.c       | 1 +
>>  drivers/perf/arm_cspmu/nvidia_cspmu.c    | 1 +
>>  drivers/perf/cxl_pmu.c                   | 1 +
>>  drivers/perf/fsl_imx8_ddr_perf.c         | 1 +
>>  drivers/perf/hisilicon/hisi_uncore_pmu.c | 1 +
>>  drivers/perf/marvell_cn10k_ddr_pmu.c     | 1 +
>>  8 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
>> index 86ef31ac7503..65f4882531db 100644
>> --- a/drivers/perf/arm-ccn.c
>> +++ b/drivers/perf/arm-ccn.c
>> @@ -1561,4 +1561,5 @@ module_init(arm_ccn_init);
>>  module_exit(arm_ccn_exit);
>>  
>>  MODULE_AUTHOR("Pawel Moll <pawel.moll@arm.com>");
>> +MODULE_DESCRIPTION("ARM CCN (Cache Coherent Network) driver support");
>>  MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/perf/arm_cspmu/ampere_cspmu.c b/drivers/perf/arm_cspmu/ampere_cspmu.c
>> index f146a455e838..426b3cfcb52e 100644
>> --- a/drivers/perf/arm_cspmu/ampere_cspmu.c
>> +++ b/drivers/perf/arm_cspmu/ampere_cspmu.c
>> @@ -269,4 +269,5 @@ static void __exit ampere_cspmu_exit(void)
>>  module_init(ampere_cspmu_init);
>>  module_exit(ampere_cspmu_exit);
>>  
>> +MODULE_DESCRIPTION("Ampere SoC PMU (Performance Monitor Unit) driver");
> 
> Curious: why do you expand the PMU acronym here, but not for any of the
> other drivers? If we're going to add these strings to all the drivers in
> one go, then it would good to be consistent.

Since I'm modifying hundreds of files treewide, I'm not spending much time on
individual files. In most cases I've taken these descriptions directly from
code comments, Kconfig descriptions, or git logs.

This description was derived from the prologue comment in ampere_cspmu.c (I
added "driver"):
/*
 * Ampere SoC PMU (Performance Monitor Unit)
 *
 * Copyright (c) 2023, Ampere Computing LLC
 */


> 
>>  MODULE_LICENSE("GPL");
>> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
>> index c318dc909767..c21c564840d6 100644
>> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
>> @@ -1427,4 +1427,5 @@ EXPORT_SYMBOL_GPL(arm_cspmu_impl_unregister);
>>  module_init(arm_cspmu_init);
>>  module_exit(arm_cspmu_exit);
>>  
>> +MODULE_DESCRIPTION("ARM CoreSight Architecture PMU driver");

compare to prologue for this file:
/*
 * ARM CoreSight Architecture PMU driver.
 *

>>  MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
>> index 5b84b701ad62..0dea47e48ac5 100644
>> --- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
>> +++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
>> @@ -417,4 +417,5 @@ static void __exit nvidia_cspmu_exit(void)
>>  module_init(nvidia_cspmu_init);
>>  module_exit(nvidia_cspmu_exit);
>>  
>> +MODULE_DESCRIPTION("NVIDIA Coresight Architecture PMU driver");
>>  MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
>> index 1f93a66eff5b..8b6ce9ea5a55 100644
>> --- a/drivers/perf/cxl_pmu.c
>> +++ b/drivers/perf/cxl_pmu.c
>> @@ -972,6 +972,7 @@ static __exit void cxl_pmu_exit(void)
>>  	cpuhp_remove_multi_state(cxl_pmu_cpuhp_state_num);
>>  }
>>  
>> +MODULE_DESCRIPTION("CXL Performance Monitoring Unit driver");
> 
> Similarly here, we now have a conflicting expansion of the acronym.

I'll make them consistent in the MODULE_DESCRIPTION()s.
Do you have a preference for expanding or not expanding?

/jeff
