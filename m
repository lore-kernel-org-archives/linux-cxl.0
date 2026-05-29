Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0000B37B3F9;
	Fri, 29 May 2026 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780074453; cv=none; b=Tqdjd8e5Z5MfaPe16l2vUmYlvl1cly2ZUs9CezCfsc7SX3TzepRbKgnBS3iEHJmrW6j068M3x9QNv1j02vGH5vuBJQayz4ShV2T8OvN+Ga+fTMJixjk52EZm2a4KXKeTw8BgdnmlxqhHhW5jMCf1MgrEE0YLHdPUPl38hl+k1n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780074453; c=relaxed/simple;
	bh=tXNp0g3W9JDleKH3mGUCK15MwBH0BMR204B9RWHLpy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K80iOzjmEucB2MdCg5Il8LZQgMLftb6SaR3EQQnnKYrHzTcLGkDaipKcAY5nbCZPKFF2FTHwLn1KU9HeJYtI5G+Xu/bcBbRiJsg3LHsijZ58N8Y0nV3ZbO4N8D5IEgao1ukVamChyhYy0/pxYivLozZyI5mCH7W7Qb/13co3Alc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAaCXSHW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAaCXSHW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780074451; x=1811610451;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tXNp0g3W9JDleKH3mGUCK15MwBH0BMR204B9RWHLpy4=;
  b=SAaCXSHWMXMPRot+S0qumc0eaXU5axs9Gr2thzrAOHbVVXd2EJuDgZNt
   sV/uJ7b9va57aV7DU6osklmTD6T0U5NIaabZUVhsj3vy7M1X36CH9ypWW
   gMO1TXWlJ9yz27+4zVymnQtA5tIvv4CUOP/Zrs98DL8FUAkWjyrDGTOem
   p2sL1x67I1HT9La3RAk6y09NuMFTVHzZvQnTMC3g1iM0eLwhS6UtlrZJP
   /KuUCXV4UifhcM/rOzxWyoboh/7mHmwXiQ+Cssx5JV4gmmEOv2tBzfxfZ
   TPvyj6BQZrsxYxZ6VR1RYqSOtMztUiMY3J5LUdea5gJLbbd/v218FpSV1
   g==;
X-CSE-ConnectionGUID: 1EtuYcB3QUmEZqgC1ehk1w==
X-CSE-MsgGUID: mvpMH3Q6Q7+Fhkt0HY1TcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="84818577"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="84818577"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 10:07:30 -0700
X-CSE-ConnectionGUID: G5PilY2TRVCbhtb15yLkqg==
X-CSE-MsgGUID: vzlt7mksQS+P4+at1bzt3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="236543663"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.151]) ([10.125.111.151])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 10:07:29 -0700
Message-ID: <19e89881-0969-4305-859a-f8120198b783@intel.com>
Date: Fri, 29 May 2026 10:07:27 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 24/31] dax/bus: Add uuid sysfs attribute to dax
 devices
To: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev, Dan Williams <djbw@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>, John Groves
 <John@Groves.net>, Gregory Price <gourry@gourry.net>,
 Anisa Su <anisa.su@samsung.com>
References: <cover.1779528761.git.anisa.su@samsung.com>
 <00e5da991afc1c96ca1074152ec10d0d8484b673.1779528761.git.anisa.su@samsung.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <00e5da991afc1c96ca1074152ec10d0d8484b673.1779528761.git.anisa.su@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/23/26 2:43 AM, Anisa Su wrote:
> Introduce a read-write 'uuid' sysfs entry at
> /sys/bus/dax/devices/daxX.Y/ with stubbed handlers: show returns "0"
> and store returns -EOPNOTSUPP.  A follow-on patch wires both
> directions to dax_resource tracking.
> 
> Document the attribute in the dax sysfs ABI.
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-dax | 18 ++++++++++++++++++
>  drivers/dax/bus.c                       | 14 ++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-dax b/Documentation/ABI/testing/sysfs-bus-dax
> index b34266bfae49..23400824073b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-dax
> +++ b/Documentation/ABI/testing/sysfs-bus-dax
> @@ -59,6 +59,24 @@ Description:
>  		backing device for this dax device, emit the CPU node
>  		affinity for this device.
>  
> +What:		/sys/bus/dax/devices/daxX.Y/uuid
> +Date:		May, 2026
> +KernelVersion:	v6.16

update

> +Contact:	nvdimm@lists.linux.dev
> +Description:
> +		(RW) On read, reports the uuid identifying the capacity
> +		backing this dax device.  A value of "0" indicates that the
> +		device has no associated uuid — either it is not backed by
> +		DCD capacity, or the backing extents are untagged.
> +
> +		Writes are accepted only on dax devices in sparse (DCD)
> +		regions; writes to non-sparse devices return -EOPNOTSUPP.
> +		Writing a non-null uuid claims every dax_resource in the
> +		parent region whose tag matches the written uuid, consuming
> +		any available capacity in each matching resource.  Writing
> +		"0" is shorthand for the null uuid and claims a single
> +		untagged dax_resource.
> +
>  What:		/sys/bus/dax/devices/daxX.Y/target_node
>  Date:		February, 2019
>  KernelVersion:	v5.1
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 5c1b93890d30..1d6f82920be6 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -1526,6 +1526,19 @@ static ssize_t numa_node_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(numa_node);
>  
> +static ssize_t uuid_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", 0);

Should it just emit null UUID instead of 0 to not screw up user apps?

return sysfs_emit(buf, "%pUb\n", &uuid_null);

> +}
> +
> +static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
> +			  const char *buf, size_t len)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static DEVICE_ATTR_RW(uuid);
> +
>  static ssize_t memmap_on_memory_show(struct device *dev,
>  				     struct device_attribute *attr, char *buf)
>  {
> @@ -1597,6 +1610,7 @@ static struct attribute *dev_dax_attributes[] = {
>  	&dev_attr_resource.attr,
>  	&dev_attr_numa_node.attr,
>  	&dev_attr_memmap_on_memory.attr,
> +	&dev_attr_uuid.attr,
>  	NULL,
>  };
>  

