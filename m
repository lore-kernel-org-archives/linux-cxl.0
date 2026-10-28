Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146460;
	b=I9pMzlL3cevxBxZPU0x01cuShvowhLt4uO1iygPvS6Ut1MQNghTz99uBmHN/HL2MvgWW
	 B4HO2m/BLD2mGIRwYD7dX+S1Y/eSpHSpAAZYqgi0KOxYBZi/usvQpnG1Qug8YhsmWU8PO
	 EwneX5YxtWvcXquPwWvtnXVkOTkpDCR5kPCg2umCt07KtAkKEkvti3KEePB1TqifuG/9X
	 tKYyjnphleAa0H/PpTlzmaahslTDhvGas49saGK2NIWXMh2Zz27cLfURx3BHzvSezduSE
	 C7mkTv/ID2nhTFvd7HvcUz3H2FVwr/M5H0Cbxcoje2eK+1UV525KCkPS8tRISK1zrcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146460;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7p1ucq/Ny8UBz6ghlqYuLhKrCHyG8ylaL7otql1jOZ8=;
	b=zXQSuo4wLZc6iyoECxxNr/64PNQTtldlwTW8LmJmMOTgcjADjn7rRq5svoyIXuirVVuF
	 zyPoXgZ3iytknVKfQhXmIANLT1prulTmhwrnJVXCQCGI6vYj+lTz7jhFsn4xJuij2i0Hz
	 q0ts5Q7NVD11ljQktcNzpZBNW5WRz6Adob8tt+XLQwFp2wEg5IK+1gkoeVakE7qslRQ3i
	 IHzmKAkckth0hk1CL10wj1jQXKDj2NmtIYxkHbGQiCIssfodgX8luC2t9Eak/+6h/e8sf
	 ECE0jikDHP03fjqmloMxuozxUH7SKhn6yIubTY9RcX/sLV/rwbBbZrlFIvcuqZo4tNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=lsovCs6I;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=Q4NLyjW1;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE56F606A31D
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 00:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE56F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=lsovCs6I;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=Q4NLyjW1
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RIuxwt479834
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 20:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=7p1u
	cq/Ny8UBz6ghlqYuLhKrCHyG8ylaL7otql1jOZ8=; b=lsovCs6IxaWMyufeHyab
	UGnNVfqeJNBrnilLDH1hmBBzIDO1Xw2PYSUP6AO5lBNUxpxEQbs+32FmrWqXgs2U
	tOPH30t80MNHG2qpSiuiuflnpzM+Fl8MrVaIQ/TzOQwsV3+8EA9G3C0UHn/qCG3Q
	PQj237pzIWWLwXlIO/8itmTx5LzX4mvdorMSSEhTUlDiVt+iAvZg3DPutnck/E72
	SD4t4EgnBW4hfXCWuhw5rDgUQrr386PNS4Nzie4yCvvMNEyT2eeHSzgksDyKzRBz
	69BiiAg+4Y9BSAZh6oP9aUSXMEnXOkAGEduwN+78Gc0cdd8YkiEvb2dw4F4cmelV
	dQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hjxk9mh09-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 20:14:12 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91c7b175e38so10019036d6.3
        for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 17:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793146451; x=1793751251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7p1ucq/Ny8UBz6ghlqYuLhKrCHyG8ylaL7otql1jOZ8=;
        b=Q4NLyjW19/i3ait1GGvuGUivPbsqagcGPGP+qWcDf7njdgRSJuYGwHwfXBRn6+WApZ
         u2dU/OtMje0X9b8UevuOY8/zp+xcTBSlA+AQPyXfpQIFvqXQkrx7HvxUuLeKu1xIjmOz
         kiBinAtDG9/rbdMBTxkVC2eZ+5y6Lcu8Hj86h5xFKIuiV8Oo+uj+Ulbj4qOr85BrMbkh
         EyxD2Q8Thz/bitPJU4cocw8Ol6X7hbw2JlkPyQ66x5sGjM+qvJmR/qMkUXyApTT34u/s
         sZcQJdUwxGiWQoZpZVBv/TUZjOGT3aT0Y0GxHW03AK0xQsXqWosKF43hPhwNOMY3TfSO
         p3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793146451; x=1793751251;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7p1ucq/Ny8UBz6ghlqYuLhKrCHyG8ylaL7otql1jOZ8=;
        b=vNfid7beIN4e4kzV1SURLQRtbdMap9z9xb2aeK/YIWMOFCL6UE8aS3XDulYoiBkAGK
         FXBFdHJsF7ISIci582CwFAo8+hlF5f1+FBtPBioux4g2YwE2KniZY4y7PYkxj7Qlk03h
         B3iEuSs9Zd3hIB/fjTGvKxbK4lcv1NOkUPD5Fg/nf+nuJekdoqCkQ//s24pH2GujWP44
         I+eAcz0DZMAFZoWX+ktxtl6Suu0NP7tyItb42IyBKB/vF5vkSL5aH3NrWB/oxnXOScM0
         F3VbUtmo82/uxYcHy5zaTPD8S7OU5D/17HI55i7rj2gaxxPK41q6/+adMo9DvMTkfZvb
         4pOg==
