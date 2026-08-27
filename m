Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667EE30E85D
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820102; cv=none; b=aLh6RiOhydioVOLPDSRJc+QBecUhnw92ue4M5XRxQOXy1m4SR16WZgXQhvdYAwXqVZ84NeBbE3YG3ao9er1VN+IMF1rpfT7uQ4uIYRbWtp8UPjzKXAOWqMao/pco80forjIJvEUncAky1tRVp3m/s4SSxpB8XHacxGI80EALHxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820102; c=relaxed/simple;
	bh=PLoXoimKGN3Mf1qZO17rEUOfZ/uvFPem6U7WY3xXkSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imNKc35yGtN+x2E1oq0//gnN5vwDSL+kCKDPg2li1UX6mQgB3qSKTNS+/Cf9y5DnvBRNDYS/eCDTgRqd1nLBU56Z+HIpLXinMt5ty8oCHs0mKp6m8zG56m6ShQmWXg3qAUgw2vUf1oxkWgPM3fT+JVZwfoUCP+w5gW4OwSdk9so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J55oBVw/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NBDC5Q7i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J55oBVw/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NBDC5Q7i"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6RGBU3039605
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SmOBVBiGsHolNU8PiQp4XF/NOueJObjNbn6UN13+F2g=; b=J55oBVw/f35P30EL
	IC+gIz26L1ZloGtBz+LikeppJmtlnBeFHIVmTX7OqeX7oVs7+EavvEhRD+7EoiKB
	YxYBxrgxeF5bcAET5foJEf6+9z2+u0oRTUkjWVf2nm0Cjfz7daYiEgjoME5VoCzA
	riNRXYxQ/RW5lLj1iY57mfJWbF6Jsivz2NA9BI0AYu0Yaygn2mUsP2Gxd+ZtJ/K+
	JGo2nFl/SRmp4P7fMSKDcB+G1ehtaKU0ndRoAjo0T0ch71GajPNlCOqnPfJ6rNfu
	XA/hRGdPW9UkhctDS7OTrKcmS/V49GzAbws4bdBTDczcrYiFbvgPZi9l6EGa6o43
	Vz92kg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga03ac2ny-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:41:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52ef04756caso13344171cf.1
        for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787820099; x=1788424899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SmOBVBiGsHolNU8PiQp4XF/NOueJObjNbn6UN13+F2g=;
        b=NBDC5Q7iUwPilEaFAugb1oN3S7IhJy6WKzqP+ONWVAx9sB6FghelM8hgSs8xlzaejW
         HPRuOXhLDOGj9nV2D6LoU2vgFkIz7VHfYeqOCPl6ky39hI/bwUsIR5UU6YDIsi4e5lVk
         zHdZ2WGmt4qN4vGMz7IUJj5Y7gyVekkmW+lml/wxi7yQFciF4CBdNZ+TbTvIFc4qnA4O
         13EDcypyYPyuMjDdBrNjllWMttETFDvprGF3pK37nI6UPv188VekgXMUgXRZIH7NTlLq
         Tmi8rJTHjwfp364UWym+m1ukgUMO92oS7umc9+1acGRs2qnWgCTyUvI6O71q3HH0Lvd0
         YPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787820099; x=1788424899;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SmOBVBiGsHolNU8PiQp4XF/NOueJObjNbn6UN13+F2g=;
        b=Knxz2XYAs2B5Ecc05EcYduLREpPwXD4dryB1ErA1CFpeT4HpAYACEPG5d0pAb8ucM1
         O9pVRqRIjbSGmuJ1eHqa85pDOe6X9YrnpkZEZG9DlVy0A12Ute+J+68FPaYrlIbgPe77
         03fTE1rkwXdjqpmYT2MKOXpJqtqBhhB4IbYceCwO88tW++88UhM7aE/9ySIr96gtjNff
         pK2qgp5+urlNXFyo+cwrHKEMSo6DRxvro0i+rKkJGeRcCCgHdc+x7ewP0C5gAbdKj4PK
         y764imCt3cmp/kwGEteR6E2ml6IF+atyxiDTf/OIRmk38P+7oFoxuSSIJ4iQQpNAT5bH
         VXCw==
