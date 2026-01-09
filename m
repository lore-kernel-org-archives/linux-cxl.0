Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F9E3563D5
	for <linux-cxl@vger.kernel.org>; Fri,  9 Jan 2026 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951347; cv=none; b=blxAwCXDKBuJi4+yX49qnO4tFpSh0a9em1nL43k/7cixOT3VYXZIRnMcyMbLHciAkTijqtRxE9n00t9vwW14yJmuTCl9pncY44ch0hVeou+6/YR05GX2ov1E3X5E+oLoUvBbvIK6OldlBZdytU6o6j3lMfxxahGXggtgtXX0iT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951347; c=relaxed/simple;
	bh=wRc0tXXioJaz4/Nwc5V292nnsUkko9GAXJqleHLTKI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hB+6sLHEC+KZ6pi6RxNhehLkDQtLdwqsA/Wd/eUoCHac3bN1Q8sGTZtBRj6kcbgvR264XlPiXAjKAEsjyBKZmYkEyUe1BI+DW0bna6FHi2gT9Ql02Sscd3urFzXsMie7gi2E9iyRZfNlBguruptlYiY1cMDwgMRle7mAE+czvPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gD4d7LD7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cU2Upmw8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gD4d7LD7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cU2Upmw8"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6099XjUa1048558
	for <linux-cxl@vger.kernel.org>; Fri, 9 Jan 2026 09:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3iojzp7AXQH0u6ZxuwGy4zWDgaqOjTe75g7N5AkccBk=; b=gD4d7LD7EbNkJqqu
	xUth1YS5fdXr8zijS7aw1rBu87Jz1IEM8J2sK5jDvF69O/cbY4jezCxnMiOUEfb9
	FaA0z/LG2zpF2k9mYjfnp2jzJdxNUTYGwa+qCMyLCpKQKQZ3xoclx34Srt1+TftA
	34i3StxR3/WBMTs3vymv7js76dfMiMTJj6os0SISfcsxE2/eo7yhj2APcLp/hLm7
	fz6ihDKFAhkDVG8tStsaKa2zCeXsBBvWU8oiWtF4l014wJcfwt4DQjl3zlSZ1dqP
	LqmSYApNjRZ0xAEcYjL53nbB1Z+m6j4ICiYqattICWBySAElbUkLp7+y8i7C7shV
	Z5fznw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjy5b809j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Fri, 09 Jan 2026 09:35:44 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ae29a21e7eso1852999eec.0
        for <linux-cxl@vger.kernel.org>; Fri, 09 Jan 2026 01:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767951343; x=1768556143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iojzp7AXQH0u6ZxuwGy4zWDgaqOjTe75g7N5AkccBk=;
        b=cU2Upmw8ptN5pViFoektimNr01WXN/WtXEjSz2O5oSfTfPAkM0Icwg7QvFPkBz6FK8
         Js276XNBBF0d16uhI4fGxWYB/TC3pVdR2xsONk3Cz997NrEF+n9HOPgySIQfU+w7V7ob
         AKcTo27Dm/NHUcpkzz5e6gCzMg4WHqduIAQqcHeVKXgKi6huv1IIs747cpDgsSlertPA
         5YYAWFM+jmhwZijrbsKc2DgLYkdaR8vQRavtdgLWnmaCYSqV8p/g5JY+Mn0EICg3yltx
         j6LqZTCa4OKWgKtiMrNSt7fUSULZ9qNA3nim+fML8zWT9ZazAMPQtOvthZ5dU1S++O7R
         gslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767951343; x=1768556143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3iojzp7AXQH0u6ZxuwGy4zWDgaqOjTe75g7N5AkccBk=;
        b=Kw4CCU8EAIrHEYeeI1cJzZVRxs/4ENp874zCcIlScyoE/dyOhITfY1HKih3U8X7QRS
         b4moaWYZW9Yzh6oY5LcB24Ul0g6Ar+xtsiTKQ0xx6D+TlCgzDuTBBWcj0BJgSrfSNCA0
         GuCyUzpzhzfMvIVWCspigRiMFeuTilKmZS5f0aoZE3cOIM98/eSdyx6IeqHfEnMsfCNj
         M833oeWaOLXum5TUZQtC/awbpdiBSeLcSKqiHi0qgbEZ43fjh5uwQMSxDhQ46Len+mow
         SDsu4qxiNQscjYhb+TZy42UABTRypMTIgsQ+oEyPTEX8l23IrTJTmWwR+8QqSL6OGvqF
         LoZg==
