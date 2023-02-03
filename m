Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D275C61DA4
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Feb 2023 00:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjBCA7c (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 19:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjBCA73 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 19:59:29 -0500
Received: from mailsrv.cs.umass.edu (mailsrv.cs.umass.edu [128.119.240.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A547B7B7
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 16:59:19 -0800 (PST)
Received: from [10.28.85.193] (unknown [150.203.68.66])
        by mailsrv.cs.umass.edu (Postfix) with ESMTPSA id 16B5A402B008;
        Thu,  2 Feb 2023 19:59:16 -0500 (EST)
Message-ID: <d59ee7a2-bb9b-81e4-a8b7-e266296a62a8@cs.umass.edu>
Date:   Fri, 3 Feb 2023 11:59:13 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Reply-To: moss@cs.umass.edu
Subject: Re: [PATCH] daxctl: Fix memblock enumeration off-by-one
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, vishal.l.verma@intel.com
Cc:     nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
References: <167537140762.3268840.2926966718345830138.stgit@dwillia2-xfh.jf.intel.com>
 <7bd7c84a-2c74-df1b-020d-a8f4a6725c18@cs.umass.edu>
 <63dc5116b95f1_ea2222941c@dwillia2-xfh.jf.intel.com.notmuch>
From:   Eliot Moss <moss@cs.umass.edu>
In-Reply-To: <63dc5116b95f1_ea2222941c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 2/3/2023 11:11 AM, Dan Williams wrote:
> Eliot Moss wrote:
>> On 2/3/2023 7:56 AM, Dan Williams wrote:
>>> A memblock is an inclusive memory range. Bound the search by the last
>>> address in the memory block.
>>>
>>> Found by wondering why an offline 32-block (at 128MB == 4GB) range was
>>> reported as 33 blocks with one online.
>>>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> ---
>>>    daxctl/lib/libdaxctl.c |    2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
>>> index 5703992f5b88..d990479d8585 100644
>>> --- a/daxctl/lib/libdaxctl.c
>>> +++ b/daxctl/lib/libdaxctl.c
>>> @@ -1477,7 +1477,7 @@ static int memblock_in_dev(struct daxctl_memory *mem, const char *memblock)
>>>    		err(ctx, "%s: Unable to determine resource\n", devname);
>>>    		return -EACCES;
>>>    	}
>>> -	dev_end = dev_start + daxctl_dev_get_size(dev);
>>> +	dev_end = dev_start + daxctl_dev_get_size(dev) - 1;
>>>    
>>>    	memblock_size = daxctl_memory_get_block_size(mem);
>>>    	if (!memblock_size) {
>>
>> Might this address the bug I reported?
> 
> This one?
> 
> http://lore.kernel.org/r/558d0ff1-4658-a11b-5a6d-0be0a3a6799c@cs.umass.edu
> 
> I don't think so, that one seems to have something to do with the file
> extent layout that causes fs/dax.c to fallback to 4K mappings.

That was the one - I think you're right; it's not immediately related.

EM
