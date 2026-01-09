Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9285250096F
	for <linux-cxl@vger.kernel.org>; Fri,  9 Jan 2026 04:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767933860; cv=none; b=uxiEBAxD6FYqoIVOGtnFHOrqitSmB5LkMCQ1S2CpQ0j8F+pbon2SPx2OPMETICUF13PjS3rI7ycVFt1AGKhRoWUh0l8sZbs8CuEaUZSVPJ8/gofp3wJOHtElTdLfuXZyFGslAvjuS39xKQKG9FLkAV+g1R2bHL41wEWD/ZcNB0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767933860; c=relaxed/simple;
	bh=D0UGfay3dsna+FGkp+Qbtn2m4AUWrP4lzsCEMgm1HfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oR2ZAt34hTZvEX6dZChbOwJkN6Q1jRkfX8VmQwJkwu0gPmUdB7tWhFmYlwk7FbmOudvBzgD0egBwWzf9ncgGanIAQUbSLHjRdudY1g6CZodRAdrzScb8Ap4mxHlTco8z4B3zNgBYaOc6wwVF8tvAcEWcGKidIM9Ee8WFAJIl9qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h3D7YraT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kqkVsx1t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h3D7YraT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kqkVsx1t"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608Hk88r1701990
	for <linux-cxl@vger.kernel.org>; Fri, 9 Jan 2026 04:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9PMU9ieb1QmCoXo11coZcBcipTvyHbkjE2lSzxbfThY=; b=h3D7YraTfVmsM947
	ssAm268Ecx0hciT9Z4P/p3YNMwdJ9No2awOjCMsug+ChBVc941iiP7TldxzGPBqa
	V/JTyEzFcTqAt/HJYh9eGijEQQDJL+pnYzzb/W28YmE68ZBNqijzHFtOTf3rJjvT
	yY4rryx0RtHnbufPqf1fuu5ZQQCQX7BSwlLdaoUNqfQrH6joIplWawpsULAeOloN
	FgIdSEn+3IavIxmfYxdal/UJBXhquwNJP6lfsJb1TZZfuOPohHeVVLRaawdjqMfb
	wB+15Ywi6Usvs4R2Yv6pntwve3M+nZkybOdtMn6YTUAVJojbD+7ImQf8NLT/pOe3
	zPBMYg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjfdaa0ge-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Fri, 09 Jan 2026 04:44:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a090819ed1so28778845ad.2
        for <linux-cxl@vger.kernel.org>; Thu, 08 Jan 2026 20:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767933856; x=1768538656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9PMU9ieb1QmCoXo11coZcBcipTvyHbkjE2lSzxbfThY=;
        b=kqkVsx1trpcyZpjo5TPryavkmSObWjksL2SATronXcw8c1EVkd5weNPFb0pX6MxL83
         DzWm/cQKz9+DVqbkE+K+hKa/itsJ/w3HU4R3uU17u9/YeHl24yifwNQ7evcTej5IGuH6
         sxS3AJEjGHkqJN0hiRhsP6SaTmjumW53q4s4bBjNmh3ZWBFGJcz7uA8cElbylkAK2BKh
         HOkTzKgT2deb0Y49jMx4kFVIIF77uhnMQu3zhm9QfrgV3rDM5TQHK29t4L31b8ynmcGN
         FgcqHBn+QVTu+2Av2hYnWJ/qtUiwR1/NuQs1Q6fGWyyF6S53SvraZ27JZTCBjh913RyF
         dQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767933856; x=1768538656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PMU9ieb1QmCoXo11coZcBcipTvyHbkjE2lSzxbfThY=;
        b=pcGh75KB/6zwnqZNylLg6gFjLJy3NIiyCa0p7wP+Xf4Zr3cLDNZMRoZkeAaBoe+2Iy
         O6coX6HiXsJnLInd6Y/6kWyz25FmCPZb8BySuZ0aJHPCSzZD7ic7dxSsmE+dNwRS/U5F
         p76aRGqfZbKsnMoigFfDnq/nMau4S+T/51HPWY2mnfN3ZpTrdyvGawbq0KP9g9uyd3bp
         m8qSAeA3TyhxAXutOVzF8KHwwF55d68ONDCwgkW0vgbvq4G+mKT5etTroEEv2eZffAD/
         kAy2o5tQXrt3pUWxQsDqRYW+ZgA2pZYg0IFculc253btL33HTFpcYiLIXxEbCisF6m4f
         Z24Q==
