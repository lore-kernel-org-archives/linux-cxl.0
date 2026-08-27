Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A873E958F
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787819982; cv=none; b=absMV7tsWVB4oEJjk0aNFIKb5ehdFyy4DZom7/gXeu1T7G7jYMkJ1FLxTby8b4JcdmtV5EalpnsAV3WVU0QryIa2K66yPY6UsDNsIxfnNbQqvCjrGfxntmN73LwR8isx42vB+/N8B/965wGxTzOWvX4KWNq3z7CWnIXWtzcpcz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787819982; c=relaxed/simple;
	bh=YU5gS3rgWxWv3rwlYXEMlnWim4ZD4A+flTfUInKpaIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=isoLqNravP6GVbj191Q/2upBZbIXuKTQlMhy7Ljv3vRayGsXjljJU22OdxV9ttvaF4SXVZL5ObEqYSdQBBhVOsTgTdJai9Ip3GFWHHzI7ORkQSmCQm/eB2ltu99cVe+LTPA8kWn++JqgNUd41ojbc22/dZ999HDpSsJqMLzptNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZA3qNtqS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a2ss1/dQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZA3qNtqS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a2ss1/dQ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6R7hH3257758
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a7+AsBvBDO3jYmBzGBNJcGR/R409Qb1IgeySkVV9Er8=; b=ZA3qNtqSf0GF81Fc
	cP5eYIqZ7dmwGa4lVZ97KF4nxVfM8KTsLbPnurQ4htRdns7LOH1OCYgzMbTLvLM4
	yxYlWfmLP7JwHrhgFcF8QsGuQ/tsaz9QWDPrNcHRkPjf3WeQfmLeZu5pBXdoiR3z
	9T1eDEQYvWEVuVxyLNynjTMED4Y6mywYQnkAOIpWtxmHFT/uDxIa9tnj8DQia9mF
	MuYxLMcgMDN+sasL3dP+oskh4VX3uyyB6MVuItDhVlg4aOg/rhadzGM1IPmH3bXF
	xblYRUqYMVZqcwLsCj6JIQFHWsrlC52vD4K7p7PTX8EId9jQutV7NrcdPT9mIXQt
	1O+V5w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4ecaued-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:39:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-526da7e3c9dso17965581cf.1
        for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 01:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787819979; x=1788424779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a7+AsBvBDO3jYmBzGBNJcGR/R409Qb1IgeySkVV9Er8=;
        b=a2ss1/dQWy/qqVCY/r+gebbrSRxN37/DL9M/0yOZKU5U3YPlTvVG9SiKvD4btz6ejG
         yFugv8LE3V+Umy3/pAR72Jn64zW5U3CGz5+AjiaqeTVCOGuQCWgRzw+BPAqp/b1o43gR
         R61twXjga4/Ocd2FsqAs857E/B7tOPdjCeowCHFDULeERCiR1mR6vCNh2s2zWRaGCEqL
         bdIIAeo3qQrzAdjvMxGUgMhyTSuYI4MWoaDy0/X/bDMC5ZioByAfUGnJT1mRBJjFeVXx
         a4xXbS3FmTy3HFyr5/qvuMO227U9zno54cbawFCVMwnAMNnYH9tGc/MSu44u/4OhLDVj
         Xnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787819979; x=1788424779;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a7+AsBvBDO3jYmBzGBNJcGR/R409Qb1IgeySkVV9Er8=;
        b=ikeULICw+sO951rI9BtOT/8HKlyS/fXU9GD5F5qehFkF8WGFB1XNJy2CwFWC6ZwUxp
         +LadH2MwCqUy/OFj1Fgdtd8JXhLEjOI8WvRWwK+7jR8xKQsMJSvbQwMZ70g1m6Qooa+G
         9sUmjK0zoMe5Ep6f/vgN2hXBzzJNajwB4GP11BL6DlCK18kkS3AWmvHqcLTnitYI2Wj0
         s7k79iN8zngisdMHvvpXSV+B9pgwZULCgpUEFwhUssnSXoNw4gFCpAZ5ckKBjDPbTi+0
         LFKfG/IvAxGlhGJoom3LzqtdDqDSHj7B3fMCdgfhqA06DXvhVT/suBnEtdk0en+r6Ev/
         ACbQ==
