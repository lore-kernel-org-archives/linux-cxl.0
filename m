Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6C73DD862
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787819997; cv=none; b=Vn1bMga5l3kkTrHfty/wAx2reKSf4CHWcyAAW46fha0Je3HDt5d7xLa4+/mW+UvMfO+Rbe7jVYkL/3Rndv6U4/o1255WG7xbjEwbLSKEl0GZrlZBii0RSvtFe1P5/spBk78VjhXDj7Fh9nrDhaO6KXEtkBeZrIPQmpHkIiPQIYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787819997; c=relaxed/simple;
	bh=yKufXW8Y2WKIhyUCaguLHlxvC9xcvQmdQUNu8RVmeFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqKhPxYCCzU8IumiJt6zohFyAUvs4mYZi4vZOa5e1qxUUzUQyEkGbfEsW51+geVSXB/76MRwn6VNodaQGLoMzI4vCz3MtQFc6EG+Qm7UWijUAxCnuhMFHXuhwmRjrI+xOOLuvl6fNIuigPUbwU6krTYQ0J8wf1gAJXkrT202kP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ofVBmW/8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Htt8tOJK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ofVBmW/8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Htt8tOJK"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R76sw23227015
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PAuNdE0+RvBG45FZpe+6E4vVKW9lRTIG1OGafBpzdQA=; b=ofVBmW/867PwielI
	nbOAZqjD4ymUJPkTuWNRiPIpJuLCeOGVsxeqyk/Xsu3xPvLd54HU61R3NWZRqRSI
	P5gUCEUwAT2eZie+nZ8bfADEWMJ26DD7P5GxNAZeCGMA9fNoTrmunTcRYZ82QURo
	Xu8uuFBl4vINGokZcCtkukOGRQychUsla+UTzJNK5AbU0f9fPMNg+RxnoWn1JZ68
	qROB2rJ8Gk2s5R56uvH9K3GmnafBf7pbDut8fcjvl2JiQwRtIya5+C4pLJTuqRkw
	PGb/0V8IWcMWeaJMbbQ/qIX96aii4B/DnF6y3hBEGf3eN5K+o1IxKSbe5XBaKI0C
	41fNBA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjfrc0w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:39:55 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90cc2b97f8fso33520556d6.0
        for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 01:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787819994; x=1788424794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PAuNdE0+RvBG45FZpe+6E4vVKW9lRTIG1OGafBpzdQA=;
        b=Htt8tOJKXus0HIkrrVKH2gcFYCX6RFahPycQF2bh2fQJaYdnd03XK0lgiluFYkv2/N
         VlddRZVjlax/mn+wPbAGyF8zPKGFk7WaI+K+R4T6E4JTp+nghjBFarsk50qIOZWcP91R
         k/8m7notoSs+zKDtAlVxXpXwAO1U2Jb8wDugeWXHbIMbGdjeaKlCmZYHPXKZQFbA4Dlo
         Ro091XDPwdc+hTzWr7XIvGJQSxmXjp9Hxz78QrkKtyxzPlLx9gwzZhSi3C+4fyAQh1xG
         RlGfUUvi6WkvS8fZWGcFvQ/kMjv1xoJAsuBmN24vNlg8aYyiGIOwOsyAFPBzeETl3FjT
         yW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787819995; x=1788424795;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PAuNdE0+RvBG45FZpe+6E4vVKW9lRTIG1OGafBpzdQA=;
        b=RXgBNEWFwJSUhjYzckYWYntOOMAT7dwIAU4vcb2n/fUwMFtUAnPtdiwNp5b1rZEUGE
         WwWjXcnCvwpwzVXX+SzNIeznKc9+Sk3b9cYMImKO8v3Kz29llh+LShvk2e6A80j8IYUx
         bRPVkCduhgovV311SCf5+3HscXq3aCUO5ATAglosZWa8DGRVtao1VJ8tR0+iQR6f+INA
         w0A2BrpN+56Y730kfIDSINQD1Z2ZpKA0AwnE6ByyTFvnI4/sMT1l39lDso8ncmYtVJcE
         8GgijS+pnWASsbhdhhvb/1yhQq+9T8hEOUQnTZ4WSl2xGiLsbWxmLpvzURLCAUzmtavP
         5xRw==
