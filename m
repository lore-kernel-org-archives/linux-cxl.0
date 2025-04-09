Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90951214815
	for <linux-cxl@vger.kernel.org>; Wed,  9 Apr 2025 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744238410; cv=none; b=RSnurqVmtkz2PEP5tkrp6Ssx86FbFLhsY4M9VnWtoByMBNw6VUekMGTAvDrVbr98lGmMAvRn2gnGfbpNnbKMzha17WmJrb1EeSDpjEhX69csJPEwUdZcK1Pxx8bDbKBbvXfur+SdDG0cOOjLqlpqNJximnQX0R2TlBi0Ce+fpu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744238410; c=relaxed/simple;
	bh=OSspoLPV6cz+UAg+fyfE9f8ppE7/Be1G6NBk+IQhaTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4GCc30Ialqhm+8swiYDsSWiB6F8d30kMRbo9xuGLqSfFp2gngOzwhwBdYxg9pndE4/3JkgzhFlRMs4ZgJpzZN1/oIhXI0FOkbecSgrd9U5VfZriqEGu2XovLnu8MgQv42j+OPi+zcO5oCzjLk49na74dNmG6WIRmvQvQ/rM23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CrHFgNMI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CrHFgNMI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744238408; x=1775774408;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OSspoLPV6cz+UAg+fyfE9f8ppE7/Be1G6NBk+IQhaTw=;
  b=CrHFgNMIfHuFjEzl/bw0aXBDFln0AXgLEjOgsStGxKlL6ZgxuQVGpiK8
   h5+Zk+WXTiDo24BGyNStGU6cF8QZ/SOlIK5MqC1A5mQluq0CTCZvbin3V
   TPyZgsHTKfUM3liSUebLtlxNYexaXR7u8s7tm7V0UU6cGkVkXEolfeHVT
   eSWuKxOXwsDSkHGQGHo+TbfWQKPpEQYQmcP8QYPneaWgMy+xrUdh94nVQ
   wQhu79EkUyht/pzLaMuUMwyPa/3V1mvjL/XEmQhHqUA2s1dkqwA6m5nuC
   quGLcqPzXK3enoRO49fvnO/MfMVZgKd/p19qxmtwL0SFKZdBHS5OKsPyC
   g==;
X-CSE-ConnectionGUID: k/LFmRxfTwKO7aTNGejnHQ==
X-CSE-MsgGUID: zjkgKvkbS3yGH5102bvchA==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="44876497"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="44876497"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 15:40:07 -0700
X-CSE-ConnectionGUID: 38h8ViRsRymyHA0RLD8rBg==
X-CSE-MsgGUID: KLw+BhN1Si2PK9RLEsb1Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="128696606"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.111.236]) ([10.125.111.236])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 15:40:07 -0700
Message-ID: <b1915848-288d-4d60-96af-490929fe410f@intel.com>
Date: Wed, 9 Apr 2025 15:40:05 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [NDCTL PATCH v4 2/3] cxl: Enumerate major/minor of FWCTL char
 device
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20250218230116.2689627-1-dave.jiang@intel.com>
 <20250218230116.2689627-3-dave.jiang@intel.com>
 <Z_bQ-mo2QnxcVbOK@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Z_bQ-mo2QnxcVbOK@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/9/25 12:56 PM, Alison Schofield wrote:
