Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E953DC861
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136897; cv=none; b=spkNjMQpkhfrWvcLkAfHc2CRi8Q7Y8tEubCDNuew5E3WeAB9Gr4gjsOtO4wtStDY7HS0W/E78mEDm4FPE5NUM3VGfnw7mxbH4XRpoIMbwd9hFzF33E6xbmfOHBaB50AQVDT9v0zvB/5AUN5oMXE9Nbn/yiaWCJN+iZ41fj/AXtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136897; c=relaxed/simple;
	bh=j5h32L1Hp7BH1yrownVQVrrGStDsJP5shWP3mDt8slM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xdfs+UEGIjuQga9GRHU0RjkZAVF52miVzfrgyQFbNtIO+/P4/HZ/pEjNi2JB4NLiwzWTfLyI36PAe0tAQiej4QcFtfiX0HUhLD4VBlV35eWe/iW798X9BU/CA4Y8yrdJcNg2uA/LcTP2GBNUxKfeKUkcbEgS+jJDtVFBVP3CJXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EL2iPqfy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dBouj2bU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EL2iPqfy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dBouj2bU"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R1foZB2466623
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 07:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n9Aos/jywAp1KiMqxdiE8FS02FkmBZsX9G9dQPrcuvQ=; b=EL2iPqfyrvykxEZa
	MFiIQ+lSCqpY0dq6MTGp18qPgDTC82WXawL2HenxIA5MlUO15NozzHXVbLLpfkvi
	8MaMguk/OOYpkbFmN9yrJcWP8M/m1PPSkii9gtLTmd42ol9mQ5LbcCsUK+ekAkPQ
	3t5bwh/Wd1sUOXBgzyjN2jCMYKUzkrYOSeKHliskf/RBkUf311JSJ8L24A2wqtYx
	NstW3BXVnO3J3WCVZAJ3Uf/u8y8gwxHjwzVueiJo2/l3rMYbZQE/Tm+Q31ppiT5M
	tUHFcoJ/2m4xoN5b7sSEf+I3PoOFP37DRL5e1qbqGVZj0WNjZr1pstUTxXUOeOqE
	l4M3QQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmm5756mn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 07:21:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfe3fa93bso29361101cf.2
        for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 00:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785136894; x=1785741694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n9Aos/jywAp1KiMqxdiE8FS02FkmBZsX9G9dQPrcuvQ=;
        b=dBouj2bUSQPV5+aWWsG0VQFiGYLkw8+z/zev08Rj2wVyPdcnzOIghTNHzHQyNXGbBG
         iigbb879jqheV2zU5HB4729p1KMYD8e35z6nYDsx7119qe89QfUgJTbZIt6kkFmHYQvR
         z0wldf48ScXfw5htDwW8qhpj0O7T4C0NWTlWbHFR6+cSYAR1o2G6zM9I4aqCskAwJjlg
         hkHzmW5J61Yv0b/FiJ17A7Rom/zADPWkA9RLLnJ81Cs+8JeysEDL+RtreJz/YOQBKQbI
         NriZYQU12mIp49KtY9PEw4TLMWF5Vm/QyUK+WqV+X3k+CSkb+kEofv4hoMIRfulxGgua
         ncug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785136894; x=1785741694;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n9Aos/jywAp1KiMqxdiE8FS02FkmBZsX9G9dQPrcuvQ=;
        b=IcvgakXHd7GObZv6qcmabU1vWVq/LnSsxZT4v9DA5UbtykmahdEUCg88AhojuMwhoo
         vGX2Mmn0EivWuozkT9hxm5kivMN2KpFw24woKcfXjvzZgHNOYnzdSy9IptxhFMcEYqBa
         08s3sa2NlDzXlAFgVH6CauaESb4Sve1/tLRjdH0sa/Jyld2PLWaY+zxI1QDfe3ZMKGP1
         kX/GDaI87g3RJylYqEhADGwUZXi888+bLZwNhH5oVKkHHhkn404SM8peIdDul/vMdzDz
         5Y4IbK0L8e0ThW6uvLBO8pzRjKaBBwoXrZlDw2aTNA206Yk72tAWV8Eu7UfFEeXWHpZY
         sY5w==
X-Forwarded-Encrypted: i=1; AHgh+RpAQ4ztscrWz/sixP8WcHNQMGUm7WccSAsDiJrTteEq1fUhHbD2+GYfryMafGrZ8r9S5i7EkMat0hU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMQJGkkOQZqogxHIBIzhhY+KTwYWhqzbmKVZN+BfPJXaqj+ST0
	hLGDxmFjdlKihz3vjGr9LuuTW0hO2cwX3hscnDr5M0xvKIDlV6eIYhkJ18bX8jQLGQIGK2ThlGe
	T3SnGLQ2kojf+Ivae6jo9wHVez92bJ94A2qqrlEyokU/86CuBnf7OfSjEoKsPyjI=
