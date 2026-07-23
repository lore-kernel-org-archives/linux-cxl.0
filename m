Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC72342A96
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 06:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784786602; cv=none; b=k9eWZ3xRAJWCMhRuKoLTNz8lC3U1RVdePPs07VBcMulfLr1bWQhR8DdmNc/imINbvkCqKeBSNWaZpeCM0dcG8RezMhMIHXCVNi/zkwWWPRuqmB8MrQwNFrORe7KT+4drl6+bPu+I8TLeWuM16bHfJ4QROdlo8quqbhBJLL1MreQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784786602; c=relaxed/simple;
	bh=shsfgmxG7zwr1EMRRcctsmHlV7OruFQUx3Gmyu2NR3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/QQMh87dPZnEAQIo8IjUaCTl2/kLn1kL3574GTsdyuq1O5AO54y4+bl7lCxwRCQrlhForitbtDk3HiWh6q4NUP4sWlNJNJLZEai2wMBQejyeGe0H8UP4WZ1a3OwrzmmXSNpO17xJFQO+KajuZbo1kylWlaU9lx1Ns47VxRQf6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fxZByc1b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J2Z8xYcc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fxZByc1b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J2Z8xYcc"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N4vPWA4120623
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 06:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5dIfXP4k7T0w/N6bzOXXDpCcB1UHw3MNkwDqEd9a3VI=; b=fxZByc1byi04YA+D
	129sKkwvYJwuMkEmUqicYka3ATZNeX6oqrWyNDkzqLXfSKHdv+rixrtUNRpx9NEk
	zvf/MsbfeE+A0GdIIX6MkB2dJa7UZNYUt3U8X+5bmOkDz3Dc6rLt1duQZ6wCA8iu
	Hki++YLnxNJIvfI0Jld3uZftgX5wk1c/z5QYaQXIV48yBi9sc0A6Jr8uhIFi+2FX
	NujOIOKCVfG9ow1gfCrA6eM64ZqC4RmpPcbpP0BGvAYYYjNrZXXUJcXtQ8DXjIAZ
	VeGWoYUzKVZl2aumr0wLUMUT1wcgt2/eS/II5iPNvw1M6M2BBcilbRCiCThh0LWe
	3NhrPg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk28xth3c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 06:03:20 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51ebdfceddcso6515431cf.3
        for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 23:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784786599; x=1785391399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5dIfXP4k7T0w/N6bzOXXDpCcB1UHw3MNkwDqEd9a3VI=;
        b=J2Z8xYcck/nMCM8VanGA0qYKGb0+nHL6r31fiIzuTeYxI79rS7r9NeEGjHJpkVM8NW
         A7isGT7cHiv3ARh/CC42BDf4Tlut2wU2/WzpQ8lHoEzfwK7JKRQ8g/EBV7J24LVtLdBU
         pBkWBC4LWhjVXHr+sh3wODC/p5lJd/Niyeck11Cj9gRNOtonq0RFYZkrIbrG6S2DTgWO
         +pbg6qh9pecZXS8Pxwzz7CSlJfHD4ZJBjr16fDAfwwjWbsaOUBtwAGacWEwJTWh88FFP
         xnzqPqMBUgiyrWO7DamioQWPCze3TV4rC7F8LQ+Qe0fzZtYeFYLvwoe8H9WYXUsmWkLi
         8XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784786599; x=1785391399;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5dIfXP4k7T0w/N6bzOXXDpCcB1UHw3MNkwDqEd9a3VI=;
        b=PoLakNX+5aBDiOYG/5AsOIuVRzGS3AhQfII2ABepyrakzQAfGMbu4hNcj07Teymivs
         P950ZcLUdQV/h2J9OYaoV/n8aciRloZypg94PXszGp9FFB8Bqbc80vfp1Bt/JJxlr/Ho
         VtYsNA+1Q7ZrnefgNON7dh/u2D2qPy12GWaYbqxbnzWjXpW8hKKzbXD5T7NKCgHzMcGB
         B2OpTe0h4QrKBSrPumEkuUTWkohTlJ/qCZM2NQ/tG//XRM7jz2a3ohXdRPaSobmAY1Wy
         wRnJ0ZwusljLDPuUsxfnZRHaBrUAAY+hYZjtdGYRqU64lsw0Cyl5FV9lKBPaKdJRRL1l
         rhxQ==
X-Forwarded-Encrypted: i=1; AHgh+RoaiMRhRFNHBOfqswylUOkyYm5uQsvOTMWp7CAvsFtTuKTUc/xjiYTnWajs6LsuFKu0F1PjUBtYt4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU9aHGbynIzNWw3Ty83ymXKTbG3n5dDV2rC6qPXktLs+sXnWzu
	AvkeZYXW+LtCd/Hfc9C6IzjeDE+v+HinQzD4dtP0AynbGGrYeX92zfriZ8hnfcWLeYzfFODD04J
	H9I+iTHol9fEIySq9IXL7PtpXUPEdKa6W9bzBhNcB3fyy8zYUf4zZhTPvTMYL2oU=