X-Forwarded-Encrypted: i=1; AJvYcCXR0fKafaxoIXBJZN33aqp4zCe/XuJy4naq0YH1ee1NoBsq+ounHM0EcRFbZBcYTM30YMqPp6Xr84Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqaGasdTeqVwEXmY+vcAfAEKdqxPEd3SGfyMOU/lxfvfmjwcmT
	F3ERDuwHYhXSTyos5M8rdmjbFvS2dcnN8vAGeHq8FO7hLVDcLREdd7IPmBujS0mxVPwVcKLoRJs
	6nn7T1phU82zHoa3ToX9V50phyZwApwCDbgn/DzbtUm9XEGzzUBATn4NOyoFxvW7cMCNQhBUlJA
	H4zjgPp+qpCYJ9wz2Ju3SDlhjKwyMfDJXLgErTf7vrM4rQZOQz
X-Gm-Gg: AY/fxX60Q13A3vAr2Gd85HN2VYEbJH+J9lC2oSYdDFp1lSci9rx76lUHEf+CRmVzK0b
	6TtcIz5TIJl/MdfXk8T91XGV+TVZktMVQAWAw+/FoBLsfd6pYGku/+xDKqiABaHPg6qu9HRbBfH
	0TMuIrWB1aR6eLzDV446lsbkDa5/mH+ySzlMYi+f7+fobCYLsiEeD0Aqz4YJg1ngp+ubJ8
X-Received: by 2002:a05:7300:551:b0:2a4:6c74:c54a with SMTP id 5a478bee46e88-2b17c89636cmr6203033eec.18.1767951343066;
        Fri, 09 Jan 2026 01:35:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjsjc9X4TtkDjvpzzyEN7YVy2fVy4g1x1T/tHe1z5/FLBJR6gO6kMr0v+2FZd0uUGsy+noJHHR+bOIdZeaBZ8=
X-Received: by 2002:a05:7300:551:b0:2a4:6c74:c54a with SMTP id
 5a478bee46e88-2b17c89636cmr6203015eec.18.1767951342522; Fri, 09 Jan 2026
 01:35:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106031042.1606729-2-cuichao1753@phytium.com.cn>
In-Reply-To: <20260106031042.1606729-2-cuichao1753@phytium.com.cn>
From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 15:05:31 +0530
X-Gm-Features: AZwV_Qg8GSORLSmZAk-i5FV38NWIPnQziFHC1lSE5ORre2DCBTsVGVLGkQhEY7M
Message-ID: <CALzOmR2z0noh74aCAd=QVUBgdn7Q+Hbevs-cr1EtV_zXCuQ=PA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID of CFMW
To: Cui Chao <cuichao1753@phytium.com.cn>
Cc: Wang Yinfeng <wangyinfeng@phytium.com.cn>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: blgzSkZOYKYXoyTRIRayAgYCdk3EGd7o
X-Authority-Analysis: v=2.4 cv=JP42csKb c=1 sm=1 tr=0 ts=6960cbf0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=fgrLqfBXAAAA:8 a=i0EeH86SAAAA:8
 a=zSqqh9NAIYBvi6e2emAA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=_Ge82aPy-h_wFa7gWU4u:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NSBTYWx0ZWRfX6NRinjE19Y+Z
 5ayMCh6VFn3AhUaV7VCDyGYio3BmhbvC/0KdI70tBupirLYaFrSoC0HeqD93ZqFg99J8AZTdeCz
 HRQi3LWdoF84fEwACuxRWd9LGp05wY7uWSD2OjCLJsvtVSwYAcK17wVV+vDgDe/u4D+fUJQe3vL
 Vbb0Cmoe/2zlqF4aYEz6oPZJCozYO6xx+t3uGM5fhBJLWS/d7EEEQL4W0G9g3yJpB69r+3Kk/Uk
 NUjXZzO0KjIgE1CFWPyCwVvmEWljj0pmPMet8YDHrq1Kc21kUN/j5KaR7n689EBTDb2Noufo0mF
 vMEbAHFdJrw8oOlU2Dm4JAFxPjJAqOS/piQlUefST2GMBw4PulnGtu8Ja/DWloJe/6tA5zktdDc
 2tZN5QaK40HSALaLDI3oA1EKqloWLpOQjJgEkvDSTfRkJAMUjWfoF76zu79CR4XACUWoxIz8NOE
 DRdpfedrjKGkLBL6Lag==
