Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B673C636CC
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Feb 2023 22:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjBGWsk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Feb 2023 17:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjBGWsi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Feb 2023 17:48:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A788F1F4AE
        for <linux-cxl@vger.kernel.org>; Tue,  7 Feb 2023 14:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675810117; x=1707346117;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Pws/iBg8wY27xetTmYnkUqFogmMcRhjYgh/PTqN+CAA=;
  b=OQdTMIZQVVzkWhgDjGi3dw44LaPkLJcxh50UBnOslafSrIGoVHEEp6pV
   9DCd0ZdaVHP05XvJPbno3LuENqfqYAPt6p8EQ183UaJAMaH2PYCiSf4y9
   twTFu3OKd29/8k3KouafFWJcGO5F1j2i0S6jm3tEYWzUEbNV9vXoRAsfL
   vkOEOxop7GuBohbCb7bP68ilpueiOK/I5kHarGwyacqcfiKxG+tA+w5oq
   A6J//yfE1DbJSj5/a5pP/dA9QLDqHKfN8XECeE9I41s6uIs7udmo6OX1a
   yN6nzXyf+5SuVGwsCL22BgJ9RspyR6PaY9UGJuQjlcvgU2B5zVNecMPGm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="328299355"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="328299355"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 14:48:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="644623995"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="644623995"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.98.37]) ([10.212.98.37])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 14:48:34 -0800
Message-ID: <d98eeedb-39b9-413b-9dfc-d5d059614b51@intel.com>
Date:   Tue, 7 Feb 2023 15:48:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v3 4/8] cxl: emulate HDM decoder from DVSEC range
 registers
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, jonathan.cameron@huawei.com
References: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
 <167406533420.1455071.7180353856174143346.stgit@djiang5-mobl3.local>
 <63e2d310d5063_e3dae2943d@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <63e2d310d5063_e3dae2943d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/7/23 3:39 PM, Dan Williams wrote:
> Dave Jiang wrote:
>> In the case where HDM decoder register block exists but is not programmed
>> and at the same time the DVSEC range register range is active, populate the
>> CXL decoder object 'cxl_decoder' with info from DVSEC range registers.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> ---
>> v2:
>> - Set target_type to CXL_DECODER_EXPANDER (type 3). (Jonathan)
>> - Skip HDM enabling if DVSEC range is active. (Jonathan)
>> ---
>>   drivers/cxl/core/hdm.c |   36 +++++++++++++++++++++++++++++++++---
>>   drivers/cxl/core/pci.c |    2 +-
>>   drivers/cxl/cxl.h      |    3 ++-
>>   drivers/cxl/port.c     |    2 +-
>>   4 files changed, 37 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index dcc16d7cb8f3..af1f5f906f52 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -679,9 +679,34 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
>>   	return 0;
>>   }
>>   
>> +static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
>> +					    struct cxl_decoder *cxld, int which,
>> +					    struct cxl_endpoint_dvsec_info *info)
>> +{
>> +	if (!is_cxl_endpoint(port))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (info->dvsec_range[which].start == CXL_RESOURCE_NONE)
>> +		return -ENXIO;
>> +
>> +	cxld->target_type = CXL_DECODER_EXPANDER;
>> +	cxld->commit = NULL;
>> +	cxld->reset = NULL;
>> +
>> +	cxld->hpa_range = (struct range) {
>> +		.start = info->dvsec_range[which].start,
>> +		.end = info->dvsec_range[which].end,
>> +	};
> 
> They're both 'struct range' values so this can just be an implict
> memcpy:
> 
> 	cxld->hpa_range = info->dvsec_range[which];
> 

ok

>> +	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
>> +	port->commit_end = cxld->id;
> 
> I think F_LOCK should ultimately come from whether the associated CFMWS is locked,
> but for now perhaps a comment like:
> 
> /*
>   * Set the emulated decoder as locked pending additional support to
>   * change the range registers at run time.
>   */
> 
ok

> ...basically just to indicate that there is no requirement that they be
> locked, but that the unlock case needs quite a bit more work and
> testing.
> 
>> +
>> +	return 0;
>> +}
>> +
>>   static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>>   			    int *target_map, void __iomem *hdm, int which,
>> -			    u64 *dpa_base)
>> +			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
>>   {
>>   	struct cxl_endpoint_decoder *cxled = NULL;
>>   	u64 size, base, skip, dpa_size;
>> @@ -717,6 +742,10 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>>   		.end = base + size - 1,
>>   	};
>>   
>> +	if (cxled && !committed &&
>> +	    info->dvsec_range[which].start != CXL_RESOURCE_NONE)
> 
> Ah, here is where that CXL_RESOURCE_NONE is used, can this condition
> just be:
> 
>      range_len(&info->dvsec_range[which])
> 
> ...i.e. non-zero size?

In order to do this, I think we need to do
.start = 0,
.end = CXL_RESOURCE_NONE,

So range_len() == 0 in the end.

> 
>> +		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
>> +
>>   	/* decoders are enabled if committed */
>>   	if (committed) {
>>   		cxld->flags |= CXL_DECODER_F_ENABLE;
>> @@ -790,7 +819,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>>    * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
>>    * @cxlhdm: Structure to populate with HDM capabilities
>>    */
>> -int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>> +int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>> +				struct cxl_endpoint_dvsec_info *info)
>>   {
>>   	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>>   	struct cxl_port *port = cxlhdm->port;
>> @@ -842,7 +872,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>>   			cxld = &cxlsd->cxld;
>>   		}
>>   
>> -		rc = init_hdm_decoder(port, cxld, target_map, hdm, i, &dpa_base);
>> +		rc = init_hdm_decoder(port, cxld, target_map, hdm, i, &dpa_base, info);
> 
> Looks like a long line for clang-format to trim.

ok

> 
>>   		if (rc) {
>>   			put_device(&cxld->dev);
>>   			return rc;
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 97690c429e05..81882ea94adf 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -427,7 +427,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>>   	 * Decoder Capability Enable.
>>   	 */
>>   	if (info->mem_enabled)
>> -		return -EBUSY;
>> +		return 0;
>>   
>>   	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
>>   	if (rc)
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 1057affb2db0..ea9548cbc7eb 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -644,7 +644,8 @@ struct cxl_endpoint_dvsec_info {
>>   
>>   struct cxl_hdm;
>>   struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port);
>> -int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm);
>> +int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>> +				struct cxl_endpoint_dvsec_info *info);
>>   int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
>>   int cxl_dvsec_rr_decode(struct pci_dev *pdev, int dvsec,
>>   			struct cxl_endpoint_dvsec_info *info);
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index 404639a1c3d0..7f1b71c5cf15 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -79,7 +79,7 @@ static int cxl_port_probe(struct device *dev)
>>   		}
>>   	}
>>   
>> -	rc = devm_cxl_enumerate_decoders(cxlhdm);
>> +	rc = devm_cxl_enumerate_decoders(cxlhdm, &info);
>>   	if (rc) {
>>   		dev_err(dev, "Couldn't enumerate decoders (%d)\n", rc);
>>   		return rc;
>>
>>
> 
> 
