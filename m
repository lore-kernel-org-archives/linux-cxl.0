Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125226;
	b=pjWg2sAsw1QfPcvz0MeQy5LbcSmq0np6ijDmnGi9gp85MhG/CMCYRJQODyMFg90kcOB5
	 JdN9UmEWfKf3D1z/+HTooV0irk3d5n2TDsiBx2Sv3Gzp0vZg4oFGkbLr4i1jZUA2CgRg0
	 b+/k9FIWoUXFEOLRxtdqqY3CeDw0rPznl4//WnOslp9ntjN1Nh/GeBOML8JsmHt4V5deF
	 e8WCSV0BVjHHrRBb+vehNBsIyrGBZxacL9gkmVaFUWiIWEDL6IQco1077lKK6YnjQrLEL
	 8kzvBujsCaadCpQ+ANXzdB8Bd7Qk8iG+ft+h4kCkazSyvQyNCww+A2Vmj2aB9fXYKHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125226;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=l/eyCz6OAbl+DS5fLuIlzjlbpRVKk1BOYI/y79dV96Q=;
	b=GynGAW8DMVxPaJFPtGjaC38Z2V+fBVeQ0/WSKOTneR8WVQ+uCP70xt+2BEkH3QPI25eB
	 Ngp0Zev7t049TpDlCz7PL1Vf3c1x6NHRkSOuNAgZclBk/c14+aV0PhPYLSbpRSYlzc2Dg
	 scp8G1I8ohyt9fNHa/2kpqa9cZ/AkX+fIfLx+lfYqdqO4Ok7JHjnmSkuSfmcCp2R8kPr0
	 bi1pN80UwTxGJVlb3O/xzSYFuJetnymRXE6DEDkZ8IuCKLmZMXaeHt3RZeZicrOuA4yYF
	 LCk/gVk8ROTZ5wLyY5aK45P64yWDF2XwoU50ASPuJ899jMKheI30TO6SiS0RHBYkNag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n7dAzJ39;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rk+JP5ib;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB90606A31A
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 18:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CB90606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n7dAzJ39;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rk+JP5ib
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RIHoJB4036022
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 18:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l/eyCz6OAbl+DS5fLuIlzjlbpRVKk1BOYI/y79dV96Q=; b=n7dAzJ39aoyMybfW
	C8p0Iyuxi7XkYk9D8imsy4nxniqVV6zmD3azOUtVTBNpRVV+Bj6JvpCHRLtFWtdT
	JVGkhz4XbmGEkyJIXpzbeXgndVngtQhudEfIzH8+eA+aXhuCOFvXXZM3JC1zpkmH
	ky8Wm14wDzko8eTGd5CtMFZB8m3oUG4P3tvueJCIPIOxAKT+RBeW2cNik6V4wRDW
	5nbI1ZAalZEaZrE1Zl3YzVdZ96aWtf7jhURrIvQBv+WnWnJl9e08lvT5x0QFAkw5
	+3ufaGu51gktQtnCp4NnKbugB0rHh9IXxkBxaD9Z1SnTJN0x9HrJvgC4cIf7Xzpc
	OWb86Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjyjprfsb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 18:20:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f13c143c8so8951585a.3
        for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 11:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793125224; x=1793730024; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l/eyCz6OAbl+DS5fLuIlzjlbpRVKk1BOYI/y79dV96Q=;
        b=Rk+JP5ibflAx4RfOYR9Nexx30TkerXcQzYPagK6fL+ieCFzZTqMyu+OClKbSPgGCC6
         miAx1a4FRDYVQ66dWgIbzRfqNgeMolhcTrL5oH7EQVIOle7C6qdpSd/NuPnV8PHkARlE
         7qJ7vtLxze4wkKTk7xy6hhMbdARHx8+E8L4v+fE4D7IHEIfvh4elM0CnVT66/S4gaXEZ
         ah6A81KgS+N/M3JLVa+dwAueFZBoNmoIQK+BzjtJrlheX2CmmrzWjUG/6zJpWQPaL6ss
         gnXO157bu3CDSW0M/Ns13UyijEgnkw+qbjjkHQwXPdAXp0jn4PCnPAotBUyj4Hyzzx5c
         Jy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793125224; x=1793730024;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l/eyCz6OAbl+DS5fLuIlzjlbpRVKk1BOYI/y79dV96Q=;
        b=Z+ZmXYDoS5ALW+3/te7Qk2sMwAeeVs6z5icgoyE6X0SHmIRuYBmYt4m++GA06rgrx4
         8ArbdZUdBl2vL+GQRYRWN6Qy6XYJecYXjXQe1DWcUZ6fNp9/3OyESw/pg1PVTnhMJA2q
         xyn75Fk202CialKl7Kf39XyaZgpnx3S07UG+Do8CzWrVO5BMUNshHi1bq538o56DRgwx
         fko8Dtm4PcTNjPHrUAhiw6/AHqoVA3WjOakSPsn7V/kjcmdhTRKjZ8KYhk9sph613pQo
         5WnE7EWdm7KjIi2J+X4HrPdsOMCJtcTQBbO6po/uqZmriKA5oubCZ8bBN5lTDfHKBnsG
         2+IA==