X-Gm-Gg: AR+sD13+cAjeDw3/B5ArFqASFUk8JDT54J/aZvoBjpXzehNBdVaoiJP2n1zrfCoKCXW
	F7++6TH5gxL/QCMXAL/XkpePhDqcQe5XaWOdx2O7+mhylC5MeCENYdLG5pZUO+DZppMBkCCfSbJ
	OgqBlcsMWQGADHBEcFzG8VLuqhBt12DgJr6HknZKeAY9OUTokGCnKtuCGpoyZhB4kfrtrqcdxbk
	pO5y5OSgvEr59J2E0Ie/Du9SCssTXeQ4PaaIBfpfi4rJLLhji4f1nO+ln8NL0XVacjNiFrxgqUH
	+kPWhz6BvdaEHvoM1XTarz4oMJXzG+QfJa2r6bQ+6iWoGIAVhE7iy5gpbxwAP9kXNVt/lKx2B2W
	eNeYJXTmGGAA/F/fGnN7h7iTmWoyjbymiExjF6OT+yprDnz/5Fc8=
X-Received: by 2002:ac8:7d16:0:b0:51c:92a0:b2cb with SMTP id d75a77b69052e-529a84cd3d2mr70090361cf.26.1785136894612;
        Mon, 27 Jul 2026 00:21:34 -0700 (PDT)
X-Received: by 2002:ac8:7d16:0:b0:51c:92a0:b2cb with SMTP id d75a77b69052e-529a84cd3d2mr70090121cf.26.1785136894171;
        Mon, 27 Jul 2026 00:21:34 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4ee0e91sm201630615e9.4.2026.07.27.00.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 00:21:33 -0700 (PDT)
Message-ID: <d5f540ee-0d6b-46f7-b3d0-6405bc826eba@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 09:21:31 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] hw/hexagon: fix machine->fdt leak in qom-test
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
 <20260727-fix2-v2-8-d0c4831ed7ea@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260727-fix2-v2-8-d0c4831ed7ea@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA3MiBTYWx0ZWRfX1bdqAkSsqFQd
 oGYdo2ISj3EWzfj+yldOvhPLcvLr+kOMnrt5KN3cCy8VKg1EDcvPEFMUmb2OdQAFi4ijb6TxYrC
 fkwfTcYd9p5zpCIZ5a6Mj72MDuCTaxo=
X-Proofpoint-GUID: 2fO2fGhjyepWhH-_uTHsfzU1iqcsYNYB
X-Authority-Analysis: v=2.4 cv=FOErAeos c=1 sm=1 tr=0 ts=6a6706ff cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=CN8BiiQClkPCgTBgyyEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 2fO2fGhjyepWhH-_uTHsfzU1iqcsYNYB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA3MiBTYWx0ZWRfX1UYzUFnDY6Wu
 Ot/JODgwHw8srM+gKu9ltIEvoXPAnIYshJhXAfY8X97DadxdR3u1iP6oJeeel6dJEKj1CRZNf7d
 eYZvyDzJIVkwvE52ommy4KhUBgeLOxocubcrXRZozKuKeycGpkbIq/YNRZafO63Po9GK1IH0yap
 L7XltBieLcWUnixGQXPDy71c4DrGDnadMPOl1C4fBRWiJHlN6egkALiVZ39v5rttwTDvhZSbGgT
 xftb++4e2aUFiidUIcyrx78ZM1/xY3SaoR5aj40IZXnjs2UM+nikfIXXTcSMmag8gWyB9iTpmjD
 eHOxPWMk3nM0eWMvfYa9kPerFCp0EDZXdo5ywGyTKfHjPUIhDFG281jqxuXdF2k6a9i/a3OfnC1
 Ba4iOOoYj/XQ1XirYMxlNGddQgxXgIPQaukb/vOoLnBo46LKyQDOfACN5VS/xc8zdRi12w29JoU
 4StNtLx2mGeBi5mtrlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270072

On 26/7/26 22:44, Marc-AndrÃ© Lureau wrote:
> virt_instance_init() built the FDT unconditionally at QOM
> instance-init time, so simply instantiating the object (e.g. via
> qom-test's introspection, without ever realizing the machine) leaked
> the 1MB FDT blob: machine_finalize() does not free machine->fdt.
> 
> Other boards (arm/virt, riscv/virt, ...) build the FDT lazily from
> their MachineClass::init callback, which only runs when the machine
> is actually selected to boot. Do the same here by moving create_fdt()
> into virt_init().
> 
> Fixes: 88a8bc7f43ff ("hw/hexagon: Define hexagon "virt" machine")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/hexagon/virt.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
