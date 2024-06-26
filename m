Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24FA18FDD1;
	Wed, 26 Jun 2024 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417743; cv=none; b=RZ9YFbkaJxlomoA9u05ol10X6+RUWBc/rUyyw85OwrzFJwR6MfqRVyvJ5agiI5g8+KqeIeXQRi09iJ6o063paCEayKRoJ0IWS4a11y9hx5D5lqV3R7mGfqfecq61AWFBkVqYPZIykt4Kb38fGyEAlNaXTvwQSaixRqP9ysneUfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417743; c=relaxed/simple;
	bh=Nks4r5sngP4w71v87g0KsbMCsvS6aoQosHoCsuWrV3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FjLwopfPkAzyhOb1OmQCLRow+eEpXVUaDKbslVrdfPXV3Eqi0lORE0hqx78qivWOLWBjqfFXWY2yNwZvg20cXNDLDFV7urvuS1khH29rJTnd5X/o7mq44RdC5M4rlmK6EJbTSTfxHmeVU3mnkhz4+67938D0U9AvN5rZT1u/Jzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=afnHNbd1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="afnHNbd1"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfO6F003678;
	Wed, 26 Jun 2024 16:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d5lv7XvXAWTWI+Kn7k5U1DXldo9c2WgCrQLyKqLylZ0=; b=afnHNbd1TgLzRu/L
	pZfuVfInFGnE3vRaodxR7+sO2SmsADe9/Py6Tn1YKivAgHfPHM9OjgTJ2jTjL3xo
	3JC9kfqGbKb+7T4YtgF1VifNK0+4ucuyvEirtTLeOkAAtp7eKtVuekWizxky4Jo9
	52fCN/HmbarJ03Zqo8BWO+4oNBdbfcTceE6unWI3/AhtUVaqlUJcYkDTNKUdARDp
	sfs6egqbFg13F4e1QRi0zUU1LlqNWTuU9F048OH58xoNe4uJE3TIsLssTGWHGGz6
	OAJJCZ2r5L3noJHarctEwM2U2Kmw93y5EP/jkFsxgGREUimYmnn85dHsrZDQQdn8
	6TtFgw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywmaf2g1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 16:02:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QG2ALV005842
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 16:02:10 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 09:02:04 -0700
Message-ID: <aef7c12f-cefa-4823-b3a2-920c12990afa@quicinc.com>
Date: Wed, 26 Jun 2024 09:02:03 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma
	<vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240607-md-drivers-cxl-v2-1-0c61d95ee7a7@quicinc.com>
 <20240607151046.00002ae2@Huawei.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240607151046.00002ae2@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZL9Kcr36Hzgjj98mQT7fIs5NNKrA6Sq9
X-Proofpoint-GUID: ZL9Kcr36Hzgjj98mQT7fIs5NNKrA6Sq9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=752 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260117

On 6/7/2024 7:10 AM, Jonathan Cameron wrote:
> On Fri, 7 Jun 2024 06:57:15 -0700
> Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
> 
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/core/cxl_core.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_pci.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_mem.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_acpi.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_pmem.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_port.o
>>
>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Thanks,

Following up to see if anything else is needed from me. Hoping to see this in
linux-next so I can remove it from my tracking spreadsheet :)

/jeff
