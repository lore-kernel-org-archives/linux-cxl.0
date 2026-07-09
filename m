Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51427083C
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 00:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783558096; cv=none; b=lQ+KBg7SVhitkuS8fEXB+qpA+HfVoqycte+YCnHUA6j4tE8lFMzhS/KboD5RCicB/WtZ8cISq7WaQp6xJivq5HXCRJgNvRe8SWH01YRAvewMF2dq7vo2/wSlZLzVzMBasTmBpMHz0ClIio5NQ2EHwyRPTppfHKyyQkqbOnNQ1Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783558096; c=relaxed/simple;
	bh=0kJ2IMa/afXUZWKFGfFlPo9i1DnpVDCTWIdgE6KoPac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/pazskTyGHS/12gqJer7Q3NkBe+8J1grR/mQAiQU002INM9FdRS+MOP7e+bb7BdHllttRooEGImLN9/cJqNEMF6YItEPq5ydO4ce+GLreUi3zXHAfyXo24MHIgpAp0LFMKDq5kiWuv3CmqGJaDtfE2DS6bOrLnztJP9nRRONqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fYaCyh8c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fvar8IeL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fYaCyh8c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fvar8IeL"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668N92NW001670
	for <linux-cxl@vger.kernel.org>; Thu, 9 Jul 2026 00:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gz2zzoiKa8nBCLIddH2LPjpf+59l5OpZUeFvfC9iTuc=; b=fYaCyh8c/XPGnP7L
	cn6GO06ER+TezAcOL7FiE6/nDX9Txh3CpmSGfJUsD+NO0bNmEJ4ifwqY10Dmuv72
	uZvBPwrL5RTO4g8PorJYZI02dpVaY6u5SNU+LKgbB3lvP2bqTbGubfXG0UEqRN9a
	oiJINlfBH7ksFSiBegvIupXVtKnGQ/gyWduwVK7b6nEQEXdy4M9WMhdFqD5924gP
	pEhgr8CgaZpkwUyIvdynsxC8cASfdL4ioDRm4pVZwYtncS2eW2zYFZq9yMl2Cpzl
	P3WSWlVGhCBjItEgkOLZ88kWlrVNiwWgNJzLihNQSE0Sg5IEDQgQYugeybJ6K5S9
	wZo0Ug==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9urvs33b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Thu, 09 Jul 2026 00:48:13 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88d7a75507so573903a12.1
        for <linux-cxl@vger.kernel.org>; Wed, 08 Jul 2026 17:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783558092; x=1784162892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gz2zzoiKa8nBCLIddH2LPjpf+59l5OpZUeFvfC9iTuc=;
        b=fvar8IeL7rHS9GYzq6BDudXzZRhLmyd5BhhOhm37NpAxV7iIjpdSYPqISWlBTUcZYq
         FkVxqvxHtVcKAdK6UEnCVBX/tub3fvW7YxkgV9l+BIKNcQnwzlcj4p5tFQdN1EtH2/yH
         CVhvnglngF1+ugnfFX6nrDamalGF3f83mTRubsn0bnkO7Qq1nWrd9ax5RIYtXP7P/vDo
         nUqbdq9v5ysBrA7DDk7ht9Y9uQFbYWS24aSFiMWtdkym6e7k02BhONSsKdZ96gKmyV9y
         s6NMEIQNszs0ZmHcfGhMi5QuGpjciG98T12p6rUyRhj7kNptkAodpwM0gcMgmLNGhVpI
         mA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783558092; x=1784162892;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gz2zzoiKa8nBCLIddH2LPjpf+59l5OpZUeFvfC9iTuc=;
        b=hHGb5sIByMvx8l5tIIvHjoQulLoDfONXf1pNRZVCPV3wEuYwGCHecFrsE0AvaNxfZu
         84Z32M83pDz3iSiKOgtySxXMLLhGpGp+oPaFzoZM4gJ8r2C0n4RjkMP9kEbvV4G62/Jd
         GCuv78ZNlN0QoSz0j2LWqJZgcid6RfeHgNSh1lArp8j4+nmsUyMjzzAaBRZgIzAcT6SX
         HQ0innyzzTPUNJZTCrUcLHpBKrSkkl8jtcPVkEx5/ixj8LI4Cz9zd0RNncQr96d3lC8O
         /JRXgxHA/Vw9TPtYvRSC3dT448GoGe9ZONjEe76HhLC+jCN2WSwMdoPEcMpXF24x+RKA
         AZCA==