X-Forwarded-Encrypted: i=1; AHgh+RriGNg1C09a3YXRspVwFMdduPjCG2QIVtvdiBf8MscgBj8IZJMFxclJzdRKcfQZhVCO1YvDsBulTVY=@vger.kernel.org
X-Gm-Message-State: AFuF++kW4IGx8p2G2szi+4f3CqShA2Xuvs8NCv6kWTFKX26LJ119xt0u
	4holdKAkBlmWg1b1Fn7MREXX28VFpc+0jvAslU0k9FHUq2a/tEJKzxSqjSO72PWaTxCUxCiNRQ5
	NGo6tOO0C9EIjcNYJg+h59yLMLbXLhabQfXYZgmy9PwPJzmlcOfi9wbkGwBGBtE8=
X-Gm-Gg: AR+sD132LK83dVesM2tsqIIheDR3taTHwRiLaNlak4uTxk+kSRZF5NEm7Tu0PAqVZXh
	cijC+fqkumXydfTZIPghOKVtT058O0IS3IGabP/Xa72oXfvl7qNEQ4V0zWX+HUnuH+84wKVZ4Jl
	Rem81P1FnoU3ahabjGNqpAoGPEedxRiB1cUrMZHVMVPejGwywWKhjEUppeppVQGX3uNI28imSpN
	6tNX+j9F6MSY7TsgmilCWKRFZoI0nvE0Osh4ruKdCVWK2pzDtSUtOOHa/IvVN+KSvjM+768L7bL
	BC8OBo0xe7wuDbcK02SIt1HLUWfZQssX9loZLuIp6YlFOBYMFONdFcn0AB0Rnn8XarVxMJ4v9zD
	udsE+cigf4k+GDzP/HylehGzp+sOcttMCs4YszCpQfE6+hNn/
X-Received: by 2002:a05:622a:a0a:b0:52e:f66:f1a4 with SMTP id d75a77b69052e-52e423f6de2mr137305411cf.38.1787819979277;
        Thu, 27 Aug 2026 01:39:39 -0700 (PDT)
X-Received: by 2002:a05:622a:a0a:b0:52e:f66:f1a4 with SMTP id d75a77b69052e-52e423f6de2mr137305021cf.38.1787819978860;
        Thu, 27 Aug 2026 01:39:38 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28dc3f5sm7529973f8f.21.2026.08.27.01.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 01:39:38 -0700 (PDT)
Message-ID: <09c2e2b7-fda4-4a94-bd23-202e7f021002@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:39:27 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/43] qapi: convert trivial intro sections for
 accelerator.json
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
 <20260826193840.2152000-11-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826193840.2152000-11-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KIBqylFo c=1 sm=1 tr=0 ts=6a8ff7cc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=UFf3ptpOQOAA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 58cyI0PihJlT-ocASR4nDKi1nEJ3IJMJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MCBTYWx0ZWRfXwZWtjYgwFkWn
 xlX5io4Mwu9Fxdo33fXOI+taeodvEUGEJ1z7Dpp//0rs+mfhvStOlLEaO3Ici4DtG4MAF4uiuvH
 +quzBniGHXgiFvp7criXI1NH8CxLaSJtxd3XmbS0JE+PNhw2xMdwFzErGxYvdw7WRtXM3DuwdlG
 s6CZdbdaB9adXFr8vBcM6PGEy7sxFBwLoduzeRV+NsYJ0zYjg0VdKsqT4nx9mvxujUpEptOz2+Q
 LinzeS9IzqiOQ9TtDLARjvYycDaiJ0tkIDzXErSeShW5ZFNhvXrTPOd1DKGQL0/DGvV1m0Np0Rv
 uQ0qJcAjwcgaX5JtnVrLlUuFpZu/YSV/93mkRYw9vw5F5Ljz6qr2bI4kbujwlUIpHzEUWCF5qQD
 ac/MQdDzywcNENu/OcE78qIVSq0Cq8ondgA+w/G+bCvNAzT+Z8RWOQK9hsY3HGo8I6vEkrtRk/P
 v5fJGWoFayemtUX5ikg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MCBTYWx0ZWRfXxRoHGbAo//8X
 HrrqyL67VgqlBoAr2zfj79D+aflRUdVuObQRZYUNS6MueFHGHwQndRnpA6zkJs39+B5Lj7AcTuY
 TTNi5CqO8cMjnAmNveY08DplK96QWTw=
X-Proofpoint-GUID: 58cyI0PihJlT-ocASR4nDKi1nEJ3IJMJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270070

On 26/8/26 21:38, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/accelerator.json | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
