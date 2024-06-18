Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9C02139C1;
	Tue, 18 Jun 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722565; cv=none; b=pCqoQOFdfjw4hfiKM7oegqlBs4h92g1vBmzL1izlx8Bg846OpNr9BEZtvM79QAg7JXuxl8yh15Dxv+JrHW5it2MnCHwNq1vJQ1EjMvVfIU/KbGI6sbW82KubznX3y7bveMZ0k0uJaLLE18l+BEdf2xLYgA0ZLk4N1SSLKc4BixA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722565; c=relaxed/simple;
	bh=WWIcDGYJuYuAdpT+XGlc7mKr9FETSJw8Q7URuI+3ymI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R5Wbp82Tg2sVKzZ4MsXSmoBlnLm3k/rXyHZ1t50giZ9ghMl8tNjRWHhmEcgwn2/d6iCZu8uAoEeFTv5e0m7hQxx72coF1Rbs2o+CQ5uZ2DIaQifylokim4LqAbQF9yPx82fKVnPRPv/q6Usf/UN7em2Lz8ydz4ET43qHm0brox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UmoM2J2n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UmoM2J2n"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I8cL23010046;
	Tue, 18 Jun 2024 14:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7JR76i9sJfWyWdICy5qRE0YnfzpbfIDKRwlKkoNeGzQ=; b=UmoM2J2nF0IhNGz6
	obQ/8uuV118CP1ufk4XLElUPcENWFWYkJ9nZS2oLVH4VpizxcGMM4ATB4d7URCYZ
	69HTp33e7tWfqNmPtc7fc7m4zBrzhQ+o+pIH0G90Air2eothVcMcwp40tmlTY7Ac
	bs8iuAybPDKAaee9NaN1AcUmhDUlcfkeU6tni6NjrC516pfVc59ngviokxF5t0zy
	Z4GkWPzVn8z6OUIgKGXQUijDQFwkSrdkKII02ehB1CTwYRgf1Sahx/dD0j+Se3fJ
	29HrqGyvZGnig2qK0ag/G+lO5KVgtnj4ycOxalaf3Pn6T5+lrLKdI08ZzZRuRDGm
	uSq9+A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yu6wa92cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:55:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45IEt9EB018995
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:55:09 GMT
Received: from [10.48.243.231] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 07:55:08 -0700
Message-ID: <5e355d8f-3b6a-47d3-b559-61acf4746859@quicinc.com>
Date: Tue, 18 Jun 2024 07:55:07 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Yicong Yang <yangyicong@huawei.com>, Will Deacon <will@kernel.org>,
        Mark
 Rutland <mark.rutland@arm.com>,
        Jonathan Cameron
	<jonathan.cameron@huawei.com>,
        Frank Li <Frank.li@nxp.com>, Shawn Guo
	<shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix
 Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Yicong Yang <yangyicong@hisilicon.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <imx@lists.linux.dev>,
        <kernel-janitors@vger.kernel.org>
References: <20240611-md-drivers-perf-v1-1-c001bae6da5c@quicinc.com>
 <bd65ab86-902d-abd1-1b8b-d473c8f6016d@huawei.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <bd65ab86-902d-abd1-1b8b-d473c8f6016d@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3dgRfhfWj9neqKsrALVizpHh1PsOoMHb
X-Proofpoint-ORIG-GUID: 3dgRfhfWj9neqKsrALVizpHh1PsOoMHb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1011 bulkscore=0
 mlxscore=0 mlxlogscore=881 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180111

On 6/18/2024 7:33 AM, Yicong Yang wrote:
...

>> +MODULE_DESCRIPTION("HiSilicon SoC PMU driver");
> 
> This module's not a driver but provides the framework for other HiSilicon uncore PMUs. Should be
> more proper to make this "HiSilicon SoC uncore PMU driver framework".

Thanks for the clarification. I'll update in v2

