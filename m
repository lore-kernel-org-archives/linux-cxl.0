Received: from mail-m25492.xmail.ntesmail.com (mail-m25492.xmail.ntesmail.com [103.129.254.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCDC1BC32
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jan 2024 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.254.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174340; cv=none; b=g7LeruQlBda8kd0prwZbmVlxJaHd1uH/KjhM0eyAK5Th8oduHQXlVuT6eIRFUAdUeT3dN6smaDNjBJIGaJQafPgUFPRSzM47PxCkSXHPS7/dq3VRM7nRy2dT7ozTRq7wrMI8s+IyaRrXdCr18d+67CJW4VBJ/7aYX8UwqXe1mnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174340; c=relaxed/simple;
	bh=hQ5hsgHAywbkJvumzMcev9ttCd4FKeOp165Y4v045PY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MAJWc2oeIV3PcxfkzvllMDaxGAbYdmN6H6BY/LyWZAYUwcw7kYoBN1TK80aREEThnpGjqctBQ4O02AqRyQl2JvnIXJp3qA+2+HrCEIfYHs2EBYNHKJFUK77zVfipDVJM5KVjcUkw9F0vjynhVStZjKW4yKGUY7WfOusvzBVOHAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=103.129.254.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [192.168.122.189] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id B6045860279;
	Thu, 25 Jan 2024 14:49:12 +0800 (CST)
Subject: Re: [RFC PATCH 0/4] cxl: introduce CXL Virtualization module
To: Dan Williams <dan.j.williams@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, ave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
Cc: linux-cxl@vger.kernel.org
References: <20231228060510.1178981-1-dongsheng.yang@easystack.cn>
 <6595c83083418_8dc6829468@dwillia2-xfh.jf.intel.com.notmuch>
 <a32d859f-054f-11ca-e8a3-dff7a5234d0a@easystack.cn>
 <65b1da5b2933b_39fcf29416@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Message-ID: <8498fb54-b003-e9b5-ba50-2e6eb8e257f5@easystack.cn>
Date: Thu, 25 Jan 2024 14:49:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <65b1da5b2933b_39fcf29416@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTU9CVhlIGExIShhJSEsdQlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lOSFVKS0tVSkJLS1kG
X-HM-Tid: 0a8d3f6143f1023ckunmb6045860279
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ni46SDo6Njc0OU8hPUJRGR0Q
	ORoKCzVVSlVKTEtNSk1OSE5OQkNOVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBT0JJSzcG



在 2024/1/25 星期四 上午 11:49, Dan Williams 写道:
> Dongsheng Yang wrote:
>>
>>
>> 在 2024/1/4 星期四 上午 4:48, Dan Williams 写道:
>>> Dongsheng Yang wrote:
>>>> Hi all:
>>>> 	This patchset introduce cxlv module to allow user to
>>>> create virtual cxl device. it's based linux6.7-rc5, you can
>>>> get the code from https://github.com/DataTravelGuide/linux
>>>>
>>>> 	As the real CXL device is not widely available now, we need
>>>> some virtual cxl device to do uplayer software developing or
>>>> testing. Qemu is good for functional testing, but not good
>>>> for some performance testing.
>>>
>>> How is it performance testing if it's just using host-DRAM? Is the use
>>> case something like pinning the benchmark on Socket0 and target DRAM on
>>> Socket1 as emulated CXL to approximate CXL bus latency?
>>
>> Hi Dan,
>> 	I give an example as below, please check it inline.
>>>
>>>>
>>>> 	The new CXLV module allow user to use the reserved RAM[1], to
>>>> create virtual cxl device. When the cxlv module load, it will
>>>> create a directory named as "cxl_virt" under /sys/devices/virtual:
>>>>
>>>> 	"/sys/devices/virtual/cxl_virt/"
>>>>
>>>> that's the top level device for all cxlv devices.
>>>> At the same time, cxlv module will create a debugfs directory:
>>>>
>>>> /sys/kernel/debug/cxl/cxlv
>>>> ├── create
>>>> └── remove
>>>>
>>>> the create and remove debugfs file is the cxlv entry to create or remove
>>>> a cxlv device.
>>>>
>>>> 	Each cxlv device have its owned virtual pci related bridge and bus, cxlv
>>>> will create a new root_port for the new cxlv device, setup cxl ports for
>>>> dport and nvdimm-bridge. After that, we will add the virtual pci device,
>>>> that will go into the cxl_pci_probe to setup new memdev.
>>>>
>>>> 	Then we can see the cxl device with cxl list and use it as a real cxl
>>>> device.
>>>>
>>>>    $ echo "memstart=$((8*1024*1024*1024)),cxltype=3,pmem=1,memsize=$((2*1024*1024*1024))" > /sys/kernel/debug/cxl/cxlv/create
>>>
>>> Are these ranges reserved out of the mmap at boot time?
>>
>> Yes, it is reserved by memmap option in boot cmdline. I use memmap=8G$8G.
> 
> A faster way to get to a device-dax interface fronting reserved memory
> is to use the efi_fake_mem= command line option.
> 
> For example:
> 
>      efi_fake_mem=4G@13G:0x40000
> 
> ...assigns 4GB of System-RAM starting at the 13G physical offset with
> the EFI_MEMORY_SP attribute. By default the kernel creates device-dax
> devices for that dedicated memory.
> 
> For dax mapping performance testing you don't need any of the CXL
> driver infrastructure since the CXL driver has nothing to do with the
> data path.

Thanx for your information, I create cxlv because I think there could be 
some other use cases other than device-dax to use cxl memdev. In that 
way, we need emulate cxl memdev in cxl driver level.

If we always use cxl memdev by creating a region and creating a 
device-dax, I agree we dont need to emulate it in cxl driver level.

Thanx
> 
