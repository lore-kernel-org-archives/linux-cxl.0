Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480F9526A86
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651658; cv=none; b=CdM0A3bRrqy4BlQMDKfD+W9PvJXsmDmGWay9NutAVSRIhKRVAoNn7Oqf1xm/7TXOmfosVmJIhr8bhKoqQyspmdT2Orj2YQSfb+q9uuydLYopI0u9vXwozidFGJr+KZJdVDrg2u/f2DHkEjw7shTEETlCkXs8Di9TS07xw8WnglQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651658; c=relaxed/simple;
	bh=enXwzA9BcIOkYsH2pguE945nGXNFjkYL8fMgKtjyR6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MX4QLqk4fCVvRpBjpRoirX/Y8hxOT1C5dHgWgkx5r2Tlpspp2DhYCA0FvMgHbHSjmwQApjJbdWZCDeNstRm8ZrKjVp3OwHbtBRA+RLB2LuziOXPjO8/9RHaILwymBlz5+qOtr9h7YzY47mVqQhqQ+jQfh+YfGXNa+Jd9A4xJC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rd3z23Qc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rd3z23Qc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789651655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Os4V/Nh6hpIAE4QELnwb/Aon1/X5FEXVxFR2MrZLV0c=;
	b=Rd3z23QcH+hScsqRjHlTVBVa4TW2To703cEfrhfchJOuckJXi8QgDES61Q9j/3RZ5oM8hw
	7+HKc3fZ7ytIO2PA6aYkw5b5dYj+iAkcIXLCvn2dy9ST5iUWlbW4dhtBzr87hf7dK3jASJ
	zEg1YIrrtvtXKvTEjR4Tg6Nbpk9ZcM0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-eLboj1v0PL2TnmEftFe6-A-1; Thu, 17 Sep 2026 09:27:33 -0400
X-MC-Unique: eLboj1v0PL2TnmEftFe6-A-1
X-Mimecast-MFC-AGG-ID: eLboj1v0PL2TnmEftFe6-A_1789651653
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4994cf6cdb9so7159425e9.3
        for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 06:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789651653; x=1790256453;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Os4V/Nh6hpIAE4QELnwb/Aon1/X5FEXVxFR2MrZLV0c=;
        b=zzZvqPQhxKY5dOccRNCNvTpCcx50F/41IPtI+OftqXoNVJeDMtK/Vku2I7uhf1tijt
         SNwrtKcswQCzXqQXxBMUljb8Ac/Pbrtm6Yfs3R9UTCQNwV+bEyleA8+ZYxYf9LVj7Gh3
         AIus6V9GQvulXtRI7E/vaxHlvZVJXyfEjjU7wE8XKcxOfylEHRaw7tu44J65KUYlHzlb
         oV/HFhfCMcdxbqJNDOJLDiC0m3gBCPuyu0FyKfvzslKes3mlyqZqS3M7E94OXBFLfRsl
         6tM/h/FZqmeSJ/Gh+osSyyslk7lSaqmOTS6sySLANPdLJOPTK49b4rjnMFt3cGyU6xnq
         95Sw==
X-Forwarded-Encrypted: i=1; AKwUvBxW1T3LHe6MWcarJ750vL3a4Z5OIK3d4nUPEaq6B0XW5WKRtBFhLwHTcAITAVwu5sH32QSnAKgSiJ4=@vger.kernel.org
X-Gm-Message-State: AFuF++ndxBV9O5XeLAWhkMSgKbzjvrIRScDq8HBHbV0UVBYCaaL6TYoR
	Bx2Vp2O+uSrVJjC94Uzbg1V0V6/8S5J6ao+w6SlG22A5DAnIhNcYqanb26mVXNY6Z6OAvjuvsHq
	SjeKlyjgVO5XgUF6X2YbG9NXbhmtQYzBgTy4zcNt2Pzz8LtfdbvwqVLM9CldjHw==
X-Gm-Gg: AYBFou2/l/ADUV4Cc3/OghjPY9OZGD5iVt+wjf4HdvHFGB4FJAjmf+2uy1haxutG3bL
	Uk9B2Hh//hfNioGY8kxQpyq9crEOMPnnYsSK34q3A53HpaaLm+8+ZUEcJ+pokJOzHhKYmiiP2Ra
	woudd40ltCx78Wop1Jvf5xmRVRCFCVFxx5dL/TdrY5zlNox0eq94RGIvRrjiEDHsnCNoGC8Xub+
	1eKYjs7fQEs9us0k6185eUaGuVQjxekeszDtY032CRkwSZ1TpbPrfeWz3K5ZyzgmNZpA+bl3Ey0
	vuJtUSNoMRsqR4b/M+j8Q39rhosdo4r5djkpAwXX5ClufOQYYo7dkQ3QQG5kxS2yJYoiqZFRTH1
	Z7PzvcE89c3YJPjVVlAKJI4MAoy3NzaS0lATEeAxsUw==
