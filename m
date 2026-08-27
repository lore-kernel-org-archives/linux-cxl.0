Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E7A361978
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820208; cv=none; b=Bs2KEQzXcpbtfmfRuMO1aHr021RZg20Ha5b6tOW4jev9AHWwV44xu8QutXjdT+1NiS+3vqZX7RCPkTaQ3piBsbw52sKOUrXVaddMrpsKGVmYrci9hUK5KURwUOX6PE2rqd6vWHtbA6XLFinUxuXxNckIk1CPfm8VBKiPfJm/HKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820208; c=relaxed/simple;
	bh=xjfLEcZbiuJ+phh6Tj68Y6yeF6JUwWViXigVl/FP3Zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LsD/LXOA4dT+zXcw21b2WISB+uTgsLag16cSdbCWUJGgGEq0/nVlUXlPLjRgLUBaJD1+nsGl3IMyCXdoEjox3T9qluyJYJhnyuP8A98SHkH0Z0LTQIY1Xb91hVvZ6KjVi5VmTX/lz3DoLtn84BE4bxkCbN5IEL6WddaUs/S3Nwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ELNsoZc9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OVO6mTmk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ELNsoZc9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OVO6mTmk"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6R6Fr3269801
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AwEnIvKejSYNsZw2U2+fayxSeMSAewks083pgmQCYBU=; b=ELNsoZc9ihe9RR+t
	obuyPbV+BoO4+WDjqn8qfbN1FSyP9xNgJghbb73hYprwW2ahD0J0epXrO1LLyEhC
	ldm7wxvpTnFCtoCL+u5/Tm6UYBQ7aJB0vbp+esznHyYxpHbKp1xl8vegiQgwMRG7
	gBXgZsPCJEbiBjge478V/cIfYz/YjXwZpZDJfSIHOBw1bzj2Iodwno9JddMyLUpN
	jB0c7IE7JP+lUtx5M/H7PEv0wn0K2pafx984jmsgJKFpkDCZ/0BKgcX+GE+91Njc
	8NvoCFtXipk4f/nZVOlAN1XDxgJTj/+MiG4cAdnhBZuQ3EpzFgoZoUAwXkYhOAq/
	x8jscw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga075c377-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:43:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52d33c89a29so5653241cf.1
        for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 01:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787820206; x=1788425006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AwEnIvKejSYNsZw2U2+fayxSeMSAewks083pgmQCYBU=;
        b=OVO6mTmkxDHuNuifDdxmGYxr8mkxPlsQtzsOKkSyCxhNa/vOfqPp8IvM52xHEJk5EH
         MBjEIZAUpWppCDpyCwDHDHUF98HAftU8vDB/WVnANNtPUDvLXWyWmUMjOqGiUZA3q3Iv
         YTca0L/Q3AWQIvuO2d1xNda+0f4nsGG3gpMvG+jyl4oNGbwElfFLpmNfQyFpAFs9PbQ1
         OyQhYGq05Ys5cBRPKZzwPMhh0EEDmCbnvPVD94hDMcbzrSArL9v+uC6UgfL9jRztUcSL
         zWVhG7rE+pC+/Cs8vPgl7yXFhUkVCKtdkJ9DzLi3St+NZodj8SnpjnqdRIPBihhVmObF
         LTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787820206; x=1788425006;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AwEnIvKejSYNsZw2U2+fayxSeMSAewks083pgmQCYBU=;
        b=GxMt5RJU0fPUj4GYARfWYD5rtecpiypJ9glHqe8RKABOPkMDI4WBlK3mLLyMq/txkE
         /dJEJ60S1uTaj3C1kD4u09VxtUY4U5bhkJ32NeqbzVUuoKuLXdYapBDX2fPcjR+lsjZA
         U0DPisGrDw51IwMhrzy/SCxLpn7yFfAwGOKAn5W8CYBSNQgTYMVCqMDNX/99IgKkNKd8
         ygFsn4i2y501lqeN5E8QbGuB3Nuzt/vx1G/ns/4zngA4ao5bgNoR2wiKj+nXUFr4EoGk
         WxyifVW/kx7W4pMPrl8AJgHcax/SwKGeuLS41OYxYbZoCPX+2lLBsQPJtF6PaoGh0Dve
         v4mg==
