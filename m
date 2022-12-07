Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECEBC47089
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Dec 2022 17:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiLGQ77 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Dec 2022 11:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiLGQ7m (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Dec 2022 11:59:42 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93C368C46
        for <linux-cxl@vger.kernel.org>; Wed,  7 Dec 2022 08:59:14 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C8C713E1F63;
        Wed,  7 Dec 2022 16:59:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 456F73E123D;
        Wed,  7 Dec 2022 16:59:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670432351; a=rsa-sha256;
        cv=none;
        b=FAvnV/HRC+oRKfc1uidkrCq2nxRgN2Arm/o8xUVUVPVqMHVS4VEcDSgF+Pmz/oJC0jlaWU
        Y350kv3KwHMZFK9hkM9+bN3Uefkk0ocQGCX4O2vQ+cy+WPCKrKTDzZyvgaRKfX1GLB7ucY
        N2wYLfmp0oXL0xV2ABuNYCqF+LeMT1mFPZ3x3O1oJg0t0PFtYxu9dGvyOGWFG3rIbA8EGp
        EQB4kuq8V/vXEHUIRRvIw6wU4TpKc6bSMvAC0ixV0CQRRsfID/O+QBXDuAaXKokaqHirl+
        6rWutul3qZVts2NWqIw7u8oghPbEbSm54BomFi6uOnEfPWXgT1iIbhQoh2exhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670432351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=L7nDKhjxSK1xQ3oz7bROoJ0Gvir5WZHYVpsLPvVSCXI=;
        b=JtrEi7EgBdm4HExEQvCo10SsMBUqQB/FhQQcMgEPj9ucODz8bFfEfwXuC5a7d/RB8r5mrx
        OiOm3UqI+9hoHIgBMpVCQVRlb+0Uwxu4B0BTOiTuFrN/rqAS3OiEBoRtifaYv3tbv6a/MN
        OkwQL7qYT2G34uGyI8U7iKl0JxpDSvVYldv6hrmD3KIbGi0bRompBqWUUs8qcJVIG8alEw
        XjRzQT5qESaw1N19uj4YSwsVQqQE261dm2FHwWLATHxVhG5fmO76Fan9lGHpNlES01vfNg
        NPnHfWOwRR6RBhl1S8GC0aMxUfgs1Lzue7yi+VFqP9GhMSi+Ugwj7vpjU5DYSw==
ARC-Authentication-Results: i=1;
        rspamd-85f95c7974-2z4m8;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Ruddy-Spot: 41c6a53354d94997_1670432351596_3882521184
X-MC-Loop-Signature: 1670432351596:3977257095
X-MC-Ingress-Time: 1670432351595
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.179.114 (trex/6.7.1);
        Wed, 07 Dec 2022 16:59:11 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4NS3R16PgFz7G;
        Wed,  7 Dec 2022 08:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1670432350;
        bh=L7nDKhjxSK1xQ3oz7bROoJ0Gvir5WZHYVpsLPvVSCXI=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=XUDXk874guH2MAKotLIeVfcsiBr6pbUMla+qLeGbR6YvUTOvx0f4F1yDATbnJAXQe
         zQPT/Yj6gh7n6wwcmIN0KHI4xZRNJvWQNE0pNBQ3OuVquN0jft+xw6xwk0KUr44rDl
         yt/0K65EHrrZCMUKSk6C8wTirMB32gmHjGhhtyISad78aCSth+qVeFh2/2kNENb8ZD
         LQeAbESfotl6/3CQCu+WI6gH9GhheR4QzJOdhAfXinKr+LLRyY9JXLlMjOVMVY4i1G
         yh3ZBUu84WJoyFmn7u+3CWYd1qXu30+/FNtICob0B8HTthM0rrwuDPpf8D5RSjCpqc
         cpFFk/bPgXGhg==
Date:   Wed, 7 Dec 2022 08:35:05 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     ira.weiny@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/3] cxl/mem: Support sanitation commands
Message-ID: <20221207163505.iteqrwryjxxjkyde@offworld>
References: <20221206011501.464916-1-dave@stgolabs.net>
 <20221206011501.464916-3-dave@stgolabs.net>
 <638ff86e7e44c_3cbe0294fd@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <638ff86e7e44c_3cbe0294fd@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 06 Dec 2022, Dan Williams wrote:

>> +static ssize_t security_store(struct device *dev,
>> +			      struct device_attribute *attr,
>> +			      const char *buf, size_t len)
>> +{
>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	char cmd[CXL_SEC_CMD_SIZE+1];
>> +	ssize_t rc;
>> +
>> +	rc = sscanf(buf, "%"__stringify(CXL_SEC_CMD_SIZE)"s", cmd);
>> +	if (rc < 1)
>> +		return -EINVAL;
>> +
>> +	if (sysfs_streq(cmd, "overwrite"))
>> +		rc = cxl_mem_sanitize(cxlds, CXL_MBOX_OP_SANITIZE);
>> +	else if (sysfs_streq(cmd, "erase"))
>> +		rc = cxl_mem_sanitize(cxlds, CXL_MBOX_OP_SECURE_ERASE);
>
>The above needs quite a bit more safety that the device is not currently
>actively decoding any HPA ranges.

I'll look into this, but overall I am relying on the fact that by hw, writes
won't have any effect and reads will return random data on all locations
corresponding to that device, sanitized yet or not.

>I realize now after sending the comments in patch1 that Sanitize defeats
>the dream of being able to timeslice background operations. On the other
>hand, it really is a special case that is only meant to be run before
>decommissioning the device. I think it is fine that it monopolizes the
>device because the device is literally unusable during the process.
>
>> +	else
>> +		rc = -EINVAL;
>> +
>> +	if (rc == 0)
>> +		rc = len;
>> +	return rc;
>> +}
>> +static DEVICE_ATTR_RW(security);
>> +
>>  static struct attribute *cxl_memdev_attributes[] = {
>>  	&dev_attr_serial.attr,
>>  	&dev_attr_firmware_version.attr,
>>  	&dev_attr_payload_max.attr,
>>  	&dev_attr_label_storage_size.attr,
>>  	&dev_attr_numa_node.attr,
>> +	&dev_attr_security.attr,
>
>This likely wants is_visible() handling to hide the attribute if the
>device does not support security operations.

Can is_visible() work on single attribute? I was only able to get it
for an attribute group. I had also considered ifdefing the thing based
on ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION but ended up not caring
if security file was shown as we have the remap scenario you pointed
out, so hiding security features became less appealing.

>
>>  	NULL,
>>  };
>>
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index e7cb2f2fadc4..1dd1caabd41c 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -215,6 +215,7 @@ struct cxl_endpoint_dvsec_info {
>>   * @mbox_irq: @dev supports mailbox interrupts
>>   * @mbox_bg: opcode for the in-flight background operation on @dev
>>   * @mbox_bgpoll: self-polling delayed work item
>> + * @sec: device security
>>   *
>>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
>>   * details on capacity parameters.
>> @@ -254,6 +255,10 @@ struct cxl_dev_state {
>>  	bool mbox_irq;
>>  	atomic_t mbox_bg;
>>  	struct delayed_work __maybe_unused mbox_bgpoll;
>> +
>> +	struct {
>> +		unsigned int __maybe_unused sanitize_tmo;
>> +	} sec;
>
>I missed this on the last patch, but __maybe_unused has no effect at
>declaration time, only at definition time. Otherwise, I wish I had a
>facility that would tell me which of my structure members are no longer
>used in code.

heh yeah, I mostly put them regardless as it nicely documents the
irq vs polling requirements. I'll remove.

Thanks,
Davidlohr