X-Forwarded-Encrypted: i=1; AHgh+RogZNESpG89mUdzEQsk0vwhimqpSzEpbMEmb8a1A0MrHGIVNWEB42J+aoqE2Wd7y8QMW8LboB7eM94=@vger.kernel.org
X-Gm-Message-State: AFuF++n7m6I7U/gG23pBKhrtLTzM7jjUNPfVaXWY0AcBM6d6fiWneLns
	u+0Vl1uRVxlfg5RHemNL6v1Lbqw51V1JgEXd9zX+k5jaxnixh9DxLvLyLmc1iJpj4VWt1rGRKhR
	wx8/DlkF4zVyqnVcNyunWOGvr46iGwX/7BMA7IBXm5cnu579tCBEW7iA1t5LKXwA=
X-Gm-Gg: AR+sD10DsHWsI+3twZuU3/jE7iPE6Iu7erLC64LYE+4birTur+WmPL0sd+h0oZ7C5Gz
	QDSkBAG27mUjVcViHYD1zCrJeDYTZ0lnmdOCz+vtDnkU/ylMHN5qQ0KNKFICjiJaDxur6KxAUYK
	reDePQs7M0inV81KIw0VhzROOquUFXsmMAIsUpfS/YYGDLeFJoY018BdXUyVJ64tNRXxZ8Cm2IA
	fg05cEc2+OCogdqJQ34eTnB5W1HIDbmpxEr1G2VMtB0fUvXK3hQxG3b1X/Z8LFzN5VRss8w+R6l
	WDqlA0w5MIHKa+MUpalS0jbjwRK+GqZ8qoPcbq1djCWmzRMZ/iuE3kB3J11rQO0clGSVJBalzNF
	c75eoGDU5o0REWV2zpVM1G9eW9mEbzy/Noy7bYTy6dz6H3mBw
X-Received: by 2002:a05:622a:1914:b0:51c:22c5:daee with SMTP id d75a77b69052e-52e4234e4c1mr140036991cf.29.1787820099527;
        Thu, 27 Aug 2026 01:41:39 -0700 (PDT)
X-Received: by 2002:a05:622a:1914:b0:51c:22c5:daee with SMTP id d75a77b69052e-52e4234e4c1mr140036341cf.29.1787820099116;
        Thu, 27 Aug 2026 01:41:39 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b49610170sm83255455e9.6.2026.08.27.01.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 01:41:38 -0700 (PDT)
Message-ID: <693accd8-abe2-4cde-ba61-0a33adb4c7ff@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:41:29 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 35/43] qapi: convert trivial intro sections for
 run-state.json
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
 <20260826193840.2152000-36-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826193840.2152000-36-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: K5-czr8fPgkZs_SxI3L6YX5fM163a19k
X-Authority-Analysis: v=2.4 cv=VdLH+lp9 c=1 sm=1 tr=0 ts=6a8ff844 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=UFf3ptpOQOAA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: K5-czr8fPgkZs_SxI3L6YX5fM163a19k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MSBTYWx0ZWRfX4KwPH9wI1QC4
 H+HdyaUmjAppfvMp7+wUnivPKggB2YWLWms/85zYPrmODO2HP70+2oL6mQkSfjadI3Gaw73Yv8G
 dW6T/hxfwY09nJnkLmEo7uWK79A31y0/ZIKX5BpB8hg4gW1weszrg8XlC7LEBFfu27YWFsqV0iJ
 aZ84b13gzZu7xUjStnRxCEFaM+BMHORSNk+Prk98rnWjwyooTGkDlM1ttJ9njVL242p/ldJmu2k
 W0Yua/Ao4JEjwdAGMnxMXnZ5tsU72ZhuYBvRj372YS75GIjbqxIqvc51cxI1pk7xLyKcN1rVjju
 DY8cB1ooy7hEtlkUbBHDJXl7u0V+NokGf8Yep/Z5BdhLXyg3pXR57/9YnAPTKSpXMLS8P/GDjMg
 pXNggs8CzBFwW5X+VMcbRuQU4a2cN3IqLwNflClCj5f0VzFkTvJJi750HXIrfDZlihjaxwBcdzy
 c1ao3biTxPDne446Xrg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MSBTYWx0ZWRfXymarGyJHq7Dh
 rp3H++69JBS/ueC+M8h69ioCoA3T7jN7TsFKo1LxeROtpjX8uBzG/k0aKZ128bisTU+MRZC/GJu
 XKWfqkqn/iMjawtM0wIWia7QLJ+eJo4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270071

On 26/8/26 21:38, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/run-state.json | 113 ++++++++++++++++----------------------------
>   1 file changed, 42 insertions(+), 71 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
