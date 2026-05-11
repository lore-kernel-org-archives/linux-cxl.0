Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4FC377567;
	Mon, 11 May 2026 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490784; cv=none; b=SAX6rvl3+PwXMkDTviFfyjXv8pheUnoe9GKW4xojP6L+Mu5FlBkdbnklHBHhGbVt8EdvSuRl+mctcMkMsaXdDsLApOytFC7lMmASmHEavY4WOtysW7wkRpsyLLTCZGXR45vVOuN3VUS0KAIa9LsUVw5TKSxQss7XoBRRE3qVh8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490784; c=relaxed/simple;
	bh=v+NVvuMtu0+rgssi+Nf/wQoj/MpnCEhZR447leF12tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmQ9OrU/UZefRhBxrUMrlM+FkOmiEJOoQZZd3QSWfE7SDGvWIRSFbbK7a0xwSx5IAliyYUOC8lTfVzt16EH9/Ou4sIj2RSa0wJvO1nDgvzhVkPU3mKxaITN7Djf2AJGPYhmvNH4+65eBnUapmkomDnz3Xezw9ZRNLW1TE2jytL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dhd0esCf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dhd0esCf"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B5J9RQ2454484;
	Mon, 11 May 2026 09:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7Zcp0k
	Wb+Anwe2WoWtnjD3EG2vBXgnnNuj3KIcfeAAM=; b=Dhd0esCf1iXuiU/vzkh1iY
	sm9iZRZm5mb83web4eqRkiZES1bqScKUuBM7huhXAaNpyQHmzFsy9pP15mV7c1XA
	yLFU7zv/HoO7sYheoXuqwV+8iM/hFFKVh+nsWLebceVlS4U06QUVIJNIvt8kATp6
	gvFiQf2uTE8GP0NUbQ+PMnDfyZUzwbJYe2T5OFux1SXNAtEXX+st5VQjaBq9iBf2
	1fkCq1HauNrmCRjhCCiB91eJ9v8rhIuTFt+8y+mennvxGj56tioGjE8NQjYcVETF
	F/h0DLBJvYVKeAXUChxFdpnr2d+T478v12kk56HkbZdc5L0hgT4UnAJkDlXaj4mQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ubdq34c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 09:12:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B8sPXF016793;
	Mon, 11 May 2026 09:12:31 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2f8q4pdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 09:12:31 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64B9CUWC33620644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 09:12:30 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E585958067;
	Mon, 11 May 2026 09:12:29 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65B0258065;
	Mon, 11 May 2026 09:12:27 +0000 (GMT)
Received: from [9.123.6.34] (unknown [9.123.6.34])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 09:12:27 +0000 (GMT)
Message-ID: <67f5b175-7a9e-4693-95ce-84d4b42e6b45@linux.ibm.com>
Date: Mon, 11 May 2026 14:42:25 +0530
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory_hotplug: Factor out altmap freeing checks
To: Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: muchun.song@linux.dev, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260511084307.1827127-1-songmuchun@bytedance.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20260511084307.1827127-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BezoFLt2 c=1 sm=1 tr=0 ts=6a019d7f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=968KyxNXAAAA:8 a=VnNF1IyMAAAA:8 a=Uail7pCi9VyjTqRTir0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fdcB4qRrTqLF4DtyW6B9LVSZHJfAxZTf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEwMCBTYWx0ZWRfX2eRwCj+7uMQ5
 v4MWT3UjCyTxnkpX5VQqYC2W6PoVj8rr4nO4raC+au2LCS/78p8LRvXsy4BK9Sdc8H/230Vpclh
 KAnCZ0CVm9NsfgE3+r/amdhaFDcyepqwKORgXidpkRIHcQiyDvoj8xvaXKDtdLAqz87/O/1n3pF
 Yq2HiZSPwcOtya14p4K1r/8qgWsKtHLbm+RpHUVJVPPHFYdHy98eVm0izUj1iIA89F+8sOFObPT
 lDRgAM09w4ZEc+/PrBRMk9EY3jrBn0tJk4jlzwtb+SZViMiRU6L3pG6AGXDbbTHYYNzqkWtFW88
 fZyKrTAnBt8KBmM7E1JaflYz6e13NmJcceRviG6KAI3ZTE7JZQz+I76i/iTxztMARb5oCeWuspC
 tShFtx6ep4nFPs5m+6iO4X8hao4qLdYlPJzW+b6o6joqBgpMOqSw2CBcO4JmtLNdNFwmfYnNgnd
 YAqBu8qeBZ+H+LZ9fKw==
X-Proofpoint-ORIG-GUID: fdcB4qRrTqLF4DtyW6B9LVSZHJfAxZTf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110100


On 5/11/26 2:13 PM, Muchun Song wrote:
> Use a small helper to centralize altmap freeing after verifying that all
> vmemmap pages were released. This keeps the check consistent between the
> normal teardown path and the memory hotplug error paths.
>
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>


looks good to me.

Reviewed-by: Donet Tom <donettom@linux.ibm.com>

-Donet

> ---
>   mm/memory_hotplug.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 462d8dcd636d..af5489f03771 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1403,6 +1403,12 @@ bool mhp_supports_memmap_on_memory(void)
>   }
>   EXPORT_SYMBOL_GPL(mhp_supports_memmap_on_memory);
>   
> +static void altmap_free(struct vmem_altmap *altmap)
> +{
> +	WARN_ONCE(altmap->alloc, "Altmap not fully unmapped");
> +	kfree(altmap);
> +}
> +
>   static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
>   {
>   	unsigned long memblock_size = memory_block_size_bytes();
> @@ -1427,12 +1433,8 @@ static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
>   		put_device(&mem->dev);
>   
>   		remove_memory_block_devices(cur_start, memblock_size);
> -
>   		arch_remove_memory(cur_start, memblock_size, altmap, NULL);
> -
> -		/* Verify that all vmemmap pages have actually been freed. */
> -		WARN(altmap->alloc, "Altmap not fully unmapped");
> -		kfree(altmap);
> +		altmap_free(altmap);
>   	}
>   }
>   
> @@ -1463,7 +1465,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
>   		/* call arch's memory hotadd */
>   		ret = arch_add_memory(nid, cur_start, memblock_size, &params);
>   		if (ret < 0) {
> -			kfree(params.altmap);
> +			altmap_free(params.altmap);
>   			goto out;
>   		}
>   
> @@ -1472,7 +1474,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
>   						  params.altmap, group);
>   		if (ret) {
>   			arch_remove_memory(cur_start, memblock_size, params.altmap, NULL);
> -			kfree(params.altmap);
> +			altmap_free(params.altmap);
>   			goto out;
>   		}
>   	}
>
> base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
