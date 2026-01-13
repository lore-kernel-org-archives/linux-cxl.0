Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B11341AB8
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296790; cv=none; b=JjbGUl+LsUjzmTnn2xSHlc7OteIrWY2LeedgKHhrL2c9uITLVMKeWmFOZLuAClWdBfpXYSgUOD3z7NVSG09/7FX2fYa3gVRrakD3g7iprG3Odk9MMmPJTrIH06hM31mJjTcH0jIWWsXmjP7RiqrttybpKnDjVlroNP86jPO/TDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296790; c=relaxed/simple;
	bh=1Eiifu80j52RijGjXr0wmDrto47lICEqQroalzmp67M=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Oqv5Z16CspWNJ7purPf3eYDPk0TTfttFHqdV9wmpJM+pDw8AWjyQDiFC2q+8LYCA3Iubc7eYAYJfW5D0muczrvKvm1MZgOtmx7AI5dDTDiClo7VDlX/lMdAk5FAoapHn/uVPr1ehCQLdIZCTprS4Rl2mFcIJxjzDp7n/zeYXRsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fZ0UFaTH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O2gKk1Yc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fZ0UFaTH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O2gKk1Yc"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D7aQfm3299726
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 09:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1Eiifu80j52RijGjXr0wmDrto47lICEqQroalzmp67M=; b=fZ0UFaTHpp3VQxv7
	41/ygaOqURkgS+QcOuMwXCj2F0c9c246Ngcx1OSWcmq1qCZzK5tcoHnIyLARRC9T
	3jZJfrcgqc5z4/WzjW2AVsv6zcONO6gmn6To2XqqZ7EpNYhzJa6z2hpJ1yhk3V/k
	sIJW6ZTLRL81vDA9eLkajoQAgn68yPkHVfXA8Ba9alf4vRU0NhfaNf5wL59ZulQ1
	10IvqCDzb8PWhY4ZEN+qoMPzzUkBkfRQ5ic+NCWUh5xZmBWBP7aF3Mhvnqnb6AqN
	jSlAXHgnm1HD4ew6zEExPlLen8RJ4QjLvHw7aedI7muusxTONUGdRe37kYfe3Tmv
	XzeWPg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn6jma7ac-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 09:33:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34eff656256so7476645a91.2
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 01:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768296786; x=1768901586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Eiifu80j52RijGjXr0wmDrto47lICEqQroalzmp67M=;
        b=O2gKk1Yc04LVUPk+i++rsmj/4klq4uOmyQPAvcVvJM+6rYivoaW2QiOnqOsdG9wBo+
         HtDi7lzZ4zanig6rSl7O6l6QEsAViThRh7wWOMpU3ZbkuMzMWAiwIi8oAziZqVmtN1se
         LySeZQvbjLaBorz1ON8XAFlRdXHNr6d7d/KtEgwQtytX84o4A3Tes7QZhC3wTnSb/3Uz
         hsl9sGPOIqyLNjaXxBCCJGEmv1oo0QaPwdfuVXJkEErd06Ccpzvn+kJ47uAZipJQ+aUF
         KfI0PLu3v+l6VZVJ9dqY6kjd/QrpxQkNezJRO/Oli1DmJBDrqisnOZbHNVtstvswajHx
         KxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768296786; x=1768901586;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Eiifu80j52RijGjXr0wmDrto47lICEqQroalzmp67M=;
        b=fatBvHun3mK6LBp6GCRytdN/TNpgtAdEDcx0+CUD6PRNG3XEZnJIu5FwkV7wlFdNC6
         w3r4l2umgeArIaN9Pab3daVBmkMlVVqm256fZythc2FyBY875mtEHrmAYAIWQ2Z0a2nT
         Vqh0rp0UbPjs20f0zJaRWF2GeOUHtK1bXnAhnW8gWFQIkUQ+v/3u6AB9jJBXVFSEomab
         IVQ75tZPsGWeh+MxA1cTLKic2l8mlBsqnrmkrnaI3JAXwHZmb0swbsG2pXsZD6+/RkPX
         XelBOLsFskBH8HcOWOhrLmoxPXHEbaJS/nzDnPnTLAIHuCQ3+xQXCqacl09X441OqrH0
         0uhg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ0fLb4mLWN8CsgEDLrm9zfRUpRAUvbYzsa9Jub+4/h/0EGScG6gBoiwLQYW8QkES9ScGSecwHY6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDLHX8osy/HSm4Ho/Q8P/FiZTpO5rkC9bhWKjz9PYPgzgqLL7t
	9qSxWsbigKdnqdV97045oX0v1pzmammNXpEB2Ja78+7rHG/+V61o75h2ERipQZBO9hd6YgpUs+Y
	UfA4bCUCswCxlerOxVPI3X6v1/y65dnyawg1wHgRg08jci9BTnNK+9RJBtM6AQQ0=
