Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9246AC04A6A
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Aug 2023 20:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjHJUSt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Aug 2023 16:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjHJUSt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Aug 2023 16:18:49 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29F510F5
        for <linux-cxl@vger.kernel.org>; Thu, 10 Aug 2023 13:18:46 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DC6A38412E3;
        Thu, 10 Aug 2023 20:18:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 68D0E8416ED;
        Thu, 10 Aug 2023 20:18:42 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1691698722; a=rsa-sha256;
        cv=none;
        b=yTSxQUh7tPT+gmM5947SzwHXLX1LoE9QAjK6xGuQzNwuQF2lsIvCk0GxTjKzvfeMoI1lCu
        kd/A2f4GHcYxEyg8maoC6leGB0PrUjCJySGxYPJ63KnrrH+u8OrcSej1hyeD3GE9g8evZH
        Y2MIBrLaAedjRB1oCz0Gmkj18LuLRvU2XIm2s+/713KVTRUTN8soKRar5K/uMpCpvkQ6KB
        TQ+gEIuxT0v+Z9zBZQkkhWb2Otfzlp8n4x2XA6c9tK2mDk6tRmlh6+z8BDuTgC56muvahb
        9mEHmxkahN02sKONEinZFGpqDtG3Yr+Dl3XFJCAnuUexwIG4M4jSGLhXkKaZqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1691698722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=LJ5+wU82xzLNXI6l/q55OHO7aR5ABLgxHNChpIe1i/E=;
        b=JEC4pDEjmX/EhjR5/kTQgF55tlFPOz+nRJQaZA0wv/LdO3FJljfKDzyL8Q4JEhwN9J7Xow
        Qqcj+JQjxiDWOkAa08Ms7FAbXmP3jOUhmoYFv5B4VvVYTkDC4QhdcdIOY4s7xwjnORYd7J
        T+VKpc8R26wxR3vopvTeCI+Sk6DDIEJBy/gs0FZ1y8JvBw/xVMZkq9vy49UrL8+20mlclM
        76eW5Vvznf0XxJBuAJVQT62gdExyXEi00TNfp3f6DkITccU3dQIJn9auMrjZvf3V6brHIj
        8GRNv4s5vqkR4JD2pkXU9y73FRROFMrXzytTMLXqOYozTQOPor99ACfrEf8q4w==
ARC-Authentication-Results: i=1;
        rspamd-849d547c58-xqd2h;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Gusty-Battle: 15d432726898dd32_1691698722686_2838668292
X-MC-Loop-Signature: 1691698722686:266859627
X-MC-Ingress-Time: 1691698722686
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.124.60.171 (trex/6.9.1);
        Thu, 10 Aug 2023 20:18:42 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4RMJCj6Vx6zFZ;
        Thu, 10 Aug 2023 13:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1691698722;
        bh=LJ5+wU82xzLNXI6l/q55OHO7aR5ABLgxHNChpIe1i/E=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=j3RENuiwwH1bDM5Z+JEH2V6biXc5Ut7lX/aMvXZCoVGGR/88GyIjgpqky7JTlQk0q
         FWzyFpvZFfgR8cUL9Bcllqunxue1JlOz/AJvyyqujvrtLsqVN58PF7offW+NB24MlB
         3N+00MFN4mCdLlTcsUSF2WZs0AFq3oT2UaxlLKQ6LJB/Rux3Zri7BzxlWHHJ/uClDu
         o6aqthAT+hkzXsNVrZrdJcLl7YvwMq5VdvxkxygNH0sb+q2xf5AeA1APtOapzbfcKx
         Qao/p/db4M9+rXAGaL9Z6hCAM+oiSRbzGJqyrIR87SwCP+dpd3jRvuvCepgNmNL+ll
         PYmr9IZz0dVeQ==
Date:   Thu, 10 Aug 2023 12:40:28 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     dan.j.williams@intel.com, dave.jiang@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/memdev: Decouple security init from
 devm_cxl_add_memdev()
Message-ID: <w6qikszveyi5ns7oqsjld6nhqtiid56mkyof3tghubz2jxxuh4@fbqkkp3znxn4>
References: <20230809163733.32008-1-dave@stgolabs.net>
 <64d5392b3364_1aed4629443@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <64d5392b3364_1aed4629443@iweiny-mobl.notmuch>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 10 Aug 2023, Ira Weiny wrote:

>Davidlohr Bueso wrote:
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 14b547c07f54..628d9d1fb795 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -561,7 +561,7 @@ static void cxl_memdev_security_shutdown(struct device *dev)
>>	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>
>> -	if (mds->security.poll)
>> +	if (mds && mds->security.poll)
>>		cancel_delayed_work_sync(&mds->security.poll_dwork);
>>  }
>>
>> @@ -570,7 +570,6 @@ static void cxl_memdev_shutdown(struct device *dev)
>>	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>
>>	down_write(&cxl_memdev_rwsem);
>> -	cxl_memdev_security_shutdown(dev);
>>	cxlmd->cxlds = NULL;
>>	up_write(&cxl_memdev_rwsem);
>>  }
>> @@ -580,6 +579,7 @@ static void cxl_memdev_unregister(void *_cxlmd)
>>	struct cxl_memdev *cxlmd = _cxlmd;
>>	struct device *dev = &cxlmd->dev;
>>
>> +	cxl_memdev_security_shutdown(dev);
>
>NIT: Moving the call to cxl_memdev_security_shutdown() kind of threw me.
>I see why you did it.  But is there is a way to make this call mirror
>better with pci probe?

Right, this is the disklike I had with this patch, and have not come
up with a cleaner way to do this except just doing without the call
altogether and move the sanitize corner case directly into
cxl_memdev_unregister():

static void cxl_memdev_unregister(void *_cxlmd)
{
	struct cxl_memdev *cxlmd = _cxlmd;
	struct device *dev = &cxlmd->dev;
	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);

	if (mds && mds->security.poll)
		cancel_delayed_work_sync(&mds->security.poll_dwork);

	cxl_memdev_shutdown(dev);
	cdev_device_del(&cxlmd->cdev, dev);
	put_device(dev);
}

Then we don't really need to mirror the init, specially considering that
ad-hoc sanitize checks are all over the place due to its nature. Would
this be preferable?

>
>>	cxl_memdev_shutdown(dev);
>>	cdev_device_del(&cxlmd->cdev, dev);
>>	put_device(dev);
>> @@ -1009,11 +1009,10 @@ static void put_sanitize(void *data)
>>	sysfs_put(mds->security.sanitize_node);
>>  }
>>
>> -static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
>> +int cxl_memdev_security_state_init(struct cxl_memdev_state *mds)
>
>This needs to be exported.  I get the following error when trying this:
>
>  MODPOST Module.symvers
>ERROR: modpost: "cxl_memdev_security_state_init" [drivers/cxl/cxl_pci.ko] undefined!
>make[2]: *** [scripts/Makefile.modpost:144: Module.symvers] Error 1
>make[1]: *** [/home/iweiny/dev/linux-dcd-work/Makefile:1984: modpost] Error 2
>make: *** [Makefile:234: __sub-make] Error 2

brrr I had only run a 'make drivers/cxl/' on it. Will fixup in a v2 as well
as the typo found by Dave and the above if there is agreement.

>
>12:12:19 > git di
>diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>index 18ecb9c90412..492486707fd0 100644
>--- a/drivers/cxl/core/memdev.c
>+++ b/drivers/cxl/core/memdev.c
>@@ -1025,6 +1025,7 @@ int cxl_memdev_security_state_init(struct cxl_memdev_state *mds)
>
>        return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
> }
>+EXPORT_SYMBOL_NS_GPL(cxl_memdev_security_state_init, CXL);
>
> struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> {
>
>>  {
>> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>> -	struct device *dev = &cxlmd->dev;
>> +	struct cxl_dev_state *cxlds = &mds->cxlds;
>> +	struct device *dev = &cxlds->cxlmd->dev;
>>	struct kernfs_node *sec;
>>
>>	sec = sysfs_get_dirent(dev->kobj.sd, "security");
>> @@ -1029,7 +1028,7 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
>>	}
>>
>>	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
>> - }
>> +}
>
>NIT: this is an unrelated change.

imho such a small change makes more sense here than a separate patch only for that.

>
>With the export fixed:
>
>Tested-by: Ira Weiny <ira.weiny@intel.com>

Thanks,
Davidlohr