X-Gm-Gg: AR+sD10aMAMS5KwU+9/lmAOTVdIR7WOgygViQdXIZZg2fVj4DabdfgYbv4N8QW4BJ88
	H2qEZD2bkkhz1mjSdWu8LhZbpTGutmZT2MCDw6JgwcnxPvUnfGksUgSWzwB4L7tfzdwcW/qQpn0
	HT9bmcDv9s+vlLV52Mj4udS9FiE9w6xlbNJMybnhQ2hYMxk2R2VFXyJDQpjk5lPbHQQtiJDF0EH
	S4BK5Prn4H1tiQmX09i4t0yVWF+n3Q7971mifps6mWKktXtwWInAFeIlOQGawGiktmDPivb+q4n
	YYjaNSv51I6FNxK5emm4yo5iTp/naLf10LUosylqn4iemL6LLmQVQvN1FG/g+t8xwtZxn8azTVp
	OywlfNU1AkBd5wXJOqEl6oH8n35Ftc17Esz6ObZ4kr3IQjW8IutA=
X-Received: by 2002:a05:622a:8c:b0:51c:db4:3cb2 with SMTP id d75a77b69052e-5283df63187mr14764291cf.63.1784786598962;
        Wed, 22 Jul 2026 23:03:18 -0700 (PDT)
X-Received: by 2002:a05:622a:8c:b0:51c:db4:3cb2 with SMTP id d75a77b69052e-5283df63187mr14764091cf.63.1784786598447;
        Wed, 22 Jul 2026 23:03:18 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a508aa6sm126057685e9.7.2026.07.22.23.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 23:03:17 -0700 (PDT)
Message-ID: <d30675f5-4719-4622-8a2d-c50ff0d27eb7@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 08:03:16 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] hw/cxl: convert cxl-type3 to three-phase reset
Content-Language: en-US
To: Junjie Cao <junjie.cao@intel.com>, Jonathan Cameron <jic23@kernel.org>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, qemu-stable@nongnu.org
References: <20260723011625.1117034-1-junjie.cao@intel.com>
 <20260723011625.1117034-4-junjie.cao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723011625.1117034-4-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SNikWn5PVX8o4x8sidXQwvzYquOEY2-x
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA1OSBTYWx0ZWRfX+c0UWA5hWhva
 SKqBh2yA0OdAkOLdHSnwelqKhri9uR66KHsQ9VwyJDTB/FOqDzhzViCP4VmIB6EAR2OdjNxY3Kf
 c4oNZ81RgNnSr9Rh3vI9YXlMIWFksyw=
X-Proofpoint-GUID: SNikWn5PVX8o4x8sidXQwvzYquOEY2-x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA1OSBTYWx0ZWRfXxsyxAKjOwU3C
 8TO/DaJCNh0dF1w6AjysaAstPWHwhuuWmEQXH8amtwkKm9db2RebyUNKxgqMFyl2i74U0oSNvJ7
 cL8IFEgcN5xS3DoyMC5q+FP6r0BXNUkR0mQwFZuVM6kSY3OsBbRTbfm5l28f7Mt9NwjgEzOu+11
 6yGJJju5A52kNhtJkOKQhqzXaW0adT2c11Qqeo/dgLMw9lFYJi8PZwYo1JwID8OZWoiPHT8O9uJ
 exVdSHGXzAJ5UyreCKMoQEdVFkFCYgI2qPsg3n7EoGPF0zZ5PKT6+vBzIXVbaqqTJyZJBaDm7Ne
 UjT9zRK95g5+mKiNLesgx6OHSRQT+lq8XgCA9nw6hq0nQMIFWgE0ovo16qCkbSkKeBq08FYKey4
 e2EP864Mw7LgMsPQPL/dMmNMZ9Ae+5zEr/81ZeCTpNZ6zI4hGvFtb2eaXBcavA8Fh6xxQcoWFEP
 2WGO32EOrg9muFi+cDw==
X-Authority-Analysis: v=2.4 cv=WNxPmHsR c=1 sm=1 tr=0 ts=6a61aea8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=9aJME8LnsKA-8nNKvUIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230059

On 23/7/26 03:16, Junjie Cao wrote:
> Replace the deprecated device_class_set_legacy_reset() registration
> with the three-phase resettable interface, following the pattern
> already established by the CXL root port (cxl_rp_reset_hold).
> 
> Only the hold phase is needed; enter and exit are left NULL.  The
> parent hold phase is chained for correctness: TYPE_PCI_DEVICE installs
> no hold phase today, so parent_phases.hold is currently NULL and the
> chained call is a no-op, but capturing and invoking it is the correct
> forward-compatible pattern and mirrors cxl_rp_reset_hold().
> 
> No functional change — the reset body is identical; only the
> registration path and function signature change.
> 
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>   hw/mem/cxl_type3.c          | 16 ++++++++++++----
>   include/hw/cxl/cxl_device.h |  2 ++
>   2 files changed, 14 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