X-Forwarded-Encrypted: i=1; AHgh+RrpYU09UWsAQ4x2ovFOEOEBbcZvCJmzi3QCXjT8pksnUfNFEya4v29ZyPsL95/9PQAqDWk9ruR1/mY=@vger.kernel.org
X-Gm-Message-State: AFuF++lStFvlXVUmaeUtr+HeJffeSSPh6hQCFXTi5kCeyX8Is5WoMwj3
	j+piR0zYp3NUsW3SJbZPUirow0dqr7NVAsL/nVv9hd53yki/y6GrerEkHiTNTSapbQah64RkSFH
	MihpktdC45ZnAZJQWdob6Nq22SDrIDqZplRHvLT7LiJNx7oPG4fWF/srlNd9fwnM=
X-Gm-Gg: AR+sD13rwMzzNA3z+wGYQXcO3zrqHGE68B8MZgZbYz3I8oq5EtEofAdBW6nUk6m7pwL
	2QDrQrymlzt6qcF6qelLX1Oi+64lmQDOnQTqCkyk4YAgdchPhcndVIL4lKoRammd9TZSFtlkkJO
	VqJV7nszM++eIDEWecIHYLnNLpNP2HWitC5dZf3zhZdBVGaE537x9RXn4Md/VikeZI5Q/PyogHt
	/32/H4oaofl0mpGm1QZS4uLGPzfAUZ07thMjKve7lS/ZiUhwfeJLuBKmbsS8yhvv/DNxkLSgnDM
	Wff6WU8Vy85RkDLNLSkz09aXVPYL6SGYEvp7jGHCwUOPN8Y6A7CxaeAG1YY2QrYn8B0eFgZqXz0
	f5eAD3Tb5UuaKxIiQ4+sS1nhwsLhS7zUlKGj6DG6HMRz/unfn
X-Received: by 2002:a05:622a:15cd:b0:52c:ce3:6428 with SMTP id d75a77b69052e-52e422cbdb4mr125107341cf.16.1787820205789;
        Thu, 27 Aug 2026 01:43:25 -0700 (PDT)
X-Received: by 2002:a05:622a:15cd:b0:52c:ce3:6428 with SMTP id d75a77b69052e-52e422cbdb4mr125106791cf.16.1787820205377;
        Thu, 27 Aug 2026 01:43:25 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4942298fsm36548445e9.1.2026.08.27.01.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 01:43:24 -0700 (PDT)
Message-ID: <a18dd511-2be8-43b7-9f3e-c4248a5d70de@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:43:17 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/43] qapi: convert trivial intro sections for
 error.json
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
 <20260826193840.2152000-2-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826193840.2152000-2-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xlQt8Etvplrjg2Ixqasgmx2lIjw5pjI1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MSBTYWx0ZWRfXw2ia+jRPIeoQ
 vLxf7l3Lhg1y0aYkpixJzyed0MVJ+7gjzuoSY9wH7rN7Mr9lGN+U5qf4o6fin55m0ZccB3bfVXJ
 0rGKXPMu0aAGKXiIIaWIPd6emcsWxgPa7Jsyx3oKRjKHgRzZhIeqjwmdkdfn7iBophcJ4Zx3eiV
 xHJVNKT8nCbGovFQ/Cxo/b7HoOrWM2ErjyjVs80q6OJbNuagtut5Hz9VT4Elb0i5M+nquxHQsHS
 2/l/k8bdSqyuwoANcvSWKvdCiOT7inNCsbCnG+JW/CkHhEeIIhaaMjcJqRHtxb3n2+ozxoQMWqF
 gamRP1gw3ZtcJ5AhYZ5gcZu4YGSkl/8YOcWgPgZLQC0AaC81x8HFPy6mR1gAkgJG1Zh0SqUKxA0
 4ebAWI6sKXWiIAw/5NFesgWl7tz1eIFsYm+5Dx61s4qim832NBXSxdwiR3fStaUYmHllT2NrxNr
 wgDcvFQ7GfUDlNeMhNA==
X-Proofpoint-GUID: xlQt8Etvplrjg2Ixqasgmx2lIjw5pjI1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MSBTYWx0ZWRfX4+v771oIijxl
 Iwxggk6b1sB8jTWrWH1DUoRAjyZQ7uxcN2ROe88C+s1mzO8OSWgZaEAJJBGYGx7KjRp83CXTi67
 Zqkvqu3fKHx4gN/U5zoqZ8BWq7IbeGI=
X-Authority-Analysis: v=2.4 cv=RPiD2Yi+ c=1 sm=1 tr=0 ts=6a8ff8ae cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=UFf3ptpOQOAA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270071

On 26/8/26 21:37, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/error.json | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