X-Forwarded-Encrypted: i=1; AKwUvBwY82Akw9guSVTlBveEmm3MtYFtfy0Hb/YDGJaC+EK3jlWCR8K6dQQ9w8duoCsgRtc4PagrQ2HvoyY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4s8glxK5e5zsn8FztbCIW9ofXF7MlqqDHIh8T+NkCuxp7ZF1h
	PdmzAToSG8iefNvWg2lg2MEjWePyxzJF+gGmupM4KzGnTtajx9fr8+VNVy+JCYz5rNGgWu88LNU
	aO2ynxTrILwM4oWoD1wXUToMG2mc/HkBNtcDt4o9jsVxALVIQP3XEcA5Hlw==
X-Gm-Gg: AYBFou2RLUu9AchCAAoa89ESl6RPRIC+s4GPSn+ZO1pbTftHzzUQcB8NAJUmeuvxEY8
	qIqwXq96TR38q6FvBT8GW3omPb28Z11tahBNCMHf2956rk8/0xh9dC0RrZmxNqv9r/WWWF0kgSd
	ouKL6uHPs/vePbDbWSm95XNWlbSrrZ4aFJBJIzwa+T4vpcIU/t3zY558HTlFmP3zBHYk5++JEqx
	sqm1/WWfd6qsZTOWFqc9v58B1CAGHPyJJgoIO2HX80e4LUyHD23qB1i/ZL7AVhTGWa2yjv3fk4n
	pMm/Yc8nGIUeGSZi3t8NqoIcQ9yYGl9tHNOfn2UZCG7s89qecFT+GJV4IgEKEtAVwFKExwKgErT
	qgaWFbdj0MZArF8keWJ3nYEJ5fsM75/XZ2XfXC/UMUnnSA4DCWqT3cXazOSA7+DoWT29Hr8oFMP
	mtiEGcrGIozPTafzgPDKqlcxNsFUXkFvz/aP1k2k08oV5KRl0fTJHFcGvvIseVLF3v91alnUoda
	CNTbdVfJdJofm0PiZvlNk8HAUV0SmJsNpXzb3JHTQ/Jf2NLfeOYFitmLgoFFOJ5
X-Received: by 2002:a05:6214:21e7:b0:91c:76aa:2c67 with SMTP id 6a1803df08f44-91c7d1aaecbmr12070276d6.39.1793146451387;
        Tue, 27 Oct 2026 17:14:11 -0700 (PDT)
X-Received: by 2002:a05:6214:21e7:b0:91c:76aa:2c67 with SMTP id 6a1803df08f44-91c7d1aaecbmr12069876d6.39.1793146450883;
        Tue, 27 Oct 2026 17:14:10 -0700 (PDT)
