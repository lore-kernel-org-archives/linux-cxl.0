Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D271C433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Nov 2022 22:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbiKNWtu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Nov 2022 17:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiKNWtt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Nov 2022 17:49:49 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB112120BF
        for <linux-cxl@vger.kernel.org>; Mon, 14 Nov 2022 14:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668466187; x=1700002187;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2I0K2TFL2TVl5aAsh7J0up3NE2o569V/jkbGL4BERJY=;
  b=FO9/dyHyBsULDcf3zEA6tauwp6kuabDo5SyCEAx+D1yeDEjXof1xc9vk
   nmcRa29E4AMt8rscHbjlj9hOqOdWVqNpBFeRXIYVdKXqHvf87j3OlKBXN
   e9hDA/Brw3WGSt7vwM8rgaVjwwUWiHmJGXj64lCdpoZnQqS1sXGnWs8JA
   P95m7l0krm+NqlC4RyRWnH5biUs8k+oD0BGoNwGhy+zLopcVeRBoVyIkq
   jluWU157A1aP2hMEnE7uQ6VJeEvk2q75waItYyMh8tS1iG0I9trPwylnn
   9cMskBRVlTwaMuT+zFLBFi2d3HLqgSsc7OeueitqWAv5LABjytg/J+Wq/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="398392472"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="398392472"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 14:49:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="883719826"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="883719826"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.53.251]) ([10.212.53.251])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 14:49:34 -0800
Message-ID: <6c24d5c5-8ed2-2f88-5578-665b6eca1130@intel.com>
Date:   Mon, 14 Nov 2022 15:49:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH v4 13/18] nvdimm/cxl/pmem: Add support for master
 passphrase disable security command
Content-Language: en-US
To:     Ben Cheatham <benjamin.cheatham@amd.com>,
        linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net
References: <166845791969.2496228.8357488385523295841.stgit@djiang5-desk3.ch.intel.com>
 <166845805988.2496228.8804764265372893076.stgit@djiang5-desk3.ch.intel.com>
 <1cc14f3f-6500-778a-087c-e7601f82adf3@amd.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <1cc14f3f-6500-778a-087c-e7601f82adf3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 11/14/2022 2:27 PM, Ben Cheatham wrote:
