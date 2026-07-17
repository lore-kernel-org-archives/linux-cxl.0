Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FE3F507
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784247620; cv=none; b=s/twdJR2XKL0gFQlaq5TKmUMWcQLOHVBrmCChMO0pmbMKX14yg5Lyrr+iT3X5iaxmS66TSAbBnhEC37D27Dv5+I6+T5lkxCbffLqBr7TfBKSUqOyO7WCb7iJy2N4hTmZL3iUJh/j38ofQxnLVBAv0ojdtZ+/Lxq3LJ7fCBQFB50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784247620; c=relaxed/simple;
	bh=NMWxVa2O0pcZ7CXoIPYnrqJdQNRFng0555z8QlRrJ4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WwlyQCYeAGS0zR3dh8ci9HVISdoGv+8sHUg8WEtIqat3gQRWl0eLZA3uHOGTJmZrSp4xsV5uuNV0Yr45JXyk5jWbX60tLz6CJJ+7KNgNKNbrn7Gr7ddZk/s01BA8Tpp+zC6wwdl5D8f7r8/2jSZ8JOT0Ml8zaMU6m9kDEJrtXQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L+UJimOi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FnZRmepj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L+UJimOi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FnZRmepj"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GNJEfL4052388
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 00:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	STYZA1LnYQTfXAhvgUb7SwcUx9+N7av2siYHawu2deQ=; b=L+UJimOirvI4UX8N
	fMnQWaJnWdoIaUt62qHwO//4uA02oXHcUonCJMUIRtKI6115x1jdsFyTQ27bbkEK
	Yl8ND3mOQJ5H6w30nQNdRqsQuoHCcy60KXI9bF4GUg33zJMeDeSwM56nrLNXxYA7
	g4CAkL9i7kvAvPOU2nwiSdt6yH6gDy3hsDFwY6mF/lc3R3NQFaLMqAQ0mTbKsK42
	ibUnbpVCCKSW9eczxSWe8QSQrPZWPMzQcB5JOsK1cnFZBxahvWM4swN2YB6OdPcE
	H8VS0jYbLGgK3WZbcTByi/+Rss4T/v0PRMLcPCKl+3SFkbrNxlyQEY83QPe0FYrL
	2fsTfA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff1we9vkk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 00:20:18 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dbe39ce62so1287945a91.0
        for <linux-cxl@vger.kernel.org>; Thu, 16 Jul 2026 17:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784247618; x=1784852418; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=STYZA1LnYQTfXAhvgUb7SwcUx9+N7av2siYHawu2deQ=;
        b=FnZRmepjiClwNXLFamVnk+Ag2aoB4f14mFf7hezX8FKvzu7jLaiYVymYc2S0pJwUyK
         pCsoUnWvrbLAjDBjeIXwxv4Tq/3zpYe6AcUJy6Iccey5rGQ/aLyL2ln2ntLynG5wotf2
         R+Gezu5/wIeyL21RbLAOnvmFEpDN80XXlShiIyEt1Egx74FI3LUrPWeatDmgprRbdqXw
         ccuApT13vw/J2aHXWK65iPqkaWFQNsoW75TVy7tQal2rZ1Ag033VzkSL6BEJ9GVGCwBJ
         oHryMsGHTCqS7wUhaDqvPwF3/2X4ED6OySNIQhLJTGZINCGXS2MzOwVuyZ9qR4me5MdQ
         bvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784247618; x=1784852418;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=STYZA1LnYQTfXAhvgUb7SwcUx9+N7av2siYHawu2deQ=;
        b=KWfBYOvF3J/5d37/8xO++AmcalQiQzFN2VNVufPgQ6LVlWwzKIXVFRzHhMMn9bOeC2
         w/uqgD+zgRBzHp+MZjw0LoYa5pnDE4/tq7IqCxAkp+nZ73XYz9jPIxiLmcd+sUxG6f7o
         b93w5rt0XYoyhNpsWZQv+Vcewi/GLWAraVpODC6kJzH4Q2sk4G6sDGP+Ki478OxTkZ+U
         1DTthqFB+uYFmr75wg5aLHayLvYljnWe5BHxpelvOMnyPnBGAq6aa9bfBUY5SwsRqBPd
         lHvabrrFjxh0aUF3XeUE+hObdDh+GpG0ECk+wK6yOZDZ89sDCN0sZq3GeZo5zFVxCLZd
         PROQ==
X-Forwarded-Encrypted: i=1; AHgh+RrpIfQBHANIrNsLEcKL9Qbx3l/Thi+zKiA7dHP17wUWItwUCQ7QtW9NN91Jdp9Tt6jHrggdG7Zpnl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwicT3yNNDpM1/IdyjWNTKTTCaEHUWocXOG74/dh9/JRjKwj0cg
	h35VUGPd3VL1C8dImTmZ2hJEDvogY3vsGRMvaZQ9sV6utojYFUO+EdeBomPiuSVQwoHhjBrl1uL
	F78lF65fPGMrNsQUqVvxuOJ3WYzsMIxeJfpbKGQFACvb4QSUQ4frQNsExGtNeMb/76XDOdKw=
X-Gm-Gg: AfdE7ckvWycD2LBBCq8AACYYXY7IieamU9Zw1mnHhFCvk3+h+40166ufnwx8Jx5kVCN
	xfRq6QS27yV+x1g/eZ+lpMh+Y3FULJgIHQe8QLZm32nzXkfYcWCDe9zsczuOCsH8aYklEBemE5a
	BF5G7YGPBw1kH0tc3uofUSpvirRa2C1htlpS5ADryq/4BbTaQ9P2uA57fRuO3Kvmd31AqX3Ubpc
	K/No0I56KhkL9AnYhaJ+JiujQ0fZVbWLTrj+0eEKypw6o/yb25D41gLUSTl2AK65vW3iZiza1DS
	2B6QS5gkKTfAtzNO8ITgXff/iHlRvTtvGT5iV6sevUvWJrByKMxekJJEGkKHbLEzyF9U/sbND+k
	w3GN5Y682hY1URk8saic7xuEi8g==
