Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735946;
	b=ztAna/GVM7XgOBq66YLal2GM7ATOIYaiYyIcsGE1s+KD/YmdKMFIthK8mPs0Aa09lwZZ
	 7AxJlyNRAx7sSJJ5jr31zT6+UaMIG7UHK1V9Oh2/tIYqGBNWs/40HXIWTh+9cIB0dHWoz
	 8+DOQeew3TZHg1FqVSUG0RJBMwXYNg4gXQAYVmx+cdXg3r0Br6ANOtKLP8dhnYbrybWBT
	 5Fv6YIbvQfJbKO4NiL2o6Z4gtuVa82DxsIyRAObD6joBhUxI9iuk81VHKM7vj10sHiTHN
	 nfpVtw3jI9/bZDHVjyJG9eY28p4LAoHmS4exRrFifdmsWUJgge6hZbK5zbZ0pdktQUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735946;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=xpOJgsJz0sB9K9v/xEpka5H4yAVwg4X0Reyl3yXA6Do=;
	b=iJufHhFBsS4/MjZt5fkouFnm3OZS25rCeUIdvqYjqLFAj+aiKT7/kBXsL4dp6LxVsDXN
	 DUhKDq8KzrTB03AJRj+71yPRzS6UTMvAI783rzwMY3EXsVD7dGvPNb5FXMI2mEbQ9zg73
	 tg8r710rafKvP5CY9wmrDDARRwee2XJQMJ/IRQAdLHnL+M3TEcI1KX/bp70L7c9Z2zkfJ
	 fcDkJS0Q66aqwHW6U++iGZLWdwaNfqc1yAQ5sM+bCLdcEjbHsA5VW9QPJHGdavAoQTfWO
	 hGt4DGUto7RY6HnskOfziLXArHwOReMoZ0f+dZot1JyFRRJIuKwUEIRxwlO/EKN3iAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=FXwGhxDE;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=GaQODNnC;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36BF606A329
	for <linux-cxl@vger.kernel.org>; Tue,  3 Nov 2026 19:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C36BF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=FXwGhxDE;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=GaQODNnC
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3HYpZS1061719
	for <linux-cxl@vger.kernel.org>; Tue, 3 Nov 2026 14:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=xpOJ
	gsJz0sB9K9v/xEpka5H4yAVwg4X0Reyl3yXA6Do=; b=FXwGhxDEyiYhfsw+MEKc
	iO0eBRAzcshzu7iioSTg0l4c/nSPG+/zQx8xhKoqHzoxaS/xYHaWqQyNCBePASkp
	cJlVaVT7G9ZeiWlELtAN6O245MoqLDujnT4Jcz8wscpAP9RqI783TDLEhRf4Jyj4
	gbOQPQmMARPk7y6ytdo9OoIhnD0kTrjSAYs/uio5hAxfXmehy/LbjJFA1teyeQSw
	88mjVAEfgt/vw905KGKiSzeLnQYg3s0X9LpfJiYDGaSBtqzY/iHCcFMePyi3VEmk
	azNZEYGsHqT8NXwYiuZEHSrMwnTAczP3IO5Z9MY5nqKvsVVUBYfMfDhurMMbpK2B
	gA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hq52m5uuf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Tue, 03 Nov 2026 14:59:04 -0500 (EST)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93e49a1d3b1so825385a.2
        for <linux-cxl@vger.kernel.org>; Tue, 03 Nov 2026 11:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793735944; x=1794340744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xpOJgsJz0sB9K9v/xEpka5H4yAVwg4X0Reyl3yXA6Do=;
        b=GaQODNnCTY0xX476g3KSgDPSnWSn6yB06/CS7MdbnsVgaGgZ3uGMseiDqwU4nIWj+P
         LWEOGKTO6VVhHqmKRCtpf0EHh8DU0hqtxFC+ZOApIsAzwkSE3jkfllsPOL6BZ1sKfGRh
         x9vIYvM2MD/oS8Tc5IwdsGHExElcWBCPqeojOtrIBkk3YrPj6dH0wmbi1tsygjeI8Zep
         L3ooHLjUgTbzq7l7ALg7V/lv2LRbqRaUSUhM0v3zCQXCN0VYcuG3F6S5+WOQBqt0qe11
         NGtBkaFUmaZuwHjdV+uP849NMhabki+EzDsGoMJTqWyI1CHmcHcR+bHCcPcLEyKiMWfe
         ZJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793735944; x=1794340744;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xpOJgsJz0sB9K9v/xEpka5H4yAVwg4X0Reyl3yXA6Do=;
        b=W0ecNXEbArVIdEYj8J/y+m3sBdBi6scGIOVvpRJgsDdNQ7vpTERq4Oj6y3rVYpQMOw
         qFfaT93oYqyQgKrv1hXnIjjEVgkqR9LdCHW67f3BU/Qeq7u2RHBGP9N9nP8ORRtCEP5h
         +GV1vL0IuNDDYKGz4Lc8nnfS4xVrcvpa5qmtMYXT8pAapULwIPQ11fjBU3gN1hyuuBzX
         8pREH8Tk9d9BFT+6Hasvfqz9OhtarfmtEMgwQOn0kGoT4cQr3wzhn1ltglCtIYR1prt1
         5JZsO77Ys5JLckLQ4154Rky035zYAlUwSzYSC3AhWBwtmuCuBaC1DAE5B2NpLqVJpJh3
         3nqQ==
