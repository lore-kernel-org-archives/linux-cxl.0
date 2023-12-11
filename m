Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsgqkaBc"
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022F4DF
	for <linux-cxl@vger.kernel.org>; Mon, 11 Dec 2023 01:06:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3333131e08dso4803223f8f.2
        for <linux-cxl@vger.kernel.org>; Mon, 11 Dec 2023 01:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702285611; x=1702890411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0DW+M09JuCjPa87ln7cQCVX9tIA94ugoZMo/Auhk0ls=;
        b=RsgqkaBcVVrdV7OTMvaMXX1UBzY2n83afJQXacKhDPWB8dlDHk4jLBDU+FspQobny0
         4+9bvnujSBwM8d7fmbvWYezEs0fWT7ininNzuDiMqi09gEvtGLhF/LNrLedkWNneNqPi
         7/5vqH+lkGnVdt69+DEwgqndBWRXDYpPMXV6lTpL2n0aDO0MjuX7OO9EABr8oVB0CTzA
         MPDlFAxFUbElGromNiA+4RNzzMzIhDXaK1J7GltV7ty/qNWcJfPSIwtT2wy1JpJNpZZg
         cRe6q/+KtQxUDvtFtXFCDENkrqhtpzlJCDFaDCnUmUF8zQySvazGeIGVmzbaK508qkYd
         u8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702285611; x=1702890411;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DW+M09JuCjPa87ln7cQCVX9tIA94ugoZMo/Auhk0ls=;
        b=w9YJVsKyUMvkcnrsyW+nl1uITIxcLqKKQKoMzOHN7pcjES78ggBV2WIzXFw/ejjIK5
         4T0UrmbruMSdXUuRkLwnTwpM+qn2Usas/428ihWHxdi/yTDbAaCriTrt0iEJEkSGL/Ik
         WeDD2SeP7v6TUrxM6w2ZCcaDwMXLku/QBo07BoE1P5cmOkCPhY9Cg1jzIEvTYeapYGhp
         QMzp0PjtMq3MefJg/AhitQ40+CmZu1R4ypSPYFKUDdzC4NZB5q4k6NbmdsqPc0CDYJh1
         7IOPGnV1RCo818GGrsf8uYhTWr3in4gxkpXmAhEcpnpmWPAZ7F7EcKpNHZw2ddE0i4tJ
         y6xQ==
X-Gm-Message-State: AOJu0YzmNq61JxOJr0jRDr0wtCOia7q7xUawq4ZTuD1IL19yisc2mEOo
	S4q3JBuUi0OrmPnkMccZWVOHv2EOVn2fHw==
X-Google-Smtp-Source: AGHT+IG8G1flFcWgd7dCukBhTfYeUFWZiJwZfzwn0GQq7O2dhrPh4arWrYPv0JHkxNeHTvA/TrZ+Ng==
X-Received: by 2002:adf:e0c3:0:b0:333:2fd2:2f0c with SMTP id m3-20020adfe0c3000000b003332fd22f0cmr1495970wri.133.1702285611052;
        Mon, 11 Dec 2023 01:06:51 -0800 (PST)
Received: from ?IPV6:2001:660:6102:320:b79a:47e4:aec5:5f17? ([2001:660:6102:320:b79a:47e4:aec5:5f17])
        by smtp.gmail.com with ESMTPSA id m11-20020adfe94b000000b00333504001acsm8032270wrn.15.2023.12.11.01.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 01:06:50 -0800 (PST)
Message-ID: <23a78aa8-e076-4b98-bd7c-4299aefd9895@gmail.com>
Date: Mon, 11 Dec 2023 10:06:49 +0100
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
> Add read/write latencies and bandwidth sysfs attributes for the enabled CXL
> region. The bandwidth is the aggregated bandwidth of all devices that
> contributes to the CXL region. The latency is the worst latency of the
> device amongst all the devices that contributes to the CXL region.


Hello

Which initiator do these bandwidths/latencies refer to? Local CPUs near 
the root port? This should be specified in the doc.

Brice



>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-cxl |   40 +++++++++++++++++++++++++++++++
>   drivers/cxl/core/region.c               |   24 +++++++++++++++++++
>   2 files changed, 64 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index fff2581b8033..e96f172eb6a6 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -552,3 +552,43 @@ Description:
>   		attribute is only visible for devices supporting the
>   		capability. The retrieved errors are logged as kernel
>   		events when cxl_poison event tracing is enabled.
> +
> +
> +What:		/sys/bus/cxl/devices/regionZ/read_bandwidth
> +Date:		Apr, 2023
> +KernelVersion:	v6.8
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The aggregated read bandwidth of the region. The number is
> +		the accumulated read bandwidth of all CXL memory devices that
> +		contributes to the region.
> +
> +
> +What:		/sys/bus/cxl/devices/regionZ/write_bandwidth
> +Date:		Apr, 2023
> +KernelVersion:	v6.8
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The aggregated write bandwidth of the region. The number is
> +		the accumulated write bandwidth of all CXL memory devices that
> +		contributes to the region.
> +
> +
> +What:		/sys/bus/cxl/devices/regionZ/read_latency
> +Date:		Apr, 2023
> +KernelVersion:	v6.8
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The read latency of the region. The number is
> +		the worst read latency of all CXL memory devices that
> +		contributes to the region.
> +
> +
> +What:		/sys/bus/cxl/devices/regionZ/write_latency
> +Date:		Apr, 2023
> +KernelVersion:	v6.8
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The write latency of the region. The number is
> +		the worst write latency of all CXL memory devices that
> +		contributes to the region.
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
> +static DEVICE_ATTR_RO(attrib)
> +
> +ACCESS_ATTR(read_bandwidth);
> +ACCESS_ATTR(read_latency);
> +ACCESS_ATTR(write_bandwidth);
> +ACCESS_ATTR(write_latency);
> +
>   static struct attribute *cxl_region_attrs[] = {
>   	&dev_attr_uuid.attr,
>   	&dev_attr_commit.attr,
> @@ -653,6 +673,10 @@ static struct attribute *cxl_region_attrs[] = {
>   	&dev_attr_resource.attr,
>   	&dev_attr_size.attr,
>   	&dev_attr_mode.attr,
> +	&dev_attr_read_bandwidth.attr,
> +	&dev_attr_write_bandwidth.attr,
> +	&dev_attr_read_latency.attr,
> +	&dev_attr_write_latency.attr,
>   	NULL,
>   };
>   
>
>
>
