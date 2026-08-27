Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5796D284693
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820154; cv=none; b=FDdVGjHt8RbvGRNDoT8Jgw9q5lxFmuvS1iCYZoTFAUYPuOXgXc9K3BsR4utF6uBd/mLa7NgI2cW4i9mkde6pHvhfocN5DiJy/TvvsfL3/wlM9n2N8mGJojxQycCaFbZ4qwg/CqSpAwAbVFC6ai/KIP1kr1XPNralgDTES51FqG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820154; c=relaxed/simple;
	bh=mksnwuft8hGjdZENCJxZySBx10tPalbzM8mi3uDVw5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdHviFRFhyE0ISxOIpd2fLjyVAJGu/JmntH5QFkFcwBMxTxh06oFzUXCSdb8zPHnjNUlxksWO4mbEt+enrJZCF5vy+0fVrkKrUOpswzfUj5Wx2j4sM3oJKOJHMy1ceqW8qxR1aULPII7v4RTLYErscSLMbj+TrVsAWxqXyEnZhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kCqXnufV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XUUiX8YZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kCqXnufV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XUUiX8YZ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6RFZW3592028
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eTOp0U6hBPBLp7IWusXAj3yNaChjytvOMMoMQ0I0hhg=; b=kCqXnufVK1shlEJ4
	5UPS+/H239/KEj1HJfFerfxh0oBobJkWDz0FkVGdfTr6VrF/whboY68byyJbZeV0
	cdQD7aoPm8TbkMKrxiFfIj6mRqkT0GraTI/go4xoahp1kW23UVXvEcXN0vGXPXnJ
	NFQ8IqksMC+uXLNbcky9WgpR4IuGk087/1gKCK4U66G8/J4g6msD00gOcEiI+U77
	vvgcShJ9xcm1bCKyYU2hRNxxu1xIQgRNgRxfwhFzruqvTrmgJHxczKd/SukPSnan
	yaGewgvhkRaHLvOI3F8m+tonZjRaVX7dV6kgXBikDSfJQBGKv1FGcshvSh5clLMj
	CoAYHg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4egjwc7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:42:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c21c01cf3so33561351cf.2
        for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 01:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787820151; x=1788424951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eTOp0U6hBPBLp7IWusXAj3yNaChjytvOMMoMQ0I0hhg=;
        b=XUUiX8YZiXpM5aZfAfoVGkCr7gc76m9K28g0MOjZsIxuVr+hMjECLpcrMPdURgbvp5
         ukFiJ4hCYGWstJf+O2gHMBnQmnARqbMH1tsOV5X0UZYFO00cYGNkY9pmwHxHphcUxM/x
         JLhDNUnuHepRYDctUNa4zwW02+6OhTedkC45hilhKaPhahIkohqnR037RiqNs9dbNIIC
         Qs7fcxuuuTMcvrIKsexYieigoXXsaeh1XOzofaNgy3bOqvjkUZSVDVlO8kJ2tjNJSSk9
         xlS5NBxHp0NwU+inlZF8Zm6iAJeDkcrOvbgwuGblUIrumFEBstQ/zTW+IHPZmB25Xwds
         ZVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787820151; x=1788424951;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eTOp0U6hBPBLp7IWusXAj3yNaChjytvOMMoMQ0I0hhg=;
        b=LURzFc+EeJQeKwgs6auajozT9DpOqAs7MDOln1e0Ed2dBY8D+XMCXG36CUEP0AOkAQ
         DZAqpbTHKP6kp5DUihAfXKZdrlrUrdTVPH1mnE/B4/4MOen2Fy0y+9b/dKKh9+yTlEu+
         wsJh9o60rZ5q4wKmTYeZRSBWaC+WAYlwJPHKmC4FHqWX7N7sHkBTrRsikqrMo8d0bZFw
         2x2LDwp+Xmofizp1XgIlCw0bLttF7EjgCUqCwP/IrcrUUBHIbndj4nsOnfj7aH8xG19F
         Ae59724HyiAsfdYK9pEkbXatcBCBaX65M0wYRTL7qx3f8Y4mJ1V72uzvjAkLgZo52iGT
         Wo3w==
