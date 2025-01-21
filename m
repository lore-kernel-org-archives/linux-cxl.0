Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038A51AFB36
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jan 2025 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737447569; cv=none; b=O2EiJ5DvviAVwStXOJXajNTbr510HAjt8csWXE8wNwVAvphbglt/422DitkOrvhdT82LsrbDAvYHqzf2YxMQCMw96NDHoC4TX2AUbEfzUk+Z/6i5WVKG0CH6SxX9kB1Lq0+tuP1z6/h6ksnPLb5v+sof8wzyRdlBYlPhRa1bBx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737447569; c=relaxed/simple;
	bh=PVLtA/n+6DO2XVphDCQUZh1/a24J9ioYMMNy/uS60IQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lM7am3oxjNc3veJnZJoTRSOyGDhwDWOnu1ryAX39tMLsDxMTrzM67MVFF9yE711CHz9ujCkhqOEsCGaOCrsRPfI/MxJLF3GUQl9exeP4AdLEpCfmvk05SxZWjskJkbeyfwxFmsfkMJ1njTgQ03nxJte3hnGJ1RQGZo6M451wtSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=feNs0Dgt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feNs0Dgt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737447565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oWxFfQloQrWxhz6vkTH178/CIdL2k87FeluoUAyrDBU=;
	b=feNs0DgtTRsOlSBfGGzrGkejfJy7p/RGUNryW+RfZky67X53FmeTOdxBitGvWW6cseuu5N
	WXemfBL9eVgGjk4DOimwmcYPOaO271RPDQ7EJAeU12tfKEKnop8ANk7208B65Z3wA0NW1K
	6iy9iyU8C2m/ZbH6kPSEwrP/R7GTaX8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-sqwA_95CNYeqaPQgge9wmA-1; Tue, 21 Jan 2025 03:19:24 -0500
X-MC-Unique: sqwA_95CNYeqaPQgge9wmA-1
X-Mimecast-MFC-AGG-ID: sqwA_95CNYeqaPQgge9wmA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385d6ee042eso3427840f8f.0
        for <linux-cxl@vger.kernel.org>; Tue, 21 Jan 2025 00:19:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737447563; x=1738052363;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oWxFfQloQrWxhz6vkTH178/CIdL2k87FeluoUAyrDBU=;
        b=tpIz0Oni7DRxo6tXUxX4J5XB+DE7coQfsEWEO5cmQ2DgK3VMxsyKqPa2oGF9ZNgIox
         Bh8BJ0Zre7lKsEoV2clLBXnIK0palg0UBnydbabzxtY912Pe4vY4VCIY5PMS9xKOX0cb
         EvJShVP4JpBn82/rhIWH69yKRwawCWutDGDEr4GPSYCYKysik5OHY2LY6q3lXGToolLy
         KQ8japwh7K1Ugs8f5FQyPpNXVEsvanwQFon7y5zhSg+4JkozbYmJgVvAIgTSeat+roz/
         /Ni43ljHbhJA5apUcrD74oglMfVurDzBksBPRae76uxzRyZ+qdA5H3Ic0nilJ6S+q7f8
         Rv6g==
X-Forwarded-Encrypted: i=1; AJvYcCUi0xeaTYQJx/0EtIWjDTfUbAFIwb1N5KW2mzxbfhx1D1hYk3U6a/TLVW/DIAcC13+vztSkI9IcGuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOucx4OlbDgfHq87eucIRAgxaDZxfTjkWJpGHkkAB/npcOP+B9
	omws01R8HaDF5ht26uJQjCU6kPX1Nx7rnbYSMyDlo8ycsQnfvfZX9AM12cjZyc3uQcMVv4WABds
	Csj2nknPnDU+hoMo5ffpStAmBPQIuJpH6AJ5ifDBAnK5VHDCigJTpnZC5zdwXOPJDbg==