X-Received: by 2002:a05:600c:8b86:b0:49c:fff9:f684 with SMTP id 5b1f17b1804b1-49eb7320be4mr78559835e9.21.1789651651948;
        Thu, 17 Sep 2026 06:27:31 -0700 (PDT)
X-Received: by 2002:a05:600c:8b86:b0:49c:fff9:f684 with SMTP id 5b1f17b1804b1-49eb7320be4mr78559305e9.21.1789651651438;
        Thu, 17 Sep 2026 06:27:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:e939:7a09:c368:e5d5? ([2a01:e0a:1292:d530:e939:7a09:c368:e5d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd32c5e1sm108386465e9.5.2026.09.17.06.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 06:27:30 -0700 (PDT)
Message-ID: <3d799d0d-1365-4bbb-a159-c8d926f2863c@redhat.com>
Date: Thu, 17 Sep 2026 15:27:29 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] hw/vfio/region: Add vfio_region_setup_with_ops()
To: mhonap@nvidia.com, alex@shazbot.org, ankita@nvidia.com, jic23@kernel.org,
 dave.jiang@intel.com, alejandro.lucero-palau@amd.com, smadhavan@nvidia.com,
 pierrick.bouvier@oss.qualcomm.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pbonzini@redhat.com, eric.auger@redhat.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, cohuck@redhat.com
Cc: kjaju@nvidia.com, vsethi@nvidia.com, zhiw@nvidia.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, linux-cxl@vger.kernel.org
References: <20260916184412.3825713-1-mhonap@nvidia.com>
 <20260916184412.3825713-3-mhonap@nvidia.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260916184412.3825713-3-mhonap@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ljb7OIKZ_z532CRquUbQvHagZ-1sn_LYY3UaIOTmfDU_1789651653
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/26 20:44, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> A CXL Type-2 device traps its HDM decoder block, so that region needs
> custom MemoryRegionOps rather than the pass-through default. Split the
> setup body out and let a caller supply the ops; NULL keeps the existing
> behaviour.
> 
> AI-used-for: code (prototype)
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>   hw/vfio/region.c      | 27 ++++++++++++++++++++++++---
>   hw/vfio/vfio-region.h |  3 +++
>   2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index 54ad11a6c8..21b54978b5 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -228,8 +228,9 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>       return 0;
>   }
>   
> -int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
> -                      int index, const char *name, Error **errp)
> +static int vfio_region_do_setup(Object *obj, VFIODevice *vbasedev,
> +                                VFIORegion *region, int index, const char *name,
> +                                const MemoryRegionOps *ops, Error **errp)
>   {
>       struct vfio_region_info *info = NULL;
>       int ret;
> @@ -249,7 +250,7 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>   
>       if (region->size) {
>           region->mem = g_new0(MemoryRegion, 1);
> -        memory_region_init_io(region->mem, obj, &vfio_region_ops,
> +        memory_region_init_io(region->mem, obj, ops,
>                                 region, name, region->size);
>   
>           if (!vbasedev->no_mmap &&
> @@ -273,6 +274,26 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>       return 0;
>   }
>   
> +int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
> +                      int index, const char *name, Error **errp)
> +{
> +    return vfio_region_do_setup(obj, vbasedev, region, index, name,
> +                                &vfio_region_ops, errp);
> +}
> +
> +/*
> + * Like vfio_region_setup() but traps the region through @ops instead of the
> + * default pass-through, so a caller can intercept accesses (the CXL HDM
> + * decoder block). A NULL @ops keeps the default.
> + */
> +int vfio_region_setup_with_ops(Object *obj, VFIODevice *vbasedev,
> +                               VFIORegion *region, int index, const char *name,
> +                               const MemoryRegionOps *ops, Error **errp)
> +{
> +    return vfio_region_do_setup(obj, vbasedev, region, index, name,
> +                                ops ? ops : &vfio_region_ops, errp);

if you're calling _with_ops(), you have custom ops, that's whole point.
Passing NULL is a caller bug, no need to have a fall back. Or assert().

Thanks,

C.



> +}
> +
>   static void vfio_subregion_unmap(VFIORegion *region, int index)
>   {
>       trace_vfio_region_unmap(memory_region_name(&region->mmaps[index].mem),
> diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
> index 58b236f113..8d5699013a 100644
> --- a/hw/vfio/vfio-region.h
> +++ b/hw/vfio/vfio-region.h
> @@ -39,6 +39,9 @@ uint64_t vfio_region_read(void *opaque,
>                             hwaddr addr, unsigned size);
>   int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>                         int index, const char *name, Error **errp);
> +int vfio_region_setup_with_ops(Object *obj, VFIODevice *vbasedev,
> +                               VFIORegion *region, int index, const char *name,
> +                               const MemoryRegionOps *ops, Error **errp);
>   int vfio_region_mmap(VFIORegion *region);
>   void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
>   void vfio_region_exit(VFIORegion *region);

