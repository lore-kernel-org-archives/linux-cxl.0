Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF5923A562
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 05:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932746; cv=none; b=rzf7b+s6BD4xg58R1lPeNLyt8dlr59YrsjxBunxdCngS+4Lmcoo4Cy3dE1AqIYblJ/9641hsujZCADsDnfd9de33HoEgsf/nj3q9XOltpk4K1N4ZtoGFo+TWIzMLqJFj7bXslAUzPNrqQBclwOwiIKhbmqH0yAvMpZmGx+9IXxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932746; c=relaxed/simple;
	bh=blw9zUD71STj1oJv7SulCS0PN75vKi2woeDxoUhfg94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4FmftbHxHYkaA5pGA7ymKrJo5itQzn6lbDYtPgrrLooIkO6nLcleodMm4H5bd5qKmHNQBnjXTaNJd2kRba5lttQLpEVy+zJe5r4ZdeLKAQyALFahopkWwNT4xgNHVVCkgqsMXO+XKlnaPSgZ7iDhKGmlrhX/Ai6/3zgWylHR98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRzWW8FT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRzWW8FT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788932743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CnETwSEWzByRDrmJZmZTyAdrkNKGi9pl8hfhdZ4YH0M=;
	b=PRzWW8FToSxn3fwrvSBeJxA/OvHlq4/ckVs9FZoHfTxgmTzU4vpAvXzugS1Ypn65UnzPtx
	aQA1zGz2kV243h7cLBGoEfj5xbtV34xmUgoz2Gf0Tw6Wasvs4kMjnz8KrRPcbY8YZTuliP
	NmfySa/dXHWHHO2XrKrSovQikKpeUZI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-nnPHUTBaM2awIrXOvRHCww-1; Wed, 09 Sep 2026 01:45:42 -0400
X-MC-Unique: nnPHUTBaM2awIrXOvRHCww-1
X-Mimecast-MFC-AGG-ID: nnPHUTBaM2awIrXOvRHCww_1788932741
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48439eea716so3674896f8f.2
        for <linux-cxl@vger.kernel.org>; Tue, 08 Sep 2026 22:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788932741; x=1789537541;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CnETwSEWzByRDrmJZmZTyAdrkNKGi9pl8hfhdZ4YH0M=;
        b=oxtZjXa0fPyjAIb86tiUpt7OhPOnAao05T4sa4ytWOjMzgia/26Wq/uAfdXVBE4AZ1
         ggtGZgAApWbRZLRn0WfudgZkTbON3wQxt0dfqDsYnfX0cc0YCflnM2NBttJzxtQvUjNk
         Yos/6toqt4d/CWG9cybMTKpv8oq3M3hNCbUR8e+tOuMeAXh8leZwJuFAUn2znzsa23t7
         IQSanW/veLxRcduB2SnD0b1/l8I8SdoZ3vCg33pTPjgvA3emWA+Kj3qOV7EL/9Fqqopk
         HuDs/bBqPNBmUzikI5ZtcQFue/B45OM53SSHddyFdMl5nUW8ipIQnE8v8D+IpM+ZcbDg
         Lxrw==
X-Forwarded-Encrypted: i=1; AKwUvBw+rDMrhi4LSdvhlMn1k18JPxzeRE6fMNvuPmUtyOl36N42UPPpU6wM/a3pB26uRhdzJ+HjOIqH424=@vger.kernel.org
X-Gm-Message-State: AFuF++khI9j0kJN/dY6rbJS0SOsQ7dA3UmruSWDxrfbOrBks2syDm+ZD
	rzh6TGBmAXPE/lyAmjJ4nPMhEvI2NAG4aF9553xyQ3h46NWygb1oFj6etRIX138NC297Xe7lJIh
	dZ2pH2fz/yku9lwWWTsbfESluY9YiPEjgP+sHA9cxle2HYDIf++BNQHpst3AWZg==
X-Gm-Gg: AYBFou16bWVqEj0txWmmyBsURN49eBpefG9dE/t3t1tVU/p6oqjG9bMXgpkyOLTJqsD
	mLiDg4yMtckoa1bEBZnSM/mFm9ms7VHUJEE1Gz2jloqj5eU4oiI76ZF4nPHrLtO9/+yJGuhr4Pu
	FUslu+x0xs8EJ27aWJ4PsF2ZqKe51jo/61WDUxlMuWhtEGrv+1NAuZ60wRCD/V93iD0IY+DYRTX
	GM4kP9FJMYu/YFYAz3Trpj+a2gcTVFT+P8HaFoYzY+8rn4vIfqo1LaTxpDruyJVsI+sV7b0RJMu
	to4fvTTypdJkzMqbk7mDgae1ds2TRBa9gEorJT2rO31GhuVtL2bXXFD+jK0WuEsXCDuNdL3gbTi
	5N9zQ5o8BPvBCU7MU5YULgGrbjjlWBcnR3aMBGfnEMA==
X-Received: by 2002:a5d:6f13:0:b0:485:ac96:7265 with SMTP id ffacd0b85a97d-485ac96737bmr1903852f8f.10.1788932741157;
        Tue, 08 Sep 2026 22:45:41 -0700 (PDT)
X-Received: by 2002:a5d:6f13:0:b0:485:ac96:7265 with SMTP id ffacd0b85a97d-485ac96737bmr1903820f8f.10.1788932740798;
        Tue, 08 Sep 2026 22:45:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232? ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859207c28fsm36167376f8f.5.2026.09.08.22.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 22:45:40 -0700 (PDT)
Message-ID: <0bab1434-c36b-49e4-b902-b446b8be9617@redhat.com>
Date: Wed, 9 Sep 2026 07:45:38 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] qapi: convert simple enum intros for vfio.json
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>, Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Hanna Reitz <hreitz@redhat.com>,
 linux-cxl@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>
References: <20260909041640.69080-1-jsnow@redhat.com>
 <20260909041640.69080-2-jsnow@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260909041640.69080-2-jsnow@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0rMkAs3_8pq8I5h1HtC7HYxRWVmRxqNGdn7vTVekLwU_1788932741
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/9/26 06:16, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/vfio.json | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/qapi/vfio.json b/qapi/vfio.json
> index 3d61fc38ecd..47fff8b979d 100644
> --- a/qapi/vfio.json
> +++ b/qapi/vfio.json
> @@ -10,14 +10,13 @@
>   
>   ##
>   # @QapiVfioMigrationState:
> -#
> -# An enumeration of the VFIO device migration states.  In addition to
> -# the regular states, there are prepare states (with 'prepare' suffix)
> -# which indicate that the device is just about to transition to the
> -# corresponding state.  Note that seeing a prepare state for state X
> -# doesn't guarantee that the next state will be X, as the state
> -# transition can fail and the device may transition to a different
> -# state instead.
> +#     An enumeration of the VFIO device migration states.  In addition
> +#     to the regular states, there are prepare states (with 'prepare'
> +#     suffix) which indicate that the device is just about to
> +#     transition to the corresponding state.  Note that seeing a
> +#     prepare state for state X doesn't guarantee that the next state
> +#     will be X, as the state transition can fail and the device may
> +#     transition to a different state instead.
>   #
>   # @stop: The device is stopped.
>   #

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

