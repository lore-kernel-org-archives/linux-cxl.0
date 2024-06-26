Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA4518FDDB;
	Wed, 26 Jun 2024 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719421670; cv=none; b=f/tpWNYORKDKPuVZb1c1KxOKItdEHx84BNDP8XblzPHzFAMb0h0dcV5bNHnodK44nC2squMz6ampLxBFORxbrQx/SSIcSAj3CrNdQO5qys0kZCBSgLqBy0toPPt9X4Gjn7m0zN8SiiuGHp4lMqrKX4CLrY0de3ZrqPTWl71+Kx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719421670; c=relaxed/simple;
	bh=kbZfnvVRofJofrXjdAQ0NM3qIZEy7Cwc+QUG2rU3NVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EK/VyOaJ4WcRIIag7f5c4iXaRbNOhcOdObrT8cNvolyixbJB1J6KtL4wL7Kr0Kn3OWCfexopvSAjYyStGOQGw6T3VerNMUBxxNUW+V9xxW8EAR7fwaQEmnYliTmTDNnuZ9qmMTUIRdBON9VgCxJSzqDe7Bq63oheXylwMvz0DiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fPoDdK0u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fPoDdK0u"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfPoS003769;
	Wed, 26 Jun 2024 17:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tASF8765k3yZcy7NfGgI2MYdpJ9SJ7bI4KsPBk3R1i8=; b=fPoDdK0ufwcoOAfu
	nqhwUnrO8JRu3Uybb2z10mapo/Phj1cc/Gg12n7mlfR6GK72Wpmv85vcbTq7AhGL
	vsY+PYIxhaj8KHL3DbLZarZOG9jkO1VHD9qJ6ao+TVQyoLiYB+P2sENRRaZ1khwf
	LVhHuT2WuNSD1gKN7HFFneWfHzvyQNnNbjirKeWvltrcIczbMlZVthvJjpnkx6Yu
	8kZTom7Dt5f1l3JFYFUk+dsRtPkQMVvmZ8WB4CpjJpNOnmyLRo+wjQlR3r0UdAWZ
	6SlxWI6FvOGVcRkxUjmoxCaLJUmCt0u0TnY1c55dqmVTu4bYzAbm7+Zu8aKuNHNc
	P8tiBg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywmaf2n1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 17:07:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QH7cQL001386
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 17:07:38 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 10:07:37 -0700
Message-ID: <e9cfefc0-e197-42aa-935e-de4d66b5f47d@quicinc.com>
Date: Wed, 26 Jun 2024 10:07:36 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron
	<Jonathan.Cameron@Huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>,
        Alison Schofield
	<alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira
 Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240607-md-drivers-cxl-v2-1-0c61d95ee7a7@quicinc.com>
 <20240607151046.00002ae2@Huawei.com>
 <aef7c12f-cefa-4823-b3a2-920c12990afa@quicinc.com>
 <73d13869-cb80-4226-b8fe-3e45fb7d2518@intel.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <73d13869-cb80-4226-b8fe-3e45fb7d2518@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nz9dXlV86oDCxcZRSP7OeQQ3rD5TKYbW
X-Proofpoint-GUID: nz9dXlV86oDCxcZRSP7OeQQ3rD5TKYbW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_08,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=800 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260125

On 6/26/2024 9:41 AM, Dave Jiang wrote:
> On 6/26/24 9:02 AM, Jeff Johnson wrote:
>> Following up to see if anything else is needed from me. Hoping to see this in
>> linux-next so I can remove it from my tracking spreadsheet :)
> 
> I have it locally queued, but will probably push to linux-next after rc6 drops. 

thanks for the update!
/jeff