X-Gm-Message-State: AOJu0YzK2Pa4sU1yk0iz+joIcjJoYht5sLMRSvr9IUGXhO92eeRWvOQK
	+UY982ARm9xiWXQDvhbZe6Vyk8TjU43OX/Jg2jCvdfHLcFtv7FrA+uRWII+5GRAsvxdJ+7vAZ1g
	+Y2CZOR5eCBXme66d3aUUU9EsudvyYqvYiCdRgBD0DPaNtU5LhF2w210Q07lmIZgO1/gFI4s=
X-Gm-Gg: AfdE7ckNV52xbGRWcQ5Cc1bVq2E5lMjvjqbb3JdlqfEaYjXDd7keAo9azJyZM/k3/Gi
	T5uQKthBffa7QEyAJgl/64bldQQZVatofaE+opitH3f8IJTx2jWxXwRt7db0ribxaLi+uG6tD7n
	U5kSqFZGtasiZsH1hWuBlOwBNqfV+OZ1V+DWxPyeX5LwelsBr0CJPWTsGIg4228+TdQ8n34nqoA
	AGhLMYz/xhRrixhYm73n36Auiu9vC58VOj7r00VGvrGHgw021l9vWTL3PGW+3r96M21HEGjV6U7
	TGvfeND/488EjlEUsuKgaWY4DF/eBYFtRbuMLvQYiQ7sIZajVUFQ9JUnEcgebNUhR6AD3aVszNh
	/fBpudkJTznhYVly5elq51HPm0eglSpXCqlwnTwUsfBm43Ej3sa1n/ChgzeTnsaWnTkw=
X-Received: by 2002:a05:6a20:428b:b0:3c0:9c19:658f with SMTP id adf61e73a8af0-3c0bd00234cmr5913866637.73.1783558092561;
        Wed, 08 Jul 2026 17:48:12 -0700 (PDT)
X-Received: by 2002:a05:6a20:428b:b0:3c0:9c19:658f with SMTP id adf61e73a8af0-3c0bd00234cmr5913834637.73.1783558092110;
        Wed, 08 Jul 2026 17:48:12 -0700 (PDT)
Received: from [10.71.178.173] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31189cd8234sm13895635eec.9.2026.07.08.17.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 17:48:11 -0700 (PDT)
Message-ID: <5bb46fcf-d769-4ef7-889b-ae1524cb3492@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 17:47:49 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: Enforce CFMWS HDM-H policy at decoder commit
 time
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
References: <20260708213047.267024-1-mayank.rana@oss.qualcomm.com>
 <20260708215718.A584A1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
In-Reply-To: <20260708215718.A584A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDAwNSBTYWx0ZWRfX9XHhLklzooja
 UfN3mTshJrUVoiUGlLBPSbMavieeyIizqBg2N32y3OWDqYGlEeZaKHFCAJY6GhbPr+OUlrhTNVd
 I6EezSYY96sMUdf8iX5Zh34apZ6Sr38=