> On 11/14/22 2:34 PM, Dave Jiang wrote:
>> The original nvdimm_security_ops ->disable() only supports user 
>> passphrase
>> for security disable. The CXL spec introduced the disabling of master
>> passphrase. Add a ->disable_master() callback to support this new 
>> operation
>> and leaving the old ->disable() mechanism alone. A "disable_master" 
>> command
>> is added for the sysfs attribute in order to allow command to be issued
>> from userspace. ndctl will need enabling in order to utilize this new
>> operation.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/security.c    |   20 ++++++++++++++++++--
>>   drivers/nvdimm/security.c |   33 ++++++++++++++++++++++++++-------
>>   include/linux/libnvdimm.h |    2 ++
>>   3 files changed, 46 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
>> index 631a474939d6..f4df7d38e4cd 100644
>> --- a/drivers/cxl/security.c
>> +++ b/drivers/cxl/security.c
>> @@ -71,8 +71,9 @@ static int cxl_pmem_security_change_key(struct 
>> nvdimm *nvdimm,
>>       return rc;
>>   }
>> -static int cxl_pmem_security_disable(struct nvdimm *nvdimm,
>> -                     const struct nvdimm_key_data *key_data)
>> +static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
>> +                       const struct nvdimm_key_data *key_data,
>> +                       enum nvdimm_passphrase_type ptype)
>>   {
>>       struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>>       struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
>> @@ -88,6 +89,8 @@ static int cxl_pmem_security_disable(struct nvdimm 
>> *nvdimm,
>>        * will only support disable of user passphrase. The disable 
>> master passphrase
>>        * ability will need to be added as a new callback.
>>        */
>> +    dis_pass.type = ptype == NVDIMM_MASTER ?
>> +        CXL_PMEM_SEC_PASS_MASTER : CXL_PMEM_SEC_PASS_USER;
>>       dis_pass.type = CXL_PMEM_SEC_PASS_USER;
> 
> Hey Dave,
> 
> I noticed that you are overwriting dis_pass.type with 
> CXL_PMEM_SEC_PASS_USER after your added change here. I imagine that's 
> not intentional considering the rest of the work in this patch!

Hi Ben. Great catch! That was suppose to be replaced with the changed code.

-       dis_pass.type = CXL_PMEM_SEC_PASS_USER;
+       dis_pass.type = ptype == NVDIMM_MASTER ?
+               CXL_PMEM_SEC_PASS_MASTER : CXL_PMEM_SEC_PASS_USER;

Thanks for the find.

> 
> Ben
>>       memcpy(dis_pass.pass, key_data->data, NVDIMM_PASSPHRASE_LEN);
>> @@ -96,6 +99,18 @@ static int cxl_pmem_security_disable(struct nvdimm 
>> *nvdimm,
>>       return rc;
>>   }
>> +static int cxl_pmem_security_disable(struct nvdimm *nvdimm,
>> +                     const struct nvdimm_key_data *key_data)
>> +{
>> +    return __cxl_pmem_security_disable(nvdimm, key_data, NVDIMM_USER);
>> +}
>> +
>> +static int cxl_pmem_security_disable_master(struct nvdimm *nvdimm,
>> +                        const struct nvdimm_key_data *key_data)
>> +{
>> +    return __cxl_pmem_security_disable(nvdimm, key_data, NVDIMM_MASTER);
>> +}
>> +
>>   static int cxl_pmem_security_freeze(struct nvdimm *nvdimm)
>>   {
>>       struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>> @@ -163,6 +178,7 @@ static const struct nvdimm_security_ops 
>> __cxl_security_ops = {
>>       .freeze = cxl_pmem_security_freeze,
>>       .unlock = cxl_pmem_security_unlock,
>>       .erase = cxl_pmem_security_passphrase_erase,
>> +    .disable_master = cxl_pmem_security_disable_master,
>>   };
>>   const struct nvdimm_security_ops *cxl_security_ops = 
>> &__cxl_security_ops;
>> diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
>> index 8aefb60c42ff..92af4c3ca0d3 100644
>> --- a/drivers/nvdimm/security.c
>> +++ b/drivers/nvdimm/security.c
>> @@ -239,7 +239,8 @@ static int check_security_state(struct nvdimm 
>> *nvdimm)
>>       return 0;
>>   }
>> -static int security_disable(struct nvdimm *nvdimm, unsigned int keyid)
>> +static int security_disable(struct nvdimm *nvdimm, unsigned int keyid,
>> +                enum nvdimm_passphrase_type pass_type)
>>   {
>>       struct device *dev = &nvdimm->dev;
>>       struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
>> @@ -250,8 +251,13 @@ static int security_disable(struct nvdimm 
>> *nvdimm, unsigned int keyid)
>>       /* The bus lock should be held at the top level of the call 
>> stack */
>>       lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
>> -    if (!nvdimm->sec.ops || !nvdimm->sec.ops->disable
>> -            || !nvdimm->sec.flags)
>> +    if (!nvdimm->sec.ops || !nvdimm->sec.flags)
>> +        return -EOPNOTSUPP;
>> +
>> +    if (pass_type == NVDIMM_USER && !nvdimm->sec.ops->disable)
>> +        return -EOPNOTSUPP;
>> +
>> +    if (pass_type == NVDIMM_MASTER && !nvdimm->sec.ops->disable_master)
>>           return -EOPNOTSUPP;
>>       rc = check_security_state(nvdimm);
>> @@ -263,12 +269,21 @@ static int security_disable(struct nvdimm 
>> *nvdimm, unsigned int keyid)
>>       if (!data)
>>           return -ENOKEY;
>> -    rc = nvdimm->sec.ops->disable(nvdimm, data);
>> -    dev_dbg(dev, "key: %d disable: %s\n", key_serial(key),
>> +    if (pass_type == NVDIMM_MASTER) {
>> +        rc = nvdimm->sec.ops->disable_master(nvdimm, data);
>> +        dev_dbg(dev, "key: %d disable_master: %s\n", key_serial(key),
>>               rc == 0 ? "success" : "fail");
>> +    } else {
>> +        rc = nvdimm->sec.ops->disable(nvdimm, data);
>> +        dev_dbg(dev, "key: %d disable: %s\n", key_serial(key),
>> +            rc == 0 ? "success" : "fail");
>> +    }
>>       nvdimm_put_key(key);
>> -    nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
>> +    if (pass_type == NVDIMM_MASTER)
>> +        nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, 
>> NVDIMM_MASTER);
>> +    else
>> +        nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
>>       return rc;
>>   }
>> @@ -473,6 +488,7 @@ void nvdimm_security_overwrite_query(struct 
>> work_struct *work)
>>   #define OPS                            \
>>       C( OP_FREEZE,        "freeze",        1),    \
>>       C( OP_DISABLE,        "disable",        2),    \
>> +    C( OP_DISABLE_MASTER,    "disable_master",    2),    \
>>       C( OP_UPDATE,        "update",        3),    \
>>       C( OP_ERASE,        "erase",        2),    \
>>       C( OP_OVERWRITE,    "overwrite",        2),    \
>> @@ -524,7 +540,10 @@ ssize_t nvdimm_security_store(struct device *dev, 
>> const char *buf, size_t len)
>>           rc = nvdimm_security_freeze(nvdimm);
>>       } else if (i == OP_DISABLE) {
>>           dev_dbg(dev, "disable %u\n", key);
>> -        rc = security_disable(nvdimm, key);
>> +        rc = security_disable(nvdimm, key, NVDIMM_USER);
>> +    } else if (i == OP_DISABLE_MASTER) {
>> +        dev_dbg(dev, "disable_master %u\n", key);
>> +        rc = security_disable(nvdimm, key, NVDIMM_MASTER);
>>       } else if (i == OP_UPDATE || i == OP_MASTER_UPDATE) {
>>           dev_dbg(dev, "%s %u %u\n", ops[i].name, key, newkey);
>>           rc = security_update(nvdimm, key, newkey, i == OP_UPDATE
>> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
>> index c74acfa1a3fe..3bf658a74ccb 100644
>> --- a/include/linux/libnvdimm.h
>> +++ b/include/linux/libnvdimm.h
>> @@ -183,6 +183,8 @@ struct nvdimm_security_ops {
>>       int (*overwrite)(struct nvdimm *nvdimm,
>>               const struct nvdimm_key_data *key_data);
>>       int (*query_overwrite)(struct nvdimm *nvdimm);
>> +    int (*disable_master)(struct nvdimm *nvdimm,
>> +                  const struct nvdimm_key_data *key_data);
>>   };
>>   enum nvdimm_fwa_state {
>>
>>
