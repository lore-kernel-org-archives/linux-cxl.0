Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26729C77B7A
	for <linux-cxl@archiver.kernel.org>; Wed, 17 May 2023 22:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjEQW2j (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 May 2023 18:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEQW2i (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 May 2023 18:28:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1C55FC3
        for <linux-cxl@vger.kernel.org>; Wed, 17 May 2023 15:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684362516; x=1715898516;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CD5ODkMIdBEFWSU5E6ms7pn4JRHoZ7jA/A7RiLF/2sY=;
  b=FG8t8K6RWIRv8CcJ5AeQtPL7wpaTv0qQ1oyn/omSM3UK6ihQMprK5JrD
   Ri1uljFRMkdd01ZntNucR8rjlS7o9eJM4rwPOiJvppoZGPoa2P23HGT2S
   /GPj4GHzlVJGMSCB/rBGW4ysBGZjlMvXbtz+3mqiBRTJTsiAxmEltd+z/
   VHlAgjeppsoI20ulHPm2y27B/va9miVp83YXYEoOE0wIwpKtHknjExDbK
   VpJVyI7Y7TUdBp2ETOePDDaWZbTTpdalu2RBuFsXLz5YoNgUdRndwbhyV
   1/5XE0wqFBr+i/quCkV9yuSk7uwPQkdQvhqlG61WOYQM8sBLmF8PQyagJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="380095437"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="380095437"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 15:28:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="696054970"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="696054970"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.83.61]) ([10.212.83.61])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 15:28:34 -0700
Message-ID: <e199d92d-c5bd-ab91-8986-b92cea6d7bcf@intel.com>
Date:   Wed, 17 May 2023 15:28:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v5 14/14] cxl/mem: Add debugfs output for QTG related data
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
 <168357889673.2756219.5112791678818283230.stgit@djiang5-mobl3>
 <20230512163642.00002715@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230512163642.00002715@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 5/12/23 8:36 AM, Jonathan Cameron wrote:
> On Mon, 08 May 2023 13:48:16 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add debugfs output to /sys/kernel/debug/cxl/memX/qtgmap
>> The debugfs attribute will dump out all the DSMAS ranges and the associated
>> QTG ID exported by the CXL device CDAT.
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> LTGM, though seems we haven't been keeping up with ABI docs for other
> stuff in debugfs. That wants fixing but is unrelated to this.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>>
>> ---
>> v4:
>> - Use cxlds->qos_list instead of the stray cxlmd->qos_list
>> ---
>>   Documentation/ABI/testing/debugfs-cxl |   11 +++++++++++
>>   MAINTAINERS                           |    1 +
>>   drivers/cxl/mem.c                     |   17 +++++++++++++++++
>>   3 files changed, 29 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/debugfs-cxl
>>
>> diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
>> new file mode 100644
>> index 000000000000..0f36eeb7e59b
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/debugfs-cxl
>> @@ -0,0 +1,11 @@
>> +What:		/sys/kernel/debug/cxl/memX/qtg_map
>> +Date:		Mar, 2023
>> +KernelVersion:	v6.4
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(RO) Entries of all Device Physical Address (DPA) ranges
>> +		provided by the device Coherent Device Attributes Table (CDAT)
>> +		Device Scoped Memory Affinity Structure (DSMAS) entries with
>> +		the matching QoS Throttling Group (QTG) id calculated from the
>> +		latency and bandwidth of the CXL path from the memory device
>> +		to the CPU.
> 
> Curious. This file should already exist as there is clearly more debugfs ABI
> from the code below.  Perhaps a precursor patch to create the file and document
> existing interfaces?

Looks like Alison got it into 6.4-rc1.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=50d527f52cbf0680c87d11a254383ca730c5c19f

I just need to wait for cxl/next to rebase to 6.4-rc so I can rebase the 
series.

> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fd8c4c560f8d..256e4e57017c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5171,6 +5171,7 @@ M:	Ben Widawsky <bwidawsk@kernel.org>
>>   M:	Dan Williams <dan.j.williams@intel.com>
>>   L:	linux-cxl@vger.kernel.org
>>   S:	Maintained
>> +F:	Documentation/ABI/testing/debugfs-cxl
>>   F:	drivers/cxl/
>>   F:	include/uapi/linux/cxl_mem.h
>>   
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 39c4b54f0715..587e261a7f76 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -45,6 +45,22 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>>   	return 0;
>>   }
>>   
>> +static int cxl_mem_qtg_show(struct seq_file *file, void *data)
>> +{
>> +	struct device *dev = file->private;
>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	struct perf_prop_entry *perf;
>> +
>> +	list_for_each_entry(perf, &cxlds->perf_list, list) {
>> +		seq_printf(file, "%08llx-%08llx : QoS Class: %u\n",
>> +			   perf->dpa_range.start, perf->dpa_range.end,
>> +			   perf->qos_class);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>>   				 struct cxl_dport *parent_dport)
>>   {
>> @@ -117,6 +133,7 @@ static int cxl_mem_probe(struct device *dev)
>>   
>>   	dentry = cxl_debugfs_create_dir(dev_name(dev));
>>   	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>> +	debugfs_create_devm_seqfile(dev, "qtgmap", dentry, cxl_mem_qtg_show);
>>   	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>>   	if (rc)
>>   		return rc;
>>
>>
> 