X-Received: by 2002:a17:90b:4a10:b0:35f:bb17:39f with SMTP id 98e67ed59e1d1-38e3d133ff8mr5060879a91.1.1784247618207;
        Thu, 16 Jul 2026 17:20:18 -0700 (PDT)
X-Received: by 2002:a17:90b:4a10:b0:35f:bb17:39f with SMTP id 98e67ed59e1d1-38e3d133ff8mr5060858a91.1.1784247617738;
        Thu, 16 Jul 2026 17:20:17 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bbaf6sm495131eec.17.2026.07.16.17.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 17:20:17 -0700 (PDT)
Date: Thu, 16 Jul 2026 17:20:14 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
        linux-acpi@vger.kernel.org, rafael@kernel.org,
        Alejandro Lucero
 <alucerop@amd.com>
Subject: Re: [PATCH v2 1/1] acpi/hmat: preserve hmat_adist_nb notifier block
Message-ID: <20260716172014.0000299c@oss.qualcomm.com>
In-Reply-To: <4b146ef6-ffa1-4406-b625-85fe05ed4604@intel.com>
References: <20260716181114.35962-1-alejandro.lucero-palau@amd.com>
	<20260716181114.35962-2-alejandro.lucero-palau@amd.com>
	<4b146ef6-ffa1-4406-b625-85fe05ed4604@intel.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAwMSBTYWx0ZWRfX02JZN/NxS1Ih
 PGPSAOE2oNIVqZWtO5rKxuOX7OelcA3MwJGFU9wXMC0SD1Q+4D+AgQLS8r9HUE8A/IOoSotcSNQ
 Iof+a1z7WLLA/MjvvKm9LSzYjcZdinWyORvv647SiWD88VK/XTzuZGTWevzAhz9jPy5U4CuX1qo
 XpaxTXpQ3RpdolVbtGMUhtoiKZgHWRPZbJyICWeTwAwWXBh+qrJc16dezkR/NhaVWsq5Z83n3dx
 WKwOKTZ64vuLEqZESK/EcAP7A7tAG/As9iRlDKLZd9j0Vr5cs2m005B0mHKCUVjasHjHnWWHFx/
 Udyihsryc/SkJUJM6ZcmJjuZt/vPWz0cR2o79yewWGnTM83vD/qTjOlwhGcjw9twUEmvxdjjMD2
 1hYZ3tFl4JSdytWAIzy4z5c4R0rx7R2oH/ZTiqzNy6adpF62YUtYzP0XoBxigrwvRh+XO2xb46D
 jsUFRLeQuCvl7lrgdMQ==
X-Authority-Analysis: v=2.4 cv=JJ8LdcKb c=1 sm=1 tr=0 ts=6a597542 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=QyXUC8HyAAAA:8 a=zd2uoN0lAAAA:8 a=EUspDBNiAAAA:8 a=pp6aupvQFOZKKrBwpXYA:9
 a=CjuIK1q_8ugA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAwMSBTYWx0ZWRfX7yNsS9JFr034
 k74T9IrUo8V0didPIzGqHC/gflXsvNCIk8o6EU4uxKXSzN3iW4SV8kQJshfqQoL+MxT3pLDiJi4
 1zGZBV+AZyzii9/EKBbyWgPzQW0xFl4=
X-Proofpoint-ORIG-GUID: HNAqziBUqIf29RIiE_BlCa7PfJnKM-Tg
X-Proofpoint-GUID: HNAqziBUqIf29RIiE_BlCa7PfJnKM-Tg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170001

On Thu, 16 Jul 2026 13:27:56 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 7/16/26 11:11 AM, alejandro.lucero-palau@amd.com wrote:
> > From: Alejandro Lucero <alucerop@amd.com>
> > 
> > Remove __meminitdata from hmat_adist_nb declaration preserving it even
> > when CONFIG_MEMORY_HOTPLUG is not set. Otherwise further notifier
> > registrations using register_mt_adistance_algorithm() will find a
> > notifier chain likely corrupted.
> > 
> > This is the case when cxl_region_probe() calls
> > register_mt_adistance_algorithm() what can happen when CXL regions
> > are dynamically created at any time from Type3 device(s) or when a Type2
> > device is initialized at its driver probe.
> > 
> > Fixes: 3718c02dbd4c ("acpi, hmat: calculate abstract distance with HMAT")
> > 

This will trip some of the checker scripts that run on various trees.
No blank lines in a commit tag block. I guess who ever picks this up
can tidy that up though rather than needing a v2.

> > Signed-off-by: Alejandro Lucero <alucerop@amd.com>  
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Seems sensible to me.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> 
> 
> > ---
> >  drivers/acpi/numa/hmat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > index 9792dc394756..3006789ae31f 100644
> > --- a/drivers/acpi/numa/hmat.c
> > +++ b/drivers/acpi/numa/hmat.c
> > @@ -995,7 +995,7 @@ static int hmat_calculate_adistance(struct notifier_block *self,
> >  	return NOTIFY_STOP;
> >  }
> >  
> > -static struct notifier_block hmat_adist_nb __meminitdata = {
> > +static struct notifier_block hmat_adist_nb = {
> >  	.notifier_call = hmat_calculate_adistance,
> >  	.priority = 100,
> >  };  
> 
> 

