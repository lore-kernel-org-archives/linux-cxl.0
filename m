Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E4D3D47D9
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154921; cv=none; b=EWEu4Cip3tUrT7bOkSKuq+38CbVAa3WU0+gP2qJ097UG2kqIyVUmym/GJbeAASuKVKl+GtACK3QuY0jcWEQCdnAx6JlITToxx7LdeDh4pqfGDaFR+VJucRO/KhNKJM7EbYKPvhfz4xKqXnEStRHakS/MZd894t7FKUvV2bP4WFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154921; c=relaxed/simple;
	bh=XRaW2nSJW/ZJH/KETqqjeqOqS+m7sEajGew9umlE19s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqJPdikQq29Eab0JeKRmkWdBuUhjABf0uJiTuEESBA5uvuSQhTWnh9L0ICYz6t15yxojJksCoqqrsEv82BTSNKqIATd8Ra8FQZOUMHncKNFjZFmDcIwcFIMJvVU62O1LNcRx6TtDgf7oYg6NH5xutFzJasVPfpnYE05ASlncrbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RCqAKCl4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O/k1shjE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RCqAKCl4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O/k1shjE"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FKPG7V577469
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 22:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pzttxML50p3Qjxs95TmyrNyRbKMzRVF3lav5cviw9SA=; b=RCqAKCl42KVFy3Fg
	37+c9449K1KA8oZz1v7T/8dDalZTIlbiUDn43AeJzOIn3+aeIjSCAFv+Vf6cV0kM
	mqdzF1/qjxrsi+mBA8G6Ip0HPcURH5YKZi1l+BtIjcy4zGLC9ShAjo8Kyl1est/2
	UKAdiwacGlZFttwuZ4IiKnNtxNnoEOSLOpLDTdvn7nc2zzR5VmUd4SwC5WEllC6+
	3UZyiLwZwVbdZ2kBXSc4J+LbQJlgCh8bFaG7lOBn6CKRmctQAu2Fs+ZSBWXjFl9k
	rQazxwYC07/EjH5jPjbAsvPJbZ6cYmj2uNC/Hzi3wtrRlybolzRQijMK2dUq4EKq
	h/Q3cA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feefqh18y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 22:35:18 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cab048cdb3eso6521919a12.0
        for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 15:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784154917; x=1784759717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pzttxML50p3Qjxs95TmyrNyRbKMzRVF3lav5cviw9SA=;
        b=O/k1shjEGKcSlvHlLbx4bW6LcxhoHVdRd9ewt+Yxhpik2cc+1xPcImyKGzga4/lNOw
         Y0WSAbqxwEIUvbErYHr2RKuUx5Txyjcr10v325bOHyGQOpic/IbaD8OxYRnbDNSK+JBj
         SNvLU/fjQH3JQIDaNQcgFJfKo/Vnw+Qjnybxt1XxUwlW3nMmZftgdVxW3p4923l9a7ZU
         vTYf2P1xT0UqBNgZ+6vpeP9YscmwAOlz5eUtYIsWyBg64LDbMDDqX3dvhgrg/gJ3Fg4l
         vfrIpBUBi2bVJKzFHQ/zZWqj2BjFN/UAV0FNwUkVShR7GzQNnrVnDrLZ75OH7UntCEv0
         WV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154917; x=1784759717;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pzttxML50p3Qjxs95TmyrNyRbKMzRVF3lav5cviw9SA=;
        b=h4Ng+1ft57+zRLjA6FyUOLo/OvveD4A6jkcQAYuUo7azkI46lbmWXsOC7cfyAJhwTI
         nusQBGcRhi5WD/Co5PAhSxRrWlWEfF2PsHJs7amwlThD5zbip6l3DaIP2USo3He5j89d
         xnnNuWahRTxDYpeVm74lnrC5Kl5WCiy37gzPIkpih9wiymILGPQtM5NYnQpxAx7LYHXg
         kpS7XqEkQnreODvTWBGJoJXsZWEoz/Cx/qDRq6wJ91cogCsu/sAZZB1soVjQ/gxyTOtf
         3KD46Chj2IyNkETIQJWbN5TfK51pB792Y7cdspfVSw+Fg5UD2OrfYi0ArV/DQ7mYJSka
         nyQQ==
X-Gm-Message-State: AOJu0Yye9NObUFDYzw//lXY92H94HVsUnGvTmHAUwbW3OPV/oxhf5vyw
	S9P/UpLeyWyCg5B8pCmRV6+QMjtH5wmJZVS9v0dKYKMCD1tFU3nUFCIa+5386vTSC/aNJmzXZA/
	DPPHYVX1QbYUn3xDeDG8qyYqmjE/NJXTwiipu/XSDu8LCoGSa1CuS/pkNPhdBTmQ=
