Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5EF3859CB
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 06:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784787432; cv=none; b=Fd+xPf30aj8AV+VGM19IePW50/M1Hnm/PJlH7WXkWTPr+/Y+WDJrHR1KkZKPke2eab1bvJ50pyq6E8p3tnmiD7GD4ugzO4J7nKe4K874PuSb9BNF/X87v/1739nnm9yaNFJrtg2oBMZur4fHYHXhae/PTw5yH4hAe5IhHy9+NT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784787432; c=relaxed/simple;
	bh=iYyrjKJ/KJkfE1qflQgasWcqEFxs7klSMIU20/Px9Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAHSefqipbv4mzAiPr6FE0vVFaIXD3fY5Tm2msJMywvAg9JWJkVt9AjGTXgFMyKSXqcFhLI8iICccPo4mIEzrRMdQWlBPkwA85Y/EjwctGsevS+Ub4UMlXtZdSCS7IPqufi0Q7xPoiKB6+nPxi5fB0/l7jbpEUa9XidyFidDBw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jrjB2ovN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pi0FnbLy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jrjB2ovN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pi0FnbLy"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N6Aa0Z3274773
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 06:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7yveroT3Jrswv3t5GgZlyF3krE4zg30v7QN+83PhQdg=; b=jrjB2ovNQ7Rq/RfN
	ho4y84Ag7oANSvwPkBt1YzRHj2kRX/8SVGpJHQ0I+egkqTB5XfufDl+NBAZbcev0
	l1QQJDqBIy2zxLS9VZd5Lnzqhow/7K115yy7DWaC6XCgTuVRM1OtTNDoGLzb6ZKQ
	NWIvL082bNGlNCYf9eVHW+B1HTxI9bIurtn1ytjxHmWCPhYQDz1YxfkaOwtxfDdX
	mAZoCRioklEP7MSdCerMuEsurI9jLx5eYw63ZW+9rcGUxzzJfxTPx1HO/JyReIi3
	25cq9cw0s+IRHjW+hnMUlmiRZv4iO7dFtAhQtQdJzD+lZ/yc/VK/9W4Edfr9MYpv
	dB4LPQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk6c7hh3e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 06:17:09 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ef8249f871so7128336d6.0
        for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 23:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784787429; x=1785392229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7yveroT3Jrswv3t5GgZlyF3krE4zg30v7QN+83PhQdg=;
        b=Pi0FnbLy1Gz05u0IT24daAUwQYKTFa6SpUUJacxtpIUzjQHOh8nA1UiJEPlmGwwvdt
         ldA8u7UOKlFB3HkZPxR4EdBZnylZ7RtZjs8St7aB2TNv5lmZoDXQF2DSxfRd0TBYNcqT
         q+HmcrxFj1u78EWWCxvo1P5J6OjoSsGwiDHpWVP1rhAUY4Z6z5U+PJGn5rdgHWdlTvW3
         kktyLJgH2xBVC6LBxFYzMADuM4FBksBMuzy/kZV7NRteYLnKw4Y7sKuRyJ5EQO7TXSsf
         J7vsV+z71Vkx8MuUv0Jw7YSNDZ3bw7VVFBgWrg6dH8GGnR87sa6FbDl3Oldef7pPZ7pl
         m2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784787429; x=1785392229;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7yveroT3Jrswv3t5GgZlyF3krE4zg30v7QN+83PhQdg=;
        b=EM61tmN+GZVB9mgeKUEGvxiXMr7pGyAn+MmGHG4Umd2VIh8J0izjU3cl8PUz5DOgPi
         I1yB1uvGOozs40vJglhHyM2+p0c2Nwu+NBBvogXbYd7hiHM5TvVeYw8P9w55WP7FkMCD
         vNxUCYxGjPJ1i5b5XnFio2LHNvDF3dxranMWoY8xIPBigmIWSGCFwyCTCwaQtW3Tnu4l
         A9y6uJlGDvQo6mo9cwSbXz27VqqSzVKH+zUTzrZxYVn6+59O+tdVXQEHEaAOXMwsPKYv
         dqqxldNXGoNWmXnFLEz7Rqdf7UvFB+ZtcoB7J8LW1oGlzbrlXBtuz0nY3mpJMG4KV3Q9
         U3TA==
X-Forwarded-Encrypted: i=1; AHgh+RqoxwJs17xZYSL5ejDBn2mFaVEbWhB0iYlEI6ONRQlYTNeXjZZUaJhSTTNxP+o9lMU1KGtEbnfDsas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylbs0j/SFT+XkBcvsuaxFtAr6auguaFTsGeZAQt1jSNHymcs1h
	TSxPa7tPW6aoBe92v0S3/ZcAonKojeNwmlRz4cSskO/nuzwrsv19/RJO5YPYySmhwjRg7Pe5mQY
	qFC+A3s1W6ItqC5jSQzH/VmAf2YLoJPCcRp4di9rahbV3jrUFlwiMkn7pF8LQuE4CDTQeDIw=
X-Gm-Gg: AR+sD11BHXcM+SDMkCeHBs8y9oC7AhswCWLW79DuupkTfKK6sDK3U8Ff1wGfJ1seagp
	mY6YVmsONTFcFnkX3JnWHLw26h36B03Jxdx/DZh7kvhhjxy9ZJcOnKaSr7mCkTCO77VNCXUfOQy
	9WdDGLWTjvbyl1hjQpKSpW8AK1zZxvQD8v7+6+4IWNONiIGpdnyxP+SrzjPidS03lodEImErrSs
	kOfFb97NHL7Xo81ejwo/Hd8WOphGys7/bm5ua9COXL94F6HUHt3BYiCyAx4KyAJy78Xy+iItGBR
	hDwikgt+dFlyqRchOfzRntqlrHhth3/j7gkeg3gQwtuO3HVl27HBe/OW5w9LutLoQBZgDm0CrPL
	Bv3GNU6bPtjHQcvrgjkv8R6id7I6R7YrVo11IrsRWiC9zTthTwAg=
