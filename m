Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74AA3BFACA
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137677; cv=none; b=pGZY6JA6gYJ64gAs4eLb47IIJKVLzURP8MRsZvgdBuOYAHCrKo6PbjFGBpj+ubTY/h5V0u9sPQisZKLv80zBwnyulq1Trdq2m5Qy75O3FNwDBCWVUJ3Ci9R//UUX9DamScMrbhqyPzi9w0oW0VCiwLy2SExOonJSg0wsu9ZBLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137677; c=relaxed/simple;
	bh=nAfPvnptfbjoFJe+juHGr2q8t+Iwhsl/575MX0kpz4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/6/q4OEMzcxSAkoQUD2Spi29bC4aLQ5efZeY3gQVS7KvWYnY/GgXPJlkJYuxGVpb7jn2xEOKi5v/jDXvZ2ssNGRnrTxkklU0O7GK5pMmAozYB0MdMiP63j02cUP4+cAAY/tn/WmsNaB/PtXCA+ckk8bRJbH6dxg3nFuJ/lHEZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FPQAcWCA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KDfinyB4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FPQAcWCA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KDfinyB4"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R7SOfP2532932
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 07:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XJlPP6+uPJ9y9V/qPQMBHH272zTYCeTPmDaMF54LowI=; b=FPQAcWCA7LLe/1hV
	1x/lEVobPXwxnjiEZYhqCDHrfnUbeI4Ma9JqtfEkY+cfiO1N4UqURGzzkF9mjq0S
	WaDgbFFEjQ9tQS/0CcmNqpbM3MEpJ7ShJPy+R0+mzvSFhvaClLt8159Sb7DoMoCL
	p6138YI/UmeR2tc8m/FP5pHS4g0K87OnIk54a4jvJE55S0ddT5txBqCzXQg5TCI4
	WDWMRxOm1kbhWabtM3waO12N6h2SwOdXxUMoyJy53uiVgy5+WephyTwGrMIb29VE
	jJIZi4IdWb8dxDCYVI9VsMW8dHBDSZXUpSzLEJgDVFUDsV1bpz4q5XlrixG5JQhh
	jXZprQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmpajmtug-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 07:34:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c110a3b6aso34339881cf.1
        for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 00:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785137674; x=1785742474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XJlPP6+uPJ9y9V/qPQMBHH272zTYCeTPmDaMF54LowI=;
        b=KDfinyB43wjfVuLWJK/C55+c7QEI4+ae+TKlbQcVYoKr/nYWPiBPNxoRZiI4oI2QDL
         FDYPK5ck7uzjZNf2odwN7OfMH27s9U+IjZaC6Q2cSbW7KTXQz5rg5sM+rlW88I1Ec77n
         m3JNNgdyRkK/hdGzOkJlDabtKu1QCRtLRc+AMM8czsD5PqN2gj9eiyxRbYiu8ZagxYGf
         +7LzNWt5lwi9FJKeRIgEjWoj/W52bnqxibNXl6259TZL4vHhKSrQI+DfMDzaeWjU0KpD
         GGDHKQtK4ue3Ge58q/w7i4SjuTsb0RSyQmSbJzO/uxop+HOcUMi5DvOBG63myR/Km866
         nyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785137674; x=1785742474;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XJlPP6+uPJ9y9V/qPQMBHH272zTYCeTPmDaMF54LowI=;
        b=PfFNTxHBZZyWdZSJGddPzBy+Xu1LzrfazlBDZR83akftt4XV1LBEfX/xZtkQ/YWKk6
         CCtvNoDoYTtXQUzZqpBncDkSeBetT2NlGRJZPZovx5//l/F5njs1YpONYmIETJWL/TWE
         5RUDcPtk6uS5MiVFE806stKIYDyZalDbLK80DxhG+WZpRrubaknnMsFB5XVMr1oysRum
         R7uNFnyEYRc+JLoYD33S3WEEknV48CEr9dV+RZRGo68VlK3WpWPPhK5BT6/4LhM00Mbg
         hsRg6tIr7QgR6tfHh3HpaAQ1RrdW08OnQ9SNb95T2nTV/izNdWpeABaFRauSEL+9+XiX
         XwLA==
X-Forwarded-Encrypted: i=1; AHgh+Rr8bgBDR5ImOcOvwok7VcgxqOxr8oHZOQIZxiRi8edJ+qEdgJCEPfA9PKmbqF5EOL4YmVL2eZ1hfJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywti/x/Z+jQiEQN+DbUpUrPXVDkw6maf4xvf+OJK3JTHtzNYu7Q
	225vyASp+YWVJM9lH6tAcAsiqeA8a0HerCRveM/7dpgx4328hhj8+ToIw232d3S5XCfRi2+h0bm
	NcjOE4njcqGbGnkEg+TZZYFWeQZcgZ0JzZ6tHBueCJ72TkBZVt9VbiA/exjkCi8g=
