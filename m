Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DE2395ADC
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820185; cv=none; b=XRpg1XrYCugJODvvJxby3jTy5a1830d0gOi7KaXHuduBH1wc17RbwT8kf3PbSeB1i+kQSvNd5RnK1A3xQeGSZUJPtnTMkomnOha+DC8mtUPYICyir9r1dLZkLmsdRbxj5IDvbYep7GunDk6QD7eLFr9EhJprCvpJVVXsAWxUumM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820185; c=relaxed/simple;
	bh=uc4EvIEvS6zwcP2AvkGVlP1mc4b39uZyU1I4h3ui9bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGRrRrS5icccqGQ0P1MGOn1ALS7Tc+Uer5kRCUFPcKCYPjj8UaALCsZnqsttGeHLWEh46n88zLjWPaIYEDGgJ6/UTGF6BjBbY3Niw5mUsi+0z6MuMqPb3pV0aLbv8uBJwWCgBWQd1HLVSwVAEfhIkHabdcr4rt5GHoluKSRMmAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WY03Ckdj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=db8A/ZEc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WY03Ckdj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="db8A/ZEc"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6R6od2143871
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZZoq7fGj3wd39YT/btHjUtvUCMSYh+asT/eB37Pkio4=; b=WY03CkdjK+R1JkAH
	BGEO60j8H/rS8L1WDxPF2WYaZXYqlg7VZgQRdNYPXHDBAVoIgMfR+Yo3fIKQMJdP
	AzKCs6gqtw5EtDm5W9Ic6PQmUIV+MwUNyQaXATHDHCo26aD9f0QRXdjtKMaAnDjI
	d5uwc8DeMnUAi28FUKcDh6wKbYhkU3hE0lEv1CHqa1BqUVBa0kMGz/6iRUcklKDC
	pIVedoW5IgjEgx6dE08rbTlYQ3BNwd88EOjumaOJidqcDM2Y+IIgvYdKi6LXfE2i
	Suai3e19mhR86iZvSV/9H/aB4gRxWB6saT5xhTZIG5gdWQDHCBxig5AlgPvBmDMH
	m/wdag==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gab7t1grp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:43:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1a97644aso4859631cf.2
        for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 01:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787820183; x=1788424983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZZoq7fGj3wd39YT/btHjUtvUCMSYh+asT/eB37Pkio4=;
        b=db8A/ZEcbMbL/hFzPBOR1yBYW+l4YV/zPWZ4T9QKOBD/3p0EOVmn8Ouxqf91NETyTK
         +jVl59AHkWUFL8wui/5ZuJEuMq4wnRW7o7A6Vk3aA3iVLico7ylZl/kcY0zQkLYjnmX9
         DFDx11Kr/bzSNfphiQtDqxqUcCOR6frGASLkGL8Ae0neZO0SmVbWlJzU/7Zg/SwLY7hq
         s2LUXXCLUWaSKezGceXr+2kfFKx/2Zlb99D9kFCXvAsjGljZUTDr+xUy4U9Gie+WdIUR
         rP+4FXa0nkMdOffKCk7lTpEvsuuCbhsrGsRP/NP3ewTQ0NKEW119Ue2Nr5Y+JRTp2XOg
         VZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787820183; x=1788424983;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZZoq7fGj3wd39YT/btHjUtvUCMSYh+asT/eB37Pkio4=;
        b=Q5iaBro73jNRkBHKl5ZCo6EPWZQnDOH/+4IfTyHnPDGAg6YE3O2er87qftlcLC1wcN
         +BTFqeZJ/8DhlDABDD3zsgSDLPv6ayEIjo/TMXVhVOI37MAmYDnZBjIMvWum+lKqmT8N
         Pu9jwep0/U6FapcjKMNj0dLhbic8bLy67RI1qesKCO4nXxZ0TI8dPhlCAwX8uTO7alQb
         /ygLDm6bE7EvCcVuDOasqLp7pmdKI6Cz+f1j1/XZFw+FJhTKzgYWFaNJN2QEoHAyKyid
         9hPYpJRIJF/lni6KhlDipt9Rhi0b3pOPQSGgoS3ErLWcK3SmZ4z1HT08RJBMC1Kn7N3G
         qXEQ==
X-Forwarded-Encrypted: i=1; AHgh+RqY9Q5c/3RhWRREDyCaMTJNypkanSBWzSDEUyncKztXRKmBTAVj5olGZdkJoKWI8UFsKOajOUxHq1g=@vger.kernel.org
X-Gm-Message-State: AFuF++kVEmbVBChxFF4kevXTtFarYhhLhxG6X2vd3pFn3dP4gFXvAQP0
	+y767vX/At0hYjaPL6O33JeMV4zlKlqS2gfX2VjZXGpUOsOVMb98gvJWCvYPk3wtzMsQKCHT8PQ
	UnCgFtEgdPJhX/nEm5qUC7EYuZTL6gPnemjRGMy/ZhrwvHZjLbSm3ic97awTpzoE=