X-Forwarded-Encrypted: i=1; AHgh+Rrkx4g/q+fc1EzfqN7pebiknpK7fw6jUlxSXsTXbFikm/V2WB+PEhcWeRp+tg/mizMuVaRHEke9Dxc=@vger.kernel.org
X-Gm-Message-State: AFuF++nyUPux7ZpqHsxjHkB26oZ7i994wLJxYDcOz6s4XgjbBkMMqRsq
	y1KOe9RhZrBK0h83sMs2U45a4pJZthMK4Sey+G3B37sGFUpCVY7UZkEjAA4Oy7d+8Ut8KwWvTtU
	2nWCuk7BKDCc2DaREPD/9POVp0Y4phbyib3viIC5c1sVJpm4g4uLwYx/4wOVV598=
X-Gm-Gg: AR+sD13/fWgCRHUbtqWyrnFr8oXzQUfDAsfcpmGikZREz+P3b4ADnYT4A4PyrDKz/DS
	VRwuwA4DoIOYCulS+eMPLtS/qYyhMh4lXL9KZlbLqGPh2Bph+vmuGWUXu7/pQf5FhK+z2Ae8Aty
	XdqZct6kp65nL/4y1LtQKKHBsmvBPsy3XlWd7gEayU55Xm8cKbq/ofWTJmiFntv4GyMAdglA3Vq
	biVXfTiFMgphtk4+8euwnhYwBwvcnL+b9+OEPBWnH6xDHn/BCbaWQuvsDsnsVDLyp0IC2twaFo4
	CzHOcy7qRYFawbyeBb09cRgxvwwJtasY6vkKggEA/XUSUYddG2AWk5kMBTznGW6QQFJrGbA8F0j
	TOqS+cr1Wb7xmss6jQNroawPVLICD4+AnwUUYraBqUbZ3lPYM
X-Received: by 2002:a05:622a:1b86:b0:51c:fc4:a144 with SMTP id d75a77b69052e-52e4228ddf0mr128989691cf.4.1787819994653;
        Thu, 27 Aug 2026 01:39:54 -0700 (PDT)
X-Received: by 2002:a05:622a:1b86:b0:51c:fc4:a144 with SMTP id d75a77b69052e-52e4228ddf0mr128989271cf.4.1787819994192;
        Thu, 27 Aug 2026 01:39:54 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e279e391sm7271138f8f.2.2026.08.27.01.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 01:39:53 -0700 (PDT)
Message-ID: <83b91fb7-8ca9-455a-8969-4693a4fe273b@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:39:44 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/43] qapi: convert trivial intro sections for
 qdev.json
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
 <20260826193840.2152000-18-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826193840.2152000-18-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SZYfuArVH6Kj09QchbS7eRtwsw31hflr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MCBTYWx0ZWRfX6/bHalUxFhVa
 crBquiU0HJxrN/T24xjQhu83fs8t1J76m+QOlg88szmbV1GuYVPe9s7+PurpK0OevRUM8IM5l72
 rNPNSXfpyXZxhJ+SjCiT8fY88CHEXlqsMjCFEo8ampM+GFH5e4YFZKGiqN3YBwlEvaTFxLoe0nx
 w0GHLFm4VklUdZtjDdgnJfza1mjH4kTY9B0EUWlku4VW0TdBgALlszZxXCPXDfHMTkatuyUK+YA
 CD0Gsak2g8I/E+Fco0vnjB7NbaC1pvrgO4fdUm5QdBlGEUjmkseBKjC1vBEkjz1ia3nu1kloM9B
 Zy6tCLQkq7cOEbfrEBghs31t1CV4etwkPzKKtUDXFd3M++pvvkMj/LZjW51S9eN2c0BnIo/VUpU
 YCS9+93WDb9wtqvlqHIKl0oT2Ca0wsrPOcnw44D7aJB3wqSe9frz91I4J/s83E/pHHLA7R4JOrc
 Sr5N04HqtNukzHuIQYA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MCBTYWx0ZWRfX1cJ2OYVMXmnN
 kb/Pgx2L9y/Lczplcs4KXwwi5FpFE9NwdCywqe/GadkXNt85zcwkTQtpLd1l92RODIAc+PlJdBJ
 8AoZe1jjEK9U8DqCI3D2JzhifSH9pS0=
X-Proofpoint-GUID: SZYfuArVH6Kj09QchbS7eRtwsw31hflr
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a8ff7db cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=UFf3ptpOQOAA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270070

On 26/8/26 21:38, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/qdev.json | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