X-Gm-Gg: ASbGncsPEHuWKQALVp4doPBZgQ2dAc8o1Jxhte+msAhYjLOqHGgN3LMHOLfnGlOwza4
	9zKWwb6gXoOBUS0K4BjkXbdev2RiXMBWRforfkraut5e7TaQk5jY1Xppz4DOf6/qMS12mm/6DU0
	n1Xa+lzVS4REr3jXAezOC56WXXDbNzWzPOh96rokPJrvmdoW/un7RGhoFdh62z2KKt53ZOXckw4
	WQNMnzF4u8bcruOhNV2hj7XMnCuahesA8lvpfoOP0Aoid9G5iYOZ13gMjIq7Lhrg7gaJVd+92uk
	YWLnpmBwU/rLVLEg256ZzLM2M4Xn2WoHP0ziQkU7kjidlobjLqqQb7AgGSKZB/V47Bnyu9mBJ3Q
	U7m5LznRCdoj+JFvMzHajMg==
X-Received: by 2002:a05:6000:1a8c:b0:385:e5d8:2bea with SMTP id ffacd0b85a97d-38bf56639c9mr13643409f8f.20.1737447563297;
        Tue, 21 Jan 2025 00:19:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFw900bC4ZSmXSTcrHZnhNPl9DtuShk5pGkORoBHldXZaUNRdHHeTrgff2+DLeBofC9o14SYw==
X-Received: by 2002:a05:6000:1a8c:b0:385:e5d8:2bea with SMTP id ffacd0b85a97d-38bf56639c9mr13643385f8f.20.1737447562926;
        Tue, 21 Jan 2025 00:19:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:6200:16ba:af70:999d:6a1a? (p200300cbc709620016baaf70999d6a1a.dip0.t-ipconnect.de. [2003:cb:c709:6200:16ba:af70:999d:6a1a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c752935csm226281845e9.26.2025.01.21.00.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 00:19:21 -0800 (PST)
Message-ID: <4e556200-c790-4e0a-b103-2a1529c81927@redhat.com>
Date: Tue, 21 Jan 2025 09:19:19 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] kernel/resource: Introduce managed SOFT RESERVED
 resources
To: Nathan Fontenot <nathan.fontenot@amd.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, alison.schofield@intel.com, linux-mm@kvack.org,
 gourry@gourry.net
References: <cover.1737046620.git.nathan.fontenot@amd.com>
 <1800b17449d1c231292c85f59b226aff39a81552.1737046620.git.nathan.fontenot@amd.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1800b17449d1c231292c85f59b226aff39a81552.1737046620.git.nathan.fontenot@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gmI-21x9meP3c5zOHMVAAQSKkaVj9Sba-gkxoue8qeI_1737447563
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.01.25 18:42, Nathan Fontenot wrote:

Hi,

> Introduce the ability to manage SOFT RESERVED kernel resources prior to
> these resources being  placed in the iomem resource tree. This provides
> the ability for drivers to update SOFT RESERVED resources that intersect
> with their memory resources.
> 
> During boot, any resources marked as IORES_DESC_SOFT_RESERVED are placed
> on the soft reserve resource tree. Once boot completes all resources
> are placed on the iomem resource tree. This behavior is gated by a new
> kernel option CONFIG_SOFT_RESERVED_MANAGED.
> 

I'm missing a bit of context here.

Why can't we flag these regions in the existing iomem tree, where they 
can be fixed up (even after boot?)?

Especially, what about deferred driver loading after boot? Why is that 
not a concern or why can we reliably handle everything "during boot" ?

> As part of this update two new interfaces are added for management of
> the SOFT RESERVED resources. The release_srmem_region_adjustable()
> routine allows for removing pieces of SOFT RESERVED resources. The
> the merge_srmem_resources() allows drivers to merge any remaining SOFT
> RESERVED resources into the iomem resource tree once updatea are complete.
> 
> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>

-- 
Cheers,

David / dhildenb

