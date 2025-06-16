Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA6372607
	for <linux-cxl@vger.kernel.org>; Mon, 16 Jun 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750094596; cv=none; b=lYaZizHo1GLIS13WbLuqM8SetuWjc1Aeq4G0nVECgx36z5RGDRPx4u5tYRI5lnbyQPfBVxQZR7BZYDdfNCewAQOdJqjhhQq3K5RvAM6qQjiTmjiZpXLAXpM4KnjLDGkD91qC0M4LbRdC9oOVpH3BQUDSqN98lYazeEojj251lyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750094596; c=relaxed/simple;
	bh=9GpsATAvd5Mycus79E26ZiGHa8AvIB8hYmz1tpR7TLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dua+SRwjnn0LtLM6xOqEvWHtyZREopKQp9Nn/LsbewTgzAtul+nL6CbQOxNYOzfn7wFHXJ2W8yPW4EQ+EWvBwC89N9hGa903ey7SW+EWZfoHDYbp9GI2Ly+ytYPhcjxkbUDmNWxpLSDO5X0YaqpSCAxJR1syUj3jPQUW7wScEEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S6PEvpM2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S6PEvpM2"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G8X7Tu014209
	for <linux-cxl@vger.kernel.org>; Mon, 16 Jun 2025 17:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=m6YqyeBy7Ov8800VxqTiWsN8
	BrbBZn4cTFMrsDcYbSI=; b=S6PEvpM2FK9QmfujM/rysSmgb1/oEy93bhEOL41i
	SVT8BVDmdrX+zP/gecVNELZZi9LCo+a4Kxm63PlqKSSVfKyFLb+aQPoUgl0WMsH/
	qS9wYgGon27ZVCQ5N5ERnePMrJ/HWgQFx3RzPSCBmO/glRPTAwAYwrRIEIqf+qzW
	I1jyzMw0e0yXCc4vuJ3QHASDNB/br+k172qQIARCKvhVKFGCGMIFkVglnwQLpNMB
	mMx0m/UAyLg4N510tigFSRBcXUoBIC8lrFI8oYpsC3UaSx3uiA1p5Qwu0IA6Bk0O
	SwQpAvOl5uB/lkDQd+foYPAorubkcWsZmU387sHQiJLA2g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791fswayq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Mon, 16 Jun 2025 17:23:12 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b0f807421c9so3005933a12.0
        for <linux-cxl@vger.kernel.org>; Mon, 16 Jun 2025 10:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750094591; x=1750699391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6YqyeBy7Ov8800VxqTiWsN8BrbBZn4cTFMrsDcYbSI=;
        b=JEzKYFXDMEM1gN6HFrJCUY7XCG1hRCjtRW+i36ULtGKr5sHzMD6xIpAonjywrz5gHd
         m+7Z6H2FznD/rao3VmQ0wuvVawTrFtq9ZxmQUaA5HQfROxkdXraKe4Rb1ovQPa+xnq2m
         ulCe3X0YIzjNph0cLvJ+0aoKiJmWz+BshJXMytO4Gor3PKVI8PqZ6pvomFpvLcVL9Rf2
         TgEfHymGjpdNhHobyvz9U+dF31Dc0CYjIaUlrDpQK2BlQibxTOxpd+NVaW05hanfZjnm
         hL3mUCBcY1qfp5XBfX9+T5HRe24M3PLxMt+dpWxURPdydC/L2Nwya1a+PGnAADuscWl0
         lLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxmWXk4tGKsVCKb4eISXXnk30TYsIWExL89QrdaX00Wjq6U8pLKHJueTxoB0/b2hYBv2R00nLcNEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaTuq8jjMrKrvzKm395iJEkitos2VdBoFS1uj9RvXdsNJ/du7e
	+aWcC5bkVyHe1mrqJnbfAU78unImEIGv/D/FHsqKhyzrnKY2vO+SYN7P7lE+zDAcZOKJlu2yexe
	EdTOt0Z9xYaXmE8QjQ3D5+jRyaKwKLZM7CBFukcnQSVa4TZLYhFw24r6zef3OmsizYUaXJ3kJzj
	IAGYYvDTGhb7tXNbgd22kf6UgxhsWPf20CL6nIVw==
X-Gm-Gg: ASbGncu2c0zeSLeQrK0ptz8SWw6xhssEQBdy3SE9fwOX/w7Mad79M8KK5wLaEjsGupL
	slBVSXHfTPMTruvv7WzRk4Mk8l/ij3WFePLbleNngSyN7q2tQPp066YFTrBmtb0wXH3Kvp9dk6n
	DEAuNEWnmQCyqET7VC/X3Fdq8+EFsmPSjGdTrV
X-Received: by 2002:a17:90b:3805:b0:313:2768:3f6b with SMTP id 98e67ed59e1d1-313f1daf338mr14972215a91.27.1750094591523;
        Mon, 16 Jun 2025 10:23:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/RyDJ7K3KS6GMwbYw05w1eiNNPGaBZDamZbMnsx1mEbSqlH2ArymUN+7RmqduX/J1dxCXmqmceqnjgeN7Lbk=
