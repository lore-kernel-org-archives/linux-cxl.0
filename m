Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8779382F06;
	Mon, 23 Mar 2026 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774256213; cv=none; b=QC/J4eQLG1D5H5jALCTSBDm3S59yvcZnpvg+54i146c7aWNy+MDBqwYApcd0ZOiN3nn5R1LJ3cRa6cqGHB/IXJrLHjEvpR7QwMpfCFtuepSYPvG6O35f9d1bbXYvm+oCF2+zxbWevvSyC38KXmJ4L2iT2ZQNlE/QPxfmzsgYYco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774256213; c=relaxed/simple;
	bh=xNC49kf2jZxkGM84MWEaRm7mYtl2QWEkY41xfBlq1BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvwxS4MYIue/bJaAnRm98X7rPhz+syWyTt063ICVP2VO3B+eWyZ+hYAVyHOZM+/75rUCf6maqbjCM6Kc+K51NoU2j5PASxNfTaRXXehdtDua2gKdWNnd1CvICyEJMzb2pKyKyRJWxFG8zkU2F+p385RU1adsEE6+ItbO/Y7YXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NZcI0pJK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NZcI0pJK"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MHLUqA4165707;
	Mon, 23 Mar 2026 08:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=M5Y/fE
	RwhKhoqxvdE3p5IKv/NOKxkrVNr6hVFfnSRlk=; b=NZcI0pJKZIUYwuoRFL2Q3t
	XdI4dlGInWbdNY2bNfERUfnfJKcPpExgmkPPK5JDY2kWghLGXdd8EkVFrq/7oPlb
	YacuXBuO9Fj0AVeGr1Lu62r7uP4yHFsADQA9YsU/g7Y72Yb7ONkX3TpJCl0TuEiH
	JuYBAe3dfGvcVM9X47C+RNYbAfqJYuPsybScR1AB9t2acJ2izzPVmQKYs04th2aG
	3zr5TR5CSzEw3oHr97+pEr0xhNkXIau1w0Pm3lLirlpVAjz4TjORsimCmeeLhGrh
	kzCEvqoxzhe2ooZUR5f+A68dKjb7knIXmh/PcDJZLnT1c1n25HFGJ+Tqsc6N/IYw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktunts7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 08:56:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N7El5g009143;
	Mon, 23 Mar 2026 08:56:32 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nncp8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 08:56:32 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62N8uVoR24576618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 08:56:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01C745805A;
	Mon, 23 Mar 2026 08:56:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18E665805D;
	Mon, 23 Mar 2026 08:56:26 +0000 (GMT)
Received: from [9.123.6.34] (unknown [9.123.6.34])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 08:56:25 +0000 (GMT)
Message-ID: <a691d42b-f4a2-4f4a-8284-4dc537c04285@linux.ibm.com>
Date: Mon, 23 Mar 2026 14:26:24 +0530
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/base/memory: fix stale reference to
 memory_block_add_nid()
To: Kexin Sun <kexinsun@smail.nju.edu.cn>, david@kernel.org, osalvador@suse.de,
        gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
        linux-mm@kvack.org, linux-cxl@vger.kernel.org,
        driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr, xutong.ma@inria.fr, yunbolyu@smu.edu.sg,
        ratnadiraw@smu.edu.sg
References: <20260321105704.6093-1-kexinsun@smail.nju.edu.cn>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20260321105704.6093-1-kexinsun@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5NZKWs9zDTObDkwDn80J4vezwIYz0Cye
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c10040 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=w5w-BL6sGUiLeuYIlr0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA2NyBTYWx0ZWRfXxBT29/4Br3da
 ikMUdn8q0h2P873ZZ5X7nR0oFz7zBLO0loA31tXiF7Fz7eBYCOFdKkwgJDoz/HiSa9rmv1Y+GQE
 klXC6lotyNNDXDefKpTQsLWUVrlK0KtbG1mICty1R03UADSg+0lFanB32iLlmlXFIs46k/Mptfu
 hkb/YH0LYLcvpuGONx3PTFuEuE5HMGNYUUERfzaQbCGfhRECQIEUEnPSbDkiG3qI+rxrJwJth3O
 Ldr/8QVvhzfmw7f5pi1mAkISSxv8ItCObXxI76e5h21uYoSgwZkzlDuj39ycbqO1XAWHPd8giHB
 PBYKnRSLhZ2utytpK7oVE4PRQUc8mmaas3/1s/mUWFz8ChhUzEXsPf44fB2ql9PKhoTf5yzM5mC
 Iqu574NDQTz7Ow7TNKjEFdY8fCuqnfKfeZ2l4t38+YBj0RtlaLKxb4Ipd2Ct0GGmG9SlUGmKPEh
 lCstrIdyaA46ct1U6Eg==
X-Proofpoint-GUID: 5NZKWs9zDTObDkwDn80J4vezwIYz0Cye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230067


On 3/21/26 4:27 PM, Kexin Sun wrote:
> The function memory_block_add_nid() was renamed to
> memory_block_add_nid_early() by commit 0a947c14e48c
> ("drivers/base: move memory_block_add_nid() into the
> caller").  Update the stale reference in add_memory_block().
>
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
> ---
>   drivers/base/memory.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index a3091924918b..0d6ccc7cdf05 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -815,7 +815,7 @@ static int add_memory_block(unsigned long block_id, int nid, unsigned long state
>   		/*
>   		 * MEM_ONLINE at this point implies early memory. With NUMA,
>   		 * we'll determine the zone when setting the node id via
> -		 * memory_block_add_nid(). Memory hotplug updated the zone
> +		 * memory_block_add_nid_early(). Memory hotplug updated the zone
>   		 * manually when memory onlining/offlining succeeds.
>   		 */
>   		mem->zone = early_node_zone_for_memory_block(mem, NUMA_NO_NODE);


LGTM

Reviewed by: Donet Tom <donettom@linux.ibm.com>