X-Gm-Gg: AR+sD13f0mXGibuE+A3ZDUAZT9ayCNsA5waXCo79oEf2unA40qRMJzZFv/zN+UFkNrn
	XNg3e6Ni9HPDwoKnVUm9GjvBjfqNSUOrbY9DFOwpdpu8EOLjiv73NM6ojsxKEGoONXzZi5YyM3U
	SoqqaLcQtd0hxexb0XNfwUK7v5TUPm+xkm8X2SMPHrB2e2sUdXeRetQDnu9LsU4rfS15HLArTiD
	KLsOg45IgNVogsBP9FIVlekGzszGTbq5Wry1RdM9nOTJ2pheoT/34dj3uELtPBO9hrfYM5t2HXD
	eaXlfipR3ypvkeHWHFVsH4XF8XrSk+iG9HwPtT6YlIrXnDBqfmaHIEv6sQf6b7Q3+W5Vf1fWfYl
	YZQUwtNrsd3/ySEOQQch99unEp8ODrZMsGPl1USJRxyw1CAoR
X-Received: by 2002:a05:622a:5889:b0:52e:12e8:54f3 with SMTP id d75a77b69052e-52e422300damr153090321cf.8.1787820182709;
        Thu, 27 Aug 2026 01:43:02 -0700 (PDT)
X-Received: by 2002:a05:622a:5889:b0:52e:12e8:54f3 with SMTP id d75a77b69052e-52e422300damr153089881cf.8.1787820182115;
        Thu, 27 Aug 2026 01:43:02 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e27ab574sm7239065f8f.14.2026.08.27.01.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 01:43:01 -0700 (PDT)
Message-ID: <a845abd4-fdbe-426d-9a28-7323bea656d8@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:42:54 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 42/43] qapi: convert trivial intro sections for
 machine.json
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        linux-cxl@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
        Michael Tokarev <mjt@tls.msk.ru>,
        Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
        Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
        =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org,
        Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
        Laurent Vivier <laurent@vivier.eu>, Jiri Pirko <jiri@resnulli.us>,
        qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>, linux-edac@vger.kernel.org,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
        Zhao Liu <zhao1.liu@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Lukas Straub <lukasstraub2@web.de>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
 <20260826193840.2152000-43-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826193840.2152000-43-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X6Bi7mTe c=1 sm=1 tr=0 ts=6a8ff897 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=UFf3ptpOQOAA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: t0TZ0RHaEEpGEtEdo3D8OtgConUtX-2k
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MSBTYWx0ZWRfX1Mk2M76VZwXe
 iPw+hQYuIoUg2LF25/UG71xWYqULMNQpimVgF+uk13t2r0BtJzSx+hkWR3zTicUIFE++4CqNDzi
 sF3Kl+2bz8KQ0o9KaIRUPfedH8NVLAQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MSBTYWx0ZWRfX/Sz9VY3HZnAW
 vrvHZDG+A+9Knn0to/GzQMhJ8NAvlslFIA1rcX12zFWrt2d7yswGRvoCcByp9PVv7kdpRo1B4Uf
 VNJaCC2dDY5R4aBwt2AKDO7Y/vBdY3AN/M+rVnTJycOK2MO69ofXxczsnQIibNTyk6WxpLVJcU2
 1deLLsB92PZ8HXYil1umtRXUXd0qC7Fd3gDV5OZ7ytny23/wG1W5GtkoQ0HickYzum/GxoiWeny
 x2vxEnWMcPlkcdGVIVSei+ENjhFcux77ozc8G9yZckC07rrZghOQrI88CJ48WYI8j1Iw8y6vhp3
 avdgslSOfI0T7/he1ebr2wMg87EsLbqfc53qISAHAcLoHum1/Lzgvj6Zsprz+sRJgmYHgkYaOmb
 nhdopLnKLsncz7id7vsQE5fPKtEJyJSYGLlN6X9ynCwbzfYMKaKWos+TAOXKRhHw6dPeMDgY5pZ
 TKSjoChdWIqD7mRAYmQ==
X-Proofpoint-GUID: t0TZ0RHaEEpGEtEdo3D8OtgConUtX-2k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270071

On 26/8/26 21:38, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/machine.json | 208 ++++++++++++++++------------------------------
>   1 file changed, 73 insertions(+), 135 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