X-Forwarded-Encrypted: i=1; AHgh+RoN1xJGOjNqBXFkW3pxhQGKNHnrvCf73NuAB6UKbKQbuOQOxAwwZ+kpviWNNAynw48zhCYzBr0Crno=@vger.kernel.org
X-Gm-Message-State: AFuF++nwHoEhZ/8DfJz4+OaVn/1+h+OT7zDxacQAdGUIYR9lVsMOaxHt
	XWxFH1BsT7iHXXloaIWklPn5z2X9VjnB/0JZ/2yhwBdjNFSqZRAAhPqHYjDCVvSdOxldZwHYY7r
	0QBS4Lhx7FBTbUQ2Dz0AwuYPjA+IJm0Mz2iOfYxlZcFXY9hBiopFUNDTg8OinT/g=
X-Gm-Gg: AR+sD11Zkr2xdiZaIOyMdSdzcyJ/iHeG1VsX9Ov8yb01yqnLq2HNrP9afx+SIlkDs+b
	fVa5TMWLm5t6L1BGScQh+8iExXMomYpdytbdvrr7rCAWQSQw9nHxyz7Bxim84642+udKWJs517R
	ZHbG5SHCFJRsDgblPi97iO3Nz97IiwMJr020Hh699VBHeHCqsbXiFNFrAXGXtETteWr5L2BVbdf
	FKfMgUA+Hb+tY9z1znGWZNVaRChMaavBfaPtBbmssCwMjBtGiLlZqEp+5lFyiq9vmxJoZ5ZIztP
	mnpsYzr4fGd6ORzvGV8Cm99Q4vYRnyd/JdLcALqkQRnIVVwtIg03rD4+1EMZRYi1yDKSi6RGQlC
	gBiDz8aqrWWe7oRtURCHbUJLbvKM1PZKEs/AU9FSmpkkK+Xc0
X-Received: by 2002:ac8:6107:0:b0:52e:2906:9124 with SMTP id d75a77b69052e-52e420a0859mr147672171cf.0.1787820151500;
        Thu, 27 Aug 2026 01:42:31 -0700 (PDT)
X-Received: by 2002:ac8:6107:0:b0:52e:2906:9124 with SMTP id d75a77b69052e-52e420a0859mr147671551cf.0.1787820151047;
        Thu, 27 Aug 2026 01:42:31 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4942366asm32395695e9.3.2026.08.27.01.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 01:42:30 -0700 (PDT)
Message-ID: <3e222ce2-9e3e-4dfd-918a-37a03aced152@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:42:22 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 39/43] qapi: convert trivial intro sections for
 qom.json
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
 <20260826193840.2152000-40-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826193840.2152000-40-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GvsSKG1kKnCOCra5yqj-qNa7EZEfi4rl
X-Proofpoint-ORIG-GUID: GvsSKG1kKnCOCra5yqj-qNa7EZEfi4rl
X-Authority-Analysis: v=2.4 cv=DsRmPm/+ c=1 sm=1 tr=0 ts=6a8ff877 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=UFf3ptpOQOAA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MSBTYWx0ZWRfX9uy95Vtv7+KG
 UrBn3DHPD4CcxUTGs+/TLYiuzCn6slK/zdrl+cWLgrFe8A50DAe23nnYkDsv9nhkajmco85D7A9
 sH1t+ogHUlN0NdoTxxTPwvnCQlIBxOp9xMWnF0qqRWi+s2YHlwYz9B/V92Rb9rGTKiDtl0+TFS/
 mpUxXM+v5k6TtbN0nduMtBGPBBI+hMioUVRDhtVy8RuxQQp0QRaQdP3hl7pgwkcuTCGNajoRtCM
 8NWjPg5X3ODlx+xB2FRZrI8ZcsO0Y12DSSoCcGSvaZuOeqgBGRBeC4sIzeyZA3dCW9Y/t6hExh0
 L8lz4u4qsmnWDkyPskUiwe33ipo92xD46Qtbhgjq4jicXfywWTZOrb8nhSvpDIaQ34mGWl+Samc
 vajTP04ye28QohtDKQgx1QF9axE2/weAiBhNugQ83/Aq5BXL5VBAdF32FcDso/CLnpw/5vEzzlN
 rYWXYp/u9Mtng+BaesA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MSBTYWx0ZWRfX4U47+ie6k5VD
 E/2Nfn76W9y/3okd73Mfde/z70PdxsL+KcnaFqfV0/WNdWQOZCj0uNE+/kd+8oEfoRY5obTtvEV
 IDs6fzvgiTZEcTrQvQvgD9TGQuH5lfY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270071

On 26/8/26 21:38, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/qom.json | 150 +++++++++++++++++---------------------------------
>   1 file changed, 51 insertions(+), 99 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
