Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsJhzwrw"
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC39AD
	for <linux-cxl@vger.kernel.org>; Tue, 12 Dec 2023 05:46:48 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c3fe6c08fso33195825e9.1
        for <linux-cxl@vger.kernel.org>; Tue, 12 Dec 2023 05:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702388807; x=1702993607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CTU9K8HtW7anEeps3JC1jiOhhNJckpMX5hNxpt7E+Qw=;
        b=IsJhzwrwe3s6oQkPQCpeejIuYjyLhURuxxTROWZahnXtlXTpuGKwmIBPFxTIAx4jTP
         xp+mNJFCauhKEkjBtKPh5VXrbPRilRxOLNjle4jAfJdjVx9eanOVHkmUYchH9yoFBmbZ
         FzPudP8PAzfJQqnoePLbJHpUyOjZHEUqgseYGrrptHzNoCxYZlq75E1uD2khekbXsNQn
         VH5EHfYPKcNzS1kMDmTXfcVZb991Ee+91nt8wXDY7+YU3d0ZRlKrdYddoOGd8R5/s2UO
         NUSA6LH9x9K3Yz1bD4hhePbaZoFYiFIFbupz/FinwWtRDolHBgTYx34utwFINK9cXTbs
         jitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702388807; x=1702993607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTU9K8HtW7anEeps3JC1jiOhhNJckpMX5hNxpt7E+Qw=;
        b=Hr/yiDKA9FYf/2dTp9ql9GDFZCEPXSqrjCGRq5UFn/QfkhoLd5iDGpjTd76rWpj8Oo
         9YcJPgBuJDp+V41Fxvph5bKhOTNQIckyEPgy7aZ4WkciFOSksiyzP0eUtgxLDuZ1Pgco
         +hHmmazpvXb7kVNzsIaC8+dk6Gyz+JGFz68G9alsG1Grfjgz/eO2zXKZbQB4Wcd2HXqt
         ccORYfeSDLmpS4PRgTId79c8GA0UxjeCDFam2pvAtNAJKus/3RfXp+V81WFl+t0dnnbm
         XSW2IeGL4HcZiTZmy12WrNcFpFqA+PGA/DwrtIfKDxiyAgVsMrhsmFQWAv7Y3bmvREDq
         gKnA==
X-Gm-Message-State: AOJu0Yx/nBSHOEVkJDCmmdVNLaMvXZGEx9sy45VuxgnnRwzzQviZqwTl
	Q/Wia/KtUXD+Vkhp8q4ybihj6bcaFQHyzQ==
X-Google-Smtp-Source: AGHT+IH5cbkw/YxrlQNLOxauJibq7rup3MWFr7QFOBYjxW79r7AruhxFLtMsXEmmkQR/X33bM1NCaw==
X-Received: by 2002:a05:600c:6020:b0:40b:5e59:99bd with SMTP id az32-20020a05600c602000b0040b5e5999bdmr2073207wmb.221.1702388806620;
        Tue, 12 Dec 2023 05:46:46 -0800 (PST)
Received: from ?IPV6:2001:660:6102:320:8576:b1e1:1bd4:efe1? ([2001:660:6102:320:8576:b1e1:1bd4:efe1])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b0040b3e26872dsm19038356wms.8.2023.12.12.05.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 05:46:46 -0800 (PST)
Message-ID: <d7d17fd4-9587-4786-af58-a68d1ebe074f@gmail.com>
Date: Tue, 12 Dec 2023 14:46:45 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cxl/region: Add sysfs attribute for locality
 attributes of CXL regions
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, jonathan.cameron@huawei.com, dave@stgolabs.net
References: <170199184936.3543815.17537965163543815359.stgit@djiang5-mobl3>
 <170199191618.3543815.17768111410214136858.stgit@djiang5-mobl3>
From: Brice Goglin <brice.goglin@gmail.com>
In-Reply-To: <170199191618.3543815.17768111410214136858.stgit@djiang5-mobl3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/12/2023 à 00:31, Dave Jiang a écrit :

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d879f5702cf2..72c47f624d63 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -645,6 +645,26 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
>   }
>   static DEVICE_ATTR_RW(size);
>   
> +#define ACCESS_ATTR(attrib)					\
> +static ssize_t attrib##_show(struct device *dev,		\
> +			   struct device_attribute *attr,	\
> +			   char *buf)				\
> +{								\
> +	struct cxl_region *cxlr = to_cxl_region(dev);		\
> +								\
> +	if (!cxlr->coord)					\
> +		return 0;					\
> +								\
> +	return sysfs_emit(buf, "%u\n",				\
> +			  cxlr->coord->attrib);			\
> +}								\

Hello

Latencies ares off by a factor of 1000 here (I see 586/686 for r/w attributes
for NUMA nodes in Qemu but 1000x higher for region attributes). For NUMA node attributes,
you're dividing latencies by a factor a 1000 in cxl_region_perf_attrs_callback():
  
         /* Adjust latencies from psec to nsec to be consistent with HMAT targets */
         coord = *cxlr->coord;
         coord.read_latency = DIV_ROUND_UP(coord.read_latency, 1000);
         coord.write_latency = DIV_ROUND_UP(coord.write_latency, 1000);

For region attributes, I think you're missing the same?

Brice