X-Gm-Message-State: AOJu0YzJ50ox87G/2cqI85tJicaYu8AS6q7wWJH6WhlY+jYREk6FBfox
	Don+A/IpRXQmpQsxIkx7xdtKR9RscvuAGLq+zN4mttebps6j3AtoQkBIpUPNhn6QA7jAndh4sZM
	T5rixRLyQUt0WiXrrUmaWmx+ZAciwWgaW3kadqS/TXqRtJk3mWk/VQfQauCWgB6I=
X-Gm-Gg: AY/fxX59Z92J3Df29AVKVJDyOl3UgquVmsBRU3dCosPXfRu3xYaYIHrw3fcyLCOV5Cy
	Lp+CTW2UZoMw1ZBmuXCEY4T3jkDw+xNhmdAcJvvZU992KHWTWIMy+7xcGjXBMWtd8MR104Zwh4p
	UdtOKB1VropK5+Bb2TU6iFP8I59ZhrXhMA3xke7TNwiDi61jTE3i84qExbXzkPMNegqrmM6Yp2H
	51MUjGb4U3uMo2AHBWEQ8i0C3lj/hFUZ7ii6d3hPQz8YxjUiRwoWP1waO7VcQHdi9xsQRVVVUyS
	YSjOsL9dNiHpJIyklG7DXin6OTx7oNiwzoOca524z8gQaH1HZtyFnWyjgoQzkLdwxF6kb1AWZmJ
	/rqwaWx8Vc6iBqa2DHh8mdpq5RSzrf4Rp0zsSrmq9Co0=
X-Received: by 2002:a17:903:a8f:b0:2a1:3e15:380e with SMTP id d9443c01a7336-2a3ee4aae30mr77088425ad.34.1767933856409;
        Thu, 08 Jan 2026 20:44:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFB3u+HKizZWgXaPWyivW/bF/qgEHwpzZILB1cDaAISw9tmf93lNmF0fhBODQ2Q/mtucKddLQ==
X-Received: by 2002:a17:903:a8f:b0:2a1:3e15:380e with SMTP id d9443c01a7336-2a3ee4aae30mr77088205ad.34.1767933855925;
        Thu, 08 Jan 2026 20:44:15 -0800 (PST)