X-Forwarded-Encrypted: i=1; AKwUvBzhU9908X0jLhDiJOQbqaK0vnwFUwdHNyz6pPpNH9Zdw9wC8rDguRoVx8ewwBWkISHjMwjv5dYphmU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1pvnVf2eh2clCSYtmVJ8KJVWsZERbvP8p0R8ChqM+7Zin4Uwe
	mU99M2wS1y0C7Vec/+qtNqHcQGAV/9LTsWLtxOKYljyfhPpWfxWJzdBWXyfQJCipoDcOuTjMwAm
	XUdX98fzOgnsQ1+x5EKnAXCKtOHDaFwdXFXshPz+fBMhOy42/KR9n0G6X12zn9zA=
X-Gm-Gg: AYBFou27ZR3TcTPMhw9BqhnrQRtIgkkXarqhHVT2fcl22JmklBCu+qNdc+mihSAZpJ3
	LDGUrywsKfanc4IVNwnx6lcocMM17u8MJIQC+HxnKz70i4D8JJDPktNpHjrpokjVSRbqCDPQorz
	AjdKDDMPfuagYY2uuUjcd/7QCrGs4AoJ622HkmdOdO6TkaO1crBultYybFxg9Aejm0e/eoiJKsf
	meqRdeYLd7jHSYAF4kStIqy1TlC/5HQuay0ODWZFBumAJx7e4GyMGuqFqXSAEJ2kOot2oZkMXaS
	MPwj8ZI9Xz5GX7aDf+8nOR9wrbtNm7wWiGtbJX0ODmZ00HB3cGcKnmN6RMfuv7xR1RK3gKghjEF
	K21nFTT26N6I9V0ywflSXwNUGVgnCLBJsDJmeSl37fe59aYfJVA==
X-Received: by 2002:a05:620a:a992:10b0:943:faab:aabe with SMTP id af79cd13be357-943faabb32bmr278237785a.62.1793125223759;
        Tue, 27 Oct 2026 11:20:23 -0700 (PDT)
X-Received: by 2002:a05:620a:a992:10b0:943:faab:aabe with SMTP id af79cd13be357-943faabb32bmr278233285a.62.1793125223141;
        Tue, 27 Oct 2026 11:20:23 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net. [82.67.153.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd48e0sm24775219f8f.38.2026.10.27.11.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 11:20:22 -0700 (PDT)
Message-ID: <02d394e6-eafe-4a3d-9f63-61b639267aa8@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 19:20:21 +0100
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
Subject: Re: [PATCH] MAINTAINERS: Update Junjie Cao's email address
Content-Language: en-US
To: Junjie Cao <junjie.cao@linux.dev>, qemu-devel@nongnu.org
Cc: jic23@kernel.org, mst@redhat.com, anisa.su@samsung.com,
        linux-cxl@vger.kernel.org, junjie.cao@intel.com
References: <20261021134307.874867-1-junjie.cao@linux.dev>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261021134307.874867-1-junjie.cao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfXw9EWCUqw0xB8
 8IcCYojoNUdrgx4ylK/BdPckTVVf0MTWGScpxOOhKndeKt3Ppe7LrC9UTYwAx1afpWIP3GbujkG
 B9SlbpcpFKWl1PFYvjLl+kdG0OAZWqaDZO082eXZ284KzcPVfdJQuKvjR6wAl9VXWv5w9srC+lq
 WUywBfiw+Sr3/gNpi//iXwRYNbAzAEF1v+Yf2P2sC3MZgCfWag9bKwuYNw5Zvn4rYO4jmw3TKNs
 +c0WEhOg7kW2GdpZBYAWwOnSEko5vWzjMjKD74o3B6HfIfPM1k2Uj8ZhdmQ0uKQBliJDtieFKQx
 n9KtC8QVTcqtsb1oYyOccWJKaYZyz1oHZPjOGTA1HV0uUAwPn1SLzzbaCYahtkGEeOyE4Jmmwws
 U/wf5v6ZPrfumJrmOH36s28O98rlgV4P+1T1WelXap0Re5VrnWrQgGRispKQyh/nb6CrTJCaNoz
 tjWI8hUzdRdN17jJnPQ==
X-Proofpoint-ORIG-GUID: oEUrkUgERl6Gfpg3kFWYig9KIEVH_cEO
X-Proofpoint-GUID: oEUrkUgERl6Gfpg3kFWYig9KIEVH_cEO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfX9i6/aKU0BX8T
 yRpVF0tZBClBq7gW67cZ+xGP2r/CSBHI7oQ7IKhKHq5evCYBJ+AwSn1726nHpklcm0p6+9dpcdX
 oMAboSbtwVdEiHmK7QvvhcfQDHFTsPs=
X-Authority-Analysis: v=2.4 cv=JodkP84C c=1 sm=1 tr=0 ts=6ae0eb68 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=hD80L64hAAAA:8 a=njIK7alONr2zF-bboPIA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270072

Hi,

On 21/10/26 15:43, Junjie Cao wrote:
> Update my email address to junjie.cao@linux.dev for future correspondence.
> I'll continue contributing and reviewing CXL patches.
> 
> Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d9209f043f..2b78316436 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3370,7 +3370,7 @@ F: docs/devel/migration/CPR.rst
>   
>   Compute Express Link
>   M: Jonathan Cameron <jic23@kernel.org>
> -R: Junjie Cao <junjie.cao@intel.com>

Could you Ack from your other email?

> +R: Junjie Cao <junjie.cao@linux.dev>
>   R: Anisa Su <anisa.su@samsung.com>
>   L: linux-cxl@vger.kernel.org
>   S: Supported

