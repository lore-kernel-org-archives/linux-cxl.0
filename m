Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA92F7F1D
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 23:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783638197; cv=none; b=TLD1LJTlD8CUeQyIbirWoVCrnupgqsM/fF0sA2TGqD0WaPTFnchaXAE1by7gEW6br/ZlOp3mdeL3TeysleAY4UGwN7GBYFo1xTLz50OU0vu1KZygjYdB9KPgp8sAWAnD0bFBveBNseeOBa3uLt7u3WX+dLSgRLPhBs9GgvtPN2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783638197; c=relaxed/simple;
	bh=melRTksghF/8erkwu8aA44NkTQUG9wGQoKKZ0OKUX3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRSRcujWuRZHHU1kVT/sJNRthLjL6mljLi6X2Qcm8RqEXVTZqA6ZF+8/uHE1qBKKhUVY+NTV/SDCFY3L3nU1SHaAuHzLG5jCjhAPHZIbxpCiG6/pHE0SjBbFuzKvXHPfbL8Wns0JI9qrBlj1kC42WpW1x4uQgB3hzRqkUzsw0fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ltKsbNyQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TSH7fI3u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ltKsbNyQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TSH7fI3u"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669HXBXK2327965
	for <linux-cxl@vger.kernel.org>; Thu, 9 Jul 2026 23:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8eMfGOVP+cMvuKNjFhD4tj0PMF3X3yfxdgpmYgvAa2M=; b=ltKsbNyQOCAARRgy
	KIHpqBIbr/tAoMrCDnUeRgsb9dOZ/1Vj9K6Lelj1CL5ykmPBZrm3PaSCNuCakj6D
	GH1EO7I7U7n924RtkDKPSE7QUL/n4BQA/U7dmaNDceNC+AFcAVgN5EvC1jHhpWtb
	RkMkWRlJGtpeasWNLwWdSjKjp6ust6loj10uyP7Fm4D0jkeMKkpur2Dhfs2fJqbY
	t+drpnmSTFtTN4Zj2Pqe60622lc4N2ehkP76zk7q7lCKrFsZNCErk9CwPunBdP90
	Me7v6ZKm+1ZOku85vSre04FPBxexJmGb4DuC+mJ7ZrKqekvbKC76fOzBFgOthbzQ
	NFE+OA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24sjqa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Thu, 09 Jul 2026 23:03:15 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so215369a12.1
        for <linux-cxl@vger.kernel.org>; Thu, 09 Jul 2026 16:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783638194; x=1784242994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8eMfGOVP+cMvuKNjFhD4tj0PMF3X3yfxdgpmYgvAa2M=;
        b=TSH7fI3uQG1yOUfHAibQKbC18LGxTRBLDx8EjQfVgHqemmyBDgOXk5E/NKOcnHAcKA
         EAyHzRJBxO9P9C5gon6cQySumwoEzrFY2vSpiI1CZzWfSKsQk0YTIOxBqpJePjGh/qnO
         RKX3mKaPHwCtAOeuc1xzL0fgEeJ1IVwtZXeq49OmVH+jEVYwP88Y28wDOebtidTqlGeB
         zwaD6e54nOQNXw6+CY4iao3aGmRnw39FV25oXe4qJTHpqq2vI+jAXfANkJqVF81Ii6mk
         pJHbpZ3AbWV/sjZNQgWI+nOH8SFtxgtBb9maK1F/wKZ0GTXcFYRg+hJXXCbM1IbPhTyu
         RRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783638194; x=1784242994;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8eMfGOVP+cMvuKNjFhD4tj0PMF3X3yfxdgpmYgvAa2M=;
        b=Ds8uJ6TQvzfxx8b/Vwf/u/meiLEt2invht7FtGp+55+u9lEESpMHfI2nZyPkqI8QnV
         UEbftCQZJ1ObvJ9FSvihnTShJLbXooaCCZ7FPAXpAA7KTosvI5RKRwxGaxnHvANFdBFd
         IB44NiFjV3srJ4ZpQb6RJQBc0fVtOoUiMFKZ+8VbysUAiWICVp9MCTd/wUEJeuhl8397
         AZ+wsMUwFrBBRlnlOkX8JEe+Jxmy5kfMA5UyFWtU9wH6lN8u1IImhS7jfRKTCcyVNJ/S
         H93s9n+bNv8wtcB6qEnBJEN7LyqYvLuxQHZxrN/snIAk6xOiM1CB99EFovzF/YC/2Xf7
         ajZw==
X-Forwarded-Encrypted: i=1; AHgh+RpPP6nOBNlzRQMy0xJ/YqFCwYvrSTvbFJWo7TQTHxvDjg3mZCwYKjl43UMUBUOfQagWgjpRatkF7OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWjJfex2Mw0TZ6xg4xowGsIe8+G6zlC0hn38moBXXl89JJ4r2+
	6qB5wUZuTNlyxOf1aO7+f13t9RapWp0lAFAiUu1qCmZhUbq29T1LH0D4aVPz1gJd/cNo/41fj7p
	fHMyjJ9yJVa11mRPAjzhZW1hU/biGPlIjJdbn+zQj2h2rNyFLIDc7mWco0gf5kXI=