X-Proofpoint-GUID: blgzSkZOYKYXoyTRIRayAgYCdk3EGd7o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090065

On Fri, Jan 9, 2026 at 12:44=E2=80=AFPM Cui Chao <cuichao1753@phytium.com.c=
n> wrote:
>
> In some physical memory layout designs, the address space of CFMW
> resides between multiple segments of system memory belonging to
> the same NUMA node. In numa_cleanup_meminfo, these multiple segments
> of system memory are merged into a larger numa_memblk. When
> identifying which NUMA node the CFMW belongs to, it may be incorrectly
> assigned to the NUMA node of the merged system memory.
>
> Example memory layout:
>
> Physical address space:
>     0x00000000 - 0x1FFFFFFF  System RAM (node0)
>     0x20000000 - 0x2FFFFFFF  CXL CFMW (node2)
>     0x40000000 - 0x5FFFFFFF  System RAM (node0)
>     0x60000000 - 0x7FFFFFFF  System RAM (node1)
>
> After numa_cleanup_meminfo, the two node0 segments are merged into one:
>     0x00000000 - 0x5FFFFFFF  System RAM (node0) // CFMW is inside the ran=
ge
>     0x60000000 - 0x7FFFFFFF  System RAM (node1)
>
> So the CFMW (0x20000000-0x2FFFFFFF) will be incorrectly assigned to node0=
.
>
> To address this scenario, accurately identifying the correct NUMA node
> can be achieved by checking whether the region belongs to both
> numa_meminfo and numa_reserved_meminfo.
>
> Signed-off-by: Cui Chao <cuichao1753@phytium.com.cn>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>  mm/numa_memblks.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
> index 5b009a9cd8b4..e91908ed8661 100644
> --- a/mm/numa_memblks.c
> +++ b/mm/numa_memblks.c
> @@ -568,15 +568,16 @@ static int meminfo_to_nid(struct numa_meminfo *mi, =
u64 start)
>  int phys_to_target_node(u64 start)
>  {
>         int nid =3D meminfo_to_nid(&numa_meminfo, start);
> +       int reserved_nid =3D meminfo_to_nid(&numa_reserved_meminfo, start=
);
>
>         /*
>          * Prefer online nodes, but if reserved memory might be
>          * hot-added continue the search with reserved ranges.
It would be good to change this comment as well. With the new logic
you=E2=80=99re not just "continuing the search", you=E2=80=99re explicitly =
preferring
reserved on overlap.
Probably something like "Prefer numa_meminfo unless the address is
also described by reserved ranges, in which case use the reserved
nid."
>          */
> -       if (nid !=3D NUMA_NO_NODE)
> +       if (nid !=3D NUMA_NO_NODE && reserved_nid =3D=3D NUMA_NO_NODE)
>                 return nid;
>
> -       return meminfo_to_nid(&numa_reserved_meminfo, start);
> +       return reserved_nid;
>  }
>  EXPORT_SYMBOL_GPL(phys_to_target_node);
>
> --
> 2.33.0
>