X-Forwarded-Encrypted: i=1; AKwUvByhu9UAyfNKjGyFXcFe/Z8SezD8FhiWuC2MVO7S97Wj1RicdEbqC3zau7dq11joDwgLuo1X2EvYdtY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cCMzXNzvSzzDCogYacg+3kC+Ont24g4Jz9GNOdXxMoRDIt/Pd
	O4pHcIH8w/5xbukY2wAWzg9VBPUpuRRjo3awYcUrNNiEDs1ERqqF73h/DWuKKAvkeTuXrQr/+22
	CHNJShBxg7U8LqmHvXIKil/foOgvlLgU9ZmHC0HxCXGX6OFgvhbhuwI3xRA==
X-Gm-Gg: AYBFou31VncyS/3jWBJDKmXwJKf5Fp94wQEGOgBLHn+PoG+zFrB98jaIzramdFm5InM
	jlKtiDllKHe19ZlGaD2GzeSJcusDJlNgTCD7KPAKpEZpcPsD+XDEaTuai/yDM55U6ZaCsOSmsRn
	ZJvaY502MjqiWCIAAjKU8y1SecB2r2LM6WIsPCA5dt3On8obUaSEkiEBx9ykMpAEj8I5QS2V6p8
	sr+b/cdigEMYDYXB/CPIu+oHeTfsdx1Zq7jgORR70Sg7XSN3XTKnzBqf9zSsP+VlI10Jhqexz6O
	rcnnRH0xUWOgssmbZi0O5zsg4LWejYscRUifUKyGYXoODnnetnfIImECsgU+8lxzWCOBxJwd1LF
	OUG+IX8Z6MU3NFYFEJTjLEMlNonbHO+PhMkwu2MVuzbJnAk0BpTnmWaAWmi2h32fkF9C9OYhVwr
	MOCkmaxIMPpdXykAh6PqvSNAs/z92nUmzDlFCUWMFd7mlKy3HTW/camBDwddlBs0fHBHFlGFYpG
	Vfu87D+9+ZhfppkAvMh8UZEQUP9FSoABV5ZzI3JYHtR9Dr6Gz6xzXTDyBLSNO+A
X-Received: by 2002:a05:620a:2909:b0:93f:61a6:b89 with SMTP id af79cd13be357-94421588cd4mr2307140585a.7.1793735943854;
        Tue, 03 Nov 2026 11:59:03 -0800 (PST)
X-Received: by 2002:a05:620a:2909:b0:93f:61a6:b89 with SMTP id af79cd13be357-94421588cd4mr2307138385a.7.1793735943552;
        Tue, 03 Nov 2026 11:59:03 -0800 (PST)