X-Gm-Gg: AR+sD13vptrPPuE5/lgYsOch1ZqJxszd9bLYqulGg4nL7iVGCNq3D1ERuC0YNdf9xxB
	WgyfQ7fkEeaa2NJw5TmzuFdpWtdeWMNd2pHV0cxMKadpliJTTiiRfGfSQI2iH7AHNmB1FfdeyV1
	chxmcagvvWFdD+qFd23UAYuPEkCkPV4VZeNwS0mlwgDqjbPZUfY6hfJgt81A6dPPVtqHw5ap0Q1
	yiOPpEP3jCuj0X7QVnL9ajMigIk0DFfj1DTAhcLLqeBrcD6S/kQSXltRyJlHXMFqKLq2dXpJ97f
	SZ229DYNnbzKCP8KyYm+0mL2gpr4IwgEmUUXn1y7KaMdhcXX5+75pVrXL/tMq33r+enuIeJ8q4h
	fZpHXrZTh8D7BYb0NMEYZ/y0wRJQiuq8kbrX0/iNQjKb3F6R2ZHU=
X-Received: by 2002:a05:622a:2515:b0:51c:7b12:1212 with SMTP id d75a77b69052e-529a8758e57mr87086331cf.80.1785137674211;
        Mon, 27 Jul 2026 00:34:34 -0700 (PDT)
X-Received: by 2002:a05:622a:2515:b0:51c:7b12:1212 with SMTP id d75a77b69052e-529a8758e57mr87086131cf.80.1785137673897;
        Mon, 27 Jul 2026 00:34:33 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6ef25sm42900744f8f.36.2026.07.27.00.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 00:34:33 -0700 (PDT)
Message-ID: <47566cde-0739-4152-a9e5-1ff13904d9b7@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 09:34:31 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] block/blkio: fix compiler false-positive warning
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
 <20260727-fix2-v2-3-d0c4831ed7ea@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260727-fix2-v2-3-d0c4831ed7ea@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ttXMIjvf6ZuyBXl-xJHh50U_GmBMYltT
X-Authority-Analysis: v=2.4 cv=A8Bc+aWG c=1 sm=1 tr=0 ts=6a670a0b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: ttXMIjvf6ZuyBXl-xJHh50U_GmBMYltT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA3NCBTYWx0ZWRfX+OPmXHMHzR2k
 SSQBCKuxLa1NJYOgChYsEcncawSdk9Kk4ISdsTb6n+bGoaSW6BpWaS+WdqUZ05omOXeA21n+rCt
 J7Xezi5RTA23hmKS24SIT7D0Nts0XkylKvp+AQACiPdJ3PKS6Fdh3ddaG31MZQsYi4VuLhpx/p3
 2mqrAzGJyTg2Mda0I4nIGGYv9Zl7gcDrQDAWszB+Qtx1GBClkeFxmJ6RuXL2ydaS3Cb1QiT3dU4
 K2FXespoDMgdJRR9AfaAZyjZK506ZuWt2zaA53m07zJ3Ydp+zyGrjAgsZg1SvTr7HBB3cfRWuPS
 +y4P3MLhYn9X8MiGxf1vEa2INsgFdWWo9Ym5xBBKVVz187bbAP6JHUtUB6GaIdWgAwDYwsvDkFb
 A0beCBOI10De4Rri4CUU9CWt5me2PxSjX4XDz1GdZrR64FSD5ERxI2zEYDZTNc1c8fnjIeix7bd
 AoZQX+T2LRAmnZlrIcw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA3NCBTYWx0ZWRfXyZqnJwnxzbov
 AtkdfoUzEBU7u1Q+f0DqVrR8frPBLKTvHPqlyWf7MHTTG9CPH3dc1ju6U1Hd6Ei9t9y9mSNSyMv
 o9RjkhFzXTCIlR9vOB7r+xTZhlePNEg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270074

On 26/7/26 22:44, Marc-AndrÃ© Lureau wrote:
> Under some optimization, gcc produces a false-positive:
>      ../block/blkio.c: In function ‘blkio_co_getlength’:
>      ../block/blkio.c:943:8: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
>        943 |     if (ret < 0) {
>            |        ^
> 
> Replace WITH_QEMU_LOCK_GUARD with the simpler QEMU_LOCK_GUARD.
> 
> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   block/blkio.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