X-Gm-Gg: AfdE7cllJE+rGHX6LcjnMVHHOE9ecubuZkX1RrUTi4CjaTESAnTBnZnMhpwE5n4s+eU
	ZbmjPdYqOFCrADvaozI0KnHiN0hsg6d9nJuNcBHk+kWg26wPQ2sdVSgc8Riuak3HCstqieNnSxG
	3eV1t5dVg1+1oi3gY9ejzP89IoxqWcna+o0NhzSqC4LsSYr0JWqVDhKtrZlq5q+6hEnffiu1fpx
	+/ZOzDxVh/Riz+NPBg85YhE9IXXv+HsQVf/0qmmmVBMVRVhdy3+KhJNQqdhsisd7azo9QBF6XDE
	XBRCk978KqHZoL3/GN34GZ3WhgUiMlxPkGobxbJCaWml2mzU6+3dgxd65ySfXFzSHVjpHG4btj+
	wkdQk/GXo+jpagu58xQynKA==
X-Received: by 2002:a05:6a20:7288:b0:3b3:1c7b:ff7 with SMTP id adf61e73a8af0-3c0bd0fa250mr10349734637.46.1783638194404;
        Thu, 09 Jul 2026 16:03:14 -0700 (PDT)
X-Received: by 2002:a05:6a20:7288:b0:3b3:1c7b:ff7 with SMTP id adf61e73a8af0-3c0bd0fa250mr10349694637.46.1783638193944;
        Thu, 09 Jul 2026 16:03:13 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174892711sm35958607eec.13.2026.07.09.16.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 16:03:13 -0700 (PDT)
Date: Thu, 9 Jul 2026 16:03:03 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: alison.schofield@intel.com, dave.jiang@intel.com, jic23@kernel.org,
        nvdimm@lists.linux.dev, guoren@kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [ndctl PATCH v3 2/2] daxctl, util/sysfs: skip module
 probe-insert when driver is builtin or live
Message-ID: <20260709160303.000031bc@oss.qualcomm.com>
In-Reply-To: <20260618090653.8983-3-cp0613@linux.alibaba.com>
References: <20260618090653.8983-1-cp0613@linux.alibaba.com>
	<20260618090653.8983-3-cp0613@linux.alibaba.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Ew2iF9oVYGqFWwq2TOtaaYvlom_EGICG
X-Proofpoint-ORIG-GUID: Ew2iF9oVYGqFWwq2TOtaaYvlom_EGICG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDIzMCBTYWx0ZWRfX13KYdTNqqzcb
 buCK1mwJT28HE1aeehl2HaFnrFoTQbcsI71C00suCXUOHlV0EcmQdZ7qChpMApC09cYXZHQ115n
 /SdRNwm2VL1tFNlbx4wpYMImdlxSuQI=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a5028b3 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=SRrdq9N9AAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=C3rexAz7Qlc2DGwNamgA:9 a=CjuIK1q_8ugA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDIzMCBTYWx0ZWRfX/m9bHjVeeOwO
 EGAjxr9K3vq3+2So6U8snnFrHMlZMMHUFFoA5izealGAauYlx74XV1x07B/vJ418SX6Rh8wGJrr
 cHM8S7G+qg54P3O5UoKoJLCfxaslf3FTqZD4X/dQIxPjC++yDIrw+BNJeWyEBf/ArfqMWs+jK2x
 DiiMEy47ifBYybMy+mNYCaqbkmXTVtrWyFVOPaXxXcFCZVcVGI5nk2M2xJDwDQ/9CzPekBsO1NJ
 9GE8r8Wle4ftusRcG9Wz5b+j7ekmZ+aF8RpahsHxtD8vslbpIQoyEYJpSmopfyOhMPdc2WkZbG9
 2cdibewub7x27FvEMDSdF8oq5UGDK22CGPezvx6oiyKiCWdsgqRkaI4v6x7Ba5njSPEFoF4LFu2
 youoA2xXLzJIfbAmndSmUgO/sRcMJW/CYPgmW4N1HFJALdQoqg5pokBwoSRh3iUhA3xohUDTpqI
 RZVrpA8CLt17y4dKCbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090230

On Thu, 18 Jun 2026 17:06:53 +0800
Chen Pei <cp0613@linux.alibaba.com> wrote:

> kmod_module_probe_insert_module() is supposed to return 0 for builtin
> modules, but only when libkmod can locate the modules.builtin index. If
> the index is missing (e.g. a kernel built with the driver as builtin
> but installed without running modules_install), libkmod falls through
> to the real init_module() syscall and returns an error such as -ENOENT,
> producing a spurious "insert failure" even though the driver is already
> part of the running kernel.
> 
> Add a helper util_kmod_skip_probe_insert() that returns true when the
> module state is KMOD_MODULE_BUILTIN or KMOD_MODULE_LIVE. As an
> additional heuristic, treat KMOD_MODULE_COMING as builtin when
> /sys/module/<name>/ exists but the initstate file does not - this is
> the exact pattern libkmod's sysfs fallback emits for builtin drivers
> when the modules.builtin index is unavailable. The pattern mirrors the
> KMOD_MODULE_LIVE / KMOD_MODULE_BUILTIN check already used by ndctl's
> own test/core.c (see test/core.c:218-236).
> 
> The helper also returns the observed libkmod state via an out parameter
> so daxctl_insert_kmod_for_mode() can distinguish LIVE (retain the kmod
> reference in dev->module) from BUILTIN (drop it, since builtin drivers
> cannot be unloaded) without re-reading /sys/module/<name>/initstate.
> __util_bind() passes NULL since it does not need the state.
> 
> Reported-by: Jonathan Cameron <jic23@kernel.org>
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

I'm not set up to test this right now but fix looks good to me.
So a tentative
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
