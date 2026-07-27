Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4E63BB9E1
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138009; cv=none; b=sI2Q1ZvwIi39gqlPpjMROK/Ts0H8foPBV+C3Uz4S+p5rbpuoyA9U30u86oiApdz1a770uouRersESZluCf5Vpu4qt8e2dDr7VgNqwryfUzUK1m0sc9WDk/WEsvMxxt+V/X5PeFEbZ1Sr1PIHcJI/LG861jwi1y1QgAD8PR7JQ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138009; c=relaxed/simple;
	bh=9P0m63De//IVirZvvRdvf9hPi0ZqXl4EdikP+mfJeAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmo4UJ8/ZzbRgtPah1cVQrB5n6IGGnuxXMDr7RBsJQ1MkOLVAMnabizqeRU/e2QqAdDFMYHDQ/ZPAakaVgy7G7Z3vZVFm+7Zd9zwEaazf09xC9wuKmKkgpawFwz1Knv2eLHXChFQdEqeEadIWWA8h8iF+L51OgLGaGYeDPu/5ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U5Xhijrf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CQDI1MC7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U5Xhijrf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CQDI1MC7"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R7SGqv3339732
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 07:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iBfkOdqV37oVZnVxDNf8UxS8CIuif2Im/W5r9GnoYHI=; b=U5Xhijrfk4KmN79h
	Cpppi83C18JJnsFzNpfzzTGTXFTNTyaNsAhejWVWNZ9lz+rJ9u4hDQEjldC8Wecj
	9ryj2fSSlEti2TIxFUu1zPomJaGHuUhDnaat4Sw/kcE3wdCcQPQ0ImW7iEfJrXjs
	uijgBK+HxhN6XYFm7EMxfNx1rG6B/o8viGthgjKkNNghgn+JpE39ws8tFb+c7g2o
	uBEpjmX+YhvCl7Jxg3F3OWhFFOUAcLjnY7s6RN5QxfIUgUP+/s5btAyTf5scBp4E
	0oKWzuRhAs+EC2Ld3Ls/NhCK6coBy0LpKYQ2xWbhY7T8q5FArbf6mp1GUwWZbEOv
	FXGWHg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmm3sd542-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 07:40:07 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c12e43b98so30926901cf.1
        for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 00:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785138006; x=1785742806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iBfkOdqV37oVZnVxDNf8UxS8CIuif2Im/W5r9GnoYHI=;
        b=CQDI1MC7VQV0LzZnZnKw6up77rF1go2S8mYZc9FXr+CiYXGjEA5axFrHsf9yhMHkMw
         0Qvpq/PVprW3muhGJYqsnDEABsYOoT/Ij3Nfo61uiWH3otgOiqaUwkpRMNWc66iALHQG
         KzyvJn0RBXvRFzSegB05N4W7Wa5RU7IBr/cXXQ/o/Llp0n1W09WNg9JkyYUC1TOyHEDa
         QRdn9ILtb7IQkMTRj6i/BQBG4roaPyWRczk/P3U1q6taI6+jEtaWl9+BtFoMZeEnUN3S
         4QtGtE8+arb3EqKvCESSRN1crAawosz7kEesWkK0VT0Fe8sleMBB52t6qUBIRMzdDbWd
         JR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785138006; x=1785742806;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iBfkOdqV37oVZnVxDNf8UxS8CIuif2Im/W5r9GnoYHI=;
        b=Bd4W5rn/LhuBkMpIsjC1alcxGVBaZSl/JffZk/coCLg9xiE3pe42zZh77IjrUPAyLo
         5heuzPsBy+p66qqH2dfWHLQgxpbuQw3HBTHD/+9fGE7qpctaFRUWzj1+w4c2q5Fl/pQA
         YHMJG43ElE3yyRBADta3MaUSYFYCIYTdH0JI3W9Xb3x4Q0C1LIFjyu5kb7WIQVqgbJ24
         0XAxxnn0ltStCYufgTc5fehsjNcH4M+dSaaN06XHiSfjJF2Z5jloXmIb8Zf3CEEJ5zz4
         2iX5qYtmBqzbv9QPSmNGfRBWnMFY0D1sutFzwqg3AuXvF+Gs47eipo+VIukxiXZfqHzI
         W2JA==
X-Forwarded-Encrypted: i=1; AHgh+RoHKmbwzL3EchijNI5R9ApGJF3E2YSrNJeFn7Y3pBm2pqa6cZ2LlwzTnc1Eitiz9/MY3t8yggo8BVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4R+yhDHCQAnL6jlAaiHR/yk1pDRfRX0RtmaqOKvH7nECMZU2U
	DaUUietHWAIEaK7bmDxUWXbgYIdspWRqBlKLsqAF7MvtdUJ/LUPJrGepMbjlJ0cHnAr0oav4Y4g
	IR7/A0JhgKnUhb++VANyxVBDx2XNd/8DTO0dE+YP6qB2MWgJ6NRISz2k5+c1guiE=