X-Received: by 2002:a17:90b:3805:b0:313:2768:3f6b with SMTP id
 98e67ed59e1d1-313f1daf338mr14972173a91.27.1750094591053; Mon, 16 Jun 2025
 10:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530105430.1662-1-wangyuquan1236@phytium.com.cn> <20250612161739.0000400c@huawei.com>
In-Reply-To: <20250612161739.0000400c@huawei.com>
From: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 18:22:59 +0100
X-Gm-Features: AX0GCFvh6NbG-uIeTzAZqgYkufOxYvvCG6hnR9L5itpvXJCw5VmS78OBCW99iG4
Message-ID: <CAD=n3R1_rox5VQBPFK7XdXT8YR4Bk2S6demyLeir=Y30RirTsA@mail.gmail.com>
Subject: Re: [RFC PATCH v5] hw/arm/sbsa-ref: Support CXL Host Bridge & CFMW
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: wangyuquan <wangyuquan1236@phytium.com.cn>, rad@semihalf.com,
        peter.maydell@linaro.org, chenbaozi@phytium.com.cn,
        qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDExNiBTYWx0ZWRfXwqus6xNNRgt5
 Vi5LrMXOHxqgruAXEGqrNQp+bj5XwgkBIqMpNm5PN7eh4c4lf3Gv6eBFrFr/onwJvSWaz87Oswq
 xbOSMMwB9cwkZalGAX1sPoKPz2TwmG60cEeEjUNjH8PAlBJ9uEWC1sxJsDnjtDEmSDTnA2GURDD
 cRuOH6TbxcEqrT2pqd+q701/UWhlx8ktuvC+jkQOnr5alSXt6lX0xMIFvsBIkL5XsGvlz318jVd
 zo5BE/uZ2Vhv1rDM71MJkVdF5/Wb5Tm+wmfXtFvPWkLaZHiTROWuXdql7xhDp2W8StgYv5bsPJZ
 GQHepH95wryTO75QF6fJt0lNW0QtSrV/b5MTW4ogteZgrHpJvY5CGGR1dx6h1BRrKOmiyMLT3Qv
 WML1tLYqkDsIvvnuazz04NnqMUf8Tpwr9s7+aAw1uQq/Q+Al/c2RZLNBduChrSitMC4z7O8Y
X-Proofpoint-ORIG-GUID: 1xYfXKETXqK12_BPlE_P6iNwGhN_oNwu
X-Authority-Analysis: v=2.4 cv=OLIn3TaB c=1 sm=1 tr=0 ts=68505300 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=i0EeH86SAAAA:8 a=fgrLqfBXAAAA:8 a=UGI2eN1KjAFkz-9eoiAA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=_Ge82aPy-h_wFa7gWU4u:22
X-Proofpoint-GUID: 1xYfXKETXqK12_BPlE_P6iNwGhN_oNwu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160116

On Thu, 12 Jun 2025 at 16:17, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Fri, 30 May 2025 18:54:30 +0800
> wangyuquan <wangyuquan1236@phytium.com.cn> wrote:
> > Dynamic cxl topology problem
> > ============================
> > Actually the ideal expectation is sbsa-ref could also have a dynamic cxl topology by user
> > parameters. According to my knowledge, it should pass a dtb to firmware to match the requird
>
> Spell check: required
>
> > address space. I'm currently trying to solve this problem. I am looking for suggestions on if
> > there are better ways to do it.
>
> I wonder how many cases we actually need to cover?  If we were to support 2 host bridges
> with a few root ports each (maybe 4 or 8?) and a set of static fixed memory windows
>
> 1. Target only 1st host bridge.
> 2. Target only 2nd host bridge
> 3. Target interleave granularity X across host bridges
> 4. Target interleave granularity Y across host bridges
>
> Maybe longer term we'd want some of the more complex options such as different properties
> for the fixed memory windows or different QoS groups (QTG) but I'm not sure
> we want to go for fully configurable.  The virt patches cover testing a
> general software stack - in my mind SBSA-ref is about testing a single representative
> configuration.

No. (continued below)

> The dance through DT and trusted world is just too messy for
> a development platform / configurable test platform.

Well, the "messiness" is the point. Although the DT is incidental and
nothing that would be visible
beyond the first layer of firmware.

A lot of the general testing effort being done (across the
firmware/software layers) is set up to succed,
rather than to verify sane and functional interfaces.
The purpose of the sbsa-ref platform is to enable useful verification
of the full firmware/software stack.
_But_ it's also about providing a sane default platform.

If we can have a sane default platform that also permits specifying
more complex topologies on
command line, that would be great.
But there's not necessarily value in providing more flexibility than
could realistically be found in real
SBSA-compliant platforms.

I need to take the time to read through this series properly.

/
    Leif