Received: from [10.206.51.58] ([129.236.225.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c6d8103b1sm40645156d6.44.2026.10.27.17.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 17:14:09 -0700 (PDT)
Message-ID: <3c754c36-86de-44a6-ab3f-5c86e4bf83a6@columbia.edu>
Date: Tue, 27 Oct 2026 20:14:07 -0400
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
Subject: Re: [PATCH 10/46] mm/huge_memory: fix list corruption when
 deferred_split_scan() races with deferred_split_folio()
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
        Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
        Barry Song <baohua@kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Baoquan He <baoquan.he@linux.dev>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry@kernel.org>, Alistair Popple <apopple@nvidia.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>,
        Matthew Brost <matthew.brost@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Nick Piggin
 <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
        Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
        Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
        Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>,
        Gregory Price <gourry@gourry.net>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAwMCBTYWx0ZWRfX2fkea6EAf6o4
 yRKvuqOjZozbifQywKCj3v24m+8HHMDzD9r+XlSzJhMYydwrxN8dEtMrPOyDC/XJq1QySkJ4MKC
 ZF8Z5VS9uHaYuO9mKMD7IdF4NCi2MBgdTiDumtq3YzT/QsArUp/Y
X-Proofpoint-GUID: MZa1b_qPzY6tUP5xL168cS_GaoIvtlFF
X-Authority-Analysis: v=2.4 cv=SowFe/O0 c=1 sm=1 tr=0 ts=6ae13e54 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=TdXXog4ttPu8yHJGq4T0ug==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=VwQbUJbxAAAA:8 a=maIFttP_AAAA:8 a=_zromwrzjHPDTWxWFBQA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=qR24C9TJY6iBuJVj_x8Y:22
X-Proofpoint-ORIG-GUID: MZa1b_qPzY6tUP5xL168cS_GaoIvtlFF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAwMCBTYWx0ZWRfX59n6Vf3yxZer
 hr0UsWiUoCYktyuXyo1oZHOmg5EKasO+E/yoXv2p4s5SdOvpKIo/IR04soih6gs4nxRndqBoBEh
 oB3MEFUZ5TBChJEUKpZ+wrNq7c57xf/9MPchp6dfIxm193V8qKdSnLBkmH/F9WPY3+zCLaP+71T
 TmwQLiypbTZfkXJ5lOQLIHm/3gn/AoVuptsahsPcwVH+oI/shuS0ETwtICtMWWF8BL1gZLM9ibJ
 sCRdKR99p11TzyoJti9in++L71Eu7nTvflf6lSH2pEn+7kXw6IAQs4QR6xYKJ4FWdKpTZX9gG/x
 R+fGwWmhX54gxbUEQIBnqP6hlNEgBfTMrxK8kZSDXioDpjse5UlggXD96L6vxtvbYN5Y82saEb5
 7BXcTi7Rqibru2YHw4TP/vUHfWGFhLwjEwDmShOoXbgIbdeTvZpQ8Ucg9U3Q8wMNlMJo/mXLE7Q
 j4A+tQiHbrDnUfW288Q==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11948
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=10 bulkscore=10 lowpriorityscore=10
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280000



On 10/26/26 7:17 PM, David Hildenbrand (Arm) wrote:
> Since the deferred split queue became a list_lru, the isolate callback
> moves the folios it took a reference on to an on-stack list, linked
> through folio->_deferred_list, and deferred_split_scan() takes them off
> that list with list_del_init() without holding the list_lru lock.
> 
> deferred_split_folio() does not know about the on-stack list. It only
> holds the list_lru lock when it looks at the same list_head, and it can
> run for such a folio: a THP is queued when it is mapped, as a candidate
> for the underused check, and is queued "again" when a part of it gets
> unmapped:
> 
>    CPU0 deferred_split_scan()          CPU1 deferred_split_folio()
>    list_del_init(&folio->_deferred_list)
>      next->prev = prev
>      prev->next = next
>      entry->next = entry
>                                        list_lru_lock_irqsave()
>                                        folio_set_partially_mapped()
>                                        __list_lru_add()
>                                          list_empty(item)  -> true
>                                          list_add_tail(item, &l->list)
>                                            item->next = &l->list
>                                            item->prev = tail
>      entry->prev = entry
> 
> The folio now sits on the list_lru with ->prev pointing to itself. The
> next removal leaves the neighbours pointing to it, and they still do so
> after the folio has been freed. With CONFIG_DEBUG_LIST:
> 
>    list_del corruption. prev->next should be ffd4000000270090, but was
>    ffd4000000278090. (prev=ffd4000000270090)
> 
> Fix it by grabbing the lock around list_del_init() so
> deferred_split_folio() cannot race with it.
> 
> Fixes: fafaeceb89a5 ("mm: switch deferred split shrinker to list_lru")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Mani Tofigh <mt4022@columbia.edu>
Tested-by: Mani Tofigh <mt4022@columbia.edu>
