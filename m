Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1913845AF
	for <linux-cxl@vger.kernel.org>; Wed,  4 Mar 2026 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610934; cv=none; b=iFhzmMPyS7LdFOZBShYjJDju/bNy1MFhyJoQYw0TU0C5xNJX8njL5LxI/Ig43WmtSLu5CCxT0ZujcFrU1oMyJlke8pnsR3z+skC6TyvHva9Djms4FDtSQ91JkchFyADgRs3FQ0600LD8xsJ1TZn5CodLK1SF0AGa0BKQ6LLsngk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610934; c=relaxed/simple;
	bh=spW69giXt3iCN4mkbiiykMqhdbJz858ckzNh6YJB1eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLIore/i7GGB1+wfIBrcD4eqTEbWeVO1XSt6m8wzq3PWy+PDixVygZ7gD8O3NkPSfbY4vngFyz21i9YZxT0DEkAdLGTI0+CYdn9yBNqK9cJVHGp1jTT/8dgpai2D+5on9RMV2+4a7n+eUaIUZhW7AmFrUpQnjbi02mIPBdZsHq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=PXeFPg/c; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="PXeFPg/c"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c6e3e4e7388so2608227a12.1
        for <linux-cxl@vger.kernel.org>; Tue, 03 Mar 2026 23:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1772610930; x=1773215730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d26wglEJJkjfXy3+5eMzSRmt/fkICHWyBpSofh5tqJc=;
        b=PXeFPg/cO2a7GlRjcQnO8q/cWrYEw+hoRr4fVpstdRO1e0yqJGeVQUBngcwuFbFaX4
         UgKNWLYF6G8dcQ7iyy+cNAvTTjvUyRNNysK9UPIirTnOujTZdEdh6D++GMnQ7FJPnQSn
         pWrc93Nq1M+DWRpcFEHxaX2Uql7DRlImsrXl4COYyL0kviFp9N1/qppM41b77CURptKp
         8WkYPqWpSby8r/QyZO8HEYADdKlpNUvrwrgRktSxdSioNxHq8p9D72S6N6WykdwO5VHY
         NACsaCY9DTRLDPn3APLn6qNxNx0d+/i1WBuYmdYQoTOdErcIpukiTCss5jOkGAwTfkXd
         TOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772610930; x=1773215730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d26wglEJJkjfXy3+5eMzSRmt/fkICHWyBpSofh5tqJc=;
        b=cukhe0ryCnq5T77IHyvtaE5grKo7VBg9fVjKTSQ3t/EUYxHDZDhCUo60f8xKTpVI1F
         /kU3rX/INZAs7AYhjVzj4iGg495afMUWmgXE/ddCd5ipC4+lpVPhaIxnYPGEGZqgAQAp
         CHSGdTthmHGlOkJvr3llzwnh1YTvElil4lyasHGbOSK0inGRHLqjW/4StM0MMyWfjSDb
         EuNMA+bQS0BZUt4a0Gzf6M+Ex/Zl7o9wYgxJJBuL6N26OjZ6p0+MJIbrqw4yh4qXSqYs
         l+m0KccCWFF9ODRjByl43fMQelaTzQ+DxJyh6yDSDJZZJACDxkusyhnnW7LYoIOxIYRs
         M/+w==
X-Forwarded-Encrypted: i=1; AJvYcCUUY7FfvDZIMAC2AbiIPFmM6xKF9Xl/zKGKB1W9fcwy3UvVGyoQxvdy0Bva2ze9SSpIOB94B/vQikw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWgZy+go5lV+e+6if6CeHmN3Eiw+Wyr8Cv9E69qt1jIA2P9sgi
	tPAK81/ZYoqWFQLb+1ppLsf/vkITEZ/gSUhZVqq5TBA6Frc3Hya/+kyrA/TlP9ljyR4=
X-Gm-Gg: ATEYQzwhgb/FenGY1MzCDZk5zk9EaOT0u0H89KiaFjCzCigKJ/IP7VKz9c7Y2gDe+kx
	62TpMSPhKIJy5Jxm3g83nzY9a2jcxtWlx+ygD0WaZkTwvufccQmnMxsJoFgFQC7pCxe/LV0Tlx+
	CwtigOiS6e6icXx+/HRwFdGFptCO1dTTCy90TLNth9m/Sv6nbdLleXjWGgje4PkxXpfRY/GqMtn
	PVyufsZNqNwWNOxJ8SqvP02Vz4/ij2jt/FJVdjyfTjWr9K+K5xGVr5WAdB/sLiRu+Lv5iwf3q4Z
	PJ7eaWkyO7JxWfjnTOrCLpqmRkFd3BYksNhnk/if5V3viYVnvcIY9de+KJjRDy8/leMTRK4rGif
	DM6b9nBp4MxISW4zwMMligTFiVbZ9TYlBZhnPAAM9lZ8fkpHCOzSZXsTICZsmHAV8M6HYAhOeIY
	ecnkSaXcHZpLu+UinuTzSvjTxSD0cnQya7yNAR
