Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795412787;
	b=TqMboEFGvXdoXl9z9X101jXewPzVSDLx8upcyTE5jge/1yHrxXHSKdAIoAmcO+itB1AM
	 lNU5Pow/RjZmBzcX4+r0ljZiR0VHPeTjj7+Pp4y0tERmmhoPYljilkAHVFtuT/Qn4P+O0
	 qUxl8owq9vPQPucOCnNFDcO+IAwtTQRErNKIlLsKgzRkHNHtnOZ5AFvzFXSoRFaKFu4vn
	 b8rYO2mBvtEjxD2lko6iHxYrEDMNMzsYtWLT/6qtmcmNuCG7/6uPd8bilJZ46SYr3de/d
	 kKnNLSSllO82D+JR73Mbsg3gdb+jJ0vhd3iGrA5izoI98ZVgtlj+oKN7mQyzORJNqCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795412787;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WDdOZbAef0VZJUq8GHeZZN1Befvz7h+o1H703vna+VE=;
	b=kHlnkbp9UXO3fLf2eK/fA8FhdZKkZIq9MGcVRxykZ1sfaqK99pz/qQOGSik8Wp6fY/0Q
	 2RXZa9TJ0uvZH6xwoSH9+06CW9O+VSNj8IK56HBZ9HMjn1dVTrB0Una0IoUelhNTTEI3O
	 VPhdLH9/xbaWEAf/9X8bb7FTNGa2Q98ezA68LzPrdqhPUjebOCKtBizNFvADt7JFKK8IC
	 YS98dEDdPzb+kKI9LJc1dhp0oOcU5k8k4uJh+CZ2iqTAl33Yo4qLUVhKgBHdVLzj2O4Jn
	 aVekXq+kh8tWQX7ZeSfDc+q8cxe/KYaZM4cAq+Vt9Y1vub6cGeL6+6izvNec5krRnXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=eyBQmLoc;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=iY5Le221;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB857606A31E
	for <linux-cxl@vger.kernel.org>; Mon, 23 Nov 2026 05:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB857606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=eyBQmLoc;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=iY5Le221
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN3XUwT1206266
	for <linux-cxl@vger.kernel.org>; Mon, 23 Nov 2026 00:46:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=WDdO
	ZbAef0VZJUq8GHeZZN1Befvz7h+o1H703vna+VE=; b=eyBQmLocBEnxAn3RL7SN
	cxpvSnKSDfx4CShgBEFehjOQkpPAto2AqDp1fZc3OV6rEchZANMo3ed39PVKMCuQ
	rlIaSuz6+KHv2xwQSPeGMJCwwzyGmyteNde7PYNE4qOcfLkq8m7RQf4df9WqNU5S
	OGu4TKiVPPLMEYcukEciniTiC0A2W99NS0wwhyL6s/q9LBLCoFhEJDjH1OLYebJQ
	s40EfeUkrq4RYceMa4Sk+5kmmowqEer1xw2BkHWOB2dGL1BPh5AACK7oW06otfwy
	h7uu2lNzh6gdYQz1I/9lNZsD9mOjkRcIBpzSURKurTJk5wK2lumfS8J2jFrUz4nf
	0Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j42cx3a8t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Mon, 23 Nov 2026 00:46:19 -0500 (EST)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-9213659143bso59009486d6.0
        for <linux-cxl@vger.kernel.org>; Sun, 22 Nov 2026 21:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795412778; x=1796017578; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WDdOZbAef0VZJUq8GHeZZN1Befvz7h+o1H703vna+VE=;
        b=iY5Le221neFbE3zr5ARx+0f1B8tbd8Q1gPbGPei3hF+X4oLEENJjEZtIZRTjY5UuQS
         aQykmgvUNHDc9mhC+YlPdytgTm4wQQlDOa1Zzwu6gr5+vdihGK9bqwvNW/TbinvnM5Rj
         xXyACtSh2oVFn0rwGSO4luDQsDw5M4JgfK74EoQxLeKtICr8eRhu2uMO/cZCRvTxPm8c
         /wq8OfinG7ofM80QY3mUrf3zpD2f3TLbERi3Eyz+Xka7Z4MtMJ05iyovkeHskb/unl07
         Xvk2gXCwu5VHYZDf/2rVFxgTMMTRNYCvrATFpjyB3pvltkROK+HcarIuuXnKgfumTvNZ
         qMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795412778; x=1796017578;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WDdOZbAef0VZJUq8GHeZZN1Befvz7h+o1H703vna+VE=;
        b=rP228C7lhDJt2ZugFJ6aJHCYvzYLh5+0IlaTCMgOC2YRoG0qhPnxevek3dWjWT0LxN
         5JWbsigNSrkxhyka37PnvBqvrjOufSNqH4riv+N3anXKSUobHiE+2Lda5tQmlBQsc5+P
         wc9V7qLyghmQtIKa+sQ/vQB28wJPUmee0/u6rnSC345F57v7ROQwIFD4jzKYJ31XXLvj
         f4X3SC+X1HKtpFQ0e3SFlPCpLPivsJLEK0h/hiGQYlbqOrgL9uJ+SqXCN3Ces2RH4tv/
         UBl8d4Sb42M2in7ym+whrB9yVKK333u8NXuySAM5kQpSvvDmwAYzVYJGpwBY9mnoqWMC
         /Ftg==
