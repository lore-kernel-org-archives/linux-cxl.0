Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgHcAX72"
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F7DB4
	for <linux-cxl@vger.kernel.org>; Mon, 11 Dec 2023 10:27:18 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d06d4d685aso27928825ad.3
        for <linux-cxl@vger.kernel.org>; Mon, 11 Dec 2023 10:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702319237; x=1702924037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bkEqs71OWUKLYuUhrXnwF0zHeMPT3KmL9Abt/cUJ7eM=;
        b=LgHcAX72fJDso4qIZH0o8ll0Zp8oGXY3l0SIuVg35gFORPLTYvyaZIP1x2CCDwSkea
         4TvrRPzZcOD1TLHeUXGTvwmUig+gz7kJwD4RLgQq2nZ0B2m/DcPm8EHkxj9WbPPazLVr
         +qGiUhp5Sbh+DJFM8terEjP7IpcD8GcA9C+JZje9w9w86/1whRzLrVOjpGPAPVpStn8L
         ySZY3WTQkqoTGjivVez47RsoE4SUMC8KpBAYRuc6a7PhJK/x5Z0buVtWNNSW1XKiuJev
         9GI9HO7d2DSL8E0tgx6XKqmR4XTfBYmBnFE8z2z3jr2hQ263LhqgH5zKTWn6TU+Lt98V
         tzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702319237; x=1702924037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkEqs71OWUKLYuUhrXnwF0zHeMPT3KmL9Abt/cUJ7eM=;
        b=kQSmdI7erRQwxhIQV9BWCz6PkFOcV5MWdT54JFFC5P4AfJ56NAK0P8+fL6SLmRkwSJ
         7CvDDgq5EYYfELUhh6zBSDofkqbG2sUpMoZZ8RP2Id6bTQCpWTKqjKmuCiFcQAHNX3m1
         Ihea+FMAGIAW7Fpjb+k/NE/aCnfInHYTKlitVCvZ4yRO8sK4bf6PCZ7e8sndKudl3k07
         TjEpY0E4F3nj69Y7McYsSgxi6w6mfhomz0xKkNZavyxaO+aqyThKBimyPGqhsWC/DC7/
         kFzBKwBKx1qsqcOmGrys+X3Oo8fKmT+Xq/gaMGOKnAWrK86KhS7MUzcB9rXBLG9ZDONu
         L6yQ==
X-Gm-Message-State: AOJu0Yx7y7KTpxgzmZeEQ0KZCO7YJkCn1S7lMMswU8cbQeZF68O8OuuQ
	NOYBB0tnYX1y0ThYZqCWmx88DpNuv0U=
X-Google-Smtp-Source: AGHT+IG1wgllkzQCsXkLzFXx/E1PoBjVcZHvBfMZ3/aR0eEz2qiGCAyDP8deXiLTK1QN3ovxB7kCtQ==
X-Received: by 2002:a17:902:e5c5:b0:1d0:90bf:cba2 with SMTP id u5-20020a170902e5c500b001d090bfcba2mr2412553plf.73.1702319237477;
        Mon, 11 Dec 2023 10:27:17 -0800 (PST)