Received: from [192.168.1.9] ([122.171.107.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd2b3asm91438525ad.88.2026.01.08.20.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 20:44:15 -0800 (PST)
Message-ID: <cb77c9eb-6dab-4147-a0bb-ce488524beb2@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 10:13:11 +0530
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mm: memory-tiers, numa_emu: enable to create
 memory tiers using fake numa nodes
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
        hannes@cmpxchg.org, david@kernel.org, mhocko@kernel.org,
        zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
        lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        rppt@kernel.org, surenb@google.com, bingjiao@google.com
References: <20260108101535.50696-1-akinobu.mita@gmail.com>
 <20260108101535.50696-2-akinobu.mita@gmail.com>
Content-Language: en-US
From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
In-Reply-To: <20260108101535.50696-2-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ue1ciaSN c=1 sm=1 tr=0 ts=696087a1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=yzROskTkGupuC83a2laO1A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=gTkrCQ11ykXsVYlltkQA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: uN9wM_7X8qwS0BSkZ-rp6ls4uPGtWUnz
X-Proofpoint-GUID: uN9wM_7X8qwS0BSkZ-rp6ls4uPGtWUnz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDAyOSBTYWx0ZWRfX++6Jy1IRqdKi
 mJJXb874v+XyQguhogLMUq/VlmBnhh+Nm3iI/vfWU6XGbbtRB3g9ivLVNWtYwEzcHJvj34DW+kl
 eAMutBVknmWRgHqt7r5NDX5yjfZMnU05wz8sVOXzrNL2iA8OiyW4VDImjdUSZF+mHkmdV8zE3W/
 SxOAQc1HbUewGj1DHIzj6N6gDepSsVEufuCJhBjRbMysJ0lvaDVtJTdUo+rsfP03+kIpQX3GftO
 qfwQnFVHcSxAV1ac7JTuL3i0TNjPd8wt3tDMccnzcauFN2i/+Hod3+6/0AnLTdWIsDxF8WGUoVd
 2w5Qz0iPxnydJ2Z79oi7l5cMSPC+bsHnbcwZaSCfl44YAIX89Hw44z8Ine8ehp3X+dqm+lYGDjH
 LH/OMV7oNZHR/BcbCTlFTHnfnGbb0U0jNuFkZ7SiNupxR3Kd8/A8qtYpuBQix0r9AKajrxSoWEb
 2CdvqvcMaT5SuT5gMxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_01,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090029


On 1/8/2026 3:45 PM, Akinobu Mita wrote:
> This makes it possible to create memory tiers using fake numa nodes
> generated by numa emulation.
>
> The "numa_emulation.adistance=" kernel cmdline option allows you to set
> the abstract distance for each NUMA node.
>
> For example, you can create two fake nodes, each in a different memory
> tier by booting with "numa=fake=2 numa_emulation.adistance=576,704".
> Here, the abstract distances of node0 and node1 are set to 576 and 706,
You mention 704 in the cmdline but then mention 706 in the following text.
Please correct the typo. Btw I am not entirely sure if this example is 
required
in the commit text here. The Documentation seems to the right place for 
this.
> respectively.
>
> Each memory tier covers an abstract distance chunk size of 128. Thus,
> nodes with abstract distances between 512 and 639 are classified into the
> same memory tier, and nodes with abstract distances between 640 and 767
> are classified into the next slower memory tier.
>
> The abstract distance of fake nodes not specified in the parameter will
> be the default DRAM abstract distance of 576.
>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
> v2:
> - fix the explanation about cmdline parameter in the commit log
>
>   mm/numa_emulation.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> diff --git a/mm/numa_emulation.c b/mm/numa_emulation.c
> index 703c8fa05048..a4266da21344 100644
> --- a/mm/numa_emulation.c
> +++ b/mm/numa_emulation.c
> @@ -6,6 +6,9 @@
>   #include <linux/errno.h>
>   #include <linux/topology.h>
>   #include <linux/memblock.h>
> +#include <linux/memory-tiers.h>
> +#include <linux/module.h>
> +#include <linux/node.h>
>   #include <linux/numa_memblks.h>
>   #include <asm/numa.h>
>   #include <acpi/acpi_numa.h>
> @@ -344,6 +347,27 @@ static int __init setup_emu2phys_nid(int *dfl_phys_nid)
>   	return max_emu_nid;
>   }
>   
> +static int adistance[MAX_NUMNODES];
> +module_param_array(adistance, int, NULL, 0400);
> +MODULE_PARM_DESC(adistance, "Abstract distance values for each NUMA node");
> +
> +static int emu_calculate_adistance(struct notifier_block *self,
> +				unsigned long nid, void *data)
> +{
> +	if (adistance[nid]) {
> +		int *adist = data;
> +
> +		*adist = adistance[nid];
> +		return NOTIFY_STOP;
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block emu_adist_nb = {
> +	.notifier_call = emu_calculate_adistance,
> +	.priority = INT_MIN,
> +};
> +
>   /**
>    * numa_emulation - Emulate NUMA nodes
>    * @numa_meminfo: NUMA configuration to massage
> @@ -532,6 +556,8 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
>   		}
>   	}
>   
> +	register_mt_adistance_algorithm(&emu_adist_nb);
> +
>   	/* free the copied physical distance table */
>   	memblock_free(phys_dist, phys_size);
>   	return;
Best Regards
Pratyush
