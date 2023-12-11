Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnaMcb+A"
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B9F93
	for <linux-cxl@vger.kernel.org>; Mon, 11 Dec 2023 10:03:51 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d05212a7c5so26729405ad.0
        for <linux-cxl@vger.kernel.org>; Mon, 11 Dec 2023 10:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317831; x=1702922631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BP2FG0CLKFZ8PYueHXYMnzoIdqajJYlYcwV1qYNiOeI=;
        b=fnaMcb+A3zgoDuebCmppm7A4fHOih8qf1ZU8Xod1e8NIxRUkhBEeXQrUg+yJ1PR4Fz
         nmhmduccNu7UmpQIizpzXTsmPfnl+zAbDLjg+3g3liwoZ/CqMMEvCehYbr+vxDeABHlC
         J1rOaN/0joiU6tlegLKJTd2361bC34iYn3m5r2KYBhh78xRh7nIqRWwM6YTRs0lMkiXS
         tYwCRsoZLeCZEYbxvyJXf4kdHLJepRcU8ci831ia2P0go5+uBqaNFX322T5CmhuWeaj0
         N+Av1iMwM94j+1de7yUvqnnGplQOUr7ccddw7rKOLy2TbQZ0TnRxUNF0uMguXlnREKR2
         70HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317831; x=1702922631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BP2FG0CLKFZ8PYueHXYMnzoIdqajJYlYcwV1qYNiOeI=;
        b=UtW+Nrr1g1PVxVPPaKb6f2XvyzsNpqSoK/z1rV/W4s7MvLGH50/hs4VBn+qR80wByv
         /0cfUBiWGqh9A/3bn3zVaa46p3MAIUGdRiz68i4x/T0rReL9YLtOup07DyenrIHWbyix
         W3SEHhhc+tCZFvH6O4Inl3JJkTeRr7AeQp6qEkwPkH4dnp7QIdu33j+bf35xEH6E5MNn
         KUw432C1aMHnwnJ2EwifezahGUQxfWkIYW4WdaxRCBp6C2K1Eo0u8XBrzIh4N47CMW20
         HD/VRudEZckDYO0HnVfB0Pc8GzUKicvqbcwmtQSXfHZqnUAiEugDatcFVRot9EWypVeZ
         dG9w==
X-Gm-Message-State: AOJu0YwvQw+MQB0z7uR/Ik91ZKXwraAGhSEa9YZVomMggWIaidqmjOcx
	AQOJ67j+48ASBnJoL/V+xoY=
X-Google-Smtp-Source: AGHT+IHu5KnepVF7Q+1KoyPOoU04VPf/6yn9vzOrHwxOT4+EVsC0BFE3NJDoPdwwU/VOvSYszqx4zA==
X-Received: by 2002:a17:902:8301:b0:1d0:b6b9:ec85 with SMTP id bd1-20020a170902830100b001d0b6b9ec85mr1559826plb.134.1702317831245;
        Mon, 11 Dec 2023 10:03:51 -0800 (PST)
Received: from debian (c-71-202-158-162.hsd1.ca.comcast.net. [71.202.158.162])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001cf7c07be50sm6934531plq.58.2023.12.11.10.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 10:03:50 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 11 Dec 2023 10:03:48 -0800
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, jonathan.cameron@huawei.com,
	dave@stgolabs.net
Subject: Re: [PATCH 2/3] cxl/region: Add sysfs attribute for locality
 attributes of CXL regions
Message-ID: <ZXdPBMbWau0dePxv@debian>
References: <170199184936.3543815.17537965163543815359.stgit@djiang5-mobl3>
 <170199191618.3543815.17768111410214136858.stgit@djiang5-mobl3>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170199191618.3543815.17768111410214136858.stgit@djiang5-mobl3>

On Thu, Dec 07, 2023 at 04:31:56PM -0700, Dave Jiang wrote:
> Add read/write latencies and bandwidth sysfs attributes for the enabled CXL
> region. The bandwidth is the aggregated bandwidth of all devices that
> contributes to the CXL region. The latency is the worst latency of the
> device amongst all the devices that contributes to the CXL region.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |   40 +++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c               |   24 +++++++++++++++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index fff2581b8033..e96f172eb6a6 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -552,3 +552,43 @@ Description:
>  		attribute is only visible for devices supporting the
>  		capability. The retrieved errors are logged as kernel
>  		events when cxl_poison event tracing is enabled.
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
>  }
>  static DEVICE_ATTR_RW(size);
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
>  static struct attribute *cxl_region_attrs[] = {
>  	&dev_attr_uuid.attr,
>  	&dev_attr_commit.attr,
> @@ -653,6 +673,10 @@ static struct attribute *cxl_region_attrs[] = {
>  	&dev_attr_resource.attr,
>  	&dev_attr_size.attr,
>  	&dev_attr_mode.attr,
> +	&dev_attr_read_bandwidth.attr,
> +	&dev_attr_write_bandwidth.attr,
> +	&dev_attr_read_latency.attr,
> +	&dev_attr_write_latency.attr,
>  	NULL,
>  };
>  
This way latency and bandwidth ABI are defined seems not to be consistent
with what we have now.

For example, for other attributes like interleave_ways, we only define
one attribute "interleave_ways", and use two separate functions
interleave_ways_show and interleave_ways_store for read/write operation.
for ABI interface, only one is provided
"/sys/bus/cxl/devices/regionZ/interleave_granularity"

for latency and bandwidth, should we provide two interfaces like below
instead?
/sys/bus/cxl/devices/regionZ/bandwidth --rw
/sys/bus/cxl/devices/regionZ/latency --rw

Fan
> 
> 