Received: from debian (c-71-202-158-162.hsd1.ca.comcast.net. [71.202.158.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902c1cc00b001cfb573674fsm6925397plc.30.2023.12.11.10.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 10:27:17 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 11 Dec 2023 10:27:00 -0800
To: Dave Jiang <dave.jiang@intel.com>
Cc: fan <nifan.cxl@gmail.com>, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	jonathan.cameron@huawei.com, dave@stgolabs.net
Subject: Re: [PATCH 2/3] cxl/region: Add sysfs attribute for locality
 attributes of CXL regions
Message-ID: <ZXdUdMaziZi4vOMQ@debian>
References: <170199184936.3543815.17537965163543815359.stgit@djiang5-mobl3>
 <170199191618.3543815.17768111410214136858.stgit@djiang5-mobl3>
 <ZXdPBMbWau0dePxv@debian>
 <567d1abe-906d-4ace-aad7-7fc22f9e97e8@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <567d1abe-906d-4ace-aad7-7fc22f9e97e8@intel.com>

On Mon, Dec 11, 2023 at 11:13:42AM -0700, Dave Jiang wrote:
> 
> 
> On 12/11/23 11:03, fan wrote:
> > On Thu, Dec 07, 2023 at 04:31:56PM -0700, Dave Jiang wrote:
> >> Add read/write latencies and bandwidth sysfs attributes for the enabled CXL
> >> region. The bandwidth is the aggregated bandwidth of all devices that
> >> contributes to the CXL region. The latency is the worst latency of the
s/contributes/contribute/
> >> device amongst all the devices that contributes to the CXL region.
s/contributes/contribute/
> >> device amongst all the devices that contributes to the CXL region.
> >>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >> ---
> >>  Documentation/ABI/testing/sysfs-bus-cxl |   40 +++++++++++++++++++++++++++++++
> >>  drivers/cxl/core/region.c               |   24 +++++++++++++++++++
> >>  2 files changed, 64 insertions(+)
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> >> index fff2581b8033..e96f172eb6a6 100644
> >> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> >> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> >> @@ -552,3 +552,43 @@ Description:
> >>  		attribute is only visible for devices supporting the
> >>  		capability. The retrieved errors are logged as kernel
> >>  		events when cxl_poison event tracing is enabled.
> >> +
> >> +
> >> +What:		/sys/bus/cxl/devices/regionZ/read_bandwidth
> >> +Date:		Apr, 2023
> >> +KernelVersion:	v6.8
> >> +Contact:	linux-cxl@vger.kernel.org
> >> +Description:
> >> +		(RO) The aggregated read bandwidth of the region. The number is
> >> +		the accumulated read bandwidth of all CXL memory devices that
> >> +		contributes to the region.
> >> +
> >> +
> >> +What:		/sys/bus/cxl/devices/regionZ/write_bandwidth
> >> +Date:		Apr, 2023
> >> +KernelVersion:	v6.8
> >> +Contact:	linux-cxl@vger.kernel.org
> >> +Description:
> >> +		(RO) The aggregated write bandwidth of the region. The number is
> >> +		the accumulated write bandwidth of all CXL memory devices that
> >> +		contributes to the region.
> >> +
> >> +
> >> +What:		/sys/bus/cxl/devices/regionZ/read_latency
> >> +Date:		Apr, 2023
> >> +KernelVersion:	v6.8
> >> +Contact:	linux-cxl@vger.kernel.org
> >> +Description:
> >> +		(RO) The read latency of the region. The number is
> >> +		the worst read latency of all CXL memory devices that
> >> +		contributes to the region.
> >> +
> >> +
> >> +What:		/sys/bus/cxl/devices/regionZ/write_latency
> >> +Date:		Apr, 2023
> >> +KernelVersion:	v6.8
> >> +Contact:	linux-cxl@vger.kernel.org
> >> +Description:
> >> +		(RO) The write latency of the region. The number is
> >> +		the worst write latency of all CXL memory devices that
> >> +		contributes to the region.
> >> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> >> index d879f5702cf2..72c47f624d63 100644
> >> --- a/drivers/cxl/core/region.c
> >> +++ b/drivers/cxl/core/region.c
> >> @@ -645,6 +645,26 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
> >>  }
> >>  static DEVICE_ATTR_RW(size);
> >>  
> >> +#define ACCESS_ATTR(attrib)					\
> >> +static ssize_t attrib##_show(struct device *dev,		\
> >> +			   struct device_attribute *attr,	\
> >> +			   char *buf)				\
> >> +{								\
> >> +	struct cxl_region *cxlr = to_cxl_region(dev);		\
> >> +								\
> >> +	if (!cxlr->coord)					\
> >> +		return 0;					\
> >> +								\
> >> +	return sysfs_emit(buf, "%u\n",				\
> >> +			  cxlr->coord->attrib);			\
> >> +}								\
> >> +static DEVICE_ATTR_RO(attrib)
> >> +
> >> +ACCESS_ATTR(read_bandwidth);
> >> +ACCESS_ATTR(read_latency);
> >> +ACCESS_ATTR(write_bandwidth);
> >> +ACCESS_ATTR(write_latency);
> >> +
> >>  static struct attribute *cxl_region_attrs[] = {
> >>  	&dev_attr_uuid.attr,
> >>  	&dev_attr_commit.attr,
> >> @@ -653,6 +673,10 @@ static struct attribute *cxl_region_attrs[] = {
> >>  	&dev_attr_resource.attr,
> >>  	&dev_attr_size.attr,
> >>  	&dev_attr_mode.attr,
> >> +	&dev_attr_read_bandwidth.attr,
> >> +	&dev_attr_write_bandwidth.attr,
> >> +	&dev_attr_read_latency.attr,
> >> +	&dev_attr_write_latency.attr,
> >>  	NULL,
> >>  };
> >>  
> > This way latency and bandwidth ABI are defined seems not to be consistent
> > with what we have now.
> > 
> > For example, for other attributes like interleave_ways, we only define
> > one attribute "interleave_ways", and use two separate functions
> > interleave_ways_show and interleave_ways_store for read/write operation.
> > for ABI interface, only one is provided
> > "/sys/bus/cxl/devices/regionZ/interleave_granularity"
> > 
> > for latency and bandwidth, should we provide two interfaces like below
> > instead?
> > /sys/bus/cxl/devices/regionZ/bandwidth --rw
> > /sys/bus/cxl/devices/regionZ/latency --rw
> 
> Hi Fan. I think there's a misunderstanding here. This is not reading and writing of bandwidth and latency. This is read latency and write latency and read bandwidth and write bandwidth. They are separate and unique properties of the path. i.e. upstream and downstream direction traffic performances. 
> 
Oh. I totally misunderstood, thanks for clarification. Then the patch
looks good to me expect for a minor typo in the commit comments as shown
above.

Fan
> 
> > 
> > Fan
> >>
> >>
