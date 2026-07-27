Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86A93F5BFC
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154737; cv=none; b=WTeaT1epJw+1q86Dpev8mUsvuzBxCjHoaLU/oILDUe3tPCA09CgT0SiVPe7EBcuhIAYoGedeycdTMTYddR4FJXN9n/7vyEgyD0ItK6zPix7MZg8ZMBbgDWLrYUOfxy2789MA+QK0k4p+OlA1vXxXDTv8H5PEbIs6EYmcGsf/Ibk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154737; c=relaxed/simple;
	bh=qwk80AisqTMy0iYs4QukeX072/7dtVnb8chN7LgZcqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJAXnVUjCK+877+4zqhWd0k0zkuE/nPx+mnneUBm125povseTdjn+kUDU5h1/a2yOO50+NrKWPICD+KdJxPeSdJAy00snkwnjJ4AM4SvDRtgPF+MYg9MsrrXHGXHC6OPrt/by+n4pK33b8Q2EImn61KB99PXNclBYFN0Gyme6Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEm8+oO7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEm8+oO7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785154734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5dKeWNXTVrL85tSrPucpBv2NSFt9uxptmhhn9V0Ke0=;
	b=XEm8+oO7AVncKeEfSBHC0NSp/l6PAWJqgNFKTRe5xNe1shKvB5B2ksdSJL5vgKpGrT/TJG
	kokTwU7IfgDn5zHrdhChtsNW2nWOirTRi24eVyXTZkSIGfCsd6OAmOKThvvnjefktS5HMo
	ad5LotK2J7uKl8DRvj8ov4SAAcWZmsg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-PCTNl3h9N5ylvhz4NWXA_w-1; Mon, 27 Jul 2026 08:18:53 -0400
X-MC-Unique: PCTNl3h9N5ylvhz4NWXA_w-1
X-Mimecast-MFC-AGG-ID: PCTNl3h9N5ylvhz4NWXA_w_1785154732
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4954fd771baso24071255e9.0
        for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 05:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785154732; x=1785759532;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L5dKeWNXTVrL85tSrPucpBv2NSFt9uxptmhhn9V0Ke0=;
        b=XzTgx/Jdj5lj3kucjUJz60pUBzzYIxe8qInerq74Wswnr3wNpxHikEyp67V0EJZT/l
         qzsYEtPGXsuerlEbv7GxcgZcGO1rA4lkvbKfJp+UUYQAjQOUH7h9BdI1RRqjqQYrUDj+
         9T2Q2HmiYjMWupA95Dm1dYK+XZInUqh36EZK8/oJrYeEJjU70xr4YH0dOnvTdTEHZmyX
         gMfJI30ECH+XYDyYt2+gimOBz0e2McSgoM99kLHz1HEyeMiofs2OmAovCEHvnxZ0s1k+
         IP7vmEnx/LOaOweQVrZNIaTQgBLmpxVUlf1h8zJ0J07av0/hqK01eg03/BoiE23WSolg
         x+FA==
X-Forwarded-Encrypted: i=1; AHgh+RqKuqTCeMlQzAKj1+AehYir3tqPlNt0OtM72sWbusT2qI62xwrtpFq/KI7yd+NGe/qqdemCV+jIzoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZgmvjV5ZEUe7giYkALEjhg0xj/LE1n7iySrChnYtXisi06zS+
	B2BjZ0JwrzsEnrKPvOoAWFNdBc9ArxzevWZ6/mbXzHUg2vUjp4Q116QGQFOPZUoTiynTu5KrNNv
	WNryqmYuvbX1U5AOhPD4uvMVWX21XKKoC6lt6tqvX0rAe/5/AYNDaFc1Jt5lDOg==