X-Proofpoint-GUID: DAEJPnq5k3Ky7CSRUDHL9tl59MTLZCMm
X-Proofpoint-ORIG-GUID: DAEJPnq5k3Ky7CSRUDHL9tl59MTLZCMm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDAwNSBTYWx0ZWRfX3qWXWL/uBCVm
 IzEhfG6Srq2tQrEq9ZhE/dG9s5XzXsmEcBrmH2td5OYQfs7kmjcRmrgahodWI6eZncoAlCfsN27
 qSmcWGSa6PvJYG0nrC+squdTjGGCpAvwe4Q2TI2nuYH7UE7214JkPZOXD7/xFhMkISjvelFCz2o
 zh6wU7DaL+Yq50HJO6ZMBwriEopkcbTu8uGhUeLgdMryG8/ZinH9VmHJ9iN0Y9abSJ+04+O0uZD
 u6XRPOQ0VjlkXk/4G7OkV1JONMptAY+LNUxTe8QNzIKAJ2bodB7/69P9Lt1K9K9Q4Viocl6g4C5
 PS44XUKNwtagV88LvSL/esJsiTjea1dJw3OUWPE35XiS0QYlHpolZ82AyMNUoyYgQ5lmZMWAa+r
 bisCA9g3CXT9iwB+9Ft7ZWj8CJEkkr1af1gJtCMhAijzlJaXN7ZB0QEEHSGbz7C2ZDYINleMlJA
 Z1bwLveCftAMk9Q3e4g==
X-Authority-Analysis: v=2.4 cv=H43rBeYi c=1 sm=1 tr=0 ts=6a4eefcd cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oHVBGa2KwL-N18TGJlMA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090005

Hi,

On 7/8/2026 2:57 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Incomplete CFMWS restriction enforcement allows HDM-H commits on HDM-DB only windows
> --
> 
> --- Patch [1]: [PATCH] cxl/hdm: Enforce CFMWS HDM-H policy at decoder commit time ---
> commit b323fb5684f24e6f22174021a05686b301fd4e31
> Author: Mayank Rana <mayank.rana@oss.qualcomm.com>
> 
> cxl/hdm: Enforce CFMWS HDM-H policy at decoder commit time
> 
> This commit adds a check in cxl_decoder_commit() to enforce platform
> CFMWS restrictions, rejecting HDM-DB commits on windows restricted to
> HDM-H only.
> 
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -834,6 +835,19 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>>   		}
>>   	}
>>   
>> +	/*
>> +	 * Enforce HDM-H: reject HDM-DB if CFMWS lacks CXL_DECODER_F_TYPE2.
>> +	 */
>> +	if (cxld->target_type == CXL_DECODER_DEVMEM && cxld->region) {
>> +		cxlrd = to_cxl_root_decoder(cxld->region->dev.parent);
>> +		if (!(cxlrd->cxlsd.cxld.flags & CXL_DECODER_F_TYPE2)) {
>> +			dev_err(&port->dev,
>> +				"HDM-DB commit rejected on %s, CFMWS restricts to HDM-H only\n",
>> +				dev_name(&cxld->dev));
>> +			return -EOPNOTSUPP;
>> +		}
>> +	}
>> +
> 
> [Severity: Medium]
> Should there be a symmetric check enforcing the HDM-DB policy by verifying
> CXL_DECODER_HOSTONLYMEM against CXL_DECODER_F_TYPE3?
> 
> If the BIOS incorrectly leaves an endpoint programmed as HOSTONLYMEM on an
> HDM-DB only window, the kernel will auto-discover it.
> 
> If a privileged user subsequently uncommits and re-commits the region via
> sysfs, cxl_decoder_commit() would run.
> 
> Because this check only validates CXL_DECODER_DEVMEM against
> CXL_DECODER_F_TYPE2, could it silently allow a CXL_DECODER_HOSTONLYMEM
> commit despite the root decoder lacking CXL_DECODER_F_TYPE3, thus violating
> the platform ACPI constraints?
> 
Ok. I will extend enforcement to cover both directions: HDM-H commits on 
HDM-DB-only windows are now rejected in addition to HDM-DB commits on 
HDM-H-only windows.

>>   	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
>>   		setup_hw_decoder(cxld, hdm);
>>
> 
Regards,
Mayank