Received: from [10.206.225.113] ([129.236.228.41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4799adcsm15298185a.13.2026.11.03.11.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 11:59:03 -0800 (PST)
Message-ID: <a002901b-715a-4adc-bdcb-7a6fcda67711@columbia.edu>
Date: Tue, 3 Nov 2026 14:59:02 -0500
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
Subject: Re: [PATCH] mm/memory_hotplug: don't offline a hwpoisoned page still
 in the page cache
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Vlastimil Babka <vbabka@kernel.org>, Gregory Price <gourry@gourry.net>,
        linux-mm@kvack.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, tz2294@columbia.edu,
        stable@vger.kernel.org
References: <20261101-memhp-hwpoison-pagecache-v1-1-ed8785ca44eb@columbia.edu>
 <1b6a6d13-8a01-414b-9bbe-cd194af1f539@kernel.org>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <1b6a6d13-8a01-414b-9bbe-cd194af1f539@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7WYWJsTS8sd3MEXsF8OSsmhGlL8VKVdG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA3OSBTYWx0ZWRfX2Bn8ZeLrN+qF
 ZscM4D0sdxEzx05DODNdnhvHbNh1FKeEyojGBkuhEmBz5DQVnsyV0AbI4ZCwJoGFYXOk0X9nYyf
 Z76A/CaB+uthTKK70wgTR+QyKT7woYH/SG4YdF3xt7VPHCnMMueC
X-Authority-Analysis: v=2.4 cv=YO4KWhGx c=1 sm=1 tr=0 ts=6aea3d08 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=hEunIlkDQR9riCPXO4CBGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=qOjK20r3ws_Z4Kvo5k4A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 7WYWJsTS8sd3MEXsF8OSsmhGlL8VKVdG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA3OSBTYWx0ZWRfX47YVg2PQbaHt
 J+VaJ7ebNDm8s+cm2R5kUvcnIT//fTJV6c88diwWYJP0/quMoWm/+HT6anLZOQYJNcTEOmoq2rK
 tLrMBRFjRVXX4UsqoniA6lMa8UBAdENzA63U6XqhxEeW08ILDDqyJOHh7ASIWwcMRuwRABe5PTI
 p7XFuUQGwB12N8Ras9SrzfQBoha7+lHriNfp3SmaI85Ny5ijkKA4he7pWhI4LJog6CVJ4FVuwVQ
 9wncPwBeoNt2Me+OS5oo06tRJuzCzd8U2/l0Vqw+1sMUh1T5zV+bcCBWRy1GVtlwDuXWI+kkRJv
 dwqTWIqdtdMwIdP/7jvaRnfA3Oa5K4Pogu+wNLwYTkfeDosvSjXq9zWcg0Td4YmvVelxoTgbdtk
 qfS11lvvxGL2GiR6mu1Mf28QEL/xiYPi/sCmVcb4pOF+jd2jAb4E208SO5F4o+O+AxIv9PXevXC
 8yTa1kTxqux6XZwMUrg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11955
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 lowpriorityscore=10 phishscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0 bulkscore=10
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030079

On 11/2/26 1:56 AM, David Hildenbrand (Arm) wrote:
> 
> What if we still have the page pinned somehow? (vmscplice etc).
> 
> Wouldn't it be better to make sure that poisoning code holds exactly one
> reference (whoever set hwpoison) and check here that the refcount is 1 ?
> 
> Pagecache references would turn it > 1.


Yes right, a pin isn't covered (neither before nor with this patch).

I don't think refcount == 1 can replace the mapping check though. In the
race from the changelog memory_failure() has set PG_hwpoison but is 
still waiting in get_hwpoison_page(), so it doesn't hold its reference 
yet, and a clean page-cache folio then has just the one reference from 
the page cache. memory_failure() also doesn't take a reference on the 
kernel pages it ignores, and a poisoned page that gets freed later sits 
at 0.

So I'd keep the mapping check and add "refcount <= 1" on top as a
follow-up, since that also needs do_migrate_range() to drop the 
reference it takes when it takes a poisoned folio off the LRU. Does that 
sound good?

I'll send a v2 soon with a small do_migrate_range() change from the 
bot's review.

Mani
