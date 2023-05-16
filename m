Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F181EC77B7F
	for <linux-cxl@archiver.kernel.org>; Tue, 16 May 2023 21:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjEPVx5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 May 2023 17:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjEPVxz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 May 2023 17:53:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1D77D8A
        for <linux-cxl@vger.kernel.org>; Tue, 16 May 2023 14:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684274002; x=1715810002;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KXRcKzFE0P/NeSHahBtdI4W83ZklhMx3ga0WRnfRYM8=;
  b=BBr/bVU2xynJ9Rdkui4vh0DufAi1qyj+BtdS4jm5vXiaGHgcJFTGJoc0
   pv8KfJYanz4zl6MIoBF9NxXyeWRWaXVOKKOzSHV2vdHFejAoS//JwRPOE
   l6FnO4gMWqQt5b02rWSeyCZ2p9TgMra+lQNjiH2/6Zdz4pZ6YxS4ldTY1
   cTbJ8enwuL6aWpQV8xLN/5vJ4L82f4xJzNNYi7r0CuNVemciZg5A3rU/8
   QL2U1W0U6bwQY+QyiAToXiPwMR7dPwhDtKlYxk5o1UXIeR7xWn8Ymw2Wc
   BwNWr7+VFciIyqGhBTxBznnj+Hjw0gTtB/NIzg5Q0CGXU1HsinYmHyxwl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="354770832"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="354770832"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 14:52:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="791236558"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="791236558"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.5.122]) ([10.212.5.122])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 14:52:18 -0700
Message-ID: <a917cba3-2549-d89d-729a-3f849e134d4b@intel.com>
Date:   Tue, 16 May 2023 14:52:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v5 06/14] cxl: Store the access coordinates for the
 generic ports
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
 <168357884996.2756219.11067819935569345137.stgit@djiang5-mobl3>
 <20230512155957.00000c2f@Huawei.com>
 <4f398988-e5fa-cbc8-f73a-bfefaf89e252@intel.com>
 <6463f1e8d963d_250e2942a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6463f1e8d963d_250e2942a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 5/16/23 2:13 PM, Dan Williams wrote:
> Dave Jiang wrote:
>>
>>
>> On 5/12/23 7:59 AM, Jonathan Cameron wrote:
>>> On Mon, 08 May 2023 13:47:29 -0700
>>> Dave Jiang <dave.jiang@intel.com> wrote:
>>>
>>>> Each CXL host bridge is represented by an ACPI0016 device. A generic port
>>>> device handle that is an ACPI device is represented by a string of
>>>> ACPI0016 device HID and UID. Create a device handle from the ACPI device
>>>> and retrieve the access coordinates from the stored memory targets. The
>>>> access coordinates are stored under the cxl_dport that is associated with
>>>> the CXL host bridge.
>>>>
>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>> ---
>>>>    drivers/cxl/acpi.c |   28 ++++++++++++++++++++++++++++
>>>>    drivers/cxl/cxl.h  |    2 ++
>>>>    2 files changed, 30 insertions(+)
>>>>
>>>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>>>> index f9b35e8fe810..675a4f423f4b 100644
>>>> --- a/drivers/cxl/acpi.c
>>>> +++ b/drivers/cxl/acpi.c
>>>> @@ -537,8 +537,26 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
>>>>    	return 0;
>>>>    }
>>>>    
>>>> +static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
>>>> +{
>>>> +	struct acpi_device *hb = to_cxl_host_bridge(NULL, dev);
>>>> +	u8 handle[ACPI_SRAT_DEVICE_HANDLE_SIZE] = { 0 };
>>>> +	int rc;
>>>> +
>>>> +	/* ACPI spec 6.5 tABLE 5.65 */
>>>
>>> tABLE?
>>
>> ooops caps lock
>>
>>>
>>>> +	memcpy(handle, acpi_device_hid(hb), 8);
>>>> +	memcpy(&handle[8], acpi_device_uid(hb), 4);
>>>> +
>>>> +	rc = acpi_get_genport_coordinates(handle, dport->genport_coord);
>>>> +	if (rc)
>>>> +		return rc;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>    static int add_host_bridge_dport(struct device *match, void *arg)
>>>>    {
>>>> +	int ret;
>>>>    	acpi_status rc;
>>>>    	struct device *bridge;
>>>>    	unsigned long long uid;
>>>> @@ -594,6 +612,16 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>>>>    	if (IS_ERR(dport))
>>>>    		return PTR_ERR(dport);
>>>>    
>>>> +	dport->genport_coord = devm_kzalloc(dport->dport,
> 
> This needs to be the same device as was used to allocate @dport, and
> that's not @dport->dport.

ok

> 
>>>> +					    sizeof(*dport->genport_coord),
>>>> +					    GFP_KERNEL);
>>>
>>> It's pretty small - worth allocating separately?
>>>
>>> Maybe add something on why to the patch description if there is another reason
>>> for this dance.
>>
>> My intention was to allow detection of whether the data exists or not
>> based on if the ptr is NULL. I'll add explanation in patch description.
> 
> A couple reactions, is a "zero" access coordinate not sufficient for
> that?

Probably. I can change. I was being paranoid.

> 
> Also, "genport" is an ACPI-ism and I was aiming for cxl-core objects
> like cxl_dport to remain platform implementation independent. The
> concept of a dport having a host-bridge access_coordinate is generic
> though, so I would just rename this to "hb_access" or some other
> host-bridge generic naming.

Ok
