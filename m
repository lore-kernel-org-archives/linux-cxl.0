Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A868A1BC9ED
	for <linux-cxl@vger.kernel.org>; Mon, 11 Nov 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731364661; cv=none; b=pVRU5JCRSpyNadYit2kpWefBS3oImU+Aj4uqTe+tR+ttayIyB8lYlwRxQJ2HgOThbnfc7w/r0y3d0BYhh+LxWHk4u8n1YKKaWbwUTxlAqnW3yK6MjxVIJmwswcXOicp79tjWRcBlWE0CUoL7fONa+MgzDf07xqojOtB7dkq1yF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731364661; c=relaxed/simple;
	bh=m9dHkd326dJknoBTUfDG9L/benzgGToUCDC3raIi1hc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P94wNu9Gzs++h0iMF3FSWQVZS50XffD5LG6TdUW+vFeR+csj4CZMwfJz4bZo1PHHp42TMJ3noOSXQ07hkuv7xLy/4Qx3qTxyKDK1zP8Og7NFxYu9RI4TrfPgKgcEdz6hK5tLI2Umer0DrTQ85HxgJxobv9EN7wvxB/HvKDG5sGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUdELOsa; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUdELOsa"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e35bf59cf6so54113597b3.0
        for <linux-cxl@vger.kernel.org>; Mon, 11 Nov 2024 14:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731364658; x=1731969458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rIo50m0in8Z4wlkZ0261BWOCfXUT7KLdlhX4Ym2Pe1k=;
        b=SUdELOsab+j/pvpLon4K/0wtprYKH0FMpqBZ6YuROdeDuJT/ST79m1vmvuFRbUokCZ
         3rQDNxhVWgU7X1IjXfvpjQ5o6ywxDrId+d14sosrtMYSO5+/GulkSvqTGBKerO3akwCM
         8uJMkLc1lmhPpz9TZCDRZM8MowdMkUKW6i23RVAh0HEwtkFyAxL3DlbIYFPiNXBxjcRs
         QvdGmWOekuhpKvP96s9K56+a1CDnf6jtFqat9btrexm/RKlcUEac2FCgpVGCRuHBzLV0
         tY1f3l/LwDq1FonJZqH+td9aBsJdsxh5bHjLDtgNRyfAFzi0uxnEABZIyJzQconkxRvr
         IR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731364658; x=1731969458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIo50m0in8Z4wlkZ0261BWOCfXUT7KLdlhX4Ym2Pe1k=;
        b=dDmkMBUvOJD0XKhi60Lmssp3h89fm6b5CJcfro6l+Xv5179AHPXFPEQYZQ3TloSzOx
         x9yuP/DA5R3SWeaN7Eunq9w/wTyZhXIkJhTyOQiondt7GE77S5rx/5elBQtvAfoompKC
         DLH260bGkhNsCSrDJU2b8JNs9rM4RltBpKV3EAvEmQCNmlCicH3ufcLBL4YeF3HmumRC
         AiEqUa+9dDCXp9ihYfZ3yDfOqRL0i8DYqzq1udNpQFY4p4rCNvbHpVJdEzmj8MyHledn
         SI8lxfGQ8e4iloO5q3P6a1mEu1BY+y0qZ++abRth8WTo77bfEDN/bkYH1mhZRn80Ggus
         cYXw==
X-Forwarded-Encrypted: i=1; AJvYcCXthqzUQdrcgJDActbmPKRBQmTFcA3ptUAvFG5dXSmbDtUCFMhmZqcjLkR/m+7KF/vZwpBTytKo3Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+NTkZEI/PrXjf9DZZuvo1QJd7jQDfYmn1aHlwPwV1ciX2xHx
	iLwr+sTlCCxkPwIfvr30jg1asO/IkNXIgUyC2nY7DmdROuSWra5N
X-Google-Smtp-Source: AGHT+IHUTtEUNPkruAHlebfeluDRcnDJ4V3w2CfmWj/VH5Ik9RanGwO9toGON2FgbbQMdWt8M+M82w==
X-Received: by 2002:a05:690c:fcf:b0:6e2:451c:df02 with SMTP id 00721157ae682-6eade50eb4amr114154657b3.16.1731364658581;
        Mon, 11 Nov 2024 14:37:38 -0800 (PST)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb65b76sm22250647b3.71.2024.11.11.14.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 14:37:38 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 11 Nov 2024 14:37:35 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, linux-cxl@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>, shiju.jose@huwei.com,
	qemu-devel@nongnu.org, linuxarm@huawei.com
Subject: Re: [PATCH qemu] hw/cxl: Check for zero length features in
 cmd_features_set_feature()
Message-ID: <ZzKHL9msnqMSv8WE@fan>
References: <20241108175814.1248278-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108175814.1248278-1-Jonathan.Cameron@huawei.com>

On Fri, Nov 08, 2024 at 05:58:14PM +0000, Jonathan Cameron wrote:
> Zero length data for features doesn't make any sense so exclude that case
> early. This fixes the undefined behavior reported by coverity for a zero
> length memcpy().
> 
> Resolves CID 1564900 and 1564901
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 2d4d62c454..ce9aa18364 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1288,6 +1288,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>      set_feat_info->data_offset = hdr->offset;
>      bytes_to_copy = len_in - sizeof(CXLSetFeatureInHeader);
>  
> +    if (bytes_to_copy == 0) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
>      if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
>          if (hdr->version != CXL_MEMDEV_PS_SET_FEATURE_VERSION) {
>              return CXL_MBOX_UNSUPPORTED;

-- 
Fan Ni
