Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20903F3269
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170898; cv=none; b=fw8DfA5sstE+fahzHrDhE61j7EkU+9HGCOnIVqL6KDPfPqnV/TyOziiMQpKwFpvIU0TeiOin8Yo/Kj9m/xFM79sTcCY5FYknV5vDUYIqL0UERVxF1qseQHbFnzNwv4joWbGHp7xm1mhGZihTVNh3VQdcVzy8AZOheoOPXdWAtOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170898; c=relaxed/simple;
	bh=7N89eJharAsSenXsTakiq707g0xTuq8cOHDBF4TYKgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioRJRsfJ9U/wqdLJ6DcvOfbC1sZ2Z37ZOu5zienEcrQ9KdbtSPjvMLM/V8ZgJIHTw/xajIz8PEemXA/rHAV0cf5Ba8IGYfZnJPyu8XKbX3M7tVqSfyotXyE+5igOnuTBdnUz/sVAcbEbMmiyi03G4Mnt9f7vttGN5DQ9QZ2YIQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T21z3hjL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bPI1ToCH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T21z3hjL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bPI1ToCH"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7xJFH4081741
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 10:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7zWdv7cUnYT3obPhLTChhJrjSEx1QVaS7ZcgFj3olUA=; b=T21z3hjLuCH10lmM
	Jsl2my6nerwUAcf/ZN3W6nqo6FEkYOcSsOd6fOqPM6+mIKMOXid89UG+l122ke6S
	Oj5Ky2Ir+5O+Xv9OVn4YmoEDctUZlOa5OqDdmhzu6zc7kF6a+Gq3NPZMp+IZhhI5
	fl0Dwmp2AnORx5buxox+lMywCFzl7cTHwi0SUZTB4RtOcscr7KBxCQtMjECBNkRg
	6jMz7++9PVJNfYXh3ZcaSu9uPmvBNt7WMu8CVTFe648qM6cq/E5njrJ3cxtkdEEB
	D7SkI1PCQcCk3/Khj30oqBbi5oewIwTiRDzXNqfuPxh25QnPQnSXWlQ0dWfGlGAZ
	jWPXbA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv8h24f1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 10:08:15 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52dcf1bb6e9so64015591cf.1
        for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 03:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788170895; x=1788775695; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7zWdv7cUnYT3obPhLTChhJrjSEx1QVaS7ZcgFj3olUA=;
        b=bPI1ToCHSQljFq6eHppB0rH7cLigV7EO9cQIBJJWTOd6MezIpzdu66scYQWBarOzCw
         pgF5VgOWlznkJW7/uN3xIn+Nju/XRGknA+3Tj5kbLRCWyVqmOHUFoYEB17t/CuZEF0cY
         DGarslAC896Lm0QjCZMHqiEw9xUP2NadkiymJRZ35DivTcrlGydB5cos21j6wZ0Cha9T
         pBa2BWWZq5SGHaLZFv/1aIQlAjjQcOgdcxQcqgyw9duu6dtJZXmuGKjOWLfw8OVbfEuV
         vJEf08dlzvlAMaSAu7SNppzEquPIC4Kuq8izw94KvTv62gFpvu3OxclkRymJAt9YLkmc
         u96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788170895; x=1788775695;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7zWdv7cUnYT3obPhLTChhJrjSEx1QVaS7ZcgFj3olUA=;
        b=Stj1WlHl6af0766SpilTes7/5UJLpRk/PbFiwT7bWhz1vrq2n0TDRXp1M/+7a1WZYb
         voxWziatlo+b40C8lC0BKNfunzvxeK7z0HYuD97G2WoB+WpTiqGFBZ58d1RQl6giTnRe
         FFTzKSXCvpV7E5Y2Us+cp0zcCljLncCZsUmuzC/T5UYxeGWswnxt34gGkQE/Pv3fUhv0
         wZmNVwEjFGBkE6+n9uffS7llWO+BIofi0azm0v+FqSZQUaLbrW6Uge1VHVZ8luqnI6RK
         EHBdN4u9mR6a8HAN15yMjAJYaSwtYwAEVm0VRhBw/4I/4EcNXWtJzsbv18kS+o0Msi29
         bMXA==
X-Forwarded-Encrypted: i=1; AHgh+RqRiwW1LCzDVhxfpz4P347Mf+u088AZAPxr/lAlPcS5y/353aihTO5JJi/LNSwIRE0gG3YEI9P0kqA=@vger.kernel.org
X-Gm-Message-State: AFuF++koY32suwUNapAiiKbvU6tGxWcpr+0H9pSiyNvw0ggcRxaDni9y
	iAwtdoROQ+JGzIEDrSsJDuWfGrAey5T95zk8nPb/rw1M+EAouBHFmO/mpo5HFWAY3PUOClIDMbo
	xwCa/75uVFWp0RMJY7gUdZNf1ulWq+FtixYhmZKIOq+DaSfGrta8QvY0kG0FwwgZNO+jfIDA=