X-Received: by 2002:a17:90b:2884:b0:340:ad5e:cd with SMTP id 98e67ed59e1d1-359a69adf47mr1114314a91.5.1772610930325;
        Tue, 03 Mar 2026 23:55:30 -0800 (PST)
Received: from [10.54.26.107] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359a8e768efsm364872a91.0.2026.03.03.23.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 23:55:29 -0800 (PST)
Message-ID: <751572d2-2665-4a67-8098-2f3a69668e0f@shopee.com>
Date: Wed, 4 Mar 2026 15:55:23 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: add a boot parameter to disable parsing CFMWS
 during NUMA init
To: rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
 jonathan.cameron@huawei.com
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260304064609.75585-1-haifeng.xu@shopee.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20260304064609.75585-1-haifeng.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2026/3/4 14:46, Haifeng Xu wrote:
> For the machine Intel(R) Xeon(R) 6746E that supports CXL memory,
> the possible node is 20 (0-19). However, only two numa nodes (0-1)
> have memory and the rest (2-19) nodes detected by CEDT is memoryless.
> 
> The problems is that when creating many pods, the shrinker map size
> need to be expanded for all memory cgroups in expand_shrinker_info().
> If the number of possibles nodes is too large, the holding time of
> shrinker lock grows significantly.
> 
> In this case, there is no CXL memory inserted in the machine, those
> memoryless nodes are useless for us, so there is no need set them to
> 'numa_nodes_parsed'. After disabling parsing CFMWS, the pod creation
> time is reduced from over 10 minutes to approximately 150 seconds in
> our intertel test.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  drivers/acpi/numa/srat.c | 29 ++++++++++++++++++++++-------
>  include/acpi/acpi_numa.h |  6 ++++++
>  2 files changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index aa87ee1583a4..8716d70043fe 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -31,6 +31,7 @@ static int node_to_pxm_map[MAX_NUMNODES]
>  
>  unsigned char acpi_srat_revision __initdata;
>  static int acpi_numa __initdata;
> +static int cfmws_numa __initdata;
>  
>  static int last_real_pxm;
>  
> @@ -39,6 +40,12 @@ void __init disable_srat(void)
>  	acpi_numa = -1;
>  }
>  
> +void __init disable_cfmws(void)
> +{
> +	cfmws_numa = -1;
> +}
> +
> +
>  int pxm_to_node(int pxm)
>  {
>  	if (pxm < 0 || pxm >= MAX_PXM_DOMAINS || numa_off)
> @@ -313,6 +320,12 @@ int __init srat_disabled(void)
>  	return acpi_numa < 0;
>  }
>  
> +int __init cfmws_disabled(void)
> +{
> +	return cfmws_numa < 0;
> +}
> +
> +
>  __weak int __init numa_fill_memblks(u64 start, u64 end)
>  {
>  	return NUMA_NO_MEMBLK;
> @@ -648,14 +661,16 @@ int __init acpi_numa_init(void)
>  	 */
>  
>  	/* fake_pxm is the next unused PXM value after SRAT parsing */
> -	for (i = 0, fake_pxm = -1; i < MAX_NUMNODES; i++) {
> -		if (node_to_pxm_map[i] > fake_pxm)
> -			fake_pxm = node_to_pxm_map[i];
> +	if (!cfmws_disabled()) {
> +		for (i = 0, fake_pxm = -1; i < MAX_NUMNODES; i++) {
> +			if (node_to_pxm_map[i] > fake_pxm)
> +				fake_pxm = node_to_pxm_map[i];
> +		}
> +		last_real_pxm = fake_pxm;
> +		fake_pxm++;
> +		acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
> +				      &fake_pxm);
>  	}
> -	last_real_pxm = fake_pxm;
> -	fake_pxm++;
> -	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
> -			      &fake_pxm);
>  
>  	if (cnt < 0)
>  		return cnt;
> diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
> index 99b960bd473c..2435f60e56ce 100644
> --- a/include/acpi/acpi_numa.h
> +++ b/include/acpi/acpi_numa.h
> @@ -21,6 +21,7 @@ extern int fix_pxm_node_maps(int max_nid);
>  
>  extern void bad_srat(void);
>  extern int srat_disabled(void);
> +extern void disable_cfmws(void);
>  
>  #else				/* CONFIG_ACPI_NUMA */
>  static inline int fix_pxm_node_maps(int max_nid)
> @@ -30,6 +31,11 @@ static inline int fix_pxm_node_maps(int max_nid)
>  static inline void disable_srat(void)
>  {
>  }
> +
> +static inline void disable_cfmws(void)
> +{
> +}
> +
>  static inline int pxm_to_node(int pxm)
>  {
>  	return 0;

Sorry, This patch is deprecated. I'll send a new one.