X-Gm-Gg: AR+sD13TIQR7tfd7SsSi6xfRZeSN++2dsqpzc2rzMaBgyEszEWD90saLauIkHqsV9ec
	So29ku4wy1I4or4lsdKLVKwLzxr5zlYfe/qzQKnFSaw1gR8VHCQId1hJI5RrrUoTRVoAW6OP7tk
	ht5LehQJwY9eQVgKzUvGja2wecBAjWXqIUjUsZgnm4hfBRIR4vfdN7ZgjxO+4euWD9deyczWqyK
	aaU7lXp+xzKa0m3c2QN7JzEFJWh1IAoZI3Kr/f09vlmODUlH/B+mQYjXlYer4pmLSuSOar1DUq0
	dxuv6tgWfWoyFUM6Vr9d+S1Ev1IY01WFB2y0h3FOL+Q6Fmax9QpEDovVsqXvxckl5uQXkxPOcZV
	oW3bZkmCJ141XNeL9QpQK8zURpdkvp4PFXhD1FsqFihuTKWZcuUs=
X-Received: by 2002:a05:622a:e094:10b0:51c:13d6:b4e3 with SMTP id d75a77b69052e-529b3acc196mr28044021cf.64.1785138006237;
        Mon, 27 Jul 2026 00:40:06 -0700 (PDT)
X-Received: by 2002:a05:622a:e094:10b0:51c:13d6:b4e3 with SMTP id d75a77b69052e-529b3acc196mr28043901cf.64.1785138005869;
        Mon, 27 Jul 2026 00:40:05 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b842691sm232369865e9.1.2026.07.27.00.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 00:40:04 -0700 (PDT)
Message-ID: <0206544e-1d58-4040-9cd1-f36c917d88cc@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 09:40:03 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] hw/i3c: fix default return value of
 d2_i3c_send()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
        Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
        Jonathan Cameron <jic23@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
        Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
        Phil Dennis-Jordan
 <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
        linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-6-d0c4831ed7ea@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260727-fix2-v2-6-d0c4831ed7ea@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA3NSBTYWx0ZWRfXzvZDeATTYbse
 RKIW5lrwHCfYDmp8pKhruuuDh2BP/0GCHObxACdtu53YnOWqL+sM00bHImP+zo29bYdYoXThkYb
 AfobVY/v0xh/oMi/0RnOMrF2WUBfNWtW4kLlGJTiD/fZ2P3AsPtcR9HQ//1Cf7E1uxCmr26vTNN
 liyUFxipzJs0ELh4ynYCv4YosJ2CTaY9tiVJJVaHfFXg/GmSBRU35oXpQ8kzzfEZHOVy0kl/MTY
 OcN9NN81SRxTHR678+k5sYXnuN9MFOqbH250BwnmhyNlwjL9FvjXb7vcJN5Gb6fC44Nhzx3VANw
 j/ji6QwT9IhbV9IE6dTK6/jec/r6qbcuKtweOH48ONpQhn+X4qR7LkNz+LbHkLbxwqUKJusngcc
 i5c8tZS0Um1QAtB5h8TMGliFhANc7Qi+XU6Mc2BmWlVvC+J9vvQegypQESogfDmtwhlGvk+4L+7
 +1SyhJsfQbtF5PqlBpg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA3NSBTYWx0ZWRfX/yRBnI445kmW
 T+EAmE0smqp6VxoSXBiGU9HdKpyc5FdFYvKHKKpl75+gBLSBgGFSuqV41FzpHP8gl10m2eolF3h
 V5gn7uJcCnTk1LuB8o77vKzPEbyIeQM=
X-Proofpoint-ORIG-GUID: w-nEbp6TA1AoEqgRgosjqr4by--2gnUn
X-Proofpoint-GUID: w-nEbp6TA1AoEqgRgosjqr4by--2gnUn
X-Authority-Analysis: v=2.4 cv=KanidwYD c=1 sm=1 tr=0 ts=6a670b57 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=vpC8OiRf_cHKS7sXZC8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270075

On 26/7/26 22:44, Marc-AndrÃ© Lureau wrote:
> Fixes: 208772a189f9 ("hw/i3c/dw-i3c: Add data TX and RX")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/i3c/dw-i3c.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
> index 6386499dd9fc..7b887fbd60cb 100644
> --- a/hw/i3c/dw-i3c.c
> +++ b/hw/i3c/dw-i3c.c
> @@ -430,7 +430,7 @@ static int dw_i3c_send_start(DWI3C *s, uint8_t addr, bool is_recv, bool is_i2c)
>   static int dw_i3c_send(DWI3C *s, const uint8_t *data, uint32_t num_to_send,
>                          uint32_t *num_sent, bool is_i2c)
>   {
> -    int ret;
> +    int ret = 0;

So IIUC the issue is being called with num_to_send=0.
Can that happen? Apparently no. Could we assert it is
non-zero?