X-Received: by 2002:ac8:7f15:0:b0:528:38b1:b54b with SMTP id d75a77b69052e-5283de0e52fmr15754831cf.20.1784787428935;
        Wed, 22 Jul 2026 23:17:08 -0700 (PDT)
X-Received: by 2002:ac8:7f15:0:b0:528:38b1:b54b with SMTP id d75a77b69052e-5283de0e52fmr15754661cf.20.1784787428388;
        Wed, 22 Jul 2026 23:17:08 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85a2573csm11768525f8f.0.2026.07.22.23.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 23:17:07 -0700 (PDT)
Message-ID: <14f4c087-6d7b-4839-88d5-8134b8120007@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 08:17:06 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] hw/cxl: free in-flight sanitize state on reset
Content-Language: en-US
To: Junjie Cao <junjie.cao@intel.com>, Jonathan Cameron <jic23@kernel.org>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, qemu-stable@nongnu.org
References: <20260723011625.1117034-1-junjie.cao@intel.com>
 <20260723011625.1117034-5-junjie.cao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723011625.1117034-5-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: m7JsiWdvBMTcyP8JgS7LV9AZK-55JSql
X-Proofpoint-ORIG-GUID: m7JsiWdvBMTcyP8JgS7LV9AZK-55JSql
X-Authority-Analysis: v=2.4 cv=baZbluPB c=1 sm=1 tr=0 ts=6a61b1e5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=QyXUC8HyAAAA:8 a=yhWaLJ035AIv3j_7LEMA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA2MiBTYWx0ZWRfX61zfayI1dzOR
 bIyQaMo74NSmp2lPX/u9WdwaOyQqvq2g65K+L/5lR3mPRsWtPppW1iHM8j3wAE9monTu49z3FRN
 uTtF8tMDQFhpAeOEXdHBYfZizuWOiPA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA2MiBTYWx0ZWRfX7Du/Ok9Z5goG
 SkbkX6W5Mm4RQi9/kn+fBtdlGm3BMhr53gcyC/KO6lm28qGuCEN41XOyT6mUQ4IEmTj/oyRXE/f
 0Ij+Tkrdbv5wz3wnJTfR7FDOGAP1jISQsTcdzZu3bNbsE0w8Lm9e1urcGU/bSPKmp/mWJKTMcn9
 KLd27S1t4YbCXMqKwvVsFcZ2HpEgw6CuKuQ/ZtF3J53k6O6q/eIG8cvpHFboTCZcz1Facbaa56o
 zsRkl/buKRJYMDJBydQL9aIsurh8aV5pDBHqTkvqplrOlZA+pA2fcl5H2G0pRPFN9ovxk9Z7C0s
 Y+APSFQM0Jw1fMDfsYuX92TZkMAnygDKGBtfxyzIKDDE76bS2j0gOmLROTEPr0NsjxlOyPGT2E/
 VLvXWS0c44+RQljCHTxHpw4SX3uScbN698OYXGlPxOCpmsnkqdzoeJixSr7/8xLi1sana5a8T3S
 0Ff1APV70/mXik1M0aA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230062

Hi,

On 23/7/26 03:16, Junjie Cao wrote:
> Per CXL r4.0 Section 8.2.9.4, "Background commands do not continue to
> execute across Conventional Resets."  If a sanitize or media operation
> is in progress when the device is reset, the background timer is already
> cancelled and freed via cxl_destroy_cci(), but the per-operation state
> (media_op_sanitize) is heap-allocated separately and would otherwise be
> leaked.
> 
> Free it unconditionally at the end of the reset hold phase.  The timer
> that advances the operation lives in the CCI that was just destroyed and
> re-initialized, so the operation can never complete after a reset of any
> type; preserving the heap state across reset has no benefit and would
> leak it the next time media_op_sanitize is assigned.
> 
> Note that Section 8.2.10.9.5.1 additionally requires a device whose
> Sanitize was interrupted by reset to remain in the Media Disabled state
> until a successful Sanitize completes.  That latch is not modelled here
> (reset re-enables media via memdev_reg_init_common()) and is left for
> future work; this patch only addresses the resource leak.
> 
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>   hw/mem/cxl_type3.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b842e71c66..a5e6df3033 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1361,6 +1361,16 @@ static void ct3d_reset_hold(Object *obj, ResetType type)
>       }
>       cxl_initialize_t3_ld_cci(&ct3d->ld0_cci, DEVICE(ct3d), DEVICE(ct3d),
>                                512); /* Max payload made up */
> +
> +    /*
> +     * Free any in-flight sanitize state unconditionally.  The background
> +     * timer that would advance it lives in the CCI just torn down and
> +     * re-initialized above, so the operation can never complete after this
> +     * point regardless of the reset type; keeping the heap state would only
> +     * leak it on the next allocation.
> +     */
> +    g_free(ct3d->media_op_sanitize);
> +    ct3d->media_op_sanitize = NULL;

Maybe we could add as cxl_cancel_media_sanitize() helper in
hw/cxl/cxl-mailbox-utils.c and re-use in __do_sanitize()?

Actually, I wonder if this shouldn't be cxl_destroy_mailbox_t3()
to match cxl_initialize_mailbox_t3(). And if so, then also call
in ct3_exit().

>   }
>   
>   static const Property ct3_props[] = {

