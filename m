Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A42167268
	for <linux-cxl@vger.kernel.org>; Wed,  5 Jun 2024 23:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717630712; cv=none; b=bK6vwztB8vYRsCiJ6P4CnJwOKeC3gh3QXQH9A+HQLU/ukfymEcfCb0aR2gaFhBiiP2d2RXED6+EAvLsQa7/QV7MFhNOZ4+c8NmTscQXSsKBnuF1bbP1gfBKUPqmA1ZkCM6QHCsKWz5drnzFDPs8IkNX2anwlDt12Z1bPK99GbUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717630712; c=relaxed/simple;
	bh=PhZlAwUAGZeoOGv7uZuLzZpmTf9Ee/Ipga54rTFOKD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MseheAzXHuwEA0H71Hvbfy0dAOjWRj/OsZKf4e1HzXELYJGwNRS49yQiDIKN1z6iOUU9TbuHyVzkBXZb38aNJ3ADimJyesGUQw7zHQCG8orlOb5+Kr/DA3qthWRWWRlh8SgFI2WnneGmhoeheUH743WCpHmf3+naji4XaWy+ERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XPkZc7Tx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPkZc7Tx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717630709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yz8jTDHMfEz/BGDUc0jcZQLJ8Pv4WKQiVSKM0FSCnkU=;
	b=XPkZc7Tx790DJMZCylSEjwQDohoM9JI/d4YSY0KwPmunzOBU64JztUJkZ6seSwbTu2I6o7
	ui9YSWG6NX36CPLiVtAU9lBpMfivTYp1VgyPlxRwgi2ZeO8t5C2TW9dpGmHolHNDxmoIBa
	Pxe7VZ+bFoAwxeLwqnHUcLNu4EX+KTM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-sw899h24NSeA1lLFUy7fOQ-1; Wed, 05 Jun 2024 19:38:26 -0400
X-MC-Unique: sw899h24NSeA1lLFUy7fOQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2eaa74bfc18so1870921fa.2
        for <linux-cxl@vger.kernel.org>; Wed, 05 Jun 2024 16:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717630705; x=1718235505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yz8jTDHMfEz/BGDUc0jcZQLJ8Pv4WKQiVSKM0FSCnkU=;
        b=t03sK0ovvbannnuc+zzefiURvn0774Dc3uxQMBrBmTKImCItGyX7OHpUb2HsLqBQup
         7l6IMxg0dCeqGCF67Phn5ZIiTael1lvmmDJS+QgCrgtBVTKszKBLgnA2hSPTcyyHev3c
         2kJDTM2MRQBQotlcP3To9OhImrg22k4uB5V3a9DVDVfJRolOv9s71b9OUTbQqA1JvERL
         7DrpUQ7b5F4/ERfND0j4vP/vfCRB8O3ssFYeoZLhnnr5gm8H/EgKN3Q83dcrKhePpiy0
         Yxh53SHIM5iSRrRWo7zsBG2OlQ8+pZwNSRDmatjfNrsFERPCgzK+sjcu03MukzyS3YET
         p4uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEp4iTJankWCysYTRBLSmmzY8lz2R++m2bKj0/u279nuZA8jHELcrKwfwfHB7o54nUbqftEiKw9rExqLEjv7d5WO7rpbuYz9QK
X-Gm-Message-State: AOJu0YxkIrvu+75Ov6Ik0JQO08YjrH3ZSnApokPcm17EK7Sd1OvgebQq
	KpxfxeBdLXKQpJhJMQAQHtlyPjaSxLU6G+z/L1kybgTkELjYdzxnO9RhIZrhUAC5PasT+hV1LHv
	WHSrKBv0C0iU3rc4FL5fydkmNtmoJtlnclT1secEWDDDTI5Y/plKLEw/7rg==
X-Received: by 2002:a05:651c:503:b0:2e9:5380:615c with SMTP id 38308e7fff4ca-2eac79ed1ccmr27266951fa.12.1717630704878;
        Wed, 05 Jun 2024 16:38:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoVbIhP9pkqfy2MLhDm9ysTZOAvAKztWMN20l1VXr4b9I5STTJjNjbjbMU047kXF5BagMUrQ==
X-Received: by 2002:a05:651c:503:b0:2e9:5380:615c with SMTP id 38308e7fff4ca-2eac79ed1ccmr27266851fa.12.1717630704364;
        Wed, 05 Jun 2024 16:38:24 -0700 (PDT)
Received: from redhat.com ([2.55.56.67])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9d06fsm104226a12.12.2024.06.05.16.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 16:38:23 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:38:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
	ankita@nvidia.com, philmd@linaro.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, eduardo@habkost.net,
	imammedo@redhat.com, linux-cxl@vger.kernel.org, linuxarm@huawei.com,
	Michael Roth <michael.roth@amd.com>,
	Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH qemu ] hw/acpi: Fix big endian host creation of Generic
 Port Affinity Structures
Message-ID: <20240605193521-mutt-send-email-mst@kernel.org>
References: <20240605180455.18193-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240605180455.18193-1-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 05, 2024 at 07:04:55PM +0100, Jonathan Cameron wrote:
> Treating the HID as an integer caused it to get bit reversed
> on big endian hosts running little endian guests.  Treat it
> as a character array instead.
> 
> Fixes hw/acpi: Generic Port Affinity Structure Support
> Tested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> Richard ran the version posted in the thread on an s390 instance.
> Thanks for the help!
> 
> Difference from version in thread:
> - Instantiate i in the for loop.
> 
> Sending out now so Michael can decide whether to fold this in, or
> drop the GP series for now from his pull request (in which case
> I'll do an updated version with this and Markus' docs feedback
> folded in.)


Dropped for now.


> ---
>  include/hw/acpi/acpi_generic_initiator.h | 2 +-
>  hw/acpi/acpi_generic_initiator.c         | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
> index 1a899af30f..5baefda33a 100644
> --- a/include/hw/acpi/acpi_generic_initiator.h
> +++ b/include/hw/acpi/acpi_generic_initiator.h
> @@ -61,7 +61,7 @@ typedef struct PCIDeviceHandle {
>              uint16_t bdf;
>          };
>          struct {
> -            uint64_t hid;
> +            char hid[8];
>              uint32_t uid;
>          };
>      };

I think there is another issue:

+        memcpy(&dev_handle.hid, hid, sizeof(dev_handle.hid));

not nice since there is no check that 8 will hold all of
+        const char *hid = "ACPI0016";
and won't access buffer out of range.




> diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> index 78b80dcf08..f064753b67 100644
> --- a/hw/acpi/acpi_generic_initiator.c
> +++ b/hw/acpi/acpi_generic_initiator.c
> @@ -151,7 +151,9 @@ build_srat_generic_node_affinity(GArray *table_data, int node,
>          build_append_int_noprefix(table_data, 0, 12);
>      } else {
>          /* Device Handle - ACPI */
> -        build_append_int_noprefix(table_data, handle->hid, 8);
> +        for (int i = 0; i < sizeof(handle->hid); i++) {
> +            build_append_int_noprefix(table_data, handle->hid[i], 1);
> +        }
>          build_append_int_noprefix(table_data, handle->uid, 4);
>          build_append_int_noprefix(table_data, 0, 4);
>      }
> -- 
> 2.39.2

