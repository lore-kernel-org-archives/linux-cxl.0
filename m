Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124250;
	b=3bvoRQW1Q+TcRHKzvjSO/rse/cTquw6ql8ks9lroR9zRIF2tjxgT40JXyw5DST6ADhLw
	 cLoA8jvBhAxihXp1hQQwWnj45gN7DNYBq2YA4qna9F6s3yE0ztImqBoEdS+/qMTmy0LSm
	 B1+46dbSorQFoVGVijYNiQK7P52KbyGr79i3sB9yKON5wpvmPGFMMyB7ldHRi0bZiiPnH
	 PVw26BXUF2gUnjbJiXo6vAUgvIKFpfHY8MXTaBenCXypCYG/26NiKTdv01koJDYLU9/et
	 NN1yYIqu523duDxCOQ02pcBzs7rVuooxThtYeXREEWFnx+QM1bEyOGwo+9ctoFrO8+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124250;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CbwQln0osS5Ody02EmE3zfTJ+96bXVyWs9ItOG40Y20=;
	b=WUIA589imE1MGzrmeYzA7JU/1tdKq9lgDeNOrHvW0E8D+qhinLixX6TDaIlIrUqALz8z
	 Qco5+DqTwIFHeFkykyp14Dhzyt80Uym8gnENoxOhBmW0V5ZP5Lo/deCpwWWu7F6IhAQpn
	 y2W2HomP0bV2hozOlxcrIIeyVSHJEyk/TaMiNEfd2c2WPw4Yx6aoGmGkHm/wBQtHHB9GR
	 19w+i9lrdPfL2WhWVtsfWJ9CkWF2w+ErUq4rBt8hCJVzC7b95zNxdxzqcwjZ7rHgVuk2K
	 Z4HhTRptZywoPBSuJMluJiX73woBXDpj6PPxSNBSQ8pPZ54Bq23MvGgJgCWW4ZU1+lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=HWMW+LuC;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=MkOva+DP;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8116D606A31E
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 18:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8116D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=HWMW+LuC;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=MkOva+DP
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RHhNY9273992
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 14:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=CbwQ
	ln0osS5Ody02EmE3zfTJ+96bXVyWs9ItOG40Y20=; b=HWMW+LuCz6utW8S/VyIJ
	rHuo4CHhRhfcBnkgT2it5oCdt4YIlLKc6jaoFTG6NBRm9OQx8/Gj8cgBC4Do0iWk
	mAEHeGX4ZEQrgjmx5BHUqwprw2uw/fxZQF3p+JzRElcb76yXcKt4GQvOnFFzOajv
	msygurYhvvDfEXZY1Y1OFRcS/MQ3DzxL1Zn7WjVKu/boL2iCknUIbvotLMEHVOFn
	8z9EcTAubn7A/+OQElkqnT0CU8euYHGKsuMyJovfBE9MpfZ4akkMjYw62aGpHRD7
	9NYu/mzCxLPH6caGTchbWrsAFJNSQvq09+77FlRkr73QTb2lnAcZCq5a3XUaooGA
	UQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hjqr9ckwx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 14:04:03 -0400 (EDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-917a7c17166so3709256d6.1
        for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 11:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793124242; x=1793729042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CbwQln0osS5Ody02EmE3zfTJ+96bXVyWs9ItOG40Y20=;
        b=MkOva+DPKFBicQaIHSSly2JfoMAicHAbd7jFFZ2jAPfMZSSAxwOfcC3CPShO84ijPq
         ZECGGl73Kz7/09FPj4HtrAatZ8+T45RQt+M4cGZiieC2QJbgruC3B154GGVXb7OAzN+0
         2UhtrH2K//SHtIBzgQwch7+1xSTuSdd3XBXrSOFftUuUdhA49+eAWmetIwHQ/lmQkNU1
         eDgkpiPJIa7m+mdnAJUQCGKhtaBLbGtQoh5/+RjGZf2sev+2X2y5UVI9n1Ip2H0WcVvt
         DLiMDqjdZzodxrWp70M2mYAtjmKnXIkOjZKPebpETepX3BO/HR7B5Mv3SiADMWH9paOp
         KEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793124242; x=1793729042;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CbwQln0osS5Ody02EmE3zfTJ+96bXVyWs9ItOG40Y20=;
        b=a4kJvOfyGoCFAhzBXT6vtIuQLybhuxWTzLtLLBqX/CzYg6vif/b2FMNJqUqncbPW30
         EcsuCY1BpFE2pJleZ6EpbXJ8+gHw+2sRu8DU3Kdeqm3wrC1S+YeJGfd9kVxKBNtiNzUp
         0d8i8eTlPoHk7ldODO6ciW/IrOXmIHyry4gw1u3vqVAxWbA26ElSAFLHvrkcF3LT9cQ2
         6AbOTbk3C/OUHbG3BdTNmazhL10C99j2tpttVgJnASwT3DTPQkWI2ce7d8DXxQ9GoYyY
         02Kc+IQWxgJT8gwPJ5HrTQUX/l4iSHEojypQq17BLzM2WZWZp/21D84VlN5RiC2KG2ap
         hzog==
X-Forwarded-Encrypted: i=1; AKwUvBwvxhXJXHYvhLtiexP4Ly/s5eaG7czpZE64ldP3ajJmr/jfY+aI+0YomHyPkLdHfDE2Pu2pSzxRbMA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIv3OqT/MGcAArEPivwvw140vGdmShdi3VLWAOVjiqITF7EKUCl
	uU6osNt4OIIuOrTdqhI6CSRck/dXkmy5gNCgHVI8mbhw3IvRofiCx9cegcxkChImSSe1kJkRWGb
	R5NMIWv6dCIPIBxbCCU/GI6qNr2TU95FSUUq1a+U/+PQvljFLjRw1B3Vt4A==
X-Gm-Gg: AYBFou0eoxeYD6CMb7OavU8RLh4IWlHWZwj8XWq9PH5TRHjxnuec49TGdMuMJjjR8Jk
	cR6LB1PL5vAOzXX97D0lSa+AnQY5ufcZJ5KI+k9ncr2T8h8lAFlWtha6oY1Gs4TmCgVSZ55CdN7
	NnxdfbYdZG0kkz5c0+PKKPnViF9dc8eHOCHscs47G4is84lNeLK2336IPwZu/RoYrxLEYE44/12
	WjhnN9CgyF/ejnZFoGHGU7Kudq7+tCY6e316slGNksXaZis9TCtRqwRmKfQ2FzI9HA/v+igdDYz
	/LLwCj944jfMK+HYRxe+gaU9sIPtw4q0oN2jGCFpoetDzogACn53Ba51J7sH2fCHPlAI3e/Y0cc
	EXtjalwNL7ZfhJPeQ4NkIFsr+p/rOs1v5b6oTDGP7wvzRJnMw5lLpRQWhuSrASIp6oXSzDZGn3J
	2I5+ylh1Oak2mPfAt843nRMZAjVRBzyxORXupPCoR0bz6chbHreSO8KBkecGftjZvoN7NkK49jT
	Z14rTguwjQBt5A=
X-Received: by 2002:a05:620a:2a06:b0:93e:c12c:9dd2 with SMTP id af79cd13be357-940ef9ed966mr1547498485a.82.1793124242398;
        Tue, 27 Oct 2026 11:04:02 -0700 (PDT)
X-Received: by 2002:a05:620a:2a06:b0:93e:c12c:9dd2 with SMTP id af79cd13be357-940ef9ed966mr1547486985a.82.1793124241704;
        Tue, 27 Oct 2026 11:04:01 -0700 (PDT)
Received: from [10.206.51.58] ([129.236.225.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a94a5csm1037624685a.41.2026.10.27.11.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 11:04:00 -0700 (PDT)
Message-ID: <208738b1-35df-458c-9955-e2e5318fd2c7@columbia.edu>
Date: Tue, 27 Oct 2026 14:03:58 -0400
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
        Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
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
        Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-cxl@vger.kernel.org, stable@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
 <auCw2-_yjh1_RjiO@cmpxchg.org>
 <5d431bf7-8813-4e2c-a40d-b45d4ff39a5b@kernel.org>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <5d431bf7-8813-4e2c-a40d-b45d4ff39a5b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7fXxOzCurmSJi-ECo-wgLcESrvWSlpi9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MSBTYWx0ZWRfX65nFNkEyJqlE
 uqOHnhPVM1IcUnN3x+82bB6CRNBptJs0a9mbZR2VXA84Q3HZy/VvATy1Aarkr5SGHssBT5nMi1K
 ywxgo0ArfLiZsfcvrzcDLid8zTsvAoM1JSbJG1V8LaCmSHqnC9Lx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MSBTYWx0ZWRfX8Mme+roP+Rxp
 +zgKgOvNlteA84gmwuD/lW+1WY7LBxmaSn/yGm2tQ8Y50D7StE4OFsr3bAgYy4kUZWPUASRIBfB
 A4NiQ3MHUl38giRJ6nfZNUNsJFE6Ecb9ln7SDWT6zN3BSMl885bGD8+qCaWL2GBVp/Q6MZNadXV
 jWG+mx5czTHSRAupAIYp7/U6gMo2bxjsRehitcENb8D/G22YDL6DFGDB2EEBNEwHkkYBo9bQcuh
 fUec+xv88LqopCxkR0cx4NJUDKaD4r9TsqbpsAsvt4xqb9sWl669Ii2m4KHeWPvXa27K0Z2w3qA
 onv33A2FuLScE06MBeL6JC/xoaEqq2Ux0QRlNgjIWzJN4oMw6sz3nGjLOVyLXe/k4zqEJJImJzq
 dRpDBgW8eXGP3W8TtMjmmSqmC0LRaWhYDwsKaghzZkAI+qYUQgt2A/3JUiPJPK6xNRgEp4/BNhH
 Kwx6/scQuI5usVTUKRg==
X-Authority-Analysis: v=2.4 cv=PKSaavqC c=1 sm=1 tr=0 ts=6ae0e793 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=TdXXog4ttPu8yHJGq4T0ug==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=VwQbUJbxAAAA:8 a=pJWPUViXIfCbsMganCcA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-GUID: 7fXxOzCurmSJi-ECo-wgLcESrvWSlpi9
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11948
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1011 lowpriorityscore=10 adultscore=0
 bulkscore=10 impostorscore=10 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270071



On 10/27/26 11:15 AM, David Hildenbrand (Arm) wrote:
> While I have your attention: This variant works, a different proposal used
> 
> list_del_init_careful()
> 
> instead. However, that is documented to require list_empty_careful().
> 
> Do you think it's worth looking into?
> 
> 
> https://lore.kernel.org/all/20261026-thpsplit-careful-v1-1-d357d70fd6f4@columbia.edu/

In this case the careful variant is fine without
list_empty_careful() since it writes ->prev first
and then ->next with smp_store_release(), and
__list_lru_add() only writes to the entry after it
sees -> next == entry so it can't race with the ->prev
write anymore.

But your version also covers the PG_partially_mapped
race your comment mentions, which mine doesn't, so
it's the more complete fix anyway.

Thanks,
Mani