X-Forwarded-Encrypted: i=1; AL+hErF4+zIn7wTVuE52DAqp75sLUeTCFgbbF01tzsnbZjZajg94eVHuzI1PKhDS8pOMBArtkk1mu+2yZ4Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BrCVqEiuqRrrJWAbyK9IgQRoaG3YCUaNSY+U0TEB2cH/MZw28
	KYchP35sOaE+/p8qcHPx4JSqtGMXc7l+2Sa2tQQenUqtEvnO9L/gQwXLTmON/G5NHn9fyZFD6Yr
	UEqB7oGKvfIALQEmw602Ia6Cf5ppf8JG+qegzgfeue6kGPAJzNPimDFsANQ==
X-Gm-Gg: AZFdTZdcs37Lu8KsA7ngiSG72eyPokVSNIxxsFXcQ/y6t5lYj975gHQVa8rxY2+CMrq
	UUxQSawjSdKV8J3JtCFJAHbTvbQ5kg2V/u3XQbiiGK4mT+JUd/HPFmYDBZ4DzZGuoxDQZ3gwUoE
	JyYAUAZ9NP/w2PG5BEt+rKwDNFgfjHgL+bcDtoAks0aq7zN8hzT03YkcMnZVOPEyt6QA8sXfV3y
	+MlZdKW97EDHpGE5WyuiSqmy0PC9YIILc3LA03svSGlM7TyPDzA/YGUDSarKI6FtBdwP7S6uNcT
	aAItaCH4iTe3yK6a7m85McFh7NElz8uFCnfMTIScNBtyRykS0sBobpLJrhbtKUrxZcsIADljOAu
	CX+sXoz07buZEPONiL4x+sW9X7uS1C2QWMYeHnlbimxekidjD8F88e+wCn140cl6XhUgOjeJroo
	/hn6AgrGYTeQg1l98tKV5J8XHWB9Za4I7cqfDRKcxUL72pYxcjUnC4GM7JKG4PTTvH4QS9oHeQL
	dzCAZatWKCfVog37hpcHZn/3QD/bq9hJmeTk0eMtttjxNeMuWJU7b6SbKKmZLrwdSqlM8O6Db8M
	NMXiiX2ZrSVQoMxF829H5ZU=
X-Received: by 2002:ad4:5dcc:0:b0:91e:76a7:187 with SMTP id 6a1803df08f44-92134a9e8bcmr183190056d6.43.1795412778490;
        Sun, 22 Nov 2026 21:46:18 -0800 (PST)
X-Received: by 2002:ad4:5dcc:0:b0:91e:76a7:187 with SMTP id 6a1803df08f44-92134a9e8bcmr183189906d6.43.1795412778183;
        Sun, 22 Nov 2026 21:46:18 -0800 (PST)
