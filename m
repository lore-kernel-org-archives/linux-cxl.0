Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387A499F24
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788185274; cv=none; b=UMFk8bJX9n/sOe8nJWv2jHnB7v3LWTuw0JNygPYP0mj5qOzBWxbkGewb0rKxJ6mmoIHhDQBg6YOUPTXECI+dKr7ACIzLSmVwpgdtTLb0uojKhQ3rXl5xyA43W3u15yoR3BpEP/FsOOJ4aA3EiBMT3OPbGQdDpvnnuz6T8PxDnGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788185274; c=relaxed/simple;
	bh=u1BAQ3FAEvU2JGSTuxjTM+PckZ2nrw+iI0nrk7y7Ruc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKxcKzOI1F5shOJKTBWthB5XJzwNuOej9Nngwvl9+qD6H41nbMjCftxV+vPjwf1oTfA6p/aNreNY1GJORE8OHbJi/6GnCeh0TyA+TnOglNhPdXdyLmfrxDNOmllD9k0ucZ/KzSZYuEzqsB0c1EnLbtwubut/EtZ7igjC2Hcd97w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3S2if29; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3S2if29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788185271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zw6an/2EhhJ5W4wnSO5Y4YLVwQ7GrB0FsgM2E6YvV0o=;
	b=X3S2if296WWlYY7cFbv0dSSIvDg6Rhs+ZMp8vGBHJOJKBaFOYfq7y9WBn5sZx8NK87u/kk
	j83ib33mcm/CtSOl6xe+XuV+Ft1c0G89NGzlZn6PNi0X/YSBgfpRYgeBijuIxCwwvMxzwj
	sMBHTAmxGdrGAqu7QbJvG9Z8XIGb4Tk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-g8JLtvpjNcOIHhwrVmGSHg-1; Mon, 31 Aug 2026 10:07:50 -0400
X-MC-Unique: g8JLtvpjNcOIHhwrVmGSHg-1
X-Mimecast-MFC-AGG-ID: g8JLtvpjNcOIHhwrVmGSHg_1788185269
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15f4732dfaso315754866b.3
        for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 07:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788185269; x=1788790069;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zw6an/2EhhJ5W4wnSO5Y4YLVwQ7GrB0FsgM2E6YvV0o=;
        b=n1UNR/rBCw1LFDqNB5KYr4tIzIeC0t80PQZ5X4ij+Tqn/C8k8uTXcZWd0JtBH/NC1O
         xJtcihAR8knkozjkwYzbC27ds0mOEXcEcesm2FRjMricgQmhtHFtL7b9TXAXldVYamye
         x+aOECgfil7bEwOquC4LYvzRCLRHrViZuSEoYcOZZXXztjhyhAinIgmYjQXuOU3Xf9WK
         Qu1NtUkUlhqBQDOVX2J6Pf6xWpOyEtZ+pR6dMKftlkBZeQSvd+Dmpws5JjMVk83JOU91
         MV0n+DnewW+Js8XaeBNOAtA1GfVq3V0H/qfcyoM0tznzj2IS5wgjYXcioljI8c2NTnkU
         v/ag==
X-Forwarded-Encrypted: i=1; AHgh+RqwJzyPA1RNRCp+vBtbYQxzbTcE+zRFh2SjmagnmSZ1lK8kSjXchH0N04H9Hju/9qgkLEyuhblfx0Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lVgkWUWHAt5hVXLGeYng8zQwvVhwWKt6Hksl5rXcZQXbV5sten
	kuibq1l2puydb+bvd3WsgUqnnq8ekhg6XY2kwJIsrQPP8KsW8MOjL/I2dLOlnjSrYu84T7SM2rm
	im85OOQX4qQZ3lZPB2ih/WTUFg4csSEi184gPTiGUEYTCovUWLpiLgJJKS3rLpQ==
X-Gm-Gg: AR+sD108qQbA2Y2xZiNDXJ4TvQJdxkwkB5imXWa+Jg10Xl2YBe4ixjm/rg9Yqg194W6
	Y0y4BApoVh+qwz6PGcvVRpTI+PUjVHKjZlbBRf/BXZ+EXu6NrO9x1HreWMf8Lh+WYBHGh7kO+nZ
	X3qNh+BBSmXaVDoEBuuMgYn8ewoDXpn85EpDZlbM2mIY22JEeSguihCo1qAZnbfSMMpVmuiBZ/r
	iWfMR0zpBGOQ68meHLM8ds+1kGIKZBbqzgIYI7x2nfqMbDtk/B1KfNb/qvHwvtvp2NtnzYUM2FQ
	6hE2FDWaz5Vv5Qc5NcbTG8sI67Bd/tdh1bmnt26ZTtX+COzudBOeYv3Qmqf518fiW9K5wKuYLF5
	XG6BTxZAuBMXtQ6BlAqKuPO5EqoXPKjBpzqfbyCg=
X-Received: by 2002:a17:907:97c4:b0:c25:6e17:9b4 with SMTP id a640c23a62f3a-c256e170a28mr1236351066b.24.1788185269255;
        Mon, 31 Aug 2026 07:07:49 -0700 (PDT)
X-Received: by 2002:a17:907:97c4:b0:c25:6e17:9b4 with SMTP id a640c23a62f3a-c256e170a28mr1236346666b.24.1788185268714;
        Mon, 31 Aug 2026 07:07:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4? ([2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee09f4dsm466979166b.6.2026.08.31.07.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 07:07:47 -0700 (PDT)
Message-ID: <fadc5ecd-f939-4258-841a-e80f488c080e@redhat.com>
Date: Mon, 31 Aug 2026 16:07:44 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/43] qapi: convert trivial intro sections for
 vfio.json
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 linux-cxl@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiri Pirko <jiri@resnulli.us>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, linux-edac@vger.kernel.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Lukas Straub <lukasstraub2@web.de>
References: <20260826193840.2152000-1-jsnow@redhat.com>
 <20260826193840.2152000-6-jsnow@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260826193840.2152000-6-jsnow@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VJb7naEZD5JDYpjEdf7I-WM81j0EpARQG0j7qSlBUJA_1788185269
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/26/26 21:38, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/vfio.json | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi/vfio.json b/qapi/vfio.json
> index 17b60468712..3d61fc38ecd 100644
> --- a/qapi/vfio.json
> +++ b/qapi/vfio.json
> @@ -49,8 +49,8 @@
>   
>   ##
>   # @VFIO_MIGRATION:
> -#
> -# This event is emitted when a VFIO device migration state is changed.
> +#     This event is emitted when a VFIO device migration state is
> +#     changed.
>   #
>   # @device-id: The device's id, if it has one.
>   #

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