X-Gm-Gg: AR+sD12DMbIzVbO+biD3DcpxlpcftgX/QEOsA65agkhCT4VlwBuhi9UOxYFl70XGYiY
	BbVb4TEEXLFvwfxUOdnTJTLYG63nwpxzB5O2/MqMngv9o56MK+KXy0kCpksqDM6V08q6JdCuV9D
	sbnZXZJV/3a3kwOHKiS3QOuoVKhfDgPF4ZpKJaUwRz3gkPyKfizS5q3N79bhWGtUDikKv1YjAWP
	921J/+DYdWJWwBImGzwWod0uNuVEWT0e2RqrFnEG5+170qY+6wGQd3Bxylv6LarD+bNk15YwWD9
	ddp8eYOKU6UkOyT2nZZMP9iNMIi4AfJq32RC1s8ttmZY/RPMUF9ULVvhB/8d142ZxsmuRk+aGMW
	xouT7T+hfkOvAJ5WjqvFU9Wp6MyHu3xN09A==
X-Received: by 2002:a05:620a:1787:b0:939:957:ed2a with SMTP id af79cd13be357-93936cca294mr647647685a.15.1788170894740;
        Mon, 31 Aug 2026 03:08:14 -0700 (PDT)
X-Received: by 2002:a05:620a:1787:b0:939:957:ed2a with SMTP id af79cd13be357-93936cca294mr647643885a.15.1788170894321;
        Mon, 31 Aug 2026 03:08:14 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb2794dsm22589235f8f.25.2026.08.31.03.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 03:08:06 -0700 (PDT)
Message-ID: <7907e4e8-6c1b-41a1-929c-8e680bd2992f@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 12:08:04 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] hw/cxl: add cxl_destroy_mailbox_t3() as the
 mailbox teardown counterpart
Content-Language: en-US
To: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org
Cc: jic23@kernel.org, linux-cxl@vger.kernel.org, qemu-stable@nongnu.org
References: <20260729144645.1552511-1-junjie.cao@intel.com>
 <20260729144645.1552511-5-junjie.cao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260729144645.1552511-5-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DY0nbPtW c=1 sm=1 tr=0 ts=6a95528f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=lJrOWJkMPCPpVJRVPmIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4NyBTYWx0ZWRfXxjOfqbGyFNhr
 thLiePJkqToc2ACrzdadKpYrYgGGLgWDSw7hTI+WTOsA4O6sGvwi6CoGfCwciYYjOQMkLaEXD62
 nHfGclKQHwT9EpWfdm8VzEMFv26awuXhQtP07d0CjwT/AG3enTncajXfyC8bmCWxiBak+0LkACY
 wb8b6HtHs8YIIfyUCsL9YXhTKhV3JcI/krT9RiFoD0p/vIUbqCPphrYSa/IZOpvUcrIweRdjYMm
 1rPTwPpeHWpTS1XuFI4OZSjT1GePuTXkrgdOPS2zSWtnp7PJ/z88Uv/XMS8VGn7ngZbKenvjvB1
 6wZSnBMCRAy40SJIeRUIZ1w7cPiNLrRVWSNVrpgYhkFBzRB6Gn4BZfjWHc9L3QoJ1qPF9C7twmi
 SQwQ+aOLSmGpEirv2PZv16gGxsJezNYr3iKpRSmWpYvBICFqP3K1tcYZhVzzMbyDkjB6TxE/A4X
 l3wCT29CInyCJwe5o3w==
X-Proofpoint-ORIG-GUID: NlEWBnnpx42hjQh_BoNBxtkOXvTxDLqJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4NyBTYWx0ZWRfXxr9TZJ1itrmw
 geyrSUsDIJG2bV+NvuqFdH+SYTBskEb5oAu6lYtHFjCjhXj8nc1h7QKAx/MNCLQnt2uHWqK4EEu
 hYT5EJJe9H3iwWWozxEqEzJ5d6fYRPY=
X-Proofpoint-GUID: NlEWBnnpx42hjQh_BoNBxtkOXvTxDLqJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310087

On 29/7/26 16:46, Junjie Cao wrote:
> The primary CCI teardown is open-coded, guarded by .initialized, at
> the two places that need it: the reset path (before
> cxl_device_register_init_t3() brings the mailbox back up) and
> ct3_exit().
> 
> Factor it into cxl_destroy_mailbox_t3(), the teardown counterpart of
> cxl_initialize_mailbox_t3(), keeping the .initialized guard inside the
> helper: the primary CCI is only brought up from the reset path, so the
> first reset after realize and an unrealize before any reset must both
> skip the teardown.
> 
> No functional change.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>   hw/cxl/cxl-mailbox-utils.c  | 7 +++++++
>   hw/mem/cxl_type3.c          | 8 ++------
>   include/hw/cxl/cxl_device.h | 1 +
>   3 files changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
