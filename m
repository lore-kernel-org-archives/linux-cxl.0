Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6917DA73
	for <linux-cxl@vger.kernel.org>; Wed, 26 Feb 2025 06:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740549763; cv=none; b=X5qx50y0j36V3xKGlWWk64i0RxX2qHg4PCATwpZ3d00qDWTdQLSUDmmzkJTWdw61naQQaZTvOZz2gSNAPwqfHCeJ66mEKebzEb6vivoZ4Y2QWPbGMxAikRSmr3piwAw6bAynHkIwM/K/UscuB7TmM/sVdu/K1N2JLeLyM1s/idk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740549763; c=relaxed/simple;
	bh=0vSZLN1xAFTeTPcNqNaIEkQDF+HMRLl5Sem1JqP5x6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1Cl9m9LVnTt76CH/Nx5umIITdp2gNBxJqvn6ABlTmyvOKmghv00R3s2wQfAYW6QxLanO/1azXtIAE/YJw21Yf1floaZxomh+4tofqVFLQOWFoZdo4C7KGP6zZr/JChCZRppGvIVWFgGGPfvSq9gcwO/oz4lm4ThZwbAM21ngEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bSxpub5+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bSxpub5+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q20lht008286;
	Wed, 26 Feb 2025 06:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/XwG5t
	3c0sHqWA3P32R3VCVp7uwlMTYSfa14+OGDOnw=; b=bSxpub5+CGp/4w4bSKQ/pY
	pTPt2jllAnS+f5vPCexthJoCmwDKPFSfgJLKzzegJsvSIFaoKeiaUE9gpcHS2bo3
	dkqri6mTQqu92qQUOFgRbmbaj2QPWGn1g4CXc0K86tx8zkxK+r0/A743mgSqe8mi
	pm+MchmhMdTdbeFcU8GFGn2ejWnALanaFRgR8d12Pqc+wlVFD/K5ae74PwmVocuU
	Ib2pF7vkDYDJVzAMoZZrzb+HJ5u4cweSYcNJPhHyR0iLpFahBAf2nf0mUwx+n8Zn
	5mgI3dX1Qqc0xcMlUdqDxQ95ZXmZpOeGjFzXT3bJpWejGwiYwc0VsRns+p4T1WFA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451ssygsxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 06:02:35 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51Q5vDwm016890;
	Wed, 26 Feb 2025 06:02:35 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451ssygsxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 06:02:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q3N72r012597;
	Wed, 26 Feb 2025 06:02:34 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9yh9rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 06:02:34 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51Q62X92131660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 06:02:33 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2760E58051;
	Wed, 26 Feb 2025 06:02:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8C765805C;
	Wed, 26 Feb 2025 06:02:31 +0000 (GMT)
Received: from [9.39.28.177] (unknown [9.39.28.177])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 06:02:31 +0000 (GMT)
Message-ID: <6f43cf6e-a3b7-4746-be15-d354cc6dd699@linux.ibm.com>
Date: Wed, 26 Feb 2025 11:32:30 +0530
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [ndctl PATCH v2] ndctl/list: display region caps for any
 of BTT, PFN, DAX
To: Jeff Moyer <jmoyer@redhat.com>, Donet Tom <donettom@linux.vnet.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>
References: <20250220062029.9789-1-donettom@linux.vnet.ibm.com>
 <x49y0y0oi1g.fsf@segfault.usersys.redhat.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <x49y0y0oi1g.fsf@segfault.usersys.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3Hj82jVJF4sI3N63UY12VnCY6vfaa-8r
X-Proofpoint-GUID: LS-k3mkHuPWpM8o0rafpFVNj88VthKmV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260046


On 2/20/25 19:05, Jeff Moyer wrote:
>> diff --git a/ndctl/json.c b/ndctl/json.c
>> index 23bad7f..7646882 100644
>> --- a/ndctl/json.c
>> +++ b/ndctl/json.c
>> @@ -381,7 +381,7 @@ struct json_object *util_region_capabilities_to_json(struct ndctl_region *region
>>   	struct ndctl_pfn *pfn = ndctl_region_get_pfn_seed(region);
>>   	struct ndctl_dax *dax = ndctl_region_get_dax_seed(region);
>>   
>> -	if (!btt || !pfn || !dax)
>> +	if (!btt && !pfn && !dax)
>>   		return NULL;
>>   
>>   	jcaps = json_object_new_array();
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
>
Thanks Jeff


Hi Alison

Should I send a v3 with Reviewed-by tag or will you take the patch with 
the tag?

Thanks
Donet

>