X-Gm-Gg: AY/fxX5aEcoOATVlg+OYQrTJpSCzVVVN6EuaMrE41cOkymEV3d0NdP9xAVn01COYTVL
	jMks244mIOE1kslsEtqf4v76t47ZEb4ZvCuSAo7G6FVe0dYKc6tQCbet6HxaIx/Wi1U/VQWEzii
	nAyhhRE6fU+IeznBxCvSynP+b8JurWRQH1gI2P3aVmBnbNF14b5+C4cKJwfFNGryC5NAxWjqxod
	bfhLrTCODJen+Usxw+TDtRq6CZn7JdNgY01vt+Th754Dbhx3ulbvB8LThHUT9w3QAi9BhuvJRm/
	YGfhRDDN763/STq9JiH3fagjk1v3B+mxxMuiJccg4j2u8DNzFjVkBGoxT8F4+uWTs53gVvmFHCt
	OVHc6MGotWcZ3XWQfjn4fQagDmgh5J8VqqVUkAjnDEg==
X-Received: by 2002:a17:903:2b05:b0:29b:e54f:936d with SMTP id d9443c01a7336-2a3ee433175mr209045655ad.1.1768296786082;
        Tue, 13 Jan 2026 01:33:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUW+AGHuF4co37Yj2KMp2HJuC+tdM8BWSZSCu/VCAIlvHrWutChuq4ZOgZfyraylsR1ktpNg==
X-Received: by 2002:a17:903:2b05:b0:29b:e54f:936d with SMTP id d9443c01a7336-2a3ee433175mr209045135ad.1.1768296785541;
        Tue, 13 Jan 2026 01:33:05 -0800 (PST)
Received: from [10.218.5.175] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c48c75sm199484985ad.35.2026.01.13.01.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 01:33:05 -0800 (PST)
Message-ID: <d23898e5-caec-43db-ae29-2c56a6b83693@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 15:02:56 +0530
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: akinobu.mita@gmail.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, apopple@nvidia.com,
        axelrasmussen@google.com, bingjiao@google.com, byungchul@sk.com,
        david@kernel.org, gourry@gourry.net, hannes@cmpxchg.org,
        jonathan.cameron@huawei.com, joshua.hahnjy@gmail.com,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
        matthew.brost@intel.com, mhocko@kernel.org,
        pratyush.brahma@oss.qualcomm.com, rakie.kim@sk.com, rppt@kernel.org,
        shakeel.butt@linux.dev, surenb@google.com, vbabka@suse.cz,
        weixugc@google.com, ying.huang@linux.alibaba.com, yuanchu@google.com,
        zhengqi.arch@bytedance.com, ziy@nvidia.com
References: <20260113081453.8293-3-akinobu.mita@gmail.com>
Subject: Re: [PATCH v4 2/3] mm: numa_emu: add document for NUMA emulation
Content-Language: en-US
From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
In-Reply-To: <20260113081453.8293-3-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bbDQiX8lmPSOtk4vQqZi9r1ZnGBgLPSP
X-Authority-Analysis: v=2.4 cv=SK1PlevH c=1 sm=1 tr=0 ts=69661153 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=UdPnmgDXQIG4_xgNs28A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: bbDQiX8lmPSOtk4vQqZi9r1ZnGBgLPSP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA4MCBTYWx0ZWRfX0HCZQAFEVC4r
 36F17rPr5nn3J72PSmhwsugv6IBZp31ExBwcGAf11vOqreGn8zrlYG/sIudX9aJL/coSf8j/L1M
 08nDAm7jHoAQ0K6EHCCHANEGdhoBCgHjA5zo60d600A6Ns7XM0RFIYSgLyQXm2Em5gi2L0Z4IfA
 Eir+8Hv6svpsopCX9zUn1DCV7HufBtB+XPlq1tJPc2Jo93jsAk746qMo+j5RGfi1/Mdfo5KNStT
 wtgREE0Ox03QHV1NpYno6KjkjwxviAQHLhXcgjtrQAxsVgIDm/Czw3hQLeQUjUCah1EZTnzMFpo
 m6wy+J3a6lk7dNm+vonlwivdIafOHlsRozFU8nAfR7Qip8epxlke0TonUgJQC8PVYCL8OxmFI0b
 Vf0sZXKIwcnZZZ+EGe3Ykezi6qhwb26yafLPtL7NvZU3i+xOaj09dFIsj66xti3Y8w3V+3b7MuT
 mWq71BWOzaUYTEEiCzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130080

Reviewed-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>


