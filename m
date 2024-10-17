Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F8C1E0E03
	for <linux-cxl@vger.kernel.org>; Thu, 17 Oct 2024 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184235; cv=none; b=N3ecW7yNCpHY8r9wYlaS16o9tWNekKztuDmjDuGl6jB7QxUehUgk0LXYPH0jhgE3oY2THay+lpb0ydaqWO4rZJAi22y752bfPUhG/PwGIwtQ1S3VO6HiCMVRgSkTiEGh4qPwn+W6X4EMebrE99My5V4qPxRZFl3cTOJAcJSuYs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184235; c=relaxed/simple;
	bh=9mxssVP6BoSQSKh49EBFy220BvBoalmwrDabQy9VJuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFrl3z3rGDPW+XffyOGkyOIcVuFrTu3C3cO3EhkvHQnFmaSO3cL8x0SojwEOx3lfG+nOS03WXI+SvDeKqH497/JPqw1AxUnHYPBEdRW1phi/JhDpvhdCQD5ewIr2+XoleIAa05DiRUCROidWWJ5RCNoZulkKl6P3O39G8rhRsCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RfZ66l+4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfZ66l+4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729184226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lg7XsMEhuWLNtgjlRCyQaoVUReKNoqecctKxe2PlgNM=;
	b=RfZ66l+4XWmvZInDbQBINGa6il71P2tyvupr2vJ8THQ6v7PbrcwYViNn9FMl8qQDRpRz2H
	WHMM2IOxTzR70oWP0w6bS3cM/44cEkDWAWrZVJWzF7YIOoi5UE/pv4sdGYYJ0zUoSfb9aV
	W31y2O1QLfjdT+aWZNxWfClC2YTBrVQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-fI8lriC7Po68UfO6ZkM3eg-1; Thu, 17 Oct 2024 12:57:03 -0400
X-MC-Unique: fI8lriC7Po68UfO6ZkM3eg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-431518ae047so10786705e9.0
        for <linux-cxl@vger.kernel.org>; Thu, 17 Oct 2024 09:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729184222; x=1729789022;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lg7XsMEhuWLNtgjlRCyQaoVUReKNoqecctKxe2PlgNM=;
        b=oSS5daXibXFnBJfFOCp4kqAvmjX0GQskXUC1vv0Q6TzXXvpZpInCAEhVt8H+yWu6mP
         udWnvzznFS5eSK1g/W+b+cKTCeMXPadJAyWL7hbQVwAmvVRgVI/mk1peI0eIYwC+x2MQ
         s1Wpd0m3WrDKwpMntyvg4StULt7L+y0y60/WMKaa01GVRpEoTKiiEN6eBdaphMjR+q6v
         rrzSUiWJC1ifVkYgnnAp7e19R0hu3vQD35sN8RrsIdwpuc0IkbUqd+K1YnNmOkGV2yDT
         AIZ0AQ+cK2AFVWmYve2vaAkCe8Dkm+bFzp/BaRNt/iI07kOh6G5VjFJ6ugrPUZFhWNEW
         LNKw==
X-Forwarded-Encrypted: i=1; AJvYcCUFoZnLM8vZ1HkL7RM6N4NdQ7qRV9CLmkFTqMpN0EtRKKkh8xP7BlUqhvykG7dm7LQatjQygG53mog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5CgBhUVWbDhJr768z9+B+NdZFJTczBXQYCPruw0jkJIaRMVHx
	otrJ4otXx7MhDEfocyTfrPZDaW4U/oL8+s1GXHIdxTY/VArgjAaF5xJHh1SxqGdPequG+LdHXTB
	mK1Sm8XEneG50iQGeLfwSL+cumJoV+KnOo0fRugvexvZcNDp6uuo0utPqfg==
X-Received: by 2002:a05:600c:6012:b0:431:46fe:4cac with SMTP id 5b1f17b1804b1-43158759b80mr26805435e9.14.1729184222139;
        Thu, 17 Oct 2024 09:57:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7nhSjWLW2YwXq+3jzHjDvHGRg++AFqh6UyGuBgHAuMziVTb1jKQ7j+twfSfHI/ghMayJISw==
X-Received: by 2002:a05:600c:6012:b0:431:46fe:4cac with SMTP id 5b1f17b1804b1-43158759b80mr26805295e9.14.1729184221688;
        Thu, 17 Oct 2024 09:57:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c? ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316068c694sm1096255e9.13.2024.10.17.09.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 09:57:01 -0700 (PDT)
Message-ID: <5827f6e5-6de9-4ec1-83eb-b2e552092498@redhat.com>
Date: Thu, 17 Oct 2024 18:57:00 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] hw/cxl: Type 2 Device RFC
To: Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Zhi Wang <zhiw@nvidia.com>
References: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 5/18/23 04:45, Ira Weiny wrote:
> Type 2 devices are not yet a reality.  Developing core kernel support
> is difficult without some test device to model against.
> 
> Define a type 2 device 'cxl-accel'.  This device is derived from the
> type 3 device and retains all that functionality for now.
> 
> Mock up a couple of accelerator features (Back Invalidate [BI] and
> Unordered IO [UIO]) as examples for the RFC.  These have no
> functionality other than to report the features as present for software
> to key off of.
> 
> Defining these devices in qemu can be done with the following example:
> 
> ...
>    -device cxl-accel,bus=sw0p0,volatile-memdev=cxl-ac-mem5,id=cxl-dev5,sn=0xCAFE0005
> ...
> 
> NOTE: I'm leaving off Michael Tsirkin for now because this is really
> rough and I'm mainly sending it out because it was talked about in the
> CXL community call on 5/16.
> 
> Not-Yet-Signed-off-by: Ira Weiny <ira.weiny@intel.com>


A recent proposal to add support in VFIO for CXL passthrough uses
this emulated device and a sample driver for a proof of concept.
For this effort, it would be very useful to have a QEMU model for
a CXL type2 device, even partially implemented.

I haven't found any updates of this series. What are the plans for
upstream today ?

For vfio-cxl, see :
   
* [RFC] vfio: introduce vfio-cxl to support CXL type-2 accelerator passthrough
   https://lore.kernel.org/kvm/20240920223446.1908673-1-zhiw@nvidia.com
* [RFC] Introduce vfio-cxl to support CXL type-2 device passthrough
   https://lore.kernel.org/all/20240921071440.1915876-1-zhiw@nvidia.com/


Thanks,

C.

   

> ---
> Ira Weiny (5):
>        hw/cxl: Use define for build bug detection
>        hw/cxl: Refactor component register initialization
>        hw/cxl: Derive a CXL accelerator device from Type-3
>        hw/cxl/accel: Add Back-Invalidate decoder capbility structure
>        hw/cxl: Add UIO HDM decoder register fields
> 
>   docs/system/devices/cxl.rst    | 11 ++++++
>   hw/cxl/cxl-component-utils.c   | 80 +++++++++++++++++++-----------------------
>   hw/mem/cxl_type3.c             | 39 ++++++++++++++++++++
>   include/hw/cxl/cxl_component.h | 51 +++++++++++++++++++--------
>   include/hw/cxl/cxl_device.h    | 16 +++++++++
>   include/hw/pci/pci_ids.h       |  1 +
>   6 files changed, 141 insertions(+), 57 deletions(-)
> ---
> base-commit: 8eb2a03258313f404ca0c8609a8f9009b9b4318c
> change-id: 20230517-rfc-type2-dev-c2d661a29d96
> 
> Best regards,