Received: from [192.168.0.76] (dyn-160-39-51-212.dyn.columbia.edu. [160.39.51.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a0a454sm95684796d6.35.2026.11.22.21.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 21:46:17 -0800 (PST)
Message-ID: <2e11ba52-b5c6-463e-a5ea-c165ba935704@columbia.edu>
Date: Mon, 23 Nov 2026 00:46:16 -0500
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memory_hotplug: don't offline a hwpoisoned page
 still in the page cache
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Vlastimil Babka <vbabka@kernel.org>, Gregory Price <gourry@gourry.net>,
        linux-mm@kvack.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, tz2294@columbia.edu,
        stable@vger.kernel.org
References: <20261105-memhp-hwpoison-pagecache-v2-1-029d35634d42@columbia.edu>
 <d4812513-6cfb-4865-8636-b83dd92c23a0@kernel.org>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <d4812513-6cfb-4865-8636-b83dd92c23a0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyMiBTYWx0ZWRfX7Vc5zjsvLhmd
 2tpq61tqeR6qyPOGJb5/xZF8/LRM6vADz6sndmt2jG+Hvu9jwxKHK1sumbx8VKxvx4ebh+W36DY
 Err7fVWFnhCWI1MFt6aLGmed+je0lzqh8BDO9r7cvl5IHN3uaZb6
X-Proofpoint-GUID: td0ef_2Wz0NUIaZJcX1ckDIlHW6Asvb7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyMiBTYWx0ZWRfX6KqzvkXf5eNu
 XfeiMNGz9zZsfsUm/FmHKmH0l6NObOeJTKWC4qKZEfRL2fV+OtgnOZyQnKYNVYp/zps3HOWO/Xq
 VTnF7BUss9sE1MIYc/b71iglftJd9V8JCPR7H+QQyqu/1UowqH8DkczPq38FcJR6JRbf5lVwWa3
 zItZvTXLoNUM7885D2/AaJ1VQPNS2kszrPuQ4nDqxKsjMUjB9YvVz1qOAXzhgJOQk8dxs5x3ETH
 IlWSbe6sodtGLwAekxntnLujU0aOdUA4Wb6R6UmrZIrFWo1UOvUBhDP9ppfij5M94yIv/kF/7m3
 QLfRKuhPXQHNoHiQLfWddve2uAoBip4Dcd359UgmX2vi1hBZfWFB1du6kf+tBZs3cdmZug2P55s
 nY51UrTMiAsCu3AmPrCqzSB0/zkIvvUA34AfkhqnHPi/0nBzyhDPaM6OMS0pIXgpI6miZLNDuev
 6dPJh5LRQe50nTdNf2A==
X-Proofpoint-ORIG-GUID: td0ef_2Wz0NUIaZJcX1ckDIlHW6Asvb7
X-Authority-Analysis: v=2.4 cv=GNOdgeNK c=1 sm=1 tr=0 ts=6b03d32b cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=l9izRfKDRJJ6Wn/vzKnQSA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=CtMvlx9HVXp8zQbR6KoA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11974
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=10 priorityscore=1501 lowpriorityscore=10
 bulkscore=10 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230022



On 11/6/26 3:58 PM, David Hildenbrand (Arm) wrote:
> I didn't understand why just checking for the refcount is not sufficient. Can
> you elaborate once more (and please not send a new revision before the
> discussion is over).
> 
> Memory poisoning must grab a reference when setting the folio hwpoison. Any
> other reference (pin, pagecache, swapcache, mapping) keeps it alive.
> 
> Why can't we build on and?


Right, but memory_failure() doesn't always hold that reference. It i)
sets the flag before get_hwpoison_page() grabs it, which waits on
pcp_batch_high_lock that offline_pages() holds, and ii) gives up with 
the flag set and no reference when get_hwpoison_page() fails (e.g.,
a pagecache folio briefly off the LRU). In both cases the pagecache
holds the only reference, so offline can't tell it apart from a
page memory_failure() already handled.

So I think if we move zone_pcp_disable() in memory_failure() before
setting the flag and keep the reference when it gives up, offline could
simply treat any poisoned page with refcount > 1 as busy. That'd cover
pins too. What do you think?

Mani