X-Gm-Gg: AR+sD10zgm0gLp/9+rOqdFHVIW/WedoUnsYsoE18ZHfy7f1SuXvJ3Mesd1jpo63/pn6
	GTPoiz/PGEm+QEj4TsZj/GQelr8t/CxZC8+Z0SSpueLLiYafoHQSUiS0nP89Lg1GVRsFw3Et7h/
	dYjsCT51u2/NlHw6IPRQ8q7g9wWCDuUkEeSVL4z7OUv2wHzTP35B+iV7tAaSZMd6/fg3Tgsq4BF
	aSDX6/5BVAyqcOGEDI0NIYrtnRN4XWPl23Z2FfJbQCZsr40wAJ3Ai+xGunBHUWNHh93zrCyqlAe
	Jrn87zZaGPAqYiNAAf7HoYDb4piJQ3BKKBP8J9YHUFMa+vnRcGx36+7Ch9cf
X-Received: by 2002:a05:600c:4444:b0:495:6b4c:fccc with SMTP id 5b1f17b1804b1-496b5c7182amr99174645e9.10.1785154732012;
        Mon, 27 Jul 2026 05:18:52 -0700 (PDT)
X-Received: by 2002:a05:600c:4444:b0:495:6b4c:fccc with SMTP id 5b1f17b1804b1-496b5c7182amr99174075e9.10.1785154731608;
        Mon, 27 Jul 2026 05:18:51 -0700 (PDT)
Received: from imammedo ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b388d5b4sm162922435e9.3.2026.07.27.05.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:18:50 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:18:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?UTF-8?B?QmVubsOpZQ==?=
 <alex.bennee@linaro.org>, Lukas Straub <lukasstraub2@web.de>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Zhao Liu
 <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>, Markus
 Armbruster <armbru@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@mailo.com>, Alex
 Williamson <alex@shazbot.org>, zhenwei pi <zhenwei.pi@linux.dev>, Hanna
 Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu
 <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 linux-cxl@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Stefan Berger
 <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, Stefan
 Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, "Michael
 S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>, linux-edac@vger.kernel.org,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, Jason Wang
 <jasowangio@gmail.com>, qemu-trivial@nongnu.org, Jonathan Cameron
 <jic23@kernel.org>
Subject: Re: [PATCH v2 16/44] qapi: convert trivial intro sections for
 acpi.json
Message-ID: <20260727141848.5cc56eb2@imammedo>
In-Reply-To: <20260723044805.527643-17-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
	<20260723044805.527643-17-jsnow@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: biy6s-KWW0dU1zANok0jDy53UFVu8LJ0-nplhakNbkk_1785154732
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 00:47:37 -0400
John Snow <jsnow@redhat.com> wrote:

> (Trivial)
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  qapi/acpi.json | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/qapi/acpi.json b/qapi/acpi.json
> index 906b3687a55..291a04a7ea4 100644
> --- a/qapi/acpi.json
> +++ b/qapi/acpi.json
> @@ -81,10 +81,9 @@
>  
>  ##
>  # @ACPIOSTInfo:
> -#
> -# OSPM Status Indication for a device.  For description of possible
> -# values of @source and @status fields see "_OST (OSPM Status
> -# Indication)" chapter of ACPI5.0 spec.
> +#     OSPM Status Indication for a device.  For description
> +#     of possible values of @source and @status fields see "_OST (OSPM
> +#     Status Indication)" chapter of ACPI5.0 spec.
>  #
>  # @device: device ID associated with slot
>  #
> @@ -107,9 +106,8 @@
>  
>  ##
>  # @query-acpi-ospm-status:
> -#
> -# Return a list of `ACPIOSTInfo` for devices that support status
> -# reporting via ACPI _OST method.
> +#     Return a list of `ACPIOSTInfo` for devices
> +#     that support status reporting via ACPI _OST method.
>  #
>  # Since: 2.1
>  #
> @@ -126,8 +124,7 @@
>  
>  ##
>  # @ACPI_DEVICE_OST:
> -#
> -# Emitted when guest executes ACPI _OST method.
> +#     Emitted when guest executes ACPI _OST method.
>  #
>  # @info: OSPM Status Indication
>  #