> On Tue, Feb 18, 2025 at 03:59:55PM -0700, Dave Jiang wrote:
>> Add major/minor discovery for the FWCTL character device that is associated
>> with supprting CXL Features under the cxl_memdev. Add libcxl API functions
>> to retrieve the major and minor of the FWCTL character device.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  cxl/lib/libcxl.c   | 74 ++++++++++++++++++++++++++++++++++++++++++++++
>>  cxl/lib/libcxl.sym |  2 ++
>>  cxl/lib/private.h  |  1 +
>>  cxl/libcxl.h       |  2 ++
>>  4 files changed, 79 insertions(+)
> 
> Please describe the new library interface in 
> "Documentation/cxl/lib/libcxl.txt"
> 
> Add To: nvdimm@lists.linux.dev
> 
>>
>> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
>> index bab7343e8a4a..566870acb30a 100644
>> --- a/cxl/lib/libcxl.c
>> +++ b/cxl/lib/libcxl.c
>> @@ -1253,6 +1253,66 @@ static int add_cxl_memdev_fwl(struct cxl_memdev *memdev,
>>  	return -ENOMEM;
>>  }
>>  
> 
> 
> Can we define like this:
> #define CXL_PATH_MAX 512
> 
> and do this:
> char path[CXL_PATH_MAX];
> 
> in next 2 funcs?
> 
>> +static const char fwctl_prefix[] = "fwctl";
>> +static int get_feature_chardev(const char *base, char *chardev_path)
>> +{
>> +	char *path = calloc(1, strlen(base) + 100);
>> +	struct dirent *entry;
>> +	int rc = 0;
>> +	DIR *dir;
>> +
>> +	if (!path)
>> +		return -ENOMEM;
>> +
>> +	sprintf(path, "%s/fwctl/", base);
>> +	dir = opendir(path);
>> +	if (!dir) {
>> +		rc = -errno;
>> +		goto err;
>> +	}
>> +
>> +	while ((entry = readdir(dir)) != NULL)
>> +		if (strncmp(entry->d_name, fwctl_prefix, strlen(fwctl_prefix)) == 0)
>> +			break;
> 
> Can we exit this while loop w entry not NULL, yet not a match?
> Maybe a found flag or store a match separately.
> 
>> +
>> +	if (!entry) {
>> +		rc = -ENOENT;
>> +		goto read_err;
>> +	}
>> +
>> +	sprintf(chardev_path, "/dev/fwctl/%s", entry->d_name);
>> +
>> +read_err:
>> +	closedir(dir);
>> +err:
>> +	free(path);
>> +	return rc;
>> +}
>> +
>> +static int memdev_get_fwctl_chardev(struct cxl_memdev *memdev,
>> +				    const char *cxlmem_base)
>> +{
>> +	char *path = calloc(1, strlen(cxlmem_base) + 100);
>> +	struct stat st;
>> +	int rc;
>> +
> 
> Do we need to init memdev->fwctl... to something to avoid garbage?

I think 0.0 is probably sufficient as incorrect chardev for user. We don't init memdev->major/minor either.

DJ

 
> 
> 
>> +	rc = get_feature_chardev(cxlmem_base, path);
>> +	if (rc)
>> +		goto out;
>> +
>> +	if (stat(path, &st) < 0) {
>> +		rc = -errno;
>> +		goto out;
>> +	}
>> +
>> +	memdev->fwctl_major = major(st.st_rdev);
>> +	memdev->fwctl_minor = minor(st.st_rdev);
>> +
>> +out:
>> +	free(path);
>> +	return rc;
>> +}
>> +
>>  static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
>>  {
>>  	const char *devname = devpath_to_devname(cxlmem_base);
>> @@ -1279,6 +1339,10 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
>>  	memdev->major = major(st.st_rdev);
>>  	memdev->minor = minor(st.st_rdev);
>>  
>> +	/* If this fails, no Features support. */
>> +	if (memdev_get_fwctl_chardev(memdev, cxlmem_base))
>> +		dbg(ctx, "%s: no Features support.\n", devname);
>> +
>>  	sprintf(path, "%s/pmem/size", cxlmem_base);
>>  	if (sysfs_read_attr(ctx, path, buf) == 0)
>>  		memdev->pmem_size = strtoull(buf, NULL, 0);
>> @@ -1515,6 +1579,16 @@ CXL_EXPORT int cxl_memdev_get_minor(struct cxl_memdev *memdev)
>>  	return memdev->minor;
>>  }
>>  
>> +CXL_EXPORT int cxl_memdev_get_fwctl_major(struct cxl_memdev *memdev)
>> +{
>> +	return memdev->fwctl_major;
>> +}
>> +
>> +CXL_EXPORT int cxl_memdev_get_fwctl_minor(struct cxl_memdev *memdev)
>> +{
>> +	return memdev->fwctl_minor;
>> +}
>> +
>>  CXL_EXPORT unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev)
>>  {
>>  	return memdev->pmem_size;
>> diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
>> index 1fc33cc6e1a4..b2b51a72673c 100644
>> --- a/cxl/lib/libcxl.sym
>> +++ b/cxl/lib/libcxl.sym
>> @@ -292,4 +292,6 @@ global:
>>  LIBCXL_9 {
>>  global:
>>  	cxl_bus_get_by_provider;
>> +	cxl_memdev_get_fwctl_major;
>> +	cxl_memdev_get_fwctl_minor;
>>  } LIBECXL_8;
>> diff --git a/cxl/lib/private.h b/cxl/lib/private.h
>> index b6cd910e9335..676bf1573487 100644
>> --- a/cxl/lib/private.h
>> +++ b/cxl/lib/private.h
>> @@ -37,6 +37,7 @@ enum cxl_fwl_loading {
>>  struct cxl_endpoint;
>>  struct cxl_memdev {
>>  	int id, major, minor;
>> +	int fwctl_major, fwctl_minor;
>>  	int numa_node;
>>  	void *dev_buf;
>>  	size_t buf_len;
>> diff --git a/cxl/libcxl.h b/cxl/libcxl.h
>> index 3b309968a808..26aa906740af 100644
>> --- a/cxl/libcxl.h
>> +++ b/cxl/libcxl.h
>> @@ -69,6 +69,8 @@ const char *cxl_memdev_get_host(struct cxl_memdev *memdev);
>>  struct cxl_bus *cxl_memdev_get_bus(struct cxl_memdev *memdev);
>>  int cxl_memdev_get_major(struct cxl_memdev *memdev);
>>  int cxl_memdev_get_minor(struct cxl_memdev *memdev);
>> +int cxl_memdev_get_fwctl_major(struct cxl_memdev *memdev);
>> +int cxl_memdev_get_fwctl_minor(struct cxl_memdev *memdev);
>>  struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *memdev);
>>  unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
>>  unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
>> -- 
>> 2.48.1
>>

