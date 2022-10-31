Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA41ECAAA1
	for <linux-cxl@archiver.kernel.org>; Mon, 31 Oct 2022 21:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJaVhF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 31 Oct 2022 17:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiJaVhF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 31 Oct 2022 17:37:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65928F1A
        for <linux-cxl@vger.kernel.org>; Mon, 31 Oct 2022 14:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667252224; x=1698788224;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4b1zq3CXGyRkdU5XjFmp2MefaI+ffszmmIHE+9JNhtE=;
  b=cWXh5lDs98R3sv12ZTEl8Xq0J6FROPaPuNy7x8Ryjd4YvX0gJGyM/cT8
   1wJwIGz7qKNlFQShcNVCIHR4mDkIODnvUNX9pjM/woyp1Wno7ML6m7LFw
   D9fIYYU0PKY145jDaXVicjXj+NvzJfoUrco7h8psJXdaWxIvB7GWjXyOr
   tHyvFfX5vaKoZ59T6jqHEKTGtj4+rZcCYfZ7XGy+sfUNB6Zg5s5Mvzazj
   w3SWt0OwqEqdnQTfDz3ISL8+srOHugbS4OAAtscA7vcsDuODXsciKVtxk
   hkQGfRrWjqeCJ/AR+cFEnytLyIsf5LnFeEGcOhMiS07ynDftPJ0nPmlBg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="306622345"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="306622345"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 14:37:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="808696873"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="808696873"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.209.188.164]) ([10.209.188.164])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 14:37:03 -0700
Message-ID: <653ef2ee-0de3-1536-bf88-c7ea9cc67a4d@intel.com>
Date:   Mon, 31 Oct 2022 14:37:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH 1/7] ndctl: cxl: add helper function to parse trace event
 to json object
Content-Language: en-US
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
References: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
 <166318847529.3087953.18405653106756321818.stgit@djiang5-desk3.ch.intel.com>
 <Y2Api2kdhBrRepeq@aschofie-mobl2>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Y2Api2kdhBrRepeq@aschofie-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 10/31/2022 1:01 PM, Alison Schofield wrote:
> On Wed, Sep 14, 2022 at 01:47:55PM -0700, Dave Jiang wrote:
>> Add the helper function that parses a trace event captured by
>> libtraceevent in a tep handle. All the parsed fields are added to a json
>> object. The json object is added to the provided list in the input parameter.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Hi Dave,
> 
> I've been using these parsing patches, and it all works for the purpose
> of parsing the cxl device poison list.
> 
> Tested-by: Alison Schofield <alison.schofield@intel.com>

Thanks!

> 
> One comment below...
> 
> -snip-
> 
>> ---
>> +
>> +	for (i = 0; fields[i]; i++) {
>> +		struct tep_format_field *f = fields[i];
>> +		int len;
>> +		char *tmp;
>> +
>> +		tmp = strcasestr(f->type, "char[]");
>> +		if (tmp) { /* event field is a string */
>> +			char *str;
>> +
>> +			str = tep_get_field_raw(NULL, event, f->name, record, &len, 0);
>> +			if (!str)
>> +				continue;
>> +
>> +			jobj = json_object_new_string(str);
>> +			if (!jobj) {
>> +				rc = -ENOMEM;
>> +				goto err;
>> +			}
>> +
>> +			json_object_object_add(jevent, f->name, jobj);
>> +		} else if (f->arraylen) { /* data array */
>> +			unsigned char *data;
>> +			int chunks;
>> +
>> +			data = tep_get_field_raw(NULL, event, f->name, record, &len, 0);
>> +			if (!data)
>> +				continue;
>> +
>> +			/* check to see if we have a UUID */
>> +			tmp = strcasestr(f->name, "uuid");
>> +			if (tmp && f->arraylen == 16) {
>> +				char uuid[SYSFS_ATTR_SIZE];
>> +
>> +				uuid_unparse(data, uuid);
>> +				jobj = json_object_new_string(uuid);
>> +				if (!jobj) {
>> +					rc = -ENOMEM;
>> +					goto err;
>> +				}
>> +
>> +				json_object_object_add(jevent, f->name, jobj);
>> +				continue;
>> +			}
> 
> Insted of comparing the field name, is it possible to check for
> f->type of 'uuid_t'?
> 

Yes. I talked to Ira and he'll change his uuid to uuid_t from u8[]. That 
should make it better. Thanks for pointing that out.

> 
>> +
>> +			jarray = json_object_new_array();
>> +			if (!jarray) {
>> +				rc = -ENOMEM;
>> +				goto err;
>> +			}
>> +
>> +			chunks = f->size / f->elementsize;
>> +			for (j = 0; j < chunks; j++) {
>> +				jobj = num_to_json(data, f->elementsize);
>> +				if (!jobj) {
>> +					json_object_put(jarray);
>> +					return -ENOMEM;
>> +				}
>> +				json_object_array_add(jarray, jobj);
>> +				data += f->elementsize;
>> +			}
>> +
>> +			json_object_object_add(jevent, f->name, jarray);
>> +		} else { /* single number */
>> +			char *data;
>> +
>> +			data = tep_get_field_raw(NULL, event, f->name, record, &len, 0);
>> +			if (!data)
>> +				continue;
>> +
>> +			jobj = num_to_json(data, f->elementsize);
>> +			if (!jobj) {
>> +				rc = -ENOMEM;
>> +				goto err;
>> +			}
>> +
>> +			json_object_object_add(jevent, f->name, jobj);
>> +		}
>> +	}
>> +
>> +	list_add_tail(jlist_head, &jnode->list);
>> +	return 0;
>> +
>> +err:
>> +	json_object_put(jevent);
>> +err_jevent:
>> +	free(jnode);
>> +	return rc;
>> +}
> 
> snip
> 
