Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C3233439D
	for <linux-cxl@vger.kernel.org>; Fri,  9 Jan 2026 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956968; cv=none; b=dTuBKktLd34qZHvWXomyL1ezeP6/bXqocGGbeIjvoPp7z4WibvdmFYViJJzgxA13la9yAkDjfQLHsuSIEgAHVpCxzWH/+JAvlikdv7pe8+h/ulBpK+86R+ZYdvnGMfeiPLyJ9Lv+xkMMKjkKt/ySl3z+37SVPDAFDyxpwvZojBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956968; c=relaxed/simple;
	bh=8Xq5WIfVuMEOt90CrULMH4IpO5y3+EIFJpPu7WTMeHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tnIPIDOsHHJTdX/OvcbsHglHo0Y1q7tjoexnwEwPF5pYjvKUOsG8IWzgrriKFEMK9JeOm72juRg/VUk+zkD+ucwJ2DJ+XYX7NrTnTUUK+pwuZf48vYzCJ1m9zophQjS0nEYRUqiy4md4KIvOxXgJr5+33vuq/0ALYpxUH4BRJLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=coEfTPb0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="coEfTPb0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767956965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WLh4YdMT4BQhhiGpX2c08r18nWKZ1SS4NAmL7UFi+k=;
	b=coEfTPb0GWukj1WzVhQFF+TGwDHtNMK7+RLgIa9lNLkM4dqYCY/L0j7OvhcUkI4bdCe80N
	CfK4K1tYTq6UdHHWOFuS+Y79cuo5Yr25m4d5LD8USACOEKOOtrsZZOvUfRupz07DZ6dISn
	L+QzOGLy4ZpcB7F00VlLxXS22FzHIHU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-NsWMg2WGPuyMri6uRuZ1Yg-1; Fri, 09 Jan 2026 06:09:25 -0500
X-MC-Unique: NsWMg2WGPuyMri6uRuZ1Yg-1
X-Mimecast-MFC-AGG-ID: NsWMg2WGPuyMri6uRuZ1Yg_1767956963
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-59b3b255ee8so3826045e87.3
        for <linux-cxl@vger.kernel.org>; Fri, 09 Jan 2026 03:09:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767956963; x=1768561763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WLh4YdMT4BQhhiGpX2c08r18nWKZ1SS4NAmL7UFi+k=;
        b=H/gIhob3P3DjJ5xDyRGh8Q0wBi0QIdwDOursXPa49Q3rpxa1DECpkVz6Y1EO7TwnJ4
         sPbc4KfwAnlo3Qb8/X58dUwIGoIt9V8HikYVzsGJDgp0PPp3taB2dkWFik/lX8etcCCV
         2gB7f3Urn6zrVFO2EygcIBAgcFR0fhyKLTGt1BUw6Kjd6EfJ5ZgM45RiYZRsZH9hfNp5
         W7HDJ+MNgti8EAjj3OjnpAlI8KqlFqdX08lbmNDC4r5h+VUC0IKOAbHsfV8GI+w1Ha67
         aOVfhyEL9Up9M/Zd68GOhiAg5wxLItn5wYEDdAktuEE8oMEptmNVisjY7CNlmiXMABwd
         TIfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGa42k9JditXN4y04RkyNWdn12nZAQZjxC+/c6TFWE2yobgNU7u+S7Zq85U0UF2nUoiMmI6I+hYlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdv2evEUUgcsw7iKaT3wL8U3CxQhm9G5RQqROvMrECLehc5eOO
	21e1fZgg1a6QR96DcH8aRgME/ZRXUKE14DGsJOIJQJvz61+2nmYifzyrwrvwnMGMKUk/7E4+xpj
	rGo5SPo340UDHLCsh8HQOx+cglUCPKQP6fDXOU40fVJfu7SZPX/APxkoDf56n
X-Gm-Gg: AY/fxX7/dw3Ps35X5r4BGgRxusyMI2DvebcXx0Uxbll4ap+5/Vgx0X0d0WkFoPGSzTp
	FACNNt1RpOS52AnhQJeQS/vez2VtgZPOIz/MZi6ii8eyXztNIy9D8K6QCb6IJn9vBbCx1DEHW/H
	4mzlh9lvAnDYV9SPfWaU4FfAV6Geo974A42+E7zA1iRofTcBiBXwvX2BsiV6cJoOT+aVryq7EZD
	ekMQu+PrUzzYC6H3hKLhQo7kApdT5DzMLqapunjg5Sn3cq8o3tjRzCb5TnQXA5eqV4FH41AEQLh
	dEIsuYmQnVSFlfyZq1nZW86BzBDAajCAwYN37UmyIV6viOm6lJ0NtQq4cbq9Vk0EaD/2ITyHUSU
	MZldhcqnSQGp4O58EWvlHDx6Epnf94LcnHEY=
X-Received: by 2002:a05:6512:138c:b0:595:840c:cdd0 with SMTP id 2adb3069b0e04-59b6ef23821mr2942409e87.2.1767956963322;
        Fri, 09 Jan 2026 03:09:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1Kdn6xqqEz7oS8njPdOYi3SCUUHgKoVYObUp3Vur8XucGkM8H4lTSJgH2gDE+3acZOyL3Ug==
X-Received: by 2002:a05:6512:138c:b0:595:840c:cdd0 with SMTP id 2adb3069b0e04-59b6ef23821mr2942314e87.2.1767956958199;
        Fri, 09 Jan 2026 03:09:18 -0800 (PST)
Received: from [192.168.1.86] (85-23-51-1.bb.dnainternet.fi. [85.23.51.1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65d0f6absm2716455e87.42.2026.01.09.03.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 03:09:17 -0800 (PST)
Message-ID: <d1d80b81-678d-4d28-9ac2-95cb74824e73@redhat.com>
Date: Fri, 9 Jan 2026 13:09:17 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] mm: Split device-private and coherent folios
 before freeing
To: Francois Dugast <francois.dugast@intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Matthew Brost <matthew.brost@intel.com>,
 Balbir Singh <balbirs@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>, Andrew Morton
 <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260109085605.443316-1-francois.dugast@intel.com>
 <20260109085605.443316-4-francois.dugast@intel.com>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20260109085605.443316-4-francois.dugast@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CaFir5B6dsZruifFRWU4bQdeGPCBNCgZ2H0ocglW0QQ_1767956963
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/9/26 10:54, Francois Dugast wrote:

> From: Matthew Brost <matthew.brost@intel.com>
>
> Split device-private and coherent folios into individual pages before
> freeing so that any order folio can be formed upon the next use of the
> pages.
>
> Cc: Balbir Singh <balbirs@nvidia.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Francois Dugast <francois.dugast@intel.com>
> ---
>  mm/memremap.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 63c6ab4fdf08..7289cdd6862f 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -453,6 +453,8 @@ void free_zone_device_folio(struct folio *folio)
>  	case MEMORY_DEVICE_COHERENT:
>  		if (WARN_ON_ONCE(!pgmap->ops || !pgmap->ops->folio_free))
>  			break;
> +
> +		folio_split_unref(folio);
>  		pgmap->ops->folio_free(folio);
>  		percpu_ref_put_many(&folio->pgmap->ref, nr);
>  		break;

This breaks folio_free implementations like nouveau_dmem_folio_free
which checks the folio order and act upon that.
Maybe add an order parameter to folio_free or let the driver handle the split?

Thanks,
Mika