X-Gm-Gg: AfdE7clwukrrHxxS01mR16SaNKZMQtD+pU2A8zzEZaQ4ZMMD+JyMly501JqCfpVCdYc
	n+Zl2cfXNdbTnK4NnTnBavM4cx4ASgEVy8HaExaqasdbaueerAryeNobXxcPg+/Dn5F00NaQXuN
	LzQEbr4IxDAvaVfQuWHZNLcs8DrmfPHbIRzp51wfQjZREpfzlVWmHznd2cVrhb3DAeMu762OgNH
	TVmGfc5lBk2dTwu50RUf9yviUzsx6R+8v3X5qHpqX3PhHeeT3GsyMAxPd24R8lCjTtvKaYtQzVe
	m28yoA+Yoi/gwexZLR5iTaKZS+Bn0r7wXRHDTKZ0ekP/lY+mz9afwnw+71rd8Bf2JSvBt2SiWnM
	iP2xoQVFWCaRMt3vrBv11ztSr8juWJiEgnAx0N1ZjV3dGN6nAEtEi5oRP
X-Received: by 2002:a05:6300:6705:b0:3c3:8ce8:203 with SMTP id adf61e73a8af0-3c38ce807camr143379637.50.1784154917189;
        Wed, 15 Jul 2026 15:35:17 -0700 (PDT)
X-Received: by 2002:a05:6300:6705:b0:3c3:8ce8:203 with SMTP id adf61e73a8af0-3c38ce807camr143334637.50.1784154916555;
        Wed, 15 Jul 2026 15:35:16 -0700 (PDT)
Received: from [10.71.178.173] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6f0dcdsm3949168eec.31.2026.07.15.15.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 15:35:16 -0700 (PDT)
Message-ID: <642b8ff6-5309-4500-bb62-ae5091bb7ea7@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 15:35:15 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/hdm: Enforce CFMWS memory type policy at decoder
 commit time
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        linux-kernel@vger.kernel.org
References: <20260711003341.2602368-1-mayank.rana@oss.qualcomm.com>
 <20260713160448.wvkpmbldmfciq4a3@offworld>
Content-Language: en-US
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
In-Reply-To: <20260713160448.wvkpmbldmfciq4a3@offworld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=APNfGQ4N c=1 sm=1 tr=0 ts=6a580b26 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=R4ayLD03AAAA:8 a=bnOQvwX50u-8yI3fIb4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=qJlm0-shE6CLU_iKUWNr:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDIyNiBTYWx0ZWRfX3oPzGkAXlzXW
 49R76w7UYJyQ69WPqBnaUUR7awG3LbVoYoqwtwO6b707rHkhN641M8xK/mhmcgkr/ua/U2XsrbS
 C40rJGnTw4A1Fnoik9R9Op/GKcvFpsE=
X-Proofpoint-ORIG-GUID: sbIeyBG_RbM4QUUBT0c6qgGw3GqS7RE6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDIyNiBTYWx0ZWRfX7xmgY+FQLFFi
 SC9uHZDeO0VPCMBclzH8l3ZmVr04wgmygEpIx42pSFPReIhR6Qfe1zvTR3toDRJQO6cjD96jYmi
 zS9R7oQ3S5bbmO4D5bWxfE9YQBgGhIKpAyTgqiKHCzczX6SoZZ0yTktrza3M+4XPBmg60j5kvsy
 hxbN6ITjZzvcOx6rypPKW0kn5IfKSvNNqBCgf0H6XSjYafkP7wD6Bb3JodjI/gGI50YE+ErG9ky
 sAmaHmCHEgHqMucvio/vPPxqQi4FxnDNVEQ0JOWlFKsOoOiV/RQQPsynAuNJFjQJhFo7FAqARIx
 J7oAboQeX05CaEhNl+gkZuM2/BvpFXIi3XJ3YXNVKV+oE0/4ZNaKAWcuytlRbttmMX1XPkPqa2h
 D6CH8fAGJxh6/2c7vNdGITq6dReZSVxNEXvpFb4a6L80sc0iz4XKA7ovCCKDftg81MtCrp6hG4B
 3zdJw7a12Tt20qrQNng==
X-Proofpoint-GUID: sbIeyBG_RbM4QUUBT0c6qgGw3GqS7RE6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150226

Hi Davidlohr

Thank you for your review and suggestion.

On 7/13/2026 9:04 AM, Davidlohr Bueso wrote:
> On Fri, 10 Jul 2026, Mayank Rana wrote:
> 
>> A CXL Fixed Memory Window Structure (CFMWS) in the ACPI CEDT table
>> carries a restrictions field that describes the memory types a platform
>> window supports.  cfmws_to_decoder_flags() translates this into
>> CXL_DECODER_F_TYPE2 (HDM-DB permitted) and CXL_DECODER_F_TYPE3 (HDM-H
>> permitted) flags on the root decoder.
>>
>> However, nothing currently prevents a caller from committing an endpoint
>> or switch decoder whose target_type conflicts with the CFMWS policy:
> 
> Hi Mayank - please refer to the latest Back Invalidate patchset (v5)
> for properly dealing with this:
> 
> https://lore.kernel.org/all/20260615145529.13848-1-dave@stgolabs.net/
Ok. I will review propose changes, and rework upon this fix.

Regards,
Mayank

> Thanks,
> Davidlohr

