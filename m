Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8B3C4332F
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Nov 2022 23:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiKGXqO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Nov 2022 18:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiKGXqL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Nov 2022 18:46:11 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B191A20BEA
        for <linux-cxl@vger.kernel.org>; Mon,  7 Nov 2022 15:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667864770; x=1699400770;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+JiNF6qNCWiqq5Gl/6YJHcjYthV66OU4XJXxB9QDo30=;
  b=QB8imTGGoKDzo9Yq7xkh7Eaoo1Nv8S99jAPe+69bf2J766EuzIVXc4eS
   hnkuEhZibqnEPzl37g7QkV6/7j27YFWzaQRL0rUtIZ48i7TsVn8epZGZw
   PGyflbqxVZUmFkYrWWazQ/QKEm9YB7y3+2Ay59NZAwhX50t9wVD1z3Z/n
   550z86iIqTxDCWJ/9PKws1jOuczf6GP1ScddzPLqb6ApKW74J6xJrwlYD
   +6U5tFY4GLl281CZY4yrw/+RIT0rAd6FNrhqoEQWIGsFTF8vnkrLlcku8
   5P/WOfEOBZDmd69px0UMCyQBxS6pSpfRLHzUy6xYk338cgXTCiUM5HuNb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="374825042"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="374825042"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 15:46:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="630670087"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="630670087"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.213.168.235]) ([10.213.168.235])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 15:46:09 -0800
Message-ID: <634216b7-93af-11f0-534e-24341aef81c0@intel.com>
Date:   Mon, 7 Nov 2022 15:46:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH v2 17/19] cxl/pmem: add provider name to cxl pmem dimm
 attribute group
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        dan.j.williams@intel.com, bwidawsk@kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dave@stgolabs.net
References: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
 <166377438921.430546.5550361331475412529.stgit@djiang5-desk3.ch.intel.com>
 <20221107155824.000043c5@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221107155824.000043c5@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 11/7/2022 7:58 AM, Jonathan Cameron wrote:
> On Wed, 21 Sep 2022 08:33:09 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add provider name in order to associate cxl test dimm from cxl_test to the
>> cxl pmem device when going through sysfs for security testing.
> 
> sysfs ABI docs update?

Should be an entry for nvdimm bus. But seems like there isn't one. Will 
add one in Documentation/ABI/testing/sysfs-bus-nvdimm
> 
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/pmem.c |   10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
>> index 9f34f8701b57..cb303edb925d 100644
>> --- a/drivers/cxl/pmem.c
>> +++ b/drivers/cxl/pmem.c
>> @@ -48,6 +48,15 @@ static void unregister_nvdimm(void *nvdimm)
>>   	cxl_nvd->bridge = NULL;
>>   }
>>   
>> +static ssize_t provider_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +	struct nvdimm *nvdimm = to_nvdimm(dev);
>> +	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>> +
>> +	return sysfs_emit(buf, "%s\n", dev_name(&cxl_nvd->dev));
>> +}
>> +static DEVICE_ATTR_RO(provider);
>> +
>>   static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *buf)
>>   {
>>   	struct nvdimm *nvdimm = to_nvdimm(dev);
>> @@ -61,6 +70,7 @@ static DEVICE_ATTR_RO(id);
>>   
>>   static struct attribute *cxl_dimm_attributes[] = {
>>   	&dev_attr_id.attr,
>> +	&dev_attr_provider.attr,
>>   	NULL
>>   };
>>   
>>
>>
> 
